Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA03313283
	for <damon@lists.linux.dev>; Fri, 22 May 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466700; cv=none; b=fSoeyiMkZC10910x+mPOlOe+fGpzt3+BU2Hc58rltmzq9EssR2RTf7QuzqfUflwTQD80si+kMOACiu6ps6NY3Nx/Prt7/8CUw83OqkCOw6hs+d1z2brIMYNbXMi7Y6IkFkCUqEZzzyGorl9EqPzJupEJ/W785JMku0P/2RJ69ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466700; c=relaxed/simple;
	bh=SOdBvT6mMugBaEjR/3TxHLH5f31XC42dW/c1GFH0tTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n+VFJGLxrs0MRPsSJKjt5WWnawO2NQOBokq/9OqrXjQaqpoFyX/kBmj9SE4jtKB0Hl35h/dEmE+j5SSHkvtx/1uYPr4W/4E38mtbCrWhWP9e4nXdFDB2/ZcaEpt1swAS6F4Ix3mZs1ZCiRLTlszc3KAQGsrtbuGUMHjG+CHKuic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEkXGjB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEkXGjB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D5B1F000E9;
	Fri, 22 May 2026 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779466699;
	bh=q4ARohaFY1xs0ckaQXfd6HJ0eQQRZ/fc9O5iW/Z5gRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEkXGjB+n7jqr+zA07HAtaKHWoIn2ybg9q+W/TFpvIILB+iZ8UAUpCfEB/oziXOjm
	 9KJj0/2xOoH49lkx3BjwboIu6VBJOQ0AlkUXoMWRz1VQoLpOiQ2GhK1ZsSlmkmd+Ha
	 T5iFy87LsQKalkSQ2yTT0Up7Kl/0qMWrc4ptx1kxWk5SScKd1DYmzXSQ/cCLEu79Sh
	 rZRb+SglkyLU2HeH81WaBWwuPbEM1VXeBGyCMXgZwEeUZ2G3pPJJTKpVfP4tBQGhFt
	 VwVSRB/ZOJor7F8MbIBurJguudyldV+J1qYduMHMCK6D6io/km8m++kr/7e9+Q2G+H
	 +YXXgL4FOCGpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/14] mm/damon/core: safely handle no region case in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260522154026.80546-2-sj@kernel.org>
References: <20260522154026.80546-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 16:18:18 +0000
Message-Id: <20260522161818.D9D5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ALIGN() macro on a user-provided 'end' address can overflow, resul=
ting in a region with start > end.
--

commit 89557cdc68b6d3d7150e7aa8e4bfee900340a83d
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: safely handle no region case in damon_set_regions()
   =20
This commit refactors damon_set_regions() to explicitly handle the empty
region list case. It avoids relying on the internal implementation of
damon_first_region() which expects a non-empty list.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 68b3b4bbc8fc9..8360cb4c506ef 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  			damon_destroy_region(r, t);
>  	}
> =20
> +	if (!damon_nr_regions(t)) {
> +		for (i =3D 0; i < nr_ranges; i++) {
> +			r =3D damon_new_region(
> +					ALIGN_DOWN(ranges[i].start,
> +						min_region_sz),
> +					ALIGN(ranges[i].end, min_region_sz));

[Severity: High]
This is a pre-existing issue, but since this new block relies on the same
alignment logic, could the ALIGN() macro on the user-provided end address
overflow?

If an end address is close to ULONG_MAX and sysfs input produces a
non-power-of-two min_region_sz (e.g., 1365 from an addr_unit of 3), the
bitwise operations in ALIGN() can corrupt the address. Furthermore, even wi=
th
power-of-two alignment, a very large end address could integer-overflow and
wrap around to a small value.

In these scenarios, damon_new_region() would be called with start > end. Si=
nce
damon_verify_new_region() only warns and does not prevent creation, could
damon_sz_region() compute an enormous unsigned size? This appears like it m=
ight
trigger cascading integer overflows in DAMON's core logic and lead to severe
memory corruption when passing massive lengths to madvise.

> +			if (!r)
> +				return -ENOMEM;
> +			damon_add_region(r, t);
> +		}
> +		return 0;
> +	}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522154026.8054=
6-1-sj@kernel.org?part=3D1
