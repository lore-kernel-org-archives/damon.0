Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D036AB57
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972334; cv=none; b=c/7HxAv2yApMh9aRkJfruQ1IWBjdKHipCeiWTlZURU2K+N0dKKHigr9qc0ZTgdCTLi2jaz+PX2hOi60VGNVhBERF8rG4Z0odWOEaA/pwkQUiQSX0mcTPFzryUq7m9VgSs9gvm6F5dErRosoFJt7BgsiZq6UgeLZ4jvKa7H6KIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972334; c=relaxed/simple;
	bh=37t3Kkt3Ret9y1EncGVsOaO0HJRisTd14ss3ua8C0ro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nGGgeK2Ow5vjLQzHyUKBYcbQhvWA03uXQOM3lph6r534ZwelcgcaFMLYsDYYe5bmtxFIZw5T2Dbsq0GC/Sa2qtRlsatzIZqBsYFbaM1Oz8VSMiETVfYszEfOvAV1I/JQyOTDIgqhJMyG5p5IBNE39s3N6X9Oawxf5MqYv4vQLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a17RQHBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a17RQHBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300CEC2BCB2;
	Thu, 23 Apr 2026 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972334;
	bh=37t3Kkt3Ret9y1EncGVsOaO0HJRisTd14ss3ua8C0ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a17RQHBbzryEklp+snCm0O+jvsGfx4gj038uEtAG7c8m2vGhXN8agskThBGVHwua+
	 vEKDzLz2VbbNUG1R83y0lygrrr6OHvhaMVoE47s3QsJbpAgrEF2YNig5eyNwVNbnyV
	 X++stiSQn08VqbO/3ZNcDaAcz9H1Rbg/GuOTzvzDsRZ8YECLDbXupCZ5LcBDb3F/tk
	 r7dxnhJA7nQRn0IZTxM0o5huRQitTv1bklKN17av8V2bNl61OpUtxascKqQQjB5num
	 KmY12OSRS8dHGxfaGpJBzp0gK92Xq3macxYcj6vgZvHHpdtVzrhnoTALzifodOJAoj
	 iipSMLMgI8prw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/paddr: prefetch struct page of the next
 region
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260423122340.138880-2-jiayuan.chen@linux.dev>
References: <20260423122340.138880-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 19:25:33 +0000
Message-Id: <20260423192534.300CEC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Unsafe use of `pfn_to_page()` on unvalidated PFNs causes kernel pa=
nic on SPARSEMEM configurations without VMEMMAP.
--

commit 8abf0dd953e91eace9153afe00585b922bbe2751
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon/paddr: prefetch struct page of the next region

This commit introduces software prefetching for the next region's struct
page in DAMON's physical address mode to reduce cache misses. It uses
pfn_to_page() instead of pfn_to_online_page() to avoid the serialization
costs of looking up the memory section, expecting prefetchw() to safely
drop hints for unmapped addresses.

>   - pfn_to_page() rather than pfn_to_online_page(): on
>     CONFIG_SPARSEMEM_VMEMMAP the former is pure arithmetic
>     (vmemmap + pfn), while the latter walks the mem_section table.  The
>     mem_section lookup itself incurs a DRAM miss for random PFNs, which
>     would serialize what is supposed to be a non-blocking hint - an
>     earlier attempt that used pfn_to_online_page() saw the prefetch
>     path's internal stall dominate perf (~91% skid on the converge
>     point after the call).  Prefetching an unmapped vmemmap entry is
>     safe: the hint is dropped without faulting.

Does this logic hold for systems using CONFIG_SPARSEMEM without VMEMMAP?

While it is true that pfn_to_page() is pure arithmetic on VMEMMAP, under
classic SPARSEMEM it requires a section lookup to evaluate.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index b5e1197f2ba22..99bdf2b88cf19 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -48,10 +49,29 @@ static void damon_pa_mkold(phys_addr_t paddr)
>  	folio_put(folio);
>  }
> =20
> +static void damon_pa_prefetch_page(unsigned long sampling_addr,
> +				   unsigned long addr_unit)
> +{
> +	phys_addr_t paddr =3D damon_pa_phys_addr(sampling_addr, addr_unit);
> +
> +	prefetchw(pfn_to_page(PHYS_PFN(paddr)));

Can this cause a kernel panic on CONFIG_SPARSEMEM configurations without
VMEMMAP?

In DAMON paddr mode, target regions can span physical memory holes. Since
damon_rand_fast() selects a random physical address, it might select an
unpopulated area.

If the random PFN falls into an unallocated section, __pfn_to_section() will
be invalid. Attempting to read the section_mem_map from it will lead to an
immediate NULL pointer dereference in C code before the prefetchw instructi=
on
is ever reached.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423122340.1388=
80-1-jiayuan.chen@linux.dev?part=3D2
