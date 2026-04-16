Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD82D7BF
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365519; cv=none; b=kmv1ags2obw33pKuXlGsTqHO9l0gbs92XKS45UO6rzB/HVubaiN1Gy6zUEoTItGGFF2RHmaozQexOzApwf1c/XUWbLMutKCxI6LtIfFZuDosI691K+J3jlHoW6RMcIakTTQufcG5IpWVBP+b4YWRG6hSSyC6ETTkST42pLm6t1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365519; c=relaxed/simple;
	bh=Ps0jJabuy1RPCuPWgd4auU6IuAuyi+7S1O8FFen9t0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nYlkRDNlz2j6UflEm3RIhI+okius3d5ZSYFUbNu9rcv6n0aJqSdDKp12Jhg1h327JxxlP5bmVmHOexggsN6fmoYpDu1DaqiWKlXWdLUY2J+5Q5C7Ve2kVmHYQH0QTIvT9jX4UIlAHEwH9UKEZagaGiUbpQBmJrdVjQN3pLqwrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl728tp2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl728tp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54460C2BCAF;
	Thu, 16 Apr 2026 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776365519;
	bh=Ps0jJabuy1RPCuPWgd4auU6IuAuyi+7S1O8FFen9t0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Yl728tp2WnhAUIL4X3XYSEDAOjnIElwn+vA5ajg3oRRBDNr7+lpRshPpMuMzadKXP
	 pfWPM2YRz7PVmkgjzmwhrQK6j2FlfH/Lbr1VlZEs1eVeuILsFGtHBJpvry4NjIY8sb
	 Af5+PMLCvle4ldSJzszxvwnQkI7YOdSUMkiKnIyTgUIfvvFlZk6B/1NJDelFBAagqy
	 N9PPpXN+BZxrdJKZgoNiNYzUPagreh0gM4rSdHkEyawuO+S74Z3v2SdW2aCpnArLXg
	 SM5Y0NDersxnxJr3GJu88rgL9sWUeDyTDFwQM/ZXzwFZXw+nf2hf0mJpfSVLl6rt/G
	 eZFYkonpJbIYw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/stat: detect and use fresh enabled status
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260416143857.76146-1-sj@kernel.org>
References: <20260416143857.76146-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:51:58 +0000
Message-Id: <20260416185159.54460C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Medium] Writing 'N' to the `enabled` parameter after kdamond has stopped=
 unexpectedly bypasses `damon_stat_stop()`, leaking `damon_stat_context`.
--

commit 1171ea4d01e310ec9987bf3cb2d19f8bf89b60cb
Author: SeongJae Park <sj@kernel.org>

mm/damon/stat: detect and use fresh enabled status

This commit changes the enabled parameter's get callback to report the
actual running status of kdamond instead of the static enabled variable.
It introduces damon_stat_enabled() to dynamically check if the context is
running.

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

If kdamond stops unexpectedly (for example, due to an allocation failure in
kdamond_fn), damon_is_running() and consequently damon_stat_enabled() will
return false.

If a user then explicitly disables the module by writing 'N' to the enabled
parameter, kstrtobool() will update the global enabled variable to false.

Could this cause the check above to evaluate to true (false =3D=3D false) a=
nd
return 0 early?

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

If the early return is taken, damon_stat_stop() is bypassed. Does this leak
damon_stat_context since damon_destroy_ctx() won't be called?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416143857.7614=
6-1-sj@kernel.org?part=3D1
