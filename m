Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C39196C7C
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193702; cv=none; b=tBNBwDEoSwQ60NcXSuTVU5H0GC3ExSYkB/pst1p3IAjlKOLTg7l5Q0NIleOztxrcjc4tqC971XzBMYyw6k0GF7LDgBXsetMVb8PhuOdwXRaCUzHWQ40ZUNo64Kn8XNW2pAbP5rxPm4jZQ99Tg5eQttLUsXUfFgVlHqqzTy6qLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193702; c=relaxed/simple;
	bh=L33hFmTFwOygAqmx4KgnMPeBORkq0YEelSR3XfUbSQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOxaQhBI/N5cLI71aHI52fICJdnP8helcV5HpN1g6aS71Ta06vO0Ri6eIXbs/2kv2D7ZfS9bxQxocdAmu/v1SEvdjBHyLsTJAV4YRi8lAx0/+qr32VbIvkX+FCDZDiNTR265DqE4JIF1qDS81kcBtEAX4l1X2m+1jD1x7LKp7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joTI0ZzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joTI0ZzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF161F000E9;
	Sat,  4 Jul 2026 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193701;
	bh=rFdzYHwA5U37cfx3fRjs6HSweTPEzUEtm2tNn6HDPNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=joTI0ZzM86XDPSweI9WvaxIeJQjJ3a+Yn3v48lu4+2YIYmzx0FZxwaKukEODXcSMS
	 2uiRYaWfkfJfCLQsd1d+967BRBhkeFVUU0jwmKMfEGToD3+oQPGjx6XoBnJ/TUgkaj
	 S/QAMROkjo7Wx5+nIDSytm3Y8tNVd4Yrt020yIwGkH3aD0rIvuAwoKP9eZnrohvdM6
	 zcww8xu6PtNjALQH4CeNCDbl3pKRj8JoyJkoSo/t5g7SLjpAP0OJ6iauurMZpkFmLJ
	 LWceMbLAIZ2OK3RH0qLRYcfvrjWRYTj8tn5hcnDVDo/FYj5wyIhzw1rW76FFRl8d1C
	 iz9n3+K1UPlVQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 09/11] mm/damon/core: stop ctx in damon_call() before reruning an error
Date: Sat,  4 Jul 2026 12:34:52 -0700
Message-ID: <20260704193454.1094-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704182513.4D53B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 04 Jul 2026 18:25:12 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Concurrent invocations of `__damon_stop()` triggered by canceled `damon_call()`s lead to a double `kthread_stop()` deadlock.
> --
> 
> commit 5b208204f87a1b80335c35ce1b66a42e8f74a1ba
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: stop ctx in damon_call() before reruning an error
> 
> This commit updates damon_call() to ensure the DAMON context is explicitly
> stopped when a call fails or is canceled.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index aa48bf44c2a0b..9c15d44084af4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1956,8 +1958,13 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >  		return 0;
> >  	wait_for_completion(&control->completion);
> >  	if (control->canceled)
> > -		return -ECANCELED;
> > +		goto canceled;
> >  	return 0;
> > +
> > +canceled:
> > +	__damon_stop(ctx);
> 
> [Severity: High]
> Could this lead to a deadlock if multiple threads invoke damon_call()
> concurrently on the same context?
> 
> If multiple threads are waiting in damon_call() and the kthread exits, it
> cancels all pending controls and wakes the waiters. These threads will jump
> to the canceled label and call __damon_stop(ctx) concurrently.
> 
> Looking at __damon_stop(), it reads ctx->kdamond without clearing it:
> 
> static void __damon_stop(struct damon_ctx *ctx)
> {
> 	struct task_struct *tsk;
> 
> 	mutex_lock(&ctx->kdamond_lock);
> 	tsk = ctx->kdamond;
> 	if (tsk) {
> 		get_task_struct(tsk);
> 		mutex_unlock(&ctx->kdamond_lock);
> 		kthread_stop_put(tsk);
> 		return;
> 	}
> 	mutex_unlock(&ctx->kdamond_lock);
> }
> 
> Does this allow multiple threads to fetch the same task struct and call
> kthread_stop_put() concurrently? 
> 
> Since kthread_stop() waits on the kthread's exit completion which is
> signaled via complete() (waking only one waiter), would the subsequent
> threads block forever in kthread_stop(), causing a deadlock?

Good finding.  But there is no such parallel usage of damon_call() to my
understanding.

DAMON_SYSFS calls damon_call() for state file writes.  Multiple threads can
write the file in parallel.  But the damon_call() from store file write
callback (state_store()) is protected by global damon_sysfs_lock.

DAMON modules can call damon_call() for parameters commit and initial start.
But param file writing is protected by the param_lock.

This may be better to be documented or make the code more robust.  But no real
issue.

> 
> > +	return -ECANCELED;
> > +
> >  }
> >  
> >  /**
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260704181135.132956-1-sj@kernel.org?part=9


Thanks,
SJ
