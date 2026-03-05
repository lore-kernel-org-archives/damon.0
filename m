Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5C285CAA;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689167; cv=none; b=svzdg6m1YSamrNXDJiEeLSWSfZLrNCSRhdghFJZdf7qfDpun5rfikOmmYgXvvNJVXWW4jMvJtDo4OTZjCLoq07/yaajLbqas9Tb8RTBBNIelTCWrbQIi07ybzmmw9C5TACOtn/J533ESDEG2XLx0wVEQAjZ4K7H7Ak2PwB5Avu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689167; c=relaxed/simple;
	bh=mqrS298EvCt8+EHb5aza5DzJ8VI15nbcF2oVbBOpCLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6r+DpWwfmQVpwoJKkv0+f78qjr51d6ifDE6Mb+gMCqRT7yEoimwhUFS5BgLwQBb9LE4rZi8W/fAtlcZ5v7Ks+CL9/QDUhGdFn5TobwpJCy2KgxSF3fEVPRuRggg6iX5+V8EUu4IO43cTiqUMXWU7Pc16MAyZUEAlO+FCIFlxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF76mekm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF76mekm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346EEC19423;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772689167;
	bh=mqrS298EvCt8+EHb5aza5DzJ8VI15nbcF2oVbBOpCLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nF76mekm1OnSpkMCOuLU8n63slrkkELJNnTBBSGi7gyGXGB80cedFl3EHHb8qDAnW
	 nfda3ULhAI9uo1HVhqKDvAPhOlQDtlQcWCuDPOh081E7SKGYV2I0YsEJPRENTryrFk
	 DJoqjYgUc6Sihv9ruypthGx91c3+97PumlSHDPeTNpl3Ay5jjZdMnqPC6fU0Y2D4Ym
	 SLoHuT75vr8tLpPW2sAhoxvQwy96BwePlBFH7qpiuABtv23yuTi61qzAIeSzkkchtS
	 77dI79qAPUnYWOFZJoXUDqTNKpgfA7KA+4tzGciQ73aZYIz5r3BYlwrVkGIvXPTUd3
	 rAFly0PFSizcw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/5] mm/damon/core: receive addr_unit on damon_set_region_biggest_system_ram_default()
Date: Wed,  4 Mar 2026 21:39:15 -0800
Message-ID: <20260305053918.83786-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305053918.83786-1-sj@kernel.org>
References: <20260305053918.83786-1-sj@kernel.org>
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
inner function to support addr_unit.  There is no reason to support
addr_unit on damon_set_region_biggest_system_ram_default().  Update it
to receive addr_unit and handle it inside.  Update callers of the
function to pass value '1' to addr_unit parameter, though. to avoid
unnecessary behavioral change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 mm/damon/core.c       | 7 ++++---
 mm/damon/lru_sort.c   | 1 +
 mm/damon/reclaim.c    | 1 +
 mm/damon/stat.c       | 2 +-
 5 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c4095b34f7929..c269b0c93f9df 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -985,6 +985,7 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
+				unsigned long addr_unit,
 				unsigned long min_region_sz);
 
 #endif	/* CONFIG_DAMON */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 38c7a919f9bb2..ce19d751f5102 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3099,6 +3099,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * @t:		The monitoring target to set the region.
  * @start:	The pointer to the start address of the region.
  * @end:	The pointer to the end address of the region.
+ * @addr_unit:	The address unit for the damon_ctx of @t.
  * @min_region_sz:	Minimum region size.
  *
  * This function sets the region of @t as requested by @start and @end.  If the
@@ -3111,7 +3112,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  */
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 			unsigned long *start, unsigned long *end,
-			unsigned long min_region_sz)
+			unsigned long addr_unit, unsigned long min_region_sz)
 {
 	struct damon_addr_range addr_range;
 
@@ -3119,12 +3120,12 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
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
