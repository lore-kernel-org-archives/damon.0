Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6828F5
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782076392; cv=none; b=USihXjIDo7ps7yurT0YJdmoXg+7vHgaPcEZrgi03EosWiMts94R3GjvYbJOq2M3l/6GBzimEOT7VJn0aNklJyXF2+QbO+vJ+SCqMwaeKw5tG46NKUEMnWIuNiSzCTyHnYF9n7ZbMV8GxcJLFZPsbolHaRQdYUgt/wqE/d3aRKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782076392; c=relaxed/simple;
	bh=7YHaGNn32mivUJyVuYiRaCiOe1Uge7i1aa2NtWA/234=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgvQ6TuUwpy1X22DaCzIAMEfGH5vnWgRQNjE+oW/oGUKNcOw7b3l9nQShVJVjGo/qBkDENWiTTiBvsC+SzQmJb78c/pKt4jn73PQJtT8D1mQwTv9txd/H6UNrWZns07GnXkrU6DR69e5ikniPV2ULa2PRrSI/8dRkie/DJlgdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEqHhHAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEqHhHAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E394E1F000E9;
	Sun, 21 Jun 2026 21:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782076391;
	bh=7xGzaie8MWSH+abn5nNJwhVaCPyqEJ/glRN0vASJx2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEqHhHAosXzg+tw//mjhvRAE925rwGHU/I16fM+FAsKvlfR7b30cwADGIIiwTsuwa
	 m7hPZH4N6HVN9xVe/tiVEbnP8mebiE1KVWedThrv8H5eEJEtH/wof4ztKkJEuIEd+f
	 QXXSdRmGH1uGymggM/ibd/hGGzlw+w0F7dueS4iC7gVDtjlnCS8vfg7AXaGNjDLvyp
	 jIfPAyMHuI53uzbYC6b0STVnxDqnGqYpH/76hTUqj/IsfMUBAaUHgxEZ1Xaz00blGz
	 7LmJxtnUtIoo+H0VN7HyVoP/XVqT/tj/bpzEA1usbaW0tUPehvm6+8rF3y3Pe+oSgb
	 ddgr6RWObuJuw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 03/17] mm/damon/core: always update ->last_nr_accesses for intervals change
Date: Sun, 21 Jun 2026 14:13:02 -0700
Message-ID: <20260621211302.11854-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621202307.10276-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 13:23:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 21 Jun 2026 16:11:04 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Arithmetic overflow in DAMON access scaling functions when interval ratio is large.
> > - [High] The patch attempts to fix a 'wrong value' returned by `damon_nr_accesses_mvsum()`, but misdiagnoses the root cause and leaves a major double-counting bug unresolved.
> > --
> > 
> > commit 6636564dd42488eb260d7102569887a00bdd3d71
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/core: always update ->last_nr_accesses for intervals change
> > 
> > This commit modifies damon_update_monitoring_result() to unconditionally
> > update last_nr_accesses when aggregation intervals change. It aims to
> > prevent incorrect calculations in damon_nr_accesses_mvsum() that could occur
> > if called with a stale last_nr_accesses value alongside a fresh aggregation
> > timestamp.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index addd14e4e70bf..bc40a6d10f277 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -873,6 +873,8 @@ static void damon_update_monitoring_result(struct damon_region *r,
> > >  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> > >  		bool aggregating)
> > >  {
> > > +	r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
> > > +			r->last_nr_accesses, old_attrs, new_attrs);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does this scaling trigger an arithmetic
> > overflow when the interval ratio is large?
> > 
> > When damon_nr_accesses_for_new_attrs() is called, it performs 32-bit
> > arithmetic in damon_nr_accesses_to_accesses_bp() and
> > damon_accesses_bp_to_nr_accesses().
> > 
> > Specifically:
> > 
> > mm/damon/core.c:damon_nr_accesses_to_accesses_bp() {
> >     ...
> >     return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> > }
> > 
> > mm/damon/core.c:damon_accesses_bp_to_nr_accesses() {
> >     ...
> >     return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> > }
> > 
> > If the ratio of aggr_interval to sample_interval exceeds 429,496 (for
> > example, a 1s aggregation and 1us sample), the intermediate multiplications
> > like r * 10000 inside mult_frac() are computed as 32-bit unsigned int,
> > which overflows the 32-bit maximum.
> > 
> > Can this silently corrupt the region access counts upon attribute updates,
> > leading to completely incorrect monitoring results?
> 
> Known low priority issue.  Not a blocker of this patch.
> 
> > 
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does scaling
> > last_nr_accesses fully resolve the incorrect values returned by
> > damon_nr_accesses_mvsum(), or does it leave a double-counting flaw intact?
> > 
> > The commit message notes that damon_nr_accesses_mvsum() can return the
> > wrong value. However, the root cause appears to be a state desynchronization
> > rather than just a stale last_nr_accesses.
> > 
> > When damon_set_attrs() is called, it advances ctx->next_aggregation_sis
> > into the future:
> > 
> > mm/damon/core.c:damon_set_attrs() {
> >     ...
> >     ctx->next_aggregation_sis = ctx->passed_sample_intervals +
> >                                 attrs->aggr_interval / sample_interval;
> > }
> > 
> > If a subsequent call to damon_nr_accesses_mvsum() evaluates this future
> > timestamp, it assumes it is at the start of a new interval, meaning
> > left_window_bp evaluates to 10000.
> > 
> > mm/damon/core.c:damon_nr_accesses_mvsum() {
> >     ...
> >     return damon_mvsum(r->nr_accesses, r->last_nr_accesses, left_window_bp);
> > }
> > 
> > Because kdamond_reset_aggregated() has not yet executed, r->nr_accesses
> > still holds the fully accumulated count of the just-completed interval.
> > This means damon_mvsum() adds two full intervals' worth of access counts
> > together, effectively calculating:
> > r->nr_accesses + (r->last_nr_accesses * 10000 / 10000).
> > 
> > Does unconditionally scaling last_nr_accesses merely adjust the second term
> > of this sum while preserving the underlying double-counting logic flaw?
> 
> Good point.  In the long term, damon_update_monitoring_result() should modify
> nr_accesses.  We cannot do that at this moment, since we have to support both
> nr_accesses_bp and damon_nr_accesses_mvsum().   I will add a temporal
> preparatory hack to damonn_nr_accesses_mvsum() for this issue, like below.
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -268,6 +268,8 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
>                         ctx->passed_sample_intervals;
>         left_window_bp = mult_frac(left_window, 10000, window_len);
> 
> +       if (left_window_bp == 10000)
> +               return r->last_nr_accesses;
>         return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
>                         left_window_bp);
>  }
> '''
> 
> At the end of the series, we will updte damon_update_monitoring_result() to
> reset nr_accesses always,and remove this temporal hack.

No, I will not.

After kdamond_call() that could call damon_set_attrs(), if it was the last
iteration for the current aggregation, kdamond_fn() will further invoke
aggregation interval operations based on the before-damon_set_attrs() cached
timestamps.  Those operations include DAMOS (if apply interval is aligned with
the aggregation interval), regions split, regions reset and intervals
auto-tuning.  Some of those operations still use nr_accesses, so nr_accesses
cannot unconditionally reset in damon_update_monitoring_result().

I will make this series be merged with the nr_accesses_mvsum() change, and
cleanup/simplify the logic after this series.


Thanks,
SJ

[...]
