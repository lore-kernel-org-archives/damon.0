Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238037C10A
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947042; cv=none; b=RX2E8Qd7UwemymiL5g7D17nSgzcsav2mgBRJlfMpv2s7SDtS6NHyhLDeLgiZSMfja4yFPZQ2c4YeMbLV5NDOi15cUTaWvFemE6+jkfh8aGQKoOYv2h8K1goFgBDTxv00ujadXd2kahvGA/eik2TvLeE1SVjF/oO9U8MpneQ36KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947042; c=relaxed/simple;
	bh=fiy8iaMWq/Yg9MRmr3M4HhfUKjomqt2aCidGWPzQrdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWSR6ktyejMtzvbRsxqpVQOVTMh8k7qjN5aIpdDdLRUpGJvmxc+DL0JuQq3ioUhwCEeYmmdaVNk4nYPjumFNrPyXBIAC/stCoNERL4iGsekLiwzOl+d8GsWOSHGht23ft+cxBdrjM/1X0X1Owx+YNJa1vI9DZ2N48ST2stmHIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uSs8sNFM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uSs8sNFM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776947038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWGjHpC/HwB7fOZCannKHZudf6pNBvZv4RwdF493nao=;
	b=uSs8sNFMQgoMF4PGSAmwJQVHn2QRYj6ZOrMD/xzKqULAsofXXIyqFRkoCEqJpc6kHTPuy+
	wS+PJOTfcHpfVRZ2dyYuva66+OmWPGg6SpaKwckqm4od1thLjqxVqjoUPI4BcmktBBsOt4
	1KyNGBLHpLboCw9PogA/xes+z33JDAA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/paddr: prefetch struct page of the next region
Date: Thu, 23 Apr 2026 20:23:37 +0800
Message-ID: <20260423122340.138880-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260423122340.138880-1-jiayuan.chen@linux.dev>
References: <20260423122340.138880-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

In paddr mode with large nr_regions (20k+), damon_get_folio() dominates
kdamond CPU time.  perf annotate shows ~98% of its samples on a single
load: reading page->compound_head for page_folio().  DAMON samples a
random PFN per region, so the access pattern scatters across the
vmemmap with no locality that hardware prefetchers can exploit; every
compound_head load misses to DRAM (~250 cycles).

Issue a software prefetch for the next region's struct page one
iteration before it is needed.  In __damon_pa_prepare_access_check(),
the next region's sampling_addr is picked eagerly (one iteration ahead
of where its mkold will run) so the prefetched line is usable, and the
first region of each epoch is handled with a one-off branch since it
has no predecessor to have pre-picked its addr.  damon_pa_check_accesses()
just prefetches based on sampling_addr already populated by the
preceding prepare pass.

Two details worth calling out:

  - prefetchw() rather than prefetch(): compound_head (+0x8) and
    _refcount (+0x34) share a 64B cacheline.  The subsequent
    folio_try_get() / folio_put() atomics write _refcount, so bringing
    the line in exclusive state avoids a later S->M coherence upgrade.

  - pfn_to_page() rather than pfn_to_online_page(): on
    CONFIG_SPARSEMEM_VMEMMAP the former is pure arithmetic
    (vmemmap + pfn), while the latter walks the mem_section table.  The
    mem_section lookup itself incurs a DRAM miss for random PFNs, which
    would serialize what is supposed to be a non-blocking hint - an
    earlier attempt that used pfn_to_online_page() saw the prefetch
    path's internal stall dominate perf (~91% skid on the converge
    point after the call).  Prefetching an unmapped vmemmap entry is
    safe: the hint is dropped without faulting.

Concurrency: list_next_entry() and &list == &head comparisons are safe
without locking because kdamond is the sole mutator of the region list
of its ctx; external threads must go through damon_call() which defers
execution to the same kdamond thread between sampling iterations
(see documentation on struct damon_ctx and damon_call()).

Tested with paddr monitoring, max_nr_regions=20000, and stress-ng-vm
consuming ~90% of memory across 8 workers: kdamond CPU further reduced
from ~50% to ~40% of one core on top of the earlier damon_rand_fast()
change.

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/damon/paddr.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b5e1197f2ba2..99bdf2b88cf1 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -10,6 +10,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
+#include <linux/prefetch.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
@@ -48,10 +49,29 @@ static void damon_pa_mkold(phys_addr_t paddr)
 	folio_put(folio);
 }
 
+static void damon_pa_prefetch_page(unsigned long sampling_addr,
+				   unsigned long addr_unit)
+{
+	phys_addr_t paddr = damon_pa_phys_addr(sampling_addr, addr_unit);
+
+	prefetchw(pfn_to_page(PHYS_PFN(paddr)));
+}
+
 static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
+					    struct damon_target *t,
 					    struct damon_region *r)
 {
-	r->sampling_addr = damon_rand_fast(ctx, r->ar.start, r->ar.end);
+	struct damon_region *next = list_next_entry(r, list);
+
+	/* First region has no predecessor to have pre-picked its addr. */
+	if (r->list.prev == &t->regions_list)
+		r->sampling_addr = damon_rand_fast(ctx, r->ar.start, r->ar.end);
+
+	if (&next->list != &t->regions_list) {
+		next->sampling_addr = damon_rand_fast(ctx, next->ar.start,
+						      next->ar.end);
+		damon_pa_prefetch_page(next->sampling_addr, ctx->addr_unit);
+	}
 
 	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, ctx->addr_unit));
 }
@@ -63,7 +83,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(ctx, r);
+			__damon_pa_prepare_access_check(ctx, t, r);
 	}
 }
 
@@ -106,11 +126,16 @@ static void __damon_pa_check_access(struct damon_region *r,
 static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
-	struct damon_region *r;
+	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
+			next = list_next_entry(r, list);
+			if (&next->list != &t->regions_list)
+				damon_pa_prefetch_page(next->sampling_addr,
+						       ctx->addr_unit);
+
 			__damon_pa_check_access(
 					r, &ctx->attrs, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
-- 
2.43.0

