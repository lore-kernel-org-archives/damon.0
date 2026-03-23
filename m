Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3572E11D2
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291093; cv=none; b=JJ6LCJXjJ7xUgcp9s7lm+ZV+w27/u4P1sdYisuXhrhZcwdsSopB1iRpoO1Uu/sD8ViEEnUWVcYFpBNXYsGm+zqt2XvNT3hCs6ZJ5nkh2w8HFsGazAh2vsj5RMtffNUWZ5/9Gzm4NsGH+1HwzIsTy72DKRw29bYwLi4qcp4lgLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291093; c=relaxed/simple;
	bh=p6ttFEoKwFXvehvDTPRfINYRp8vMaQ6dQxIZKHW+c4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m18T83+WR+vD4U2akH7mskvfxneGcUeP7jmPj16ti4Z+pDYb8Oi/NeOA9hTtt3tFcgqrrnopzbUJmBax1Y8t/gXmykArkUEIVtVPAz76IVWFQvXuN1S1eXLX0DOkwgyIXMKxY7DhRVPwUMrJ0jgvjhp4XYJDrhsDrVlr4sf3VrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pe9Mdu5c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe9Mdu5c"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3679853a91.1
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291091; x=1774895891; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VpMu8BW02kfasuQLNMIW88lcfKKCHzNKLRC8iN9hLI=;
        b=pe9Mdu5cRJYiviOr+p/8qWzlAFBnhQJlu52fOxp5vNjESwwvV74zHhhHlUfkyDwjq5
         7SRwvc18mxII62is0Wi4vI8+p4WMnulFuaghoqycM7N1yXV01/LcpODEils7q9F2cwL6
         C5Pio1q9dT+lZyn2GMeJaJBLU0FdMeIVnmlKN0vLiFSBBvno8WMWw+b26avgdafWb+jq
         2HdXISTV4hkqhz9ewHxic8doxDDVkOM7wAhrycGA7RzfnrEVi03aTfbtOjtJvLdd6aka
         H/ew8K+U5itkqh/B4fCM4NGHC06yRLHtZXWHvas4sern9Vk/R2FCV754CrHCZZwtYEih
         8/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291091; x=1774895891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9VpMu8BW02kfasuQLNMIW88lcfKKCHzNKLRC8iN9hLI=;
        b=puG4eVi6JelkhXQ5dpKLlhUvH43vHPo9GC5TKrq8QCfCypNbKRGucHi8q2pauFQdi3
         G9ifAZXUKeo2vmAV4AKpOuMd0C7603zG5yNNFgZysU+50oSprADDuLCHaXJWz/Qf+St4
         /XqU4SYxIvYtshL3AZHH6gaiaMTJ9T4rb5bOKJrkkvJhMlHYvGjTFCyqEfoY3/clmx+E
         Qgf5BneB3AI9v9/3NOikefht6oxLDV03yJU4t3dd/u6/NOaKSokL6iHdYen/aJCEnGt5
         5CwXIK5/SAaEWBalVRHypqQ5CL5JIlppXtNXikvkR8o3DPQQOrJHNV5Ns+4cRFZkFKwm
         0YRw==
X-Forwarded-Encrypted: i=1; AJvYcCWEg5mMeOvkMtt/IeA4Ix3X+PP4b7kXyuI9VEb45pTQqpfGV2oC9DGSFixeVPWDRWaRv8TGpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxODsI0Pk9pM2ySadBzcuPBVe93Bk3zyxvwqAYon7PLVegpzjoJ
	rDfCVKmgzfrjTSNvW8wJARTbIQRdYW9mRX6WsjTZJAwdJWyY5YADM8RZ
X-Gm-Gg: ATEYQzzsYStAhGkeKAQ03i37Av6Mqq6J394v6ECGMjJFTmdbe5K7PQM2nwFHQItDWy8
	3W4YyrLU2W/fMk6UExy09H4asLaBtLtD7gz/yMfLsYoA0SryqIVMhrFW5FgHN57M0ecWJIa+H/v
	gntr3Q9NHfH1ZGNFa8cRPKk3AZmW2WosZmD5HthtYTAxyydnDiObi4CvhCa/llGqJezIbERXJON
	VoO21Bn8BYvRlKk3Cch31yBwM/OEgXA7JuV0En/mqJSAuIvrVugFGtXHFnYpX1YgLsBluSP72yb
	srGGaXRI3/v7uPEFttDWCAjeSlcH4IkQT0mzSEdWTHbA6jOoGh9SX6erm9LvHA8aQJuzsvoBwQ6
	QcPFEompUXpvK92nKd8j/kaz0+pgSEUI+p59Im4VNOCqe5ryKeLZ/UdO7Xppa1Aq3kpRLQPipIC
	ZzADDgt2mAXO0TWCvDITbyF/pFIX037OU5tpyDLg==
X-Received: by 2002:a17:90b:3d48:b0:359:8d95:4a4f with SMTP id 98e67ed59e1d1-35bd2d3b8f9mr10302435a91.32.1774291091371;
        Mon, 23 Mar 2026 11:38:11 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c017477eesm23164a91.1.2026.03.23.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:38:11 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Tue, 24 Mar 2026 02:37:58 +0800
Message-ID: <20260323183758.42138-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323151237.81224-1-sj@kernel.org>
References: <20260323151237.81224-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Hi SeongJae,
> > 
> > Thank you for reviewing this patch. I'd like to address the review from
> > Sashiko.dev [1] and ask for your guidance on two concerns.
> > 
> > > > -static int damon_lru_sort_handle_commit_inputs(void)
> > > > +static int damon_lru_sort_commit_inputs_fn(void *arg)
> > > >  {
> > > > +	return damon_lru_sort_apply_parameters();
> > > > +}
> > > > +
> > > > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > > > +		const struct kernel_param *kp)
> > > > +{
> > > > +	bool yes;
> > > >  	int err;
> > > > +	struct damon_call_control control = {
> > > > +		.fn = damon_lru_sort_commit_inputs_fn,
> > > > +		.data = ctx,
> > > > +		.repeat = false,
> > > > +	};
> > > >  
> > > > -	if (!commit_inputs)
> > > > +	err = kstrtobool(val, &yes);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	if (commit_inputs == yes)
> > > >  		return 0;
> > > >  
> > > > -	err = damon_lru_sort_apply_parameters();
> > > > +	if (!yes) {
> > > > +		commit_inputs = false;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	commit_inputs = yes;
> > > > +
> > > > +	/*
> > > > +	 * Skip damon_call() during early boot or when kdamond is idle
> > > > +	 * to avoid NULL pointer dereference or unexpected -EINVAL.
> > > > +	 */
> > > > +	if (!ctx || !damon_is_running(ctx))
> > > > +		return 0;
> > > If kdamond is not running, this returns 0 but leaves commit_inputs set to
> > > true. When kdamond later starts, will subsequent writes of 'Y' to
> > > commit_inputs hit the earlier check "if (commit_inputs == yes) return 0;" and
> > > silently ignore parameter updates until it is manually reset to 'N'?
> > 
> > My current thought:
> > When '!ctx || !damon_is_running(ctx)', we should return -EBUSY instead
> > of 0, and keep 'commit_inputs' unchanged. This way, userspace
> > immediately knows the operation cannot proceed, and there is no risk of
> > stale state.
> 
> Yes, I think we should unset commit_inputs in the case as you and sashiko also
> mentioned.  Maybe it is better to just keep its value always 'false', though.
> Please read my reply to the patch for more details about why I think so.
> 
> > 
> > But, this means that users can no longer write 'commit_inputs=Y' before
> > 'enabled=Y'.
> 
> Is this a problem?

No, that's not a problem for me, but I think it might change some user
behavior, although I don't think anyone relies on that behavior. If
you're okay with it, then that's great! :>

> > 
> > > > +
> > > > +	err = damon_call(ctx, &control);
> > > The module parameter set operations are protected by the global kernel
> > > param_lock. If the kdamond thread is currently deactivated by watermarks and
> > > sleeping for the watermark check interval, could this damon_call() block on
> > > wait_for_completion() and hold the global param_lock for an unbounded
> > > duration?
> 
> It is bounded to user-set 'wmarks_interval'.  So I guess that's not a real
> issue?

I also believe that this is true.

> > >
> > > Also, could there be a race condition here if the kdamond thread is stopping?
> > >
> > > If kdamond_fn() flushes pending calls and only afterward sets ctx->kdamond to
> > > NULL, could damon_call() insert its control into the list precisely in this
> > > window? This might cause it to perceive the thread as active and block on the
> > > completion forever, deadlocking the param_lock.
> 
> damon_call() handles such cases using damon_call_handle_inactive_ctx().  I hope
> that could work for this, too.  Liew, could you please double check?

I have read the implementation of this damon_call_handle_inactive_ctx().
It does seem to avoid that issue.

> > I admit I don't have an elegant solution yet. Here are my current
> > thought:
> > 
> > Add a timeout to wait_for_completion() (e.g.,
> > wait_for_completion_timeout()), using 'damos_watermarks.interval' as the
> > upper bound. This prevents indefinite blocking of 'param_lock', though
> > it still holds the global lock for up to several seconds.
> 
> Because it is already kind of timed out for user-set 'wmarks_interval', I don't
> think we need an additional timeout.  Please let me know if I'm missing
> something.

It makes perfect sense. I believe there shouldn't be any problems, since
both 'enabled' and 'commit_inputs' are protected by param_lock.

Best regards,
Rui Yan
