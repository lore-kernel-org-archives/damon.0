Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D152772E
	for <damon@lists.linux.dev>; Wed, 20 May 2026 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259123; cv=none; b=dO0s40LXkJZ51zbh3xGP0ZYgmAML3/GaJtLeORvlF92CD3FKNK+CdN99QF6AA9MAeEG6w7Zo8EL/YDY+9ZsaPw4u+rpiIHySrTeZfvAzjDCiSF0eJR0pSbSbmvPyODmmgMbQvJQ6oFELfU0q1qmeeAFpjdhJF2jbV0/3ggrv0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259123; c=relaxed/simple;
	bh=wduUj+bpWjo6WtXPjbhemfwLFiD9R0FHN/JE1Qm2U40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntZseo7u+9eH3agdGWkzcEcjURnT9zJx+Z2AKTp2qg1XQdMJJ2YeVvXs0qezchLfsyDI5NhBRqlHsnw7PM2tDh6FEGKG1fq9ZW1LkB/RRahTsXrRFbgWtyXJ/y0vEfcJAFfCBGBcrtu17E9+wKi3Xb2JdutN0nv8oZMCptOPeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXZBxBIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXZBxBIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C04C1F000E9;
	Wed, 20 May 2026 06:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779259121;
	bh=KLS9vt+Qj2L5ZVKZerOe4KIsoZVFMoBfWImLPdNeAKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fXZBxBIN8q5Urjm0JQo88GvTISDCXbNk4WBd8HCE5LTVaoquU/DcaxVbaeI6B0y/7
	 0+aX9TMNOZQ9qgK9hEB1JezNb5y9Tmvlq1IQyfAGnBCZcnTymwmP80IuOvqzTxEnxi
	 wgy8MEnBDLk5Mtw7IDxPcYsopzKDv4zuhWZ7cqvTj+LWUzDEInY80TTBJ2iIoucY6q
	 437kZRuMowQCNKogHz/ScgXZqVFSA+rzjbLh315waLRbd2LAuKlKio0eAxn3UBo3Yz
	 gBxlf1B3YY9xNKZdCHSFohaeJkNGoazlZ2YhAvYoTQ2hm52YNF4HubEHhSJ+1Fkw/H
	 ZtQgTxv7kcNeQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/14] mm/damon/tests/vaddr-kunit: replace
 damon_add_region() with damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260520062858.167011-5-sj@kernel.org>
References: <20260520062858.167011-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 06:38:41 +0000
Message-Id: <20260520063841.7C04C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The dynamically allocated `ranges` array is never freed, resulti=
ng in a memory leak.
- [Medium] The return value of `damon_set_regions()` is ignored, which can =
lead to a NULL pointer dereference if memory allocation fails.
--

commit 178b94e956635731d61e076b1aa09699c5f9b686
Author: SeongJae Park <sj@kernel.org>

mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regio=
ns()

This commit updates the DAMON vaddr unit tests to use damon_set_regions()
for setting up target region boundaries. This replaces the manual setup
loop that previously used damon_add_region().

> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 98e734d77d517..23be9c3be75fa 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
[ ... ]
> @@ -132,20 +132,24 @@ static void damon_do_test_apply_three_regions(struc=
t kunit *test,
>  				unsigned long *expected, int nr_expected)
>  {
>  	struct damon_target *t;
> +	struct damon_addr_range *ranges;
>  	struct damon_region *r;
>  	int i;
> =20
>  	t =3D damon_new_target();
>  	if (!t)
>  		kunit_skip(test, "target alloc fail");
> +
> +	ranges =3D kmalloc_array(nr_regions / 2, sizeof(*ranges), GFP_KERNEL);
> +	if (!ranges) {
> +		damon_destroy_target(t, NULL);
> +		kunit_skip(test, "ranges alloc fail");
> +	}
>  	for (i =3D 0; i < nr_regions / 2; i++) {
> -		r =3D damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> -		if (!r) {
> -			damon_destroy_target(t, NULL);
> -			kunit_skip(test, "region alloc fail");
> -		}
> -		damon_add_region(r, t);
> +		ranges[i].start =3D regions[i * 2];
> +		ranges[i].end =3D regions[i * 2 + 1];
>  	}
> +	damon_set_regions(t, ranges, nr_regions / 2, DAMON_MIN_REGION_SZ);

[Severity: Medium]
Is it safe to ignore the return value of damon_set_regions() here?

If damon_set_regions() encounters an allocation failure, it returns -ENOMEM,
leaving the target with fewer regions than intended. Could this lead to a
NULL pointer dereference in the subsequent test code if it attempts to acce=
ss
regions that failed to allocate?

[Severity: Medium]
Does this code leak the ranges array?

It appears ranges is dynamically allocated via kmalloc_array() but is never
freed before the function returns, and damon_set_regions() does not take
ownership of this memory.

> =20
>  	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520062858.1670=
11-1-sj@kernel.org?part=3D4
