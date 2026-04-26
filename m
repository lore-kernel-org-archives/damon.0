Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DF30B50F
	for <damon@lists.linux.dev>; Sun, 26 Apr 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777241050; cv=none; b=At75xltmsi05Yczk4agFXUYzlwNaSkz6L2WwuVN/rZC9F7NLpO/1y2oRRi3HQPtHuBskgJFpE2O7dhJtl9Pw7caFOO4B1kce6WMhlQQBdS+IJNKlNqmzx87h1to8k8Zk7XD7UbQlm0u9mhjFWR17llnkYTaC0ud1hM2Ha62xs3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777241050; c=relaxed/simple;
	bh=ICSCqO+eCaERVOShAoqNpBTc6Wxu4AQJkUeIfIIgds4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V+YMiUZy9bLk+Wq6lg1XPtD990VkpR3lHuQXvAjG8mQAWBHkacPajyT6uCNVzXmpsvYTsEceTRu9OaVPhAIPZddRYzEMbeNi8jpaR3yvG/06uNNSFTKoG7NAVpLPW6KsB+sVY4Gyhozr1oAu2KS7TXJPMXdpdwz6KmDFkUrzsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIJlGryR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIJlGryR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B26C2BCAF;
	Sun, 26 Apr 2026 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777241049;
	bh=ICSCqO+eCaERVOShAoqNpBTc6Wxu4AQJkUeIfIIgds4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IIJlGryR6WI28E49Ilun18rLGWBkMA6l8nTKgC2n8kInME/2Ui1wz1IAkj6PdkHVa
	 yqwEnmVzfc17zkn2sZTETOZer9SkJM+ZWkEGMda2/agYw6+rgW6EvuF4s15Wg7WxDw
	 ijrKBsJaOyBNbkJz4v2pI+fhNvxyamgvCxymd7ETai53PY1IKe7tNuUJodNnaOoyJc
	 Nlj3v/rWgkeHGQpXidWLcC2Szw9DKn1HLE7JRG1ZuzmHKeH0UGG2ZBHqeFLZVQd8bN
	 xXe8JqiCJhlTg6Z8LUsVOlQpVAY9zo+8Xi27aWQ5DuHUA7s4NaBRqowi6ygKHUV5HK
	 rXWCMgMYnIcbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] mm/damon: add node_eligible_mem_bp goal metric
Reply-To: sashiko@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260426213859.1835-1-ravis.opensrc@gmail.com>
References: <20260426213859.1835-1-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 22:04:08 +0000
Message-Id: <20260426220409.95B26C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 4 potential issue(s):
- [High] Missing `cond_resched()` inside the inner address-scanning loop ca=
uses CPU soft lockups.
- [High] Direct use of `mult_frac()` with 64-bit `phys_addr_t` causes a lin=
ker error on 32-bit architectures with PAE.
- [High] Integer overflow in `mult_frac()` on 32-bit systems without PAE le=
ads to incorrect metric calculations.
- [High] Unbounded O(N) page-by-page memory scan in quota evaluation breaks=
 DAMON's low-overhead design.
--

commit 078c85e7912c268fbbe87930fc285713a5b57d05
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon: add node_eligible_mem_bp goal metric

This commit introduces a new DAMON quota goal metric,
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, which tracks the ratio of scheme-eligible
memory on a target NUMA node compared to total system-wide eligible memory.
It operates by exhaustively scanning the physical address ranges of eligible
regions to determine folio NUMA locality, returning the ratio in basis poin=
ts.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff71..b23b6bd53aba 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2287,7 +2306,111 @@ static unsigned long damos_get_node_memcg_used_bp(

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
> +
> +			/* Convert from core address units to physical bytes */
> +			addr =3D (phys_addr_t)r->ar.start * c->addr_unit;
> +			end_addr =3D (phys_addr_t)r->ar.end * c->addr_unit;
> +			while (addr < end_addr) {

Does this unbounded page-by-page scan break DAMON's low-overhead design?

This inner loop iterates through every single page in all eligible regions
during the frequent quota adjustment cycle. Scanning massive memory pools
(e.g., hundreds of GBs) requires hundreds of millions of synchronous atomic
refcount operations via damon_get_folio().=20

Should the NUMA distribution be estimated using sampling or region sizes
instead?

> +				struct folio *folio;
> +				phys_addr_t folio_start, folio_end;
> +				phys_addr_t overlap_start, overlap_end;
> +				phys_addr_t counted;
> +
> +				folio =3D damon_get_folio(PHYS_PFN(addr));
> +				if (!folio) {
> +					addr =3D PAGE_ALIGN_DOWN(addr + PAGE_SIZE);
> +					continue;
> +				}
> +
> +				/*
> +				 * Calculate exact overlap between the region
> +				 * [addr, end_addr) and the folio range.
> +				 * The folio may start before addr if addr is
> +				 * in the middle of a large folio.
> +				 */
> +				folio_start =3D PFN_PHYS(folio_pfn(folio));
> +				folio_end =3D folio_start + folio_size(folio);
> +
> +				overlap_start =3D max(addr, folio_start);
> +				overlap_end =3D min(end_addr, folio_end);
> +
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

Can missing cond_resched() inside the while loop cause CPU soft lockups?

Because cond_resched() is placed outside the inner loop, and DAMON regions
can span hundreds of gigabytes, the kdamond thread will monopolize the CPU
for millions of iterations without yielding. Should a cond_resched() be
added inside the address-scanning loop?

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
> +	return mult_frac(node_eligible, 10000, total_eligible);

Can this cause a linker error on 32-bit architectures with PAE?

On 32-bit systems with CONFIG_PHYS_ADDR_T_64BIT enabled, phys_addr_t is a
64-bit integer. The mult_frac() macro performs native division using the
type of its arguments. Since the kernel does not link 64-bit division
routines (__udivdi3) on 32-bit platforms, this will cause a build failure.

Could this also cause an integer overflow on 32-bit systems without PAE?

When phys_addr_t is a 32-bit unsigned integer, the multiplication
node_eligible * 10000 is performed in 32-bit arithmetic. If node_eligible
exceeds roughly 429 KB (UINT_MAX / 10000), the multiplication will silently
overflow, producing an incorrect ratio.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426213859.1835=
-1-ravis.opensrc@gmail.com?part=3D1
