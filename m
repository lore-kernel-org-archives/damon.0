Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813893093D3
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697719; cv=none; b=i2Anz+7F2Xe6j4ilp11ETpZedru/L56d/tGohcmt7eHa6L05sV7d7aPO8+wn4toKRfEny9k1L1VN4ElAFontuYxUlneHXOrRiL/Dgen4lDeXZTLltsZ3asee7hNTs/dQZJE7U0WTcAeweircnm7mGvwgObMdGxYjJ9ercMvWnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697719; c=relaxed/simple;
	bh=ceVNQVGxxhw69JOmks/WDvloGMAeA51LVsakz+Dwl4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dDu7tQYOaunUCVatleafhyiZ0sRf8qkZALuwZ6Fy7IMIsnD3yATKBp5+DyLQ29SimkL1V+KcLLx3FNTbCc8i1KfYRcAPceJ2wf11/tY7z90T4FP3nik3CmBWc8bCrbRk+TVSycJZTQ5WvYVlwP8Q6UwJ5h2Kk06fB3JSCvG4Uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUMX4oIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUMX4oIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015EB1F00A3A;
	Sun,  2 Aug 2026 19:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785697718;
	bh=pXVfXezW4XqaQuVIOYLXoomgrtsY8pjVcgfOIekqML0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUMX4oIJqgLaC0DC6LMOYmRAQOO0eFQV/Xg9SDoIDsTOYFTTPqbC0DpJRY6EsR2iJ
	 j7UyHk99THdj2Fgj22S8ogSI6j3L4Y6h0/nKPR2GaSWWyp3dicBVLUPSG4JzUcjEPA
	 SZFAu1TYMJWEHT9kcBcmmlQCWV1BoPuCjNbtjZMuPhuc6ygVw9MBYudP1wDJB4iKsv
	 j76Wo6S1WQs7fYVarzcPAkmSZN7Vk1xqHSKnHio8m5i0PAXjsSYHGHu9AS34qQ+SUB
	 cYMbxZ7H01rEzrk0Oh9Y5jb6CDiJ7YlKZMa+nPfXuWtLYijqinswLGhdYFDtvOZIns
	 NEiZsu9qyOp2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] mm/damon/lru_sort: skip damon_call() if ctx has
 not started
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802185430.9940-3-sj@kernel.org>
References: <20260802185430.9940-1-sj@kernel.org>
 <20260802185430.9940-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 19:08:37 +0000
Message-Id: <20260802190838.015EB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A TOCTOU race between `damon_start()` and `damon_call()` can cause=
 `damon_call()` to loop indefinitely.
--

--- Patch [2]: [RFC PATCH 2/2] mm/damon/lru_sort: skip damon_call() if ctx =
has not started ---
commit 9a410362ed5a4418640b6bf73c4ee49300c9dc16
Author: SJ Park <sj@kernel.org>

mm/damon/lru_sort: skip damon_call() if ctx has not started

This commit prevents damon_call() from hanging when the DAMON context is
initialized but not yet started. It introduces a boolean flag to track whet=
her
the context has ever successfully started, and skips the call if it has not.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 7e077084cb03a..7df45f9a0b3ae 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
[ ... ]
> @@ -364,11 +366,8 @@ static int damon_lru_sort_commit_inputs_store(const =
char *val,
>  	if (!commit_inputs_request)
>  		return 0;
> =20
> -	/*
> -	 * Skip damon_call() if ctx is not initialized to avoid
> -	 * NULL pointer dereference.
> -	 */
> -	if (!ctx)
> +	/* Skip damon_call() if ctx has not successfully started. */
> +	if (!damon_lru_sort_damon_has_started)
>  		return -EINVAL;
> =20
>  	err =3D damon_call(ctx, &control);

[Severity: High]
This is a pre-existing issue, but could there be a TOCTOU race here between
damon_start() and damon_call() that causes damon_call() to loop indefinitel=
y?

If a user starts DAMON (setting damon_lru_sort_damon_has_started =3D true),
stops it (leaving call_controls_obsolete =3D true), and then concurrently
starts DAMON again while calling damon_call() via commit_inputs, can
damon_call() get stuck?

Looking at mm/damon/core.c, __damon_start() sets ctx->kdamond before the new
thread clears ctx->call_controls_obsolete:

mm/damon/core.c:__damon_start() {
    ...
    ctx->kdamond =3D kthread_run(kdamond_fn, ctx, "kdamond.%d", nr_running_=
ctxs);
    ...
}

If damon_call() runs concurrently, it checks call_controls_obsolete without
holding kdamond_lock, sees the stale true value, and jumps to the canceled
label:

mm/damon/core.c:damon_call() {
    ...
    if (ctx->call_controls_obsolete) {
        ...
        goto canceled;
    }
    ...
canceled:
    while (damon_is_running(ctx))
        schedule_timeout_idle(msecs_to_jiffies(100));
    return -ECANCELED;
}

Since damon_is_running() returns true (because ctx->kdamond is set), and the
new healthy thread will run indefinitely, will this task loop forever in
TASK_IDLE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802185430.9940=
-1-sj@kernel.org?part=3D2
