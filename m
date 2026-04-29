Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F6388E6F;
	Wed, 29 Apr 2026 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435958; cv=none; b=E3kfHGpqKkCsVdWj9fUiDMITKvPXTuncEnei3JobDskBVKGnHGYEcG1c9t216vdHTt3SCwDhJRrZrVsePzoPyFYsPNFeBam+/5+f4x7JHU+88FjNPkYF05w1a7X8rT1MGOmLhkirYe9dk89HHSE3lPUOF1txT4dHGOSPvYIoSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435958; c=relaxed/simple;
	bh=8jYx8KZ5p5GMU2eOGfXvJCf4Ua/nksXozWCmG0l4E4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghicHSYOx6bfbv7DejFNWTWsfmm7GsLEWBI8JGKsxjTUOF8BJYB+pnHJkMCMd8u3DkMczD8DJ+huumk50Do/K2VTcdZ+NPES1m4Rbqxy2zNemH3CxUr2A9zoBD0KApYGSqBNjnlD9n8U6lnaakuHtRPR3JTgYJHUe4rr/WVIlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On4DAleE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On4DAleE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40239C2BCB4;
	Wed, 29 Apr 2026 04:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435958;
	bh=8jYx8KZ5p5GMU2eOGfXvJCf4Ua/nksXozWCmG0l4E4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=On4DAleEvzEblzRF0MfZsJJfDsA5lc6a6VvbWctwBhhMaR7JRPPqOwfKLyoKtTl2T
	 aONJzcB/oXaoUjqOxrTAojdkxjdwWOULDFXcC0Mw2KmVFLKWiaVV+sca6oTM+BBY+N
	 Q1XYQYzacmH6KI9j8AB3l1VApf6Vm+oeQ3bMs73ZGkkXbyhFJFeWa5bWFg+5dHH4N3
	 vcNSrxC6u6TGv+CPF5bTImH82jucZWOUcycziOI6/d6BSuHxXT3MmP2P/sIrLEarVW
	 719+xYSRV+31RrlCvNdc9mNSoJsJAuvrJqCUWkbAdJWDBZHEAMjnOcmnvoWXxHVqia
	 zZXP712hKTrtQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon/core: remove damon_set_region_biggest_system_ram_default()
Date: Tue, 28 Apr 2026 21:12:26 -0700
Message-ID: <20260429041232.90257-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429041232.90257-1-sj@kernel.org>
References: <20260429041232.90257-1-sj@kernel.org>
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
index f656908b2d389..c7a31572689be 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1015,11 +1015,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
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
index 980a31cd3498e..9f38deddcb30e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3408,70 +3408,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
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
