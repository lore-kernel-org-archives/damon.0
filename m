Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E092244661
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621081; cv=none; b=A65ET0pfWWMcIvNo6jH3+tMEtPnbEvZ/UZWg2XqxCvE7zNcypwhuV1rZUm0RfP6dPHSq83VnTjJgTyeEfFSV2V45wZWX3Uxqseiyh2w9KlzIvMr1POJUnzHb8nArS83C7Ib8Y+TxkA8B3Kbqt33w97cg67dK/dDJ2UlJRaM661A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621081; c=relaxed/simple;
	bh=Mlw3ZTdqI/4YApvpCnivPBPfHavKQ8KqfToOFXc/wp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkOIb8T7QqVEG7HRGuduKBbqSGZLliVPVxWW46ButbWAfJAeiu6ZK54zS9ex3H0diyUovenijbkLXTmkIrGEOM1FzYP+KGDPrcHJ50s9kJwi2z3b0Gwuu3sf1lxZ5Gm+XXfN+vffabEAUID+WbwD3UJpCaL4nMjNynBOTc0xp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtxs7diW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtxs7diW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC4EC2BCAF;
	Sun, 19 Apr 2026 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776621080;
	bh=Mlw3ZTdqI/4YApvpCnivPBPfHavKQ8KqfToOFXc/wp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Mtxs7diWeCFymMpdmEoxrj+mdwxlhvi1FqDRpz9YazPyexMDvg906WnDX4MeZsOmF
	 dt2abFTKWqF1m7WgCQZYqBldTgfkDs3Ag7WvTS8l7UXIgsrdsT3M73DWM4DwXZCslR
	 IZuI4YQHDlsxvA3e+ox7IGMbD0Pqp7lVyYp4SYqm9A2BkfMuAYbWrdpkhQaWBrD20t
	 Kvy8d7FoMwz9i9GXtKjA4B56U9if0/aKVfHYkSQwlsLtR8hx4cqECELebUTbSNXmQa
	 A4Z+DYArL/S8D0x1hVMW8Ice2DdgnAncd7zd5nstP6Z/vzJY14MRdm3HSvRGtYV7Rk
	 z2PtOGXrG3LXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] mm/damon/stat: detect and use fresh enabled
 value
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260419161003.79176-4-sj@kernel.org>
References: <20260419161003.79176-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:51:20 +0000
Message-Id: <20260419175120.AEC4EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 2 potential issue(s):
- [Critical] Passing `enabled=3DY` during module load triggers a double-sta=
rt, failing initialization and causing a Use-After-Free kernel panic.
- [High] Resource leak of `damon_stat_context` when explicitly disabling th=
e module after an internal kdamond crash.
--

commit 16eae8a1bf380cdb61d4dd6b62187dd09f8ce859
Author: SeongJae Park <sj@kernel.org>

mm/damon/stat: detect and use fresh enabled value

This commit updates the DAMON_STAT module to dynamically detect the running
status of its kdamond thread rather than relying on a cached parameter
value.

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

If kdamond terminates asynchronously (for example, due to an allocation
failure), damon_stat_enabled() will return false.

If a user subsequently disables the module by writing 'N' to the enabled
parameter, this condition (false =3D=3D false) evaluates to true and the
function returns 0.

Does this skip the call to damon_stat_stop() and leak the
damon_stat_context since damon_destroy_ctx() won't be called?

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

During module load via "insmod damon_stat.ko enabled=3DY", parse_args() cal=
ls
this store function. Because damon_stat_enabled() dynamically returns false
at this point, the code proceeds to call damon_stat_start() to start the
kdamond thread.

Shortly after, the module initialization function damon_stat_init() runs,
sees enabled =3D=3D true, and calls damon_stat_start() again. This second c=
all
returns -EAGAIN because the context is already running.

The module initialization then fails, causing the kernel to unload the
module and free its memory.

Since the kdamond thread is still actively running in the background, can
this cause a Use-After-Free when the thread accesses the freed module
memory?

While this issue previously existed if CONFIG_DAMON_STAT_ENABLED_DEFAULT=3D=
n,
does this patch introduce the regression for the default configuration as
well?

>  	damon_stat_stop();
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419161003.7917=
6-1-sj@kernel.org?part=3D3
