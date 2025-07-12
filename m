Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6A29AAF5;
	Sat, 12 Jul 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349834; cv=none; b=l8/UBCBybkInXMSO7B8btHhufXAgK97FJ3m7Vp3+7Fas2THphBSvZbgJjnS/FLTVsPGbZ2rKCdZuivYNx78LKIYDLnZJOtwH24g1qCN8bBNWVPY0OHYuBbVs9RU54iemDaUc6burmeTI5RnZfBp+7dn5TttqdQ8ebwmmqNjr5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349834; c=relaxed/simple;
	bh=oQhsnF1/u67JFZnBKsT/L2sSUWnwWM0joMv6k3f9o4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6pC3gMXjKdmJUB27B3vamLR7FNeR2giIbaOBAoIYMWgdMQy6BXZm3+jSZGRJ96pNLQUUo25YaNcgZzzcLMjkPcHLE0Goti6eokd2y5yf3OJCsaUSk0kTBO8JIaaaJAhy7ZnrBYmUpTZtd+ekJdvMj/cOs/BY4BAwnTrnlXa39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXZ9YU2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXZ9YU2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFD0C4CEEF;
	Sat, 12 Jul 2025 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349834;
	bh=oQhsnF1/u67JFZnBKsT/L2sSUWnwWM0joMv6k3f9o4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXZ9YU2DWWzvtng2+sg7GFjLnmbS3mxfQjEl4vscmm05pc3l7IP27dr9sMFGayXBd
	 TUqTgeHrJdji1bQn9Q2WuwgFVWYzn5opGRJ872u9Id35NgjjUV+gONygjKnKYQV9Tu
	 GQDq+bbWbTP95qVDYCnqSE09LSbNtzGFPjLXBfSDyCnCS6U3D3YGdH8sM5mRnXIppU
	 ipzUtLCJJi/f+mdobrr5PQOpXwfi31SpM0tNgmhJw2ww8CZnUVdqszQ7sb1hOC/TA1
	 8BR8rNh8JK+K+SnKNebCrfBSFOwTmW06Wpom401omBXN/ciP/FbuAg0LHNtXuPxKyj
	 kehZm5p4/8LEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/14] mm/damon/core: destroy targets when kdamond_fn() finish
Date: Sat, 12 Jul 2025 12:50:14 -0700
Message-Id: <20250712195016.151108-13-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195016.151108-1-sj@kernel.org>
References: <20250712195016.151108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kdamond_fn() completes, the targets are kept.  Those are kept to
let callers do additional cleanups if they need.  There are no such
additional cleanups though.  DAMON sysfs interface deallocates those in
before_terminate() callback, to reduce unnecessary memory usage, for
[f]vaddr use case.  Just destroy the targets for every case in the core
layer.  This saves more memory and simplifies the logic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9554743dc992..ffd1a061c2cb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2657,6 +2657,7 @@ static int kdamond_fn(void *data)
 		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
+	damon_destroy_targets(ctx);
 	return 0;
 }
 
-- 
2.39.5
