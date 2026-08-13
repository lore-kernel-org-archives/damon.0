Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58A2F5A0E
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594388; cv=none; b=fwTl1UfhSHCmQ4/Kc81f5Ht73wMQ3d0ilUWOax0/VrMCqz6JLg52Ex1jK4TnuSrEkyGe9RGGpmNf7JmvhaW7iQ8fIXhLpUjg7fenKOGnachUSYDkyUkjpLH1/xg7Y8xjedPmpde1QhrO+VzGTVGSuZ5CuqAZf6LXkxfJsxFBc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594388; c=relaxed/simple;
	bh=Nq50VcK0ICQvmLH+kgnLyRb9EYuex7uayq8GeA+lMqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAk3CO7RF7wT+eo0KPJ523oKx43IBIHOr6T+Pex0vAlqaIJpA0NIOoMl8hABVYoyoVxAZf7J0A2LCELJysH0GLIhxh2zHmzhPXkrRuaty9nUvZvSikpBoCMLJwVceQdDpC2Zq+lz59HZDbkkpBMqHTg8ijKs4+bQtWe76xG0eyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcYVYdVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcYVYdVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99D51F000E9;
	Thu, 13 Aug 2026 04:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786594387;
	bh=3HQ79zatgVpys3Wq9YN1wVTO6GWHF6oOcKoPx0jZ9B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IcYVYdVePUvwUiX9pW4mHvXrPOdyuPVrQpUUYHlsE4xwD/KnKzMmmrL6NDS6w3MEf
	 eJghNHO6+ZjKteEw7MJGYI06uDrjCoKblSzlOrxnskxjPm40z+rtu+qGFS6jmg6d/O
	 djkOQv8XhRJPW3tCASHhi5I1pYnziair4AHlw9Z7n+XcwfL00CVw3P0aM1yhNEFJda
	 IV7cWhM2nFCjU8BbEVWgo9iKK5gFHcYrzaWRclhgNGw1Fla6OKxmWBdhtocostcam4
	 kugiXeKOCL6f9Hcl84intkxFvb4B6334w1qyiKAxUwjw6YuJoqYqLryxUNpWIOvoH3
	 Sm+8LzjdqHspQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/4] mm/damon/lru_sort: remove unnecessary damon_call() param validation
Date: Wed, 12 Aug 2026 21:12:57 -0700
Message-ID: <20260813041258.98406-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813040435.C13F21F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 04:04:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `damon_lru_sort_damon_has_started` check exposes a race condition causing an infinite loop in `damon_call()` when invoked concurrently during kdamond startup.
> --
> 
> --- Patch [4]: [RFC PATCH 4/4] mm/damon/lru_sort: remove unnecessary damon_call() param validation ---
> commit 288d310b5c3c2bd758d5db8eef7c717db03cbd01
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/lru_sort: remove unnecessary damon_call() param validation
> 
> This commit removes custom validation in damon_lru_sort_commit_inputs_store
> that checked if the damon context had successfully started before calling
> damon_call. The commit message states this is safe because the damon core
> layer now handles these corner cases.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index bd847829a9907..f25ee7326e87c 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> [ ... ]
> > @@ -368,10 +366,6 @@ static int damon_lru_sort_commit_inputs_store(const char *val,
> >  	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	/* Skip damon_call() if ctx has not successfully started. */
> > -	if (!damon_lru_sort_damon_has_started)
> > -		return -EINVAL;
> > -
> >  	err = damon_call(ctx, &control);
> 
> [Severity: High]
> Does removing this safeguard expose a race condition causing an infinite
> loop in damon_call when invoked concurrently during kdamond startup?
> 
> If a user writes to the enabled sysfs file to start the daemon, and
> concurrently writes to commit_inputs, damon_call can execute while
> damon_start is waiting for kdamond to fully initialize.
> 
> In this scenario, damon_call could read ctx->call_controls_obsolete == true
> (since the kdamond thread hasn't cleared it yet) and jump to the canceled
> path:
> 
> mm/damon/core.c:damon_call() {
>     ...
> canceled:
> 	while (damon_is_running(ctx))
> 		schedule_timeout_idle(msecs_to_jiffies(100));
> 	return -ECANCELED;
> }
> 
> Because the daemon thread has already been spawned and assigned, making
> damon_is_running persistently true, won't this loop indefinitely, hanging
> the sysfs writer process?

No.  The race doesn't happen due to params_lock.

> 
> >  
> >  	return err ? err : control.return_code;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813035001.97364-1-sj@kernel.org?part=4


Thanks,
SJ
