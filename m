Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6971EEA3C
	for <damon@lists.linux.dev>; Thu, 14 May 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725119; cv=none; b=eihC4agnf/HtF7cmfd8zCwcQbqYV+9d9GnwG+LKZOj7hnbs/ykhLqsIVB/fBNusa1iHtd3PDzEIN2FE8Ohy04jLV3rMSMaQtvqjS8yAP+3dMpZzN/ETb04+gXp9ODanFXf8aDBSk/nY0dkmi6OY9F860urBUFlJgdhnz3Tx73V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725119; c=relaxed/simple;
	bh=k2OhEQ/7vWVG897CN05MQsWM7SG34jRo3iWMhHRL6ro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpsEJQrAtFugWjfnsMogi0jlsMLELVQexLXA0guByL9FUlGZWd09oB66aHZLKJk99JImuUS1MxDVv+geoHOseWNsDgfM8sVcgRDIqH40U1koPd8ZVy83r6JlVm7OdAQ/IXVrojezW3Qia0XeJxk08lzji2JT3A6XULw3KhxvmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiacCyuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiacCyuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3997C19425;
	Thu, 14 May 2026 02:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725118;
	bh=k2OhEQ/7vWVG897CN05MQsWM7SG34jRo3iWMhHRL6ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PiacCyuDa2qxeeFPAopSfBCDFr8Sprb1AlDAaSOwkO0uZHhEp/6zvE0CkzLfgKljc
	 hJTofIjJ7pJW5D/Bl2rv/Ux1SbxJ973Bp4+PoTz2LMJk5sr5iCcsF5bHdp5/Qh0BaP
	 zTFNfHDghRTY/Ge7a+C4uwXrzbyNadVhVJS5yVx+NwLOa2C4ZfcRltzWc4qwNuCyST
	 3nJy1YnlPjgfASwevyLz8ULSm2g2FWeeo4a2mIOgmUN9ERrN866RzK3uQJhUklmQAi
	 EvanPSaY0mZo3JqILBAFGckt7gFs69LDRYyRj8dh2rtaDkkGYJjbLnK9jLMzHlkp2U
	 s4mYDdaYLfnnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/reclaim: detect and use fresh enabled
 and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513045238.194161-1-sj@kernel.org>
References: <20260513045238.194161-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:18:36 +0000
Message-Id: <20260514021838.B3997C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A race condition during module initialization allows userspace to =
trigger a use-after-free kernel panic via the `enabled` sysfs parameter.
- [High] `damon_reclaim_apply_parameters()` incorrectly applies schemes and=
 attributes to the global `ctx` instead of `param_ctx`, causing them to be =
destroyed by `damon_commit_ctx()`.
- [Low] The patch introduces calls to undeclared functions `damon_is_runnin=
g()` and `damon_kdamond_pid()`, causing a build failure.
--

commit e5b3e77c68d72139966a3f423a04c39c6310ef66
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

This commit updates DAMON_RECLAIM to dynamically detect and use the fresh
running status and process id for the enabled and kdamond_pid parameters.
It avoids caching the status, which can become stale when the thread stops
unexpectedly.

Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 65842e6854fd1..9df096218beb7 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -247,60 +238,93 @@ static int damon_reclaim_turn(bool on)
>  {
>  	int err;
> =20
> -	if (!on) {
> -		err =3D damon_stop(&ctx, 1);
> -		if (!err)
> -			kdamond_pid =3D -1;
> -		return err;
> -	}
> +	if (!on)
> +		return damon_stop(&ctx, 1);
> =20
>  	err =3D damon_reclaim_apply_parameters();

Does damon_reclaim_apply_parameters() correctly configure the scheme?

Looking at its implementation in mm/damon/reclaim.c:

    err =3D damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
    ...
    err =3D damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
    ...
    scheme =3D damon_reclaim_new_scheme();
    ...
    damon_set_schemes(ctx, &scheme, 1);
    ...
    err =3D damon_commit_ctx(ctx, param_ctx);

It seems damon_set_attrs() and damon_set_schemes() are called on the global
ctx rather than param_ctx.

Since param_ctx has zero schemes when damon_commit_ctx(ctx, param_ctx) is
called, will this aggressively destroy the schemes that were just added to
ctx, leaving DAMON_RECLAIM non-functional?

>  	if (err)
>  		return err;
> =20
> -	err =3D damon_start(&ctx, 1, true);
> -	if (err)
> -		return err;
> -	kdamond_pid =3D ctx->kdamond->pid;
> -	return 0;
> +	return damon_start(&ctx, 1, true);
> +}
> +
> +static bool damon_reclaim_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);
> +}

Does this code compile?

It appears that damon_is_running() was introduced in a newer kernel version.
Because this is a cherry-pick, are we missing a prerequisite refactoring
patch that provides this function?

> =20
>  static int damon_reclaim_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
> -	bool enable;
>  	int err;
> =20
> -	err =3D kstrtobool(val, &enable);
> +	err =3D kstrtobool(val, &enabled);
>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enable)
> +	if (damon_reclaim_enabled() =3D=3D enabled)
>  		return 0;
> =20
>  	/* Called before init function.  The function will handle this. */
>  	if (!ctx)
> -		goto set_param_out;
> +		return 0;
> =20
> -	err =3D damon_reclaim_turn(enable);
> -	if (err)
> -		return err;
> +	return damon_reclaim_turn(enabled);
> +}

Is there a race condition between module initialization and this sysfs
parameter store?

The sysfs file for enabled is exposed to userspace by load_module() before
damon_reclaim_init() completes. damon_reclaim_init() allocates ctx early.

If userspace writes to enabled after ctx is allocated but before
initialization finishes, this function will start the kdamond thread.

When damon_reclaim_init() resumes, it will see enabled is true and attempt =
to
start the thread again, resulting in -EBUSY.

If initialization fails and the module memory is freed, could the
already-running kdamond thread execute unmapped memory and cause a
use-after-free regression?

[ ... ]

> +static int damon_reclaim_kdamond_pid_load(char *buffer,
> +		const struct kernel_param *kp)
> +{
> +	int kdamond_pid =3D -1;
> +
> +	if (ctx) {
> +		kdamond_pid =3D damon_kdamond_pid(ctx);
> +		if (kdamond_pid < 0)
> +			kdamond_pid =3D -1;
> +	}
> +	return sprintf(buffer, "%d\n", kdamond_pid);
> +}

Likewise, is damon_kdamond_pid() available in this kernel tree, or will this
result in an implicit function declaration error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513045238.1941=
61-1-sj@kernel.org?part=3D1
