Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E840DFDF
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777346743; cv=none; b=moSgNKLxJitqjoowdxEmVIzac/LbfmSfbVbtEdTpm83D4OeJzM6PlbRBXWv86UdsRsYQ7T1LKhNDyC05N/2cpgQqJ5DVfOo2I7Qt9lhujHsWMX6BEa24UvaJrD7SKOOMpuM4OWeMR5OOhY5YWCUbG1giql6DCluLBo1oq787V+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777346743; c=relaxed/simple;
	bh=X/cuvyDbTXTxRe6268v8cLzL+y4JEg0qtpSQEr5xOhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJKRY4mFBfXG4iGGFX/AHqeWkRiPbku9S5vxnInh6VD67seZZxebRS1lWB/9yWi/mDPRPkHtANgfixKG/j5ng6KzlbklZnix9/K5PY8ADKB0Zrbft5nI9qUg3oBGrUO4e8qbGXA0V63Xb4B1J3gC/SjZSaBsf0rHeA9MFfe9hQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUFGg6Ou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUFGg6Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E37C2BCAF;
	Tue, 28 Apr 2026 03:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777346742;
	bh=X/cuvyDbTXTxRe6268v8cLzL+y4JEg0qtpSQEr5xOhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fUFGg6OuRMiInESZBT4Hm6aOl0PuK1K9XGArz2u1KIrsPkyNldA14hllfbl69ud5j
	 h+ThuMUHfypBS1yYK92aXrD27OjGJJEnINiBB1A6RX0xYf2W1Ly/KY2CAspBmaED+j
	 H3Tq/xte+N7EEfoM2p7nl7EkrHq9Go5+vRv0UEauhLpB1c0A6mJufcQARCJQ6wnznl
	 t86RLbKojacGux80n1OkEZdQURIGLM3dhkKRptTr3ZKtGGaF1eVxaXcDSVy5/mAkpV
	 wBoul4FNLYGWdUs0mKmAZcD+PhZa+p/m6H3lvLMaPU2unt55QvfAv1spry+sj8LHOF
	 glARf9e61NVQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9.2] mm/damon: add node_eligible_mem_bp goal metric
Reply-To: sashiko@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260428030520.701-1-ravis.opensrc@gmail.com>
References: <20260428030520.701-1-ravis.opensrc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 03:25:42 +0000
Message-Id: <20260428032542.98E37C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 4 potential issue(s):
- [High] Missing `cond_resched()` inside the inner PFN-scanning loop causes=
 CPU soft lockups.
- [High] Casting 64-bit `phys_addr_t` to 32-bit `unsigned long` causes mass=
ive quota calculation errors on 32-bit PAE systems.
- [High] Physical address wraparound of `folio_end` causes an infinite loop=
 and system hang.
- [High] Pre-existing `VM_BUG_ON` in speculative folio access within `damon=
_get_folio()`.
--

commit 377bf0664129c87741fa640c563456b379c8a816
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon: add node_eligible_mem_bp goal metric

This patch enables system-wide page distribution with target-state goals
using PA-mode DAMON schemes. It tracks the ratio of scheme-eligible memory
on a target node to adjust migration aggressiveness. The implementation
calculates the current memory distribution across regions that match the
scheme's access pattern.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff71..9a4220174a61 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2287,7 +2306,115 @@ static unsigned long damos_get_node_memcg_used_bp(
[ ... ]
> +			while (addr < end_addr) {
> +				struct folio *folio;
> +				phys_addr_t folio_start, folio_end;
> +				phys_addr_t overlap_start, overlap_end;
> +				phys_addr_t counted;
> +
> +				folio =3D damon_get_folio(PHYS_PFN(addr));

Since this code heavily invokes damon_get_folio() in a new PFN scanner, cou=
ld
the speculative folio access inside damon_get_folio() trigger a VM_BUG_ON? =
If
damon_get_folio() tests folio_test_lru() before acquiring a reference with
folio_try_get(), the page could be concurrently split or reallocated as a t=
ail
page.

> +				if (!folio) {
> +					addr =3D PAGE_ALIGN_DOWN(addr +
> +							PAGE_SIZE);
> +					if (!addr)
> +						break;
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

If a folio is located at the very end of the physical address space, could
folio_end wrap around to 0? If addr becomes 0, could it cause an infinite
loop since addr < end_addr would remain true?

> +				folio_put(folio);
> +			}
> +			cond_resched();

Could scanning a large DAMON region without yielding the CPU in the inner l=
oop
cause soft lockups? Moving the cond_resched() inside the while loop would
prevent it from monopolizing the processor.

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

Does casting these phys_addr_t variables to unsigned long cause truncation
errors on 32-bit PAE systems where physical addresses are 64-bit? For
example, if the eligible memory size exceeds 4GB, the truncation could
corrupt the ratio metrics and break the quota autotuner. Would converting
byte counts to page counts before casting avoid this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428030520.701-=
1-ravis.opensrc@gmail.com?part=3D1
