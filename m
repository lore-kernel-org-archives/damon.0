Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AD4252AC
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987198; cv=none; b=tONRbx7UyO4P2JIQXgEv5pyNKDTmKsfX+LJTl9kOeHYa00RHLoc9i7XdpVwkZybnBzDL6NCvF1IVMfgegF+sbR9UZJ0aXtJNKi3fnUJfdAKmm3p9WJD4Jsy1AVZK0R2TLQwipY3Cnu0aSbBCMOy2Ps712bPkp5hDI+8yqC6R/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987198; c=relaxed/simple;
	bh=LJOPjCtxRim3uaGA67RGIuhPzL+M9XE4ryHYRbSqE08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B0VHbYQeWFlPpUKipoEVISXsm+Li8Jaub27BKJndKowau6UkDtQIKjIVigCmXIuy7n2DrRz4gpAIcMk4LkmveB5v9YU9dZuxlX/k+WXHlVxea4KVxN1lbUtODjxe9VSOjVzTmOQX2y5hTv6s5xLtA5qqdE/eMlXwlmxx40QnmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2pNQKsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2pNQKsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142AC1F000E9;
	Thu,  2 Jul 2026 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987196;
	bh=n2xo0NnKRydHB8LyPDXwnBTzpdXBu6TNBu62lVD/4+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2pNQKsWXfpBafAly7+jfZA5Cqg0nZHAhbAjoPNTuS8PjfowqQGz8IQp7s3TatqrO
	 p9bbWSvZsm11iivvvcY2kAWpnuyuKfauOXcHMjZCwgn3p6Y8plDbyHgSUSqvwEqPPw
	 fWiCk9NU9yIyLrUZ3LZvJjJp2sZuIXsrnt/tBA8HIKrdRwleVooWN7F9eQExOEGBN4
	 1/rkdomlsaO9s72xFP8EzaLVn/AhOwPH97dnPiRP08IZVNZ0gveMfjhRUpfa+sMXJz
	 q8KhxgwvZxm7C4COib7bc3+lm5mQTDuNLfcqp0oDshbDjcvBzWPXIec6B0ieso3IBJ
	 KqNYWAnOlZzHw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add
 damon_collapse_folio_range() for external callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702094633.75658-3-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <20260702094633.75658-3-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:13:15 +0000
Message-Id: <20260702101316.142AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Uninitialized memory in `struct collapse_control` causes undefined=
 behavior and random NUMA node constraints during THP allocation.
- [High] Calling `lru_add_drain_all()` for every PMD creates severe system-=
wide latency spikes and IPI storms.
- [High] Directly calling collapse_huge_page() bypasses PTE pre-scanning an=
d swap-in, causing unconditional THP allocations and breaking file-backed T=
HP support.
--

commit 03af0641474bb6262efed77c042c17e3c94d4f27
Author: Lian Wang <lianux.mm@gmail.com>

mm/khugepaged: add damon_collapse_folio_range() for external callers

Adds a thin wrapper around collapse_huge_page() to allow external
subsystems like DAMON to trigger THP collapse on a target address range.

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
Does this leave the cc->node_load array and cc->alloc_nmask nodemask
uninitialized?

Since this code bypasses collapse_scan_pmd() which typically zeros these
fields, collapse_huge_page() will call alloc_charge_folio() and then
collapse_find_target_node().

In collapse_find_target_node(), the code reads cc->node_load[nid] to find
the maximum value and sets bits in cc->alloc_nmask. Passing a garbage
nodemask to __folio_alloc() could cause undefined behavior and random NUMA
node constraints during allocation.

> +	if (!cc)
> +		return -ENOMEM;
> +	cc->is_khugepaged =3D false;
> +	cc->progress =3D 0;
> +
> +	lru_add_drain_all();

[Severity: High]
Can this cause system-wide latency spikes and IPI storms?

Because damon_collapse_folio_range() is called for every 2MB chunk by DAMON
iteration logic, unconditionally invoking the heavy cross-CPU
lru_add_drain_all() here means it will execute for every single PMD in the
region.

Unlike madvise_collapse() which hoists this drain out of its scanning loop,
placing it inside the per-PMD API might severely impact system performance.

> +
> +	result =3D collapse_huge_page(mm, start_addr, 1, 0, cc, target_order);

[Severity: High]
Does this direct call bypass PTE pre-scanning and swap-in logic?

By skipping collapse_scan_pmd() and directly invoking collapse_huge_page(),
this forces an unconditional allocation via alloc_charge_folio() for every
chunk evaluated, before even checking if the PMD is collapsible.

Also, passing 0 for the unmapped parameter skips the swap-in step, meaning
any swapped-out pages in the target region will cause the isolation phase
to abort.

Furthermore, hugepage_vma_revalidate() inside collapse_huge_page()
hardcodes expect_anon=3Dtrue, so this path will silently fail for any
file-backed memory.

> +	kfree(cc);
> +	if (result =3D=3D SCAN_SUCCEED || result =3D=3D SCAN_PMD_MAPPED)
> +		return 0;
> +	return madvise_collapse_errno(result);
> +}
> +EXPORT_SYMBOL_GPL(damon_collapse_folio_range);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094633.7565=
8-1-lianux.mm@gmail.com?part=3D2
