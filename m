Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB91D89EF
	for <damon@lists.linux.dev>; Fri,  1 May 2026 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601804; cv=none; b=BeBsQAM2GNSLRjltviPHJahL191boLncznYmXYPoeD4TUvHJl3Lo7J5JoCrucnwCkg7NFqO8COCnBrkALRonn066fzegchvOWL4SnvaFJIG4fSElE6PZqFSX3rhqDlZVTYl80R7h5kb/R1COHciCHN14CDy6SqZ5zt9MNR5M3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601804; c=relaxed/simple;
	bh=gGbv3TbBD1/UpHqzudAgpCU7q4zWCM/aRWeZS6O93Zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jV3mK6UGM0ZOcsJqfanWj0XqAAcxD8+9i/a3UwsfML5hZEfncaK9Web2avdv4hhA+qYdavb3IdncDVe+RtvkFWG3tzXvcoDAlTfNKzpIgTPSpav4bVvDYuBEvmPyG5ed5+8ZTyCQNevI0GhphoEfoe5r7OEWr+nRDizsnACo7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsV8g+Xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsV8g+Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBAFC2BCB3;
	Fri,  1 May 2026 02:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777601803;
	bh=gGbv3TbBD1/UpHqzudAgpCU7q4zWCM/aRWeZS6O93Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IsV8g+XcTFeCeM5iFFwamTgbOg4mDGKm2xL+sr//BUIaUmZRPA3tAjL0tZD45rljQ
	 59x8vVI+JYeZaE3ePahhzst4rIU6pP4ITRxcDHZXqaOEdHRzbvy2o/azWZHdU+pvJC
	 LaJPNGYMbdc+9mNXhikcsa091cvQrwjXfqu06TyYBScAYGL+ShMwAMQWDyyqcSD2ph
	 b8DE8Igq+ULrHNy3URp5eMnhwY/VPp5Dc+N2ZE9YQipgohfMKJcIcTXa0ST8IshS1C
	 Kwuzh7Dk4yPFSxfrczTgfayD5rm7d8IMU3MfmsdOi90+DA9sW1t4jzsj7PLQkmzLmE
	 juP/5hTEXkxqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] mm/damon/lru_sort: validate min_region_size to
 be power of 2
Reply-To: sashiko@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260501013750.71704-2-aethernet65535@gmail.com>
References: <20260501013750.71704-2-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 02:16:43 +0000
Message-Id: <20260501021643.9CBAFC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition exists betw=
een the validation of `damon_lru_sort_mon_attrs.sample_interval` and its su=
bsequent use, leading to a division-by-zero kernel panic.
--

commit 27c4642b5b420a4c1731c9385273b591e05b5b4c
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/lru_sort: validate min_region_size to be power of 2

This commit adds early validation for the min_region_sz parameter to ensure
it is a power of 2. It prevents kdamond from incorrectly terminating with
the maybe_corrupted flag when a user simply sets an invalid addr_unit.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 2eb559d913b62..eca88ed941b32 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -286,6 +286,11 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit =3D addr_unit;
>  	param_ctx->min_region_sz =3D max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> =20
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!damon_lru_sort_mon_attrs.sample_interval) {

This isn't a regression introduced by this patch, but can a time-of-check
to time-of-use (TOCTOU) race condition happen here?

Because damon_lru_sort_mon_attrs is exposed as a module parameter, it can
be modified concurrently. If a user concurrently writes 0 to sample_interval
immediately after this check passes, the local attrs struct would copy the
new zero value:

    attrs =3D damon_lru_sort_mon_attrs;

Later in the function, damon_max_nr_accesses(&attrs) evaluates
attrs.aggr_interval / attrs.sample_interval. Since sample_interval would
be 0, could this trigger a divide-by-zero exception?

>  		err =3D -EINVAL;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501013750.7170=
4-1-aethernet65535@gmail.com?part=3D1
