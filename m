Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448A27A47F
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189405; cv=none; b=KFIN+xu8GPnkHs+s0cgi8iBFhR5e7m2DIeQNjRhpx1GqVMG7s4mp2rf3DIBu10PPvYooi/FGrndBmat0gsIBlHLva03Sx/vYNYxiG7aW6W5CZ1cIYqqu6lDsvr4Co9ypV9rCOozrdAv+7/8Qb6nLL+u1RI+CW6emBH/9qItJhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189405; c=relaxed/simple;
	bh=sdkQkpUaQslzK/TGFYGnVzjRKd0YFXW4cwHtJ1dNlBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UzoQZs/6SxDeFfOXDaEq5lbVPYHlCOgeM80gpB9N6azpUwe/VfQk6aVehlPr0lervPmzJYi43rJSyuz3lxFouusesBS+uNBqsmEFdNCcoTs6SJSJTwsXE32x56An4LHOANZ0TWtNQTKDvNIb+FXX4sYXDHebusq2sSmO+xEhSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYhTxG97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYhTxG97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FE81F000E9;
	Sat,  4 Jul 2026 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189404;
	bh=NGULI30g4riP/LtjfQgjRoapKVXNPm3uzd4DY7DbJi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYhTxG97KpeJf9jywzcqseCutv9GhXw6ttQFvDmBHQXSH7350FyLB5frjC5RvtRxw
	 yY6mxuUR8EIlx+ElUbYInQWtYjWSnx5Ref0KK/ojP592AUm38RBwXIbaFIHaA7s6Hc
	 Y5YPrv03uc/Wa6g9tM+VO6PdtZRrf9muz32pcHtPd3Nyf0vqabkq4f/ZQwpIAiwjKC
	 MmWp7mGb2fNa309CwpM41qqCf24olrnsb990jER4TF1Mh/ZYMqEeFye5/SEGgYz+IX
	 sF3CtbwslnUkjdWOhCfQZO7ctwh1LkQE/HvNL0ITJuiSuTnqXBNU/RktRqIvu8kzcf
	 2tnWYpHLsH/ig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/11] mm/damon/core: change damon_stop() return
 type to void
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-8-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:23:23 +0000
Message-Id: <20260704182324.47FE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ABBA deadlock in the error handling path of `damon_start()` when a=
 context fails to start.
--

commit 48348b0ead7556cdf0c68b6bf17ef7a1991b89c8
Author: SJ Park <sj@kernel.org>

mm/damon/core: change damon_stop() return type to void

This commit changes the return type of damon_stop() from int to void,
as it always returned 0 and callers did not check the value.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0845d6b151f81..aa48bf44c2a0b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1873,14 +1873,13 @@ static void __damon_stop(struct damon_ctx *ctx)
>   * @ctxs:	an array of the pointers for contexts to stop monitoring
>   * @nr_ctxs:	size of @ctxs
>   */
> -int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
> +void damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
>  {

[Severity: High]
Can this cause an ABBA deadlock in the error handling path of damon_start()
when a context fails to start?

When damon_start() is called with multiple contexts, it acquires damon_lock.
If the first context starts successfully, it spawns a kdamond thread which
begins execution in kdamond_fn().

If the second context fails to start, the error path calls damon_stop() whi=
le
still holding damon_lock:

mm/damon/core.c:damon_start() {
    ...
		err =3D __damon_start(ctxs[i]);
		if (err) {
			damon_stop(ctxs, i);
			break;
		}
    ...
}

damon_stop() eventually calls kthread_stop_put() on the thread for the
first context, which blocks waiting for the thread to exit.

However, the first context's thread attempts to acquire damon_lock in
kdamond_fn() to decrement nr_running_ctxs:

mm/damon/core.c:kdamond_fn() {
    ...
	mutex_lock(&damon_lock);
	nr_running_ctxs--;
    ...
}

Since damon_start() holds damon_lock while waiting for the thread to exit,
and the thread waits for damon_lock to exit, won't this result in a permane=
nt
deadlock?

>  	int i;
> =20
>  	for (i =3D 0; i < nr_ctxs; i++)
>  		/* nr_running_ctxs is decremented in kdamond_fn */
>  		__damon_stop(ctxs[i]);
> -	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D7
