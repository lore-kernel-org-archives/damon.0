Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411B3B7B70
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688499; cv=none; b=qIohHE8xI6XUvhrlYwUP+Ja2l89WYPh+Nq4OFBZafuREPrOwgBakyX9At+baxcH0OC0LVahvhUSIhePyOg2HisNf4VJk1hBx2+Zh1/r7cuKDMEuRG7i36vHx+i5uu6Z2xMBhuffe0LDGjTTjzC92MHFOCqen2bcsaOOiv9mjgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688499; c=relaxed/simple;
	bh=vq9efTEh+k7nSZIeJH4h/VYDdWXctvXi588kuVQuCGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B9ivO20EaE+LTI1dFgLZECJLDTudOWMKN+rnYBix/y78T4XE+gPtN9ueINW3e8YddcwXGBvzQwgVC2lWY+QaJWTXUK6x/CbFBziNYbk3MfpI+GtVgJ5Joj2ZofJI2V63brJ73BNMfuLlAZaGT6FrDlXZI+YCIPyRrrLjTfmam94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEqxy3mo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEqxy3mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108881F000E9;
	Sun,  2 Aug 2026 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688498;
	bh=eR3VGJUPGk/QglWxB2ORdQ4kH3OE3Xnui3Vj+0goIJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEqxy3movLj+wHXn06snV0gXv8NGlSGcM71jEgWBwjQDGrVP0k0LU7oCOxYTrlxpD
	 wh84C/9KaBJPp99qcmYAuRh5dAaBBqMgYkWiW3nPf8qH0t5s/4CHazPNwJt0b9yOdW
	 9/IsUqf9i81/0o9LUKSNkq/7+ykBPyqe6XYpOOmK3oXADRy0/ynEG+qv4WV4p2mvuc
	 LEZVYXJp6h8xnBHqHHiG89FT7CT8zbXFEhOJaPQfmjjLhtA9CddZuEJ1vehbrBkECG
	 UOoYEqLWNVsDOdZ0U1AJ1cH67DXnti2htl8xmzn6Xgd5lvfmT5ZeupL+RQd0YN6xYx
	 F9w106EZRO/yw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 3/9] mm/damon/paddr: respect folio end for
 DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162631.90304-4-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
 <20260802162631.90304-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:34:57 +0000
Message-Id: <20260802163458.108881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch provid=
es an incomplete fix for an address advancement logic bug. While it correct=
s the `addr +=3D folio_size(folio)` issue in `damon_pa_stat()` to correctly=
 align the next address to the end of the large folio, it fails to apply th=
e exact same fix to `damon_pa_pageout()`, `damon_pa_de_activate()`, and `da=
mon_pa_migrate()`.
--

--- Patch [3]: [RFC PATCH v1.1 3/9] mm/damon/paddr: respect folio end for D=
AMOS_STAT ---
commit 99e0c032eda9c903df8d327aa77b989129d9b193
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: respect folio end for DAMOS_STAT

This commit fixes the address advancement in damon_pa_stat(). When a region
starts in the middle of a large folio, it now properly aligns to the start =
of
the next folio instead of simply adding the folio size and overshooting.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -379,7 +379,7 @@ static unsigned long damon_pa_stat(struct damon_regio=
n *r,
> =20
>  		if (!damos_pa_filter_out(s, folio))
>  			*sz_filter_passed +=3D folio_size(folio) / addr_unit;
> -		addr +=3D folio_size(folio);
> +		addr =3D PFN_PHYS(folio_pfn(folio)) + folio_size(folio);

[Severity: High]
This isn't a bug introduced by this patch, but does the same address
advancement logic regression still exist in other DAMON actions?

While you fixed the overshoot behavior here in damon_pa_stat(), it looks li=
ke
damon_pa_pageout(), damon_pa_de_activate(), and damon_pa_migrate() in
mm/damon/paddr.c might still be using the flawed logic.

For example, in damon_pa_pageout():

    put_folio:
		addr +=3D folio_size(folio);
		folio_put(folio);

Could this cause DAMON actions to silently skip sections of valid memory
if a region starts in the middle of a large folio?

>  		folio_put(folio);
>  	}
>  	s->last_applied =3D folio;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162631.9030=
4-1-sj@kernel.org?part=3D3
