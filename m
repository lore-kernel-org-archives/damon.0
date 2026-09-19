Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2813515DC
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781008; cv=none; b=tQbfXDanZpfiWhD42uvlIsl6wKsx1I2kg2omFLWPvBNpWIM9DINUpgvDAxNFSvD1DcCu+SvtKj4M74cJ1kq3FZ48lPrvMmUOHzRP59x8LpTRyt767c6PQcKtRmD9BmR1MWC0m+xFNl2lRX5+cghBCUUMT0lAJX4nsus+0TNKVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781008; c=relaxed/simple;
	bh=Qd6wr71ONc3VZ1xkdG8GIxlA+MoKKJEfvp3kzdwzdOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CSDf8O2V4mCnKSTsn3ONxws7JR1vlUCL9P6x/jbJ/ctmBG7rlht0//HzLXXC7l871oVsU9Mc18kXPz/djh98XA7TXQHzYyFB//HH2cZTCps3BOCoQ6cZthQWvuwdBAPd3Gmmy7ui2qseLCz3CgG9KOPKgCef68WByDw75eWwtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7TwoD8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7TwoD8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2241F000FF;
	Sat, 19 Sep 2026 01:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781002;
	bh=XECSl7bw0+1a4rTM1VfokgnVb5TgoGqPP3oy9mzFbck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7TwoD8gOtGwiQb6CJyUKEbicEpUeDmhV9OKoij0uDUOG4tb8A1iGEWzJI5dNnYbr
	 NRZZQWHKMesPpUZQb5VGe4dZvfa92YoY4JalXck4DKOv8MJYR9KpYZ+nzUSJBvbtaY
	 JkgPdv9ZB0h2HqyvjJUrIUZ/OpGg/vp7Arj4hooh8B3P5zTEHZVGMPvhDUivWQZgSM
	 MHu5iZpCo2z4WS+4QDVblePNUrpViRu/4h4oJMzkA8PBwZ6bf0z+hoAJ0doI+NfOTN
	 heOYy2R5RrzpQOeAssZIEUgyGcBq7ETkTTtEPuaY5UfGjtxQLzz1XvbQw+F9TIhiVL
	 sryBOg1kd8Hdg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 7/7] Docs/ABI/damon: update for quota goal metric
 complement sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-8-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:23:21 +0000
Message-Id: <20260919012322.2F2241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: integer underflow in damos_set_quota_goal_current_value()
--

commit f2de2d4493473c2c847f3ad213eaef640f0e1600
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damos_quota_goal->complement

Introduce damos_quota_goal->complement for specifying whether to use a
complemented value of the given goal target metric. Add the field to
the data structure and implement essential core support.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 2258b72da7a78..9fd08cbfacd8c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3238,6 +3239,23 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>  	default:
>  		break;
>  	}
> +	if (!goal->complement)
> +		return;
> +
> +	/* updte current_value to complemented value */
> +
> +	/* for user_input, users set complemented value on their own */
> +	if (goal->metric =3D=3D DAMOS_QUOTA_USER_INPUT)
> +		return;
> +	if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US) {
> +		goal->current_value =3D s->quota.reset_interval * 1000 -
> +			goal->current_value;

[Severity: High]
Does this unprotected subtraction in damos_set_quota_goal_current_value() r=
isk
an integer underflow?

If a user configures DAMOS_QUOTA_SOME_MEM_PSI_US with complement enabled via
sysfs and sets a target_value greater than reset_interval * 1000, the initi=
al
round (where current_value =3D target_value) will immediately underflow.

Furthermore, if the kdamond thread is delayed by the scheduler beyond the r=
eset
interval, the measured PSI time can naturally exceed reset_interval * 1000,
which would also trigger the underflow.

This underflow would result in a huge current_value (near ULONG_MAX), which=
 is
then fed into damos_quota_score(), producing an astronomically high tuning
score that aggressively drops the effective quota to zero, breaking the quo=
ta
regulation mechanism.

> +		return;
> +	}
> +	if (goal->current_value < 10000)
> +		goal->current_value =3D 10000 - goal->current_value;
> +	else
> +		goal->current_value =3D 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D7
