Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EB3290B8
	for <damon@lists.linux.dev>; Thu, 14 May 2026 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724106; cv=none; b=f49L9tgkql8d1ZWOJWY/OdDQYJDgTuGeuE1VKD9KlAh8IXO0wMEm7JvcyvUNqmyve+CYRdRVAPTjWT440ahxLTfOYAVASnqmg0BJSA0aSoACca1WAWadnEBlAZlaLY2gnVbSuylGEyag95a3/CV7zZaF3RMWGs4y4tWMO8lX0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724106; c=relaxed/simple;
	bh=fDJCV9QXcvvQ9zmOHOsOnRs/Mc04u1ne/nUEF+VzgNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p26PfqBOoPSJd4uYs2tC8WFVAe1a2FNaPEdDvu0smUhdGuSIyXd8+jemuML8ABiNtuoyiBTEZtTLm2m8+u5J3P4TTtiARoTnaTuDh+Nx6lToS6U/MfHCybyXFHhgZEMhvZB83mg9yTkgWdp+dEjgGYxFyTJOW/pweOArwxgSpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOP/Kh3M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOP/Kh3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA32C19425;
	Thu, 14 May 2026 02:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724106;
	bh=fDJCV9QXcvvQ9zmOHOsOnRs/Mc04u1ne/nUEF+VzgNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GOP/Kh3MMy0jlnZlc16+K+cbMxp6ZNAIC7lvLyU/ZlZy6P4/tvmPeTs5OkgRY6TTk
	 5ZwJbKuGV2YMpcC7SkU5Ws1BkdsgirDonpYmxM7Su+khDDzV7YS199YjXTyVZNBG/Q
	 MOf/1MJ6zM3dhvFl2C7cWYI8e0lDni45Zrhb3HAWtX5FE83YUWuG+BKCfRFjdQzSEb
	 1eKyFEWg0imxxrCyYBBytWjl+12Im2n00dXbL/B4jiuzwBqZF31gZ4avDemiUMDedT
	 gZH71Fk4xHJGrRRpLD21LmrdMbSztGSpdXy6XXlQ+/662ndT4bkk5yIDWm+RKiImFI
	 277VEU3Ae4n1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 2/2] mm/damon/lru_sort: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513043039.173237-2-sj@kernel.org>
References: <20260513043039.173237-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:01:45 +0000
Message-Id: <20260514020146.4FA32C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch completely fails to fix the restart issue, leaving the s=
tate machine deadlocked.
- [High] Use-After-Free when reading sysfs parameters if module initializat=
ion fails.
--

commit 975a161fef47e6bccc8ce6810404c2d8be4ff338
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid va=
lues

This commit updates the DAMON_LRU_SORT module to dynamically detect and rep=
ort
the fresh status of enabled and kdamond_pid parameters. It attempts to addr=
ess
an issue where unintentional kdamond stoppages leave the system in a stale
state, preventing users from restarting the daemon. By directly calling
damon_is_running() and damon_kdamond_pid(), the system aims to provide
accurate runtime information to sysfs readers.

Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 61311800abc98..70cdc7425cdd3 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -285,6 +268,13 @@ static DECLARE_DELAYED_WORK(damon_lru_sort_timer, da=
mon_lru_sort_timer_fn);
> =20
>  static bool damon_lru_sort_initialized;
> =20
> +static bool damon_lru_sort_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);
> +}

Is it possible for this to cause a use-after-free if module initialization
fails?

If damon_lru_sort_init() encounters an error (for example, damon_select_ops=
()
fails), it calls damon_destroy_ctx(ctx) to free the context. However, the
global static ctx pointer is not set to NULL.

Since DAMON_LRU_SORT is a built-in module, its module parameters are exposed
in sysfs early during boot. If a user reads the sysfs parameters after an i=
nit
failure, the dangling ctx pointer would pass the check here, leading to
damon_is_running() dereferencing it:

mm/damon/core.c:damon_is_running()
    mutex_lock(&ctx->kdamond_lock);

[ ... ]

> @@ -301,15 +291,57 @@ static int damon_lru_sort_enabled_store(const char =
*val,
>  	return 0;
>  }
> =20
> +static int damon_lru_sort_enabled_load(char *buffer,
> +		const struct kernel_param *kp)
> +{
> +	return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : 'N');
> +}
> +
>  static const struct kernel_param_ops enabled_param_ops =3D {
>  	.set =3D damon_lru_sort_enabled_store,
> -	.get =3D param_get_bool,
> +	.get =3D damon_lru_sort_enabled_load,
>  };

Does this change actually fix the restart issue, or does it leave the state
machine deadlocked?

If kdamond stops unintentionally, the internal enabled and last_enabled
variables remain true. When the user tries to restart it by writing 'Y' to =
the
sysfs enabled parameter, the underlying boolean value remains true. The wor=
ker
skips the restart because last_enabled =3D=3D now_enabled.

If the user tries to reset the state by writing 'N',
damon_lru_sort_turn(false) calls damon_stop() which returns an error because
the daemon is already stopped. Because of this error, the worker executes
enabled =3D last_enabled, reverting enabled back to true:

mm/damon/lru_sort.c:damon_lru_sort_timer_fn()
    if (!damon_lru_sort_turn(now_enabled))
        last_enabled =3D now_enabled;
    else
        enabled =3D last_enabled;

It seems the subsystem still cannot be restarted without a reboot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026051243-crevice-=
spool-75d8@gregkh?part=3D2
