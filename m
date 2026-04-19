Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4B276050
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619698; cv=none; b=n6ptDjsQqXXGtip4HYBAGDkdte25tMCFfhcLOjtApZMdQNJasCVCWVoUrl10C4bc0L83BnBr1QAgQkcnC/nflzP4JqrCSeZWmAXM8qhGWYhbwhPnLPUzA/9UdWFrECpchtElY57GkPT2tTkrTQK8R986Pxa/jOcam6jssuA/AAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619698; c=relaxed/simple;
	bh=dDDMhB0T+b14QbVkhl1OB9ovfy0i4rHpnH+2qe+1L8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T733MzJ4XX8eypxntkRBOIy129sX0FXc/knjSnG+pYC9mBCHVczTdZb/t6FApJD0L2mVmm3YGMowxny8pdv32izOCaPWUJQ2PvGgPUCJYwh2A4OnwHqIgUusRcA35jlvZU1x5i063VH/dO/MmqEfxtjGDbJ9PLlHQnMhQPSt4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkIdxtmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkIdxtmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FA2C2BCAF;
	Sun, 19 Apr 2026 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619698;
	bh=dDDMhB0T+b14QbVkhl1OB9ovfy0i4rHpnH+2qe+1L8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dkIdxtmjsqXJoIsXLp0CGsoGKTVaEviPskw1Vzq+hpz5Ogvd+JW0zfqh6qjnXuZlB
	 HseNmxwH74m6g5g7sULmxqNfPLFzokecRmFPLRw2CtsLmS7wQdD/SyOUjInmrtwdVz
	 50xXLTkbcBYdFA1uycoBgVci4eEfVJBv1AZHxW8j+ImGwhaHd2/z5YSLl0yAyrPAyk
	 r3XULSet0NY/A4E+qZ20OngmlrYOsd0qHGX4Wnaa1Eresem19xyF1GOAfRR2ztjz9F
	 TdcSAq+bF5QmB1dDeAA1GvkeS95w/VOlD87iB3Q5urY/WnSIGM7tArJOvHee2iWe70
	 4IEtrjVbk9TEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] mm/damon/lru_sort: detect and use fresh enabled
 and kdamond_pid values
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260419161003.79176-3-sj@kernel.org>
References: <20260419161003.79176-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:28:17 +0000
Message-Id: <20260419172817.E2FA2C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Loading the module with the `enabled=3DY` parameter causes a NULL =
pointer dereference.
--

commit e25c111d55f5d7c99165dbc8b59a5261d640ada5
Author: SeongJae Park <sj@kernel.org>
mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values

This commit updates DAMON_LRU_SORT to dynamically detect and use the
current running status of the kdamond thread for the enabled and
kdamond_pid parameters. This prevents users from seeing stale values or
being unable to restart kdamond if it stops due to unintentional events.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..8494040b1ee48 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

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
> +}

This isn't a bug introduced by this patch, but does this code cause a NULL
pointer dereference if the module is dynamically loaded with enabled=3DY?

When the module is loaded as a dynamically loadable module with the
enabled=3DY parameter, the kernel's module loader parses the parameters
before damon_lru_sort_init() runs.

This invokes damon_lru_sort_enabled_store(). Because damon_core (a module
dependency) is already loaded, damon_initialized() evaluates to true,
bypassing the safety guard.

The function proceeds to call damon_lru_sort_turn(true), which eventually
calls damon_lru_sort_apply_parameters(). This invokes:

    damon_commit_ctx(ctx, param_ctx);

At this point, the global ctx pointer is still NULL because it is only
allocated later in damon_lru_sort_init(). damon_commit_ctx() unconditionally
dereferences the pointer:

    dst->maybe_corrupted =3D true;

causing a direct NULL pointer dereference and a kernel panic.

Should this check use !ctx instead of !damon_initialized() to properly
defer execution to the init function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419161003.7917=
6-1-sj@kernel.org?part=3D2
