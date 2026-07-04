Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD8304976
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189257; cv=none; b=ga58PD4Rgv3Oxr3EDqHR8D+vGKQ60vyB0552uB+Pu3hhXhi2T88LprAttKanlfygvvNb8P2qDUV3aI3I0eGmJZXr4WvPGYdGd2ohyeG571+374unCs+9dEbWfjfFRRlBWUbsi2bSn6g+t1JZyDt+3aUNdi1B7/PB0wrHfuXjU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189257; c=relaxed/simple;
	bh=jDGdri+2z5ty4hOHhYdKB6jVlSg6wxxl/GNp3eiM0q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0aj9bYv+BonwuUaioqJycBlpx3Xwnr92VNZ3DTHiaaoEd1CpaqyPEoaxbszKPIbdATmdwi7xwBoc2UmmcF7OCXtNRmCNrPfJaFvgh3mlyRt3zK2NFuJTmt/8R1wWk1wNqGXpYP5uUz1yEQtGibIGy40N9u89fjMwRyYRwZnx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpxrzsnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpxrzsnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3621F000E9;
	Sat,  4 Jul 2026 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189256;
	bh=81xZzsV3VKAR9gQoz4l2t+YjeOlnGvfPN8Py6RH2db8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpxrzsnAckJ4koorTSjXYpMoGBZ7yq5u8+q62EuWoFhc8F66lPOu8nUpLoC8Pssky
	 fCh8v2UxKek84dlIndgc86l+Gyz96EnFVAIia3Tv3mFOmJRWNBVYofThY7ecOPLQiQ
	 8p4WPeErXA5e1Rda94B+3OUiAR73hk+V84ewgoAzsGBQc27tI21bnXkILmpB1iRRgQ
	 hgTKYJWVgdC37ds0hLFhvb2ECLyQlcdg5a7+4C6y/StjElSHXvrnI2AYZCzKXrb5LM
	 u8ZGQx5qy3IPHDYllPKRtZSt9t8PFxq0a7Mc3qshJwJgy3fzdmasyLAGe4A250QrWm
	 JQ3bdPhicfIYA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/11] samples/damon/mtier: stop all contexts with
 single damon_stop() call
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-9-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:20:55 +0000
Message-Id: <20260704182056.0C3621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] AB-BA deadlock in `damon_start()` error path with `kdamond_fn` ove=
r `damon_lock`.
--

commit 65a3f2350afc5895953b74d531916747653f71ed
Author: SJ Park <sj@kernel.org>

samples/damon/mtier: stop all contexts with single damon_stop() call

damon_stop() was theoretically able to return failure while keeping the
second context for mtier running.  mtier stops its contexts one by one
with two damon_stop() call for the reason.  damon_stop() is refactored
to always successfully stop all requested DAMON contexts.  The two calls
are unnecessary.  Use only single damon_stop() call for all contexts.

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 90881e8bd441f..ac9c24b92ead8 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -200,8 +200,7 @@ static int damon_sample_mtier_start(void)
> =20
>  static void damon_sample_mtier_stop(void)
>  {
> -	damon_stop(ctxs, 1);
> -	damon_stop(&ctxs[1], 1);
> +	damon_stop(ctxs, 2);

[Severity: High]
This bug was introduced in this series by commit "mm/damon/core: stop ctxs
in damon_start() before returning an error" and remains unfixed at the end
of the series.

Does the error path in damon_start() introduce an AB-BA deadlock with
kdamond_fn() over damon_lock?

If a caller attempts to start multiple DAMON contexts and damon_start()
successfully starts at least one context but fails on a subsequent one,
it calls damon_stop() while still holding damon_lock:

mm/damon/core.c:damon_start() {
	mutex_lock(&damon_lock);
	// ...
	for (i =3D 0; i < nr_ctxs; i++) {
		err =3D __damon_start(ctxs[i]);
		if (err) {
			damon_stop(ctxs, i);
			break;
		}
		nr_running_ctxs++;
	}
}

damon_stop() synchronously waits for the kdamond thread to exit. However,
the kdamond thread blocks forever waiting to acquire damon_lock to decrement
nr_running_ctxs:

mm/damon/core.c:kdamond_fn() {
	mutex_lock(&damon_lock);
	nr_running_ctxs--;
	if (!nr_running_ctxs && running_exclusive_ctxs)
		running_exclusive_ctxs =3D false;
	mutex_unlock(&damon_lock);
}

Could this permanent deadlock hang the kdamond kernel thread and any process
attempting to use DAMON?

>  	damon_destroy_ctx(ctxs[0]);
>  	damon_destroy_ctx(ctxs[1]);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D8
