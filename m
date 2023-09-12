Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D87A5C
	for <damon@lists.linux.dev>; Tue, 12 Sep 2023 01:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DFFC116A1;
	Tue, 12 Sep 2023 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694482990;
	bh=MZfgo6MURz3BgruLFMBLXwS/8zrB+gqE+MzIheFwuyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9uNrRTYqaajPGhKYGdTDqSCvE+I3yEoL60HbVUdoQoEJ7vzKYfmNUP53+Mypx2q1
	 8OIwfqagUNN5TnPbd5zsQPJLoSvgv5bdmvWmyzpcegmaus2km+4OdqGibOxNLDgy5t
	 k4RdZ78uKAfS++llOiKcM3aTM9rEajLrrCs7gXmwPg+j71glXOaXNbtJWPF87eym0b
	 apqMKxjA67c24htXl1O76cWLhuaGPlRSk5sC7FsSVFbEupM5cwJOtiNnXoQqRqgB13
	 NO903WTV7hKDNuhOb1PEAzexCl5j0DEkNDlXmS5f3K9yBmLmp3PAEtWy9bIj+Jm4cB
	 9qAACSsgygBxQ==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date: Tue, 12 Sep 2023 01:43:08 +0000
Message-Id: <20230912014308.38298-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911165144.5002a0ac@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Sep 2023 16:51:44 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Sep 2023 20:36:42 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > > Then tracing is fully enabled here, and now we enter:
> > > 
> > >  	if (trace_damos_before_apply_enabled()) {
> > > 		trace_damos_before_apply(cidx, sidx, tidx, r,
> > >  				damon_nr_regions(t));
> > >  	}
> > > 
> > > Now the trace event is hit with sidx and tidx zero when they should not be.
> > > This could confuse you when looking at the report.  
> > 
> > Thank you so much for enlightening me with this kind explanation, Steve!  And
> > this all make sense.  I will follow your suggestion in the next spin.
> > 
> > > 
> > > What I suggested was to initialize sidx to zero,  
> > 
> > Nit.  Initialize to not zero but -1, right?
> 
> Yeah, but I was also thinking of the reset of it too :-p
> 
> 	sidx = -1;
> 
> 	if (trace_damos_before_apply_enabled()) {
> 		sidx = 0;

Thank you for clarifying, Steve :)

Nevertheless, since the variable is unsigned int, I would need to use UINT_MAX
instead.  To make the code easier to understand, I'd prefer to add a third
parameter, as you suggested as another option at the original reply, like
below:

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -997,6 +997,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
        unsigned int sidx = 0;
        struct damon_target *titer;     /* targets iterator */
        unsigned int tidx = 0;
+       bool do_trace = false;

        /* get indices for trace_damos_before_apply() */
        if (trace_damos_before_apply_enabled()) {
@@ -1010,6 +1011,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
                                break;
                        tidx++;
                }
+               do_trace = true;
        }

        if (c->ops.apply_scheme) {
@@ -1036,7 +1038,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
                        err = c->callback.before_damos_apply(c, t, r, s);
                if (!err) {
                        trace_damos_before_apply(cidx, sidx, tidx, r,
-                                       damon_nr_regions(t));
+                                       damon_nr_regions(t), do_trace);
                        sz_applied = c->ops.apply_scheme(c, t, r, s);
                }
                ktime_get_coarse_ts64(&end);


Thanks,
SJ

> 
> -- Steve
> 
> 
> > 
> > > set it in the first trace_*_enabled() check, and ignore calling the
> > > tracepoint if it's not >= 0.
> > > 
