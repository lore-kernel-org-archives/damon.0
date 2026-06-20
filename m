Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FCBA3D
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923730; cv=none; b=TJ6OJ991ao2YTsJfh4/7Pgni/fTLZbXFE40NUUxy+k6Mt+0C9+66+aSTQzJL1Gkm/W/iLViI0CxNNWTqfzQ5BrBhdccb648tVNBtL39tUouNAGmqjygGMav214RP/FKo8V66pc5HOgWWD5LDq32zb/BFl4q0HmtCOQOTcQJn2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923730; c=relaxed/simple;
	bh=Tn3LZXWintPTwb+sJIzGpzRfScVlvGqETje5RL3LG2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuarDLwLMf4nxMVZowEh11r43/s6aUdBhJNMR/55Vy/F49lmd+s9WyNA/Eg1kFLQ0gwJvSMjgXfLnZcysreVe0FTWqnj/Yg824mmiy1x7H1N1z20/IyIvlIWRfQm+jD+854QoFFAhAYztYSv7ViGsEcnVq0fcm6U7JVm1Y3LYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNa9jCzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNa9jCzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28561F000E9;
	Sat, 20 Jun 2026 02:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781923728;
	bh=TYz4BK/cvmExAu8KPRYcal0QWzKcu23sRpEmrShmMEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNa9jCzQvL8EcI/ffcs/iAWUzacMLutlDdM5Ks7lvkriaVCBdAFMy7El6vzBd2OK9
	 YFbLJZH9MZowbP5MRKG51h6FSUuBJZG1we41fJ97tGaAYatlH/sYuXUZANgmiEh0FH
	 uiToTm0ow+pnVwH3GHGj8KoDQrs5j2HHTsppB504eNg3TBNyy2s8Mktemd1yCazECH
	 ty5ygmuSdiOybZbl6Z39ki4YQ82lTvavcENM8Dg+kM+CJgGaVoPKC8r6LzxJiGAXlJ
	 tqYbQY5kJEkwQG/W9xKG2uURkqudu/ZPNdadkDoE/jaxydy4Da/kFKYulAWMBuhrlX
	 5JA3fNYiKRnww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] mm/damon/reclaim: fix potential memory leak
Reply-To: sashiko-reviews@lists.linux.dev
To: yahia <yahia.a.abdrabou@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620003557.243313-2-yahia.a.abdrabou@gmail.com>
References: <20260620002614.83004-1-sj@kernel.org>
 <20260620003557.243313-1-yahia.a.abdrabou@gmail.com>
 <20260620003557.243313-2-yahia.a.abdrabou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 02:48:48 +0000
Message-Id: <20260620024848.A28561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Use-After-Free and double-free in the DAMON reclaim target ini=
tialization error path.
--

commit 277092b38a2c2a13afa6d95d878b7d2841e91821
Author: yahia <yahia.a.abdrabou@gmail.com>

mm/damon/reclaim: fix potential memory leak

This commit attempts to fix a potential memory leak in the damon reclaim
initialization path by destroying the context if an error occurs.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

>  	/* 'enabled' has set before this function, probably via command line */
>  	if (enabled)
>  		err =3D damon_reclaim_turn(true);
> =20
>  out:
>  	if (err && enabled)
>  		enabled =3D false;
> +
> +	if (err && ctx) {
> +		damon_destroy_ctx(ctx);

[Severity: Critical]
Could this introduce a race condition with the kdamond background thread
leading to a use-after-free and double-free?

If damon_reclaim_turn(true) successfully starts the kdamond_fn thread but a
subsequent operation returns an error (such as -ECANCELED if the thread
encounters an early failure), err will be non-zero.

If that happens, kdamond_fn might be concurrently executing its own teardown
sequence:

kdamond_fn()
done:
    damon_destroy_targets(ctx);
    ...
    mutex_lock(&ctx->walk_control_lock);
    ...

If we blindly call damon_destroy_ctx(ctx) here, it frees the ctx and its
targets while the kdamond thread is still actively using and freeing them.

Should this path ensure the kdamond thread has fully stopped (perhaps
via damon_stop() or similar synchronization) before destroying the context?

> +		ctx =3D NULL;
> +	}
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620003557.2433=
13-2-yahia.a.abdrabou@gmail.com?part=3D1
