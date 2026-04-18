Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D329AAF3
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776556316; cv=none; b=dMv3QgTftth0inOktYBfkBSO8Z9aKVnF77bc3+QF4kKOo2nn68WkKY+hv9FhlBnBB97Srgfpg2ep3WMlReRX0xnp6ggRicGKgr2328YTb5wGYNJvIoIdSrX68CnAmhkFnYqjw8Qx0HKqxy/akRRPgPHgLnj5sfT1yKJwehg7zN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776556316; c=relaxed/simple;
	bh=9ZfP1jaCa+/+rApD2p+yCR8QbSGY4/s/s5+uMRDFaTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rve5D9XwFhMDbjg3RW/F0tuIoln58qNHBufo1gEnns6Hs09OkdpL/JpRMH7s/PsEmw8iDKZDRjyDfp2yrBP9wrrxrElIz6DO2OsTphQof8rPFxD8sxTkXnLme033qssRY2e34/EtBR/ODmQErBesroj5IRzrEzD/X3zBZ4wv0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/iHhooY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/iHhooY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4953C19424;
	Sat, 18 Apr 2026 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776556315;
	bh=9ZfP1jaCa+/+rApD2p+yCR8QbSGY4/s/s5+uMRDFaTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=T/iHhooYRcEEU0j+6ZWh8gOxIPFdNIt8On3v+lUuTPPr9MtuirTQFXEgxVngwtniq
	 m2mYJ8JISJttInPmVkTyS/xqVWuUWwAGPTRK/mpQhGSmOrVGFfUEJEmYOedUGbzATK
	 uOzqxVhAACcah6SAcfoqiFvw/bSFB2j+4QgVcLQzY2ei81dSjkb5Ggv/fyS4zd7GSX
	 qPyEpgmeZUIGlERU7Jzohv+JRjIpwoyQ+9sR0qUA/E6OFPNmzKE1ZNI2dp+LLwOQ2W
	 IHKSOVOopnkpoGm4/YzaXWZVlX36a+IbTuZc5Af5iMHwiwmzbCkxdVYin7cwPr6Pbe
	 f87HvP2e0gSVg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 3/3] mm/damon/stat: detect and use fresh
 enabled value
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260418222758.39795-4-sj@kernel.org>
References: <20260418222758.39795-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 23:51:55 +0000
Message-Id: <20260418235155.A4953C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Bypassing damon_stat_stop() and overwriting damon_stat_context cau=
ses a memory leak when explicitly disabling or restarting a kdamond thread =
that stopped internally.
--

commit b9703c85b8e9f48ea8dc673102aa2ecc0e1ac448
Author: SeongJae Park <sj@kernel.org>
mm/damon/stat: detect and use fresh enabled value

This commit dynamically detects the status of kdamond instead of relying on
the saved parameter value to avoid showing stale data when the daemon stops
internally.

Link: https://lore.kernel.org/20260416040602.88665-1-sj@kernel.org

> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 99ba346f9e325..3951b762cbddf 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c

[ ... ]

> @@ -273,17 +276,23 @@ static void damon_stat_stop(void)
>  	damon_stat_context =3D NULL;
>  }
> =20
> +static bool damon_stat_enabled(void)
> +{
> +	if (!damon_stat_context)
> +		return false;
> +	return damon_is_running(damon_stat_context);
> +}
> +
>  static int damon_stat_enabled_store(
>  		const char *val, const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
>  	int err;
> =20
>  	err =3D kstrtobool(val, &enabled);
>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enabled)
> +	if (damon_stat_enabled() =3D=3D enabled)
>  		return 0;

Does this early return cause a memory leak if kdamond stops internally?

If kdamond stops internally, damon_is_running() will return false, causing
damon_stat_enabled() to also return false. However, damon_stat_context
remains allocated.

If a user subsequently writes 'N' to the enabled parameter to clean up,
damon_stat_enabled() =3D=3D enabled evaluates to false =3D=3D false. This t=
riggers
the early return here, bypassing damon_stat_stop() which would have
called damon_destroy_ctx(damon_stat_context) to free the memory.

Similarly, if a user writes 'Y' to restart the module, damon_stat_start()
will be called. Looking at damon_stat_start(), it allocates a new context
by calling damon_stat_build_ctx() and overwrites the damon_stat_context
pointer without freeing the previous one.

Can this leak the context in both scenarios?

> =20
>  	if (!damon_initialized())
> @@ -293,16 +302,17 @@ static int damon_stat_enabled_store(
>  		 */
>  		return 0;
> =20
> -	if (enabled) {
> -		err =3D damon_stat_start();
> -		if (err)
> -			enabled =3D false;
> -		return err;
> -	}
> +	if (enabled)
> +		return damon_stat_start();
>  	damon_stat_stop();
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418222758.3979=
5-1-sj@kernel.org?part=3D3
