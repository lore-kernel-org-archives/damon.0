Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36E10785
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783190603; cv=none; b=uw48Ni2AQN2BiiKY8ZWg6+3VUspNPc8eAUO7XiZ204IqovXT16peUCvTfEo2hqdH7gRLdaxuD+SLi2PD7LxUp2bvQmRHtvP5YR9fT2QrS/alMA9dhEsR52KkqvP28ay07pHK4ecLerxCkG+vSFomK6p9yvKQaRbzG+lVMwKCKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783190603; c=relaxed/simple;
	bh=xtxrmz/aovAL1DSBQCdwDnYQOI5eO+FFATWl0FbXYQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvMDMfaNr2dVGX58BQhwL/Q3n7GDhrRIdM92S8z77KQfR8RDuokTpI91MEsx+kZFyndVp7H/ejTVMGWu3P7F6j/Drdew3lDhmb9oc27jVgmbVArRxLuHqSCbXHeWkdkFm0IEGLz+OHKg6dNWtYbzSOddzCqVkXXgtqPso8B42Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpvH/Gnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpvH/Gnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E7A1F000E9;
	Sat,  4 Jul 2026 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783190602;
	bh=yMz4zziGl9MV/Fv3CiVBAjiz7zA08n970GFWVwWgCu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpvH/GnqpkvMnFGHL252xWlTCV5U7PnIpDh/PZbf8Sm5M7j2tMyd2jlPmuUhz6Jl2
	 O3JCp2oxJe0tsWNMMlej8c9WszKLUPx/KXlWrezGIseiiE5QMiZE71zJRupY87YESE
	 B73veFP0KXgNwweSNQH47Hn1hpWZ/fCmZO7r8C+P3/NoKEycOtiqQa0/tVWn75GcE6
	 jTbe51CW97yjrmZutWxt5OLHd89reOwzGX9UFIHhEzddZ6318L4897WEqdabt+uAoC
	 owvOv+4vtpi3RirXFRCGsKkA6XEECtTAxbJs7SDr41flhj/0Ym+K2+F5GJLOVIjteC
	 ZYHXiNVJe9N0Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 03/11] mm/damon/core: make damon_stop() never fails
Date: Sat,  4 Jul 2026 11:43:17 -0700
Message-ID: <20260704184318.136522-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704183003.219C81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:30:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] AB-BA deadlock in damon_start() error path when failing to start multiple contexts.
> --
> 
> commit c787674782fb673ed8c1babcfb03eca187f10a1d
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: make damon_stop() never fails
> 
> This commit modifies damon_stop() and __damon_stop() to return void instead
> of an error code. This simplifies the error handling in damon_stop() since
> it no longer needs to break out of the loop on failure.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 45aa9acef4e30..0845d6b151f81 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1865,31 +1863,24 @@ static int __damon_stop(struct damon_ctx *ctx)
> [ ... ]
> >  /**
> >   * damon_stop() - Stops the monitorings for a given group of contexts.
> >   * @ctxs:	an array of the pointers for contexts to stop monitoring
> >   * @nr_ctxs:	size of @ctxs
> > - *
> > - * Return: 0 on success, negative error code otherwise.
> >   */
> >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
> >  {
> > -	int i, err = 0;
> > +	int i;
> >  
> > -	for (i = 0; i < nr_ctxs; i++) {
> > +	for (i = 0; i < nr_ctxs; i++)
> >  		/* nr_running_ctxs is decremented in kdamond_fn */
> > -		err = __damon_stop(ctxs[i]);
> > -		if (err)
> > -			break;
> > -	}
> > -	return err;
> > +		__damon_stop(ctxs[i]);
> 
> [Severity: High]
> Does calling damon_stop() here result in an AB-BA deadlock during a partial
> startup failure?
> 
> While this issue was introduced by an earlier patch in the series, it remains
> present here. If damon_start() successfully starts the first context but fails
> to start a subsequent one, it calls damon_stop() while still holding
> damon_lock:
> 
> mm/damon/core.c:damon_start() {
>     ...
>     mutex_lock(&damon_lock);
>     ...
>     for (i = 0; i < nr_ctxs; i++) {
>         err = __damon_start(ctxs[i]);
>         if (err) {
>             damon_stop(ctxs, i);
>             break;
>         }
>         nr_running_ctxs++;
>     }
>     ...
>     mutex_unlock(&damon_lock);
> }
> 
> Inside damon_stop(), __damon_stop() calls kthread_stop_put(), which blocks
> waiting for the running kdamond thread to exit. However, kdamond_fn() must
> acquire damon_lock to decrement nr_running_ctxs before it can complete its
> exit:
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
> done:
>     ...
>     mutex_lock(&damon_lock);
>     nr_running_ctxs--;
>     ...
>     mutex_unlock(&damon_lock);
>     return 0;
> }
> 
> Can this cause damon_start() and the kdamond thread to deadlock waiting for
> each other?

Yes, I will fix damon_start() in the next revision.


Thanks,
SJ

[...]
