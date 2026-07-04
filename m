Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881192264CA
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194457; cv=none; b=TVfM8yy+1x/44XvH/W2FccpA8uIFHD+aoaoOB9nshfMo6aSNCeFKyE+jDPAlsDYbmAha+hRav65f+5IaQJl2HpsLw8XKy3wSYI1UuX9yCqHm4fVT0sxGTAntv3hDjz2wDwBxEGRBXyL/2FUBEMp6UNpJNUnx4hhmqeGQcR9/w3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194457; c=relaxed/simple;
	bh=wGoXEIgdEr+3n9V0qbB+LDO0s30F44rxtnukS+two2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTLAguwtIQvMiKwXKPK7iWA0tCyNmWBxa+j4Q2t2fRjMiHy1nYfHXkmXSEtbTwJOFdNZXzoCja920lRozHK1HWsxPv2yYZBNN2KeZM+aIzT494EhpWe6ewVpejd2ch1lRC3swxRfNtf/3nkVuDIy9t75tR8DRvFKzVx2JOSwOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=codo9cia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="codo9cia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B531F000E9;
	Sat,  4 Jul 2026 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194456;
	bh=lrVkKkb7EyzN3CXUWiwVUd7Ee+mLfQWrm6nTtgaceZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=codo9ciawtVOWY7lPdXmOqi8HuCYirQLrhEgL/kX7eAjs1ls7dKydM13RPDTaDTb8
	 qYFPmEU8126JXajOSNBAUXXePY+ufWch3sC1aXFvaRDhob4Ap/1sVjqnT3YArW38dg
	 CxEEyLW5ydnw4a/DlnCTETzSazXgDBkKS0Ewgxv/QPuWPS3WavYYtuJMnk54QFq9zE
	 KwgCB2IE4D4XEmEkB9vbnM99vmNJii50uesAqV2VHQOXT2ZtN8jUq00WgtkE6ekqVF
	 neC/kMt+r+Wx5xGEGUTDWb19EoiT9/rbPYBDqX/z3DCOJdWvLDIrpeLSUnknOQ1ayX
	 bO/uwINQtl1qg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 09/11] mm/damon/core: stop ctx in damon_call() before reruning an error
Date: Sat,  4 Jul 2026 12:47:26 -0700
Message-ID: <20260704194727.1762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704193454.1094-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 12:35:01 -0700 SJ Park <sj@kernel.org> wrote:

> On Sat, 04 Jul 2026 18:25:12 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Concurrent invocations of `__damon_stop()` triggered by canceled `damon_call()`s lead to a double `kthread_stop()` deadlock.
> > --
> > 
> > commit 5b208204f87a1b80335c35ce1b66a42e8f74a1ba
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/core: stop ctx in damon_call() before reruning an error
> > 
> > This commit updates damon_call() to ensure the DAMON context is explicitly
> > stopped when a call fails or is canceled.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index aa48bf44c2a0b..9c15d44084af4 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > [ ... ]
> > > @@ -1956,8 +1958,13 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> > >  		return 0;
> > >  	wait_for_completion(&control->completion);
> > >  	if (control->canceled)
> > > -		return -ECANCELED;
> > > +		goto canceled;
> > >  	return 0;
> > > +
> > > +canceled:
> > > +	__damon_stop(ctx);
> > 
> > [Severity: High]
> > Could this lead to a deadlock if multiple threads invoke damon_call()
> > concurrently on the same context?
> > 
> > If multiple threads are waiting in damon_call() and the kthread exits, it
> > cancels all pending controls and wakes the waiters. These threads will jump
> > to the canceled label and call __damon_stop(ctx) concurrently.
> > 
> > Looking at __damon_stop(), it reads ctx->kdamond without clearing it:
> > 
> > static void __damon_stop(struct damon_ctx *ctx)
> > {
> > 	struct task_struct *tsk;
> > 
> > 	mutex_lock(&ctx->kdamond_lock);
> > 	tsk = ctx->kdamond;
> > 	if (tsk) {
> > 		get_task_struct(tsk);
> > 		mutex_unlock(&ctx->kdamond_lock);
> > 		kthread_stop_put(tsk);
> > 		return;
> > 	}
> > 	mutex_unlock(&ctx->kdamond_lock);
> > }
> > 
> > Does this allow multiple threads to fetch the same task struct and call
> > kthread_stop_put() concurrently? 
> > 
> > Since kthread_stop() waits on the kthread's exit completion which is
> > signaled via complete() (waking only one waiter), would the subsequent
> > threads block forever in kthread_stop(), causing a deadlock?
> 
> Good finding.  But there is no such parallel usage of damon_call() to my
> understanding.
> 
> DAMON_SYSFS calls damon_call() for state file writes.  Multiple threads can
> write the file in parallel.  But the damon_call() from store file write
> callback (state_store()) is protected by global damon_sysfs_lock.
> 
> DAMON modules can call damon_call() for parameters commit and initial start.
> But param file writing is protected by the param_lock.
> 
> This may be better to be documented or make the code more robust.

damon_call() is designed for multiple callers, so this is quite confusing.  I
will make it less confusing like below in the next revision.

"""
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2309,7 +2309,8 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
        return 0;

 canceled:
-       __damon_stop(ctx);
+       while (damon_is_running(ctx))
+               schedule_timeout_idle(msecs_to_jiffies(100));
        return -ECANCELED;

 }
"""


Thanks,
SJ
