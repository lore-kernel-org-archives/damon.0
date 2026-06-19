Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40B39F19F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898473; cv=none; b=uN5zJuCiMVkkF5NYUQqNkLGR9ixtCIlbQoRjruqmERtC9WHX1E3sbdBTLltsu7wr3Z59AGeEXDLhdcULdlWNUnRgfR72wZS9PFBhst3OSpHnS03rVdDQAYo9gPrk1A/JZU9irhUEY0OTMorI5SyUxSs1z5/ivTF7kN5UK4rwtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898473; c=relaxed/simple;
	bh=0Jy+/OoxLaLiXPEWXVDbMK2T+Icwd5VDFEVXbPslbOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=luK9sNt2xpLdr/pYrtnuwtBrUSaXADHEoxQotz6mxR5jGJ9pTtAAUA5ceAkteGqLmnqzd6JVqhCusqfMmLgtRB10s1wO7ygExyeyNguX16hmOn3YO+RAZJa0BNphJkiNWG5UhpbPZTP6pi0NcBQtBhpQpzDRtPBzhAF0rcS3UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpZTo97Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpZTo97Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30821F00A3A;
	Fri, 19 Jun 2026 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898470;
	bh=iqD0yO9XvvMNydS8kspKMmuK39hbI7Li/84FeUTsWnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpZTo97QbgFHJi0MSpSq1NEZCI7UxJI2YQuRN19ODaFCl+2wI6NUlFcT6P4S/6Clu
	 zhh+kN5rckfraSf3FnCDlfhPWRtTvp/K3JabV9P7BOwHI1S4IwhnF1k4/CdU6DJZV5
	 4EFfoLZQqzUThHdcOZ94vUSneJ51ZaSBlwUDK++16Kiyrf6lRx8sDP/CL3vok7bYR3
	 umOlO3juynelZyLQ/0x/QAmXkHyGOoX/6cq26ivGbVyUHDolJcf1683KtnQlw2QlHY
	 6OBIiWCqEdDJBHAhSXqTc3gokKnRSBELvU65hEdp2j4ZTxFne9+h1h/JljNNzvyR7v
	 HBAr2vakI+DQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/13] mm/damon/sysfs-schemes: use
 damon_nr_accesses_mvsum() for damo regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-6-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:47:50 +0000
Message-Id: <20260619194750.B30821F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `damon_nr_accesses_mvsum()` triggers a division by zero ke=
rnel panic when `aggr_interval` and `sample_interval` are configured to 0.
- [Medium] Integer overflow in `damon_nr_accesses_mvsum()` on 32-bit archit=
ectures when `window_len` is large.
--

commit 66c2d8d0e11cf5ef0032d41b0f9dcf8d2fd41a3b
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions

This commit updates the DAMON sysfs interface to use=20
damon_nr_accesses_mvsum() for scheme-tried regions instead of reading=20
nr_accesses_bp directly.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..e648b0f809332 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -159,7 +159,7 @@ struct damon_sysfs_scheme_region {
>  };
> =20
>  static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
> -		struct damon_region *region)
> +		struct damon_region *region, struct damon_ctx *ctx)
>  {
>  	struct damon_sysfs_scheme_region *sysfs_region =3D kmalloc_obj(*sysfs_r=
egion);
> =20
> @@ -167,7 +167,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_=
scheme_region_alloc(
>  		return NULL;
>  	sysfs_region->kobj =3D (struct kobject){};
>  	sysfs_region->ar =3D region->ar;
> -	sysfs_region->nr_accesses =3D region->nr_accesses_bp / 10000;
> +	sysfs_region->nr_accesses =3D damon_nr_accesses_mvsum(region, ctx);

[Severity: High]
Could this new call trigger a divide-by-zero kernel panic?

If a user configures both aggr_interval and sample_interval to 0 via the
DAMON sysfs interface, damon_set_attrs() accepts these values. During the
calculation of the moving sum in damon_nr_accesses_mvsum(), window_len
evaluates to 0:

mm/damon/core.c:damon_nr_accesses_mvsum() {
    sample_interval =3D ctx->attrs.sample_interval ? : 1;
    window_len =3D ctx->attrs.aggr_interval / sample_interval;
    ...
    left_window_bp =3D mult_frac(left_window, 10000, window_len);
    ...
}

Since window_len becomes 0/1 =3D 0, the subsequent call to mult_frac()
performs a division by window_len, which would crash the system.

[Severity: Medium]
Also, does this calculation cause an integer overflow on 32-bit architectur=
es?

The mult_frac macro expands to (rem * 10000) / window_len. On 32-bit
systems where unsigned long is 32 bits, if the aggregation interval is large
and sample interval is small, window_len can exceed 429,496.

As rem approaches window_len, the intermediate multiplication (rem * 10000)
exceeds ULONG_MAX and wraps around, corrupting the moving sum access
statistics.

>  	sysfs_region->age =3D region->age;
>  	sysfs_region->probes =3D NULL;
>  	INIT_LIST_HEAD(&sysfs_region->list);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D5
