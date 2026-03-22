Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5430E0F2;
	Sun, 22 Mar 2026 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774212700; cv=none; b=AEJAbgEtb4ponIOHbi368QQqGTMld5ZqlKmUNl9D073uzXKZIK/bk8xjHZ6CtnOKXcaSA5BC58cr0fKs90Fiki0sSdt2auAo8B4X7sy33OZL4ij4a9u9ZqVv3Mit82QGY48qc1Ev5YbLqd3v+Spx1mLtfNwkkZk2jLJvHXcaVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774212700; c=relaxed/simple;
	bh=v+JZu3qXNVA/S1bG8WB9r8Oz6NwO0tcGbFSffeOQTzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooej7vW5NRJQmYghxVBQUmiOjEmMIe5hPmJRCmC5NLbaxs5qXdwyfYtnFVtNhwuvP/LUA7CSvR2Km9vUzNiqJGhLHrcWCQZgwU1oil0H+bWOT8pQ/n+KH9DTrPGn0J5QX5i31m1BCa2xgb5fbFFFu/uVIEDNbkceKtvECZoKvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw63tztB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw63tztB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93881C19424;
	Sun, 22 Mar 2026 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774212699;
	bh=v+JZu3qXNVA/S1bG8WB9r8Oz6NwO0tcGbFSffeOQTzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bw63tztB5mqokQeZ2TQ6TDgQ4i0zunDVLTtd5npDG9dOE6JkAm8NmvH5a3DbIAQtj
	 SzA5CdTcLOxvx+90tqeYn6Kfhak7EOQB7EUPapY2FUo3mtHsnWMsOQrg9xp1Rln9Xf
	 s4NI7tvE8ho66tmEeWrR9Y9/jq2gWDAxyhp+bVH9mROWrdOmUqTRWfZeeM+/yXCN8f
	 ic55MSQlH6BTWwh+UsyYxREouYUYT+6oZEAxURvIWoRxBDZID8R3sv4ezMpAoe4A6i
	 CF/Rp3FLokntfAAFAAr5BHFPN5BCJwOFdBKigTQ6vyb72QNjgu6jq4gEQHRZbnUjbQ
	 3qfs6ZkevBUrQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sun, 22 Mar 2026 13:51:24 -0700
Message-ID: <20260322205125.88701-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322174018.83729-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 10:40:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 22 Mar 2026 10:06:59 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Forwarding Sashiko review for doing discussions via mails.
> > 
> > # review url: https://sashiko.dev/#/patchset/20260322155728.81434-2-sj@kernel.org
> > # start of sashiko.dev inline review
> > commit 2a3be2c8b6c327ef72163cd54e6121ef72b9c932
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/core: introduce damon_ctx->paused
> > 
> > DAMON supports only start and stop of the execution. When it is
> > stopped, its internal data that it self-trained goes away. It will be
> > useful if the execution can be paused and resumed with the previous
> > self-trained data.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index db6c67e52d2b..0ab2cfa848e6 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
> > >  		kdamond_call(ctx, false);
> > >  		if (ctx->maybe_corrupted)
> > >  			break;
> > > +		while (ctx->pause) {
> > > +			damos_walk_cancel(ctx);
> > 
> > Is it safe to repeatedly call damos_walk_cancel() here?
> > 
> > In damos_walk(), the walk_control_lock is dropped after setting
> > ctx->walk_control to check damon_is_running(), which opens a race window.
> > 
> > Concurrently, kdamond_fn() calls damos_walk_cancel(), which reads
> > ctx->walk_control, drops the lock, and completes the old request.
> > 
> > If a new caller invokes damos_walk() and successfully registers a new
> > walk_control, could damos_walk_cancel() resume, reacquire the lock,
> > and unconditionally set ctx->walk_control = NULL, dropping the new
> > request?
> > 
> > This might leave the new caller permanently deadlocked in
> > wait_for_completion().
> 
> Nice catch.  Orthogonal to this patch, though.
> 
> The deadlock could happen in below sequence.
> 
> CPU0                          │CPU1
> ──────────────────────────────┼────────────────────────
> damos_walk()                  │
>  │register request            │
>  │wait completion             │damos_walk_cancel()
>  │                            │ │complete the request
>  ▼wakeup,return               │ │
> damos_walk()                  │ │
>  │register new request        │ │
>  │                            │ │remove the new request
>  │wait completion             │ ▼return
>  ▼  nobody completes it.      │
> 
> Nonetheless, kdamond_fn() is calling damos_walk() already in several places
> including this loop.  This issue hence exists regardless of this patch.  I will
> work on fixing this as a separate hotfix.  Below fix may work.

TL; DR: there is no deadlock in existing code.  I will work on more clean code
or documentation, though.

The scenario that I illustrated above cannot happen, because the second
damos_walk() cannot register its new request before the old request is unset.

The request is unset in three places.  damos_walk_complete(),
damos_walk_cancel(), and damos_walk().  damos_walk_complete() and
damos_walk_cancel() are called from same kdamond thread, so no race between
them exists.

damos_walk() unsets the request, only if !damon_is_running().  damos_walk()
seeing !damon_is_running() means the kdamond is stopped.  It again means there
can be no concurrent damos_walk_cancel() or damos_walk_complete() that works
for same context and started before the damon_is_running() call.

Unless the same context is restarted, hence, there is no chance to race.  Only
DAMON_SYSFS calls damos_walk() and it doesn't restart same context.
DAMON_RECLAIM and DAMON_LRU_SORT do restart same context, but they don't use
damos_walk().  So, there is no deadlock in the existing code (or, no such
deadlock is found so far).

Let's assume there could be damos_walk() call with parallel restart of a DAMON
context, though.  In the case, below deadlock is available.  Seems this is what
Sashiko was trying to say.

0. A DAMON context is stopped.
1-1. CPU0: calls damos_walk() for the stopped context.
1-2. CPU0: damos_walk(): register a new damos_walk() request to the stopped
                         context.
1-3. CPU0: damos_walk(): shows !damon_is_running().
2.   CPU1: Re-start the DAMON context.
3-1. CPU2: Execute kdamond_fn() -> damos_walk_cancel()
3-2. CPU2: damos_walk_cancel(): complete the walk request that registered on
                                step 1-2.
4-1. CPU0: damos_walk(): unset the request.
4-2: CPU0: calls damos_walk() again.
4-3: CPU0: damos_walk() 2: register a new damos_walk() request.
4-4: CPU0: damos_walk() 2: wait for the completion.
5-1. CPU2: damos_walk_cancel(): unset the walk request that registered on step
                                4-3.

Nobody can complete the request that registered on step 4-3.  CPU0 infinitely
wait.

In more graphiscal way, this can be illustrated as below:

CPU0                           │CPU1             │CPU2                                    
───────────────────────────────┼─────────────────┼────────────────────────────────────────
damos_walk()                   │                 │                                        
   │register reqeust           │                 │                                        
   │show !damon_is_running(ctx)│                 │                                        
   │                           │                 │                                        
   │                           │damon_start(ctx) │                                        
   │                           │                 │damos_walk_cancel()                     
   │                           │                 │    complete first damos_walk() request 
   │                           │                 │                                        
   │unset request              │                 │                                        
   ▼return                     │                 │                                        
                               │                 │                                        
damos_walk()                   │                 │                                        
   │register request           │                 │                                        
   │wait completion            │                 │     unset second request               
   ▼                           │                 │                                        

As I mentioned abovely, this cannot happen on existing code, since there is no
code that restarts a terminated DAMON context, and calls damos_walk().  In the
future, there might be such use cases or mistakenly made call sequence, though.

I will work on improving this.  But, as I mentioned before, it is not a blocker
for this patch.


Thanks,
SJ

[...]
