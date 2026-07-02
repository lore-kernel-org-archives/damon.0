Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7F28030E
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988216; cv=none; b=PTrg+jOSkzG94HrcNmAbf/1MIotlCSPfEGWPVy3UmpP7UkRW/sZeVnYlmfGBMJZzI1Ag8ndaEUdYWHMucssJUvppImrrpJR3BmdYThyIsNlVZcw6ThiBymG3WkJtKxfXHKkhCkr6rEiyaTvkIx7+IcUoxR2eE/TQH852x5n+204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988216; c=relaxed/simple;
	bh=i9Ed7mxIvT3EXUN9kMXyVPzseRPfhFcE06C2ymAMsxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SbxHreYN81qwW8fhuyTgxOiFvHIW/n6Hu/pbwq+tdyCI86ltI4OYDoeCX8ZoNx0N7rx2cp99fWaZ9sJlnkX2zmlRAgfYGPVvQyiCWVGJxfIVAwgb9Qo6FXqXUaMtXmUc/8oDq7Dp9j/Z7vIxDd46pBZgKxF73EEjIV6Wawx/pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJTFlzS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJTFlzS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1581F000E9;
	Thu,  2 Jul 2026 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782988214;
	bh=/+u79sXkzm/g0ak/76bnVA2r0ZlXSrtsunyVsB20Gew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJTFlzS6GHu92I/Ly9lF5FVBbuJ779QyrY888cwDOkZqnnFMBJc5lBVBKOGl9JQlN
	 H5ldLA5C5aZvw3c0hjMP/kAplcNsZS5OIIfnfgYj6Ec1pUZ5ACWKmhnFcFRJUnOCSm
	 2O1JZ6Gix7ua+/d1tJiOxk7QpZ3avY4xiKvPxry4gCp7VVZqMp8dN3O0yRUeKpIfBp
	 eN2sImIiADlcyIGZdW1YNQ93oFEWhsH1v1o6mdTxJH3si2Aruxt6BF4yEjvL21n8OR
	 WJV7s6VJGLdB1bDNfF63JNpLSu49e4NVBfaqmCsUr6CIds6GG3nhc0aq5stPouZgMy
	 WVXfDrSjwOC1A==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702095227.75866-6-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
 <20260702095227.75866-6-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:30:13 +0000
Message-Id: <20260702103014.7B1581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect address range expansion and iteration logic in `damos_va=
_split()` causes out-of-bounds folio processing and skips memory.
- [High] `damos_va_split()` calls `split_folio_to_order()` on mapped compou=
nd pages without verifying they are valid LRU folios, leading to kernel cra=
shes.
--

commit 1aa5abadd8058bacb6959d3c7864cfd3e927e6df
Author: Lian Wang <lianux.mm@gmail.com>

mm/damon/vaddr: implement DAMOS_SPLIT handler

This commit implements the vaddr operations layer handler for DAMOS_SPLIT.
It iterates over the target region and attempts to split any large folios
that exceed the scheme's target order.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 8bfc6dcc635d5..73cb61c655fc7 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -940,6 +940,83 @@ static unsigned long damos_va_collapse(struct damon_=
target *target,
>  	return applied;
>  }
> =20
> +static unsigned long damos_va_split(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr, end, chunk_sz;
> +	unsigned int target_order =3D s->target_order;
> +	unsigned long applied =3D 0;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	struct folio *folio;
> +	struct folio_walk fw;
> +
> +	mm =3D damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	chunk_sz =3D PAGE_SIZE << HPAGE_PMD_ORDER;
> +	addr =3D ALIGN_DOWN(r->ar.start, chunk_sz);
> +	end =3D ALIGN(r->ar.end, chunk_sz);

[Severity: High]
Does aligning the start and end to 2MB boundaries risk processing memory ou=
tside
the requested target region? It seems this could expand the iteration beyond
the boundaries defined by r->ar.start and r->ar.end.

> +	if (end < addr)
> +		goto out_mmput;
> +
> +	while (addr < end) {
> +		unsigned long folio_sz;
> +
> +		if (addr + chunk_sz < addr)
> +			break;
> +
> +		mmap_read_lock(mm);
> +		vma =3D find_vma(mm, addr);
> +
> +		if (!vma || addr < vma->vm_start ||
> +		    vma->vm_flags & (VM_HUGETLB | VM_MIXEDMAP))
> +			goto unlock;
> +
> +		folio =3D folio_walk_start(&fw, vma, addr, 0);
> +		if (!folio)
> +			goto unlock;
> +
> +		folio_sz =3D PAGE_SIZE << folio_order(folio);
> +
> +		if (folio_order(folio) > target_order) {
> +			if (!folio_trylock(folio)) {
> +				folio_walk_end(&fw, vma);
> +				goto unlock;
> +			}
> +			folio_get(folio);
> +			folio_walk_end(&fw, vma);
> +
> +			if (!split_folio_to_order(folio, target_order))

[Severity: High]
Could this call to split_folio_to_order() encounter driver-allocated compou=
nd
pages?=20

While VM_MIXEDMAP and VM_HUGETLB are filtered out, other normal VMAs
might still be backed by compound pages that are not fully initialized LRU
folios. Without checking if the folio is actually a valid LRU folio (e.g., =
via
folio_test_lru()), this might dereference uninitialized fields during the s=
plit
and cause kernel crashes.

> +				applied +=3D folio_sz;
> +
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			*sz_filter_passed +=3D folio_sz;
> +			addr +=3D folio_sz;
> +		} else {
> +			folio_walk_end(&fw, vma);
> +			*sz_filter_passed +=3D chunk_sz;
> +			addr +=3D chunk_sz;

[Severity: High]
When the folio order is smaller than or equal to the target order, does adv=
ancing
addr by a full 2MB chunk miss the remaining folios within that chunk?=20

If addr was advanced by folio_sz in a previous loop iteration, adding chunk=
_sz
here might overshoot and skip memory.

> +		}
> +		mmap_read_unlock(mm);
> +		cond_resched();
> +		continue;
> +
> +unlock:
> +		*sz_filter_passed +=3D chunk_sz;
> +		addr +=3D chunk_sz;

[Severity: High]
Similarly, does advancing by chunk_sz on error paths (like missing VMAs, ho=
les,
or lock failures) skip intermediate memory and artificially inflate the
sz_filter_passed statistic?

> +		mmap_read_unlock(mm);
> +		cond_resched();
> +	}
> +
> +out_mmput:
> +	mmput(mm);
> +	return applied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702095227.7586=
6-1-lianux.mm@gmail.com?part=3D5
