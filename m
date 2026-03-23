Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82527E05E
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278760; cv=none; b=Jy0av6yT7GyGH0vTfR+k4ei9GFtsvpageKdOzmKbe3yQ5Mu2tst2PRsoawUSyCgGnuOARr++RCMQwVd9wqdUDRKX4ogjkHcjCqU6hPRzsvMgyMqlubAZUjdi9potrGbuniWvHfll7Gyj4IEtVXJKNu0kATMELU16SaC3kRUxT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278760; c=relaxed/simple;
	bh=tTzRD/5QdlyRLK1EtxLTVvBj/l5amHALku8Zl9jmQbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ksy8ud5kKibIAjyNp5Xuuz6MPoCKFTyyn6DsdaGIPYvhmYCdbgokK0HmktjX96aaO0MzM5xeKfX/r3pLTAdEcc9lxyqICE+d9A4FCIWISpzf2tzWqY86vbSQWylJQta5UOLbiGsce4JN57WRpwlSdGkNx4zDfmnhLNwd7Ir/OGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkR3HS+A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkR3HS+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA42EC2BCB1;
	Mon, 23 Mar 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774278759;
	bh=tTzRD/5QdlyRLK1EtxLTVvBj/l5amHALku8Zl9jmQbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkR3HS+AVrNHpExi/W9v183XJhT6bwxOhbYxlPexeP61pYQIj6VSeywhv73F9cm2V
	 lyilDUDeffB7xJ7CBKo26VAbv+TT3HIKx7SlbLEV8ywMEFLxJws3SOgVP+Ymw+i7q5
	 xY6YuIbxYN4XH0ON2bJ1imCg3HoFGUJfcKHaW7dqX7gmDkc4gxYEGmuIJ6Ap8HGVcA
	 OBRpnbvPeM40ILQX+Yz0MLeaybV1lks9n0TKJaswlZUKewVbFgrf1QIyk6PJXbfUqj
	 McRZmsS6mm3OM0i7Brv5HBwzt06KFiun6Au3tYRMp9i3wkvNF2urQWRn35UsxTQZU/
	 AjRgNGadSFEoQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 08:12:36 -0700
Message-ID: <20260323151237.81224-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323072724.15942-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 15:27:24 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> Thank you for reviewing this patch. I'd like to address the review from
> Sashiko.dev [1] and ask for your guidance on two concerns.
> 
> > > -static int damon_lru_sort_handle_commit_inputs(void)
> > > +static int damon_lru_sort_commit_inputs_fn(void *arg)
> > >  {
> > > +	return damon_lru_sort_apply_parameters();
> > > +}
> > > +
> > > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > > +		const struct kernel_param *kp)
> > > +{
> > > +	bool yes;
> > >  	int err;
> > > +	struct damon_call_control control = {
> > > +		.fn = damon_lru_sort_commit_inputs_fn,
> > > +		.data = ctx,
> > > +		.repeat = false,
> > > +	};
> > >  
> > > -	if (!commit_inputs)
> > > +	err = kstrtobool(val, &yes);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (commit_inputs == yes)
> > >  		return 0;
> > >  
> > > -	err = damon_lru_sort_apply_parameters();
> > > +	if (!yes) {
> > > +		commit_inputs = false;
> > > +		return 0;
> > > +	}
> > > +
> > > +	commit_inputs = yes;
> > > +
> > > +	/*
> > > +	 * Skip damon_call() during early boot or when kdamond is idle
> > > +	 * to avoid NULL pointer dereference or unexpected -EINVAL.
> > > +	 */
> > > +	if (!ctx || !damon_is_running(ctx))
> > > +		return 0;
> > If kdamond is not running, this returns 0 but leaves commit_inputs set to
> > true. When kdamond later starts, will subsequent writes of 'Y' to
> > commit_inputs hit the earlier check "if (commit_inputs == yes) return 0;" and
> > silently ignore parameter updates until it is manually reset to 'N'?
> 
> My current thought:
> When '!ctx || !damon_is_running(ctx)', we should return -EBUSY instead
> of 0, and keep 'commit_inputs' unchanged. This way, userspace
> immediately knows the operation cannot proceed, and there is no risk of
> stale state.

Yes, I think we should unset commit_inputs in the case as you and sashiko also
mentioned.  Maybe it is better to just keep its value always 'false', though.
Please read my reply to the patch for more details about why I think so.

> 
> But, this means that users can no longer write 'commit_inputs=Y' before
> 'enabled=Y'.

Is this a problem?

> 
> > > +
> > > +	err = damon_call(ctx, &control);
> > The module parameter set operations are protected by the global kernel
> > param_lock. If the kdamond thread is currently deactivated by watermarks and
> > sleeping for the watermark check interval, could this damon_call() block on
> > wait_for_completion() and hold the global param_lock for an unbounded
> > duration?

It is bounded to user-set 'wmarks_interval'.  So I guess that's not a real
issue?

> >
> > Also, could there be a race condition here if the kdamond thread is stopping?
> >
> > If kdamond_fn() flushes pending calls and only afterward sets ctx->kdamond to
> > NULL, could damon_call() insert its control into the list precisely in this
> > window? This might cause it to perceive the thread as active and block on the
> > completion forever, deadlocking the param_lock.

damon_call() handles such cases using damon_call_handle_inactive_ctx().  I hope
that could work for this, too.  Liew, could you please double check?

> 
> I admit I don't have an elegant solution yet. Here are my current
> thought:
> 
> Add a timeout to wait_for_completion() (e.g.,
> wait_for_completion_timeout()), using 'damos_watermarks.interval' as the
> upper bound. This prevents indefinite blocking of 'param_lock', though
> it still holds the global lock for up to several seconds.

Because it is already kind of timed out for user-set 'wmarks_interval', I don't
think we need an additional timeout.  Please let me know if I'm missing
something.


Thanks,
SJ

[...]
