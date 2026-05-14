Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F439381C4
	for <damon@lists.linux.dev>; Thu, 14 May 2026 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736395; cv=none; b=gbCPnTBcptDt3+rH5LtU3B6zKfzYMdLg5D0/8unCn6/DqmynZS4KHvUzJy8haGFW5+0GMPQdJoOmDgtjyxNR8kYB2BPovqRJoatvPMijQk52s4zPB8WjQJTOe7Aa0cHSn8qlENLipd30EDaia5xJ5iebBAVyZ42AXjd19unkw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736395; c=relaxed/simple;
	bh=R5NmOi9TLRtfamrvKx/d2eFNOes1PWGq0/EkFwzqkXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvVG9SWjB5R+qi76NBWUzWI6eKDdL1vWeKNMMTxGRwxVEFIGnke1j8SU6BwXxFbIca043cbinNrGiKuWCocHEFI/ghrq/Tm+YiE7k8DDS6TLQ+XEiLenMZjIz2TWvHbStP+DoeBSbd++rAr9dnohZySyz2k6DM+6caeMC1uZ8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdAkn8tC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdAkn8tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15BCC2BCB7;
	Thu, 14 May 2026 05:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736395;
	bh=R5NmOi9TLRtfamrvKx/d2eFNOes1PWGq0/EkFwzqkXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdAkn8tCrP6Ornj900m6bycHm4pmn+8yqDzzp0QrzS8yI0v0wALBmG2bOxRQPe0cA
	 78w1jNlS8ZNvpQqutq8F70skAbFmXVQHqBMbOlFHw8P/ae2dCQV+sXboStZzlH51KF
	 QzHWEYs0pWcZRqU0vrAST/q5dRoasJojV4mDskvXs4UquEm7Ur/OoB80AW7Efp5vab
	 jNMURqRfdFqyqHBkDPkr87InEmcDAjj9I1MJxrxGG2LHfMYK5E3Tn6ova6qGDOzKwZ
	 bFQ4xqjjkazAEt2U+XmdPuwFGf4YuzAmz3/Io5g+pvxcAcXGU1SRSzxaVDtc8rjnmL
	 Tm/RirmCrVpdg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y 2/2] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:26:23 -0700
Message-ID: <20260514052626.111769-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514020146.4FA32C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 02:01:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The patch completely fails to fix the restart issue, leaving the state machine deadlocked.
> - [High] Use-After-Free when reading sysfs parameters if module initialization fails.
> --
> 
> commit 975a161fef47e6bccc8ce6810404c2d8be4ff338
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
> 
> This commit updates the DAMON_LRU_SORT module to dynamically detect and report
> the fresh status of enabled and kdamond_pid parameters. It attempts to address
> an issue where unintentional kdamond stoppages leave the system in a stale
> state, preventing users from restarting the daemon. By directly calling
> damon_is_running() and damon_kdamond_pid(), the system aims to provide
> accurate runtime information to sysfs readers.
> 
> Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 61311800abc98..70cdc7425cdd3 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> > @@ -285,6 +268,13 @@ static DECLARE_DELAYED_WORK(damon_lru_sort_timer, damon_lru_sort_timer_fn);
> >  
> >  static bool damon_lru_sort_initialized;
> >  
> > +static bool damon_lru_sort_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> 
> Is it possible for this to cause a use-after-free if module initialization
> fails?
> 
> If damon_lru_sort_init() encounters an error (for example, damon_select_ops()
> fails),

So, damon_lru_sort_init() callse damon_modules_new_paddr_ctx_target(), which
calls damon_select_ops().  The damon_select_ops() cannot fail because
DAMON_LRU_SORT depends on DAMON_PADDR, and the damon_select_ops() is for paddr
ops setup.

But, damon_modules_new_paddr_ctx_target() calls damon_new_target() after that.
It could theoretically fail due to an allocation failure.

> it calls damon_destroy_ctx(ctx) to free the context. However, the
> global static ctx pointer is not set to NULL.
> 
> Since DAMON_LRU_SORT is a built-in module, its module parameters are exposed
> in sysfs early during boot. If a user reads the sysfs parameters after an init
> failure, the dangling ctx pointer would pass the check here, leading to
> damon_is_running() dereferencing it:
> 
> mm/damon/core.c:damon_is_running()
>     mutex_lock(&ctx->kdamond_lock);

Makes sense.  I will work on this.  Not a blocker of this patch though.

> 
> [ ... ]
> 
> > @@ -301,15 +291,57 @@ static int damon_lru_sort_enabled_store(const char *val,
> >  	return 0;
> >  }
> >  
> > +static int damon_lru_sort_enabled_load(char *buffer,
> > +		const struct kernel_param *kp)
> > +{
> > +	return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : 'N');
> > +}
> > +
> >  static const struct kernel_param_ops enabled_param_ops = {
> >  	.set = damon_lru_sort_enabled_store,
> > -	.get = param_get_bool,
> > +	.get = damon_lru_sort_enabled_load,
> >  };
> 
> Does this change actually fix the restart issue, or does it leave the state
> machine deadlocked?
> 
> If kdamond stops unintentionally, the internal enabled and last_enabled
> variables remain true. When the user tries to restart it by writing 'Y' to the
> sysfs enabled parameter, the underlying boolean value remains true. The worker
> skips the restart because last_enabled == now_enabled.
> 
> If the user tries to reset the state by writing 'N',
> damon_lru_sort_turn(false) calls damon_stop() which returns an error because
> the daemon is already stopped. Because of this error, the worker executes
> enabled = last_enabled, reverting enabled back to true:
> 
> mm/damon/lru_sort.c:damon_lru_sort_timer_fn()
>     if (!damon_lru_sort_turn(now_enabled))
>         last_enabled = now_enabled;
>     else
>         enabled = last_enabled;
> 
> It seems the subsystem still cannot be restarted without a reboot.

Correct, damon_lru_sort_enabled_store() part upstream change is not properly
ported.  I will post a new version.


Thanks,
SJ

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/2026051243-crevice-spool-75d8@gregkh?part=2
