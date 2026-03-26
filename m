Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294741C72
	for <damon@lists.linux.dev>; Thu, 26 Mar 2026 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505760; cv=none; b=U229G74VQ7OfrtVF61IJB593nyTtlyxCkWt22xNkNuOIyxGGDkNBnxgkGYOWMoeZ2OHI9RycJd/DXkBwGjlCclh8vYZXDcCfqYatwn1+OLYFDeJK+vygULmxVuvi5UDxEiXgXn1KNrRkv41tpr84lxYeojwOYgFAdpor10Lce0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505760; c=relaxed/simple;
	bh=mIRxZ/I0eorizTPJmJEPXDBKgn4+9C+24c9EUuvfgYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1bue6Rz/aGTaEMgYGQFzG+o0LPAdLp6Y2DuUAHWyG/6HEFfRW3WDxJ8RyuD/J5n0a1zLONbRtnXUywrsTImnRv4TLywMapPrvRy2TcQSrQv+H1QzmYM1SWuoSKXeOiDwLGGjq/ChJDE3vKTGzo2ThU+am4NDrWK37DkLdbbYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtGV7uPh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtGV7uPh"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82418b0178cso304463b3a.1
        for <damon@lists.linux.dev>; Wed, 25 Mar 2026 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774505758; x=1775110558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p21EOSSnCFy71Fyv5uK3rPcnOtTcDDpnl2bD5vJEsTA=;
        b=FtGV7uPh178aLz0KfuOUchrFvdcw5zSvhzq+jgmM7xUyfJ0dFbt4p5Jt9/EGBEnm7n
         NnQdNKhaleNWqIzYIaB6CiG66dkBPBxT+20zcK1XTFVa6qkrUWWc2TJ6lsnglGFARkcc
         IbN96Rrch0Tyz/CxMoamvq3SXi/lggwTmCTuU7XcOzTjeYpTVwl6x5cMbPCTpDDdprMi
         NP0vXvjU1yplE890QPfNIQd+gWEBGa1i+5fvN4rdwYZoDtMbA/paeap2zkKDiSWCh0PL
         A7zvxDtPgtml9sDyHUiemqI3CHGf6U9KjLRHcem14ZaQHRopgtg/dVzD4/XlBJTr+Fig
         c7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774505758; x=1775110558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p21EOSSnCFy71Fyv5uK3rPcnOtTcDDpnl2bD5vJEsTA=;
        b=PquKuKi6vNATs9iaxZ2bsn71HIMXMWDxQ1dfdL1f4slg1BglJUfaGHx44TGawC3VaF
         3Lj3oZs0mDdM/J6ECIhobtMAn2Woh/vUQodKKc0c4r3RBChuAy8XLkJJZcZqDHxx94+s
         3/KpE/pHPDT1hn0TiHS4T/gihwR5GmTPlYLWWINvG05YaIm7G1ZJnWpHUuTfwoNXiWSq
         Tu3PaeWHf+gAB7SrrxzDYKb2QVgDwMdy1GvZXK8Hd9Z11sQe0419npJyZu2Kzt8qgmXO
         uZtZRGc0rzU2xEpIkZeEtgslUl3xn+pB3MI/6KvliZEfCqqezu8vc31dxzDsdWH6FiMf
         A6jg==
X-Forwarded-Encrypted: i=1; AJvYcCVwqVwHudlEKaaKWpaNFiH6TL8VR4GcxChA6KSLA+fkxUntte8znpe89IUYKu9i34fOeEPASw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg+/cT5gKWKcSxgE8U2notXcd0yUFCT89HscWUKwKiGwLlerVO
	mT030iERwoUtOLoWaSifHh0UNBVHcE8q8csgS1GtYaTSPkll6DgtEPoX
X-Gm-Gg: ATEYQzyQ9q5BKc4MAC1ZOrV6neHjiKDU4rSDMF0r4wlrGsq25QnvvYuY7cPPUZBKuIG
	6C6X7GKUYLNYGK3xkeOI3xwNQ2OS7/2nL43t4SNQvsMmBOtu+S3LX7y4r7k+sGXDlmIOHGzM7Nt
	AAmrLg28cEFn6CkGEIxcdmALWtJloeSgmUfGcFDwquk6/iUzEiqk7rf8a/qqXheI5FqQ0VlXX21
	AYA8oWW1UGvu9RzAJfFuZqO7koeCLbIEiOn8jM9t8bOkaKw2NeAd0cYzOVZ95f23lE8LlMGhI3V
	UDG383k1/6YwaJl7cJ2uvlvYj6wGPYoPyrZAhtodtSQIsDJvZXQr/nqG8l4ACdz1P20Y0AtGPMV
	NY0K8dHwsdzrV/FbBgjJ7G3H2uBKmgSnS2CrWHWu0KMyAW1rMrkDmrzpsujxwj19MYXP7uGEV6J
	VNKhQq3hdBwKqLJIstHYSrLg4OJR/VeweczsmVaBb6XvNyDK+lmYs=
X-Received: by 2002:a05:6a00:1408:b0:829:803e:6798 with SMTP id d2e1a72fcca58-82c6e11bbfamr6279168b3a.56.1774505758063;
        Wed, 25 Mar 2026 23:15:58 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3bedeesm1482240b3a.42.2026.03.25.23.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 23:15:57 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Thu, 26 Mar 2026 14:15:54 +0800
Message-ID: <20260326061554.20466-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325141956.87144-1-sj@kernel.org>
References: <20260325141956.87144-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Wed, 25 Mar 2026 07:19:56 -0700, SeongJae Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Wed, 25 Mar 2026 15:17:09 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > > Forwarding Sashiko review for doing discussions via mails.
> > > 
> > > # review url: https://sashiko.dev/#/patchset/20260325013939.18167-1-aethernet65535@gmail.com
> > > # start of sashiko.dev inline review
> > > commit 60ccea4154b0c58741fae2323454a5a9496b67fa
> > > Author: Liew Rui Yan <aethernet65535@gmail.com>
> > > 
> > > mm/damon: add synchronous commit for commit_inputs
> > > 
> > > Writing invalid parameters to sysfs followed by commit_inputs=Y previously
> > > failed silently. This patch uses damon_call() to synchronously commit
> > > parameters in the kdamond thread's safe context, returning validation errors
> > > immediately to userspace.
> > > 
> > > Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> > > 
> > > > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > > > index 554559d72976..a2410f648b51 100644
> > > > --- a/mm/damon/lru_sort.c
> > > > +++ b/mm/damon/lru_sort.c
> > 
> > Thank you for forwarding the review from Sashiko.dev!
> 
> Thank you for reviewing the review.
> 
> > 
> > > > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > > > +		const struct kernel_param *kp)
> > > > +{
> > > > +	bool commit_inputs_request;
> > > >  	int err;
> > > > +	struct damon_call_control control = {
> > > > +		.fn = damon_lru_sort_commit_inputs_fn,
> > > > +		.data = ctx,
> > > > +		.repeat = false,
> > > > +	};
> > > >  
> > > > -	if (!commit_inputs)
> > > > +	err = kstrtobool(val, &commit_inputs_request);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	if (!commit_inputs_request)
> > > >  		return 0;
> > > >  
> > > > -	err = damon_lru_sort_apply_parameters();
> > > > -	commit_inputs = false;
> > > > -	return err;
> > > > +	/*
> > > > +	 * Skip damon_call() during early boot or when kdamond is
> > > > +	 * not running to avoid NULL pointer dereference.
> > > > +	 */
> > > > +	if (!ctx)
> > > > +		return -EBUSY;
> > > > +
> > > > +	err = damon_call(ctx, &control);
> > > 
> > > Can this sequence lead to a system-wide deadlock on kernel_param_lock?
> > > 
> > > Because damon_lru_sort_commit_inputs_store() is a sysfs .set callback, it
> > > executes with the global kernel_param_lock held.
> > > 
> > > If kdamond_fn terminates (e.g., due to an invalid parameter like addr_unit=3
> > > causing a non-power-of-2 min_region_sz), it processes its exit sequence by
> > > calling kdamond_call(ctx, true) to flush pending requests. After flushing, it
> > > eventually sets ctx->kdamond = NULL at the very end of the thread.
> > > 
> > > If a user writes to commit_inputs exactly in the window after
> > > kdamond_call() finishes but before ctx->kdamond = NULL is set:
> > > 
> > > Thread 1 (kdamond_fn):
> > >     kdamond_call(ctx, true);
> > > 
> > > Thread 2 (sysfs write):
> > >     damon_call(ctx, &control);
> > >         if (damon_is_running(ctx))
> > >             wait_for_completion(&control.completion);
> > > 
> > > Thread 1 (kdamond_fn):
> > >     ctx->kdamond = NULL;
> > > 
> > > Thread 2 will sleep indefinitely in wait_for_completion(). Because Thread 2
> > > holds the global kernel_param_lock, this permanently freezes all module
> > > parameter sysfs interfaces system-wide.
> > 
> > I have verified this behavior with the following test case:
> > 
> >     # cd /sys/module/damon_lru_sort/parameters/
> >     # echo Y > enabled
> >     # ps aux | grep "[k]damond"
> >     root   70  0.0  0.0  0  0 ?  I  12:16  0:00 [kdamond.0]
> 
> FYI, you can read kdamond_pid parameter.
> 
> >     # echo 3 > addr_unit
> >     # echo Y > commit_inputs
> >     bash: echo: write error: Invalid argument
> >     # ps aux | grep "[k]damond"
> > 
> >     ... kdamond has exited unexpectedly
> > 
> > I will add a patch in v6 to validate 'addr_unit' in addr_unit_store() to
> > reject non-power-of-2 inputs immediately.
> 
> That's because kdamond_fn() has recently changed to exit the loop if
> damon_commit_ctx() fails in the loop for any reason.  Refer to commit
> 26f775a054c3 ("mm/damon/core: avoid use of half-online-committed context") for
> more details.
> 
> Adding the validation in addr_unit_store() would work, but it could be a kind
> of whack-a-mole game.  I'd prefer doing the validation of all inputs in one
> place, just before the last damon_commit_ctx() call.  DAMON_SYSFS is doing so,
> by making a test context and try committing user input to the test context
> before doing that to the running context.  How about doing so here, too?

Thank you for the suggestion. I have now added the check
'!src->addr_unit || ! is_power_of_2(src->addr_unit)' to
damon_commit_ctx().

> > 
> > > > +	if (err) {
> > > > +		/*
> > > > +		 * If kdamond is not running, damon_call() returns -EINVAL.
> > > > +		 * Remap it to -EBUSY to better reflect that the operation
> > > > +		 * failed due to the current state of the system.
> > > > +		 */
> > > > +		if (err == -EINVAL && !damon_is_running(ctx))
> > > > +			return -EBUSY;
> > > > +
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	return control.return_code;
> > > >  }
> > > 
> > > > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > > > index 86da14778658..4cbd67e08d56 100644
> > > > --- a/mm/damon/reclaim.c
> > > > +++ b/mm/damon/reclaim.c
> > > 
> > > [ ... ]
> > > 
> > > > +	/*
> > > > +	 * Skip damon_call() during early boot or when kdamond is
> > > > +	 * not running to avoid NULL pointer dereference.
> > > > +	 */
> > > > +	if (!ctx)
> > > > +		return -EBUSY;
> > > > +
> > > > +	err = damon_call(ctx, &control);
> > > 
> > > Does this code share the same kernel_param_lock deadlock potential as
> > > damon_lru_sort_commit_inputs_store() described above?
> > 
> > As we discussed in the RFC-v4 thread [1], this is a false positive.
> > Since 'enabled=N' and 'commit_inputs=Y' are both serialized by the
> > global 'kernel_param_lock', and kthreads cannot be forcibly terminated
> > by userspace signals, the completion signal in damon_call() will always
> > be reached in a controlled manner.
> 
> TL; DR: I think the deadlock can happen.  But that's a separate issue.
> 
> Let's suppose the user writes 'Y' to commit_inputs, and damon_commit_ctx()
> fails due to an allocation failure.  The write to commit_inputs will complete,
> and kdmond_fn() will start its exit sequence.
> 
> The user can write 'Y' to commit_inputs again, when kdamond_fn() finished the
> last kdamond_call() with 'cancel=True', but before it unset the ->kdamond
> field.
> 
> Then, the deadlock that sashiko pointed out could happen.
> 
> The deadlock is due to the incomplete design of damon_call() cleanup.  And I
> think the same deadlock is already available with DAMON_SYSFS.  I will work on
> fixing this.

I really appreciate your dedication to DAMON.

> So the issue already exists.  But let's ensure the fix is merged before this
> patch, since this patch adds another exploitable path that can consequence in
> whole param_lock deadlock.

Should I wait for your fix to be merged into damon/next before I post
the next version?

Best regards,
Rui Yan
