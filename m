Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA833CEAF;
	Thu, 28 Aug 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401171; cv=none; b=dXLx7bJ9/VQ1rU6CjAD30JZB/JP/heNeOe/Ntb+rH4P6KbJRTXhYZm4DbJ0+HvAdlikGF5gFOChqwG0k0Ib1NHIGvTFIkq3Y/a38XxILoEyzhCrR6O7aAyX4progq9gaSSMwn5nJh+ydFIo2wioXZjt3W74aI23V3glDfBGJtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401171; c=relaxed/simple;
	bh=fYhqOdJk8g7Kx4IsyLnZ52pSMGRQylBDNBv4D4Pqc2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5LT1knze+F6wM56/OrylZO4gXiXs+Hk8S4qxfQk4rxJXKEMqpwghhwUizShn4DBE74c0DbXcIUDd0MEtTpJMTwIiT5v4+vGyRhA+5qUwKATW9nRWkx6SsrGLV0TGyTGXLIxxZYxqX0hj5cvXkH8HsDT9OVxV/yAkW79YELhByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6ZWd3xP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6ZWd3xP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC6C4CEF9;
	Thu, 28 Aug 2025 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401170;
	bh=fYhqOdJk8g7Kx4IsyLnZ52pSMGRQylBDNBv4D4Pqc2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6ZWd3xPefENCDvxLUzYqof2Vqp7XK2zl+1MsWwPTYSiCWpjFxzhsxx3HgoYntLd3
	 KKs80tvDNSYseHgdp4uYx96ZzbbpYJSlJecQaVqV63H0YsIJ1BDp0e6ryZvWuNXpW0
	 zYxzih8BYLXwpN8Cw2Oa6yWhGH7R7CvoIbOqZFT19Ez0nbgRiBrMor49k9eR8TeYvL
	 Cd/dlw2ZYG6FyuMmrNLl3SaPNnhqyt44NSiCM25b+Zj751sI6Qsp3/fg+r74+/t72u
	 q1YDFa+BHVyU3VbzgDt0GI1Y0IfgyUda78LGuwojc6SkRehc1K9GsfIvddbIe0ztzR
	 fqTUmMnayD8SA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Thu, 28 Aug 2025 10:12:34 -0700
Message-Id: <20250828171242.59810-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of addr_unit for DAMOS_PAGEOUT action handling from the
DAMOS operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d497373c2bd2..696aeb0f6c8e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -24,6 +24,19 @@ static phys_addr_t damon_pa_phys_addr(
 	return (phys_addr_t)addr * addr_unit;
 }
 
+static unsigned long damon_pa_core_addr(
+		phys_addr_t pa, unsigned long addr_unit)
+{
+	/*
+	 * Use div_u64() for avoiding linking errors related with __udivdi3,
+	 * __aeabi_uldivmod, or similar problems.  This should also improve the
+	 * performance optimization (read div_u64() comment for the detail).
+	 */
+	if (sizeof(pa) == 8 && sizeof(addr_unit) == 4)
+		return div_u64(pa, addr_unit);
+	return pa / addr_unit;
+}
+
 static void damon_pa_mkold(phys_addr_t paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
@@ -135,10 +148,11 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_pageout(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	phys_addr_t addr, applied;
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
@@ -159,8 +173,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_add_filter(s, filter);
 	}
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -170,7 +184,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 		else
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
@@ -189,7 +203,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
 	s->last_applied = folio;
-	return applied * PAGE_SIZE;
+	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
@@ -302,9 +316,11 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
 {
+	unsigned long aunit = ctx->addr_unit;
+
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme, sz_filter_passed);
+		return damon_pa_pageout(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
-- 
2.39.5
