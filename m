Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A73B8BB7;
	Thu, 15 Jan 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490454; cv=none; b=Eib33wYwbMeUiFQMvaYgisk5ZfYuk3MD3SktGpkGfJJPbpB13HBJbcAfsx/SdKFypJ+92lEnLlzVyuc08Fl0Wt+Pk+VtGW8fp2wDMs9UNzg8GpC9eRT3DibuzRDBI7MUNItPQ0x7OJPv48Hx+SphxfIsrwV3kDktq5piRikKRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490454; c=relaxed/simple;
	bh=Ta8voQ7PwaIwWi/tca9PDpVSIdwL9VUNWSGlUVLCyN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NACNy2n0oIs9NsvIFdSZ5QNUWA9r1ge4vurzwALPK5urdf4TthoWUcu2jvRwIK0w+vjahv9QwyPV5AZXvHRO/z7z0RO3gddRXMS9HNhVjLHap3A7tEhMZnesNiCSDELBQSbdGhfCgBtZddYX23nO3ivkZta95+V2yVUNwNjNwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auUbi4LZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auUbi4LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DBCC16AAE;
	Thu, 15 Jan 2026 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490453;
	bh=Ta8voQ7PwaIwWi/tca9PDpVSIdwL9VUNWSGlUVLCyN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auUbi4LZbcZY3XoZTmiuEBz9GFhg0i5IAadPhW3u5NPpvll+nU3nybYQhPjICRqrz
	 vIEAcLAnh+2xP+WIYwOc9F9r9eWVTY0Q6hZiR7MCIk9KyFf0AAX5/BmP4OihheV/Ge
	 JOWuHkr0tr8+AFb0hZYuKrBdyRiaSeR8HCrC9QJZQDDu7kK97Xe2cFgDe/bLc9AllJ
	 eqsZvxCYVxF8yaeHoF9eWXr6JotDIzOVgpoZSJOZq1gQdX5SmSVgWBFgHAGYDTbGoB
	 ksMlUXisqACVLlpzTEjbBMoZtFZIiTus8BEpVaCuBCeX1Qq6zyMkAkt+aJTovh2tXj
	 vVywYGXmuu72w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] mm/damon/reclaim: use damon_kdamond_pid()
Date: Thu, 15 Jan 2026 07:20:44 -0800
Message-ID: <20260115152047.68415-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115152047.68415-1-sj@kernel.org>
References: <20260115152047.68415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM directly uses damon_ctx->kdamond field with manual
synchronization using damon_ctx->kdamond_lock, to get the pid of the
kdamond.  Use a new dedicated function for the purpose, namely
damon_kdamond_pid(), since that doesn't require manual and error-prone
synchronization.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 8463a5a5032f..55df43e241c5 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -307,7 +307,9 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = ctx->kdamond->pid;
+	kdamond_pid = damon_kdamond_pid(ctx);
+	if (kdamond_pid < 0)
+		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
