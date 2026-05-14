Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF73F413A
	for <damon@lists.linux.dev>; Thu, 14 May 2026 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724162; cv=none; b=s/7/puA2uCB8FiNPH+Slre2t2zlIORpCVsjDr1nzqDLuXrgEkum9DgRDI2IGZwttVlK/GmczZMTJh++ZRJksUwGMxHfl+IWIv9m0hQ/wVGpniE4WtNv1jMxJ7Q5ecHhW5sBDbvL+tNI1fw0bO4trYIQ/AU8A1BsUwI/F1iZEaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724162; c=relaxed/simple;
	bh=1ea6Rsof7QEwcyM0QlomCsm90eMFSV5d/sZolerh9Bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o4QIbm6Moz3Up+20kWjzs5/HbcTCpNkYm5usLsyNiYwdErwpiw8feAUF4gygd63vGlFjhHNs4NVN4bYiaO7D6/k3CBx2bRWS45EF4rgwrQKnLSdWooGXkA9wFadJaQTFei5wIWcIfB1iaf+WIxGUbO6bb7QsmjsdCLeig6KX0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiv5VIPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiv5VIPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD8FC19425;
	Thu, 14 May 2026 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724162;
	bh=1ea6Rsof7QEwcyM0QlomCsm90eMFSV5d/sZolerh9Bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Wiv5VIPSYx3ihzB7rIm3pkFfjE/1HIL1MbiqFyToNvLPMSmPHLd5+6zefAODjjszw
	 r8WjkL1TNCFLfZEFfPGyyKQwNjt3DSVAYLggcigBK47/4HDqsLfmq7OzboFbLH6II4
	 73hT/OdEr366K3JU/ceaKUiID0t8yDxLiivEJkExGaCDmlJyBSxO68PpsMbcw/ZfJC
	 /002i93e1wvT3TXw8D8YNC/e9xr973TckTofuYJMggVuTw8e+LpwDgu/5ptyX+cuBD
	 0DAA4vm1+zrQjJLb/ns5tXL5184rtNS3YGP5Ztm1/cWwa4v9KJrPNzM4besI4LzAua
	 /VTcTYvsey+/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/reclaim: detect and use fresh enabled
 and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513043902.183499-1-sj@kernel.org>
References: <20260513043902.183499-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:02:41 +0000
Message-Id: <20260514020242.5CD8FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Writing to the `enabled` sysfs parameter triggers a NULL pointer d=
ereference if the module's initialization failed.
- [Low] The commit introduces a call to an undefined function `damon_kdamon=
d_pid()`, causing a build failure.
--

commit 45d783d4b3fd23532d7c6b975b70fda3e5324f1b
Author: SeongJae Park <sj@kernel.org>
mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

This commit modifies the DAMON reclaim module to dynamically detect and use
the fresh running status of kdamond when parameters are requested. This
prevents stale cached statuses from being shown to users when kdamond stops
unexpectedly.

Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 7ba3d0f9a19ac..9446e7a1b476f 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> @@ -334,42 +320,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &a=
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
> +}

If module initialization fails during boot, for example due to an allocation
failure in damon_modules_new_paddr_ctx_target(), the global ctx pointer will
remain NULL. Because damon_reclaim is built-in, its sysfs parameters are
still exposed.

If a user subsequently writes to the enabled parameter,
damon_reclaim_enabled_store() will see that damon_initialized() is true
because the global cache is initialized, and it will call
damon_reclaim_turn().

This unconditionally passes the NULL ctx pointer to either damon_stop() or
damon_reclaim_apply_parameters(), which eventually calls damon_commit_ctx().

Could this cause a NULL pointer dereference when accessing the uninitialized
ctx pointer?

[ ... ]

> +static int damon_reclaim_kdamond_pid_load(char *buffer,
> +		const struct kernel_param *kp)
> +{
> +	int kdamond_pid =3D -1;
> +
> +	if (ctx) {
> +		kdamond_pid =3D damon_kdamond_pid(ctx);

Is the function damon_kdamond_pid() defined anywhere in the tree?

It appears this function is called here but might be missing, which would
cause an implicit declaration and linker error. Could a prerequisite patch =
be
missing from this cherry-pick?

> +		if (kdamond_pid < 0)
> +			kdamond_pid =3D -1;
> +	}
> +	return sprintf(buffer, "%d\n", kdamond_pid);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513043902.1834=
99-1-sj@kernel.org?part=3D1
