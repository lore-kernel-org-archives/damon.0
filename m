Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454AAD2E
	for <damon@lists.linux.dev>; Mon, 11 Sep 2023 18:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40BAC433C8;
	Mon, 11 Sep 2023 18:19:39 +0000 (UTC)
Date: Mon, 11 Sep 2023 14:19:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911141955.245d1397@gandalf.local.home>
In-Reply-To: <20230911045908.97649-2-sj@kernel.org>
References: <20230911045908.97649-1-sj@kernel.org>
	<20230911045908.97649-2-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 04:59:07 +0000
SeongJae Park <sj@kernel.org> wrote:

> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -950,6 +950,28 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  	struct timespec64 begin, end;
>  	unsigned long sz_applied = 0;
>  	int err = 0;
> +	/*
> +	 * We plan to support multiple context per kdamond, as DAMON sysfs
> +	 * implies with 'nr_contexts' file.  Nevertheless, only single context
> +	 * per kdamond is supported for now.  So, we can simply use '0' context
> +	 * index here.
> +	 */
> +	unsigned int cidx = 0;
> +	struct damos *siter;		/* schemes iterator */
> +	unsigned int sidx = 0;
> +	struct damon_target *titer;	/* targets iterator */
> +	unsigned int tidx = 0;
> +

If this loop is only for passing sidx and tidx to the trace point, you can
add around it:

	if (trace_damos_before_apply_enabled()) {

> +	damon_for_each_scheme(siter, c) {
> +		if (siter == s)
> +			break;
> +		sidx++;
> +	}
> +	damon_for_each_target(titer, c) {
> +		if (titer == t)
> +			break;
> +		tidx++;
> +	}

	}


And then this loop will only be done if that trace event is enabled.

To prevent races, you may also want to add a third parameter, or initialize
them to -1:

	sidx = -1;

	if (trace_damo_before_apply_enabled()) {
		sidx = 0;
		[..]
	}

And you can change the TRACE_EVENT() TO TRACE_EVENT_CONDITION():

TRACE_EVENT_CONDITION(damos_before_apply,

	TP_PROTO(...),

	TP_ARGS(...),

	TP_CONDITION(sidx >= 0),

and the trace event will not be called if sidx is less than zero.

Also, this if statement is only done when the trace event is enabled, so
it's equivalent to:

	if (trace_damos_before_apply_enabled()) {
		if (sdx >= 0)
			trace_damos_before_apply(cidx, sidx, tidx, r,
					damon_nr_regions(t));
	}

-- Steve



>  
>  	if (c->ops.apply_scheme) {
>  		if (quota->esz && quota->charged_sz + sz > quota->esz) {
> @@ -964,8 +986,11 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  		ktime_get_coarse_ts64(&begin);
>  		if (c->callback.before_damos_apply)
>  			err = c->callback.before_damos_apply(c, t, r, s);
> -		if (!err)
> +		if (!err) {
> +			trace_damos_before_apply(cidx, sidx, tidx, r,
> +					damon_nr_regions(t));
>  			sz_applied = c->ops.apply_scheme(c, t, r, s);
> +		}
>  		ktime_get_coarse_ts64(&end);
>  		quota->total_charged_ns += timespec64_to_ns(&end) -
>  			timespec64_to_ns(&begin);
> -- 
