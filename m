Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0E145B3F
	for <damon@lists.linux.dev>; Sun, 26 Apr 2026 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777164822; cv=none; b=LCoiuId6vjx/FDIXJu9emX4Ozyz9kYgxJ+nZvX26pxrIEZ4+VNcK+rzAbtVZwSf8F7/IiCi527IYFT3+kOnrd2oGkdq5pq31Q37LhnLOdDvrZtFpBiDEUDkHKHWwqwOvza3iUVWJ+ffR+jKMYeRruOVNthZdPWAa7ZFYcgfUQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777164822; c=relaxed/simple;
	bh=yg7wG7tPl0dZVMy2nfdLDMqX3ELAAL+gkVj2u0lAPIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EuZExt/JoWX+g4f9n1dmKQSQYv9RLB3agEez4tgZYVJUrCGsr7CJ9Uoh3onu6dVSkHd0M4P3Ymg6TGENpCwr3FFVV+LMV0LzDhSEDPN+sS8rsyfaKitUI5GmWlKwzQ7LXGUMzmgFujOkpZ3Cp1RjW8WQ3Ut2geAYhUOvi661ymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtsvta2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtsvta2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B393EC2BCB0;
	Sun, 26 Apr 2026 00:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777164821;
	bh=yg7wG7tPl0dZVMy2nfdLDMqX3ELAAL+gkVj2u0lAPIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mtsvta2QlfXrLd74fxHHCR6v0AMr0o/qmMszMrIbPZOVOcJMIDan2X9gU8SdfvjXE
	 5QTdDRgYyfv7ZegwhO9WaWFvuwNRHefpmkckUiI0mtVbV8sEnLmf3rrh2clTvKLu4K
	 ij8mj5CcSDBQJixbNQR6AVP3NQOK7ZE6jNMHVG5Pe1CMuvNZvbg61G4RuxS+TyRg5P
	 9l4qFUlXy19waKR4V3xHpwjUCTOG+u639GFe5LLwYMrCKx+agNcZy3Zl59686YJwK0
	 +iodtT7xJr1EvTMyOzxzQl9X5aYXRM5YrLJfPNBzLxUkOSCYxnpZHyIBn6Js0prCZ1
	 UrmJD4aXK8zdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] mm/damon: add node_eligible_mem_bp goal metric
Reply-To: sashiko@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260426003245.2687-1-ravis.opensrc@gmail.com>
References: <20260426003245.2687-1-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 00:53:41 +0000
Message-Id: <20260426005341.B393EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 4 potential issue(s):
- [High] Casting phys_addr_t to unsigned long causes truncation and potenti=
al divide-by-zero on 32-bit systems
- [High] Missing cond_resched() inside the PFN-scanning loop leads to CPU s=
oft lockups
- [High] Synchronous O(N) full-memory scanning defeats DAMON's bounded-over=
head design
- [Medium] damos_calc_eligible_bytes() skips core filters, corrupting the m=
etric calculation
--

commit efcd6d55e5292f8b5cd0c6202c9d95000e99dc4c
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon: add node_eligible_mem_bp goal metric

This commit introduces a new quota goal metric, DAMOS_QUOTA_NODE_ELIGIBLE_M=
EM_BP,
to track the ratio of scheme-eligible memory on a specific NUMA node. It
implements calculation functions that iterate over eligible regions and exa=
mine
the NUMA node of each folio.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff71..a9303a8c4384 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2287,7 +2306,112 @@ static unsigned long damos_get_node_memcg_used_bp(
[ ... ]
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

Does this also need to check damos_core_filter_out(c, t, r, s)? By skipping
the core filters, the eligible bytes calculation might erroneously include
memory that the scheme is explicitly configured to ignore.

> +
> +			/* Convert from core address units to physical bytes */
> +			addr =3D (phys_addr_t)r->ar.start * c->addr_unit;
> +			end_addr =3D (phys_addr_t)r->ar.end * c->addr_unit;
> +			while (addr < end_addr) {

Since DAMON is designed to provide low, constant-overhead memory monitoring=
 via
region-based tracking, does performing a synchronous PFN-to-folio lookup for
every physical page across all eligible regions break this bounded-overhead
contract?

Because this function is called on every quota reset interval, scanning
potentially gigabytes of memory might introduce severe latency spikes and C=
PU
overhead.

Additionally, since DAMON regions can cover extremely large areas of memory,
should cond_resched() be called inside this inner while loop rather than
outside it? Iterating through millions of pages without yielding might trig=
ger
RCU stalls and soft lockups.

> +				struct folio *folio;
> +				phys_addr_t folio_start, folio_end;
> +				phys_addr_t overlap_start, overlap_end;
> +				phys_addr_t counted;
> +
> +				folio =3D damon_get_folio(PHYS_PFN(addr));
[ ... ]
> +
> +				/* Advance past the entire folio */
> +				addr =3D folio_end;
> +				folio_put(folio);
> +			}
> +			cond_resched();
> +		}
> +	}
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

Can casting total_eligible from phys_addr_t to unsigned long cause a
divide-by-zero on 32-bit systems?

On 32-bit architectures with PAE, phys_addr_t is 64-bit while unsigned long
is only 32-bit. If the total eligible memory is exactly a multiple of 4GB,
the 64-bit value passes the if (!total_eligible) check, but the truncated
32-bit value passed as the divisor to mult_frac() evaluates to 0, which
would trigger a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426003245.2687=
-1-ravis.opensrc@gmail.com?part=3D1
