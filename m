Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885230566C
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608464; cv=none; b=bWbSSydDAaq8mfOESxa9+i9zKQFvbZR7YwOxHNT0HBfCOMYUdTfKOgHdAJrW0cb17QPXaM6FfC7stP1dD5aSWjBXV9xc2TMrytLG7Xu9Nz3TkDc0JWLAQi+Yh3p5KnaJcNxu23/IE36j3Sfrumw2DO+7rdS4H8fGtSwcBOl4oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608464; c=relaxed/simple;
	bh=EVRNWtbSMwEPzmBYy4D2+8TxcYH2sDU0bRQij+gjP5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBLP6l4X5NMxTCfZHjWtLxEA4ald5fwSEUQgrTf04pKIVCuj+9S+YaF6ZGben8ucVqDu2bYww60DvSJKBS9e3tOvKdYL4tzQIl5I5UZFgZ0G2ihiX5YsCAr2ucs4J3tQ4P/H9K3SRxuPgL/2KeTejiG7yilOGaubBFy53eiDNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au9nVbGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au9nVbGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB91F00AC4;
	Sat,  1 Aug 2026 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608462;
	bh=1rU734danH9sBWqUZQVpMpubAelMLNYCw5T1D+DyM+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Au9nVbGgBQ4JjCCk0LPxZgS16MfK0os2r6x15xo9ZPapRmp4eM87v2qHsLXl7wxri
	 X8EfGVRmZuuyZVozT8VNVfQx7ZI9eLf9ZL6SoKey3uEynMD/LYzVvndHc/RO2LP1qr
	 f7P6IP2meqSuPEHs/4/EAldMwTB+GrmVE+cKGPqhvGg4cHd1T96keybmS+F7mv065X
	 PH2t9f1E6hmmm4KK+Q1k0shWMaV4bW8ESIunDq5VC+hUSDfd+4AopbO6m9QsMEJYIv
	 H1ah3tqUZgy417bJeTHXGU1hNS3BvkPvEKaeM2k33Iqm0YQh3L4XLmwSJCGpOK7LuO
	 hnFV4y+HyRq6Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/9] mm/damon/paddr: respect folio end for
 DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801173554.94710-4-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
 <20260801173554.94710-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:21:01 +0000
Message-Id: <20260801182102.70BB91F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for large folio address iteration boundary bug.
--

--- Patch [3]: [RFC PATCH 3/9] mm/damon/paddr: respect folio end for DAMOS_=
STAT ---
commit b98d6f7836f4a90b6724f683127a934a339f77d5
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: respect folio end for DAMOS_STAT

This commit fixes an issue in damon_pa_stat() where advancing the address
by folio_size(folio) could skip subsequent folios if the start address
is unaligned within a large folio. It corrects this by advancing the
address to exactly the start address of the next folio.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5c6c3a597fd0b..2ab7b3842701e 100644
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
This is a pre-existing issue, but does this same bug exist in other DAMON
operations that iterate over folios?

For example, looking at damon_pa_pageout():

mm/damon/paddr.c:damon_pa_pageout() {
    ...
		else
			list_add(&folio->lru, &folio_list);
put_folio:
		addr +=3D folio_size(folio);
		folio_put(folio);
	}
    ...
}

It appears damon_pa_pageout(), damon_pa_de_activate(), and damon_pa_migrate=
()
all still advance the address by folio_size(folio) instead of calculating t=
he
exact folio end.

Could these operations also overshoot subsequent memory and skip valid memo=
ry
folios if the region starts unaligned inside a large folio?

>  		folio_put(folio);
>  	}
>  	s->last_applied =3D folio;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801173554.9471=
0-1-sj@kernel.org?part=3D3
