Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD312D5C7A
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269632; cv=none; b=ft2x/7gdGxgXNV2SRsUIbcx82nPtMxweUfXsw4KeNCJYi8iuEtVVGpeCfeUX3saALz8kuWpOLS5+m4OU4z21Lo8nCF6Gl8lLvyI+mlbk4XG/ie+vT+A2Shyt5zr8tMujPVJDGEPOiJKx4N2nj4YsQgNyoGmfBMKQ2bUa59C2eaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269632; c=relaxed/simple;
	bh=SM30qTsBwfhfYmr8OWxmxj6LpZp5LCkUbZIyhEP8t0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUAu8ut1VPoN76Rf1BhiHsSYH+NVDnWEkRsqpMgyH9DKzem7E7Qc4QIDCXbaHwxthKpOnoIbeDrl0mfmdaE5fnB5gF0T/pJTcdAe+o6nEFLzFshEAQUOQJtxgur5C9CaVVPKn2HbkexAd1hoPQquKFA/RweVtl8aMMPrYgLreiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+1EHC/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+1EHC/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66F41F000E9;
	Tue,  1 Sep 2026 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269630;
	bh=t9+vxAPsifUkfbKzd06GXtS3wo/vsXJE99FOh4ZxouU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+1EHC/lPkkowC9JAYkwFnHBz9RbqmO6oP0+Ni9/itL+JsJJu13q9Yg2EeRv3Y4Gn
	 92YilG3ZI6uNn5vJAcrvnIJWpV5xIIzF0tltaYuiwKpB/8wfYWsLm99VnnCIdLh3UM
	 PNfBGuw3Bnz/8igxGH1pBIaSTbImulB7DDLVsUUPCQkKwQbeKruWsQ00Gow2e6qj1z
	 Hw+OKLabUQ6MkGCyKdnRHBZcZVODfPsRc7qCWLTnWXWtQ5H3tgkSFuMuDuJjAXbxDZ
	 fI9CvedcLgAzquEM98kjby+llgPCkFyDx7c8e1Fcu3I9XkAfLGrf79kQyp1tERl2hv
	 F5vXcFCgclxuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] mm/damon/vaddr: respect folio end for DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131326.97615-4-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
 <20260901131326.97615-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:33:50 +0000
Message-Id: <20260901133350.B66F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For applying DAMOS_STAT action to a region, DAMON virtual address space
> operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
> pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
> filters to folios of addresses of the region in the pmd.  It starts from
> the walking address and advances the address by the size of the folio of
> the address until it goes out of the pmd or the region.
>=20
> Let's suppose it is for the first pmd of the region, and the region
> start address is in the middle of a large folio.  Also, the next folios
> are small.  Then, some of the next folios could be skipped.  Fix the
> issue by advancing the address to exactly the start address of the next
> folio.
>=20
> The user impact is that the DAMOS_STAT-based page level monitoring
> results become inaccurate.  Since the page level monitoring is supposed
> to provide relatively high precision, this is definitely a problem.  It
> is arguably not critical since it is only monitoring quality
> degradation.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
>=20
> Fixes: 63f39737d1e3 ("mm/damon/vaddr: support stat-purpose DAMOS filters")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131326.9761=
5-1-sj@kernel.org?part=3D3

