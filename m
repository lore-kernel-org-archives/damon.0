Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28097175A80
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978850; cv=none; b=LKxeiD6fx082KJtVV8wam+r5PLsp0QxL4P+F+kYL+vhskREnGqGMbuV7o+G1nAgitid+ehFmOU0TrJsgubrIWMt80U5ysSroVTEip5VLjy9YQCsrqDBOtOiNDGexxB3MMxsVAzQS9dLh0nCLXeq+WiAbKz9wKQdI+puRKSUTOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978850; c=relaxed/simple;
	bh=hIcu0iLXol/6zSi54xAPWNvhP7Dv3YO690AVnXiqZWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oral5ZedB++yveCZWwd5UH9hVBoVviZyjrPhc83yj9QqKsiJeTRGOERYozUQLf5ojYeppPlI9wRW1XskQGtdzDGPS+mPjqJTqkMXubbb9VL7OjuZZYBmEePUJlCqn6eMoBXXj9DJ2Mqu7OPjq1X8YMSWSUKnJw9WuGcM/YA1J9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhLmZLaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhLmZLaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6391F000E9;
	Sat, 20 Jun 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781978848;
	bh=9wMcVdToENKD+EaJUbGh0uOv/AsAAJ6x7tErndPY6YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhLmZLajxqXw6IMg61l+5+QWIMVR7qCUJBBCbXCRH/6PJBDieSCas2lnBcviwJRsP
	 XtZywQeQwMa9701o0v+5AdpA6Ao0k2UdhNjoPRjzTMi85X2PEwOZXOO+JSDbXBrVLs
	 uNbUkyxJDRZyHqKtH7wHals/IBS40n5Tt1ma0B7dN+InUEckx0zhlTIn32l/xsuY+W
	 Nk1A78eXRI5kpTMshX3kXUrIHgm8ELC1NZylheO9cmyOaPFmLoypa5z5QQiZfTeKjN
	 q/3lLYl6KJCjY+GpTDYNpy/5g7+qAnx0hLK0Q0yfvaLHC8OxZeEcT7I9vD4x6ZS5Y5
	 Ux9qpXwD1OPdQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 03/13] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Sat, 20 Jun 2026 11:07:19 -0700
Message-ID: <20260620180720.93325-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620174137.53EFB1F00A3E@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 17:41:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The new __damos_valid_target implementation uses damon_nr_accesses_mvsum(), which is vulnerable to time-of-check state desynchronization if ctx->next_aggregation_sis is updated asynchronously via kdamond_call(). This causes massive over-estimation of the target access frequency.
> --
> 
> commit 2274522ec6ea648db508697b0a1f57a8bf4e864d
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
> 
> This commit replaces the direct read of r->nr_accesses_bp with a call
> to damon_nr_accesses_mvsum() inside __damos_valid_target(). The author
> notes that while execution is slightly more expensive, the function is
> simpler and more tolerant to errors.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index af95783d3402a..ee4f0f0e583bd 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2120,10 +2120,11 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
> >  	damon_set_attrs(c, &new_attrs);
> >  }
> >  
> > -static bool __damos_valid_target(struct damon_region *r, struct damos *s)
> > +static bool __damos_valid_target(struct damon_region *r, struct damos *s,
> > +		struct damon_ctx *c)
> >  {
> >  	unsigned long sz;
> > -	unsigned int nr_accesses = r->nr_accesses_bp / 10000;
> > +	unsigned int nr_accesses = damon_nr_accesses_mvsum(r, c);
> 
> [Severity: High]
> Could this lead to double-counting access scores if the context attributes
> are updated asynchronously?
> 
> In kdamond_fn(), when an aggregation interval finishes, pending API requests
> are processed via kdamond_call(ctx, false) right before
> kdamond_apply_schemes() is called. If a processed request triggers
> damon_set_attrs() (e.g., via sysfs), ctx->next_aggregation_sis is eagerly
> advanced to the end of the newly configured interval.
> 
> When __damos_valid_target() subsequently calls damon_nr_accesses_mvsum(),
> it calculates the time window based on ctx->next_aggregation_sis:
> 
> mm/damon/core.c:damon_nr_accesses_mvsum() {
>     left_window = ctx->next_aggregation_sis - ctx->passed_sample_intervals;
>     left_window_bp = mult_frac(left_window, 10000, window_len);
>     return damon_mvsum(r->nr_accesses, r->last_nr_accesses, left_window_bp);
> }
> 
> Because ctx->next_aggregation_sis was just advanced, left_window equals the
> full new window length, resulting in a left_window_bp of 10000.
> 
> Since damon_mvsum() assumes it is at the start of the window, it will add
> the unscaled r->last_nr_accesses to the current r->nr_accesses. Because the
> aggregation interval just finished, r->nr_accesses already holds the
> fully-accumulated access count. Adding last_nr_accesses effectively doubles
> the access score and could misclassify regions during target validation.
> 
> The pre-patch code avoided this by safely reading the decoupled
> r->nr_accesses_bp, which preserved the correct scaled value across
> kdamond_call() boundary transitions.

Nice finding.  This should be a minor impact that persists for only one
aggregation interval, but I think the issue is bettter to not introduced.  I
will scale r->last_nr_accesses together to avoid this issue in the next
revision.


Thanks,
SJ

[...]
