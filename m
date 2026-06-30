Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91B33BBCF
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793165; cv=none; b=mL+9qhh1jze/mpsT6aGnXvk+KHrQ9NIkZSxgvp1USes8T3Pbj+p50kzUBr5GdqP8UoTTIWGhjhngQd7ixCkiSqBhcIhJDIvT2vZOVsoUvB2R0shvRj2o+8yNMOGYSFvNmrtVZ1fyP39imsDEzRrcUAAm4gHYuqdh4GbLm03vBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793165; c=relaxed/simple;
	bh=mn86DsbNftgy2ALijM2P813EMvD626taS7KY+4rj+Ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ooD39ar9WD/n5jBH94SpEUSWX5vT4Xu94LWY6AAnukJhBya0mu3Cw3TKldZc5bW0Wv1s1xjY68KAW46vjM0uf4Vo4c5ejjPt/dfVhVx+ZoSyaptSKH5gHuYlQJ8oIj2piAiPlXaBZMuwEy7QqJrfq1+VnGyM8l5QuUz4DPTEs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqc2ubq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqc2ubq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D851F000E9;
	Tue, 30 Jun 2026 04:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793163;
	bh=Z8KwKXdOcTinaOF0JD37TZZkK0tCOMiN++coqxe9xGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqc2ubq+AEw2UiJIFRg2O8gls+q0f/uBZ8b0cC1aqNINesXe6sgmF4G7UpdEDQES9
	 4L2Rx07/smONx3c3FQ8pRBw25nCmsr4hWukXPhdIccj2nEQoOxZMLZsdpctxWOhR9M
	 plZ6ix8X7HpsTMYjujs1KKNxxqVucLaape6ePScug3ZgGp/cDz143279wSKLLwjmyJ
	 UyU2MYprRvQ0dlKqksBbG0T61HR5R3nlJs51CNlcZSSF0YXLvS2i2XaqmZo6lgK2O+
	 YQ8JzO2gwpMRisfAlSJYMRcizjacS4v+IEMBMANq7tE+ehb2g1HPjRKX0x1qV1gGi0
	 uY9iy3me23FyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/18] mm/damon/core: remove attrs param from
 damon_update_region_access_rate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630040812.149729-15-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
 <20260630040812.149729-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:19:23 +0000
Message-Id: <20260630041923.94D851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Typo in the commit message referencing the wrong function name.

Pre-existing issues:
- [High] Static local variables used for caching access checks cause data r=
aces and cross-context contamination between concurrent DAMON threads.
--

commit 75de4af226707e222be94ee075dde34562b3817d
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove attrs param from damon_update_region_access_rate()

The damon_update_region_access_rate() function does not use the attrs
parameter. This commit removes the unused parameter to clean up the code.

> damon_region_access_rate() is not using attrs parameter.  Remove it.

[Severity: Low]
This isn't a bug, but there's a typo in the commit message referencing
damon_region_access_rate() instead of damon_update_region_access_rate().

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5c2da45f988cf..8530213086691 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -91,12 +91,12 @@ static void __damon_pa_check_access(struct damon_regi=
on *r,
>  	/* If the region is in the last checked page, reuse the result */
>  	if (ALIGN_DOWN(last_addr, last_folio_sz) =3D=3D
>  				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
> -		damon_update_region_access_rate(r, last_accessed, attrs);
> +		damon_update_region_access_rate(r, last_accessed);

[Severity: High]
This is a pre-existing issue, but does using function-scoped static variabl=
es
for last_addr, last_folio_sz, and last_accessed here in=20
__damon_pa_check_access() cause data races when multiple DAMON threads run=
=20
concurrently?

Since these variables are shared globally across all DAMON physical address=
=20
monitoring threads without synchronization, it seems an interleaved executi=
on
could overwrite the cached access state. Could this result in cross-context
contamination where one thread erroneously reuses last_accessed for a=20
completely different memory region?

>  		return;
>  	}
> =20
>  	last_accessed =3D damon_pa_young(sampling_addr, &last_folio_sz);
> -	damon_update_region_access_rate(r, last_accessed, attrs);
> +	damon_update_region_access_rate(r, last_accessed);
> =20
>  	last_addr =3D sampling_addr;
>  }
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index e73ec1ce016e5..2eaced0765e26 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -501,19 +501,19 @@ static void __damon_va_check_access(struct mm_struc=
t *mm,
>  	static bool last_accessed;
> =20
>  	if (!mm) {
> -		damon_update_region_access_rate(r, false, attrs);
> +		damon_update_region_access_rate(r, false);
>  		return;
>  	}
> =20
>  	/* If the region is in the last checked page, reuse the result */
>  	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) =3D=3D
>  				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
> -		damon_update_region_access_rate(r, last_accessed, attrs);
> +		damon_update_region_access_rate(r, last_accessed);

[Severity: High]
This is also a pre-existing issue, but do the static local variables in
__damon_va_check_access() present the same data race risk?

When multiple concurrent kdamond threads check virtual memory accesses, they
share these unprotected variables. If identical virtual addresses exist in
different monitored processes, could one context reuse the last_accessed re=
sult
from another process due to interleaved thread execution?

>  		return;
>  	}
> =20
>  	last_accessed =3D damon_va_young(mm, r->sampling_addr, &last_folio_sz);
> -	damon_update_region_access_rate(r, last_accessed, attrs);
> +	damon_update_region_access_rate(r, last_accessed);
> =20
>  	last_addr =3D r->sampling_addr;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630040812.1497=
29-1-sj@kernel.org?part=3D14
