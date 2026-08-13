Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CC2F5A0E
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594311; cv=none; b=Dmdam6E6QuJk09o53Q1mW6qRsJq1cZzW/YH8ZXE5w9Xn4VOU+xIh8Xym0pPskinuuOK0SONDrz8bj8xVm0sJF0N6MjesISHNFGwqcpm40kl5pwMXLYGb7+EVBqEA1kO9NCNSkoqbHXStBs5sSXE/G/jdIBOp2O7WVlVmje1AKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594311; c=relaxed/simple;
	bh=1kgwXxBhxLa22K6h6UN/o7PZ61SbjVKzZ8K2BWrp2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuXJIDdGjR+1gHO46w3Kx+EmHO9ehmbIn8s1g21nJH9knlyvY2QtSnw5+bF39OWLCx1ecSfFss4zd+Ed4M4rnHY27PhxoW+Qg8iT92JxTcb7AMYGil3eLEVBesug8WZ9/26+IygnB1cmH9abA0Itmf3FPN+vPqvU48bnpF73Ckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnEjhcHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnEjhcHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6271F000E9;
	Thu, 13 Aug 2026 04:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786594309;
	bh=xQMav8AnkZDUwteFSzoVifkt8JLjKy31rImBJ04Ggf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnEjhcHobxuFnzRgGwSftO25Eto9YBnLrYcR2XTJZj+U9AmQmZX0oztxD/tguEi5W
	 HBAFAVWqHUI+fc9vzcJKixdo1XVlpD7GUgbMPJK2A6hdlzJQ9rt+4k2PKncZ0sA8JA
	 SdpQ3sz+js+xhqbR9lmgxupfMhDhDcBilbAyCfIaST+6WqQPA7j2euBTG99FPm/Hka
	 5ignizikwcnjLij+KqDYvRSy6iPAgvMFb9Xg6MgR3srjqN5whHgx2tjGuf64qEEGk2
	 7AbkdTh5HBQGWTUb0bJUKt3V3XfsTZue0j9V/taqynMudz0UqgdAaaIx3UoiI91yQX
	 C4ZbF4GLxxWJw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/4] mm/damon/reclaim: remove unnecessary damon_call() param validation
Date: Wed, 12 Aug 2026 21:11:41 -0700
Message-ID: <20260813041142.98270-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813040141.2A72A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 04:01:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent invocation of `damon_call()` during kthread startup leads to an infinite kernel loop.
> --
> 
> --- Patch [3]: [RFC PATCH 3/4] mm/damon/reclaim: remove unnecessary damon_call() param validation ---
> commit 07f6c5438f6069b0b8225e26e3726d6aa4e3da09
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/reclaim: remove unnecessary damon_call() param validation
> 
> DAMON_RECLAIM avoids passing NULL or unstarted damon_ctx to damon_call()
> with its own validation. The validation is no longer needed, because
> the DAMON core layer now handles the corner cases itself. Remove the
> unnecessary check.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 45d5557cc575a..42a2c9cb13431 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> [ ... ]
> > @@ -293,10 +291,6 @@ static int damon_reclaim_commit_inputs_store(const char *val,
> >  	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	/* Skip damon_call() if ctx has not successfully started. */
> > -	if (!damon_reclaim_damon_has_started)
> > -		return -EINVAL;
> > -
> 
> [Severity: High]
> This is a pre-existing issue, but does removing this validation expose an
> infinite loop in the DAMON core?
> 
> If userspace writes to this sysfs file concurrently with damon_start(),
> damon_call() in mm/damon/core.c can hit a race condition. The core
> initializes ctx->call_controls_obsolete to true. If damon_call() runs
> before the kthread fully starts, it can read call_controls_obsolete == true
> and jump to the canceled label:
> 
> mm/damon/core.c:damon_call() {
>     ...
>     if (ctx->call_controls_obsolete) {
>         mutex_unlock(&ctx->call_controls_lock);
>         goto canceled;
>     }
>     ...
> canceled:
>     while (damon_is_running(ctx))
>         schedule_timeout_idle(msecs_to_jiffies(100));
>     return -ECANCELED;
> }
> 
> If damon_start() concurrently sets ctx->kdamond to non-NULL,
> damon_is_running(ctx) becomes true. Because the kthread has just started,
> it runs indefinitely, and damon_call() gets trapped in the while loop
> forever.

Because of the param_lock, that race is impossible.

> 
> >  	err = damon_call(ctx, &control);
> >  
> >  	return err ? err : control.return_code;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813035001.97364-1-sj@kernel.org?part=3


Thanks,
SJ
