Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610214;
	b=QMEe4GB5KbKiaIV6ZGJlLGtTqxKGoZAdY0xTQKKpLcxxjVPP7oyHXG+ZDy60XPSmgzCQ
	 St3WKJQa9ihi4OURrpggJIxv//ax5T2lD1h8xuVQmrSRg6/9jLFqo2D44oGyaimQpU6OQ
	 elo4H/Co7RSRzZrtetLg/L0md3rvL2ule23PICXnhmgOZAHA4so22GONEmZ4Do7GtX/vY
	 VowZV0QwylY2Hw9E42sNxn0etzceBlvegZqMfTCfnI1ld3uIbZ8LRaffDt6Du8SZBtU/7
	 t95OiV/8DgDx+T2TDrxT+cSB+2w7ENsDHZ0wCF2M4Iz/uk+nGPyg+eVmg27ZJl4xgIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=C9PVTO+o8vn+uvMZF31e4GKIg2ZTnIwjzGlvqUNqLkI=;
	b=SVkedS7frU8VyPK5vSBkfrCeIR63pXNBRsgtMPdvhGnYsPWYQ+hlhiM9OBPNU0KGfZkg
	 1/iOt3kodmsdbQU5F1dHMw6Yl+rD41L2pd7BmuU0N52rj5bpWQSyfNGhnvjEDH8HzKKaq
	 j8mSefXgK4HCQVvoclZLM/g6FmPEG+WU5e9JC/w2FaSYVmA4Wgoclq5CUnOmKn7wYfpGe
	 i78Q7ASG9LeaEbJ4ZG9qmz89UzxtZ19Y7Q/zyN967eR9R4XI7dwQ5oSIa/FbfmtEmEP1J
	 jo9l/7n7vOwDc4sgofN+0HQRYhuthLbKvx3k70Ss+0vocw+g4wSSJ9v6avFIw7bgEFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPYSqqOq;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F655606A326
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 12:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F655606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPYSqqOq
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so1181823a91.1
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610213; x=1796215013; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PVTO+o8vn+uvMZF31e4GKIg2ZTnIwjzGlvqUNqLkI=;
        b=tPYSqqOqSgVfCVNuoZ11LCyLR3HS6MBdHo7nknjX/eeezGfq8Dsoj6bQ0g77G5zfbc
         nZ89LjEuVn3kFNavnAJ8FIYBe12/0n4OikA31MqkEiJ0ctmWBsBM+OLy1k7ZnEuAOnzl
         J16PtSvwWRYczixPJhDK79OAjjWfUjUzBOu4s78DHxWkAXTel5L+4FquMWKCROVWTRV+
         bB6IQjZoAxeIWhur22iefE3jCND9IDl/pHEzcsBGZYtyIVVNsg29JexSvwgNbIaA4Ifc
         gbU66AOhHThZgC0k6sSriWIgYk6Z7JxyfFJjSfA4ALMta1CbpfTPgIAbKAeUQncIbrYo
         ZXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610213; x=1796215013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PVTO+o8vn+uvMZF31e4GKIg2ZTnIwjzGlvqUNqLkI=;
        b=felm2bzjJ7tiFzi0nNZfQGn5oqrzLIn6cMrlOP8impK2X1UbzYlv2GEtaG7ImxAXl1
         PpZlJTfK8MbQEmLuNe6ZSV90zd6hJ90ApDgnjBo4Pue7qVRd0yXAm1MrS4YJD69l4jAq
         +JHtbCdngLLOPd92mSaD55ImMYkUIPRyy/OPReaJTZmHv5vu3gEmh6CfzUorb1ey7akn
         YeatwnsAv9NqYvqQr+F8NcUrES1r05HHi1VwADpyguE0zGMfGzc9kCN5gCvJq4mRAg2z
         1rwIZURZa9Wa5N4IjaZEJ42rsgb0M/9aE2wN78wyKachW8YQhcz7NUR4HumhZCzQGup4
         7QhQ==
X-Forwarded-Encrypted: i=1; AL+hErHQJ6QvISvHX+gWgZHBtU2KLix4eWe93SPMUmnEPWfZVgxh6/uGxhUAtfmDD1m8j73jnFu3iQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9WxG3N+le5MLHMuTyWcyK0hkoIP2Lfhehjjmc2aSnjo5HWYn63
	5MIrqqA0ERGw5T3M86GGe+FUhscDibOPYG4HbYUwzmckzmmNDIaG1O/3
X-Gm-Gg: AZFdTZfPNpolMYIxPmOh9E+rx6tnLIKwQ1NaDYyGYZvvlnC516+7RWtrqxUZZNXyIii
	tHVe13Eoev4J2ggot2Hm94P9+3puDg8pd83tj20lXXbtSuSXnza6prCoxqGD0AZBW28BNq0jKDF
	1qmAHKDXVe/tZ01oL3WtFupeC95VxAoVcvUG6LtxnPAAaYM1Eb73R77pXWj21NrtRUX5Vl4PsmC
	FQTuXDPFvu9+ONZjTopnAwNMCqrTQeg/EushK2gJO++5RlcanPzUOp7f+1/nZonFu0hgIHONpuU
	x10kDCrNOm4+93cDVECMvyEEIqMZg8XY8RjZuA9Nn8hYMZv/b1srD5oyz5x9CYyGfEfB/Ebx4wQ
	JURV8clcHEICeCpmr4rDlSucNXtPkiuhdEpyJNbDEniNTY5xFQe7jJeShBOZI8BR6ssfII+pOos
	XTriZrnA74kX5OOobKmnSLbnrqqtbBVTasFQKy1RFyqxadp+2jZk5hLs2KsQxERulbk+aGytW1C
	EnbkSwzUthRNFjQHiINhECD9mVMTEskV5qPqwdz/XnPjtwMkfL+WGjHw8yK0PaCKjMxmcVlwNyR
	WRfAba9fEeRwkWZaFKNgUjH2j7Svh+7JJzUYjByl92CW9U+17kXZ7LgFLK/qBF5yR35Bs9Q=
X-Received: by 2002:a17:90b:4a48:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b41c7b60b5mr15844816a91.6.1795610212712;
        Wed, 25 Nov 2026 04:36:52 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm30933094a91.10.2026.11.25.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:36:52 -0800 (PST)
Date: Wed, 25 Nov 2026 20:36:36 +0800
From: Kairui Song <ryncsn@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, 
	David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Subject: Re: [PATCH v6 08/18] mm/mglru: make folio lru referenced times count
 a generic API
Message-ID: <awa30hwg6x82REoo@KASONG-MC4>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-8-8ffea39934a6@tencent.com>
 <e85a2666-9722-420b-9a60-9d4251fc3d4c@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e85a2666-9722-420b-9a60-9d4251fc3d4c@kernel.org>

On Wed, Nov 25, 2026 at 11:15:33AM +0800, David Hildenbrand (Arm) wrote:
> On 11/23/26 19:53, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> > 
> > Pure code shuffle, no behavior change.
> > 
> > Make the folio LRU refs helpers available regardless of CONFIG_LRU_GEN.
> > Without MGLRU the extra bits are never set, so they are inert. Move the
> > lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares for
> > unifying the API for checking folio referenced and workingset status.
> > 
> > folio_migrate_lru_refs() now migrates the complete refs count,
> > including PG_workingset (bit 1 of the encoding), bitwise identical to
> > the direct copy dropped from folio_migrate_flags().
> > 
> > lru_set_refs_flags() skips the nonexistent mask bits when
> > LRU_REFS_WIDTH collapses to 0, preserving the two independent flags for
> > !CONFIG_LRU_GEN builds.
> > 
> > Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/mm_inline.h | 55 ++++++++++++++++++++++++-----------------------
> 
> I'm starting to feel like all of these mglru/reclaim thingies should go into a
> dedicated helper.

Hi David

I saw your comment on other patches too, about the header mm_inline.h,
about ~690 / 860 lines of code in it is for MGLRU / CLRU only. The
rest ~200 are for VMA / TLB / MMU.

> 
> Can you do that as a prio cleanup in this series, so we don't have to mess with
> mm_inline.h in later patches anymore?

Perhaps we can instead move the non LRU helpers in it?
These helpers:

  - anon_vma_name_get
  - anon_vma_name_put
  - anon_vma_name_reuse
  - dup_anon_vma_name
  - free_anon_vma_name
  - anon_vma_name_eq
  - pfnmap_track_ctx_release
  - init_tlb_flush_pending
  - inc_tlb_flush_pending
  - dec_tlb_flush_pending
  - mm_tlb_flush_pending
  - mm_tlb_flush_nested
  - copy_pte_marker
  - num_pages_contiguous

All other helper in mm_inline.h are for LRU. So we rename mm_inline.h
to mm_lru.h?

Like the patch below, zero behavior change, pure code shuffle:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d8bafcd92791..2eb0e2fc8c2d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1903,6 +1903,90 @@ static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return
 
 int vma_is_stack_for_current(const struct vm_area_struct *vma);
 
+static inline void init_tlb_flush_pending(struct mm_struct *mm)
+{
+	atomic_set(&mm->tlb_flush_pending, 0);
+}
+
+static inline void inc_tlb_flush_pending(struct mm_struct *mm)
+{
+	atomic_inc(&mm->tlb_flush_pending);
+	/*
+	 * The only time this value is relevant is when there are indeed pages
+	 * to flush. And we'll only flush pages after changing them, which
+	 * requires the PTL.
+	 *
+	 * So the ordering here is:
+	 *
+	 *	atomic_inc(&mm->tlb_flush_pending);
+	 *	spin_lock(&ptl);
+	 *	...
+	 *	set_pte_at();
+	 *	spin_unlock(&ptl);
+	 *
+	 *				spin_lock(&ptl)
+	 *				mm_tlb_flush_pending();
+	 *				....
+	 *				spin_unlock(&ptl);
+	 *
+	 *	flush_tlb_range();
+	 *	atomic_dec(&mm->tlb_flush_pending);
+	 *
+	 * Where the increment if constrained by the PTL unlock, it thus
+	 * ensures that the increment is visible if the PTE modification is
+	 * visible. After all, if there is no PTE modification, nobody cares
+	 * about TLB flushes either.
+	 *
+	 * This very much relies on users (mm_tlb_flush_pending() and
+	 * mm_tlb_flush_nested()) only caring about _specific_ PTEs (and
+	 * therefore specific PTLs), because with SPLIT_PTE_PTLOCKS and RCpc
+	 * locks (PPC) the unlock of one doesn't order against the lock of
+	 * another PTL.
+	 *
+	 * The decrement is ordered by the flush_tlb_range(), such that
+	 * mm_tlb_flush_pending() will not return false unless all flushes have
+	 * completed.
+	 */
+}
+
+static inline void dec_tlb_flush_pending(struct mm_struct *mm)
+{
+	/*
+	 * See inc_tlb_flush_pending().
+	 *
+	 * This cannot be smp_mb__before_atomic() because smp_mb() simply does
+	 * not order against TLB invalidate completion, which is what we need.
+	 *
+	 * Therefore we must rely on tlb_flush_*() to guarantee order.
+	 */
+	atomic_dec(&mm->tlb_flush_pending);
+}
+
+static inline bool mm_tlb_flush_pending(const struct mm_struct *mm)
+{
+	/*
+	 * Must be called after having acquired the PTL; orders against that
+	 * PTLs release and therefore ensures that if we observe the modified
+	 * PTE we must also observe the increment from inc_tlb_flush_pending().
+	 *
+	 * That is, it only guarantees to return true if there is a flush
+	 * pending for _this_ PTL.
+	 */
+	return atomic_read(&mm->tlb_flush_pending);
+}
+
+static inline bool mm_tlb_flush_nested(const struct mm_struct *mm)
+{
+	/*
+	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
+	 * for which there is a TLB flush pending in order to guarantee
+	 * we've seen both that PTE modification and the increment.
+	 *
+	 * (no requirement on actually still holding the PTL, that is irrelevant)
+	 */
+	return atomic_read(&mm->tlb_flush_pending) > 1;
+}
+
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
 
@@ -2887,6 +2971,42 @@ static inline unsigned long memdesc_section(const memdesc_flags_t *mdf)
 }
 #endif /* SECTION_IN_PAGE_FLAGS */
 
+/**
+ * num_pages_contiguous() - determine the number of contiguous pages
+ *			    that represent contiguous PFNs
+ * @pages: an array of page pointers
+ * @nr_pages: length of the array, at least 1
+ *
+ * Determine the number of contiguous pages that represent contiguous PFNs
+ * in @pages, starting from the first page.
+ *
+ * In some kernel configs contiguous PFNs will not have contiguous struct
+ * pages. In these configurations num_pages_contiguous() will return a num
+ * smaller than ideal number. The caller should continue to check for pfn
+ * contiguity after each call to num_pages_contiguous().
+ *
+ * Returns the number of contiguous pages.
+ */
+static inline size_t num_pages_contiguous(struct page **pages, size_t nr_pages)
+{
+	struct page *cur_page = pages[0];
+	unsigned long section = memdesc_section(&cur_page->flags);
+	size_t i;
+
+	for (i = 1; i < nr_pages; i++) {
+		if (++cur_page != pages[i])
+			break;
+		/*
+		 * In unproblematic kernel configs, page_to_section() == 0 and
+		 * the whole check will get optimized out.
+		 */
+		if (memdesc_section(&cur_page->flags) != section)
+			break;
+	}
+
+	return i;
+}
+
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f6f4bc9a704f..d7f1d3e4fa4c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -6,9 +6,6 @@
 #include <linux/huge_mm.h>
 #include <linux/mm_types.h>
 #include <linux/swap.h>
-#include <linux/string.h>
-#include <linux/userfaultfd_k.h>
-#include <linux/leafops.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -500,181 +497,7 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 			-folio_nr_pages(folio));
 }
 
-#ifdef CONFIG_ANON_VMA_NAME
-/* mmap_lock should be read-locked */
-static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
-{
-	if (anon_name)
-		kref_get(&anon_name->kref);
-}
-
-static inline void anon_vma_name_put(struct anon_vma_name *anon_name)
-{
-	if (anon_name)
-		kref_put(&anon_name->kref, anon_vma_name_free);
-}
-
-static inline
-struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
-{
-	/* Prevent anon_name refcount saturation early on */
-	if (kref_read(&anon_name->kref) < REFCOUNT_MAX) {
-		anon_vma_name_get(anon_name);
-		return anon_name;
-
-	}
-	return anon_vma_name_alloc(anon_name->name);
-}
-
-static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
-				     struct vm_area_struct *new_vma)
-{
-	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
-
-	if (anon_name)
-		new_vma->anon_name = anon_vma_name_reuse(anon_name);
-}
-
-static inline void free_anon_vma_name(struct vm_area_struct *vma)
-{
-	/*
-	 * Not using anon_vma_name because it generates a warning if mmap_lock
-	 * is not held, which might be the case here.
-	 */
-	anon_vma_name_put(vma->anon_name);
-}
-
-static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
-				    struct anon_vma_name *anon_name2)
-{
-	if (anon_name1 == anon_name2)
-		return true;
-
-	return anon_name1 && anon_name2 &&
-		!strcmp(anon_name1->name, anon_name2->name);
-}
-
-#else /* CONFIG_ANON_VMA_NAME */
-static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
-static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
-static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
-				     struct vm_area_struct *new_vma) {}
-static inline void free_anon_vma_name(struct vm_area_struct *vma) {}
-
-static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
-				    struct anon_vma_name *anon_name2)
-{
-	return true;
-}
-
-#endif  /* CONFIG_ANON_VMA_NAME */
-
-void pfnmap_track_ctx_release(struct kref *ref);
-
-static inline void init_tlb_flush_pending(struct mm_struct *mm)
-{
-	atomic_set(&mm->tlb_flush_pending, 0);
-}
-
-static inline void inc_tlb_flush_pending(struct mm_struct *mm)
-{
-	atomic_inc(&mm->tlb_flush_pending);
-	/*
-	 * The only time this value is relevant is when there are indeed pages
-	 * to flush. And we'll only flush pages after changing them, which
-	 * requires the PTL.
-	 *
-	 * So the ordering here is:
-	 *
-	 *	atomic_inc(&mm->tlb_flush_pending);
-	 *	spin_lock(&ptl);
-	 *	...
-	 *	set_pte_at();
-	 *	spin_unlock(&ptl);
-	 *
-	 *				spin_lock(&ptl)
-	 *				mm_tlb_flush_pending();
-	 *				....
-	 *				spin_unlock(&ptl);
-	 *
-	 *	flush_tlb_range();
-	 *	atomic_dec(&mm->tlb_flush_pending);
-	 *
-	 * Where the increment if constrained by the PTL unlock, it thus
-	 * ensures that the increment is visible if the PTE modification is
-	 * visible. After all, if there is no PTE modification, nobody cares
-	 * about TLB flushes either.
-	 *
-	 * This very much relies on users (mm_tlb_flush_pending() and
-	 * mm_tlb_flush_nested()) only caring about _specific_ PTEs (and
-	 * therefore specific PTLs), because with SPLIT_PTE_PTLOCKS and RCpc
-	 * locks (PPC) the unlock of one doesn't order against the lock of
-	 * another PTL.
-	 *
-	 * The decrement is ordered by the flush_tlb_range(), such that
-	 * mm_tlb_flush_pending() will not return false unless all flushes have
-	 * completed.
-	 */
-}
-
-static inline void dec_tlb_flush_pending(struct mm_struct *mm)
-{
-	/*
-	 * See inc_tlb_flush_pending().
-	 *
-	 * This cannot be smp_mb__before_atomic() because smp_mb() simply does
-	 * not order against TLB invalidate completion, which is what we need.
-	 *
-	 * Therefore we must rely on tlb_flush_*() to guarantee order.
-	 */
-	atomic_dec(&mm->tlb_flush_pending);
-}
-
-static inline bool mm_tlb_flush_pending(const struct mm_struct *mm)
-{
-	/*
-	 * Must be called after having acquired the PTL; orders against that
-	 * PTLs release and therefore ensures that if we observe the modified
-	 * PTE we must also observe the increment from inc_tlb_flush_pending().
-	 *
-	 * That is, it only guarantees to return true if there is a flush
-	 * pending for _this_ PTL.
-	 */
-	return atomic_read(&mm->tlb_flush_pending);
-}
-
-static inline bool mm_tlb_flush_nested(const struct mm_struct *mm)
-{
-	/*
-	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
-	 * for which there is a TLB flush pending in order to guarantee
-	 * we've seen both that PTE modification and the increment.
-	 *
-	 * (no requirement on actually still holding the PTL, that is irrelevant)
-	 */
-	return atomic_read(&mm->tlb_flush_pending) > 1;
-}
-
 #ifdef CONFIG_MMU
-/*
- * Computes the pte marker to copy from the given source entry into dst_vma.
- * If no marker should be copied, returns 0.
- * The caller should insert a new pte created with make_pte_marker().
- */
-static inline pte_marker copy_pte_marker(
-		softleaf_t entry, struct vm_area_struct *dst_vma)
-{
-	const pte_marker srcm = softleaf_to_marker(entry);
-	/* Always copy error entries. */
-	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
-
-	/* Only copy PTE markers if UFFD register matches. */
-	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
-		dstm |= PTE_MARKER_UFFD_WP;
-
-	return dstm;
-}
-
 static inline bool vma_has_recency(const struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
@@ -687,40 +510,4 @@ static inline bool vma_has_recency(const struct vm_area_struct *vma)
 }
 #endif
 
-/**
- * num_pages_contiguous() - determine the number of contiguous pages
- *			    that represent contiguous PFNs
- * @pages: an array of page pointers
- * @nr_pages: length of the array, at least 1
- *
- * Determine the number of contiguous pages that represent contiguous PFNs
- * in @pages, starting from the first page.
- *
- * In some kernel configs contiguous PFNs will not have contiguous struct
- * pages. In these configurations num_pages_contiguous() will return a num
- * smaller than ideal number. The caller should continue to check for pfn
- * contiguity after each call to num_pages_contiguous().
- *
- * Returns the number of contiguous pages.
- */
-static inline size_t num_pages_contiguous(struct page **pages, size_t nr_pages)
-{
-	struct page *cur_page = pages[0];
-	unsigned long section = memdesc_section(&cur_page->flags);
-	size_t i;
-
-	for (i = 1; i < nr_pages; i++) {
-		if (++cur_page != pages[i])
-			break;
-		/*
-		 * In unproblematic kernel configs, page_to_section() == 0 and
-		 * the whole check will get optimized out.
-		 */
-		if (memdesc_section(&cur_page->flags) != section)
-			break;
-	}
-
-	return i;
-}
-
 #endif
diff --git a/mm/internal.h b/mm/internal.h
index de4593b3e3b6..b52647a2442b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -16,7 +16,9 @@
 #include <linux/pagemap.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
+#include <linux/string.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
 #include <linux/leafops.h>
 #include <linux/tracepoint-defs.h>
 
@@ -281,12 +283,104 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 /* unmap_vmas is in mm/memory.c */
 void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
 
+#ifdef CONFIG_ANON_VMA_NAME
+/* mmap_lock should be read-locked */
+static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
+{
+	if (anon_name)
+		kref_get(&anon_name->kref);
+}
+
+static inline void anon_vma_name_put(struct anon_vma_name *anon_name)
+{
+	if (anon_name)
+		kref_put(&anon_name->kref, anon_vma_name_free);
+}
+
+static inline
+struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
+{
+	/* Prevent anon_name refcount saturation early on */
+	if (kref_read(&anon_name->kref) < REFCOUNT_MAX) {
+		anon_vma_name_get(anon_name);
+		return anon_name;
+
+	}
+	return anon_vma_name_alloc(anon_name->name);
+}
+
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
+{
+	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
+
+	if (anon_name)
+		new_vma->anon_name = anon_vma_name_reuse(anon_name);
+}
+
+static inline void free_anon_vma_name(struct vm_area_struct *vma)
+{
+	/*
+	 * Not using anon_vma_name because it generates a warning if mmap_lock
+	 * is not held, which might be the case here.
+	 */
+	anon_vma_name_put(vma->anon_name);
+}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	if (anon_name1 == anon_name2)
+		return true;
+
+	return anon_name1 && anon_name2 &&
+		!strcmp(anon_name1->name, anon_name2->name);
+}
+
+#else /* CONFIG_ANON_VMA_NAME */
+static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
+static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma) {}
+static inline void free_anon_vma_name(struct vm_area_struct *vma) {}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	return true;
+}
+
+#endif  /* CONFIG_ANON_VMA_NAME */
+
+#ifdef __HAVE_PFNMAP_TRACKING
+void pfnmap_track_ctx_release(struct kref *ref);
+#endif
+
 #ifdef CONFIG_MMU
 
 bool cond_install_uffd_wp_ptes(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, pte_t pte,
 		unsigned long nr_ptes);
 
+/*
+ * Computes the pte marker to copy from the given source entry into dst_vma.
+ * If no marker should be copied, returns 0.
+ * The caller should insert a new pte created with make_pte_marker().
+ */
+static inline pte_marker copy_pte_marker(
+		softleaf_t entry, struct vm_area_struct *dst_vma)
+{
+	const pte_marker srcm = softleaf_to_marker(entry);
+	/* Always copy error entries. */
+	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
+
+	/* Only copy PTE markers if UFFD register matches. */
+	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
+		dstm |= PTE_MARKER_UFFD_WP;
+
+	return dstm;
+}
+
 static inline void get_anon_vma(struct anon_vma *anon_vma)
 {
 	atomic_inc(&anon_vma->refcount);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 6e83ce3801b8..61a0c0d4b47d 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2010  Linus Torvalds
  */
 
+#include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
