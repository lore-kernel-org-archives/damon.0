Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0323E35F
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776553078; cv=none; b=B78qJAoeIwcumd7vSnG8O95YiKOGGILm5WUxTdyhm78de1zjKjtFm+ZyRt/RriiCyBJ2BX3qwttLOCXcQtCOTgqSPMsrP8/DQDJZD3ZtyjJdACokO1kxK03v0VFKN0V7vVpPcR4vIMHAkLapLPLLIg974V4qbo0PALNXRPTpbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776553078; c=relaxed/simple;
	bh=Xc9btc3bXJ/MF4jLrrzbqIJY6AHRW4lYbLE7i6ZFR2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFfQBsQB9o+HBX8U3dOmzEq5bhTEaxjOUEvWdh6WUFBRZuCDUI1WyC+VU1R7Zp9SZmhqb0hhNH6dEqblaPL8dlzHTONoSB8Gqz8mtRzVZotvk8Oel4J35tLwGc0FGErWYVZTZVCkExg7+aw5DvxGWNX1/5UZ3ittufB+qnp5QJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWhcAnX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWhcAnX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95221C19424;
	Sat, 18 Apr 2026 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776553077;
	bh=Xc9btc3bXJ/MF4jLrrzbqIJY6AHRW4lYbLE7i6ZFR2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AWhcAnX+L20ftEmAECpKCaD8lkphl5p0VTmNJwW2dE0nFjfkan9LbDVTG8Y8qJH1d
	 9SZaM/E5iuLncNbINY4ODC33thyBMETLCzcmHY+rkUXPAD/IAuI/coqK9/4xiZwkIe
	 082eeKEOG8NTH116gunD6D2eKZeJY+StUooRxQtb/NEKbKuzAlYJpHkWnCh/qcCFqa
	 TZOfXniL7lQMtzqajm08SwbhuHvadlk4Z4vyagnPoI9EGCgaiMkisRIwCCek+l8zqW
	 Pe1rYUAbrzD9deMqKAe29paVyGAjfcUh3bCnEoT37tIUMFWq/OXIOW/V/i5OTfG0jl
	 kBin/bGtHQeog==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 1/3] mm/damon/reclaim: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260418222758.39795-2-sj@kernel.org>
References: <20260418222758.39795-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 22:57:57 +0000
Message-Id: <20260418225757.95221C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 2 potential issue(s):
- [High] Missing context initialization check in the sysfs store handler ca=
n trigger a NULL pointer dereference if module initialization fails.
- [Medium] The `damon_reclaim_enabled_store` function parses user input dir=
ectly into the global `enabled` variable before using it for control flow d=
ecisions, causing a Time-Of-Check to Time-Of-Use (TOCTOU) race condition.
--

commit 9d2c63ed13e63f6709b2752f9d974f5055f9d97e
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

DAMON_RECLAIM updates the enabled and kdamond_pid parameter values dynamica=
lly
to prevent stale values when the daemon is stopped unintentionally. This
ensures users see the fresh running status and can restart the daemon when
needed.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da147786583..fe7fce26cf6ce 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> @@ -332,42 +316,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &a=
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
> -	bool enable;
>  	int err;
> =20
> -	err =3D kstrtobool(val, &enable);
> +	err =3D kstrtobool(val, &enabled);

By parsing user input directly into the global enabled variable, does this
introduce a race condition?

If multiple threads write to the sysfs enabled file concurrently, thread A's
parsed input could be overwritten by thread B before thread A evaluates it
in damon_reclaim_turn(enabled).

Could this cause thread A to execute the opposite action of what was
requested while still returning success to the user?

>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enable)
> +	if (damon_reclaim_enabled() =3D=3D enabled)
>  		return 0;
> =20
>  	/* Called before init function.  The function will handle this. */
>  	if (!damon_initialized())
> -		goto set_param_out;
> +		return 0;
> =20
> -	err =3D damon_reclaim_turn(enable);
> -	if (err)
> -		return err;
> +	return damon_reclaim_turn(enabled);

Can this trigger a null pointer dereference if the module initialization
fails?

If damon_reclaim is built into the kernel and damon_reclaim_init() fails
(for example, due to an allocation failure), the global ctx pointer remains
null. Because it is a built-in module, the sysfs parameters remain exposed.

When a user writes 'Y' to the enabled file, damon_initialized() will pass
because the core DAMON subsystem initialized successfully during boot. The
code then calls damon_reclaim_turn(true) which passes the null ctx down to
damon_commit_ctx(ctx, param_ctx).

Should there be an explicit if (!ctx) validation before attempting to start
the reclaim process?

> -set_param_out:
> -	enabled =3D enable;
> -	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418222758.3979=
5-1-sj@kernel.org?part=3D1
