Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723B175A9D
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398538; cv=none; b=UjK9dQvBlO7eefvhcozg+QWvgSgSSvJmotH6Lv0aNibH8LOact1/I1WHdoYVViVIHJBmDm8sEfxhro1C8zduRSU7hlR9NGyjndmBiqoF+VOJh2pKZtXLpeu+Z6ehq6uht2KJJhifsGS/0zYRIG3KW9zlG96Q2xHZjkHt+IAjb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398538; c=relaxed/simple;
	bh=WPKhP59dom7yN8jsvKcoS078poHk+qC82pgvc60C9Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKlOI1KIHqipSGPG+bvRUsTC5Mgmg3DIQzXihPnBc7ySdR15TW8rsdeTe+0jMHbeS3/1/SKNhtP8KOW8fGKrzqI20hLode8dcwXz/E3aY9yMbRUHzwrMBqwWUxrzqZoTgWHWD/soYNlp4KXTkcBExLc7n29OTrqYj5zmhJRPpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvMgYK4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvMgYK4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC0C1F000E9;
	Thu,  3 Sep 2026 01:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398536;
	bh=fykBVCjJgqJOPTjrcxX2e2bcon5ccS3Gb6fN0tTv4q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvMgYK4OK4WaLcC48NdVqAqtvjPfplaq8fsjKGskrdrGJU4F8CpNQtO5XU8ViI7er
	 BfEeKAN6vaCAZ8PTs87hPhoPjoowpE4m+0N+z5BAtjG68J5Dr6aPdTtwfH9vBXWPAD
	 fH6zDZYsMGggvkuUMtvRV1r347/m8/qSJuhMcyvNoDYqUElUXEKwHpeWBOBfVJFteC
	 wuzPGRcf81G9zUUkIbd0PmcRnwucCCohyiLid7K64xQjaFK/cqyqUDdVjsAaIHFLLq
	 vcuu5iV4K6dDDmi+Qxp953vNdkDno/UkN1Td2RQ3vhiPuRHrz9YHdgwEvtsylnRZVr
	 0QhlRBGbRdzrg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
Date: Wed,  2 Sep 2026 18:22:08 -0700
Message-ID: <20260903012209.94923-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903011621.29D8C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 03 Sep 2026 01:16:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch correctly fixes an indefinite wait vulnerability in damon_call() by initializing ctx->call_controls_obsolete to true, but fails to initialize the identical ctx->walk_control_obsolete flag. This leaves damos_walk() vulnerable to the exact same indefinite hang if called on an unstarted context.
> --
> 
> commit 55412502962e64df1de83b2c9805595450e93fc7
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
> 
> This patch sets ctx->call_controls_obsolete to true in damon_new_ctx() to
> prevent indefinite hangs when damon_call() is used on an unstarted context.
> 
> Link: https://lore.kernel.org/20260803134646.16640-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f1f007d8dd1d9..610556abb129e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -933,6 +933,7 @@ struct damon_ctx *damon_new_ctx(void)
> >  	INIT_LIST_HEAD(&ctx->adaptive_targets);
> >  	INIT_LIST_HEAD(&ctx->schemes);
> >  
> > +	ctx->call_controls_obsolete = true;
> 
> [Severity: High]
> This is a pre-existing issue, but does the same fix need to be applied to
> ctx->walk_control_obsolete?
> 
> Because walk_control_obsolete is zero-initialized (false) by kzalloc_obj(),
> calling damos_walk() on an unstarted context will bypass the obsolete check:
> 
> mm/damon/core.c:damos_walk() {
> 	if (ctx->walk_control_obsolete) {
> 		mutex_unlock(&ctx->walk_control_lock);
> 		return -ECANCELED;
> 	}
> 	...
> 	wait_for_completion(&control->completion);
> }
> 
> This could lead to an indefinite hang in wait_for_completion(), since the
> DAMON worker thread is not running to signal the completion. Should
> ctx->walk_control_obsolete also be initialized to true here?

The issue in damon_call() could happen because it has repeat mode.
damos_walk() doesn't have the repeat mode, so I don't think same issue exists
here.  I will consider doing so in future, for consistency.  But not something
need to be done now.

> 
> >  	prandom_seed_state(&ctx->rnd_state, get_random_u64());
> >  
> >  	return ctx;
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260903010334.93622-1-sj@kernel.org?part=2


Thanks,
SJ
