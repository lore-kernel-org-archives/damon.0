Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F833299A87
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300259; cv=none; b=LRHtVdSTdqLZJC3NnNyX4Jgz1wie9ruTqV/S8Nc0aFRyGXKaIUfHxhhviirsCXf+fp8clVNfjTKNTLgfdlGfY5FTOhPC1Vo6c2CIqiMKd1a+VP894+kJwf5dcSU+6Qs/sR0BeXV+AEhadUZO3KTlEq2ml2UY9uTEJTDWBe+W7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300259; c=relaxed/simple;
	bh=8iB33DOJ6ZAUrX7ZB0jXOvBhu22ArFtsuUC5dd5xzH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZIS3v1KTpdOEwCBNwdvN6ZyTKhY4XCliSF2SDDD0V9q9Zwv0d6ae86m+buIP6sqNRmYzdXlK65y8tNYopGLG7wn4Ts9j/dpYqHg/jzPwEoShVER/3roV8uDyQf+MnBPZ9RMlancx74Wo9RKaC7hQxzEiY0bd+qngifU41qjtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz0lyHQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz0lyHQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20093C2BCB4;
	Mon, 27 Apr 2026 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777300259;
	bh=8iB33DOJ6ZAUrX7ZB0jXOvBhu22ArFtsuUC5dd5xzH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mz0lyHQgpN9X/eW+YHjS7Q+Yfx5l0MYh7zYnPr5eh4z5no1QSkDtptQJb1m4omzwL
	 ENdDrVmmqQxfWamFt5mzhMweI5kx0JhzBU31pU2yabAbxLj0xjwGeexZ1CPB1l4cR9
	 XdE1FESrL8KL1K+UNx5JJ1RoZJBd6HKLUurZSRQrs/VvaIGl+wJJWzIkJQ2kUCkfh3
	 VvNzMdhkAAMinZzudYtP4HWW925SX3+KKcOWzZuoqEnoB69GPJyF5W6KBGyuvIXuym
	 gdS/Xfly3AF8Ox6Zcw2szgDSKhrEqxdYcRApp7Eemi0dqOivXkkgJApueICKkK/7T8
	 L8l1efWLh7aUQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 3/4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 27 Apr 2026 07:30:50 -0700
Message-ID: <20260427143052.111666-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427000012.7E772C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 00:00:11 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Writing to the `commit_inputs` sysfs parameter before the DAMON worker thread (`kdamond`) is started causes the writing task to hang indefinitely in an unkillable D-state.

I think this is wrong.

> --
> 
> commit 43a70e5ab295c21c0b94eddd32d886c9d0eba3fa
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon: add synchronous commit for commit_inputs
> 
> This commit changes the commit_inputs_store() callback to use damon_call()
> to synchronously commit parameters in the kdamond thread's safe context.
> This ensures validation errors are returned immediately to userspace.
> 
> Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..641af42cc2d1 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> > @@ -349,18 +348,51 @@ static int damon_lru_sort_apply_parameters(void)
> >  	return err;
> >  }
> >  
> > -static int damon_lru_sort_handle_commit_inputs(void)
> > +static int damon_lru_sort_commit_inputs_fn(void *arg)
> >  {
> > +	return damon_lru_sort_apply_parameters();
> > +}
> > +
> > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > +					      const struct kernel_param *kp)
> > +{
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_lru_sort_commit_inputs_fn,
> > +	};
> >  
> > -	if (!commit_inputs)
> > +	if (!val) {
> > +		commit_inputs_request = true;
> > +	} else {
> > +		err = kstrtobool(val, &commit_inputs_request);
> > +		if (err)
> > +			return err;
> > +	}
> >  
> > +	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	err = damon_lru_sort_apply_parameters();
> > -	commit_inputs = false;
> > -	return err;
> > +	/*
> > +	 * Skip damon_call() if ctx is not initialized to avoid
> > +	 * NULL pointer dereference.
> > +	 */
> > +	if (!ctx)
> > +		return -EINVAL;
> > +
> > +	err = damon_call(ctx, &control);
> 
> If the module has not yet been enabled (e.g., enabled=N) and the kdamond
> thread is not running, does this call to damon_call() block indefinitely?
> 
> Since ctx is allocated during initialization, the ctx pointer is not NULL.
> damon_call() then queues the control request and calls wait_for_completion().
> 
> Without the background thread running to process the queue and signal
> completion, it seems the sysfs writer task is placed into an unkillable
> D-state forever.

No.  ctx is initialized to NULL because it is static.  Once it is set,
kdamond_fn() is started.  If user stops kdamond by writing N to enabled,
ctx->call_controls_obsolete is set.  If user further writes Y to commit_inputs
for invoking damon_call(), it will return -ECANCELED due to
ctx->call_controls_obsolete.

> 
> The damon_call() documentation indicates it should only be called after
> damon_start() has succeeded, otherwise it could fall into an indefinite wait.

Yes, and that's excluded here since the module is not calling damon_call() for
NULL ctx.

> 
> > +
> > +	return err ? err : control.return_code;
> >  }
> 
> [ ... ]
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da14778658..4fc4a54b5e54 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -255,18 +254,51 @@ static int damon_reclaim_apply_parameters(void)
> >  	return err;
> >  }
> >  
> > -static int damon_reclaim_handle_commit_inputs(void)
> > +static int damon_reclaim_commit_inputs_fn(void *arg)
> >  {
> > +	return damon_reclaim_apply_parameters();
> > +}
> > +
> > +static int damon_reclaim_commit_inputs_store(const char *val,
> > +					     const struct kernel_param *kp)
> > +{
> > +	bool commit_inputs_request;
> >  	int err;
> > +	struct damon_call_control control = {
> > +		.fn = damon_reclaim_commit_inputs_fn,
> > +	};
> >  
> > -	if (!commit_inputs)
> > +	if (!val) {
> > +		commit_inputs_request = true;
> > +	} else {
> > +		err = kstrtobool(val, &commit_inputs_request);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	err = damon_reclaim_apply_parameters();
> > -	commit_inputs = false;
> > -	return err;
> > +	/*
> > +	 * Skip damon_call() if ctx is not initialized to avoid
> > +	 * NULL pointer dereference.
> > +	 */
> > +	if (!ctx)
> > +		return -EINVAL;
> > +
> > +	err = damon_call(ctx, &control);
> 
> Could this exhibit the same hang as in damon_lru_sort.c? If the worker
> thread has not been started, does writing to commit_inputs block forever?

Same to the above reply, no.

> 
> > +
> > +	return err ? err : control.return_code;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260426231619.107231-1-sj@kernel.org?part=3

Sent using hkml (https://github.com/sjp38/hackermail)
