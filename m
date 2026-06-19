Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B927FB3A
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900710; cv=none; b=iTq1JksXL6KhDvitTUDXqMOkap926A0ftpmGCDembHTAeBrnLqJneFKI5vBAuY+9VBQ506A8ImDIvFN4LuhRP99fMT8UTnD5eGOsqrDbuipnLZmh4qrUGaLMUIsN7HxBrfXpffM3ZPs5SrhyaxvRHUkwVRSgIH+GIMWvqeg30VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900710; c=relaxed/simple;
	bh=uMre8swghLu8d+Qoe0ahhSCPnp13VF2kHQwD79Yt7A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkMcWFJSqBD36+6710pW0PIUxIlS9S23KPZsn8dUTb11G5eBxaIdOMWpehZJPuvneV/C7WLGMWvzLRMgYIr23KHQYLrYHx6kXJA2PLROagfHUfETEjWLlpvl1Ok40FMa1h1Q92F9/A4xMqScSqs8WodqpRqC6F/RvPdlx0p/BAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4aWymP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4aWymP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4B21F000E9;
	Fri, 19 Jun 2026 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781900708;
	bh=thy8jZ3yM0J1UyO7LkckRCgP/p1vi17Fg45pFAevc5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4aWymP0qFMhxAUk4kjFojKvNhwsiRL37lgUvrpqHBFR/6/2YM02hUUJUCSZZfk+K
	 gwl43SC17Du/ZE/Zn5ilNG2cCQ3Zg+sWuqjByU1RTwDL2i6qCmCn8mwEquoP4LG9hM
	 w47tRBMv38M1N4JB+3AXo7qw5r9myb1dZJ/0Dw98AFy44xcNDI6EqDJkWYKk419NJO
	 oCR9DegT2t+U0T262c2x07J7NKtofRgfaxkas4/Tt6ikpJb3lKE2OInZMB8Thl6ZYz
	 BU3AUfSbA/y8d7FXxSlaYnNYGsRh7h3WCKijQYbO85g08WjtGgbKd6VmHx1QFio8ti
	 cmwf6ehr8QIVA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 09/13] mm/damon/tests/core-kunit: remove nr_accesses_bp setup and tests
Date: Fri, 19 Jun 2026 13:24:59 -0700
Message-ID: <20260619202459.145010-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619195232.61C9B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:52:31 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Divide-by-zero in `damon_nr_accesses_mvsum()` when `aggr_interval` is 0.
> 
> Pre-existing issues:
> - [High] Divide-by-zero in `damon_max_nr_accesses()` when `sample_interval` is 0.
> --
> 
> commit 6519e9a3b09dd0793b79fa00b085d57ba68bc353
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: remove nr_accesses_bp setup and tests
>     
> DAMON core unit tests set up nr_accesses_bp for representing realistic
> damon_region, and also test the field.  nr_acceses_bp is no longer being
> used for a real use case.  Remove the setup and tests.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -210,6 +210,61 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> [ ... ]
> > +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> > +		struct damon_ctx *ctx)
> > +{
> > +	unsigned long sample_interval, window_len, left_window, left_window_bp;
> > +
> > +	sample_interval = ctx->attrs.sample_interval ? : 1;
> > +	window_len = ctx->attrs.aggr_interval / sample_interval;
> > +	left_window = ctx->next_aggregation_sis - ctx->passed_sample_intervals;
> > +	left_window_bp = mult_frac(left_window, 10000, window_len);
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: High]
> If `ctx->attrs.aggr_interval` is 0, `window_len` evaluates to 0.
> 
> Since `damon_set_attrs()` accepts configurations where both `sample_us` and
> `aggr_us` are 0, does this lead to a divide-by-zero here?
> 
> When the kdamond thread evaluates user-defined schemes, it appears to
> unconditionally call __damos_valid_target() -> damon_nr_accesses_mvsum().
> 
> Could this regression be triggered via the DAMON sysfs interface to cause
> a crash?

Yes, I will fix this in the next revision.

> 
> > +
> > +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> > +			left_window_bp);
> > +}
> 
> include/linux/damon.h:damon_max_nr_accesses() {
>     ...
>     static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
>     {
>         /* {aggr,sample}_interval are unsigned long, hence could overflow */
>         return min(attrs->aggr_interval / attrs->sample_interval,
>                 (unsigned long)UINT_MAX);
>     }
>     ...
> }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but there is a pre-existing
> divide-by-zero risk if `sample_interval` is 0.
> 
> Does this calculation cause an immediate divide-by-zero exception?
> 
> Userspace can configure `sample_us` to 0 via sysfs, which avoids validation
> in `damon_set_attrs()` if `aggr_us` is also 0.
> 
> Since `damon_get_scheme_score()` unconditionally invokes
> `damon_max_nr_accesses()` when evaluating user-defined schemes, could this
> allow a user to intentionally crash the kernel?

Nice finding.  I will separately fix this.


Thanks,
SJ

[...]
