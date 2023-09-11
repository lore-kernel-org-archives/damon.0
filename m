Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E415AC3
	for <damon@lists.linux.dev>; Mon, 11 Sep 2023 19:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F44C433C8;
	Mon, 11 Sep 2023 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694459106;
	bh=hJ5p3TsjWyGe3OdxMfLULkedWZ9EMmXGZBw1r4Vi72Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caoz1Q8jo/vriTwrAeUv58MBLku2nEOL8/UhVo7wZQGVqe4qs9eGOvszaUThBXO8K
	 eygwuQv3xjXGPgYCHZlTEyi+gXH2EMDecgQRSPLCiZVOxi/YPDCMZmHhaJoTLN25E4
	 7B5acEhPsH1lGAKHbQ1XTPI/V6tTPkY6tLjcvgJR9cTcvsP6Acod9lQpWMIwwXJxpm
	 WoUhmaub8YtJdN2HGMzGE/a73XBz962VwFBy6eUxdnHSlTBRwXVT6QCt3Y65BLXb2A
	 AGQkYxO/1MVwyAn0nED4/6FNf/obpa58p85D6mmq8eV0KHbg8ARSa829KdYdzmCjEG
	 RbqIJxQvZ9reQ==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date: Mon, 11 Sep 2023 19:05:04 +0000
Message-Id: <20230911190504.102317-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911141955.245d1397@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven,

On Mon, 11 Sep 2023 14:19:55 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Sep 2023 04:59:07 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -950,6 +950,28 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  	struct timespec64 begin, end;
> >  	unsigned long sz_applied = 0;
> >  	int err = 0;
> > +	/*
> > +	 * We plan to support multiple context per kdamond, as DAMON sysfs
> > +	 * implies with 'nr_contexts' file.  Nevertheless, only single context
> > +	 * per kdamond is supported for now.  So, we can simply use '0' context
> > +	 * index here.
> > +	 */
> > +	unsigned int cidx = 0;
> > +	struct damos *siter;		/* schemes iterator */
> > +	unsigned int sidx = 0;
> > +	struct damon_target *titer;	/* targets iterator */
> > +	unsigned int tidx = 0;
> > +
> 
> If this loop is only for passing sidx and tidx to the trace point,

You're correct.

> you can add around it:
> 
> 	if (trace_damos_before_apply_enabled()) {
> 
> > +	damon_for_each_scheme(siter, c) {
> > +		if (siter == s)
> > +			break;
> > +		sidx++;
> > +	}
> > +	damon_for_each_target(titer, c) {
> > +		if (titer == t)
> > +			break;
> > +		tidx++;
> > +	}
> 
> 	}
> 
> 
> And then this loop will only be done if that trace event is enabled.

Today I learned yet another great feature of the tracing framework.  Thank you
Steven, I will add that to the next spin of this patchset!

> 
> To prevent races, you may also want to add a third parameter, or initialize
> them to -1:
> 
> 	sidx = -1;
> 
> 	if (trace_damo_before_apply_enabled()) {
> 		sidx = 0;
> 		[..]
> 	}
> 
> And you can change the TRACE_EVENT() TO TRACE_EVENT_CONDITION():
> 
> TRACE_EVENT_CONDITION(damos_before_apply,
> 
> 	TP_PROTO(...),
> 
> 	TP_ARGS(...),
> 
> 	TP_CONDITION(sidx >= 0),
> 
> and the trace event will not be called if sidx is less than zero.
> 
> Also, this if statement is only done when the trace event is enabled, so
> it's equivalent to:
> 
> 	if (trace_damos_before_apply_enabled()) {
> 		if (sdx >= 0)
> 			trace_damos_before_apply(cidx, sidx, tidx, r,
> 					damon_nr_regions(t));
> 	}

Again, thank you very much for letting me know this awesome feature.  However,
sidx is supposed to be always >=0 here, since kdamond is running in single
thread and hence no race is expected.  If it exists, it's a bug.  So, I
wouldn't make this change.  Appreciate again for letting me know this very
useful feature, and please let me know if I'm missing something, though!


Thanks,
SJ

> 
> -- Steve
> 
> 
> 
> >  
> >  	if (c->ops.apply_scheme) {
> >  		if (quota->esz && quota->charged_sz + sz > quota->esz) {
> > @@ -964,8 +986,11 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		ktime_get_coarse_ts64(&begin);
> >  		if (c->callback.before_damos_apply)
> >  			err = c->callback.before_damos_apply(c, t, r, s);
> > -		if (!err)
> > +		if (!err) {
> > +			trace_damos_before_apply(cidx, sidx, tidx, r,
> > +					damon_nr_regions(t));
> >  			sz_applied = c->ops.apply_scheme(c, t, r, s);
> > +		}
> >  		ktime_get_coarse_ts64(&end);
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> > -- 
> 
