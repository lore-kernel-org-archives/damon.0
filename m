Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD175809
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777253070; cv=none; b=jTrR8YkDk/QGRt7oqwiUs9KIwBGW7I/v7yYhMHeXTpPSLJyuNsJeZBQ+7St2cmr+2tnyZM8gZM2R2uzA1k+kwOeFmJz6XuS8RK4x9yMgJsi+ax9arc47ajc4pkhvN6gw6y2gANTzIbXpxct70UAIzV8YVkiYk0f81u5juDW1+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777253070; c=relaxed/simple;
	bh=MeWw30wNvJdp3niYkYNfeknLOTTCV4mu/vb4DmpX/4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g/WP8Qc83ET8yGXXNcC68VVATnPaQKS2xpjQgTsx3vRu9+y9pv5cs4GlzWDp/HyZ/A29j+PxDeHg+WASqly8dU7otrCqJJSriXLdyHnkdQyzuo3yyFHFZK7khEiLY0sDNFb/NJjm2a/GzgkQ3bzAZSNi/5IiqiriK32qkOwU4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDrXye1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDrXye1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C2C2BCAF;
	Mon, 27 Apr 2026 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777253070;
	bh=MeWw30wNvJdp3niYkYNfeknLOTTCV4mu/vb4DmpX/4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tDrXye1F+yB9VyWNEobOG8fzfFFFqi7v1ZbdH6Bo+zHqMColKITbBBaWO7zpwTK/V
	 Wc6YGiz3Nw/Zxqr0npNwld5RK7iOlF8zUsWs94162jT6ikFScvAuIrAR8qlAdQ+TNU
	 ErKnh7dK9xiZnsIUNVrDjJzEXIFTzbm3KMItQmteF7ewKw4PrWXUywczPACCOVMfD0
	 Gn0/Yv3OD3dKnCa1UtUA0rn8RbqMSD0vRl9OFxtwA6vlEPA+4u46a6qIehwn1cckr5
	 0pTbE8axCNQLDx33RUTJQ8bZBfNZi7s2r+9zPvV6JkoZttXMsnmkrL/neZQ25sCyMW
	 8+ne77rt9MSiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9.1] mm/damon: add node_eligible_mem_bp goal metric
Reply-To: sashiko@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260427010209.843-1-ravis.opensrc@gmail.com>
References: <20260427010209.843-1-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 01:24:29 +0000
Message-Id: <20260427012429.D25C2C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [High] Data truncation and arithmetic overflow in metric calculation on 3=
2-bit systems.
- [High] Missing `cond_resched()` inside the inner PFN-walking loop causes =
CPU soft lockups.
- [High] Address advancement logic is vulnerable to wrap-around infinite lo=
ops.
--

commit 10100659661304515a414f3a15324e8278667f42
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon: add node_eligible_mem_bp goal metric

This commit introduces the DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal metric to
track the ratio of scheme-eligible memory on a specific NUMA node, allowing
the quota autotuner to adjust based on spatial memory distribution.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff71..22d6eb3a974d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> +static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
> +		struct damos *s, int nid, phys_addr_t *total)
> +{
[ ... ]
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
> +					addr =3D PAGE_ALIGN_DOWN(addr + PAGE_SIZE);

If a DAMON region extends to the upper boundary of the physical address spa=
ce,
could addr + PAGE_SIZE overflow and wrap around to 0?

If addr wraps to 0, addr < end_addr would remain true, which might cause an
unrecoverable infinite loop.

> +					continue;
> +				}
[ ... ]
> +				/* Advance past the entire folio */
> +				addr =3D folio_end;
> +				folio_put(folio);
> +			}

Because DAMON regions can span tens of gigabytes, could this inner loop
execute millions of times sequentially without yielding?

The cond_resched() is placed outside this loop, which might trigger CPU soft
lockups if a very large region is processed. Would it be better to move
cond_resched() inside the while loop?

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
> +	if (!(unsigned long)total_eligible)
> +		return 0;
> +
> +	return mult_frac((unsigned long)node_eligible, 10000,
> +			(unsigned long)total_eligible);
> +}

On 32-bit PAE systems, phys_addr_t is 64-bit while unsigned long is 32-bit.
Does casting total_eligible and node_eligible to unsigned long discard the
upper 32 bits?

If total_eligible happens to be exactly a multiple of 4 GB, the truncation
could result in 0, causing the function to unexpectedly bypass the check.

Furthermore, mult_frac() performs intermediate multiplication. Even if the
sizes fit in 32 bits, could the intermediate calculation overflow the 32-bit
maximum when node_eligible exceeds ~429 KB?

Would it be safer to evaluate the byte counts using 64-bit arithmetic, such
as div64_u64(), to prevent truncation and overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427010209.843-=
1-ravis.opensrc@gmail.com?part=3D1
