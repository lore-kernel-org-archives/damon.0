Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443E3E2777
	for <damon@lists.linux.dev>; Fri, 24 Apr 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064349; cv=none; b=nsxAqDzKg2ByH/x/EeSRZzftDYWXkXs4Vu0MgqPcFU2mG+8/BDmIN2cdkknGNsXY4DrIdyIhBE5QfnRN0LbgStN642zCUg8IEuTiGyqqlpJHkW4Jo5OliOsqzxpuZTH5T8PsFjRYbj/TjeGxfPgZrC3U2o21LBVAPmjlnKnK7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064349; c=relaxed/simple;
	bh=SaFEHOmfK5+UlYtYxHOWMTwTQXHGW/HzsysoXzPLwnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YnVGIiOTDJLO0UqOAt+xHoHmeIjvLtRwtodLmJW0sXYlWIHys+ZTjg1N22Zkpq2XTfnVvrTG+LqMdKpcLI/m3O7RCraKrAVZmQUY39SwZVdcvRVvClSTwY7G64t2pf4QR9tBYYEWLHNcoUi+d6c1P2/NkJh5fsZkjpU/nYMFlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXrjP8LQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXrjP8LQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF949C2BCB8;
	Fri, 24 Apr 2026 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777064349;
	bh=SaFEHOmfK5+UlYtYxHOWMTwTQXHGW/HzsysoXzPLwnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dXrjP8LQZLfjaLpeas9LdombKx9MxJBj/d1d/Rsv/EUfJx0o/p+o5E9L/ATxVfABs
	 cNhfQehAui4YoZ0N8iKwFDTADk7bbrnGVP6l0G8gB8qW9PYb2aNOvvsNwBBuoef80h
	 2PF4kJ33DQtg6Gg46gCECT701H7wshcsA+GXuIP54YIb9kFQRo5socoLnG/sCZ03lF
	 +Kpu4LKgWRVsZw/IBfXpI9vbApVJgQGAfv7maNhhqHvE2XZrxHqBzmCaiyMEICaVRz
	 V3uotgElsfV0ncx8HU49IkL4HkDsoMi7T0RA9EgiEwNMYGNI69AzZOycHDeH/pnttu
	 5H7fA9U6v79pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] mm/damon: add node_eligible_mem_bp goal metric
Reply-To: sashiko@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260424203448.5040-1-ravis.opensrc@gmail.com>
References: <20260424203448.5040-1-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 20:59:07 +0000
Message-Id: <20260424205908.CF949C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 4 potential issue(s):
- [High] Integer Truncation and Arithmetic Overflow on 32-bit Architectures
- [High] CPU Soft Lockups due to Unbounded Physical Address Iteration
- [Medium] Missing Core Filters Evaluation Causes Eligible Memory Over-coun=
ting
- [Medium] Unaligned Address Advancement Truncates Exact Overlap Calculation
--

commit d92efd581a7b3318becfa32765dc87547acb91c6
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: mm/damon: add node_eligible_mem_bp goal metric

This commit introduces a new metric node_eligible_mem_bp for DAMON schemes
to control memory distribution across NUMA nodes based on the ratio of
scheme-eligible memory. It calculates physical bytes per node using PADDR
ops and integrates with the DAMOS quota goal system.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff719f..4ac8052052613d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2287,7 +2305,112 @@ static unsigned long damos_get_node_memcg_used_bp(
>  		numerator =3D i.totalram - used_pages;
>  	return mult_frac(numerator, 10000, i.totalram);
>  }
> -#else
> +
> +#ifdef CONFIG_DAMON_PADDR
> +/*
> + * damos_calc_eligible_bytes() - Calculate raw eligible bytes per node.
> + * @c:		The DAMON context.
> + * @s:		The scheme.
> + * @nid:	The target NUMA node id.
> + * @total:	Output for total eligible bytes across all nodes.
> + *
> + * Iterates through each folio in eligible regions to accurately determi=
ne
> + * which node the memory resides on. Returns eligible bytes on the speci=
fied
> + * node and sets *total to the sum across all nodes.
> + *
> + * Note: This function requires damon_get_folio() from ops-common.c, whi=
ch is
> + * only available when CONFIG_DAMON_PADDR is enabled. It also requires t=
he
> + * context to be using PADDR operations for meaningful results.
> + */
> +static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
> +		struct damos *s, int nid, phys_addr_t *total)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	phys_addr_t total_eligible =3D 0;
> +	phys_addr_t node_eligible =3D 0;
> +
> +	damon_for_each_target(t, c) {
> +		damon_for_each_region(r, t) {
> +			phys_addr_t addr, end_addr;
> +
> +			if (!__damos_valid_target(r, s))
> +				continue;

Does this overcount eligible memory by skipping core filters?

The quota adjustment logic uses damos_core_filter_out() to exclude explicit=
ly
filtered regions, but it appears this calculation only checks
__damos_valid_target(). Should damos_core_filter_out() be evaluated here as=
=20
well?

> +
> +			/* Convert from core address units to physical bytes */
> +			addr =3D (phys_addr_t)r->ar.start * c->addr_unit;
> +			end_addr =3D (phys_addr_t)r->ar.end * c->addr_unit;
> +			while (addr < end_addr) {
> +				struct folio *folio;
> +				phys_addr_t folio_start, folio_end;
> +				phys_addr_t overlap_start, overlap_end;
> +				phys_addr_t counted;
> +
> +				folio =3D damon_get_folio(PHYS_PFN(addr));
> +				if (!folio) {
> +					addr +=3D PAGE_SIZE;
> +					continue;
> +				}

If addr is unaligned, does adding PAGE_SIZE preserve the unaligned offset a=
nd
cause under-counting on the next valid folio?

If an unaligned fallback happens, the address might skip past a valid page
boundary instead of aligning to it. When advancing the address without a
valid folio, would it be better to align it to the next page boundary?

> +
> +				/*
> +				 * Calculate exact overlap between the region
> +				 * [addr, end_addr) and the folio range.
> +				 * The folio may start before addr if addr is
> +				 * in the middle of a large folio.
> +				 */

[ ... ]

> +				if (overlap_end > overlap_start) {
> +					counted =3D overlap_end - overlap_start;
> +					total_eligible +=3D counted;
> +					if (folio_nid(folio) =3D=3D nid)
> +						node_eligible +=3D counted;
> +				}
> +
> +				/* Advance past the entire folio */
> +				addr =3D folio_end;
> +				folio_put(folio);
> +			}
> +			cond_resched();
> +		}
> +	}

Could this cause CPU soft lockups for very large regions?

Since the while loop can iterate millions of times for large memory regions,
should cond_resched() be placed inside the while loop instead of outside it?

> +
> +	*total =3D total_eligible;
> +	return node_eligible;
> +}
> +
> +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
> +		struct damos *s, int nid)
> +{
> +	phys_addr_t total_eligible =3D 0;
> +	phys_addr_t node_eligible;
> +
> +	if (c->ops.id !=3D DAMON_OPS_PADDR)
> +		return 0;
> +
> +	if (nid < 0 || nid >=3D MAX_NUMNODES || !node_online(nid))
> +		return 0;
> +
> +	node_eligible =3D damos_calc_eligible_bytes(c, s, nid, &total_eligible);
> +
> +	if (!total_eligible)
> +		return 0;
> +
> +	return mult_frac((unsigned long)node_eligible, 10000,
> +			(unsigned long)total_eligible);
> +}

Can this cast cause truncation and overflow on 32-bit architectures?=20

Both node_eligible and total_eligible are phys_addr_t, which are 64-bit on
PAE systems, but unsigned long is 32-bit.

If total_eligible is an exact multiple of 4GB, it would cast to 0 and trigg=
er
a divide-by-zero panic in mult_frac(). Additionally, mult_frac() multiplies
by 10000 using 32-bit math, which might overflow for values larger than
roughly 429 KB.

Should this use 64-bit division or shift the byte sizes down to page counts
before calculating the fraction?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424203448.5040=
-1-ravis.opensrc@gmail.com?part=3D1
