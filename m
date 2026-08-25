Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3044605C
	for <damon@lists.linux.dev>; Tue, 25 Aug 2026 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662719; cv=none; b=ka/HGQlVET/an2joscXy0SEdRT1YyWgN/3w2jONlLbfmq3Ij7tFQENpMJjy7wtiMruI6PfcDaWm20auUcWUO5SYP87hFzKN2HVfQXMeVa2u3U8PTDYqCR7gSloAphrKLdzBtjcHhE3DOCpVClY+vMtIlNu0UKSpi3WhrxVrX7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662719; c=relaxed/simple;
	bh=s4DRubQFy4lqj450xsOu6dxUyIWLPavEY39gLO5EsaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWXOyyVAoM/Yceq4leQJRyRTprFd+4DJV3/3ok7UIG1DIwoTpcO7ur+Aaet594Cb3Da3EMsWJDb3rOfiDslidXVkb+MJoCOX8eT6IXU6FWpkkyBEmgnf8MwBTUjisHaVcgCWe3OL2ShKkXrzwisVTGwM1/QStiWGCNlDNU+EHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9qTcdvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9qTcdvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5001F000E9;
	Tue, 25 Aug 2026 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662717;
	bh=EQQg5UJ2WhyReEv1q0ozru3uz1QscvCQJIOUxCzS9n0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N9qTcdvyAH7PeazwJv6rBVBUFpe6yq44LGTpZvLSeivS0QLWrcPy0F6o4jp6J3ctX
	 8herA2vtjn4cZC/XY8Kfq7ZUE9f5AKKJ3N20K/RvU3tESE93Fgg0YhOgy+YlFG3KjY
	 JywMhQS7McRZ9UWkyK2w96t98y6HoR7wX93S4iqQuWq8obY4dlexp5+pDbnASfGEV7
	 9woHlHYdWBUy0tXYaPLfNauZzMA9rHUJ3aHuqnzNesZHB1SCnCsWhCMHWsl5XPyyLu
	 Sh5yiGDuzzlpWn5D8z2nnyVyMC31YVbdgK/iXvidfW3AHB3Y02hujK530sLCqxCGfk
	 m0o2N45DnSL5g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260825124616.5129-1-aethernet65535@gmail.com>
References: <20260825124616.5129-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:58:36 +0000
Message-Id: <20260825125837.2F5001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The DAMOS rotating walk cursor (`walk_target_from`) becomes perman=
ently stuck if it points to a target with zero regions, silently disabling =
the scheme entirely.
--

--- Patch [1]: [RFC PATCH] mm/damon: fix damos quota walk-position tracking=
 ---
commit f919352b7b1f727f53877f4c9877e9c62ea1cfad
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: fix damos quota walk-position tracking

DAMOS uses charge_target_from/charge_addr_from to remember how far a
quota-limited walk has progressed. This commit treats the fields as a
rotating walk cursor to resolve issues where regions could be skipped or
remain stuck.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..bbdb530513a18 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -404,6 +404,52 @@ static bool damon_is_last_region(struct damon_region=
 *r,
>  	return list_is_last(&r->list, &t->regions_list);
>  }
> =20
> +static bool damos_completely_walked(struct damos *s, struct damon_target=
 *t)
> +{
> +	/*
> +	 * '>=3D' instead of '=3D=3D', because the region set of @t could have =
been
> +	 * shrunken by damon_set_regions() after the cursor was saved.
> +	 */
> +	return s->quota.walk_target_from =3D=3D t &&
> +		s->quota.walk_addr_from >=3D damon_last_region(t)->ar.end;
> +}
[ ... ]
> @@ -2658,18 +2701,31 @@ static void damon_do_apply_schemes(struct damon_c=
tx *c,
>  		if (damos_quota_is_full(quota, c->min_region_sz))
>  			continue;
> =20
> -		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
> -			continue;
> -
>  		if (s->max_nr_snapshots &&
>  				s->max_nr_snapshots <=3D s->stat.nr_snapshots)
>  			continue;
> =20
> +		/*
> +		 * Skip regions before the cursor.  If the skip makes the cursor
> +		 * reach the end of this target, rotate to the next valid target
> +		 * before continuing with the next region/scheme.
> +		 */
> +		if (damos_skip_walked_region(t, r, s, c->min_region_sz)) {
> +			damos_walk_maybe_rotate(c, t, s);

[Severity: High]
Does this code permanently skip all regions if walk_target_from points to a
target with zero regions?

Because cursor rotation only happens here inside damon_do_apply_schemes()
which is called during region iteration, if walk_target_from is a target
without any regions, this code never runs for that target.

When other targets are evaluated, damos_skip_walked_region() will continual=
ly
return true since walk_target_from !=3D t. However, damos_walk_maybe_rotate=
()
won't advance the cursor because damos_completely_walked() requires
walk_target_from =3D=3D t.

Can we ensure the cursor properly advances past empty targets?

> +			continue;
> +		}
> +
>  		if (damos_valid_target(c, r, s))
>  			damos_apply_scheme(c, t, r, s);
> =20
>  		if (damon_is_last_region(r, t))
>  			s->stat.nr_snapshots++;
> +
> +		if (damos_quota_is_set(quota)) {
> +			quota->walk_target_from =3D t;
> +			quota->walk_addr_from =3D r->ar.end;
> +			damos_walk_maybe_rotate(c, t, s);
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825124616.5129=
-1-aethernet65535@gmail.com?part=3D1
