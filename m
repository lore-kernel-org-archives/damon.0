Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6927A47F
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189447; cv=none; b=vFkptQNJd9zhO7zA2eOQ4thQsbNdjEJ0JVX11MuPpuBDHiCEZywHHt/ckN4SMIpE0G5bOWlQjENTGfsShRiWIpXKBo3D62AZrpeQTt/E3+G/uh5VZ6SxJ7OscjrCPiQkwfA24smjNxGK8+YOZ/cpkVj3nCwv+kt0SYm4IetI/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189447; c=relaxed/simple;
	bh=EztQvpJrRJINMK+pZFoSpaRmN1sKAMFwyHAG3a2Nv0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5kAlkAqsrCMU4MWLr1ttE+dHuMt7Oarda6CEKRW90yNO363bQWDDu5ynnUi3vs2w3pqsA166WfLt6UAu1M8WeJm0eTC2aCu0q/7mmxEqMZBd+MUwVEnalabRJIQlMPCFFs5MDF0/eYQ6OjD4CtnfJ5x5qHLr05ekTv4SiR+SWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgJoQs53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgJoQs53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6AE1F000E9;
	Sat,  4 Jul 2026 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189446;
	bh=2U4yYUccdka+qIBm4NWplP5E3IMnVKoord/V7g9u9ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LgJoQs53ZeabAzbNrnjyUwtJ10MHFgXKUHQEUTftWPOWmx733TU2kLNlQnn4CKZ0p
	 biyU1P9yUvTtcqUfjEANxK89qb4IN3jtASKBrxquB7QaOJ9E1wxum1ufgwym0B62PS
	 gB8ecedJDwioqARdiKJ5v++HipgbEST//uEKK0GLQMwEwRFAAGqf/01bLiXpNW8jgx
	 h2uQfb53ssb7Ckyq+5hEzcT34ioWgoXqg6+GOf0jn7zQCI3EkeJYwA24Y9enrSc37N
	 e6Kk5YWsGEw/AvoklfJPoAgWkAHqGFTWDYqvhl+dKdIZsD0nyxHbOC6ozFSxh/fN1g
	 G+NZlcJOxu+Cw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/11] samples/damon/mtier: do not stop first
 context for damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-3-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:24:05 +0000
Message-Id: <20260704182406.0C6AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ABBA deadlock in damon_start() during error recovery when rolling =
back successfully started contexts.
--

commit c411cd45182c74c483bd6bd5d58aea28123f720d
Author: SJ Park <sj@kernel.org>

samples/damon/mtier: do not stop first context for damon_start() failure

damon_start() was able to fail while keeping the first context running.
mtier hence stops the first context in the case. damon_start() is
refactored to avoid that. The error handling is no longer necessary.
Remove it.

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index e567f4edd80ea..90881e8bd441f 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -193,8 +193,6 @@ static int damon_sample_mtier_start(void)
>  	if (!err)
>  		return 0;
> =20
> -	if (damon_is_running(ctxs[0]))
> -		damon_stop(ctxs, 1);

[Severity: High]
Does the refactored error handling in damon_start() introduce a deadlock?

Since damon_start() is called with nr_ctxs =3D 2 here, if the first context
starts successfully but the second one fails, the error recovery path in
damon_start() could trigger an ABBA deadlock.

If damon_start() calls damon_stop() on the error path while holding
damon_lock:

mm/damon/core.c:damon_start() {
    ...
		err =3D __damon_start(ctxs[i]);
		if (err) {
			damon_stop(ctxs, i);
			break;
		}
    ...
}

damon_stop() blocks until the kdamond_fn() thread exits. However, kdamond_f=
n()
attempts to acquire damon_lock at its exit path:

mm/damon/core.c:kdamond_fn() {
    ...
	mutex_lock(&damon_lock);
	nr_running_ctxs--;
	if (!nr_running_ctxs && running_exclusive_ctxs)
		running_exclusive_ctxs =3D false;
	mutex_unlock(&damon_lock);
    ...
}

Could this cause kdamond_fn() to hang waiting for damon_lock, which is still
held by damon_start(), resulting in a deadlock?

>  	damon_destroy_ctx(ctxs[0]);
>  	damon_destroy_ctx(ctxs[1]);
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D2
