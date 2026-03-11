Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A8333447;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206971; cv=none; b=p2TD+NbDwmz20hE4ta91DXjczWtaZ5fE34RmiQgY7dI6Ty4DZuhvi2gNnBVxKXdS9bB8gk8eFKWFg+bhsolEXoWD8YxGhPuIeWqse2qbQtXe9EqaTS/gOLZbhCeWRckvwHRAcTa9nHpmt/cyyI7Sw7WW7fhq0QwuIu9oUtOcPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206971; c=relaxed/simple;
	bh=kid8+DV+15MxZOJX+3t1IGU6wUDJNNJXItme1YWcb1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGIyCakQqxMXyJ2eOtUPTFf4Q8zYpdUFboCjyuJ4rwXnGrTPJIaleOUFCJP1akPgiDgmKSbiweVx6PEe0B9M/ASDJZ7ETT65HKgK/Ar8VgAymnsDUlcHQDPNYBMRJTzE/+F7zKRSMrcaKkVo99Q0qXFwmYryoJBJ1odDG9KsgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHV8bgoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHV8bgoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83E2C2BCB2;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206971;
	bh=kid8+DV+15MxZOJX+3t1IGU6wUDJNNJXItme1YWcb1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHV8bgoPLGkg/C+8Std46vK90hCsqe8haO2pX/KRjAmTqvPnjiHvIPENmLmfScqRW
	 yE/6CpcuHS+fcq374PZqPPtCsTZbuix9yONjFn9id8mMxZEOfacWjRTijwvVKAOU6Y
	 epb2/JASZSGFYXXHQoYT4v9OoN5EqTSM9Zd8CGFlC2TLllKqGgh/8wFG+kSJZs78rN
	 YwG8NDS+Ly8pNlHkWiqq47Lr6Ws7xHNuRjH7PkJObMnuZHidizHI9ek2HK5kS3QMoF
	 7YPyyS0yBSnpn4t6rrwpPjeXPhMBQCflKrBvIeccLpBV260wtqN3PX5Wh4s5wu8xU3
	 dEAJGf+bWzk3g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] mm/damon/core: receive addr_unit on damon_set_region_biggest_system_ram_default()
Date: Tue, 10 Mar 2026 22:29:24 -0700
Message-ID: <20260311052927.93921-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311052927.93921-1-sj@kernel.org>
References: <20260311052927.93921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_find_biggest_system_ram() was not supporting addr_unit in the
past.  Hence, its caller, damon_set_region_biggest_system_ram_default(),
was also not supporting addr_unit.  The previous commit has updated the
inner function to support addr_unit.  There is no more reason to not
support addr_unit on damon_set_region_biggest_system_ram_default().
Rather, it makes unnecessary inconsistency on support of addr_unit.
Update it to receive addr_unit and handle it inside.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 mm/damon/core.c       | 7 ++++---
 mm/damon/lru_sort.c   | 1 +
 mm/damon/reclaim.c    | 1 +
 mm/damon/stat.c       | 2 +-
 5 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1130c2f9a92f4..3a441fbca170d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -988,6 +988,7 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
+				unsigned long addr_unit,
 				unsigned long min_region_sz);
 
 #endif	/* CONFIG_DAMON */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index aee61bf991baa..d4f86c20b4f48 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3103,6 +3103,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * @t:		The monitoring target to set the region.
  * @start:	The pointer to the start address of the region.
  * @end:	The pointer to the end address of the region.
+ * @addr_unit:	The address unit for the damon_ctx of @t.
  * @min_region_sz:	Minimum region size.
  *
  * This function sets the region of @t as requested by @start and @end.  If the
@@ -3115,7 +3116,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  */
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 			unsigned long *start, unsigned long *end,
-			unsigned long min_region_sz)
+			unsigned long addr_unit, unsigned long min_region_sz)
 {
 	struct damon_addr_range addr_range;
 
@@ -3123,12 +3124,12 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 		return -EINVAL;
 
 	if (!*start && !*end &&
-		!damon_find_biggest_system_ram(start, end, 1))
+			!damon_find_biggest_system_ram(start, end, addr_unit))
 		return -EINVAL;
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, min_region_sz);
+	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);
 }
 
 /*
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 7bc5c0b2aea3e..133ea17e258df 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -345,6 +345,7 @@ static int damon_lru_sort_apply_parameters(void)
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
+					param_ctx->addr_unit,
 					param_ctx->min_region_sz);
 	if (err)
 		goto out;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 43d76f5bed449..01f2f6cdbcdfe 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -251,6 +251,7 @@ static int damon_reclaim_apply_parameters(void)
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
+					param_ctx->addr_unit,
 					param_ctx->min_region_sz);
 	if (err)
 		goto out;
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 25fb44ccf99d0..f9a2028483b05 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -181,7 +181,7 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 		goto free_out;
 	damon_add_target(ctx, target);
 	if (damon_set_region_biggest_system_ram_default(target, &start, &end,
-							ctx->min_region_sz))
+				ctx->addr_unit, ctx->min_region_sz))
 		goto free_out;
 	return ctx;
 free_out:
-- 
2.47.3
