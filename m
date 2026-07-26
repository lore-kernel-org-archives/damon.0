Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E243D5C26
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091980; cv=none; b=qCi00preKNXubIFKORkrp+1/oUmKjngNvfFWULj6hFnVxGMN5+0h9upD6vtEeBUPnXpuYwMMLeFZrQXoGBvrAnRYkGj4Ds56KaRJr85Ys+h/uQQZ7jGQGZJr2vFUuDkfxgsQyUMBrcfNKG2StG48HNtuqrQSLTz1v90Og3cxcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091980; c=relaxed/simple;
	bh=J6345WFk6bXc3tgG0Y3XXECJg2dMUy94kuMsq+VlC5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEpoCPlkT6fHRmr7i9b8Ij88lqpVR9WwOPbWjDW11og+BrwIPGOASqUWmyuWCfQQlD7B212U3boU5R8LzmVLD7KFzaq7lttUxwxmpp0bl6TMRvLtvrBO4J/PfKfJsbRAJ9vtTA0fOgQxP8XFS8QqGKF9GSkO0+quay07g7qgw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKCqiLTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKCqiLTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD161F000E9;
	Sun, 26 Jul 2026 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785091978;
	bh=RQGYnJriOAN6kVyRgVz5uzx67arHqlx9H2p6zyAhbp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gKCqiLTaF6lSwGwScsDOGofVr3DHrib02GBxM1sPvO29nemILLuCpW39n1qtAXrGn
	 VDxZWq3KGwkXoUS3SROyZC5DGFSRFRI5gfIKcv/d8qTchG+1Jhnj55pe55zgptKVZw
	 k4zNV8qbCRcoaRBGAA0l5iDzgGESV9hzZ1zVs2vOiZ8Yc+s4BmGsa6jyPMDbDxW2rL
	 /fyA21OADUy1JptRELxIhNhmm3nShJWxyXFYg/7h9cQohw7lGpeckUX/fw4dq4hwst
	 W5xSDaS3y+hMbtGyd5db/2TN+ka+iXLW4nnPY67fycfQuOA3kE/K1N65AC9QmitSl0
	 m6sVmzJIaUw8w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 07/17] mm/damon/core: introduce damon_operations->prep_probes()
Date: Sun, 26 Jul 2026 11:52:49 -0700
Message-ID: <20260726185251.2021-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726175701.89E4D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:57:00 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] TOCTOU race in `kdamond_fn` across blocking wait leads to NULL pointer dereference of `ctx->ops.prep_probes`.
> - [Medium] Silent bypass of preparation actions when unsupported by operations set.
> - [Low] API Contract Omission: `prep_probes` documentation fails to specify the requirement to set `sampling_addr`.
> --
> 
> --- Patch [7]: [RFC PATCH v2 07/17] mm/damon/core: introduce damon_operations->prep_probes() ---
> commit f3f60f13684ba2645da0754240dfe010fa41b859
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_operations->prep_probes()
> 
> damon_prep needs to be executed by the underlying DAMON operation set.
> Extend the operation set callback list for the execution of damon_prep
> actions. If the underlying operation set implements the callback, DAMON
> core executes it in the monitoring preparation time.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 24b362fcf53b1..fe2c6b56d1d53 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -654,6 +655,8 @@ enum damon_ops_id {
> >   * last preparation and update the number of observed accesses of each region.
> >   * It should also return max number of observed accesses that made as a result
> >   * of its update.  The value will be used for regions adjustment threshold.
> > + * @prep_probes should execute required &struct damon_prep for next &struct
> > + * damon_probe applications to each region.
> 
> [Severity: Low]
> Does this documentation need to specify that @prep_probes is responsible
> for setting the sampling_addr?
> 
> Looking at kdamond_fn(), when do_prep and access_check_disabled are both
> true, apply_probes() receives false for its set_samples parameter:
> 
> kdamond_fn() {
> ...
>         if (do_prep)
>                 ctx->ops.prep_probes(ctx, access_check_disabled);
> ...
>                 max_wsum = ctx->ops.apply_probes(ctx,
>                                 access_check_disabled && !do_prep,
>                                 get_max_wsum);
> ...
> }
> 
> This seems to leave prep_probes as the only callback receiving true for
> set_samples, making it solely responsible for setting sampling_addr.

Nice suggestion, I will do, like below.

'''
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -714,7 +714,8 @@ enum damon_ops_id {
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
  * @prep_probes should execute required &struct damon_prep for next &struct
- * damon_probe applications to each region.
+ * damon_probe applications to each region.  It should also set
+ * &damon_region->sampling_addr of each region if ``set_samples`` is true.
  * @apply_probes should apply the data attribute probes to each region and
  * accordingly update the probe hits counter of the region.  It should also
  * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
'''

> 
> >   * @apply_probes should apply the data attribute probes to each region and
> >   * accordingly update the probe hits counter of the region.  It should also
> >   * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
> [ ... ]
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 127d3a7c27280..7ea42983d1276 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3878,6 +3891,8 @@ static int kdamond_fn(void *data)
> >  
> >  		if (!access_check_disabled && ctx->ops.prepare_access_checks)
> >  			ctx->ops.prepare_access_checks(ctx);
> 
> [Severity: High]
> Could the context's operations set change during kdamond_wait_activation()
> (called just before this), resulting in a NULL pointer dereference here?
> 
> The do_prep flag is cached before calling kdamond_wait_activation().
> 
> If the wait blocks, a user could update the context's operations to one that
> does not implement prep_probes (via kdamond_call() from a sysfs commit),
> making ctx->ops.prep_probes NULL.
> 
> When execution resumes, it would use the stale do_prep = true value and
> attempt to call the now-NULL ctx->ops.prep_probes(...).

Good finding!  I will move do_prep setup to be done after
kdamond_wait_activation().
> 
> [Severity: Medium]
> Also, does this silently ignore user-configured preparation actions?
> 
> If a user configures a probe with preparation actions, but the current
> operations set doesn't implement prep_probes, do_prep evaluates to false.
> 
> It appears the preparation actions are silently bypassed during execution
> without returning an error during context commit, such as in
> __damon_commit_ctx().
> 
> This could leave the user unaware that their configured actions are not
> being applied.

That's the intended behavior.

> 
> > +		if (do_prep)
> > +			ctx->ops.prep_probes(ctx, access_check_disabled);
> >  
> >  		kdamond_usleep(sample_interval);
> >  		ctx->passed_sample_intervals++;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=7


Thanks,
SJ
