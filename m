Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC33B775A
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921385; cv=none; b=r+pN3paBYhudsfh3olFy2vqxvdmCMpULoqUflhbdBOIVtoLZ3+3NzYctSEmyOZg0se3A2b/7zziu3JpfH/eVz1PKLMQ4fufhTYaly4IZMu0OmXf0bs61doaEqXb/9kP+AMP6D2c0Ay9HvyZrE9faca6NQ/HgsnyLISFarqHHjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921385; c=relaxed/simple;
	bh=1x3/IbLB/4bmb0d0rXgU96lyjAPX0GARO9zvXbvGIM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcArmmNxCtEb3bnWHy5Yt3cfAtQHkEutnZX229iKU3bqVdHOY+jKP8HXB+7Zdv/8fwwJ0XcjfeiZ27ZvpNUh99UW037TB9/Q7p8w8joRjcCkEEx7xW68cF7a4wK99vcEL3B2f4WkucNNxhiWE8wAS3D5emNlp+kShaixe4vTU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHBEIcFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHBEIcFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DD61F000E9;
	Wed,  1 Jul 2026 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782921384;
	bh=nAFXvMX1SbIkk0fph84DwbNlObRAgX3+S5fpgCuGsIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHBEIcFrsA+xM/3rf8VDIvgOmo2r7G+EmC+/SxO/XbDi6CLIshEjHDvLFtLmNCm1v
	 D0FQXTzrkQnvgT2N0AqDKs1kiIpxHLC9i9N+ao5O+K5tdUTAUekMQdvPQom/lLGEOl
	 b81/koJbmjYzyF2zdxQjD5MToaIWspQ5eV/k9Xs0eWBya5CwfmFHV24lojy0CQh4+z
	 ZM9mkgPz3fdql6BZyCrE7bYI3wf3FqLFfQXhhBCI9lH5vzDBt2LBJr7TCdSd3ugq8d
	 dn19ob+s4MjGFjv6IoYuMtrQ/NWhWG809UgyVKSbFha8SDqLbfs14Z53AngkY16C9f
	 k+TDRwqqKT+Hg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/8] mm/damon/lru_sort: remove duplicated
 min_region_sz power_of_2() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-6-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 15:56:23 +0000
Message-Id: <20260701155623.E4DD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `is_power_of_2()` validation exposes the system to un=
defined behavior via `ALIGN` macros and silently kills the `kdamond` thread=
 (Denial of Service).
--

commit da14a5f653fa82832f40f8b6d0be4ad4c3036287
Author: SJ Park <sj@kernel.org>

mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check

DAMON_LRU_SORT validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the unnecessary duplicate.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 32f41491b726b..2dd0cd0d26273 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -284,11 +284,6 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit =3D addr_unit;
>  	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> =20
> -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> -		err =3D -EINVAL;
> -		goto out;
> -	}
> -

[Severity: High]
Does removing this early validation expose the rest of the DAMON subsystem =
to
a non-power-of-two min_region_sz?

If a user writes a non-power-of-two module parameter (for example,
addr_unit =3D 3), damon_lru_sort_apply_parameters() will calculate
min_region_sz as 349525.

This invalid size is then passed to damon_set_region_system_rams_default(),
and eventually to damon_set_regions(), where it is passed into the ALIGN()
and ALIGN_DOWN() macros:

mm/damon/core.c:damon_set_regions() {
    ...
    r =3D damon_new_region(
        ALIGN_DOWN(ranges[i].start, min_region_sz),
        ALIGN(ranges[i].end, min_region_sz));
    ...
}

These macros strictly require power-of-two alignment values to form bitwise
masks.

Can this result in meaningless garbage boundaries?

Furthermore, the invalid size propagates to damon_commit_ctx(). Due to a bug
in a prior patch in the series ('mm/damon/core: safely validate src on
damon_commit_ctx()'), the safe validation dry-run incorrectly validates dst
instead of src, leading directly to a call to __damon_commit_ctx():

mm/damon/core.c:__damon_commit_ctx() {
    ...
    dst->maybe_corrupted =3D true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;
    ...
}

This function immediately sets dst->maybe_corrupted =3D true, evaluates
!is_power_of_2(src->min_region_sz), and returns -EINVAL early.

This leaves the running context's maybe_corrupted flag permanently set to
true, which causes the kdamond background thread to abruptly terminate itse=
lf
on its next iteration.

Could this lead to a denial of service by silently killing the kdamond thre=
ad?

>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err =3D -EINVAL;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D5
