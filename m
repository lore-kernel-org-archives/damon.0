Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473578C9C
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241838; cv=none; b=mLj1rmSGjwNJy50Euit65HcHVTvHnoFhrsGSbihJ9+aNza7yLp0DQwZ3la+o6KHT6dRz5oQzA0iC+4mqfGl3mI1KTLDZ+TaA3ZmQdISUgdsGT6aMIVgg29cmJJeAXrj8+FJTHl6TzAB9OZh6RBl/ArSzuq7XKoXT0aNfg0so1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241838; c=relaxed/simple;
	bh=IQkKMmYuZWKi6J91TH9C9hUoSkPF4lysTg6y8XvjQrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfRifAkNIfkm59azhlpLiZnNJMm50X7jEa4fGPvH0VP+QTzknUbmiwy2F5yxDig9qSEIS8bOrcp6z+PHw5ewr8zGqJ9L5MPnyVQ4uEw/2GIR46YR3NXGaj3PK7s/GOVM+1HwVVEu5USCjFkcVcIqlHCYNXY/2zdzKVo8+CUeQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNUtQzjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNUtQzjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE41F0089A;
	Sat, 12 Sep 2026 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241836;
	bh=nn3i74FYnhcPTRhMPL54M2b+4TEzF3Jq9RuhLNxwZDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNUtQzjHfbkVbwvSjRXgiSVipGFoj1++xng4Ftt7stxCGup7GzPrGdsQ7ereyOI/Q
	 3Zi5kmQrF7wD/lnfqJ78JLL432SZ6Z45ctS0Cdkn/d3fZs4TSuc7pG3ifS3qYhTPen
	 rvbHbJ441tw1kTCTudM4rxay7L/u68OutylDu8bDTL8MiL+74G1iBSbcMUBF/6hBNp
	 zJ9v8O3gFEej7kn6reAqX+v913SiabxImuusHq3W9CnLKulDFtbreKzz99DjFFVXJE
	 DFJH+j+Zt+MjZOWbNDNwOXENaA2i+5URtJx4pE6GHyc71A5kQtwb1tOAsx7DPNuXe1
	 zs3RDofSVeE4g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/8] mm/damon/sysfs-schemes: read
 sysfs_filter->addr_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-2-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:37:16 +0000
Message-Id: <20260912193716.99EE41F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A double-read of `sysfs_goal->metric` in `damos_sysfs_add_quota_sc=
ore()` causes uninitialized memory use in the core DAMOS quota auto-tuning =
logic.
--

commit 4b90a6724a684c24da0cc60a260ec280b6d479ac
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once

This commit fixes a potential race in the DAMON sysfs interface where
sysfs_filter->addr_range is read twice. By copying the address range first
and validating the copy, it prevents invalid configurations from reaching
the core layer.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 3de4d804e049f..3c1c1cb387fec 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2831,12 +2831,12 @@ static int damon_sysfs_add_scheme_filters(struct =
damos *scheme,
>  				return err;
>  			}
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_ADDR) {
> -			if (sysfs_filter->addr_range.end <
> -					sysfs_filter->addr_range.start) {
> +			filter->addr_range =3D sysfs_filter->addr_range;
> +			if (filter->addr_range.end <
> +					filter->addr_range.start) {
>  				damos_destroy_filter(filter);
>  				return -EINVAL;
>  			}
> -			filter->addr_range =3D sysfs_filter->addr_range;
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_TARGET) {
>  			filter->target_idx =3D sysfs_filter->target_idx;
>  		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {

[ ... ]

While reviewing this fix for the double-read of addr_range, I noticed a
similar pattern in the same file:

mm/damon/sysfs-schemes.c:damos_sysfs_add_quota_score() {
    ...
		goal =3D damos_new_quota_goal(sysfs_goal->metric,
				sysfs_goal->target_value);
		if (!goal)
			return -ENOMEM;
		switch (sysfs_goal->metric) {
		case DAMOS_QUOTA_USER_INPUT:
			goal->current_value =3D sysfs_goal->current_value;
			break;
    ...
}

[Severity: High]
This is a pre-existing issue, but does this code double-read
sysfs_goal->metric?

The sysfs_goal->metric value is read first to allocate and initialize
goal->metric via damos_new_quota_goal(), and then read a second time
in the switch statement.

If the metric changes concurrently from DAMOS_QUOTA_USER_INPUT to another
value between these two reads, could the switch statement branch away and
skip the initialization of goal->current_value?

Since kmalloc does not zero memory, wouldn't goal->current_value be left
uninitialized, causing the core auto-tuning logic to read garbage data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D1
