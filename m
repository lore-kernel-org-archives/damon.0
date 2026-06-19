Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A31E823
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900265; cv=none; b=tX7oxHBqpzjeTGYo5ng5f5037RFFVcEHVp7nT3iT1PuxjFigzLm9jMvTAGBiD52xzCgcQYPqn3k1wSv70pWRBvlRKF+cwAJQWAZSViXzB7AMv11cRtZN0KFFpPOWtF1ab+k7Z6lFO3TBIbxxOkPeinTQlTpGHRL9MNzbAxSOqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900265; c=relaxed/simple;
	bh=BUzVirX/upAC9BeXadJxHjmXn/bCo0pHRS7pFk+LUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLIZIlYV/uLZ9Bi6b1JdLwqjIj/oxdj9peglge+e/Eyl7dSBlfDiQPDrQzeuDX0qfxuxoei8rCPYxdu4i3xHof1+eXiGb4sMJBq26+YZNST5Ym2dqnpkYnKhwFLlxN0jnlTYu920iRnyPqm7MfyUWUoobKXmSK+xtf1kUY3BCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDEDZ38m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDEDZ38m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16511F000E9;
	Fri, 19 Jun 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781900264;
	bh=bReG/aNKpm24qbpGm8m8fftPGdUNT2eR/XToCi+Ara8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDEDZ38mMiM6i/Cb1vqowPFbSi7IPK0xTy3DujpNenFgFEVRzVmF9mjF6mzaH90/v
	 p778hO0HZU8u4uo1Al/S1//0+YBdEGGwuGLzboMNeFYAYSPxwQDYqAUo7MLBXnIbCL
	 V6zVSQdm2rbHcZ49ughVngFcEeGhGsDFzGKZ26PZwhy7h+eLRCTgciC4kuuAtEHHlm
	 dY2VBEeVD2FyHXYpVI3iQQRVZxYiAxBNkNa50uviF/Ew+v7MNXO1qwIY2hwFWstudq
	 pQ2Zsqc6NqtGrwEJw1RdOLdKyy6A2WnWXRVFpHguanamDz80GhFvSoEVdTsOi85Zpj
	 rcnGfcR3FiBog==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 04/13] mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
Date: Fri, 19 Jun 2026 13:17:33 -0700
Message-ID: <20260619201734.144695-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619195140.E03221F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:51:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Unconditional evaluation of an expensive function (`damon_nr_accesses_mvsum`) as an argument to a tracepoint, causing performance overhead when tracing is disabled.
> 
> Pre-existing issues:
> - [Critical] Pre-existing vulnerability where setting aggr_interval to 0 triggers a divide-by-zero kernel panic in damon_nr_accesses_mvsum().
> --
> 
> commit a32ac0de542ee6f63cc5519f32be214de8a6347f
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
> 
> damon_nr_accesses_mvsum() returns a value same to nr_accesses_bp.  Also
> the function is more simple and therefore more tolerant to errors.
> Execution of the function would be more expensive than the simple read
> of the field, but because the function is quite simple, the overhead
> should be negligible.  Use it in the DAMON region exporting trace points
> instead of the nr_accesses_bp.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > index 78388538acf44..8851727ae1627 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -78,9 +78,11 @@ TRACE_EVENT_CONDITION(damos_before_apply,
> >  
> >  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> >  		unsigned int target_idx, struct damon_region *r,
> > -		unsigned int nr_regions, bool do_trace),
> > +		unsigned int nr_accesses, unsigned int nr_regions,
> > +		bool do_trace),
> 
> [ ... ]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f45f030a72d82..a7b45b3cad508 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2463,6 +2463,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  			return;
> >  		ktime_get_coarse_ts64(&begin);
> >  		trace_damos_before_apply(cidx, sidx, tidx, r,
> > +				damon_nr_accesses_mvsum(r, c),
> >  				damon_nr_regions(t), do_trace);
> 
> [Severity: Medium]
> Will this unconditionally evaluate damon_nr_accesses_mvsum() even when
> tracing is disabled?
> 
> Because trace_damos_before_apply() is an inline function wrapper, its
> arguments are evaluated before the function is called. This means
> damon_nr_accesses_mvsum() will execute on the hot path for every valid
> region, regardless of whether the tracepoint is active. It also causes
> the function to be evaluated a second time per region, since it was
> already called in __damos_valid_target().
> 
> Would it be better to pass the DAMON context pointer c into the tracepoint
> prototype and defer the execution of damon_nr_accesses_mvsum() entirely to
> TP_fast_assign() to avoid this overhead?

Nice catch.  I will execute the function in trace_damos_before_apply_enabled()
scope of the function, like below.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2711,7 +2711,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
        struct damos *siter;            /* schemes iterator */
        unsigned int sidx = 0;
        struct damon_target *titer;     /* targets iterator */
-       unsigned int tidx = 0;
+       unsigned int tidx = 0, nr_accesses = 0;
        bool do_trace = false;

        /* get indices for trace_damos_before_apply() */
@@ -2726,6 +2726,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
                                break;
                        tidx++;
                }
+               nr_accesses = damon_nr_accesses_mvsum(r, c);
                do_trace = true;
        }

@@ -2741,8 +2742,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
                if (damos_core_filter_out(c, t, r, s))
                        return;
                ktime_get_coarse_ts64(&begin);
-               trace_damos_before_apply(cidx, sidx, tidx, r,
-                               damon_nr_accesses_mvsum(r, c),
+               trace_damos_before_apply(cidx, sidx, tidx, r, nr_accesses,
                                damon_nr_regions(t), do_trace);
                sz_applied = c->ops.apply_scheme(c, t, r, s,
                                &sz_ops_filter_passed);
'''

> 
> 
> [Severity: Critical]
> This is a pre-existing issue, but does damon_nr_accesses_mvsum() have a
> divide-by-zero vulnerability when userspace configures both sample_interval
> and aggr_interval to 0?
> 
> Userspace can configure DAMON via sysfs. In damon_set_attrs(), the validation
> logic accepts configurations where both intervals are 0:
> 
> mm/damon/core.c:damon_set_attrs() {
>     ...
> 	if (attrs->sample_interval > attrs->aggr_interval)
> 		return -EINVAL;
>     ...
> }
> 
> Since 0 > 0 evaluates to false, this configuration is accepted.
> 
> When damon_nr_accesses_mvsum() is subsequently called, it computes
> window_len = ctx->attrs.aggr_interval / sample_interval, which evaluates to 0.
> It then calls mult_frac(left_window, 10000, window_len), which divides
> by window_len and will cause an immediate kernel panic.

I will fix this in the next revision.


Thanks,
SJ

[...]
