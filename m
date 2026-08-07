Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F293CFF5E
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096126; cv=none; b=TgOZGNLJWrytj+swGA2iV1xniKr+tmLNgsWEoUNObjrfykG6vobBwR7EY8GRpDNlK62uItJgisQCMO/oPx8SeFffRWaNqJdpyjuOdiYpo2UfeeQ9QMj2tNxwE04H38VcieHzLTRVliiWyWiaS5fW2gd8lyRdfcCDdFvMpMnBFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096126; c=relaxed/simple;
	bh=5SgX9EuEvtaPuz+QO4mWkd/2wwx//wvtQo89wnHULgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E3nkb9CyVMIwm5PLLqu9SVUGkL3jx2yLjzHq0hVicChqRxoWAyUmkKZ3qlMU0ea5jISblXEjZhq+n86H4A0Z0L8wtLaYiClWKXxsNlXu3O6jkbBhgXlH3na+VVsHAcm8Ppta2qtynuAZjOk2qqh5wQzYWM+iwVQPBUfVcMbDFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkY5EPRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkY5EPRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801671F000E9;
	Fri,  7 Aug 2026 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096123;
	bh=YxuZbci4/B8gQGPUzKDFqGXaMJCJZRj0rRRUDJYj0k4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UkY5EPRQvHpqV4pwcYP2jjnfwIAeUsLU6RIe5ayIEoD+9RaDc2AxXyov6M3LYc1uN
	 34v5ssTL5ymuRFnsnHOSGFDqb+D5w/3BQIvScn4tsCmqF1uqVvii8a4lp+ZYk07kA7
	 P3OZKnOvhu/xzsL8kyRGc771jTpskvMXDxyXmJeZLbtVFnjA21Sm0XIVoa3o/UF3/z
	 A21/WEKZRO1PZG2PBnMNXy0PjVmlflP6v9oZcrdh4JR7BmEG0hB5oO8HHD+cdsaHNv
	 XxQovlbMfMzAcsHBDikxbYErXQtCZkdhSay/zcXYdyCRpOa/KF4Ph8ZfmND0hMflOC
	 SPHiiMEA2F9WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon: fix nr_snapshots counting using
 tried_applied flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260807093526.183009-2-aethernet65535@gmail.com>
References: <20260807093526.183009-1-aethernet65535@gmail.com>
 <20260807093526.183009-2-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:48:43 +0000
Message-Id: <20260807094843.801671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Logic error: `tried_applied` is set unconditionally, ignoring the =
access pattern guard check.
- [Medium] Uninitialized boolean `tried_applied` in `struct damos` leads to=
 spurious `nr_snapshots` increment.
- [Low] Build failure due to removed function `damon_is_last_region()` stil=
l being referenced in KUnit tests.
--

--- Patch [1]: [PATCH 1/2] mm/damon: fix nr_snapshots counting using tried_=
applied flag ---
commit b2745ffce878c131daca165cb2a6674f9ded0bc7
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: fix nr_snapshots counting using tried_applied flag

Currently, nr_snapshots is only incremented when damon_is_last_region()
returns true. This is semantically incorrect because nr_snapshots should
count the number of DAMON snapshots (aggregation intervals) where the
scheme was tried to be applied, as documented in design.rst.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..7230483e771f7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -398,12 +398,6 @@ static void damon_destroy_region(struct damon_region=
 *r,
>  	damon_free_region(r);
>  }
> =20
> -static bool damon_is_last_region(struct damon_region *r,
> -		struct damon_target *t)
> -{
> -	return list_is_last(&r->list, &t->regions_list);
> -}
> -

[Severity: Low]
Does removing this function break the KUnit tests?

Looking at mm/damon/tests/core-kunit.h:damon_test_is_last_region(), it
still calls this function:

    KUNIT_EXPECT_TRUE(test, damon_is_last_region(r, t));

Since the test header is included at the end of core.c, compiling with
CONFIG_DAMON_KUNIT_TEST=3Dy would result in an implicit declaration or
undefined symbol error.

[ ... ]

> @@ -2668,8 +2662,7 @@ static void damon_do_apply_schemes(struct damon_ctx=
 *c,
>  		if (damos_valid_target(c, r, s))
>  			damos_apply_scheme(c, t, r, s);
> =20
> -		if (damon_is_last_region(r, t))
> -			s->stat.nr_snapshots++;
> +		s->tried_applied =3D true;
>  	}
>  }

[Severity: High]
Does this bypass the access pattern guard check?

The commit message states the scheme should pass all guard checks including
the access pattern before being considered tried. However, s->tried_applied
is set to true unconditionally here, even if damos_valid_target() returns
false. This would cause the max_nr_snapshots limit to be reached
prematurely.

[ ... ]

> @@ -3249,6 +3242,9 @@ static void kdamond_apply_schemes(struct damon_ctx =
*c)
>  	damon_for_each_scheme(s, c) {
>  		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
>  			continue;
> +		if (s->tried_applied)
> +			s->stat.nr_snapshots++;
> +		s->tried_applied =3D false;

[Severity: Medium]
Could this result in a spurious increment of nr_snapshots due to
uninitialized memory?

When struct damos is allocated in mm/damon/core.c:damon_new_scheme() using:

    scheme =3D kmalloc_obj(*scheme);

the memory is not zero-initialized. During the first execution here, if a
scheme was skipped before damon_do_apply_schemes() explicitly sets the flag
(for example, due to zero valid targets or fully consumed quotas), the
uninitialized value might evaluate to true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807093526.1830=
09-1-aethernet65535@gmail.com?part=3D1
