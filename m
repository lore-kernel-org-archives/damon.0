Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DA4973A7
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658471; cv=none; b=boFVXPuXp1qpZzL4uDstlsDfLtK6HbKn9Co62GTdR250WIwUvmimuT85S8DHf9wTyOJp7/dHBCzTQ7NM7veG8UcchHJC1keT5qmPIv3DgVeyJaYxKqSXYQkHXQj7ST/D7UCJnbzLArO3Is2umUxUHiR1tk4UjiyVH5HCDx45U/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658471; c=relaxed/simple;
	bh=D8Zci8bKvrTh9MirVPGc2GnWx6ZveBZ9sGDxlF5TYhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XM51Jq+F3L1ISSI1dijaa7pJlcjyMJVQ7Ha/G5QQePYNoJWSxHgW3cv7Q922ycpvXn8Tnh+YmEIeZBA4NKca7pxZNdVfRiUyaHlZ8uMELfbMcd0FXRjGmBuJHAQC+i5SWWoPy4BiYhDGYvqCr7Z6Wxzn+zx/UpDXqggxkAexuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdIFpOO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdIFpOO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF71F000FF;
	Thu, 17 Sep 2026 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658462;
	bh=EVGBX/VMTTERHuaUUIK6oHZxRDNSv9re4huvp5smEdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PdIFpOO/W/5EyMADnpofJ9dSIVPjGrB+uQ2l6XrrnbrJoR6II2Dt5aB/PNrwq1zMT
	 ARDY/fEpbs6wkjRc4RgL4Lxfq3yQLX8F4mMh8V9rcUqSLbhw3nh1Eg2SCgbGXc8iOc
	 OJyQtQaFsMeC4jJIZOwzhmcetd5pgA81vRe1pmMw5EDmq5sNWTVqUFYeevAjTyTbVI
	 Juu/nEdQe7ucv6ux8LverQInCcvJqQ+SkKFt4GihL25UD0Nv9TtHM4QOHDGYN2mXeC
	 MJVuNXI20c7bglXexjJHsKw7h9OU8XFeQ9FH/mzhjpJ4iiVLpNDqkUSsmoiLknH1gV
	 VwoZU1WsgtTcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: reject zero sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karthikeyan KS" <karthiproffesional@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917150631.1138698-1-karthiproffesional@gmail.com>
References: <20260917150631.1138698-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 15:21:02 +0000
Message-Id: <20260917152102.99CF71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: obsolete zero-interval fallbacks left in core.c
--

commit 3fc9c7e0ec1f59dfad336e3842553089ded8b3b8
Author: Karthikeyan KS <karthiproffesional@gmail.com>

mm/damon: reject zero sampling interval

damon_set_attrs() already rejects inverted intervals, but it accepts
sample_interval =3D=3D 0. A zero sampling interval is not a valid monitoring
period and causes busy-spinning in kdamond. Return -EINVAL if
sample_interval is zero.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 444c97c184027..7faa92106cf1d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1135,6 +1135,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct d=
amon_attrs *attrs)
>  		return -EINVAL;
>  	if (attrs->min_nr_regions > attrs->max_nr_regions)
>  		return -EINVAL;
> +	if (!attrs->sample_interval)
> +		return -EINVAL;

[Severity: Low]
Since attrs->sample_interval and attrs->aggr_interval are now explicitly
rejected if zero, do we still need the zero-interval fallbacks scattered
throughout core.c?

For example, earlier in damon_set_attrs() we have:

	unsigned long sample_interval =3D attrs->sample_interval ?
		attrs->sample_interval : 1;

And similarly in kdamond_init_ctx() and kdamond_fn():

	sample_interval =3D ctx->attrs.sample_interval ?
		ctx->attrs.sample_interval : 1;

There is also a defensive check in damon_update_monitoring_results() that
looks obsolete now:

	if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
			!new_attrs->sample_interval ||
			!new_attrs->aggr_interval)
		return;

Should we clean up these zero-interval fallbacks since they appear to be
structurally unreachable after this change?

>  	if (attrs->sample_interval > attrs->aggr_interval)
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917150631.1138=
698-1-karthiproffesional@gmail.com?part=3D1
