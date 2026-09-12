Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8E13D53C
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244386; cv=none; b=f0fwuDFynnpAemFrV2QhjA8M/FGnWKV8cjgfc/iutsIwQjgUcC5nuHZGbAKvS0TGIQSNzuSXGigv3ACqDG1NZsSdAwP9tRcYVy6R0RtUjHLDZ0cVnFvOGDQN29eXTaIVlVa35/h9JKN4Y1AbV3zvf7kTY7AfWdGqR8h9VlhAEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244386; c=relaxed/simple;
	bh=1m8mzpgi9suCJXdZJp8m9ttVoNde0dyh17JRJqVU5bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgIoTaqr52/GmUcLw5t6AY6O+6A0P2f+ULTbAbwHvOlUBxy/3KnYXDbh/Ue/PGVmDuRpnREeDtgwtrVaSvHpo9XsY1CHg36yxZfQUHg/18ZW/7KhU9WykZKi+A86d+nCCILDhEWir3gCoiA+kVqkq+uF5gCKLgU50ksVjGNyxvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOQFRRSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOQFRRSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8D91F000FF;
	Sat, 12 Sep 2026 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244384;
	bh=TMQyh0fdV4geO/Kyuo+pvob2ziWEMdoUuXaMxAJGh8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOQFRRSnjI1NlIU1Fg6l5Cry78pLtRCXwPO/u+lGW85RejF2WEE3q2FGpkDf9Qa6D
	 Tp8sRPMg52TdaFPI07e4chebJaQAo5DC94uvqPw6xepi4T7lD++V+53A31LGO/s8yG
	 nECzOk5s2ewdk4ykscjH3y14iMYu9Gg84jEsVJHUa5EWiYgORZIkEWpYmrYxERvPgX
	 0CSMNImxj4qLNhB/vjVFXXocTFpBIjcYSuQIe9G0lIevNtZ5YDfGVMJ3Nq3g8QtPG9
	 TogDoqY4vU39rm9bWmS6tRZNt/NvspQwWPl1WuB7/+rXv+Fc+ebD27HdGC1/H8P0+A
	 ONpYBtAWtKusA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/9] mm/damon/core: document
 damon_call()/damon_start() race hang issue
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-6-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:19:44 +0000
Message-Id: <20260912201944.AA8D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Brittle cancellation polling loop in damon_call() can cause indefi=
nite hangs on rapid context restarts.
- [High] Missing initialization of `walk_control_obsolete` in `damon_new_ct=
x()` causes unrecoverable hangs in `damos_walk()`.
--

commit edbd3bc657324e35d324500107e2e30a1ffabc31
Author: SJ Park <sj@kernel.org>

mm/damon/core: document damon_call()/damon_start() race hang issue

This commit documents a potential race condition and indefinite hang between
damon_start() and damon_call() if they are executed in parallel for the same
DAMON context. It adds a cautionary comment to damon_call() to warn API
users about this behavior.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6e4b0144c3dd1..f304813a08460 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2218,6 +2218,9 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
>   *
>   * When this function is failed, the @ctx is guaranteed to be stopped.
>   *
> + * This function should not be called in parallel to damon_start() for t=
he
> + * @ctx.  In the case, this function could indefinitely hang.
> + *

[Severity: High]
This is a pre-existing issue, but does the cancellation polling loop in
damon_call() cause indefinite hangs on rapid context restarts?

If Thread A is blocked in damon_call(), and Thread B stops the DAMON context
(e.g., via module parameters), the monitoring thread cancels the call and
exits.

If Thread A is preempted before evaluating the canceled polling loop,
and Thread C concurrently restarts the context, Thread A resumes, evaluates
damon_is_running(ctx) to true (due to the newly spawned thread), and hangs
forever waiting for the new thread to stop:

mm/damon/core.c:damon_call() {
    ...
canceled:
        while (damon_is_running(ctx))
                schedule_timeout_idle(msecs_to_jiffies(100));
        return -ECANCELED;
}

This race can be triggered by root via concurrent sysfs or module parameter
writes (e.g., in damon_reclaim).

[Severity: High]
This is a pre-existing issue, but does the missing initialization of
walk_control_obsolete in damon_new_ctx() cause unrecoverable hangs in
damos_walk()?

damon_new_ctx() explicitly initializes call_controls_obsolete =3D true to
protect damon_call() from hanging if invoked before the context is started.
However, it fails to initialize walk_control_obsolete:

mm/damon/core.c:damon_new_ctx() {
    ...
        ctx->call_controls_obsolete =3D true;
        prandom_seed_state(&ctx->rnd_state, get_random_u64());
    ...
}

If damos_walk() is called before damon_start(), it bypasses the safety check
and blocks forever on wait_for_completion(), because no thread exists to
signal it:

mm/damon/core.c:damos_walk() {
    ...
        mutex_lock(&ctx->walk_control_lock);
        if (ctx->walk_control_obsolete) {
                mutex_unlock(&ctx->walk_control_lock);
                return -ECANCELED;
        }
    ...
}

Even though it requires erroneous API usage, the API intends to gracefully
reject this via the obsolete flag. The missing initialization breaks this
boundary, leading to an unkillable hang.

>   * Return: 0 on success, negative error code otherwise.
>   */
>  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D5
