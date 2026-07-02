Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C433E36A
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027208; cv=none; b=esWGRMN6k+IdRgr/pkGV3FOgC/UCh1mBwPIoPBwv/Xqqi96Mqkh8r2S9RwEAFpwX+lCrnffHKASoT2Z3ogxXV/04wPulphpogVM4btGC03yv45jPhcUvLbFR61PjVTvACFIbyWhpZwF0SCvImO+CiVP6bIePRlsE0ge6WEkuGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027208; c=relaxed/simple;
	bh=O9gaLHCW0xxo7LIWR74/WThzNCWWOSnx+PYx9O+4qmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=blbQvH50N/XEPNVM/4GOhd9/rHbS/eR6UxJHtMDOAe8kFWRJprjHI2UmTbMumOH1mYXesiQdfrUC9WSqA69MbHBKLSrDLk8aJCLfxZn1Im1wtA/CrkWgiG0qV+vXAGffLoX9q6GfPw9a4zD66NhZLt7+2cJOnzfdebYAi6CHPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPeAKo4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPeAKo4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3901F000E9;
	Thu,  2 Jul 2026 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027206;
	bh=AvX6jsrUy03XMRkGASrBV6WGA8C+/kenz8CR83L6Io4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPeAKo4ozvsIW+24zRwy5h0ONBdEf6yGFm+zsicLCneUS3zvOIEO9VDchT7uSMIzJ
	 os/aqDHmWOvsCj1t5QYkoxBwqmEMDMKnw/7lATGDJxFDEK5/BCJpNdv0RaMlCwRMGa
	 iOTHL4VilARfD3Z9vw1Wtpx89lj6j8o0PZ98WvwUR54vKiM6Vy/ha0UkujqDduCzGy
	 ZveDun+ZFfnfk0eEZtfUukD+6FV6NhoaoS/ZCOCmDjFgrP+tIQbF+5r4Ho494n0fRQ
	 Rmwz0bcqNeyKe4TGQ4yii77a61LH1o3FrgGnUgIVNDNSQyXDy2FTffuU6Is/s0zNQF
	 aXYPOhrpO4UDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 5/8] mm/damon/lru_sort: remove duplicated
 min_region_sz power_of_2() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702210551.95167-6-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
 <20260702210551.95167-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:20:05 +0000
Message-Id: <20260702212005.EF3901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the early validation of `min_region_sz` causes persistent=
 corruption of the `monitor_region_start` and `monitor_region_end` module p=
arameters on failure.
--

commit 982a6b66f4f61086f3bd8de5a2da757081d4fa94
Author: SJ Park <sj@kernel.org>

mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check

This commit removes an explicit power-of-two check on min_region_sz from
damon_lru_sort_apply_parameters(), as the same validation is performed
later in damon_commit_ctx().

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
Does removing this early validation allow execution to proceed with an inva=
lid
addr_unit?

If the monitor_region_start and monitor_region_end parameters are 0
(the default, triggering auto-detection), they are overwritten in-place
with system bounds scaled by the invalid addr_unit when this function
is called later in damon_lru_sort_apply_parameters():

	err =3D damon_set_region_system_rams_default(param_target,
					&monitor_region_start,
					&monitor_region_end,
					param_ctx->addr_unit,
					param_ctx->min_region_sz);

When damon_commit_ctx() later rejects the configuration and returns -EINVAL,
these corrupted values are not reverted.

If a user then corrects addr_unit and applies again, will the now non-zero
parameters bypass auto-detection and get scaled again? This could cause
DAMON to monitor an incorrect and massive physical address range, forcing
the kdamond thread into a long pfn_valid() loop that consumes excessive CPU.

Is the same state corruption possible in mm/damon/reclaim.c:
damon_reclaim_apply_parameters() due to a similar removal of the early
power-of-two check?

>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err =3D -EINVAL;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702210551.9516=
7-1-sj@kernel.org?part=3D5
