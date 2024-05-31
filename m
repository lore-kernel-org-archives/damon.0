Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F901C6BD;
	Fri, 31 May 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184321; cv=none; b=SHVAkPglmjHz8UGWLldm3ZVQKrvgzcs+B0z5e2Z7W+bIOrg6AzLYids0r/1f4raQaWJd9wVSeQ68vcfHE4bq763S9kADjWm/tx+G5f0FCbp1U8KeDRZAnAjuM/5ZugOo/ZS5lZv9GsCTOtpVTvIPa3AvO5ybkuappixOJLLauEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184321; c=relaxed/simple;
	bh=fNirT9X5z5PGC8a0mvbvylqJzj4WA1QF269Y4SA0Y34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=En6matNtjysd8stT6FyyvXPbtuLR3p3MuW6xVSHFuzjem/jxR/Hni6K1E0TzUO20MrbTJF5q9szBIHBFKswVZ7al8jFGN0v/xOvRtMfrtesiF5OXq601X43qutqSTTrOfzdrDrGJGnYOnrl77ocFxfohV6sjSM78nlEMuuoiR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwdFNHsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwdFNHsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5F7C116B1;
	Fri, 31 May 2024 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184320;
	bh=fNirT9X5z5PGC8a0mvbvylqJzj4WA1QF269Y4SA0Y34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwdFNHsfp1Wa67UDmR34wO5Bfkq2EOr4YTNS0vEwBPr9WMwGmSkFqU8K5oQ+lXVFI
	 kdPJ3br895U8tI9pXUobnA47iFWQn+L8wXIPv6UVhAFuCVqwlXnY+Rs2o0AxU2mRTX
	 uK+cE83AumffGk2vGiySue9707Ua2/DxAkjrLHdxiUc02nLW59LFcJLFyO6ep6qRa2
	 sxu+X9VwGK0yTMwWal8PRblHyzyg0t1PShveVLXr860L8Fus526YyRvD7D6SOxocnb
	 V4ZTHng1Iw0wkWrkiRrTwmlIcJgi2qF8CnqWBCXticNSKaipTSw4VfOgbpvNsuFTcd
	 L0cmU26d+VfZA==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Date: Fri, 31 May 2024 12:38:38 -0700
Message-Id: <20240531193838.71538-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531122320.909060-3-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

On Fri, 31 May 2024 15:23:20 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> This patch actually implements support for
> multi-context design for kdamond daemon.
> 
> In pseudo code previous versions worked like
> the following:
> 
>     while (!kdamond_should_stop()) {
> 
> 	/* prepare accesses for only 1 context */
> 	prepare_accesses(damon_context);
> 
> 	sleep(sample_interval);
> 
> 	/* check accesses for only 1 context */
> 	check_accesses(damon_context);
> 
> 	...
>     }
> 
> With this patch kdamond workflow will look
> like the following:
> 
>     while (!kdamond_shoule_stop()) {
> 
> 	/* prepare accesses for all contexts in kdamond */
> 	damon_for_each_context(ctx, kdamond)
> 	    prepare_accesses(ctx);
> 
> 	sleep(sample_interval);
> 
> 	/* check_accesses for all contexts in kdamond */
> 	damon_for_each_context(ctx, kdamond)
> 	    check_accesses(ctx);
> 
> 	...
>     }

This is not what you do now, but on previous patch, right?  Let's modify the
mesage appropriately.

> 
> Another point to note is watermarks. Previous versions
> checked watermarks on each iteration for current context
> and if matric's value wan't acceptable kdamond waited
> for watermark's sleep interval.

Mention changes of versions on cover letter.

> 
> Now there's no need to wait for each context, we can
> just skip context if watermark's metric isn't ready,
> but if there's no contexts that can run we
> check for each context's watermark metric and
> sleep for the lowest interval of all contexts.
> 
> Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
> ---
>  include/linux/damon.h        |  11 +-
>  include/trace/events/damon.h |  14 +-
>  mm/damon/core-test.h         |   2 +-
>  mm/damon/core.c              | 286 +++++++++++++++++------------
>  mm/damon/dbgfs-test.h        |   4 +-
>  mm/damon/dbgfs.c             | 342 +++++++++++++++++++++--------------
>  mm/damon/modules-common.c    |   1 -
>  mm/damon/sysfs.c             |  47 +++--
>  8 files changed, 431 insertions(+), 276 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 7cb9979a0..2facf3a5f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -575,7 +575,6 @@ struct damon_attrs {
>   * @lock:	Kdamond's global lock, serializes accesses to any field.
>   * @self:	Kernel thread which is actually being executed.
>   * @contexts:	Head of contexts (&damon_ctx) list.
> - * @nr_ctxs:	Number of contexts being monitored.
>   *
>   * Each DAMON's background daemon has this structure. Once
>   * configured, daemon can be started by calling damon_start().
> @@ -589,7 +588,6 @@ struct kdamond {
>  	struct mutex lock;
>  	struct task_struct *self;
>  	struct list_head contexts;
> -	size_t nr_ctxs;

Why we add this on first patch, and then remove here?  Let's not make
unnecessary temporal change.  It only increase review time.

>  
>  /* private: */
>  	/* for waiting until the execution of the kdamond_fn is started */
> @@ -634,7 +632,10 @@ struct damon_ctx {
>  	 * update
>  	 */
>  	unsigned long next_ops_update_sis;
> +	/* upper limit for each monitoring region */
>  	unsigned long sz_limit;
> +	/* marker to check if context is valid */
> +	bool valid;

What is the validity?

>  
>  /* public: */
>  	struct kdamond *kdamond;
> @@ -682,6 +683,12 @@ static inline struct damon_ctx *damon_first_ctx(struct kdamond *kdamond)
>  	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
>  }
>  
> +static inline bool damon_is_last_ctx(struct damon_ctx *ctx,
> +				     struct kdamond *kdamond)
> +{
> +	return list_is_last(&ctx->list, &kdamond->contexts);
> +}
> +
>  #define damon_for_each_region(r, t) \
>  	list_for_each_entry(r, &t->regions_list, list)
>  
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 23200aabc..d5287566c 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h

Let's separate this change to another patch.

> @@ -50,12 +50,13 @@ TRACE_EVENT_CONDITION(damos_before_apply,
>  
>  TRACE_EVENT(damon_aggregated,
>  
> -	TP_PROTO(unsigned int target_id, struct damon_region *r,
> -		unsigned int nr_regions),
> +	TP_PROTO(unsigned int context_id, unsigned int target_id,
> +		struct damon_region *r, unsigned int nr_regions),
>  
> -	TP_ARGS(target_id, r, nr_regions),
> +	TP_ARGS(context_id, target_id, r, nr_regions),
>  
>  	TP_STRUCT__entry(
> +		__field(unsigned long, context_id)
>  		__field(unsigned long, target_id)
>  		__field(unsigned int, nr_regions)
>  		__field(unsigned long, start)
> @@ -65,6 +66,7 @@ TRACE_EVENT(damon_aggregated,
>  	),
>  
>  	TP_fast_assign(
> +		__entry->context_id = context_id;
>  		__entry->target_id = target_id;
>  		__entry->nr_regions = nr_regions;
>  		__entry->start = r->ar.start;
> @@ -73,9 +75,9 @@ TRACE_EVENT(damon_aggregated,
>  		__entry->age = r->age;
>  	),
>  
> -	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
> -			__entry->target_id, __entry->nr_regions,
> -			__entry->start, __entry->end,
> +	TP_printk("context_id=%lu target_id=%lu nr_regions=%u %lu-%lu: %u %u",
> +			__entry->context_id, __entry->target_id,
> +			__entry->nr_regions, __entry->start, __entry->end,
>  			__entry->nr_accesses, __entry->age)
>  );
>  
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index 0cee634f3..7962c9a0e 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -99,7 +99,7 @@ static void damon_test_aggregate(struct kunit *test)
>  		}
>  		it++;
>  	}
> -	kdamond_reset_aggregated(ctx);
> +	kdamond_reset_aggregated(ctx, 0);
>  	it = 0;
>  	damon_for_each_target(t, ctx) {
>  		ir = 0;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index cfc9c803d..ad73752af 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -500,6 +500,8 @@ struct damon_ctx *damon_new_ctx(void)
>  	ctx->attrs.min_nr_regions = 10;
>  	ctx->attrs.max_nr_regions = 1000;
>  
> +	ctx->valid = true;
> +
>  	INIT_LIST_HEAD(&ctx->adaptive_targets);
>  	INIT_LIST_HEAD(&ctx->schemes);
>  	INIT_LIST_HEAD(&ctx->list);
> @@ -513,7 +515,7 @@ struct damon_ctx *damon_new_ctx(void)
>  void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx)
>  {
>  	list_add_tail(&ctx->list, &kdamond->contexts);
> -	++kdamond->nr_ctxs;
> +	ctx->kdamond = kdamond;
>  }
>  
>  struct kdamond *damon_new_kdamond(void)
> @@ -567,10 +569,8 @@ void damon_destroy_ctxs(struct kdamond *kdamond)
>  {
>  	struct damon_ctx *c, *next;
>  
> -	damon_for_each_context_safe(c, next, kdamond) {
> +	damon_for_each_context_safe(c, next, kdamond)
>  		damon_destroy_ctx(c);
> -		--kdamond->nr_ctxs;
> -	}
>  }
>  
>  void damon_destroy_kdamond(struct kdamond *kdamond)
> @@ -735,6 +735,20 @@ bool damon_kdamond_running(struct kdamond *kdamond)
>  	return running;
>  }
>  
> +/**
> + * kdamond_nr_ctxs() - Return number of contexts for this kdamond.
> + */
> +static int kdamond_nr_ctxs(struct kdamond *kdamond)
> +{
> +	struct list_head *pos;
> +	int nr_ctxs = 0;
> +
> +	list_for_each(pos, &kdamond->contexts)
> +		++nr_ctxs;
> +
> +	return nr_ctxs;
> +}
> +
>  /* Returns the size upper limit for each monitoring region */
>  static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  {
> @@ -793,11 +807,11 @@ static int __damon_start(struct kdamond *kdamond)
>   * @exclusive:	exclusiveness of this contexts group
>   *
>   * This function starts a group of monitoring threads for a group of monitoring
> - * contexts.  One thread per each context is created and run in parallel.  The
> - * caller should handle synchronization between the threads by itself.  If
> - * @exclusive is true and a group of threads that created by other
> + * contexts. If @exclusive is true and a group of contexts that created by other
>   * 'damon_start()' call is currently running, this function does nothing but
> - * returns -EBUSY.
> + * returns -EBUSY, if @exclusive is true and a given kdamond wants to run
> + * several contexts, then this function returns -EINVAL. kdamond can run
> + * exclusively only one context.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> @@ -806,10 +820,6 @@ int damon_start(struct kdamond *kdamond, bool exclusive)
>  	int err = 0;
>  
>  	BUG_ON(!kdamond);
> -	BUG_ON(!kdamond->nr_ctxs);
> -
> -	if (kdamond->nr_ctxs != 1)
> -		return -EINVAL;
>  
>  	mutex_lock(&damon_lock);
>  	if ((exclusive && nr_running_kdamonds) ||
> @@ -818,6 +828,11 @@ int damon_start(struct kdamond *kdamond, bool exclusive)
>  		return -EBUSY;
>  	}
>  
> +	if (exclusive && kdamond_nr_ctxs(kdamond) > 1) {
> +		mutex_unlock(&damon_lock);
> +		return -EINVAL;
> +	}
> +
>  	err = __damon_start(kdamond);
>  	if (err)
>  		return err;
> @@ -857,7 +872,7 @@ int damon_stop(struct kdamond *kdamond)
>  /*
>   * Reset the aggregated monitoring results ('nr_accesses' of each region).
>   */
> -static void kdamond_reset_aggregated(struct damon_ctx *c)
> +static void kdamond_reset_aggregated(struct damon_ctx *c, unsigned int ci)
>  {
>  	struct damon_target *t;
>  	unsigned int ti = 0;	/* target's index */
> @@ -866,7 +881,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  		struct damon_region *r;
>  
>  		damon_for_each_region(r, t) {
> -			trace_damon_aggregated(ti, r, damon_nr_regions(t));
> +			trace_damon_aggregated(ci, ti, r, damon_nr_regions(t));

Separate traceevent change into another patch.

>  			r->last_nr_accesses = r->nr_accesses;
>  			r->nr_accesses = 0;
>  		}
> @@ -1033,21 +1048,15 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
>  	return false;
>  }
>  
> -static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> -		struct damon_region *r, struct damos *s)
> +static void damos_apply_scheme(unsigned int cidx, struct damon_ctx *c,
> +			       struct damon_target *t, struct damon_region *r,
> +			       struct damos *s)

Unnecesary change.

As also mentioned on the reply to the first patch, I think this patch can
significantly changed if you agree to my opinion about the flow of patches that
I mentioned on the reply to the cover letter.  Hence, stopping review from here
for now.  Please let me know if you have a different opinion.


Thanks,
SJ

[...]
