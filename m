Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1031FDE31
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490260; cv=none; b=iwc4YWqOcaRCR3oN/8dktsySdTRwEgg5I/mgRbi5KR9wwDn8HMG+Ps9p0kE/2+qAyC+xZ8EKUydmnUZ3GSDCcepB1a+rpFw+yRz0fcCCiB5b1gJ9b7Keb7UyO2UkqBcTYb/x4CenK0nyivxL2SuHfS/UWJC8XDWuYv37UA1rDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490260; c=relaxed/simple;
	bh=MmsA1Kwd0CVmI0RoHw1s4xWakaL5re0MGlVuBU2ax8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=axPQzY7wk8/Zp2TBBb3fPsbEAKoQ4pknP64iah1fOXZTGOa0tjXN72l+XwIc0URQUrebYD7Gzq5/n/bOK6/NUrvYDCe/r1F4x94s5TrwU+ZpdePMnFgbWdtWDa87X89WdpUe261yCyayybhA8Y0p1HcQfqxAUPSl4IPrtes2di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDQZzViF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDQZzViF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80C6C2BCB0;
	Sat, 18 Apr 2026 05:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776490260;
	bh=MmsA1Kwd0CVmI0RoHw1s4xWakaL5re0MGlVuBU2ax8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iDQZzViFliFkX/JweSRjLN74lqtCyGIz9IRbFf4FVz/xaIac/ObxAjVLAZvxYvBqy
	 tssxI8GB/1kxyw0cUvJniQN2aEKgIO4Rf77OaPSdQHZGAczHQYI5K6S+lPF1E/YBC8
	 i25OJCgGOXRmHCu89FWFYmDE48g7t9JrQuPGmb1LUnIeDOdzInQcfFlWwKnfGWujjx
	 2haN1J2mt5JedQI+4bNu4QarbXxdaDjzprlKj5YtmMA3nb6BaqYWOdmmj1oYzGcxC8
	 +F77AT8fDR9wcmqzsO2q83ZjwFGPj+7yBzIWjJs68g1yxXKi28i08zGDusqgHgd1dt
	 cU7I+EFRAbCKQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] mm/damon/lru_sort: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260418014439.6353-3-sj@kernel.org>
References: <20260418014439.6353-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 05:30:59 +0000
Message-Id: <20260418053059.E80C6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [Critical] Missing `.set` callback in `kdamond_pid_param_ops` will cause =
a kernel panic if the parameter is passed at boot or via modprobe.
- [High] Loading the module with `enabled=3DY` causes a NULL pointer derefe=
rence on `ctx`.
- [High] Concurrent calls to `damon_lru_sort_turn()` lack locking, leading =
to list corruption and kernel panics.
--

commit 905c8d84b8daa6d4ddb6fc214e81e98101608d53
Author: SeongJae Park <sj@kernel.org>

mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values

This commit updates DAMON_LRU_SORT to dynamically check the running status
of kdamond instead of relying on cached parameter values. This ensures the
status correctly reflects when kdamond stops due to events other than
explicit user requests.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..d284cb336b662 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
[ ... ]
> @@ -386,12 +377,8 @@ static int damon_lru_sort_turn(bool on)
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

Could concurrent calls to this function lead to list corruption?=20

If a user writes 'Y' to the enabled parameter via sysfs at the same
time damon_lru_sort_init() calls damon_lru_sort_turn(true) during module
initialization, damon_commit_ctx() might concurrently modify ctx->schemes
and ctx->targets without internal locking.

[ ... ]
> @@ -430,10 +414,16 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &a=
ddr_unit, 0600);
>  MODULE_PARM_DESC(addr_unit,
>  	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)=
");
> =20
> +static bool damon_lru_sort_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);
> +}
> +
>  static int damon_lru_sort_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
>  	bool enable;
>  	int err;

Is it possible to hit a NULL pointer dereference on ctx when loading the
module with enabled=3DY?=20

If the DAMON core is already initialized (e.g. built-in), damon_initialized=
()
would return true, bypassing the early exit in this function. This could
lead to calling damon_lru_sort_turn(true) before damon_lru_sort_init() has
run, causing damon_commit_ctx() to operate on a NULL ctx pointer.

[ ... ]
> +static const struct kernel_param_ops kdamond_pid_param_ops =3D {
> +	.get =3D damon_lru_sort_kdamond_pid_load,
> +};
> +
> +/*
> + * PID of the DAMON thread
> + *
> + * If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thre=
ad.
> + * Else, -1.
> + */
> +module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);

Does this cause a NULL pointer dereference if the parameter is passed at
boot or via modprobe?

The kernel parameter parsing code in parse_one() doesn't check if .set is
NULL before invoking it:

    err =3D params[i].ops->set(val, &params[i]);

A dummy .set function returning an error might be needed to prevent a NULL
pointer dereference when parsing command line arguments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418014439.6353=
-1-sj@kernel.org?part=3D2
