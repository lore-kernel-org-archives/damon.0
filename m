Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2477312826
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776554973; cv=none; b=Z0hAWIjOgdlf8LNf7I7oXeSQC29Ul09CBLkBZNwsD5iBy2kyXOyHieKTnhisqhP6TL5BywMpetiIew//lqWikaQNIHieXW7LYSnv2VD1Dr7oBTeuYhAhP5uSf28slJscsRDLbq1Nszb8k5feoEoD1Qm5Yw89olRD6bSxcR+QDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776554973; c=relaxed/simple;
	bh=oNzH10sCRl70NtiX4DnM+Qr4qcP9/DSeGwMU/5/N2y8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/f5sPdJOYXx648lrmNHY1VobonVyZ7ZxmOOqiHFnStknFG1DpxBuXcWsNjmhPcMkBnQ2VcOlqL5k9fUZbIwYhS12Y7MiFYUYKqMC/Ah7gta9KZiw6CI8PoAZJBjFAcmicXVH9RsKlcB9o+pzteJ1ckhMc5ficmpKgiNNUECKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMLDJNBA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMLDJNBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE8CC19424;
	Sat, 18 Apr 2026 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776554972;
	bh=oNzH10sCRl70NtiX4DnM+Qr4qcP9/DSeGwMU/5/N2y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sMLDJNBAKLOjVx7qxinEMKmoGmr/NdH3XkPx7vb0L+dwbHKuoxG2361wzAhaHMv6e
	 exWl+FPjUT/XpRzB9ul29BSy7vJiid5Q3L4lrHzYAlzJU9GSOwyyWOYmMraHPn8wMA
	 tpWTCoxQHkNsnpeOaDq1we+LXtGYjrqHz0wkQ+9UeFNk4NoHd1jQ+ZP1BPQkNGJsUR
	 Mumbmaet5jdgXhL/1t5amf8PyRkjbZOl9OgFZ/47qXUScove8amicCT1g5GNskbCVP
	 ei2Y4NILjNRSlM7nLPWOEUSuO2QNVVYk3Uso792mCxkov50HXJfF1bz3L5jD3bY18Z
	 5cqsBpMfrq1cw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 2/3] mm/damon/lru_sort: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260418222758.39795-3-sj@kernel.org>
References: <20260418222758.39795-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 23:29:31 +0000
Message-Id: <20260418232932.5CE8CC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Writing to the `enabled` sysfs parameter causes a kernel panic if =
the module failed to initialize during boot.
--

commit fa970a77d3fa7186f23394f3a1cfedc7ae08380c
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid va=
lues

This commit updates the module to dynamically query the running status for
the enabled and kdamond_pid parameters. This avoids stale parameter values
if the kdamond daemon stops due to unintentional events like allocation
failures.

Cc: <stable@vger.kernel.org> # 6.0.x

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..8494040b1ee48 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -430,42 +414,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &a=
ddr_unit, 0600);

[ ... ]

>  static int damon_lru_sort_enabled_store(const char *val,
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
> +	if (damon_lru_sort_enabled() =3D=3D enabled)
>  		return 0;
> =20
>  	/* Called before init function.  The function will handle this. */
>  	if (!damon_initialized())
> -		goto set_param_out;
> +		return 0;
> =20
> -	err =3D damon_lru_sort_turn(enable);
> -	if (err)
> -		return err;
> +	return damon_lru_sort_turn(enabled);

Could writing to this parameter cause a kernel panic if the module failed to
initialize during boot?

If damon_lru_sort_init() fails, the static ctx variable remains NULL. Becau=
se
the sysfs parameters are registered early, they remain exposed and writable
even after an initialization failure.

Writing true to the enabled parameter bypasses the damon_initialized() check
since it only checks the core DAMON cache, not this module's ctx.

Execution would then follow this path:

damon_lru_sort_enabled_store()
  damon_lru_sort_turn(true)
    damon_lru_sort_apply_parameters()
      damon_commit_ctx(ctx, param_ctx)

Since ctx is NULL, wouldn't damon_commit_ctx() crash when it tries to
dereference it? Should there be an explicit check for !ctx before attempting
to apply parameters or turn on the feature?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418222758.3979=
5-1-sj@kernel.org?part=3D2
