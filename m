Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685F367B84
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781913387; cv=none; b=qmGlul96OoxS/+xzDpMej/QBZogpoMFb2mWQp+K8xFmmzNfESZzzpQUseH713VjXiy8FX8t7lS5iS4Q1+Z8do6Y9LI0iC6pwrBynt6d538WpbjSNgnJ0n0KRGsdEBHyeWaQjtpRVtv4Oa4BVsPPp8WYZXgu6MybH4yjHG/Fwg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781913387; c=relaxed/simple;
	bh=hva1/BB1GJmR8Md0+MhCmhBvQVAg2L7vKUngUbQyTZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bjxdIAJ9e5gM7+6f10IORTDcEBQYgn2NcsV7mVkVPEEZ4FHc4Si/TuKaVK3QFYB9k6SYvkI12mGCDzqE0qES0gZAZpH3XGhInaykTDY4XpeIgrwebWqPDWpybM85LURU+UkzEw36uYhnH/Qp0VUwEgFWjqnmQ13G5+Xnuob9s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhKpURR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhKpURR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A191F000E9;
	Fri, 19 Jun 2026 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781913385;
	bh=CtHEPJ0R/maAVTI17bPDzpRYa37TbCzzkZjWJc5Bjb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jhKpURR/1wis269C/G29XRVX38rS2yJYe0TV5xH/33YYcgg7y2SmVTn3OjQcbvKM1
	 sGYgn/Bw8ux4seEKOzhBdqysLhpgPXXQ2ccs3KYtw+xO2JlWD6bZeqhvB2x2nRKYRR
	 EOMPLxF9++YDVnA5I4169OGixOfD3cSxlm9upytpTmrx84vsWmgNrPSgDDkM9lkUm2
	 A+Gly2rtEisiqB25nP5XoRHr6Xdu4IcLCS0214/JWKpUtfRYiSB1QlSg0XNjfkmbIS
	 CKCDWSfjh94AIw0fwF6fH7EjF3tiz2qbcKLTdDXj6Pum1pwuO8m2rRRYeliRW5Nufg
	 8aVbjJQcHFFFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/reclaim: fix potential memory leak
Reply-To: sashiko-reviews@lists.linux.dev
To: yahia <yahia.a.abdrabou@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619234606.221163-3-yahia.a.abdrabou@gmail.com>
References: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
 <20260619234606.221163-3-yahia.a.abdrabou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 23:56:24 +0000
Message-Id: <20260619235625.21A191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch attempts to fix a memory leak by destroying the glob=
al `ctx` pointer on the error path, but fails to set it to `NULL`, leaving =
a dangling pointer that causes deterministic Use-After-Free vulnerabilities=
 upon any sysfs interaction.

Pre-existing issues:
- [High] Pre-existing memory leak of `param_ctx` and its associated compone=
nts when `damon_reclaim_apply_parameters()` succeeds.
--

commit 87008af2e1842854e4e34be35814335307b60672
Author: yahia ahmed <yahia.a.abdrabou@gmail.com>

mm/damon/reclaim: fix potential memory leak

Fix a potential memory leak if initialization encounters
an error, ctx won't be destroyed.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 15bc06ae75053..dfe52717d92cf 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -481,6 +481,10 @@ static int __init damon_reclaim_init(void)
>  out:
>  	if (err && enabled)
>  		enabled =3D false;
> +
> +	/* Prevent potenial memory leakage */
> +	if (err && ctx)
> +		damon_destroy_ctx(ctx);

[Severity: Critical]
Does this leave a dangling pointer in the global ctx variable?

Because ctx is global, if it is freed here but not set to NULL, sysfs
callbacks like damon_reclaim_enabled() will bypass their safety checks:

mm/damon/reclaim.c:damon_reclaim_enabled() {
	if (!ctx)
		return false;
	return damon_is_running(ctx);
}

This would pass the freed context to damon_is_running(), which blindly
acquires the mutex:

mm/damon/core.c:damon_is_running() {
	...
	mutex_lock(&ctx->kdamond_lock);
	...
}

Can this trigger a use-after-free when sysfs parameters are accessed after
initialization fails?

>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does damon_reclaim_apply_parameters() leak
param_ctx on the success path?

In mm/damon/reclaim.c:damon_reclaim_apply_parameters():

	err =3D damon_commit_ctx(ctx, param_ctx);

	if (!err)
		return 0;
out:
	damon_destroy_ctx(param_ctx);
	return err;

Since damon_commit_ctx() copies components and does not take ownership of
param_ctx, returning 0 directly without destroying param_ctx appears to leak
the locally allocated context and its attached components.

Could this lead to memory exhaustion if parameters are successfully applied
multiple times?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619234606.2211=
63-1-yahia.a.abdrabou@gmail.com?part=3D2
