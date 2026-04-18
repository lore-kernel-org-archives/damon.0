Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202B33E37D
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488236; cv=none; b=CS9hctxlZpayMg/p6bJONTWV2ROVTmEDsSQ7p2Pb1LhKYFXVPY33nC25d+siXjU9mx5jyeeuWrcXtX0vhCjFTX/d9Rafj8i+YddblpdxAD2vB+Y9Jk7AmKWufCH3EmS+mHlgIDaqZj973p0eq0lXlV8iamoZHY5Aq7LletTp0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488236; c=relaxed/simple;
	bh=8uc2ZJk3PMWwf7nL6N84tJp509I/eMbHN0dpFgkud6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qvr0WFQW5M8+C6qnps5ZZ/NPUt5OvTJm3zAMVhPv6hk7lcuubYlpGSpWO4mMkQ+CYX6fcop0MSVi7Eo4bl7+wYUz2Q5IYJayAshQdO/AbTTr+wbsQebVCur0I6kg6iFXymsQjDg96A+3RqODJEI9qnOzltwIiTnN66J4+g9YMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN2FBSGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN2FBSGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF7EC2BCB5;
	Sat, 18 Apr 2026 04:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776488236;
	bh=8uc2ZJk3PMWwf7nL6N84tJp509I/eMbHN0dpFgkud6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VN2FBSGgDH+Vu8oQpD8e1C1/uvs0kDFCjg8aIGMX7VX/tsxaAZrCv1j+niL0BVQrZ
	 6QXgi3fsUChr7UbzKC5uwWCX8wQVgLcV4hoYYkf7+Sa0nGYtu8VHnZvK+oB01XtioB
	 ihAo2qVP+cyUQ+bFPRFEk6HDBvPQ6r628Twaifqk/Uezp+gRBlZ3ycVSojdv+m9jq8
	 9Bi28sEvZXp2tPIHHT14QTQz7d9uY45ARmVKwcm/mgvX6DMf69RyuJe0+bS5P/XOO3
	 xi8baFwzYfrZ1dkRIiuC82Vdk0Whk3Rxt/bk3KF58e+2htY04e6Y58dd5ofjaHmfVG
	 /Y8Wpufu+zY5g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] mm/damon/reclaim: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260418014439.6353-2-sj@kernel.org>
References: <20260418014439.6353-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 04:57:15 +0000
Message-Id: <20260418045715.EAF7EC2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Medium] Command-line override for the 'enabled' parameter is broken: pas=
sing 'enabled=3DN' after 'enabled=3DY' fails to disable the module.
--

commit 6f46639cc34c6ddcbecc0aba915988dff8f651de
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

This commit updates DAMON_RECLAIM to dynamically query the running status
of kdamond instead of relying on cached parameter values. This ensures
that when kdamond stops unexpectedly, the enabled and kdamond_pid parameters
reflect the correct state.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da147786583..46660c8d4d422 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> @@ -332,10 +316,16 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &a=
ddr_unit, 0600);
>  MODULE_PARM_DESC(addr_unit,
>  	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)"=
);
> =20
> +static bool damon_reclaim_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);
> +}
> +
>  static int damon_reclaim_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
>  	bool enable;
>  	int err;
> =20
> @@ -343,7 +333,7 @@ static int damon_reclaim_enabled_store(const char *va=
l,
>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enable)
> +	if (damon_reclaim_enabled() =3D=3D enable)
>  		return 0;

Does changing this check break kernel command-line overrides during boot?

During early boot when command-line parameters are parsed, ctx is not yet
allocated, so damon_reclaim_enabled() unconditionally returns false.

If a system has damon_reclaim.enabled=3DY in the boot parameters and an
administrator appends damon_reclaim.enabled=3DN to override it, the first
evaluation correctly sets the internal enabled flag to true.

However, when the second parameter (N) is processed, enable is false.
Since damon_reclaim_enabled() also returns false, the condition matches
and the function returns 0 immediately. The internal enabled variable is
never updated to false, causing the module to start unexpectedly when
damon_reclaim_init() runs.

Should this keep checking the internal enabled variable during early boot?

> =20
>  	/* Called before init function.  The function will handle this. */
> @@ -359,15 +349,46 @@ static int damon_reclaim_enabled_store(const char *=
val,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418014439.6353=
-1-sj@kernel.org?part=3D1
