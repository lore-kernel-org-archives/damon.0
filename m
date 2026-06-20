Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D12C3757
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977070; cv=none; b=OBqXFYGthLF0xl18r25yWJLyqtHM/Ts+9I4/UcjTQJKgPQe7wK8lI6e2/IPxGh/NTICZK4IQUJgZYCARpPkmU97GhH8+9Pr9xyeBsA4dbWlXJdtxO1H+w5ITgKlN7rdUUpcE+dXp1Y8slHIiuzNFNfsTP1rYo9USP5K/MqmBL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977070; c=relaxed/simple;
	bh=Z/o4qHNxGokOfQMeYy0ZxeNp+5SZUCN5luKVHvSGUmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rMcM0mwmW8vwJaJTVoj60G4CrpvhbCXIIUnLbnhmNpAlf/ZPnJON4qVzT+OBPAYonaEPKtC287nziDOB9/LgYtleGdkJ+1OZTDS2Dy88HCF2nZn0Lmf+DCiJA9qmnvp3DM7YEX4Xbn464YrKcjo5LcYZSVXST7D4XGJyfilbWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1jSxE/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1jSxE/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BE01F000E9;
	Sat, 20 Jun 2026 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781977069;
	bh=wStXm1u1sBJdJmIChmehUcjHNQpVnVVHc4iiCrzVW6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1jSxE/IRysbuoC0oOjTrIqZko7/3si+oKwTXLtCvvkH3yO5XzVPFt0Y9zsbOwMCs
	 Yb8jjKw+dIbo1lfwFuHcEkVs4pxl6hCM/N4Av0l50d2y19io0rTVg7IUCCQfzCCq2g
	 oVH5ZXo1cZaexWqCmBsf66l2X/ak86B0DF2mer6ISinZnHYn6sxNMW7n9QdEwXhEGh
	 FQBplplKdFt45EzCOZSzOZpChkledSP4QoPQEyb4hQNMJnL4eN3TpqWIxrEzeTq564
	 O/N9igFz+ZYAOyAf5czd3ByaA1xg4pWMeiSs9SlJ5Y7MY+p3iNQmJguGRvB0W46MpT
	 TA2gQ26rF+0fA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 05/13] mm/damon/sysfs-schemes: use
 damon_nr_accesses_mvsum() for damo regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620172244.90953-6-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
 <20260620172244.90953-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:37:48 +0000
Message-Id: <20260620173749.28BE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If a user configures `sample_interval=3D0` and `aggr_interval=3D0`=
, the time difference calculation inside `damon_nr_accesses_mvsum()` underf=
lows, resulting in a huge garbage value for `nr_accesses`. This corrupts sy=
sfs outputs and erratically influences DAMOS operations.
--

commit 2a77ab9c787a549b18af4699f5ffa8d3e4d60ca2
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions

This commit modifies the DAMON sysfs interface to calculate region
accesses using damon_nr_accesses_mvsum() rather than a simple division.

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
Could this lead to an unsigned integer underflow if a user configures
both sample_us and aggr_us to 0 via sysfs?

If a user configures sample_interval=3D0 and aggr_interval=3D0, the
intervals bypass the validation in damon_set_attrs(). Inside kdamond_fn(),
ctx->next_aggregation_sis is updated by adding 0 and never advances,
but ctx->passed_sample_intervals continues to increment on every loop
iteration.

When damon_nr_accesses_mvsum() is called, it calculates the difference:

mm/damon/core.c:damon_nr_accesses_mvsum() {
        ...
        left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_inte=
rvals;
        ...
}

Because ctx->passed_sample_intervals quickly exceeds
ctx->next_aggregation_sis, does this subtraction result in an unsigned
integer underflow?

If left_window becomes a massive value, it appears it would propagate
through mult_frac() and damon_mvsum() to yield a garbage value for
nr_accesses. Since __damos_valid_target() evaluates scheme criteria
using this value, could this cause DAMON to act on wildly inaccurate
access scores and disrupt system stability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620172244.9095=
3-1-sj@kernel.org?part=3D5
