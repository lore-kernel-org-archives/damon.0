Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCC29B8DB;
	Sat, 17 Jan 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672385; cv=none; b=BvWw1xLcGXYuJzBOUu5s3nqVKd/CUlMQtsQILVhPxAdmiEZEZrqn7D3zb40XphslItt1kggVA+0cPyegxLdS2eumJ0gCAx0gA7Ts2wP32E/FnZa52rlokuTS1yzPXxWLrMDQYUInUsAEfoKFp4bZPv51cZbwUfAooUEZnZ5A8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672385; c=relaxed/simple;
	bh=VahmTvFk2dGc/ONa7UpYlxUiKSb/QYQK+lIo3yfJ+G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGGmr/Kop8Odsq0Mc86pbfcR6XicgO3eW0e9So1RidNsjqalH1h9Mgta7b/mnVDFNePcDL0qJ1C+x1RwTqLjYlIVb0WXxj59hZrB2A8KSfL+RoqJ6V8scnOEWByw7BRh6GhGnL3nmJ6QbzpBB+0ltaOMmhYObvlzjeyAFf1Dj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifXrQOLf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifXrQOLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30628C4CEF7;
	Sat, 17 Jan 2026 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672385;
	bh=VahmTvFk2dGc/ONa7UpYlxUiKSb/QYQK+lIo3yfJ+G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifXrQOLf5teMOEqaYYzrF0RAErBT5uPf5a3CvMwFrMrPZwREODTvdkpagpJoa4cc/
	 qh9vBxRvkgpvUVdl5eEf3RYIWXcNFgsSL3gtHw7AFl+aECUOQ9NEtQOlOcjhiMInoq
	 btOY2x+wHjYy9p1wNRSDsdpRgHDW2mFhIlOltZixLt9ArWBuxqiCRiyVXof4fiOFyg
	 KQA+maCXs2EDprxLbSkr+pI7tQl0X8sAsFeLpM0jv51WbPEE8CeIoeRkK2ta6xw5LV
	 aYTx0paCEOobXX3ahMcUBTMFtdX5Omhs6fZA/mESVDGYXSyQd/MlnjSabFvv2SA9cq
	 TcLcM4DzeWlGA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/core: cancel damos_walk() before damon_ctx->kdamond reset
Date: Sat, 17 Jan 2026 09:52:50 -0800
Message-ID: <20260117175256.82826-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117175256.82826-1-sj@kernel.org>
References: <20260117175256.82826-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk() request is canceled after damon_ctx->kdamond is reset.
This can make weird situations where damon_is_running() returns false
but the DAMON context has the damos_walk() request linked.  There was a
similar situation for damon_call() requests handling [1], which _was_
able to cause a racy use-after-free bug.  Unlike the case of
damon_call(), because damos_walk() is always synchronously handled and
allows only single request at time, there is no such problematic race
cases.  But, keeping it as is could stem another subtle race condition
bug in future.

Avoid that by cancelling the requests before the ->kdamond reset.  Note
that this change also makes all damon_ctx dependent resource cleanups
consistently done before the damon_ctx->kdamond reset.

[1] https://lore.kernel.org/20251230014532.47563-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0c8ac11a49f9..0bed937b1dce 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2856,14 +2856,13 @@ static int kdamond_fn(void *data)
 
 	kfree(ctx->regions_score_histogram);
 	kdamond_call(ctx, true);
+	damos_walk_cancel(ctx);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
 
-	damos_walk_cancel(ctx);
-
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
 	if (!nr_running_ctxs && running_exclusive_ctxs)
-- 
2.47.3
