Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AB2609DC
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006670; cv=none; b=GUSMjVa+urAse0l2j+rJq2o0kYroQR1scQQjw2ScVZuLks1ZnTkWkqlGoMluLgyDNygSruKRzQqKoeZWJuupy28xJGx18CWvtvQ2K5IGYQupbi5AIcj/1JSxCdOGZ+m4qFGZXXsMC2j1mnMtnY8meUBYG2YB7OB+hyn3ui2078Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006670; c=relaxed/simple;
	bh=YRD6SBhL8RFbYN6prTxOhdZb3eYyfArbtM+TmdXLaQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqv9JMICjbhuvtkSGrCA3hXQVyInenD41t1MJ6hsdAX7Hzcbd7N7wDHtWQ8pL/YkXj33Kq/mbOz5hg/uLUQrFKnuzYHt+JQnoUYQFHE3Qr4lBjPFJXKhKBWQcF/8wtJB0Bd9p4b0lwkEKdxJbCesX/Nd49/1auAmXHzphfwHJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwC+x4ru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwC+x4ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235E5C19423;
	Wed,  1 Apr 2026 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775006670;
	bh=YRD6SBhL8RFbYN6prTxOhdZb3eYyfArbtM+TmdXLaQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwC+x4ruefQNTi89jR1AoNqkmYryULMg29ZFfkYkd/987EGL4Nvat2caeyp6tVDMB
	 3grSbN7cPA/G8pmNkEFZG/3lZqpK0F4IBpi8cNQJVWgc/XVW/8av2YRnCNhPJDbxJS
	 fpOxIB31EHAd034nI/0vkbJkz8cyFJckLBzaR/1h5samuTP99zh71yB7YBhVfWU9ek
	 b/XofHQtaKAIDxPboCU2HwA+DXgeHBt0qBwv4ZdVNwMX1sMDegSKRzx0S+G/sw+GZ4
	 R/qi7tAvUj+HUy9kd2bnHW44sXIdpYo1Fe6NDMZKjodXkFhzNFYicMzKzgIMWiH2NK
	 m5VCx1zma/JHw==
From: SeongJae Park <sj@kernel.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: (sashiko review) [PATCH] mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()
Date: Tue, 31 Mar 2026 18:24:28 -0700
Message-ID: <20260401012428.86694-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331101553.88422-1-liu.yun@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails, in form of reply,
and adding my comments inline.

TL; DR: No blocker for this patch.

The first one is nice finding but orthogonal to this patch (I start feeling
sashiko might be useful at finding potential bugs in existing code, like static
code analysis tools, more than reviewing patches).

The second one is just wrong.

> # review url: https://sashiko.dev/#/patchset/20260331101553.88422-1-liu.yun@linux.dev
> # start of sashiko.dev inline review
> commit 386810f9b0a1ae341b87a984b16b2a2e1bafab71
> Author: Jackie Liu <liuyun01@kylinos.cn>
> 
> mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()
> 
> This commit fixes a memory leak by destroying the DAMON context and resetting
> the global pointer when damon_start() fails. This ensures the previously
> allocated context is not permanently lost on subsequent enable attempts.
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -249,8 +249,11 @@ static int damon_stat_start(void)
> >  	if (!damon_stat_context)
> >  		return -ENOMEM;
> >  	err = damon_start(&damon_stat_context, 1, true);
> > -	if (err)
> > +	if (err) {
> > +		damon_destroy_ctx(damon_stat_context);
> > +		damon_stat_context = NULL;
> >  		return err;
> > +	}
> >  
> >  	damon_stat_last_refresh_jiffies = jiffies;
> >  	call_control.data = damon_stat_context;
> 
> Does this code still leak the context if the subsequent call to damon_call()
> fails?
> 
> If the newly spawned kdamond thread exits before the call gets processed (such
> as due to an internal allocation failure for regions_score_histogram in
> kdamond_fn()), damon_call() can return an error like -EINVAL or -ECANCELED.
> 
> When damon_stat_start() returns this error to its caller, the caller resets
> enabled = false and propagates the error, skipping damon_stat_stop().
> 
> Consequently, damon_stat_context is never destroyed, nor is the global
> pointer reset to NULL. The next time the module is enabled,
> damon_stat_start() overwrites damon_stat_context with a new context,
> permanently leaking the previously allocated struct damon_ctx.
> 
> To completely fix the memory leak, should the return value of damon_call() be
> checked and cleaned up similarly to the damon_start() error path?

This is correct, but orthogonal to this patch.  I will work on this.

> 
> This isn't a bug introduced by this patch, but is there a race condition
> between damon_stat_init() and the sysfs module parameter setter
> damon_stat_enabled_store()?
> 
> For loadable modules, sysfs parameter files are exposed to userspace before
> the module's init function completes. If the module is loaded with the
> parameter enabled=1, damon_stat_init() will begin executing
> damon_stat_start(), which allocates damon_stat_context.

This is not correct.  damon_initialized() check in the middle is there for
avoiding this.


Thanks,
SJ

> 
> Concurrently, if a userspace process writes 0 to the sysfs enabled
> parameter, this triggers damon_stat_enabled_store(), which sets
> enabled = false and immediately calls damon_stat_stop().
> 
> Because damon_stat_init() does not hold the kernel_param_lock, there is
> no mutual exclusion between these execution paths. damon_stat_stop()
> calls damon_destroy_ctx(), which frees the newly allocated
> damon_stat_context.
> 
> The damon_stat_start() function (still executing in the init thread)
> then proceeds to call damon_start(&damon_stat_context, 1, true),
> dereferencing the freed context pointer and causing a use-after-free.
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260331101553.88422-1-liu.yun@linux.dev
> #
> # hkml [1] generated a draft of this mail.  It can be regenerated
> # using below command:
> #
> #     hkml patch sashiko_dev --for_forwarding \
> #             20260331101553.88422-1-liu.yun@linux.dev
> #
> # [1] https://github.com/sjp38/hackermail
