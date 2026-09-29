Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB43AEF53
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669563; cv=none; b=LkDF4rQaHilrOYaB9OFWC5w5g/6O6/fU4JnCya8Q23gnJ2vF1gxjcIAZSFRpaP0tQfdadQFEJBF6kq1emxym2nipi2O2JttTCHnzx64Xv2Grkav5TmURf1YCjkWVLKplGb/YEYl/HofUcsiyQyIytWKVlMb9/Tvg8YPxEvq1Wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669563; c=relaxed/simple;
	bh=zLByi1FADhgSbCoNCfqp2mp0isNGfkecyAKRHii7XuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKR7pk9ugnoITG0W9LliOjb+GQRXDvwKk2IDhOJO4ZlN5RRqNCmKT0Ies3Ory6QVdU+ZbAizoxf1lfCcAlcgD3XYo3X+a8Sc7y/lV50JdGB3y0tGzOkphqHQhOMcDAhNwhmbN3qahVBBBhsy/hWCMw0zN79rddFrQ+Q3pszPVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfiZfJOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfiZfJOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69AC1F000FF;
	Tue, 29 Sep 2026 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669559;
	bh=pyXjYYCyKLEste5PH+nm0G2Pggk7V4j+jUmDe+xuDbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfiZfJODNvcR2WUqIWxWNEU0rd/A3r2rmq87H9Hj4yOsLxuijuyLP0K+jg2gSXwe9
	 W27pTLg3LE0zB7/dqUADlJXYphANswDErnvc6FaVHrrXV4pj9pwe7/pZxZjjynE82/
	 sDIoiGBLlf+JmNHQk3aP4GRH5KqC9cCh4DTBgpqf1aRWsdYakgLVCaQDZGIXxJ60wG
	 XmyKZge1/KyGLgkgVp2h6Jftwuv+5VhZHQaZ6UYzeN8EsFWYA4zZlepq+Ya4fVVHFm
	 2yYujsCOKH7mjszSOaMwiIvaHo/UbS/3BuIyL7I7wwcPM69Bs3N93Qgn1fk66mln1Q
	 1sXYtTk8M4muw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] mm/damon/core: introduce
 damos_quota_goal->complement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-2-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:12:39 +0000
Message-Id: <20260929081239.A69AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] damon: integer overflow in psi complement calculation on 32-bit
--

commit 194cde60eb24e43a85afddadebba1bd09c82f1e0
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damos_quota_goal->complement

This commit introduces the complement flag to the damos_quota_goal structure
to specify whether to use a complemented value of the goal target metric. It
also implements the core logic to handle this flag during quota goal commit
and metric retrieval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi=
_total,
>  		struct damos_quota_goal *goal, struct damos *s)
>  {
>  	u64 last_psi_total =3D goal->last_psi_total;
> +	unsigned long val;
> =20
>  	goal->last_psi_total =3D now_psi_total;
>  	if (last_psi_total !=3D U64_MAX) {
> -		goal->current_value =3D now_psi_total - last_psi_total;
> +		val =3D now_psi_total - last_psi_total;
> +		if (goal->complement) {
> +			if (val < s->quota.reset_interval * 1000)
> +				val =3D s->quota.reset_interval * 1000 - val;

[Severity: Low]
Does this calculation overflow on 32-bit systems?

On 32-bit architectures, s->quota.reset_interval is a 32-bit unsigned long.
Multiplying it by the integer literal 1000 will overflow before the
comparison and subtraction if the user configures a reset_interval_ms
greater than 4,294,967 (around 71.5 minutes).

While such a high interval is atypical for DAMON's continuous monitoring,
it is technically reachable via sysfs since the sysfs store function does
not bound the value beyond the maximum unsigned long value.

> +			else
> +				val =3D 0;
> +		}
> +		goal->current_value =3D val;
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D1
