Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0E2F069D;
	Wed, 15 Apr 2026 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216058; cv=none; b=FZLcPy5+tDopKJVGbR+vlTd4NAXg5s4uKQqPNGl24Kzi69uyK50wAAZHJ/JGQL/9ZlI3wZe7XUdlKtM3WPR3qxnYCbXHUV2nySa88AndrGcvzo9acDL07fi76rSzZtdYbfrSgBSQBFKGqIafe9HjUHmr/Gz5rcnwZk5BRqPT50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216058; c=relaxed/simple;
	bh=x8bXl3PuqEzl+QG+OoYKgf8IyRa9wew4podtKeqi3D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa6wF97YqpIfm6cbdyi/r8ubz180xHrmNZVdMojfPoCst4oVK6jSNZickR+W0ypEgY3qbH8JrmVVGbnMXl6CSixVa7qEUsv7ewb1uOmTuhFjgci5YMB3NcsWqWVeFIPb8a+KDhmW348etBCkUzOrjK6dGMQIaInQ3eXaCL3rAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMrHzTi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMrHzTi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D54C2BCB6;
	Wed, 15 Apr 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216058;
	bh=x8bXl3PuqEzl+QG+OoYKgf8IyRa9wew4podtKeqi3D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMrHzTi8vNNouQyMdH3ZOkAv3j0wwweVvEdNKI41DrZLVNbhCIT9jmPJDnD/JXK+/
	 30PpgQOhHTwS7OvwdxHIlvIphHz4B1QHKR3pW56SG4c5/ZO2zj1rBjI/XgFjHXDMFO
	 Thvbx8JtZpJ6W99VJl5uQg6EAkitdmAYCYvb6dURq0UhoZ8KVL92WUK68WCwalo/JJ
	 GTBFb6A+Hl8DEJnjOddgTkqBd2QEXv892+FonCHsvi7TYsJkwxo5Cuz7gTYIfuPpQD
	 yeFPui7fpyYyYr0kEP0b7iVA7PZ0w+5vws9Co4PpBAToZIJL4trYe5LUkMvNBnAgGv
	 bsDP9QWnmzzXg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/7] mm/damon/core: remove damon_set_region_biggest_system_ram_default()
Date: Tue, 14 Apr 2026 18:20:32 -0700
Message-ID: <20260415012048.76508-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415012048.76508-1-sj@kernel.org>
References: <20260415012048.76508-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now nobody is using damon_set_region_biggest_system_ram_default().
Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  5 ----
 mm/damon/core.c       | 64 -------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c4cdaa01ea530..1a4f754ad89be 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1012,11 +1012,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long addr_unit,
 				unsigned long min_region_sz);
 
-int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-				unsigned long *start, unsigned long *end,
-				unsigned long addr_unit,
-				unsigned long min_region_sz);
-
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3cef74ba7f0f4..d2c8c088e7451 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3266,70 +3266,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 	return damon_set_regions(t, &addr_range, 1, min_region_sz);
 }
 
-static int walk_system_ram(struct resource *res, void *arg)
-{
-	struct resource *a = arg;
-
-	if (resource_size(a) < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
-	}
-	return 0;
-}
-
-/*
- * Find biggest 'System RAM' resource and store its start and end address in
- * @start and @end, respectively.  If no System RAM is found, returns false.
- */
-static bool damon_find_biggest_system_ram(unsigned long *start,
-		unsigned long *end, unsigned long addr_unit)
-
-{
-	struct resource res = {};
-
-	walk_system_ram_res(0, -1, &res, walk_system_ram);
-	*start = damon_res_to_core_addr(res.start, addr_unit);
-	*end = damon_res_to_core_addr(res.end + 1, addr_unit);
-	if (*end <= *start)
-		return false;
-	return true;
-}
-
-/**
- * damon_set_region_biggest_system_ram_default() - Set the region of the given
- * monitoring target as requested, or biggest 'System RAM'.
- * @t:		The monitoring target to set the region.
- * @start:	The pointer to the start address of the region.
- * @end:	The pointer to the end address of the region.
- * @addr_unit:	The address unit for the damon_ctx of @t.
- * @min_region_sz:	Minimum region size.
- *
- * This function sets the region of @t as requested by @start and @end.  If the
- * values of @start and @end are zero, however, this function finds the biggest
- * 'System RAM' resource and sets the region to cover the resource.  In the
- * latter case, this function saves the start and end addresses of the resource
- * in @start and @end, respectively.
- *
- * Return: 0 on success, negative error code otherwise.
- */
-int damon_set_region_biggest_system_ram_default(struct damon_target *t,
-			unsigned long *start, unsigned long *end,
-			unsigned long addr_unit, unsigned long min_region_sz)
-{
-	struct damon_addr_range addr_range;
-
-	if (*start > *end)
-		return -EINVAL;
-
-	if (!*start && !*end &&
-			!damon_find_biggest_system_ram(start, end, addr_unit))
-		return -EINVAL;
-
-	addr_range.start = *start;
-	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, min_region_sz);
-}
-
 /*
  * damon_moving_sum() - Calculate an inferred moving sum value.
  * @mvsum:	Inferred sum of the last @len_window values.
-- 
2.47.3
