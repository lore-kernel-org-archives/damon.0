Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FF1A0712
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607532; cv=none; b=ST5+wMR5XmJMjCA5uGacAoVXqfFaZqCXRPaqhYRyzliBSeKe5KjLqrp61tBv1q+qyFlDVdwMWrQLQKfIp4Gd/QaYD4KAbOvnXKWRjvkpZy4PD8XULp55feEAPpNy8vRZ2YcEle89dln13ttqb6s3sR26R+x2HzgmNrlfj9dNBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607532; c=relaxed/simple;
	bh=Cm4Fbm8phTArnf5HvW6I9qU/spWpv5navLre1XkWj1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtL0g8xruoYrJSi6O9gri1i0izLysPfsK43+DYnR2LHNWyry8ERy72izz7L4inpYRrf+ay6qdxxFUviNPIeVgRsAhg8lalTVKaPqUpSfRpPIvQUr+XACwebPo1EzItoWwKqyVRFJJEcr7Xr80CEYs66Dl7IngWWrzP/mGBqpuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVqnsvJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVqnsvJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EB51F000E9;
	Thu,  9 Jul 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607530;
	bh=Hclknh/1jj2ssHXcIiCHjCJMbEzB4y1H9aNx9syndOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVqnsvJZnCBxHxQZjTCUCTujJPCuMwyxkkY/a4aqFCZO4lXchhdyojsBZNAtFZ9S2
	 dCvc3ChZm09+NMur3sk4DJISQvUW01Yba67KCDUaYtanVa2ozy1iiL8JtK7uZJwHhw
	 03EGjzMf7Fw+OURv3wb+hBDPnRRL3jdvK7ZL1NHPOyGMQEHVg//OaYg6n2pz9L5/99
	 oJQQGFWzMIl60KnZPMSMD91tWBIGkP0+h00DLfsT4Hhis3WejzRBxdRwYElSOTxcrj
	 23G5KthzoUuDZUVZQ4M1za9ZJHCyKLOpMPkwT3Uq8/ydXNxGxmIfODPY5aQUOfRY6y
	 dTWw2BEb+Zo3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 07/19] mm/damon/core: use abs_diff() instead of
 abs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-8-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:32:09 +0000
Message-Id: <20260709143210.84EB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential integer overflow in weighted average calculations within=
 `damon_merge_two_regions()` on 32-bit architectures.
- [High] Infinite loop in `kdamond_merge_regions()` causing soft lockup whe=
n `aggr_interval` is large.
- [High] Multiple erroneous `r->age` updates per aggregation interval durin=
g region merging.
--

--- Patch [7]: [RFC PATCH v1.2 07/19] mm/damon/core: use abs_diff() instead=
 of abs() ---
commit f6ab818d018c3ba8c682c6e198e98ba7a8a69b83
Author: SJ Park <sj@kernel.org>

mm/damon/core: use abs_diff() instead of abs()

Use of abs() in damon_merge_regions_of() could cause a silent integer
overflow. This patch replaces it with abs_diff().

Link: https://lore.kernel.org/20260705213817.100841-1-sj@kernel.org/

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fea97399b5754..4c7e8a12a9b67 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3261,7 +3261,7 @@ static void damon_merge_regions_of(struct damon_tar=
get *t, unsigned int thres,
>  	struct damon_region *r, *prev =3D NULL, *next;
> =20
>  	damon_for_each_region_safe(r, next, t) {
> -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> +		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
>  			r->age =3D 0;
>  		else if ((r->nr_accesses =3D=3D 0) !=3D (r->last_nr_accesses =3D=3D 0))
>  			r->age =3D 0;
> @@ -3269,7 +3269,7 @@ static void damon_merge_regions_of(struct damon_tar=
get *t, unsigned int thres,
>  			r->age++;

[Severity: High]
This isn't a bug introduced by this patch, but does this logic apply multip=
le
age updates per aggregation interval if damon_merge_regions_of() is called
multiple times?

The function damon_merge_regions_of() is called inside a do-while loop in
kdamond_merge_regions():

mm/damon/core.c:kdamond_merge_regions() {
	...
	do {
		nr_regions =3D 0;
		damon_for_each_target(t, c) {
			damon_merge_regions_of(t, threshold, sz_limit);
			nr_regions +=3D damon_nr_regions(t);
		}
		threshold =3D max(1, threshold * 2);
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
	...
}

Since last_nr_accesses isn't updated until after this loop completes, if
merging fails to reduce nr_regions sufficiently, the loop repeats. Could th=
is
cause the same access counts to be evaluated repeatedly, artificially aging=
 or
resetting memory multiple times within a single aggregation interval?

[Severity: High]
This is a pre-existing issue, but can the loop in kdamond_merge_regions() r=
un
infinitely if max_thres is extremely large?

Looking at the same snippet above, max_thres is an unsigned int calculated
from aggr_interval. If max_thres is >=3D 2,147,483,648 (for example, due to=
 a
large aggr_interval), doubling threshold will eventually overflow a 32-bit
unsigned int to 0.

Then max(1, 0) resets it to 1. Since threshold / 2 (which is 0) will always
be less than max_thres, could this cause a soft lockup of the kdamond threa=
d?

> =20
>  		if (prev && prev->ar.end =3D=3D r->ar.start &&
> -		    abs(prev->nr_accesses - r->nr_accesses) <=3D thres &&
> +		    abs_diff(prev->nr_accesses, r->nr_accesses) <=3D thres &&
>  		    damon_sz_region(prev) + damon_sz_region(r) <=3D sz_limit)
>  			damon_merge_two_regions(t, prev, r);

[Severity: High]
This is a pre-existing issue, but can the size-weighted average calculations
in damon_merge_two_regions() overflow on 32-bit architectures?

mm/damon/core.c:damon_merge_two_regions() {
	...
	unsigned long sz_l =3D damon_sz_region(l), sz_r =3D damon_sz_region(r);

	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
	l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
	...
}

If sz_l is large (e.g., 100 MB or ~104,857,600 bytes) and nr_accesses or age
is moderate (e.g., 50), their product (~5.24 billion) exceeds the maximum
32-bit unsigned integer value (~4.29 billion).

Since unsigned long is 32 bits on those systems, could this silently overfl=
ow
and irreversibly corrupt the merged region's statistics?

>  		else
>  			prev =3D r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D7
