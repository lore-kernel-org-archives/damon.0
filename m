Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03993C0624;
	Thu, 23 Apr 2026 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912507; cv=none; b=apuwV56Pi3WpeFsgnN3oSvMnresx/Q+I4oS154ERIIUupQAlj6a2G9mD2XqDOmIZcPrnE6pKLRkWdEMhr6jETE1e3vbbjUpkRpr2lFw2oR3yvazk9AQ8RjWHmX7IKEkxtONoaDnMe+obJu+StoCXlsU9eiW9GwmzScFY2y5l2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912507; c=relaxed/simple;
	bh=9yIVu6g6M2EL/rmu+h4SZZ1y0X+O8GibxnzxFEVi6yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPhzdplGT3Z6fD77jRDuU6Ij9eyeXUWo8GTXqCjFLQBA0TSOO3Ep/KrctIe2g+lppE++qhSsveLGIMp5KVwuCZF01Hx7rC3zZRzJyMpMNChy///2RAtpqJ/Qp9VwTCW8Qsp3cBDW+Szsp4eybVjMZeQhaY2xP8qLYxCxpZESfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh42QE6v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh42QE6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B1C19425;
	Thu, 23 Apr 2026 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776912507;
	bh=9yIVu6g6M2EL/rmu+h4SZZ1y0X+O8GibxnzxFEVi6yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fh42QE6vZ8jeEadoIu+cCyQfBPyh2DroeqM3NbPErsz37rjl2gXpTfCBhqRq+H3V3
	 BZMNLZpxIpFU/lRTFYoSdwx92n8AJ4JOPRKy7JpYJW5OHbITJk7BeDKJa4TCvkKPHx
	 2vzJnCZLa/JHEPFjWkxufkOurHET4b84GIvIlSB4JshsP7XuMXhqfHjO0Lleww1aYH
	 +GsxMdt70iideANgtVib8TgBU5eS3z10xE5Bb+xAt21NrGZG3SI/N6MIa1q/WBUl0l
	 jij3KJzDcX+/OxrpU3MS9HQY+8YfpOy0p9bW3IvqrLK5OWc/QePftZBfgzx6FcFonq
	 XbQGqb1OlGkZA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/4] mm/damon/vaddr: support perf event based
 access check
Reply-To: sashiko@lists.linux.dev
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260423004211.7037-4-akinobu.mita@gmail.com>
References: <20260423004211.7037-4-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 02:48:26 +0000
Message-Id: <20260423024827.498B1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 13 potential issue(s):
- [Critical] Compilation Failure: Use of undefined API `kmalloc_obj()`.
- [Critical] Compilation Failure: Non-existent field `sample_phys_addr` in =
`perf_event_attr`.
- [Critical] Compilation Failure: Typo in the `CONFIG_HUGETLB_PAGE` fallbac=
k macro.
- [High] Deadlock Risk: Recursive acquisition of `mmap_read_lock`.
- [High] Infinite Loop: Returning `ACTION_AGAIN` on `pte_offset_map_lock()`=
 failure.
- [High] Memory Leak: `damon_vaddr_histogram_per_target` structs are never =
freed.
- [High] Memory Leak: Dynamically allocated `buffer->reports` arrays are or=
phaned.
- [High] Memory Leak: Orphaned `perf` structs when the `kdamond` thread is =
restarted.
- [High] Data Truncation: 64-bit physical addresses are silently truncated =
when used as xarray indices on 32-bit platforms.
- [High] Logic Error: Unbounded perf events for physical memory targets (`D=
AMON_OPS_PADDR`).
- [High] Logic Error: Invalid PFN extraction from non-present PMD migration=
 entries.
- [High] Severe Performance Flaw: Full page table walks per sampling interv=
al.
- [High] Severe Performance Flaw: O(N) iteration by `PAGE_SIZE` over massiv=
e virtual memory regions.
--

commit 04697c66c594dde51627f9cdaf4c7d11b08fe1fe
Author: Akinobu Mita <akinobu.mita@gmail.com>

mm/damon/vaddr: support perf event based access check

This commit introduces a mechanism to use perf events for virtual and
physical address space monitoring in DAMON. It buffers perf samples during
the sampling interval and generates a histogram of memory accesses. During
the access check phase, this histogram is used to update the access counts
for each monitoring target region.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3014,6 +3014,40 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
>  	}
>  }

When the kdamond thread begins, kdamond_init_ctx() unconditionally initiali=
zes
the perf events. If a user stops and restarts the thread via sysfs, does th=
is
leak the previous allocations? Calling damon_perf_init() again would alloca=
te
new perf structures, hardware counters, and per-CPU buffers, permanently
leaking the previous ones.

> +static void kdamond_prepare_perf_event_report(struct damon_ctx *ctx)
> +{
> +	struct damon_perf_event *event;
> +
> +	list_for_each_entry(event, &ctx->perf_events, list)
> +		damon_perf_prepare_access_checks(ctx, event);
> +}
> +
> +static unsigned int kdamond_check_perf_event_reported_accesses(struct da=
mon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct damon_perf_event *event;
> +	unsigned int max_nr_accesses =3D 0;
> +
> +	if (damon_target_has_pid(ctx)) {
> +		list_for_each_entry(event, &ctx->perf_events, list)
> +			damon_va_perf_check_accesses(ctx, event);
> +	}

For physical memory targets (which have no PIDs), the processing code inside
this if block is skipped. However, kdamond_prepare_perf_event_report()
unconditionally enables perf events. Does this leave perf events permanently
enabled and continuously firing for physical memory targets?

[ ... ]
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> +static void damon_vaddr_histogram_add(struct damon_vaddr_histogram *hist=
ogram, u32 pid,
> +						u64 vaddr)
> +{
> +	struct damon_vaddr_histogram_per_target *target;
> +	unsigned long nr_accesses;
> +
> +	while (!(target =3D xa_load(&histogram->targets, pid))) {
> +		target =3D kmalloc_obj(*target);

Can this code compile? There is no kmalloc_obj() macro or function in the
Linux kernel. A standard kmalloc() could be used instead:

target =3D kmalloc(sizeof(*target), GFP_KERNEL);

[ ... ]
> +static void damon_vaddr_histogram_destroy(struct damon_vaddr_histogram *=
histogram)
> +{
> +	unsigned long index;
> +	struct damon_vaddr_histogram_per_target *target;
> +
> +	xa_for_each(&histogram->targets, index, target)
> +		xa_destroy(&target->accesses);

Does this code leak the damon_vaddr_histogram_per_target structure? The nes=
ted
accesses xarray is destroyed via xa_destroy(), but the target struct itself=
 is
not freed with kfree().

> +	xa_destroy(&histogram->targets);
> +}
[ ... ]
> +static void damon_va_perf_check_accesses_by_vaddr(struct damon_ctx *ctx,
> +		struct damon_perf_event *event)
> +{
[ ... ]
> +		if ((count =3D=3D buffer->size - 1) && (buffer->size < DAMON_PERF_MAX_=
RECORDS)) {
> +			void *new_reports =3D kvcalloc_node(buffer->size * 2,
> +					sizeof(buffer->reports[0]), GFP_KERNEL,
> +					cpu_to_node(cpu));

Are these dynamically allocated buffer->reports arrays freed during cleanup?
When perf monitoring stops, damon_perf_cleanup() frees the top-level per-CPU
pointer wrapper but appears to orphan these inner reports arrays.

[ ... ]
> +	damon_for_each_target(t, ctx) {
> +		struct damon_region *r;
> +		u32 pid =3D pid_nr(t->pid);
> +
> +		damon_for_each_region(r, t) {
> +			unsigned long addr;
> +
> +			if (r->access_reported)
> +				continue;
> +
> +			for (addr =3D r->ar.start; addr < r->ar.end; addr +=3D PAGE_SIZE) {

Can this loop stall the kernel thread? Since DAMON regions can merge to
encompass hundreds of gigabytes, iterating from r->ar.start to r->ar.end by
PAGE_SIZE could result in hundreds of millions of iterations per interval.
Could this logic iterate over the populated xarray entries instead?

> +				if (damon_vaddr_histogram_count(&perf->vaddr_histogram, pid,
> +									addr & PAGE_MASK)) {
> +					damon_update_region_access_rate(r, true, &ctx->attrs);
> +					r->access_reported =3D true;
> +					break;
> +				}
> +			}
> +		}
> +		tidx++;
> +	}
[ ... ]
> +static void damon_va_perf_check_accesses_by_paddr(struct damon_ctx *ctx,
> +		struct damon_perf_event *event)
> +{
[ ... ]
> +	damon_for_each_target(t, ctx) {
> +		struct damon_region *r;
> +		struct mm_struct *mm =3D damon_get_mm(t);
> +
> +		if (!mm)
> +			continue;
> +
> +		mmap_read_lock(mm);
> +		damon_for_each_region(r, t) {
> +			struct damon_paddr_walk walk_private =3D {
> +				.histogram =3D &perf->paddr_histogram,
> +				.accessed =3D false,
> +			};
> +
> +			if (r->access_reported)
> +				continue;
> +
> +			walk_page_range(mm, r->ar.start, r->ar.end, &damon_paddr_ops,
> +					&walk_private);

Can this sequence cause a recursive read lock deadlock? The mmap_read_lock =
is
acquired directly, but damon_paddr_ops is configured with
.walk_lock =3D PGWALK_RDLOCK, which instructs the page walker to also acqui=
re
the mmap_read_lock. If a writer is pending, the second read lock will block
and self-deadlock.

Is it too expensive to call walk_page_range() across the target's entire
mapped virtual memory space on every sampling interval? For large memory
footprints, walking millions of page table entries every few milliseconds
could create severe CPU overhead and defeat the adaptive sampling design.

> +			if (walk_private.accessed) {
> +				damon_update_region_access_rate(r, true, &ctx->attrs);
> +				r->access_reported =3D true;
> +			}
> +		}
> +		mmap_read_unlock(mm);
> +		mmput(mm);
> +		tidx++;
> +	}
> +
> +	damon_paddr_histogram_destroy(&perf->paddr_histogram);
> +}
> +
> +void damon_va_perf_check_accesses(struct damon_ctx *ctx, struct damon_pe=
rf_event *event)
> +{
> +	if (event->attr.sample_phys_addr)

Does struct perf_event_attr contain a sample_phys_addr field? Physical
address sampling is typically requested by setting the PERF_SAMPLE_PHYS_ADDR
flag in the sample_type bitmask.

> +		return damon_va_perf_check_accesses_by_paddr(ctx, event);
> +	else
> +		return damon_va_perf_check_accesses_by_vaddr(ctx, event);
> +}
[ ... ]
> +static void damon_paddr_histogram_add(struct damon_paddr_histogram *hist=
ogram,
> +						u64 paddr)
> +{
> +	unsigned long nr_accesses;
> +
> +	nr_accesses =3D xa_to_value(xa_load(&histogram->accesses, paddr));
> +	xa_store(&histogram->accesses, paddr, xa_mk_value(nr_accesses + 1), GFP=
_KERNEL);

Can this silently truncate physical addresses on 32-bit platforms? The paddr
argument is a u64, but it is passed directly as the index to xa_load() and
xa_store(), which take an unsigned long. On 32-bit systems with PAE/LPAE,
this will drop the upper 32 bits. Could the physical address be shifted by
PAGE_SHIFT to store the PFN instead?

> +}
[ ... ]
> +static int damon_paddr_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +	struct damon_paddr_walk *paddr_walk =3D walk->private;
> +
> +	ptl =3D pmd_trans_huge_lock(pmd, walk->vma);
> +	if (ptl) {
> +		pmd_t pmde =3D pmdp_get(pmd);
> +
> +		if (pmd_present(pmde)) {
> +			for (; addr < next && !paddr_walk->accessed; addr +=3D PAGE_SIZE) {
> +				u64 frame =3D pmd_pfn(pmde) +

Can pmd_present() evaluate to true for non-present leaf entries like migrat=
ion
entries? Extracting the PFN via pmd_pfn() on a migration entry would treat
swap offset metadata as a physical address, resulting in invalid calculatio=
ns.
Does this code need to verify the PMD is a valid THP first?

> +					((addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT);
> +
> +				if (damon_paddr_histogram_count(paddr_walk->histogram,
> +						PFN_PHYS(frame))) {
> +					paddr_walk->accessed =3D true;
> +					break;
> +				}
> +			}
> +		}
> +		spin_unlock(ptl);
> +		return paddr_walk->accessed ? 1 : 0;
> +	}
> +
> +	pte =3D pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte) {
> +		walk->action =3D ACTION_AGAIN;
> +		return 0;

Will setting walk->action =3D ACTION_AGAIN on a pte_offset_map_lock() failu=
re
cause an infinite loop? Migration entries cause this lock to return NULL
non-transiently, meaning the page walker will continually retry the exact s=
ame
PMD without making progress. Returning 0 without ACTION_AGAIN skips it
gracefully.

> +	}
[ ... ]
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int damon_paddr_hugetlb_entry(pte_t *pte, unsigned long hmask,
[ ... ]
> +	return paddr_walk->accessed ? 1 : 0;
> +}
> +#else
> +#define damon_perf_hugetlb_entry NULL
> +#endif /* CONFIG_HUGETLB_PAGE */
> +
> +static const struct mm_walk_ops damon_paddr_ops =3D {
> +	.pmd_entry =3D damon_paddr_pmd_entry,
> +	.hugetlb_entry =3D damon_paddr_hugetlb_entry,

Does this cause a compilation failure when CONFIG_HUGETLB_PAGE is disabled?
The fallback macro is defined as damon_perf_hugetlb_entry, but the struct
initializes .hugetlb_entry with damon_paddr_hugetlb_entry, leaving it
undeclared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423004211.7037=
-1-akinobu.mita@gmail.com?part=3D3
