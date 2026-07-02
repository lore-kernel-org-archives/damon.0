Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FC29DB6C
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986920; cv=none; b=jYyK/kkA0u7c4ZBnaqWNaQ61ZZXVso86b6XUuzP/yJ13Cp0pLGE+1L6GmratzxlcoebAkt8eFPEUUGeCEyzSajsqQ5HMPcD5Lx8pBN3+4dDrDzP63b01LE2jPhcLEbRwpIDp5FejJnfyhUziqFWvrFK7004x+2vHVCKwwJid6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986920; c=relaxed/simple;
	bh=txAwc/uMOV2qvPm8OmB2/fPHpE3PNK7q8P2GI8PvKGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3tDz3MnnQCaK0w/8vFoGTdLojcDgboQjlg+9oc+NnbfR8fVAk5nNIj1oR3m4hmoqQ62ovv/rryOdKzJduke33g0LH9ibIYXHNM0IXYXyuduMHLXpBjeiKyrxGHymkoe8x9pIL/OrULUywPo/zpSrYGLdjHK7ftZi3tEPPNxLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlP62zCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlP62zCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5B91F000E9;
	Thu,  2 Jul 2026 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986918;
	bh=nG32Ep39NE3bEXLqIsVHRbVFDcO9BtcXBt41vaoEtDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OlP62zCHxFiX8FR9+yIJU48LN3mURmOmKhm1gyc22L3Vail//2QxumA/glCeWg7jv
	 Hcd5Q8LtwqYrSEaZ07b8ujrSBLrYLHTcE4zDlbKJ2Dz6rJ+GkxDrINiIy7CqE+iH7E
	 YpMH90kkOIQQsbe8TOnZLJQ//adIDvdjB00qavpvWTqaxTvRLVJ8LI0B5lkh+jGZkn
	 8vly0Kugy4mluTZr8OClJApR0os/xYWAja6CWAb0bborf+NpuQW6xUoPJ6NZPKN3Vo
	 XjkoKiL6lb2b16OQ3VtKie1vWEXbRBziVH7vxanvpq229gzqluwBWF6QPSewUBAOmF
	 WY9mt8AORVA5w==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add
 damon_collapse_folio_range() for external callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702095227.75866-3-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
 <20260702095227.75866-3-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:08:37 +0000
Message-Id: <20260702100838.6E5B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `damon_collapse_folio_range()` passes an uninitialized `struct col=
lapse_control` to `collapse_huge_page()`, leaving fields like `node_load` a=
nd `alloc_nmask` with heap garbage, potentially corrupting NUMA node target=
ing during THP allocation.
- [High] Bypassing the read-only page table validation scan forces destruct=
ive PMD operations on un-collapsible memory ranges, creating a severe perfo=
rmance degradation vector.
- [Medium] `damon_collapse_folio_range()` silently fails to collapse file-b=
acked memory ranges because it routes directly to the anonymous-only `colla=
pse_huge_page()` function.
- [Medium] `damon_collapse_folio_range()` hardcodes the `unmapped` paramete=
r to 0, which prevents the collapse operation from succeeding if there are =
any swapped-out pages in the PMD range.
--

commit e521d85e0499be054d0c31614f15b39332af3c13
Author: Lian Wang <lianux.mm@gmail.com>

mm/khugepaged: add damon_collapse_folio_range() for external callers

This commit introduces damon_collapse_folio_range(), providing a wrapper
around khugepaged's collapse_huge_page() for external subsystems like DAMON.
It allows targeted THP collapse on specific address ranges but is currently
limited to PMD order.

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 617bca76db49b..7fe9ce1e05335 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c

[ ... ]

> @@ -3272,3 +3272,49 @@ int madvise_collapse(struct vm_area_struct *vma, u=
nsigned long start,
>  	return thps =3D=3D ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
>  			: madvise_collapse_errno(last_fail);
>  }
> +
> +/**
> + * damon_collapse_folio_range() - Collapse base pages in range into a THP
> + * @mm:         mm_struct of the target process
> + * @start_addr: start address (must be order-aligned)
> + * @target_order: page order of the collapse result (currently only
> + *                HPAGE_PMD_ORDER is supported)
> + *
> + * Thin wrapper around collapse_huge_page() for external callers such as
> + * DAMON.  The caller must hold a reference to @mm.  Do not hold mmap
> + * lock: collapse_huge_page() acquires mmap_read_lock for validation,
> + * releases it, then acquires mmap_write_lock for the collapse.  Holding
> + * an outer mmap_read_lock would self-deadlock.
> + *
> + * Return: 0 on success, -EINVAL on bad arguments, negative error from
> + *         madvise_collapse_errno() otherwise.
> + */
> +int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start=
_addr,
> +			       unsigned int target_order)
> +{
> +	struct collapse_control *cc;
> +	enum scan_result result;
> +
> +	if (target_order !=3D HPAGE_PMD_ORDER) {
> +		pr_warn_once("%s: only PMD order (%u) is supported, got %u\n",
> +			     __func__, HPAGE_PMD_ORDER, target_order);
> +		return -EINVAL;
> +	}
> +	if (start_addr & ((PAGE_SIZE << target_order) - 1))
> +		return -EINVAL;
> +
> +	cc =3D kmalloc_obj(*cc);

[Severity: High]
Does this leave the collapse_control struct uninitialized?

When collapse_huge_page() eventually calls alloc_charge_folio(), it uses
collapse_find_target_node(). This function iterates over cc->node_load and
reads/writes cc->alloc_nmask:

collapse_find_target_node()
   ...
   node_set(nid, cc->alloc_nmask);

Since kmalloc_obj() does not zero memory, wouldn't this pass heap garbage
to the folio allocator and corrupt NUMA node targeting?

> +	if (!cc)
> +		return -ENOMEM;
> +	cc->is_khugepaged =3D false;
> +	cc->progress =3D 0;
> +
> +	lru_add_drain_all();
> +
> +	result =3D collapse_huge_page(mm, start_addr, 1, 0, cc, target_order);

[Severity: Medium]
Does this silently fail for file-backed memory regions?

By calling collapse_huge_page() directly instead of the dispatcher
collapse_single_pmd(), the flow reaches hugepage_vma_revalidate() with
expect_anon hardcoded to true:

hugepage_vma_revalidate()
    if (expect_anon && !vma_is_anonymous(vma))
        return SCAN_PAGE_ANON;

Wouldn't this unconditionally reject shmem/tmpfs mappings targeted by DAMON?

[Severity: Medium]
By passing 0 for the unmapped parameter here, does this prevent the collapse
operation if any pages are swapped out?

Because unmapped is 0, collapse_huge_page() skips
__collapse_huge_page_swapin(). Then, when __collapse_huge_page_isolate()
scans the PTEs, it will encounter swapped pages and fail:

__collapse_huge_page_isolate()
    if (!pte_present(pteval)) {
        result =3D SCAN_PTE_NON_PRESENT;
        goto out;
    }

Could we allow swap-in by passing 1 here instead?

[Severity: High]
Does bypassing the read-only scan phase cause severe performance issues?

Normally, collapse_scan_pmd() performs a read-only validation of the page
tables. By skipping straight to collapse_huge_page(), this code takes the
mmap_write_lock, destructively clears the PMD, and triggers a global TLB
flush before verifying if the PTEs can actually be isolated:

collapse_huge_page()
    _pmd =3D pmdp_collapse_flush(vma, pmd_addr, pmd);
    ...
    tlb_remove_table_sync_one();

If isolation fails (e.g., due to pinned or unmapped pages), it restores the
PMD and aborts. Because DAMON repeatedly scans and targets memory, wouldn't
this create continuous lock contention and TLB flush storms on
un-collapsible memory ranges?

> +	kfree(cc);
> +	if (result =3D=3D SCAN_SUCCEED || result =3D=3D SCAN_PMD_MAPPED)
> +		return 0;
> +	return madvise_collapse_errno(result);
> +}
> +EXPORT_SYMBOL_GPL(damon_collapse_folio_range);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702095227.7586=
6-1-lianux.mm@gmail.com?part=3D2
