Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61547A0D7
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907348; cv=none; b=Wzoi6tnF2KODOvYbftGoqgkgl72ZzDFOb8/URRh7BxpiGv4Umt5q346hiLDyiSPaVTrGBix7IEkoUFrbFd+Ik9TWavk6OGIx3u1/AXhL6lxOYIJd5/PqaDbGaXQCGlvo3xQP7Yr5R+dvmrY1lpVFmoIBhRYXBT4m9A2htJSM8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907348; c=relaxed/simple;
	bh=XQSDPQBEhYxWA0tPod0hXwFwxfJM6kIh5iL1opWZTrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CpKs4MKwNz7Ag0HaBdmEjkL5DBpGZxL+YNLsoNmk0l3qawt5bvR//fkkexX9fuQNQPXswpfh/TRSfJ6Did9rJSm64GmJPlZm9N4ffnK4gZT26UuAfpXQCYQN3fdQvVXeRt9zpwKZULknuZKgbzhMbRaNrhX4sd2amvhFsDw8m7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzqALeA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzqALeA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8811F000E9;
	Wed,  1 Jul 2026 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907347;
	bh=mQ8rWbwIRCKAOOOEx/9RN5fgaZTzbzXX15iU36j+nJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzqALeA1GcZkuB7uqJzKfgecbMY4+XcFZyAxmQ9xaU+WctL1VxL69GhDc2vTQXjs1
	 byACwK0pXkThdb97d//L0NPGYH5JmElo1Ajxr00PF22+bEUcwTyiAiM/KmyDENR9+F
	 nE5JNBozrIh3WnOw9G/NTP/U0YRKDIOeSvWJFJIZ9rF6y4HJy9lkfnaJRGCL5C72Yj
	 TGeOPse6yFwq8ofNZN3dOCjEjBqQOGKmVMFO/tyhbYOTr3GkTfnjS+lEuJ31Mp44ir
	 8F5dTHrNqIrph3ygc5PoI8xLHp9+3I8o5RQ9LGZhdJjvIMMWh0BfyNJCLej8YvLj/x
	 CN0l2Fmczmj7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range()
 for external callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "wang lian" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701114716.56503-3-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
 <20260701114716.56503-3-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:02:26 +0000
Message-Id: <20260701120226.DD8811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Allocating the large `struct collapse_control` directly on the ker=
nel stack risks stack overflow.
- [High] Bypassing the PMD pre-scan phase violates khugepaged invariants, c=
ausing logic errors, performance degradation, and potential crashes.
- [Medium] Missing `lru_add_drain_all()` before collapsing causes spurious =
collapse failures due to inflated page refcounts.
- [Medium] Successful pre-existing THP state (`SCAN_PMD_MAPPED`) is incorre=
ctly translated into a hard `-EINVAL` error.
--

commit bb75d3df2a4ada9ebcc7237ae7417a21c9fbc4f8
Author: Wang Lian <lianux.mm@gmail.com>

mm/khugepaged: add damon_collapse_folio_range() for external callers

Export a wrapper around collapse_huge_page() that allows external
subsystems such as DAMON to trigger THP collapse on a target address range.

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 617bca76db49b..0387841ba2e7d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -3272,3 +3272,42 @@ int madvise_collapse(struct vm_area_struct *vma, u=
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
> +	struct collapse_control cc =3D {
> +		.is_khugepaged =3D false,
> +	};

[Severity: High]
Does allocating struct collapse_control directly on the stack risk a stack
overflow?

The collapse_control structure contains a large array:

struct collapse_control {
	...
	u32 node_load[MAX_NUMNODES];
	...
};

With CONFIG_NODES_SHIFT=3D10 on x86_64, MAX_NUMNODES is 1024, making the st=
ruct
larger than 4KB. Allocating this directly on the stack could overflow the
kernel stack.

Should this be heap-allocated with kmalloc_obj() as done in
madvise_collapse()?

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
> +	result =3D collapse_huge_page(mm, start_addr, 1, 0, &cc, target_order);

[Severity: High]
Is it safe to bypass the collapse_scan_pmd() pre-scan phase and directly ca=
ll
collapse_huge_page()?

By skipping the pre-scan, several issues appear to occur:

First, collapse_huge_page() unconditionally allocates and charges a 2MB fol=
io
before validating the VMA:

static enum scan_result collapse_huge_page(...)
{
	...
	result =3D alloc_charge_folio(&folio, mm, cc, order);
	...
}

Second, because cc.node_load is never populated by the scan,
collapse_find_target_node() always defaults to node 0, breaking NUMA locali=
ty.

Finally, if a non-anonymous page is legitimately mapped into an anonymous V=
MA,
__collapse_huge_page_isolate() could trigger a kernel panic via:

	VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);

Does this sequence need to invoke the pre-scan phase before collapsing?

[Severity: Medium]
Will this reliably fail to collapse pages that are currently in per-CPU LRU
batches?

Without calling lru_add_drain_all() before collapse_huge_page(), transient
references held by the LRU batches inflate the page reference counts. The
strict exclusivity check in __collapse_huge_page_isolate() will then return
SCAN_PAGE_COUNT, resulting in a spurious -EAGAIN failure.

> +	if (result =3D=3D SCAN_SUCCEED)
> +		return 0;
> +	return madvise_collapse_errno(result);

[Severity: Medium]
Does this code handle SCAN_PMD_MAPPED correctly when memory is already back=
ed
by a THP?

If the range is already PMD-mapped, collapse_huge_page() detects this in
find_pmd_or_thp_or_none() and returns SCAN_PMD_MAPPED. Because this function
only checks for SCAN_SUCCEED, SCAN_PMD_MAPPED falls through to
madvise_collapse_errno(), which lacks a case for it and returns -EINVAL.

Should SCAN_PMD_MAPPED be treated as a success case?

> +}
> +EXPORT_SYMBOL_GPL(damon_collapse_folio_range);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701114716.5650=
3-1-lianux.mm@gmail.com?part=3D2
