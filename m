Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BB2853E0
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988068; cv=none; b=AZSPvSb1xdFhznxhMIFCAW95nfHzQFPTrjHeILD9c/kNXYe9BETNeTvdcSWzRriu7fhv1RwGB78dI45D5VyM3e22q7kOXShl6wRnVUe7dEP4LLd+GWSqOSVwlCGtHyCf8Y9Y7O64laZt+MaOL/DALBOB1iwLahKceZH62JVmMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988068; c=relaxed/simple;
	bh=6362Vqlcwb1xqjXcSUvUVGMDav30/XddMxyEemWkOIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lhy19gq4XWYQNFYEhD6swWcdK0j1owKtrlmiGxvYNPG+A/WusBoGKyLNzFbN5GQCHTWTqpYft8ZVdU7X/ddEP9CzwKvA8d2k9wnxMxo8NZYOLpyYxSw1e4kYzcqXazfpCbQKa1WzgdXbC1j1+mLQ6jfGCS9O8cQcByDQCh50AVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmJUuy/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmJUuy/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C6C1F000E9;
	Thu,  2 Jul 2026 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782988067;
	bh=T7BcQVFdUVdK8+aNudq8KP6krwFd4SMuJTYgI13hW8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmJUuy/Xb6IddKz3MDk0C3xQYLNnFOFCLN0d0VJLQSsJJLWxTC9s/b8mkWaXLwHDZ
	 gFnwhcZRpWoSDZjSSWgcV39STp+rhIVvm+t4HaIaSNCzS5+8imtMl9OIi/Zcglsgsg
	 Y8MRx2y8R5oQWKiMSJgZUDbG+Tsab7Jwqf9eSFw1TM824KBjACbI+jUUU5hT4eWIBG
	 8exoQUeKBDLu5mc6Vt845zzUEpnJckSyeitOPWDAIGAvrGmtHl2tE32XLyC8T6tsnp
	 AjkgYMDUKja7YA1mZFRqg6l6DfZsG84SUnugQwGhmf8fuWOC4QuwLntjMOigoofVMo
	 5h/j65gRHx2Cw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware
 DAMOS_COLLAPSE handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702095227.75866-4-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
 <20260702095227.75866-4-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:27:46 +0000
Message-Id: <20260702102747.18C6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] The `collapse_control` struct `cc` is allocated without zeroin=
g, causing uninitialized memory usage.
- [Critical] Calling `lru_add_drain_all()` and allocating huge pages per-ch=
unk in a tight loop without VMA validation causes system-wide IPI storms an=
d severe CPU stalls.
- [High] damon_collapse_folio_range explicitly rejects non-PMD orders, brea=
king the advertised mTHP support.
- [High] DAMOS_COLLAPSE via `damos_va_collapse` silently fails on all file-=
backed VMAs.
- [Medium] Local `last_chunk` variable fails to deduplicate cross-region ch=
unks, artificially inflating DAMON statistics.
- [Low] Build break when CONFIG_TRANSPARENT_HUGEPAGE is disabled due to unc=
onditional use of HPAGE_PMD_ORDER.
--

commit 1758a6da0e4869c672603d9b92add29e2cab16d6
Author: Lian Wang <lianux.mm@gmail.com>

mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler

The commit implements an mTHP-aware DAMOS_COLLAPSE handler that iterates ov=
er
the target region in order-aligned chunks when a target mTHP order is provi=
ded.
It utilizes damon_collapse_folio_range() for the underlying memory collapse
operations while falling back to the madvise path for default configuration=
s.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 2058db9c01d52..8bfc6dcc635d5 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -895,6 +896,50 @@ static unsigned long damos_va_stat(struct damon_targ=
et *target,
>  	return 0;
>  }
> =20
> +static unsigned long damos_va_collapse(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr, end, chunk_sz;
> +	unsigned long last_chunk =3D ULONG_MAX;
> +	unsigned int target_order =3D s->target_order;
> +	unsigned long applied =3D 0;
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (target_order < 2 || target_order > HPAGE_PMD_ORDER)

[Severity: Low]
Is this safe to use when CONFIG_TRANSPARENT_HUGEPAGE is disabled?

In damos_va_collapse(), HPAGE_PMD_ORDER is unconditionally referenced. With=
out
THP, HPAGE_PMD_ORDER evaluates to an expression containing BUILD_BUG(), whi=
ch
can cause a build breakage.

> +		return 0;
> +
> +	chunk_sz =3D PAGE_SIZE << target_order;
> +	addr =3D ALIGN_DOWN(r->ar.start, chunk_sz);
> +	end =3D ALIGN(r->ar.end, chunk_sz);
> +	if (end < addr)
> +		return 0;
> +
> +	mm =3D damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	while (addr < end) {
> +		if (addr + chunk_sz < addr)
> +			break;
> +		if (addr =3D=3D last_chunk)
> +			goto next;
> +		last_chunk =3D addr;

[Severity: Medium]
Will this reliably deduplicate chunks across multiple DAMON regions?

Because last_chunk is local to damos_va_collapse() and resets for each regi=
on,
adjacent or overlapping regions that map to the same chunk might bypass this
check. This can result in the same range being processed multiple times,
artificially inflating the sz_filter_passed and applied statistics.

> +
> +		ret =3D damon_collapse_folio_range(mm, addr, target_order);

[Severity: High]
Will this function correctly handle mTHP orders smaller than PMD?

While damos_va_collapse() allows target_order values down to 2,
damon_collapse_folio_range() in mm/khugepaged.c strictly rejects non-PMD
orders:

	if (target_order !=3D HPAGE_PMD_ORDER) {
		...
		return -EINVAL;
	}

Doesn't this unconditionally reject smaller mTHP orders, causing the collap=
se
to fail while still incorrectly incrementing the sz_filter_passed statistic?

[Severity: Critical]
Can this code cause uninitialized memory usage during the collapse?

When damon_collapse_folio_range() allocates the collapse_control struct:

	cc =3D kmalloc_obj(*cc);
	if (!cc)
		return -ENOMEM;
	cc->is_khugepaged =3D false;
	cc->progress =3D 0;

The cc->node_load array and cc->alloc_nmask are left uninitialized because
kmalloc_obj() does not zero memory. Since this bypasses collapse_scan_pmd()
which normally initializes these fields, collapse_find_target_node() will
later read garbage data to make NUMA node placement decisions.

[Severity: Critical]
Does this code handle unmapped virtual address ranges efficiently?

Iterating over purely virtual address ranges without validating if they bel=
ong
to a VMA can be problematic. For each chunk, damon_collapse_folio_range()
in mm/khugepaged.c executes heavy operations like lru_add_drain_all() and
attempts huge page allocations.

If a large unmapped memory hole is encountered, could this lead to severe
CPU stalls and system-wide IPI storms before the VMA validation eventually
fails?

[Severity: High]
Does this silently fail on file-backed VMAs?

Looking at damon_collapse_folio_range() in mm/khugepaged.c, it directly wra=
ps
collapse_huge_page() which uses hugepage_vma_revalidate() with expect_anon
set to true. This unconditionally rejects file-backed VMAs without falling
back to collapse_file(), potentially breaking the collapse functionality for
file-backed memory.

> +		if (!ret)
> +			applied +=3D chunk_sz;
> +		*sz_filter_passed +=3D chunk_sz;
> +next:
> +		addr +=3D chunk_sz;
> +		cond_resched();
> +	}
> +
> +	mmput(mm);
> +	return applied;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702095227.7586=
6-1-lianux.mm@gmail.com?part=3D3
