Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACC2417DB;
	Thu,  6 Feb 2025 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883478; cv=none; b=gQsEj6vk9bKUpaaNroLCh5ooH8qiGI2825/wENIA5W3r6r3qlBdfOvYpz2qAgKQ09gwuLQtt7Sff6MzVs8HClyD/BYYvr+u7/2l+7eDzBIzASUZjxiDZrWqYIg9TOi5D0hUtIDy9KaRqvdOhEIJyOkmIOE0PlrTlF7bybG7aQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883478; c=relaxed/simple;
	bh=1l9ScDXKqIkJS8f8Hq8dlrjRQ1aDQXSzobIfw4wm6Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nyj9hKz8gw6mJsVr+X8k/XtkyqkkNDKws+WJgxim510yiHrhTTFnQToaVfx8GtdlrzdbNczs1/UIBrkSihxCNCFFZaqDQj3bOZQGkX/uGW/D3jUSascwot/h+3THcgdpS1ok5Yl2Bjw+KFqjF7gkjNdOwJuyPlzmiPzra8RaZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPa3J4Xv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPa3J4Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD7CC4CEDD;
	Thu,  6 Feb 2025 23:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883478;
	bh=1l9ScDXKqIkJS8f8Hq8dlrjRQ1aDQXSzobIfw4wm6Og=;
	h=From:To:Cc:Subject:Date:From;
	b=cPa3J4Xv775+ISWQBF7AiaN42OhdjeFkz3e0JvwuRs0mkmiRcKN7ZZvavAyh1cx6J
	 vHzcGtlGYMRfx4M2uJDcutFTKQ09iEYA8iyEg/RykWTeaEb9EjOcehM2D0wlcsDLOz
	 DFTQ1/SNfTtxRRAyssdXKp5Oefw4U6S1yXoXysMuqtSECSy3HLV3vtYiTjSMiCwrgN
	 SPqYKriZckG9EfDpz2UqEPSU10chbQDCHCdoaujbDA92EE/gPPGNbb+uDEW08Vtrv9
	 4YsC+K95mj+UAVf7gm2WMV1wyuqy+IURH2xwCvESV0bECHhjDPoMo9oHaJGPtc1qQf
	 5ev469ctkmQyg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH] mm/damon: avoid applying DAMOS action to same entity multiple times
Date: Thu,  6 Feb 2025 15:11:03 -0800
Message-Id: <20250206231103.38298-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'paddr' DAMON operations set can apply a DAMOS scheme's action to a
large folio multiple times in single DAMOS-regions-walk if the folio is
laid on multiple DAMON regions.  Add a field for DAMOS scheme object
that can be used by the underlying ops to know what was the last entity
that the scheme's action has applied.  The core layer unsets the field
when each DAMOS-regions-walk is done for the given scheme.  And update
'paddr' ops to use the infrastructure to avoid the problem.

Reported-by: Usama Arif <usamaarif642@gmail.com>
Closes: https://lore.kernel.org/20250203225604.44742-3-usamaarif642@gmail.com
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 +++++++++++
 mm/damon/core.c       |  1 +
 mm/damon/paddr.c      | 39 +++++++++++++++++++++++++++------------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af525252b853..a390af84cf0f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -432,6 +432,7 @@ struct damos_access_pattern {
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
+ * @last_applied:	Last @action applied ops-managing entity.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
  *
@@ -454,6 +455,15 @@ struct damos_access_pattern {
  * implementation could check pages of the region and skip &action to respect
  * &filters
  *
+ * The minimum entity that @action can be applied depends on the underlying
+ * &struct damon_operations.  Since it may not be aligned with the core layer
+ * abstract, namely &struct damon_region, &struct damon_operations could apply
+ * @action to same entity multiple times.  Large folios that underlying on
+ * multiple &struct damon region objects could be such examples.  The &struct
+ * damon_operations can use @last_applied to avoid that.  DAMOS core logic
+ * unsets @last_applied when each regions walking for applying the scheme is
+ * finished.
+ *
  * After applying the &action to each region, &stat_count and &stat_sz is
  * updated to reflect the number of regions and total size of regions that the
  * &action is applied.
@@ -477,6 +487,7 @@ struct damos {
 		int target_nid;
 	};
 	struct list_head filters;
+	void *last_applied;
 	struct damos_stat stat;
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c7b981308862..1a4dd644949b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1851,6 +1851,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		s->next_apply_sis = c->passed_sample_intervals +
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
+		s->last_applied = NULL;
 	}
 }
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0fb61f6ddb8d..d64c6fe28667 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -243,6 +243,17 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return false;
 }
 
+static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
+{
+	if (!folio)
+		return true;
+	if (folio == s->last_applied) {
+		folio_put(folio);
+		return true;
+	}
+	return false;
+}
+
 static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
@@ -250,6 +261,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
+	struct folio *folio;
 
 	/* check access in page level again by default */
 	damos_for_each_filter(filter, s) {
@@ -268,9 +280,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -296,6 +307,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_destroy_filter(filter);
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -304,12 +316,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied = 0;
+	struct folio *folio;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -328,6 +340,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -471,12 +484,12 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
+	struct folio *folio;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -495,6 +508,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -512,15 +526,15 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 {
 	unsigned long addr;
 	LIST_HEAD(folio_list);
+	struct folio *folio;
 
 	if (!damon_pa_scheme_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -530,6 +544,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return 0;
 }
 

base-commit: a0aaf0b2cacaf69162a3d20685ff8c7c84b15a41
-- 
2.39.5
