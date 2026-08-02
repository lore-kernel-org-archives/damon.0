Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AA2EA468
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785698176; cv=none; b=X4A9uRxMeMDg44GDbzmM5pBL46+U73CFdC44NtEux3dy3jRVquSIHBJqDw/yB4NcU5o4g0IfFUWvVm+ch1F03+JkQegXHk70R5WYwg157ZemirWoC1reBnkUh87HNpCHwG7IXa0nORfPkyDG4sdIdgg1m7Tw58wDz9odeBcOxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785698176; c=relaxed/simple;
	bh=qoPa123YAWINRZ+ntT4wZJChUC+bdRA0P3fJvLVgUR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrPIpHa5nzrWe4I9bFOC/aIS9ZFi3HUxLVbCnFPw0rh1/uQxrMZhEA1a8dkd+GfDGsS+YP+TsQvbGZEygWp5mUhc11E9GjHYs3+JJEmYI6agZpqL1xjzEtiHpmiUk9RjQ4UmT68Qg5P4iYC+jpuzBUEAFkDDpSD5fJp3Xkx2S9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV14Fgws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV14Fgws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525351F000E9;
	Sun,  2 Aug 2026 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785698175;
	bh=gUiU9z5GWd0zxwu9BEnqJqR53jqSabHNtFT9OOiTueM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IV14FgwsVNCcuygzmYqMiXxEMLELpt8j+hLPEKY3cy7IKo+x8QaieXSqhjyvBmBll
	 ZiZ6xmqwgzqgzup6w1cG8DK+xwKmWzyYect1/YZNCI6jvLR4q4PXqZ/tAWyDxWYjq6
	 r77uzW87bf6glOUdZeJ0b8X2U8cOmAvfNMkCkObIIneiK0vrTlyJm0Fkd7/Wr2dmDd
	 vXwnAn02PalVPUQX4CLz6vg/1GBtA40UbjSdnJtsIqw4tnJbrcA2s+gflLq0wTB1W+
	 S/9+Y/HR8fwPd5+hXmvjX96YBaHqQShubyQv1HlGTKhiHYDE8jrkbqf4htDFa0oyKG
	 qQWfGOiNIG33g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mm/damon/lru_sort: skip damon_call() if ctx has not started
Date: Sun,  2 Aug 2026 12:16:05 -0700
Message-ID: <20260802191607.10845-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802190838.015EB1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 19:08:37 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] A TOCTOU race between `damon_start()` and `damon_call()` can cause `damon_call()` to loop indefinitely.
> --
> 
> --- Patch [2]: [RFC PATCH 2/2] mm/damon/lru_sort: skip damon_call() if ctx has not started ---
> commit 9a410362ed5a4418640b6bf73c4ee49300c9dc16
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/lru_sort: skip damon_call() if ctx has not started
> 
> This commit prevents damon_call() from hanging when the DAMON context is
> initialized but not yet started. It introduces a boolean flag to track whether
> the context has ever successfully started, and skips the call if it has not.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 7e077084cb03a..7df45f9a0b3ae 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> [ ... ]
> > @@ -364,11 +366,8 @@ static int damon_lru_sort_commit_inputs_store(const char *val,
> >  	if (!commit_inputs_request)
> >  		return 0;
> >  
> > -	/*
> > -	 * Skip damon_call() if ctx is not initialized to avoid
> > -	 * NULL pointer dereference.
> > -	 */
> > -	if (!ctx)
> > +	/* Skip damon_call() if ctx has not successfully started. */
> > +	if (!damon_lru_sort_damon_has_started)
> >  		return -EINVAL;
> >  
> >  	err = damon_call(ctx, &control);
> 
> [Severity: High]
> This is a pre-existing issue, but could there be a TOCTOU race here between
> damon_start() and damon_call() that causes damon_call() to loop indefinitely?
> 
> If a user starts DAMON (setting damon_lru_sort_damon_has_started = true),
> stops it (leaving call_controls_obsolete = true), and then concurrently
> starts DAMON again while calling damon_call() via commit_inputs, can
> damon_call() get stuck?

There is no such concurrent calls.

> 
> Looking at mm/damon/core.c, __damon_start() sets ctx->kdamond before the new
> thread clears ctx->call_controls_obsolete:
> 
> mm/damon/core.c:__damon_start() {
>     ...
>     ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d", nr_running_ctxs);
>     ...
> }
> 
> If damon_call() runs concurrently, it checks call_controls_obsolete without
> holding kdamond_lock, sees the stale true value, and jumps to the canceled
> label:
> 
> mm/damon/core.c:damon_call() {
>     ...
>     if (ctx->call_controls_obsolete) {
>         ...
>         goto canceled;
>     }
>     ...
> canceled:
>     while (damon_is_running(ctx))
>         schedule_timeout_idle(msecs_to_jiffies(100));
>     return -ECANCELED;
> }
> 
> Since damon_is_running() returns true (because ctx->kdamond is set), and the
> new healthy thread will run indefinitely, will this task loop forever in
> TASK_IDLE?

So the issue cannot happen in real.  But good point.  Maybe the API or the
documentation can be safer.  I will add this to my TODO list.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802185430.9940-1-sj@kernel.org?part=2


Thanks,
SJ
