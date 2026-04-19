Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0213D503
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617329; cv=none; b=tWiMMn1mAlOQtyw+ARNU3eQjm79vgv69Vh7uqcD9ntJwz8stYDlBmq2B0HFTFzjRYDJLhaqRL3F0UOH4Os6ThTs553knJN6DXUoSa+w5XPstKRHsSoThZFUAnhA1QWF6eM95ItrnFUs7pNWrWTwiTDQb6/ubHodZV9h1vgt9SP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617329; c=relaxed/simple;
	bh=ewv+eD2RygO547e2azVlnZiwek3Se2sd/i6LdLb2hig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=upz5uSE596GvzOBe4VVx2EuWZ+yYpBNucJA3/emiHJuxl67mgWxVd1p/JNGNhgK2ZMrA0Tper1wdlhr0YrBA6sHhNjaRdZYclvZeYxsmQ5pP85//7h1sxZzfHvQ1FaFE9przs86TmlWqCainQ/FkTFolDxAvC2BmWfe8kuprlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3jh1XFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3jh1XFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D9C2BCAF;
	Sun, 19 Apr 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617328;
	bh=ewv+eD2RygO547e2azVlnZiwek3Se2sd/i6LdLb2hig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K3jh1XFpDVFsc81y6g1DWDKnw865dWeZiB8v6j+Wg0I43gaFKZ90JWkcoePjTOxKB
	 bymO2QbqaV1v50px2ycThc6IL6m8IxX1KgstQYc1n9idFzhT0vu5NZNHQf8X6l2ffU
	 3+l73TYSzLEyt+Q6iyWpLrUqH1n0mq0xnNMU+ivyEUkm08CoAvYlQBUSvAuP367Uex
	 3vmPp9ND5Vk/E4vJWqVrrx5m2hB/WoLiPFZYaCpzgOwMnCTCkqsccSEw9Vw23ouPsk
	 kXq22k326jr6BrTOvWPpEDpRauadVyH4AUo8RF0bJm6+AjQ/nue7HxhKmM7rHJTNBd
	 IS4yH0JO3eDbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] mm/damon/reclaim: detect and use fresh enabled
 and kdamond_pid values
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260419161003.79176-2-sj@kernel.org>
References: <20260419161003.79176-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 16:48:47 +0000
Message-Id: <20260419164848.766D9C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Writing to the `enabled` sysfs parameter can cause a NULL pointer =
dereference if `damon_reclaim_init()` failed during boot.
--

commit d88cdacb9c44c0e85a70a745ea16a47c24b53355
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

This commit fixes an issue where the 'enabled' and 'kdamond_pid' parameter
values can become stale if the kdamond thread stops unintentionally. It
updates the parameter accessors to dynamically detect and return the fresh
status from the DAMON context.

Cc: <stable@vger.kernel.org> # 5.19.x

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

Can this result in a NULL pointer dereference if damon_reclaim_init() fails
during boot?

This issue existed previously and appears to still be present. If the init
function fails (for example, due to a memory allocation failure), the global
ctx pointer remains NULL.

If a user later writes 'Y' to the enabled sysfs parameter, the following
sequence seems possible:

damon_reclaim_enabled_store()
    damon_reclaim_enabled() returns false because ctx is NULL
    damon_initialized() returns true because the core framework initialized
    damon_reclaim_turn(true)
        damon_reclaim_apply_parameters()
            damon_commit_ctx(ctx, param_ctx)

And then inside damon_commit_ctx():

int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
{
    ...
    dst->maybe_corrupted =3D true;
    ...
}

Since dst is the global ctx pointer, could this crash the system if a
local user writes to the sysfs parameter when ctx was never allocated?

> -set_param_out:
> -	enabled =3D enable;
> -	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419161003.7917=
6-1-sj@kernel.org?part=3D1
