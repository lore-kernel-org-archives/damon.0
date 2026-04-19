Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249940DFC2
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776563287; cv=none; b=RRXui93LhQZ1EOVwNJ4YpdGCFSqTM3sOtb8zZigc8yQ5qL9M3bl4X+tX+K1IBGD1rRYYvda2EvV/kAlaQFKVVUToHYaFTGVMhosHSFysratZ85fKUf+4vGki5QluBgVyFMACRG1oAc1Qc0AOZoYIEQAStUxqNLVHRWDwoU5LErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776563287; c=relaxed/simple;
	bh=+D7uU+mLL/mslmHayxB8uwvNA1g70usaXxCPuKU28bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1IMD+m4okWlfscgz99OjpETs+Tpt+4q66szL0SANRkichDjUHkajdxQq67WF9XlL4o0QpswPi2kGUbCn+U52BzY0Ib3aqt7cDSMjg42mX3PkSS87hHuiXEmtLcNRHcXMfz3Kv/GWX+g6By3j+cmspc2Lio15ILqoVxxjmzZOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqd37A/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqd37A/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29867C19424;
	Sun, 19 Apr 2026 01:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776563287;
	bh=+D7uU+mLL/mslmHayxB8uwvNA1g70usaXxCPuKU28bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yqd37A/MgaYA9uPf4JT8Xt6UQ/uNmjGTfl5vatxZwI0vIKM5mpFDnI23x0Zmesn4Z
	 CdEm/xlu1duk20szLfs7IHIZJCTtqH9EySS677wJMLbZR7HFFL8Tw8ksuI6ri0p536
	 uzeXNM/WG7dJ4pcFmWZAYpl7eGjgj3nY6yDEwmQg5+O8WbRLjISlkOPYb6wUBrxxDW
	 uv4M0LMXX+EPGFEXOifoijcWwcZF2BSU2OfGIfIGEGcPVrt+JJqW7BvHvwsGw5y6bq
	 WT3Dt/GQusfof86hcbetx+xVqk7YrGbFMVexMv7NoDDN4ulXMdjsUuvt47SKhG7o+W
	 YaNsbXXPtTUYw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 1/3] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Sat, 18 Apr 2026 18:47:59 -0700
Message-ID: <20260419014800.877-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418225757.95221C19424@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 22:57:57 +0000 sashiko-bot@kernel.org wrote:

TL; DR: no blocker for this patch.

> Sashiko AI review found 2 potential issue(s):
> - [High] Missing context initialization check in the sysfs store handler can
>   trigger a NULL pointer dereference if module initialization fails.

Good catch, but not the fault of this patch.  I will separately work on it.

> - [Medium] The `damon_reclaim_enabled_store` function parses user input
>   directly into the global `enabled` variable before using it for control flow
>   decisions, causing a Time-Of-Check to Time-Of-Use (TOCTOU) race condition.

Sashiko-claiming issue cannot happen.  Read below for more details.

> --
> 
> commit 9d2c63ed13e63f6709b2752f9d974f5055f9d97e
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
> 
> DAMON_RECLAIM updates the enabled and kdamond_pid parameter values dynamically
> to prevent stale values when the daemon is stopped unintentionally. This
> ensures users see the fresh running status and can restart the daemon when
> needed.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..fe7fce26cf6ce 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -332,42 +316,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> >  MODULE_PARM_DESC(addr_unit,
> >  	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
> >  
> > +static bool damon_reclaim_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> > +
> >  static int damon_reclaim_enabled_store(const char *val,
> >  		const struct kernel_param *kp)
> >  {
> > -	bool is_enabled = enabled;
> > -	bool enable;
> >  	int err;
> >  
> > -	err = kstrtobool(val, &enable);
> > +	err = kstrtobool(val, &enabled);
> 
> By parsing user input directly into the global enabled variable, does this
> introduce a race condition?
> 
> If multiple threads write to the sysfs enabled file concurrently, thread A's
> parsed input could be overwritten by thread B before thread A evaluates it
> in damon_reclaim_turn(enabled).
> 
> Could this cause thread A to execute the opposite action of what was
> requested while still returning success to the user?

Sysfs writes are protected by kernel_param_lock, so such concurrent
user inputs cannot happen.

> 
> >  	if (err)
> >  		return err;
> >  
> > -	if (is_enabled == enable)
> > +	if (damon_reclaim_enabled() == enabled)
> >  		return 0;
> >  
> >  	/* Called before init function.  The function will handle this. */
> >  	if (!damon_initialized())
> > -		goto set_param_out;
> > +		return 0;
> >  
> > -	err = damon_reclaim_turn(enable);
> > -	if (err)
> > -		return err;
> > +	return damon_reclaim_turn(enabled);
> 
> Can this trigger a null pointer dereference if the module initialization
> fails?
> 
> If damon_reclaim is built into the kernel and damon_reclaim_init() fails
> (for example, due to an allocation failure), the global ctx pointer remains
> null. Because it is a built-in module, the sysfs parameters remain exposed.
> 
> When a user writes 'Y' to the enabled file, damon_initialized() will pass
> because the core DAMON subsystem initialized successfully during boot. The
> code then calls damon_reclaim_turn(true) which passes the null ctx down to
> damon_commit_ctx(ctx, param_ctx).
> 
> Should there be an explicit if (!ctx) validation before attempting to start
> the reclaim process?

Good finding, but the bug was there even before this patch, so no blocker of
this patch.  I will separately work on the bug.


Thanks,
SJ

[...]
