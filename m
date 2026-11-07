Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088357;
	b=Up8JlicTG49uuclhb19Xnb5Tt8gK2SjB4nqa4NnxO+oRYHoB6V9Yu8R+nZ0WGHpNIbF0
	 g+La/SZYchd/I/mL6Ke2UIONEfi86quBBlwz9H9uIgyN+15+uf8YYVV9EQ48K7xmz24AT
	 2iHqVhNL1nFCRkh8ZdkGjYf+aVo3yyBaXQYGXwgb5x0MSbgh6aJI6AKUO0AnyiupovcDc
	 FRJ8dcAxKOTfUBMC9eej0PiCaO8kZLa51vf1sHKDx9zser1pNgUGOc0dDLIWeAB9CYIvC
	 QXvwMUD/PBKSufbOgAzz9HHULK6aJNX8wdfx9RSCyjnNU+rG5Rr5fgMeIBUvRPQ/D3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MTFE5k+b3EPTf9xyiP1cwm3DBnq7vMvtd/XV5WMMTdY=;
	b=Ub49PFH0YCGFNjKPqjviR/8PQEW1gThV45cjyrMq22PGDE7ZIKnptmNkmGm4V0M5FSn0
	 O4Hq/b/ROM02sdl36zJ8YDB5ZcPdUqZWMOgPslR8Bn47DoQgVWQkTL9Owz3fEgc5eaTRF
	 47OdkGQ5IHFuxFZHdPOK763hJcjJER+OZvf8xuTVzG8y7flkdHBwGlNK9SA8P6X1Riiqs
	 RiHzrEhr/ZF+F0v0kNeerDFetJX+suNze6jzvWX3SrCHO3UBK2kFwiPtO6QKvsv5j/MjK
	 LevBg+KWv2s+jvuhg0DiMTb7PfJWo6QsY0XeWotwuGqmMH/wqobwkL0fHMcsfb9Mr/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+RQyBut;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CC606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+RQyBut
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475821F0089F;
	Sat,  7 Nov 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088356;
	bh=MTFE5k+b3EPTf9xyiP1cwm3DBnq7vMvtd/XV5WMMTdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+RQyButyz311+aKUVi3R/oni5G31LOAlqLgmIYGvO45yPVIki9StDy04ib5P03tJ
	 lf3BY8sV1prihECfE6gbUY9LU9qcyosU4coe97/LccZqOSW2DmgoPhjCw4dqxo9w1H
	 tOZVL43VOz30ALf0dXSl9LKZE1iHRIitrsO9dPdW/UdAK61v9qGFve55nc4VVAE1A6
	 8xQJRealNcFQ5+ZS5ZePB0KKmxoPaxllCYnjlIZlWF8SGXXhwrJRATX+QjwitLCw+t
	 1LmpLcNQEk5dOWVgoCG6fRxpRvx8swZw820IV3DEV6J+jCEJSdqBWUxJEWsMhBrCe9
	 gspFPGdYcA0tQ==
Message-ID: <sashiko-outbox-203347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 1/5] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Usama Arif" <usamaarif642@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107214525.304638-2-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
 <20261107214525.304638-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 21:52:35 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/damon/core: inaccurate tried stats on split failure in
  damos_apply_scheme()
--

commit fe019f891ca813eff979dfc83e95ba297bc45135
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip applying scheme if region split for quota fails

This commit changes damon_split_region_at() to return an error code on
allocation failure and skips applying the DAMOS scheme in
damos_apply_scheme() when splitting a region to fit the remaining size
quota fails.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 81d44e41de210..6ef77741b783b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1470,7 +1470,8 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  					DAMON_MIN_REGION);
>  			if (!sz)
>  				goto update_stat;
> -			damon_split_region_at(t, r, sz);
> +			if (damon_split_region_at(t, r, sz))
> +				goto update_stat;
>  		}
>  		if (damos_filter_out(c, t, r, s))
>  			return;

[Severity: Low]
Should this return instead of jumping to update_stat when
damon_split_region_at() fails?

At this point sz holds the non-zero aligned remaining quota, and
update_stat calls damos_update_stat(s, sz, sz_applied), which increments
s->stat.nr_tried and adds sz to s->stat.sz_tried even though scheme
application and filter evaluation were skipped.  Because quota->charged_sz
is not updated on this error path, persistent allocation failures across
subsequent regions larger than the remaining quota will repeatedly add the
remaining quota sz to s->stat.sz_tried and increment s->stat.nr_tried.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107214525.3046=
38-1-sj@kernel.org?part=3D1
