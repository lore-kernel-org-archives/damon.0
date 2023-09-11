Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025825393
	for <damon@lists.linux.dev>; Mon, 11 Sep 2023 20:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D463EC433C9;
	Mon, 11 Sep 2023 20:51:28 +0000 (UTC)
Date: Mon, 11 Sep 2023 16:51:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911165144.5002a0ac@gandalf.local.home>
In-Reply-To: <20230911203642.1788-1-sj@kernel.org>
References: <20230911163127.167dccc2@gandalf.local.home>
	<20230911203642.1788-1-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 20:36:42 +0000
SeongJae Park <sj@kernel.org> wrote:

> > Then tracing is fully enabled here, and now we enter:
> > 
> >  	if (trace_damos_before_apply_enabled()) {
> > 		trace_damos_before_apply(cidx, sidx, tidx, r,
> >  				damon_nr_regions(t));
> >  	}
> > 
> > Now the trace event is hit with sidx and tidx zero when they should not be.
> > This could confuse you when looking at the report.  
> 
> Thank you so much for enlightening me with this kind explanation, Steve!  And
> this all make sense.  I will follow your suggestion in the next spin.
> 
> > 
> > What I suggested was to initialize sidx to zero,  
> 
> Nit.  Initialize to not zero but -1, right?

Yeah, but I was also thinking of the reset of it too :-p

	sidx = -1;

	if (trace_damos_before_apply_enabled()) {
		sidx = 0;

-- Steve


> 
> > set it in the first trace_*_enabled() check, and ignore calling the
> > tracepoint if it's not >= 0.
> > 
