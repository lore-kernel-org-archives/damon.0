Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605938DD3
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434982; cv=none; b=Lo8rUwP6cCyvmt2B5x+a0tLMEnB9DH5eUrHGPrVZNtLwKp7gey8rHBShWyiB1yS2dnxPFHDdPWOyO5jGwop0CL0M9fuFjjW+LBsK6chQGoGo67xMwf7So2Zb8fVQNcXr5CngIsTaVRNK1IaCCgkzEDRbWUJXcvm49uJ3kicpi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434982; c=relaxed/simple;
	bh=1cT957zsVyEvBfOkVcAjG+rLNrpVbD1VWeB5wk1x5kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBHb8Cvr8IIvCqWX9tGKFf5o7CJjl4Xx+MISGNiID9l7/rdCdJo6ewcBF7r/ltwlyOrFYATNleXimD9irTMf1/h3z89UkJFAWU0/a6nZZMEWTbyFP5QQGeH6AEcKGUgvRl+eCd7ijmoMARTK4vSVtS0/MrPtVzD/qLfIZYbyuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvI/QAso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvI/QAso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369B41F000FF;
	Tue, 15 Sep 2026 01:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434981;
	bh=8v+XpGZKdSXBCiuRjz5x5QYLUdPSac/wAoMd6G4FU50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UvI/QAsoc+PA3J1U5VjEwLEl1dt234C4tdwzhY7ENAHzLO7++DTzi6Z19pKXzxsVR
	 wiBMyavnYVa9wkOyKIDNuPkaooFJQjI8kU2Bp0wgvpj/UTjm9MXdIH7m+YBJWafokD
	 rab0efsHXXRDlP+z2BdhT7TspLkLUCUw32iqlyg36Hdb+mMcAMXsOn7Xi9oyVkweSk
	 XKxb9cQcyV8ccvndFvclctRcqBDp/2plp7TcaVIyN4rohxWOGjEFiWcZFirMV7EJkf
	 RZ1j3UVb4GKilxyBX7qiCa2an+WEHB5MaVVDltc8XtsbgRvO4z5K7KWlI11H8SY6Ms
	 MEx9YOwvBGAng==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/9] mm/damon/core: document damon_call()/damon_start() race hang issue
Date: Mon, 14 Sep 2026 18:16:13 -0700
Message-ID: <20260915011614.102342-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912201944.AA8D91F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 20:19:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Brittle cancellation polling loop in damon_call() can cause indefinite hangs on rapid context restarts.
> - [High] Missing initialization of `walk_control_obsolete` in `damon_new_ctx()` causes unrecoverable hangs in `damos_walk()`.
> --
> 
> commit edbd3bc657324e35d324500107e2e30a1ffabc31
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: document damon_call()/damon_start() race hang issue
> 
> This commit documents a potential race condition and indefinite hang between
> damon_start() and damon_call() if they are executed in parallel for the same
> DAMON context. It adds a cautionary comment to damon_call() to warn API
> users about this behavior.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 6e4b0144c3dd1..f304813a08460 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2218,6 +2218,9 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
> >   *
> >   * When this function is failed, the @ctx is guaranteed to be stopped.
> >   *
> > + * This function should not be called in parallel to damon_start() for the
> > + * @ctx.  In the case, this function could indefinitely hang.
> > + *
> 
> [Severity: High]
> This is a pre-existing issue, but does the cancellation polling loop in
> damon_call() cause indefinite hangs on rapid context restarts?
> 
> If Thread A is blocked in damon_call(), and Thread B stops the DAMON context
> (e.g., via module parameters), the monitoring thread cancels the call and
> exits.
> 
> If Thread A is preempted before evaluating the canceled polling loop,
> and Thread C concurrently restarts the context, Thread A resumes, evaluates
> damon_is_running(ctx) to true (due to the newly spawned thread), and hangs
> forever waiting for the new thread to stop:
> 
> mm/damon/core.c:damon_call() {
>     ...
> canceled:
>         while (damon_is_running(ctx))
>                 schedule_timeout_idle(msecs_to_jiffies(100));
>         return -ECANCELED;
> }
> 
> This race can be triggered by root via concurrent sysfs or module parameter
> writes (e.g., in damon_reclaim).

DAMON_SYSFS does not reuse same damon_ctx, so there is no such issue.

DAMON_RECLAIM and DAMON_LRU_SORT reuse same damon_ctx, but their damon_call(),
damon_start() and damon_stop() calls are done only in init and param write
callback, which holds param lock.  So such a race cannot happen.

> 
> [Severity: High]
> This is a pre-existing issue, but does the missing initialization of
> walk_control_obsolete in damon_new_ctx() cause unrecoverable hangs in
> damos_walk()?
> 
> damon_new_ctx() explicitly initializes call_controls_obsolete = true to
> protect damon_call() from hanging if invoked before the context is started.
> However, it fails to initialize walk_control_obsolete:
> 
> mm/damon/core.c:damon_new_ctx() {
>     ...
>         ctx->call_controls_obsolete = true;
>         prandom_seed_state(&ctx->rnd_state, get_random_u64());
>     ...
> }
> 
> If damos_walk() is called before damon_start(), it bypasses the safety check
> and blocks forever on wait_for_completion(), because no thread exists to
> signal it:
> 
> mm/damon/core.c:damos_walk() {
>     ...
>         mutex_lock(&ctx->walk_control_lock);
>         if (ctx->walk_control_obsolete) {
>                 mutex_unlock(&ctx->walk_control_lock);
>                 return -ECANCELED;
>         }
>     ...
> }
> 
> Even though it requires erroneous API usage, the API intends to gracefully
> reject this via the obsolete flag. The missing initialization breaks this
> boundary, leading to an unkillable hang.

There is no such API usage, so such issue cannot happen.  I will consider
adding a comment or the initialization for possible future bug.  But no blocker
of this patch.

> 
> >   * Return: 0 on success, negative error code otherwise.
> >   */
> >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912200814.145612-1-sj@kernel.org?part=5


Thanks,
SJ
