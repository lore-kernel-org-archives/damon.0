Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE232B138
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675314; cv=none; b=F58OAbgImnpxdsXpmxkq6ziCTo74Xz4RHBlA6hSi+HEoeVKCtAMq7/9kxo++RfLSVulF9INWFrhkSWx2L/BvmLz2kmv7d/NS9aIlsWFOhYR5aYGaCFtjJ4kq/394DakvIuCGiNOXVhrmNutqS7hJCyBYKVGHlAeRn0P0B3NNjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675314; c=relaxed/simple;
	bh=tCdMxjD/DSxS6aIqKtCHrskXFjPoi9FRHwys0huTKcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YyzDKRFwR0e3TUa92UdZA1yVjAHBetL0ynpTfN2o21H1qn7DHlop3ybMiV9X7gOtqOfpKAzAPg0D3CR+ol3mDcvloUsinQyixp4GppvDZNcfN52TXpnx0IxgFheG2nvGlDrvALTcfxP2N1V/bYwd5PC6nJpYBEKSDRvW9F+dU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig8FcwcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig8FcwcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0681F000E9;
	Wed, 17 Jun 2026 05:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781675313;
	bh=ERqHHMSt8/CbaUsxX9CQfMpVKzXXk48UIu3OZstr+ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ig8FcwcWnVJQUyIUQRwK7+STaORJu0P5MqlSoA359f0oWuyJnWvU4MsVwCKcc8skw
	 K5q6o1BT7JuWpXnzv5i1cMjAPi1XRD8i0RKMKxDvWk78743yO59Ym228LikMBo6YM9
	 4O1ENach8O4wECBSLAqPpSbBo2ifjyhW09udxU35lLaTaXoDG9jGJEj9lQ0xFTH6rU
	 bwPYfaemMkpmmSVRbz13+ykeDqHx2HdEpPrAUFrc15S2BL0K28/ajsP+DNteWulyW7
	 crYa9x9tAnrBQNuau6t/fsb8rQpvv6dTPs+4E9ZyMk+WyMlkgwRNIzCMSklkP03Pyx
	 f76R68L7RzzAA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: put stats for
 scheme_add_dirs() internal error
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617053308.83200-1-sj@kernel.org>
References: <20260617053308.83200-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 05:48:32 +0000
Message-Id: <20260617054833.3E0681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized Pointer Dereference in `damon_sysfs_access_pattern_a=
dd_dirs()` error path.
--

commit 3b785df7194b7541f02f158bcc66d968319b86ca
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal e=
rror

This commit fixes a bug in damon_sysfs_scheme_add_dirs() where the error
path incorrectly puts the uninitialized tried_regions directory instead
of the stats directory. This prevents a leak of the stats object and a
potential uninitialized pointer dereference.

Link: https://lore.kernel.org/20260617005223.96813-1-sj@kernel.org

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..0668a0e539713 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2516,12 +2516,12 @@ static int damon_sysfs_scheme_add_dirs(struct dam=
on_sysfs_scheme *scheme)
>  		goto put_filters_watermarks_quotas_access_pattern_out;
>  	err =3D damon_sysfs_scheme_set_tried_regions(scheme);
>  	if (err)
> -		goto put_tried_regions_out;
> +		goto put_stats_out;
>  	return 0;
> =20
> -put_tried_regions_out:
> -	kobject_put(&scheme->tried_regions->kobj);
> -	scheme->tried_regions =3D NULL;
> +put_stats_out:
> +	kobject_put(&scheme->stats->kobj);
> +	scheme->stats =3D NULL;

[Severity: High]
This is a pre-existing issue, but does the identical bug exist in
damon_sysfs_access_pattern_add_dirs() within the same file?

Looking at damon_sysfs_access_pattern_alloc(), the access_pattern struct
is allocated using kmalloc_obj without zero-initialization, causing its
pointer fields like sz, nr_accesses, and age to hold garbage values.

If a directory setup fails in damon_sysfs_access_pattern_add_dirs() due to
a memory allocation failure, the error path attempts to clean up the failed
object rather than the previously successful allocations:

mm/damon/sysfs-schemes.c:damon_sysfs_access_pattern_add_dirs() {
    ...
put_sz_out:
    kobject_put(&access_pattern->sz->kobj);
    access_pattern->sz =3D NULL;
    ...
}

Could this cause a kernel panic by dereferencing an uninitialized garbage
pointer if the initial allocation fails, exactly like the issue fixed here
for scheme->tried_regions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617053308.8320=
0-1-sj@kernel.org?part=3D1
