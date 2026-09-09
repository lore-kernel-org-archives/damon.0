Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B71429D
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929215; cv=none; b=SbFilWzoFsSHP0xZBNVmJIIbG11Ler5oJaMTu5Wi0JzycwTbudU7MjXyUQPgRX5/tOvgsgAGgKtWVWwdQ2/UgwAyZEdwczJQUFZKjaOHpYNId19OY20paoWln1CFACw9PGvV530t3rK8m/AYr3qUNVFvM6s9GRsqH7EvNIPhI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929215; c=relaxed/simple;
	bh=JJyCkPHWgsOI+sdPrcW7i/skMz+F/53ccPjSLC9YuSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPkkZrajjL8nSLDZvvZWwnlf/Y0CQL5/0tNCP1Etf9veOKQ6AVd0R8Cc5B/RD2/q5HJ3pu3/dMYh/z/NZxoAqCXibuFMHI9nFo2S4j/JPxkR847pPd0F8iICVjye6pTxMeJVBM6Mee/31hzBkZyQNmOAM2we1Aqkl1TA+skoZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvzzsOYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvzzsOYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CCC1F00A3A;
	Wed,  9 Sep 2026 04:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929214;
	bh=r1XtfszAhnV24BrxWlvZ92wv4QHKArQGmqEIS7ifL60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvzzsOYaDok1XX4zcKhcntgkOIcbtzvst2qT0lq8j/nq0MWk2FkdN9q55Y5beOwQi
	 fx+oimdRaorkB6NQRl4lvkQZufWZ+IY9Ijotb/Tf1joEXWMPwaQMPc2r5RkzRhcmDf
	 8ZEVApIB+DHFOrquUxpUYDPiG5YLMGhgE949Et9lxg4oTaPmtIYg7NzBePKUGa64g2
	 ikbFVhAXVoRdeYJV1hP7Pq4ngOvNBA/7T4U0LPScBeNejr75yYRfwbHgWa77/2uh6c
	 lY3zykpwOUDDGzI8Fr+4YhBjmJELWf+NPF/B1YuDXQvE2U+wDVu1aBQejAMvDd8P/z
	 v/y9t9l+pnfvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: skip aging from repeated
 aggressive merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909043807.210326-1-sj@kernel.org>
References: <2026090840-slapstick-viability-4dbd@gregkh>
 <20260909043807.210326-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:46:53 +0000
Message-Id: <20260909044653.F0CCC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The do-while loop in `kdamond_merge_regions` can infinite-loop if =
`nr_regions` remains above `max_nr_regions`. It expects the loop to termina=
te when `threshold / 2 >=3D max_thres`, but `threshold` is a 32-bit `unsign=
ed int` that overflows when doubled. If `max_thres` (derived from `aggr_int=
erval / sample_interval`) is sufficiently large (e.g., > 1,073,741,824), th=
e condition `threshold / 2 < max_thres` evaluates to true forever, locking =
up the kernel thread.
- [Medium] The C macro `abs()` is incorrectly used to compute the absolute =
difference between two `unsigned int` access counts (`r->nr_accesses`, `r->=
last_nr_accesses`, and `prev->nr_accesses`). For very large differences (ex=
ceeding 2 billion), unsigned wrap-around causes the result to evaluate as a=
 negative 32-bit signed integer inside `abs()`, which negates it to a compl=
etely inaccurate value, causing DAMON to incorrectly reset region ages or i=
mproperly merge disjoint access patterns.
--

commit 2e588ff7cb5f9fc59f1692ecf781e53ba68d8c92
Author: SJ Park <sj@kernel.org>

mm/damon/core: skip aging from repeated aggressive merging

This commit fixes a corner case where kdamond_merge_regions() repeats
merging regions and updates region ages multiple times, which corrupts
monitoring results. It resolves the issue by skipping age counting during
the repeated merge operations.

Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1786,15 +1786,17 @@ static void damon_merge_two_regions(struct damon_=
target *t,
>   * sz_limit	size upper limit of each region
>   */
>  static void damon_merge_regions_of(struct damon_target *t, unsigned int =
thres,
> -				   unsigned long sz_limit)
> +		unsigned long sz_limit, bool count_age)
>  {
>  	struct damon_region *r, *prev =3D NULL, *next;
> =20
>  	damon_for_each_region_safe(r, next, t) {
> -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> -			r->age =3D 0;
> -		else
> -			r->age++;
> +		if (count_age) {
> +			if (abs(r->nr_accesses - r->last_nr_accesses) > thres)

[Severity: Medium]
This is a pre-existing issue, but does using the abs() macro here correctly
handle the absolute difference for large unsigned integer access counters?

For very large differences exceeding 2 billion, the unsigned wrap-around
could cause the result to evaluate as a negative 32-bit signed integer
inside abs(), which then negates it to an inaccurate positive value.

Could this cause DAMON to incorrectly reset region ages or improperly
merge disjoint access patterns when the ratio of aggr_interval to=20
sample_interval is very large? Would abs_diff() be a safer alternative here?

> +				r->age =3D 0;
> +			else
> +				r->age++;
> +		}
> =20
>  		if (prev && prev->ar.end =3D=3D r->ar.start &&
>  		    abs(prev->nr_accesses - r->nr_accesses) <=3D thres &&

[Severity: Medium]
This is a pre-existing issue, but similarly, could this abs() calculation=20
result in false positives during the threshold check, forcing aggressive=20
merges of disparate regions if the access frequencies are extremely large?

>  		    damon_sz_region(prev) + damon_sz_region(r) <=3D sz_limit)
>  			damon_merge_two_regions(t, prev, r);
>  		else
>  			prev =3D r;
>  	}
>  }

[ ... ]

> @@ -1828,15 +1830,18 @@ static void kdamond_merge_regions(struct damon_ct=
x *c, unsigned int threshold,
>  	struct damon_target *t;
>  	unsigned int nr_regions;
>  	unsigned int max_thres;
> +	bool count_age =3D true;
> =20
>  	max_thres =3D c->attrs.aggr_interval /
>  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
>  	do {
>  		nr_regions =3D 0;
>  		damon_for_each_target(t, c) {
> -			damon_merge_regions_of(t, threshold, sz_limit);
> +			damon_merge_regions_of(t, threshold, sz_limit,
> +					count_age);
>  			nr_regions +=3D damon_nr_regions(t);
>  		}
> +		count_age =3D false;
>  		threshold =3D max(1, threshold * 2);
>  	} while (nr_regions > c->attrs.max_nr_regions &&
>  			threshold / 2 < max_thres);

[Severity: High]
This is a pre-existing issue, but can this do-while loop lock up the=20
kdamond kernel thread indefinitely?

The loop expects to terminate when threshold / 2 >=3D max_thres. However,=20
threshold is a 32-bit unsigned int that overflows when doubled.

If max_thres is derived to be a very large value during the assignment
at the start of kdamond_merge_regions() (e.g., if a user configures a=20
large aggregation and sample interval ratio), threshold could repeatedly=20
double until it exceeds 0x7FFFFFFF.

When it overflows, max(1, threshold * 2) resets the threshold to 1.
As a result, threshold / 2 would max out at 0x40000000, causing the=20
condition threshold / 2 < max_thres to remain permanently true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909043807.2103=
26-1-sj@kernel.org?part=3D1
