Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818292D2496;
	Sun, 22 Mar 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774201225; cv=none; b=qlqEatBRe4uZ5ZYzJyC5CxaZf2YKhKqX2vV8G5ohayxwD/O3A/IW9Pz5LVIDeRNf2uH6F9xiNeBpRYZIWnf5pqaLqTMW6VmBoVqQLeHdcwGbcV0kPQNF0dQ27BOLahXVycOTqI8rnEN5T23FufmUV+PYbHQ/Vwgok940OPYSTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774201225; c=relaxed/simple;
	bh=t1kmCjtJgBoqc5PGMnOUBWW1n3gt6R1pJatljm8Xo5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2PcR2ZAJN4wM1gAsAdcVrOgxI48yt/ZZ7spoQ9LBbeo1eeVMX4fwWc+nKTZkn2Fnveo3zuSAGbD8XNmZsCIfXO/8olVBTC3KjcmQ02LRKdmp3bxClgH5a6ZC26x160pvXGUoyuZr2o9N+iZwHlVamblZJXRERMQ/63cHGXFhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ4Cel6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ4Cel6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A8C19424;
	Sun, 22 Mar 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774201225;
	bh=t1kmCjtJgBoqc5PGMnOUBWW1n3gt6R1pJatljm8Xo5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQ4Cel6CZjAb6jCoyMoJdsoWtXwH1HECSI5Fldc6qTvmsclGT0FN1w4Xya6STcLF9
	 vGRco51ydJMZq8iri3WweLfPiKdGfZSE2ZJmr9uWAONMMAM2Wj3aZfUxtd8HqYzbRX
	 6D2dm0Xi8QsRIqgoqNPDiDRpK+MZeELGNV7uKTZ9VR2tPnLmtIlVxuTPzjXKvn1wRE
	 SV8GwCYIpQTrLAu4qdWyQz6uCORu3eRLAI1iqAdXgntxc4D9qLeqqTRi8l4P/tQPik
	 9jCvOAmll1Zzqheby51ACgIBrJg8wBErQ6fuheIywnPDfscMYtXiY4WO5XkpuTfeL5
	 kPciwjYOdThlg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sun, 22 Mar 2026 10:40:16 -0700
Message-ID: <20260322174018.83729-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322170700.83123-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 10:06:59 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260322155728.81434-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 2a3be2c8b6c327ef72163cd54e6121ef72b9c932
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_ctx->paused
> 
> DAMON supports only start and stop of the execution. When it is
> stopped, its internal data that it self-trained goes away. It will be
> useful if the execution can be paused and resumed with the previous
> self-trained data.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..0ab2cfa848e6 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
> >  		kdamond_call(ctx, false);
> >  		if (ctx->maybe_corrupted)
> >  			break;
> > +		while (ctx->pause) {
> > +			damos_walk_cancel(ctx);
> 
> Is it safe to repeatedly call damos_walk_cancel() here?
> 
> In damos_walk(), the walk_control_lock is dropped after setting
> ctx->walk_control to check damon_is_running(), which opens a race window.
> 
> Concurrently, kdamond_fn() calls damos_walk_cancel(), which reads
> ctx->walk_control, drops the lock, and completes the old request.
> 
> If a new caller invokes damos_walk() and successfully registers a new
> walk_control, could damos_walk_cancel() resume, reacquire the lock,
> and unconditionally set ctx->walk_control = NULL, dropping the new
> request?
> 
> This might leave the new caller permanently deadlocked in
> wait_for_completion().

Nice catch.  Orthogonal to this patch, though.

The deadlock could happen in below sequence.

CPU0                          │CPU1
──────────────────────────────┼────────────────────────
damos_walk()                  │
 │register request            │
 │wait completion             │damos_walk_cancel()
 │                            │ │complete the request
 ▼wakeup,return               │ │
damos_walk()                  │ │
 │register new request        │ │
 │                            │ │remove the new request
 │wait completion             │ ▼return
 ▼  nobody completes it.      │

Nonetheless, kdamond_fn() is calling damos_walk() already in several places
including this loop.  This issue hence exists regardless of this patch.  I will
work on fixing this as a separate hotfix.  Below fix may work.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2321,7 +2321,9 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
        control->canceled = true;
        complete(&control->completion);
        mutex_lock(&ctx->walk_control_lock);
-       ctx->walk_control = NULL;
+       /* A new damos_walk() caller could added a new request meanwhile */
+       if (ctx->walk_control == control)
+               ctx->walk_control = NULL;
        mutex_unlock(&ctx->walk_control_lock);
 }
'''


> 
> > +			kdamond_usleep(ctx->attrs.sample_interval);
> 
> Could this result in a busy loop if sample_interval is 0?
> 
> The DAMON API allows attrs.sample_interval to be 0 (for example, when
> tuning is disabled via goal.aggrs == 0).
> 
> If sample_interval is 0, this invokes usleep_range_idle(0, 1), which
> sleeps for at most 1 microsecond using an hrtimer.
> 
> Since the normally expensive monitoring operations are bypassed while
> paused, would this cause the thread to loop almost instantly and create
> an interrupt storm?

This is an intended behavior for users who really impatient.  So this should be
fine.


Thanks,
SJ

[...]
