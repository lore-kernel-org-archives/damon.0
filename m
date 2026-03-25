Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBD3DDDBB
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448400; cv=none; b=bXDIEYEpa6ZCcV8ZhlnkLp0E5Zn6gyUuaBm0c6j3eTkpB5qDC8wCVNFUdAPdC3kex3IyPVmNNKaBSO4xKQXLbjuzI2yrOVZAeVa1wM6wlz+zi0gwZ/V5COFztrqcdmEEW8E+KWYlR85cv91DBy5OSWZ3Zd8PI7YCDbyMnpnHJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448400; c=relaxed/simple;
	bh=q5VvioLDQTNcYBbO1nmeWlXQ6duaUHGdgXQqKoMkybE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCxut0Wojn77u+xpWwJNda4oiEbBqKM5Rtw1U3R6jI05BbFfMDyccAhr3ePBilDfks/FszB3pCar6CGp9ow4dJpqycYYoYjfrrfE0+KVAb7Pqk85u1JuljIlJaT060fB4+H9W9ZTQDi7rFLn0oizq1mKWKfazyCtzj00ypqCSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXnLPu+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXnLPu+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CA8C4CEF7;
	Wed, 25 Mar 2026 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774448400;
	bh=q5VvioLDQTNcYBbO1nmeWlXQ6duaUHGdgXQqKoMkybE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXnLPu+Wm4eCAzSiDsSSlHCsRyCrKH1ygMQc7l+D0gDD7h9w1yusmvNHEwhEZxABV
	 OCXMvPeqfHEuCdZPgtBBsGhT2T2ZHRiqyWHsDG3qI4Or/jMKiqWjAsj5zsPXtkAADs
	 ffmkfJBdioOfVc3B+raHfbYhqa5Ttu3E0npkUWMSoazmzh+uHAlgrgQiUgTC036/oi
	 VLu4JCQvnSR6QHvs4oM4u6rWHSrM9uoDATi72/t13KQmHl+P8Ukuw8w8iZwoHHX471
	 fHcIUcabP5CqXv6Es9EVaAhNsAvvQlIusPe2kyJXFFv69YqnQupSXimj5ekjvLM2Tq
	 qdURwRi77wIYw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Wed, 25 Mar 2026 07:19:56 -0700
Message-ID: <20260325141956.87144-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325071709.9699-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Wed, 25 Mar 2026 15:17:09 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> > Forwarding Sashiko review for doing discussions via mails.
> > 
> > # review url: https://sashiko.dev/#/patchset/20260325013939.18167-1-aethernet65535@gmail.com
> > # start of sashiko.dev inline review
> > commit 60ccea4154b0c58741fae2323454a5a9496b67fa
> > Author: Liew Rui Yan <aethernet65535@gmail.com>
> > 
> > mm/damon: add synchronous commit for commit_inputs
> > 
> > Writing invalid parameters to sysfs followed by commit_inputs=Y previously
> > failed silently. This patch uses damon_call() to synchronously commit
> > parameters in the kdamond thread's safe context, returning validation errors
> > immediately to userspace.
> > 
> > Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> > 
> > > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > > index 554559d72976..a2410f648b51 100644
> > > --- a/mm/damon/lru_sort.c
> > > +++ b/mm/damon/lru_sort.c
> 
> Thank you for forwarding the review from Sashiko.dev!

Thank you for reviewing the review.

> 
> > > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > > +		const struct kernel_param *kp)
> > > +{
> > > +	bool commit_inputs_request;
> > >  	int err;
> > > +	struct damon_call_control control = {
> > > +		.fn = damon_lru_sort_commit_inputs_fn,
> > > +		.data = ctx,
> > > +		.repeat = false,
> > > +	};
> > >  
> > > -	if (!commit_inputs)
> > > +	err = kstrtobool(val, &commit_inputs_request);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (!commit_inputs_request)
> > >  		return 0;
> > >  
> > > -	err = damon_lru_sort_apply_parameters();
> > > -	commit_inputs = false;
> > > -	return err;
> > > +	/*
> > > +	 * Skip damon_call() during early boot or when kdamond is
> > > +	 * not running to avoid NULL pointer dereference.
> > > +	 */
> > > +	if (!ctx)
> > > +		return -EBUSY;
> > > +
> > > +	err = damon_call(ctx, &control);
> > 
> > Can this sequence lead to a system-wide deadlock on kernel_param_lock?
> > 
> > Because damon_lru_sort_commit_inputs_store() is a sysfs .set callback, it
> > executes with the global kernel_param_lock held.
> > 
> > If kdamond_fn terminates (e.g., due to an invalid parameter like addr_unit=3
> > causing a non-power-of-2 min_region_sz), it processes its exit sequence by
> > calling kdamond_call(ctx, true) to flush pending requests. After flushing, it
> > eventually sets ctx->kdamond = NULL at the very end of the thread.
> > 
> > If a user writes to commit_inputs exactly in the window after
> > kdamond_call() finishes but before ctx->kdamond = NULL is set:
> > 
> > Thread 1 (kdamond_fn):
> >     kdamond_call(ctx, true);
> > 
> > Thread 2 (sysfs write):
> >     damon_call(ctx, &control);
> >         if (damon_is_running(ctx))
> >             wait_for_completion(&control.completion);
> > 
> > Thread 1 (kdamond_fn):
> >     ctx->kdamond = NULL;
> > 
> > Thread 2 will sleep indefinitely in wait_for_completion(). Because Thread 2
> > holds the global kernel_param_lock, this permanently freezes all module
> > parameter sysfs interfaces system-wide.
> 
> I have verified this behavior with the following test case:
> 
>     # cd /sys/module/damon_lru_sort/parameters/
>     # echo Y > enabled
>     # ps aux | grep "[k]damond"
>     root   70  0.0  0.0  0  0 ?  I  12:16  0:00 [kdamond.0]

FYI, you can read kdamond_pid parameter.

>     # echo 3 > addr_unit
>     # echo Y > commit_inputs
>     bash: echo: write error: Invalid argument
>     # ps aux | grep "[k]damond"
> 
>     ... kdamond has exited unexpectedly
> 
> I will add a patch in v6 to validate 'addr_unit' in addr_unit_store() to
> reject non-power-of-2 inputs immediately.

That's because kdamond_fn() has recently changed to exit the loop if
damon_commit_ctx() fails in the loop for any reason.  Refer to commit
26f775a054c3 ("mm/damon/core: avoid use of half-online-committed context") for
more details.

Adding the validation in addr_unit_store() would work, but it could be a kind
of whack-a-mole game.  I'd prefer doing the validation of all inputs in one
place, just before the last damon_commit_ctx() call.  DAMON_SYSFS is doing so,
by making a test context and try committing user input to the test context
before doing that to the running context.  How about doing so here, too?

> 
> > > +	if (err) {
> > > +		/*
> > > +		 * If kdamond is not running, damon_call() returns -EINVAL.
> > > +		 * Remap it to -EBUSY to better reflect that the operation
> > > +		 * failed due to the current state of the system.
> > > +		 */
> > > +		if (err == -EINVAL && !damon_is_running(ctx))
> > > +			return -EBUSY;
> > > +
> > > +		return err;
> > > +	}
> > > +
> > > +	return control.return_code;
> > >  }
> > 
> > > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > > index 86da14778658..4cbd67e08d56 100644
> > > --- a/mm/damon/reclaim.c
> > > +++ b/mm/damon/reclaim.c
> > 
> > [ ... ]
> > 
> > > +	/*
> > > +	 * Skip damon_call() during early boot or when kdamond is
> > > +	 * not running to avoid NULL pointer dereference.
> > > +	 */
> > > +	if (!ctx)
> > > +		return -EBUSY;
> > > +
> > > +	err = damon_call(ctx, &control);
> > 
> > Does this code share the same kernel_param_lock deadlock potential as
> > damon_lru_sort_commit_inputs_store() described above?
> 
> As we discussed in the RFC-v4 thread [1], this is a false positive.
> Since 'enabled=N' and 'commit_inputs=Y' are both serialized by the
> global 'kernel_param_lock', and kthreads cannot be forcibly terminated
> by userspace signals, the completion signal in damon_call() will always
> be reached in a controlled manner.

TL; DR: I think the deadlock can happen.  But that's a separate issue.

Let's suppose the user writes 'Y' to commit_inputs, and damon_commit_ctx()
fails due to an allocation failure.  The write to commit_inputs will complete,
and kdmond_fn() will start its exit sequence.

The user can write 'Y' to commit_inputs again, when kdamond_fn() finished the
last kdamond_call() with 'cancel=True', but before it unset the ->kdamond
field.

Then, the deadlock that sashiko pointed out could happen.

The deadlock is due to the incomplete design of damon_call() cleanup.  And I
think the same deadlock is already available with DAMON_SYSFS.  I will work on
fixing this.

So the issue already exists.  But let's ensure the fix is merged before this
patch, since this patch adds another exploitable path that can consequence in
whole param_lock deadlock.

> 
> [1] https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com


Thanks,
SJ

[...]
