Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE043D6CA3
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764011; cv=none; b=mCgJVrLJpBV9jWmsdksqsewJJezDsfxgSERRHQIPsWaOAoEA0TEkXJO6JyxZVI8EpI3qHgJkJwxa+NQlw5AdlhFVMAVVyLYMLT+G1H6z1AHqnGQvw7rVum5z5p/asRTK0N0P9u0+nCVtCEqJq5/xOH9X51OblTlH0/iRBGFvP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764011; c=relaxed/simple;
	bh=OkiyvRBDjewhpwgfofYDbOrd2+8LW1zSa4SMF/Uduog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=diSPC4X8oRM/D1iubmEZj2sF8t+2O5Hgv4hKZP+cuY6JiW0WzAiLBoo+Y+nF74hahkjsYm1GiS3Ikfd9co7PKMSPgAMpz49GawqHT0pZGA2Ue1sRplYC1188oT37uF5FlkgJ6+VB03xH3Bc7/EAw1Bk+kU0rJu3SN/j4hxBzOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brH9eRb1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brH9eRb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2AE1F000FF;
	Wed, 30 Sep 2026 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764009;
	bh=AG0grosOKwVu2sFtSXC/TGnMF529mUaPLFHy4SAipv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brH9eRb1xapcN7bCTKkkbOOPxvqpNzgHyssDc/J1CvMYFGd/RqYtp6UQd4xy9toS3
	 n95yYrbGZk0K2l2ykz3Ctj3pnEuNQIIOaDv6Ro8kyClwga5fVvXHxgqQYR+qAcN8pt
	 BcuuCp18fPn3T38khWXEF3x1fNJM2iRLa0goEn2S9O2vVCpeMNaG3MIb5CAvFkKHAS
	 fIvWAouqOYGfcWoAIa2JPb1mF5j2Zrk1TWhEh2gPzz+LcMlxd18Wa4A4FS2K/eTi5u
	 wB2RAYXWpJWTUSXsp+crTynaO1wSKyxq/Kt5zm6iTo2IgCu0F+7qfCl/5I+TlIf4bT
	 I0oP+mKEutSDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: fix unconditionally skip last
 region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260930101459.56041-1-sj@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20260930101459.56041-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:26:49 +0000
Message-Id: <20260930102649.7B2AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: OOB dereference in damon_do_apply_schemes() on split failure
--

commit 61e0ff2e7385bb544355d1f3aa3598f7f8e9e1d0
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This commit changes the logic in damos_skip_charged_region() to only reset
charge_{target,addr}_from when the last region is reached. This is intended=
 to
ensure the last region is not skipped if it has not been fully processed.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 32737cc5f877b..cc7250f0936af 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1322,37 +1322,41 @@ static bool damos_skip_charged_region(struct damo=
n_target *t,
>  	struct damon_region *r =3D *rp;
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip =3D false;
> =20
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;
> -		if (r =3D=3D damon_last_region(t)) {
> -			quota->charge_target_from =3D NULL;
> -			quota->charge_addr_from =3D 0;
> -			return true;
> -		}
>  		if (quota->charge_addr_from &&
> -				r->ar.end <=3D quota->charge_addr_from)
> -			return true;
> +				r->ar.end <=3D quota->charge_addr_from) {
> +			skip =3D true;
> +			goto out;
> +		}
> =20
>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {
>  			sz_to_skip =3D ALIGN_DOWN(quota->charge_addr_from -
>  					r->ar.start, DAMON_MIN_REGION);
>  			if (!sz_to_skip) {
> -				if (damon_sz_region(r) <=3D DAMON_MIN_REGION)
> -					return true;
> +				if (damon_sz_region(r) <=3D DAMON_MIN_REGION) {
> +					skip =3D true;
> +					goto out;
> +				}
>  				sz_to_skip =3D DAMON_MIN_REGION;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
>  			r =3D damon_next_region(r);
>  			*rp =3D r;
> +			skip =3D false;
>  		}
> +	}
> +out:
> +	if (r =3D=3D damon_last_region(t)) {

[Severity: High]
If damon_split_region_at() fails to allocate memory, it returns silently and
the region remains unmodified. If r happens to be the last region in the li=
st,
could damon_next_region(r) evaluate past the list boundary and return an
invalid pointer?

Since this invalid pointer is assigned to *rp and the function continues to
the out label, could it fail this (r =3D=3D damon_last_region(t)) check, by=
pass
the intended quota reset, and return false?

If so, could the caller damon_do_apply_schemes() then receive this invalid
pointer and pass it to damos_valid_target():

mm/damon/core.c:damon_do_apply_schemes() {
    ...
		if (damos_skip_charged_region(t, &r, s))
			continue;

		if (!damos_valid_target(c, t, r, s))
			continue;
    ...
}

causing it to dereference garbage data (such as r->ar.start and r->ar.end) =
and
potentially lead to an out-of-bounds memory access?

>  		quota->charge_target_from =3D NULL;
>  		quota->charge_addr_from =3D 0;
>  	}
> -	return false;
> +	return skip;
>  }
> =20
>  static void damos_update_stat(struct damos *s,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930101459.5604=
1-1-sj@kernel.org?part=3D1
