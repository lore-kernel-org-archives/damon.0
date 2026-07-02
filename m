Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041E35CB9C
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987982; cv=none; b=j64fhz/kGqVyOkTfC5OGiQTWUFUi0e+t0xIAQsUuoqNCvXBQyBQ583IyxYGCcwcwOVeNoBHOJ9tSAVFLmH4D6+1rHSBCH+jDEVJm86WJLqCzPBMl5NcA1zzPArZKz4fhzOeOvyIlcQFH9dfdLHaB78YGMCTfnC8gzp3jwqeuEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987982; c=relaxed/simple;
	bh=oMIra76P5CICGyy8Eo+izmR1Yj3obju5HGvJIZqQDzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J4VjC2oskoHuvFxUOfwLbFAeIW1xTfXcE3boEPevT6/6FwVS9Gf6CzaZap+/1cyKE8zT/5fVcRKhOXVZ60hBy9xKatJx/LLNSwEZ+Nj6cb9h8Y8/uGXnIQ6kFBnXVscdvfgfsb4Z5WU4vHq/c1G2BAb/cpe5gFrcAQqm6nwOAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fsxslzcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fsxslzcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94531F000E9;
	Thu,  2 Jul 2026 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987980;
	bh=3cizjurJn5yhyUJcorZ5g9hn3rUwN6wBMFNe4Ym2tVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsxslzccId+HXyyMnih7ok9jCdMkCreoyE86Tp6mfskTJj0LV5JqovXzvqJLC6tRc
	 374WyAU5aBjAa+BzAeQ4zAZS3QBIIS6i9kDrSZ/o3arqCcuA3hRdXQS+vfMnaM1qxc
	 BmNeK7banwf1fs8pv+JwQeDX1bcaq4nr14xefYA2jV1YBnSBmrr0vLSuDcvfLEa3Cf
	 tLxvFRFlczMqOPmh2247yqSMLUVBJGRfP2HFruq2L8d3IfvufAVXyzmV6jwKmf2NXy
	 isR/7LhbfcD+SKkZK1YCTsookLN/A+9hGSV32T/bHHDMUZKOqWRZyiJZM9Dej1wYii
	 2RKa3ju8KPtAQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware
 DAMOS_COLLAPSE handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702094633.75658-4-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <20260702094633.75658-4-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:26:19 +0000
Message-Id: <20260702102619.E94531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] damos_va_collapse() accepts mTHP target orders but calls damon_col=
lapse_folio_range() which strictly rejects them.
- [High] Calling damon_collapse_folio_range() in a per-chunk loop triggers =
severe global lock contention and IPI storms via lru_add_drain_all().
- [High] damos_va_split() skips entire PMD-sized chunks when encountering u=
nmapped pages or small folios, preventing valid mTHPs from being split.
- [Medium] damos_va_collapse() fails to deduplicate overlapping chunk colla=
pses across adjacent DAMON regions, artificially inflating statistics.
--

commit bbcfac46aaf7ca5b18e45240fde04cb5fffba9c1
Author: Lian Wang <lianux.mm@gmail.com>
Subject: mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler

This commit implements the DAMOS_COLLAPSE action for mTHP by iterating
over target regions in order-aligned chunks. It expands region boundaries
to the covering aligned range and calls damon_collapse_folio_range()
without holding an external mmap lock to avoid self-deadlocks.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
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

[Severity: Medium]
Does this code fail to deduplicate overlapping chunk collapses across
adjacent DAMON regions?

When kdamond splits regions into smaller sizes that fall into the same
aligned chunk, damos_va_collapse() is called for each region. Because
last_chunk is initialized locally to ULONG_MAX on every call, it does
not persist across calls, which artificially inflates the DAMON
statistics (sz_filter_passed and applied) and prematurely exhausts
quotas.

Additionally, because addr is strictly incremented by chunk_sz within
the loop, the addr =3D=3D last_chunk check appears to be dead code:

	while (addr < end) {
		...
		if (addr =3D=3D last_chunk)
			goto next;
		last_chunk =3D addr;
		...
		addr +=3D chunk_sz;
	}

> +	unsigned int target_order =3D s->target_order;
> +	unsigned long applied =3D 0;
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (target_order < 2 || target_order > HPAGE_PMD_ORDER)
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
> +
> +		ret =3D damon_collapse_folio_range(mm, addr, target_order);

[Severity: High]
Does calling damon_collapse_folio_range() with mTHP orders fail silently?

While this loop accepts target_order > 0 and < HPAGE_PMD_ORDER,
damon_collapse_folio_range() explicitly rejects any order that is not
PMD_ORDER:

mm/khugepaged.c:damon_collapse_folio_range() {
	if (target_order !=3D HPAGE_PMD_ORDER) {
		pr_warn_once("... only PMD order ... is supported ...");
		return -EINVAL;
	}
}

This means attempts to collapse regions into mTHP sizes will fail, while
still incrementing sz_filter_passed.

[Severity: High]
Can this tight loop cause severe global lock contention and IPI storms?

damos_va_collapse() iterates over a target memory region in chunk_sz
increments, calling damon_collapse_folio_range() sequentially for every
chunk. However, the wrapper damon_collapse_folio_range() unconditionally
executes lru_add_drain_all():

mm/khugepaged.c:damon_collapse_folio_range() {
	...
	lru_add_drain_all();
	...
}

For a multi-GB VMA region, this places a global synchronization point
(acquiring lru_add_drain_mutex and sending IPIs to all online CPUs)
inside a tight loop hundreds or thousands of times, which can cause
system-wide performance degradation, latency spikes, and potential RCU
lockups.

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

I also noticed an issue in the related damos_va_split() function:

[Severity: High]
Does damos_va_split() skip entire PMD-sized chunks when encountering
unmapped pages or small folios?

In damos_va_split(), if an unmapped page is encountered, the code jumps
to the unlock label:

	folio =3D folio_walk_start(&fw, vma, addr, 0);
	if (!folio)
		goto unlock;

And at the unlock label, addr is advanced by chunk_sz (typically 2MB)
instead of PAGE_SIZE:

unlock:
	*sz_filter_passed +=3D chunk_sz;
	addr +=3D chunk_sz;

A similar advancement occurs in the else block when a small folio is
encountered:

	} else {
		folio_walk_end(&fw, vma);
		*sz_filter_passed +=3D chunk_sz;
		addr +=3D chunk_sz;
	}

By advancing addr by 2MB upon encountering a single unmapped or small
page, this prevents valid mTHPs in the remainder of the chunk from being
split.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094633.7565=
8-1-lianux.mm@gmail.com?part=3D3
