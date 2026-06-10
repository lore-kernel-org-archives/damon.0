Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88921C8604
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063543; cv=none; b=XHnzNnxnsWTEvQQwwBQ5XJcJJRTti85PPSLKyXiHOlSngQYERt6vwM0SddhaZNdYTLosFOSMyV4xbx2QDRP/k+/ciKKZTG+2Gz0TSzv99D3HDaWOULKcMCgf3ah8dO3Qu0lKdno5ayApIEkTXENImOSjq7xUneYIjvbNk1eticI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063543; c=relaxed/simple;
	bh=jnFo3iVVU+82++io8rXdhB6930OQSs7M5P6YM3bB/Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ4OkXAwVWvyDpryAX4KPx9NjLjNTnQxagTE+aYmpoML8xxCIYyyybiuoGFl08uQbvjvRnX71Mr2rL1kmdWapGfllVyGeBfSvUhMrorueu3y6EH8YkAhOyXkICVBU6oSU67YqoadAY1/PTD7yMEygPMQBm7QpQVnCWYIozVI8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsgHOjsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsgHOjsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229F31F00893;
	Wed, 10 Jun 2026 03:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781063542;
	bh=soLce5EZ1xjfw3kMKeELXOunp7CJ0xvCN6qJTfSWf5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QsgHOjsMq/PKVQD5zHcExtdK0lDPgo5nrHbzFXzVNS7kfHjEZlE80m9fNHoY0ilv0
	 rW8DtNUxiavAWOLsJuyZyQ08aa5wWa4WW7SYE16ZsTiEq0Ep7xWF4Q1MmaDF4QnumC
	 wVmM0NPRDtZb+OcT0dmNpgekIOBVfGkRjV002Y5dFmNWjfpEU5Kn7kexf/fuZv4f/z
	 esAGLPNyr42VJqt/AR+9vMqHTrJGTLp5mKVuntehU4vCtlVf0a0xqFi0+kCCzMDAT7
	 HqQFHnB3PlJ/q3sd5dsBThzty0FOZtLfeYQBfivhB1kWkvJDPbj7+MIca60OW17H7f
	 e88EaJricsLcg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 2/4] samples/damon/prcl: handle damon_start() failure
Date: Tue,  9 Jun 2026 20:52:11 -0700
Message-ID: <20260610035214.4850-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610012948.724B21F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jun 2026 01:29:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Loading the module dynamically with the `enabled=Y` parameter causes a permanent DAMON thread and context leak.
> - [Medium] The DAMON context, targets, and schemes are leaked if `damon_call()` fails in `damon_sample_prcl_start()`.
> --
> 
> commit 66049e90074b43852fd5c6e982d320d3e8718fb4
> Author: SeongJae Park <sj@kernel.org>
> 
> samples/damon/prcl: handle damon_start() failure
> 
> This commit fixes a memory leak in damon_sample_prcl_start() by destroying
> the Damon context if damon_start() fails. This addresses an issue where
> the context is leaked when the module fails to start in exclusive mode.
> 
> Link: https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org
> 
> > diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
> > index b7c50f2656ce7..0db2598946911 100644
> > --- a/samples/damon/prcl.c
> > +++ b/samples/damon/prcl.c
> > @@ -106,8 +106,10 @@ static int damon_sample_prcl_start(void)
> >  	damon_set_schemes(ctx, &scheme, 1);
> >  
> >  	err = damon_start(&ctx, 1, true);
> > -	if (err)
> > +	if (err) {
> > +		damon_destroy_ctx(ctx);
> >  		return err;
> > +	}
> >  
> >  	repeat_call_control.data = ctx;
> >  	return damon_call(ctx, &repeat_call_control);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this function also leak the Damon
> context, targets, and schemes if damon_call() fails?
> 
> If damon_start() succeeds, it spawns the kdamond thread. If the newly spawned
> thread terminates early, for example due to a memory allocation failure for
> regions_score_histogram in kdamond_fn(), it sets call_controls_obsolete.
> 
> If this happens before damon_call() acquires the call_controls_lock:
> 
> mm/damon/core.c:damon_call() {
>     ...
> 	mutex_lock(&ctx->call_controls_lock);
> 	if (ctx->call_controls_obsolete) {
> 		mutex_unlock(&ctx->call_controls_lock);
> 		return -ECANCELED;
> 	}
>     ...
> }
> 
> Because damon_sample_prcl_start() returns this error directly to the caller
> without cleanup, the caller receives the error and disables the module. This
> permanently bypasses damon_sample_prcl_stop(), meaning damon_destroy_ctx()
> is never executed.

Good catch, I will fix this with another patch.

> 
> [Severity: High]
> This is also a pre-existing issue, but does loading the module dynamically
> with the enabled=Y parameter cause a permanent Damon thread and context leak?
> 
> During module load, the kernel parses parameters and invokes the module's
> parameter callback before executing the init function. If enabled=Y is
> passed, the callback successfully calls damon_sample_prcl_start(), which
> allocates the context and starts the kdamond thread in exclusive mode.
> 
> Then, do_init_module() executes damon_sample_prcl_init():
> 
> samples/damon/prcl.c:damon_sample_prcl_init() {
>     ...
> 	if (enabled) {
> 		err = damon_sample_prcl_start();
> 		if (err)
> 			return err;
> 	}
>     ...
> }
> 
> Because the enabled flag is still true, damon_sample_prcl_init() erroneously
> calls damon_sample_prcl_start() a second time. This unconditionally allocates
> a new ctx, overwriting the global ctx pointer and losing the reference to the
> original context.
> 
> The second damon_start() call fails with -EBUSY because the first thread is
> already running in exclusive mode. The original kdamond thread is left
> running forever and its context pointer is permanently lost, locking out any
> other Damon instances on the system until reboot.

prcl cannot dynamiclly loaded, so this issue cannot happen.


Thanks,
SJ

[...]
