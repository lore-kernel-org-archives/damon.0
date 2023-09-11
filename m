Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157D16405
	for <damon@lists.linux.dev>; Mon, 11 Sep 2023 20:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09F8C433C7;
	Mon, 11 Sep 2023 20:31:11 +0000 (UTC)
Date: Mon, 11 Sep 2023 16:31:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911163127.167dccc2@gandalf.local.home>
In-Reply-To: <20230911190504.102317-1-sj@kernel.org>
References: <20230911141955.245d1397@gandalf.local.home>
	<20230911190504.102317-1-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 19:05:04 +0000
SeongJae Park <sj@kernel.org> wrote:

> > Also, this if statement is only done when the trace event is enabled, so
> > it's equivalent to:
> > 
> > 	if (trace_damos_before_apply_enabled()) {
> > 		if (sdx >= 0)
> > 			trace_damos_before_apply(cidx, sidx, tidx, r,
> > 					damon_nr_regions(t));
> > 	}  
> 
> Again, thank you very much for letting me know this awesome feature.  However,
> sidx is supposed to be always >=0 here, since kdamond is running in single
> thread and hence no race is expected.  If it exists, it's a bug.  So, I
> wouldn't make this change.  Appreciate again for letting me know this very
> useful feature, and please let me know if I'm missing something, though!

The race isn't with your code, but the enabling of tracing.

Let's say you enable tracing just ass it passed the first:

	if (trace_damos_before_apply_enabled()) {
   
		damon_for_each_scheme(siter, c) {
			if (siter == s)
				break;
			sidx++;
		}
		damon_for_each_target(titer, c) {
			if (titer == t)
				break;
			tidx++;
	}  

Now, sidx and tidx is zero (when they were not computed, thus, they
shouldn't be zero.

Then tracing is fully enabled here, and now we enter:

 	if (trace_damos_before_apply_enabled()) {
		trace_damos_before_apply(cidx, sidx, tidx, r,
 				damon_nr_regions(t));
 	}

Now the trace event is hit with sidx and tidx zero when they should not be.
This could confuse you when looking at the report.

What I suggested was to initialize sidx to zero, set it in the first
trace_*_enabled() check, and ignore calling the tracepoint if it's not >= 0.

-- Steve
