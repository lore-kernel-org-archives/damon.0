Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABCD5672;
	Wed, 29 Jan 2025 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129961; cv=none; b=bNc6XIr8aKgTLhuOP8KCjeQoI7vu4gUp+7cwHd2g/5uvi3RV7wn3TCZL91FveEYpLIKuHlRIwL/rwc853+KGDfxJuI1L1Tng/BzjyNR1vpAVnioNOFPnOfM6/FUtaSLUzCZAyAWzF/XA5Ervs12B/ItgsBv8V0e+YgOpLBsppXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129961; c=relaxed/simple;
	bh=v7LE9sYlbkZ7sqByzVhsFE5cNYmHMRER5aHjByj/QG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5zF6a//4IssUpxZ54b6Q9xsFnvG7xOnQFhzxhRWBxcggraVgKhkYTbkTBwl4HYxazai30ClL0jVPWmv6waX2qfa8Uwy5dmK2fM1pqAEafCVxBhar0c1h3ABiePCkPkVbqgNMDZYAzkiLETP9R9e6yCrMYxRsARLRZHU+MtsR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf18g+Rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf18g+Rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DCBC4CED3;
	Wed, 29 Jan 2025 05:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738129960;
	bh=v7LE9sYlbkZ7sqByzVhsFE5cNYmHMRER5aHjByj/QG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mf18g+RcPK3KDXW+W+meaDPUQnm7PoKbkZ3X0N3MMjs+tF7qfl8bWllnxHAl/D+i8
	 MpAWyG8iX5ROIyHwnsovSq7BhM2OM9ZZNMmKkD/lImIE/5OIIxoSA8sVuS/MYgQmMC
	 1CF3OXBae6yZEGqelNEFEFZdEYCglbj2dCC/RheNzBjl4FZ0x/s2J3CxTygT1lpCEz
	 mPk4ygvvccgpFSVnVSKBMtjg6IVm4awzRneL+qlF18rLl7v/1zzgErrRj6TUOpcG8a
	 gUeaXCFXGbK50/ih/+iF96tffHT/nNjl1yjd6V42H89N9C5qtf7Yt3mxjS0+IDzPj4
	 NSkMboWfvRbUg==
From: SeongJae Park <sj@kernel.org>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] damon: add feature to monitor only writes
Date: Tue, 28 Jan 2025 21:52:37 -0800
Message-Id: <20250129055237.38547-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129044041.25884-1-pedrodemargomes@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ linux-mm@ and David

Hi Pedro,

On Wed, 29 Jan 2025 01:40:41 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:

> Add damon operation DAMON_OPS_VADDR_WRITES to monitor only writes.

Thank you for this patch!  I think this is a successor of the patch[1] that you
posted before.  Thank you very much for continuing this work.

Nonetheless, could you please add more description about this patch including
changes you made from the previous version?  I'm especially curious if the
concern[2] that David raised to the previous version is solved.  Motivation of
this patch including expected usage (I remeber that you mentioned using this
feature to find KSM-candidate memory regions, but I'm curious if you found more
potential usages) and test/evaluation results if available.

Adding comments below to things that stand out to my eyes on a glance.

[1] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@gmail.com/
[2] https://lore.kernel.org/dcb5d9c7-ae5c-e0c5-adee-37f5b92281e0@redhat.com

> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>  include/linux/damon.h   |   5 +-
>  mm/damon/Makefile       |   2 +-
>  mm/damon/ops-common.c   |  80 +++++
>  mm/damon/ops-common.h   |   3 +
>  mm/damon/sysfs.c        |   1 +
>  mm/damon/vaddr-writes.c | 735 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 824 insertions(+), 2 deletions(-)
>  create mode 100644 mm/damon/vaddr-writes.c
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index af525252b853..9a6027faa7a6 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -485,6 +485,7 @@ struct damos {
>   * enum damon_ops_id - Identifier for each monitoring operations implementation
>   *
>   * @DAMON_OPS_VADDR:	Monitoring operations for virtual address spaces
> + * @DAMON_OPS_VADDR_WRITES: Monitoring only write operations for virtual address spaces
>   * @DAMON_OPS_FVADDR:	Monitoring operations for only fixed ranges of virtual
>   *			address spaces
>   * @DAMON_OPS_PADDR:	Monitoring operations for the physical address space
> @@ -492,6 +493,7 @@ struct damos {
>   */
>  enum damon_ops_id {
>  	DAMON_OPS_VADDR,
> +	DAMON_OPS_VADDR_WRITES,
>  	DAMON_OPS_FVADDR,
>  	DAMON_OPS_PADDR,
>  	NR_DAMON_OPS,
> @@ -846,7 +848,8 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
>  
>  static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  {
> -	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_FVADDR;
> +	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_VADDR_WRITES
> +	 || ctx->ops.id == DAMON_OPS_FVADDR;
>  }
>  
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index 8b49012ba8c3..c3c8dce0b34a 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-y				:= core.o
> -obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
> +obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o vaddr-writes.o
>  obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
>  obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
>  obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d25d99cb5f2b..4a3cad303a60 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -9,6 +9,8 @@
>  #include <linux/page_idle.h>
>  #include <linux/pagemap.h>
>  #include <linux/rmap.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  
>  #include "ops-common.h"
>  
> @@ -67,6 +69,84 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  }
>  
> +static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> +{
> +	struct folio *folio;
> +
> +	if (!pte_write(pte))
> +		return false;
> +	if (!is_cow_mapping(vma->vm_flags))
> +		return false;
> +	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
> +		return false;
> +	folio = vm_normal_folio(vma, addr, pte);
> +	if (!folio)
> +		return false;
> +	return folio_maybe_dma_pinned(folio);
> +}
> +
> +static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> +		unsigned long addr, pmd_t *pmdp)
> +{
> +	pmd_t old, pmd = *pmdp;
> +
> +	if (pmd_present(pmd)) {
> +		/* See comment in change_huge_pmd() */
> +		old = pmdp_invalidate(vma, addr, pmdp);
> +		if (pmd_dirty(old))
> +			pmd = pmd_mkdirty(pmd);
> +		if (pmd_young(old))
> +			pmd = pmd_mkyoung(pmd);
> +
> +		pmd = pmd_wrprotect(pmd);
> +		pmd = pmd_clear_soft_dirty(pmd);
> +
> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> +	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
> +		pmd = pmd_swp_clear_soft_dirty(pmd);
> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> +	}
> +}
> +
> +static inline void clear_soft_dirty(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *pte)
> +{
> +	/*
> +	 * The soft-dirty tracker uses #PF-s to catch writes
> +	 * to pages, so write-protect the pte as well. See the
> +	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
> +	 * of how soft-dirty works.
> +	 */
> +	pte_t ptent = *pte;
> +
> +	if (pte_present(ptent)) {
> +		pte_t old_pte;
> +
> +		if (pte_is_pinned(vma, addr, ptent))
> +			return;
> +		old_pte = ptep_modify_prot_start(vma, addr, pte);
> +		ptent = pte_wrprotect(old_pte);
> +		ptent = pte_clear_soft_dirty(ptent);
> +		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> +	} else if (is_swap_pte(ptent)) {
> +		ptent = pte_swp_clear_soft_dirty(ptent);
> +		set_pte_at(vma->vm_mm, addr, pte, ptent);
> +	}
> +}

Seems you're copying code from task_mmu.c to here.  Can you explain why you do
so instead of making those be able to use from other files and reuse?

> +
> +void damon_pmdp_clean_soft_dirty(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
> +{
> +	if (pmd_soft_dirty(*pmd))
> +		clear_soft_dirty_pmd(vma, addr, pmd);
> +
> +}
> +
> +void damon_ptep_clean_soft_dirty(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
> +{
> +	if (pte_soft_dirty(*pte))
> +		clear_soft_dirty(vma, addr, pte);
> +}

Also, ops-common.c is for code that will be used by two or more DAMON
operations set implementations.  But apparently above code is being used by the
new write-only monitoring operations set.  If I'm not missing something, let's
move the code to vaddr-writes.c file.

> +
>  #define DAMON_MAX_SUBSCORE	(100)
>  #define DAMON_MAX_AGE_IN_LOG	(32)
>  
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 18d837d11bce..cbd35d228f5c 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -12,6 +12,9 @@ struct folio *damon_get_folio(unsigned long pfn);
>  void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
>  void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
>  
> +void damon_ptep_clean_soft_dirty(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
> +void damon_pmdp_clean_soft_dirty(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
> +

Ditto.  I find no reason to have above declarations on ops-common.h.  Please
let me know if I'm missing something.

>  int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s);
>  int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index deeab04d3b46..f01b31f1dfb9 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -625,6 +625,7 @@ static const struct kobj_type damon_sysfs_attrs_ktype = {
>  /* This should match with enum damon_ops_id */
>  static const char * const damon_sysfs_ops_strs[] = {
>  	"vaddr",
> +	"vaddr-writes",
>  	"fvaddr",
>  	"paddr",
>  };
> diff --git a/mm/damon/vaddr-writes.c b/mm/damon/vaddr-writes.c
> new file mode 100644
> index 000000000000..b887a4bc6d11
> --- /dev/null
> +++ b/mm/damon/vaddr-writes.c

Seems you copied vaddr.c to vaddr-write.c, and made changes on the copy.  Looks
like no small amount of code is duplicated here as a result.  What about
implementing vaddr-writes only code on vaddr.c and use the commonly usable
code, like "fvaddr" does?

> @@ -0,0 +1,735 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DAMON Primitives for Virtual Address Spaces
> + *
> + * Author: SeongJae Park <sj@kernel.org>
> + */
> +
> +#define pr_fmt(fmt) "damon-va-writes: " fmt
> +
> +#include <linux/highmem.h>
> +#include <linux/hugetlb.h>
> +#include <linux/mman.h>
> +#include <linux/mmu_notifier.h>
> +#include <linux/page_idle.h>
> +#include <linux/pagewalk.h>
> +#include <linux/sched/mm.h>
> +
> +#include "ops-common.h"
> +
> +#ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
> +#undef DAMON_MIN_REGION
> +#define DAMON_MIN_REGION 1
> +#endif
> +
> +/*
> + * 't->pid' should be the pointer to the relevant 'struct pid' having reference
> + * count.  Caller must put the returned task, unless it is NULL.
> + */
> +static inline struct task_struct *damon_get_task_struct(struct damon_target *t)
> +{
> +	return get_pid_task(t->pid, PIDTYPE_PID);
> +}
> +
> +/*
> + * Get the mm_struct of the given target
> + *
> + * Caller _must_ put the mm_struct after use, unless it is NULL.
> + *
> + * Returns the mm_struct of the target on success, NULL on failure
> + */
> +static struct mm_struct *damon_get_mm(struct damon_target *t)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +
> +	task = damon_get_task_struct(t);
> +	if (!task)
> +		return NULL;
> +
> +	mm = get_task_mm(task);
> +	put_task_struct(task);
> +	return mm;
> +}
> +
> +/*
> + * Functions for the initial monitoring target regions construction
> + */
> +
> +/*
> + * Size-evenly split a region into 'nr_pieces' small regions
> + *
> + * Returns 0 on success, or negative error code otherwise.
> + */
> +static int damon_va_evenly_split_region(struct damon_target *t,
> +		struct damon_region *r, unsigned int nr_pieces)
> +{
> +	unsigned long sz_orig, sz_piece, orig_end;
> +	struct damon_region *n = NULL, *next;
> +	unsigned long start;
> +	unsigned int i;
> +
> +	if (!r || !nr_pieces)
> +		return -EINVAL;
> +
> +	if (nr_pieces == 1)
> +		return 0;
> +
> +	orig_end = r->ar.end;
> +	sz_orig = damon_sz_region(r);
> +	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
> +
> +	if (!sz_piece)
> +		return -EINVAL;
> +
> +	r->ar.end = r->ar.start + sz_piece;
> +	next = damon_next_region(r);
> +	for (start = r->ar.end, i = 1; i < nr_pieces; start += sz_piece, i++) {
> +		n = damon_new_region(start, start + sz_piece);
> +		if (!n)
> +			return -ENOMEM;
> +		damon_insert_region(n, r, next, t);
> +		r = n;
> +	}
> +	/* complement last region for possible rounding error */
> +	if (n)
> +		n->ar.end = orig_end;
> +
> +	return 0;
> +}
> +
> +static unsigned long sz_range(struct damon_addr_range *r)
> +{
> +	return r->end - r->start;
> +}
> +
> +/*
> + * Find three regions separated by two biggest unmapped regions
> + *
> + * vma		the head vma of the target address space
> + * regions	an array of three address ranges that results will be saved
> + *
> + * This function receives an address space and finds three regions in it which
> + * separated by the two biggest unmapped regions in the space.  Please refer to
> + * below comments of '__damon_va_init_regions()' function to know why this is
> + * necessary.
> + *
> + * Returns 0 if success, or negative error code otherwise.
> + */
> +static int __damon_va_three_regions(struct mm_struct *mm,
> +				       struct damon_addr_range regions[3])
> +{
> +	struct damon_addr_range first_gap = {0}, second_gap = {0};
> +	VMA_ITERATOR(vmi, mm, 0);
> +	struct vm_area_struct *vma, *prev = NULL;
> +	unsigned long start;
> +
> +	/*
> +	 * Find the two biggest gaps so that first_gap > second_gap > others.
> +	 * If this is too slow, it can be optimised to examine the maple
> +	 * tree gaps.
> +	 */
> +	rcu_read_lock();
> +	for_each_vma(vmi, vma) {
> +		unsigned long gap;
> +
> +		if (!prev) {
> +			start = vma->vm_start;
> +			goto next;
> +		}
> +		gap = vma->vm_start - prev->vm_end;
> +
> +		if (gap > sz_range(&first_gap)) {
> +			second_gap = first_gap;
> +			first_gap.start = prev->vm_end;
> +			first_gap.end = vma->vm_start;
> +		} else if (gap > sz_range(&second_gap)) {
> +			second_gap.start = prev->vm_end;
> +			second_gap.end = vma->vm_start;
> +		}
> +next:
> +		prev = vma;
> +	}
> +	rcu_read_unlock();
> +
> +	if (!sz_range(&second_gap) || !sz_range(&first_gap))
> +		return -EINVAL;
> +
> +	/* Sort the two biggest gaps by address */
> +	if (first_gap.start > second_gap.start)
> +		swap(first_gap, second_gap);
> +
> +	/* Store the result */
> +	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
> +	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION);
> +	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION);
> +	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION);
> +	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION);
> +	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION);
> +
> +	return 0;
> +}
> +
> +/*
> + * Get the three regions in the given target (task)
> + *
> + * Returns 0 on success, negative error code otherwise.
> + */
> +static int damon_va_three_regions(struct damon_target *t,
> +				struct damon_addr_range regions[3])
> +{
> +	struct mm_struct *mm;
> +	int rc;
> +
> +	mm = damon_get_mm(t);
> +	if (!mm)
> +		return -EINVAL;
> +
> +	mmap_read_lock(mm);
> +	rc = __damon_va_three_regions(mm, regions);
> +	mmap_read_unlock(mm);
> +
> +	mmput(mm);
> +	return rc;
> +}
> +
> +/*
> + * Initialize the monitoring target regions for the given target (task)
> + *
> + * t	the given target
> + *
> + * Because only a number of small portions of the entire address space
> + * is actually mapped to the memory and accessed, monitoring the unmapped
> + * regions is wasteful.  That said, because we can deal with small noises,
> + * tracking every mapping is not strictly required but could even incur a high
> + * overhead if the mapping frequently changes or the number of mappings is
> + * high.  The adaptive regions adjustment mechanism will further help to deal
> + * with the noise by simply identifying the unmapped areas as a region that
> + * has no access.  Moreover, applying the real mappings that would have many
> + * unmapped areas inside will make the adaptive mechanism quite complex.  That
> + * said, too huge unmapped areas inside the monitoring target should be removed
> + * to not take the time for the adaptive mechanism.
> + *
> + * For the reason, we convert the complex mappings to three distinct regions
> + * that cover every mapped area of the address space.  Also the two gaps
> + * between the three regions are the two biggest unmapped areas in the given
> + * address space.  In detail, this function first identifies the start and the
> + * end of the mappings and the two biggest unmapped areas of the address space.
> + * Then, it constructs the three regions as below:
> + *
> + *     [mappings[0]->start, big_two_unmapped_areas[0]->start)
> + *     [big_two_unmapped_areas[0]->end, big_two_unmapped_areas[1]->start)
> + *     [big_two_unmapped_areas[1]->end, mappings[nr_mappings - 1]->end)
> + *
> + * As usual memory map of processes is as below, the gap between the heap and
> + * the uppermost mmap()-ed region, and the gap between the lowermost mmap()-ed
> + * region and the stack will be two biggest unmapped regions.  Because these
> + * gaps are exceptionally huge areas in usual address space, excluding these
> + * two biggest unmapped regions will be sufficient to make a trade-off.
> + *
> + *   <heap>
> + *   <BIG UNMAPPED REGION 1>
> + *   <uppermost mmap()-ed region>
> + *   (other mmap()-ed regions and small unmapped regions)
> + *   <lowermost mmap()-ed region>
> + *   <BIG UNMAPPED REGION 2>
> + *   <stack>
> + */
> +static void __damon_va_init_regions(struct damon_ctx *ctx,
> +				     struct damon_target *t)
> +{
> +	struct damon_target *ti;
> +	struct damon_region *r;
> +	struct damon_addr_range regions[3];
> +	unsigned long sz = 0, nr_pieces;
> +	int i, tidx = 0;
> +
> +	if (damon_va_three_regions(t, regions)) {
> +		damon_for_each_target(ti, ctx) {
> +			if (ti == t)
> +				break;
> +			tidx++;
> +		}
> +		pr_debug("Failed to get three regions of %dth target\n", tidx);
> +		return;
> +	}
> +
> +	for (i = 0; i < 3; i++)
> +		sz += regions[i].end - regions[i].start;
> +	if (ctx->attrs.min_nr_regions)
> +		sz /= ctx->attrs.min_nr_regions;
> +	if (sz < DAMON_MIN_REGION)
> +		sz = DAMON_MIN_REGION;
> +
> +	/* Set the initial three regions of the target */
> +	for (i = 0; i < 3; i++) {
> +		r = damon_new_region(regions[i].start, regions[i].end);
> +		if (!r) {
> +			pr_err("%d'th init region creation failed\n", i);
> +			return;
> +		}
> +		damon_add_region(r, t);
> +
> +		nr_pieces = (regions[i].end - regions[i].start) / sz;
> +		damon_va_evenly_split_region(t, r, nr_pieces);
> +	}
> +}
> +
> +/* Initialize '->regions_list' of every target (task) */
> +static void damon_va_init(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, ctx) {
> +		/* the user may set the target regions as they want */
> +		if (!damon_nr_regions(t))
> +			__damon_va_init_regions(ctx, t);
> +	}
> +}
> +
> +/*
> + * Update regions for current memory mappings
> + */
> +static void damon_va_update(struct damon_ctx *ctx)
> +{
> +	struct damon_addr_range three_regions[3];
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, ctx) {
> +		if (damon_va_three_regions(t, three_regions))
> +			continue;
> +		damon_set_regions(t, three_regions, 3);
> +	}
> +}
> +
> +static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t *pte;
> +	pmd_t pmde;
> +	spinlock_t *ptl;
> +
> +	if (pmd_trans_huge(pmdp_get(pmd))) {
> +		ptl = pmd_lock(walk->mm, pmd);
> +		pmde = pmdp_get(pmd);
> +
> +		if (!pmd_present(pmde)) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
> +		if (pmd_trans_huge(pmde)) {
> +			// damon_pmdp_mkold(pmd, walk->vma, addr);

Maybe you forgot erasing above comment before sending patch?

> +			damon_pmdp_clean_soft_dirty(pmd, walk->vma, addr);
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +		spin_unlock(ptl);
> +	}
> +
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +	if (!pte_present(ptep_get(pte)))
> +		goto out;
> +	// damon_ptep_mkold(pte, walk->vma, addr);

Ditto.

> +	damon_ptep_clean_soft_dirty(pte, walk->vma, addr);
> +out:
> +	pte_unmap_unlock(pte, ptl);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
> +				struct vm_area_struct *vma, unsigned long addr)
> +{
> +	bool referenced = false;
> +	pte_t entry = huge_ptep_get(mm, addr, pte);
> +	struct folio *folio = pfn_folio(pte_pfn(entry));
> +	unsigned long psize = huge_page_size(hstate_vma(vma));
> +
> +	folio_get(folio);
> +
> +	if (pte_young(entry)) {
> +		referenced = true;
> +		entry = pte_mkold(entry);
> +		set_huge_pte_at(mm, addr, pte, entry, psize);
> +	}
> +
> +	if (mmu_notifier_clear_young(mm, addr,
> +				     addr + huge_page_size(hstate_vma(vma))))
> +		referenced = true;
> +
> +	if (referenced)
> +		folio_set_young(folio);
> +
> +	folio_set_idle(folio);
> +	folio_put(folio);
> +}
> +
> +static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
> +				     unsigned long addr, unsigned long end,
> +				     struct mm_walk *walk)
> +{
> +	struct hstate *h = hstate_vma(walk->vma);
> +	spinlock_t *ptl;
> +	pte_t entry;
> +
> +	ptl = huge_pte_lock(h, walk->mm, pte);
> +	entry = huge_ptep_get(walk->mm, addr, pte);
> +	if (!pte_present(entry))
> +		goto out;
> +
> +	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
> +
> +out:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_mkold_hugetlb_entry NULL
> +#endif /* CONFIG_HUGETLB_PAGE */
> +
> +static const struct mm_walk_ops damon_mkold_ops = {
> +	.pmd_entry = damon_mkold_pmd_entry,
> +	// .hugetlb_entry = damon_mkold_hugetlb_entry,
> +	.walk_lock = PGWALK_RDLOCK,
> +};
> +
> +static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> +{
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
> +	mmap_read_unlock(mm);
> +}
> +
> +/*
> + * Functions for the access checking of the regions
> + */
> +
> +static void __damon_va_prepare_access_check(struct mm_struct *mm,
> +					struct damon_region *r)
> +{
> +	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
> +
> +	damon_va_mkold(mm, r->sampling_addr);
> +}
> +
> +static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct mm_struct *mm;
> +	struct damon_region *r;
> +
> +	damon_for_each_target(t, ctx) {
> +		mm = damon_get_mm(t);
> +		if (!mm)
> +			continue;
> +		damon_for_each_region(r, t)
> +			__damon_va_prepare_access_check(mm, r);
> +		mmput(mm);
> +	}
> +}
> +
> +struct damon_young_walk_private {
> +	/* size of the folio for the access checked virtual memory address */
> +	unsigned long *folio_sz;
> +	bool young;
> +};
> +
> +static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t *pte;
> +	pte_t ptent;
> +	spinlock_t *ptl;
> +	struct folio *folio;
> +	struct damon_young_walk_private *priv = walk->private;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (pmd_trans_huge(pmdp_get(pmd))) {
> +		pmd_t pmde;
> +
> +		ptl = pmd_lock(walk->mm, pmd);
> +		pmde = pmdp_get(pmd);
> +
> +		if (!pmd_present(pmde)) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
> +		if (!pmd_trans_huge(pmde)) {
> +			spin_unlock(ptl);
> +			goto regular_page;
> +		}
> +		folio = damon_get_folio(pmd_pfn(pmde));
> +		if (!folio)
> +			goto huge_out;
> +		if (pmd_soft_dirty(pmde))
> +			priv->young = true;
> +		*priv->folio_sz = HPAGE_PMD_SIZE;
> +		folio_put(folio);
> +huge_out:
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +regular_page:
> +#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +	ptent = ptep_get(pte);
> +	if (!pte_present(ptent))
> +		goto out;
> +	folio = damon_get_folio(pte_pfn(ptent));
> +	if (!folio)
> +		goto out;
> +	if (pte_soft_dirty(ptent))
> +		priv->young = true;
> +	*priv->folio_sz = folio_size(folio);
> +	folio_put(folio);
> +out:
> +	pte_unmap_unlock(pte, ptl);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
> +				     unsigned long addr, unsigned long end,
> +				     struct mm_walk *walk)
> +{
> +	struct damon_young_walk_private *priv = walk->private;
> +	struct hstate *h = hstate_vma(walk->vma);
> +	struct folio *folio;
> +	spinlock_t *ptl;
> +	pte_t entry;
> +
> +	ptl = huge_pte_lock(h, walk->mm, pte);
> +	entry = huge_ptep_get(walk->mm, addr, pte);
> +	if (!pte_present(entry))
> +		goto out;
> +
> +	folio = pfn_folio(pte_pfn(entry));
> +	folio_get(folio);
> +
> +	if (pte_young(entry) || !folio_test_idle(folio) ||
> +	    mmu_notifier_test_young(walk->mm, addr))
> +		priv->young = true;
> +	*priv->folio_sz = huge_page_size(h);
> +
> +	folio_put(folio);
> +
> +out:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_young_hugetlb_entry NULL
> +#endif /* CONFIG_HUGETLB_PAGE */
> +
> +static const struct mm_walk_ops damon_young_ops = {
> +	.pmd_entry = damon_young_pmd_entry,
> +	.hugetlb_entry = damon_young_hugetlb_entry,
> +	.walk_lock = PGWALK_RDLOCK,
> +};
> +
> +static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> +		unsigned long *folio_sz)
> +{
> +	struct damon_young_walk_private arg = {
> +		.folio_sz = folio_sz,
> +		.young = false,
> +	};
> +
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
> +	mmap_read_unlock(mm);
> +	return arg.young;
> +}
> +
> +/*
> + * Check whether the region was accessed after the last preparation
> + *
> + * mm	'mm_struct' for the given virtual address space
> + * r	the region to be checked
> + */
> +static void __damon_va_check_access(struct mm_struct *mm,
> +				struct damon_region *r, bool same_target,
> +				struct damon_attrs *attrs)
> +{
> +	static unsigned long last_addr;
> +	static unsigned long last_folio_sz = PAGE_SIZE;
> +	static bool last_accessed;
> +
> +	if (!mm) {
> +		damon_update_region_access_rate(r, false, attrs);
> +		return;
> +	}
> +
> +	/* If the region is in the last checked page, reuse the result */
> +	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
> +				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
> +		damon_update_region_access_rate(r, last_accessed, attrs);
> +		return;
> +	}
> +
> +	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
> +	damon_update_region_access_rate(r, last_accessed, attrs);
> +
> +	last_addr = r->sampling_addr;
> +}
> +
> +static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct mm_struct *mm;
> +	struct damon_region *r;
> +	unsigned int max_nr_accesses = 0;
> +	bool same_target;
> +
> +	damon_for_each_target(t, ctx) {
> +		mm = damon_get_mm(t);
> +		same_target = false;
> +		damon_for_each_region(r, t) {
> +			__damon_va_check_access(mm, r, same_target,
> +					&ctx->attrs);
> +			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
> +			same_target = true;
> +		}
> +		if (mm)
> +			mmput(mm);
> +	}
> +
> +	return max_nr_accesses;
> +}
> +
> +/*
> + * Functions for the target validity check and cleanup
> + */
> +
> +static bool damon_va_target_valid(struct damon_target *t)
> +{
> +	struct task_struct *task;
> +
> +	task = damon_get_task_struct(t);
> +	if (task) {
> +		put_task_struct(task);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +#ifndef CONFIG_ADVISE_SYSCALLS
> +static unsigned long damos_madvise(struct damon_target *target,
> +		struct damon_region *r, int behavior)
> +{
> +	return 0;
> +}
> +#else
> +static unsigned long damos_madvise(struct damon_target *target,
> +		struct damon_region *r, int behavior)
> +{
> +	struct mm_struct *mm;
> +	unsigned long start = PAGE_ALIGN(r->ar.start);
> +	unsigned long len = PAGE_ALIGN(damon_sz_region(r));
> +	unsigned long applied;
> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	applied = do_madvise(mm, start, len, behavior) ? 0 : len;
> +	mmput(mm);
> +
> +	return applied;
> +}
> +#endif	/* CONFIG_ADVISE_SYSCALLS */
> +
> +static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> +		struct damon_target *t, struct damon_region *r,
> +		struct damos *scheme)
> +{
> +	int madv_action;
> +
> +	switch (scheme->action) {
> +	case DAMOS_WILLNEED:
> +		madv_action = MADV_WILLNEED;
> +		break;
> +	case DAMOS_COLD:
> +		madv_action = MADV_COLD;
> +		break;
> +	case DAMOS_PAGEOUT:
> +		madv_action = MADV_PAGEOUT;
> +		break;
> +	case DAMOS_HUGEPAGE:
> +		madv_action = MADV_HUGEPAGE;
> +		break;
> +	case DAMOS_NOHUGEPAGE:
> +		madv_action = MADV_NOHUGEPAGE;
> +		break;
> +	case DAMOS_STAT:
> +		return 0;
> +	default:
> +		/*
> +		 * DAMOS actions that are not yet supported by 'vaddr'.
> +		 */
> +		return 0;
> +	}
> +
> +	return damos_madvise(t, r, madv_action);
> +}
> +
> +static int damon_va_scheme_score(struct damon_ctx *context,
> +		struct damon_target *t, struct damon_region *r,
> +		struct damos *scheme)
> +{
> +
> +	switch (scheme->action) {
> +	case DAMOS_PAGEOUT:
> +		return damon_cold_score(context, r, scheme);
> +	default:
> +		break;
> +	}
> +
> +	return DAMOS_MAX_SCORE;
> +}
> +
> +static int __init damon_va_initcall(void)
> +{
> +	struct damon_operations ops = {
> +		.id = DAMON_OPS_VADDR_WRITES,
> +		.init = damon_va_init,
> +		.update = damon_va_update,
> +		.prepare_access_checks = damon_va_prepare_access_checks,
> +		.check_accesses = damon_va_check_accesses,
> +		.reset_aggregated = NULL,
> +		.target_valid = damon_va_target_valid,
> +		.cleanup = NULL,
> +		.apply_scheme = damon_va_apply_scheme,
> +		.get_scheme_score = damon_va_scheme_score,
> +	};
> +	/* ops for fixed virtual address ranges */
> +	struct damon_operations ops_fvaddr = ops;
> +	int err;
> +
> +	/* Don't set the monitoring target regions for the entire mapping */
> +	ops_fvaddr.id = DAMON_OPS_FVADDR;
> +	ops_fvaddr.init = NULL;
> +	ops_fvaddr.update = NULL;
> +
> +	err = damon_register_ops(&ops);
> +	if (err)
> +		return err;
> +	return damon_register_ops(&ops_fvaddr);
> +};
> +
> +subsys_initcall(damon_va_initcall);
> +
> +#include "tests/vaddr-kunit.h"

My impression after my humble glance on this patch is that there are many
grateful rooms to improve on this patch.  If your intention of this patch is
not to be merged as is but for requesting comments to an early version of the
work, please remember that 'RFC' is a nice tag for the purpose.


Thanks,
SJ

> -- 
> 2.30.2
