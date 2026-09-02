Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0B3CA49C
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337773; cv=none; b=BhDUOjgzo4RrNoeIoBIL39j0Xh7Mo7MEDyiS9U91SrDyWDgcgM4wm5Rdrljdx62DYbi28yPR9iNx3jLFoN+tH2chrNw6D1gIfQjGUCOXqkpDQlGyDKxEzyPvPRxDw1g5TKM0lY9TRtHZhbaVqourKQnRny7IL159CsTTbYQNYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337773; c=relaxed/simple;
	bh=pbQUPU48O1yFddfiNU5nr7Pm+13gdxM0hhV7dxgew30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kOq0y2nAofwr4YlY7+pTtlLTdoKKlXh9jN1+dZj1Db7fDA4GTJKX/aHqOO1V+/Zh216KqOClPZK2tQ+HBTp96idPkMEhleyIr/z5nWcBdmiVueFt/9G5a2silcMUOaiPjygPvYR/4WMti3+Qy/jGIq3OomWZDd/9OyWXMF5mSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnDGrYCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnDGrYCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4536F1F000E9;
	Wed,  2 Sep 2026 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337771;
	bh=mWdyaXIluDJeKcDy98xCS+4qp+zbmSu94mnw+0+Unhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnDGrYCw5ZQW44mCFKc1LDUq5x1gKOj6yG7bGM7LauEub2H5wwapPJKfV84u52+1p
	 ZyNLtL0Fv7u+jM1QnhB+3CqjgkC+Ly00VG+Svp3BW/taIWqw5+thyzVDLxiXIiH8ZV
	 2gexPEbzJ3YzQWJvrTnafsIMk5yRpaZy92X6DuYMqv5cUsUah9BZ6LO4aqNSo8AF6a
	 OykXEPYaIZDpThvoQIUQeifb63heX7FaQ8DHJ7WgxmHeGJbJ/9oRP9dQUfPNDK2ZUh
	 zpaUHncsOmcYGC6Az+eD+lGc5c3k2s7fp85QoN6raUh4dSvpuaqP7Upcs1oftcNHTE
	 SLpeQ1OXxUE5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix false positive in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902081825.18931-1-aethernet65535@gmail.com>
References: <20260902081825.18931-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:29:30 +0000
Message-Id: <20260902082931.4536F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly added early exit `if (!quota->esz)` in `damon_do_apply_s=
chemes()` unintentionally skips and completely breaks all DAMOS schemes tha=
t do not have quotas configured.
- [Medium] The new condition `if (!quota->charged_sz)` in `damos_quota_is_f=
ull()` incorrectly skips quota exhaustion checks when a configured quota is=
 smaller than `min_region_sz`, violating per-region quota semantics and lea=
ding to statistic inflation and wasted CPU cycles.
--

commit b189466ffcadd150b11edbb63a99f1fb0477b8b5
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix false positive in

This commit aims to fix a false positive in damos_quota_is_full() when
goal_tuner is 'temporal' and the goal is achieved, causing quota->esz_bp
to drop to zero. It adds checks for zero charged_sz and zero esz to
prevent unexpectedly increasing qt_exceeds.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index df22621765911..f8c784df24600 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2655,6 +2655,8 @@ static bool damos_quota_is_full(struct damos_quota =
*quota,
>  {
>  	if (!damos_quota_is_set(quota))
>  		return false;
> +	if (!quota->charged_sz)
> +		return false;

[Severity: Medium]
Does this unconditionally bypass the remaining quota check when no regions
have been charged yet?

If a DAMOS scheme is evaluated with an effective quota (quota->esz) that
is greater than 0 but strictly less than c->min_region_sz, returning false
here skips the final check in this function:

	return quota->esz - quota->charged_sz < min_region_sz;

Could this cause the scheme to continue evaluating all targets and regions,
only to calculate a zero size later in damos_apply_scheme() due to
insufficient quota? This would artificially inflate s->stat.nr_tried for
every region while wasting CPU cycles applying zero bytes.

>  	if (quota->charged_sz >=3D quota->esz)
>  		return true;

[ ... ]

> @@ -2750,6 +2752,9 @@ static void damon_do_apply_schemes(struct damon_ctx=
 *c,
>  		if (!s->wmarks.activated)
>  			continue;
> =20
> +		if (!quota->esz)
> +			continue;
> +

[Severity: High]
Will this newly added check completely skip valid DAMOS schemes that simply
do not have quotas configured?

When a user creates a scheme without quota limits (ms =3D=3D 0, sz =3D=3D 0=
, and
no goals), damos_quota_init() initializes quota->esz to 0. Since
damos_adjust_quota() leaves esz unmodified for un-set quotas, esz remains 0.

Because this check happens before damos_quota_is_full() (which normally
handles non-quota schemes safely by returning false via damos_quota_is_set(=
)),
won't this cause damon_do_apply_schemes() to unconditionally skip all
schemes that lack a quota?

>  		/* Check the quota */
>  		if (damos_quota_is_full(quota, c->min_region_sz))
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902081825.1893=
1-1-aethernet65535@gmail.com?part=3D1
