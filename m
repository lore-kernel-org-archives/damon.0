Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006134D91F;
	Fri, 20 Feb 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600389; cv=none; b=VNxwZFgDn4RpMHaScVbN31k+vCXxoTNXWALUASfJmnm4ybxkhcOZKB4zG234EJKeFtZDapisPu6BfBJFqqgaSlcx4nTDyQLvHMhknQp17+5AhycuuPPofMIPuKyJ4a8wRviJX1DS5u66LNaoQVqPxGbKb0xl96iTvT6kk38syHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600389; c=relaxed/simple;
	bh=bxc8WQnT+E88+rul66mNDSnJZSPkzlLofI8XEyaYAa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5nVO+P/mP+rtfdbBn/b5civGo7uCjSljAILKBKZmAU8mFOVxfkQlaAq1LS4/NqWCB74WBa1N0kJXi5e9k/a31TAQg5LHpmZZAMMoAleZLBe0rCqqounvO97omBQQUNyo4QBFiuYnYerr7Kgi4oBKtauD1nfmPRK5hTSNJDbEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2Zz/QGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2Zz/QGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD94FC116C6;
	Fri, 20 Feb 2026 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771600389;
	bh=bxc8WQnT+E88+rul66mNDSnJZSPkzlLofI8XEyaYAa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2Zz/QGqB+9T41rAe3ishgh1PkcnDNXsjFBUbEQ+fYuxFle4s9oQ+fg/g5V/a0WV+
	 DVhU9fny1+YX9LhRAUkel2oaDOjDazbHFhSrj7cg+VeCT78zrW9beN15K3VTOJGfkW
	 zKU8CYOaoPuaLPWSQmZfeVoDSumX3+WiGQMAiQaN5kLC36SeTTB19Qtp5Ko/ddKdb/
	 wW5sBhFPg+fcTgkOqbn+arKymDBuz0Ix/pWcC3O7/8VymRy4Dfg1WLv8+Xfph4S229
	 /6DIJ1MPH6w8B4Gp/bKUo/jNilheMG1tp5ZuqKyz67XlqoYWsf9QdtAzBIxkhzlpcW
	 GU2Mt2Kukw4nA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [RFC PATCH 1/3] mm/damon/core: split regions for min_nr_regions at beginning
Date: Fri, 20 Feb 2026 07:13:01 -0800
Message-ID: <20260220151301.58159-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217000400.69056-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Feb 2026 16:03:56 -0800 SeongJae Park <sj@kernel.org> wrote:

> DAMON core layer respects the min_nr_regions parameter by setting the
> maximum size of each region as total monitoring region size divided by
> the parameter value.  And the limit is applied by preventing merge of
> regions that result in a region larger than the maximum size.
> 
> It does nothing for the beginning state.  That's because the users can
> set the initial monitoring regions as they want.  That is, if the users
> really care about the min_nr_regions, they are supposed to set the
> initial monitoring regions to have more than min_nr_regions regions.
> 
> When 'min_nr_regions' is high, such initial setup is difficult.  Even in
> the case, DAMON will eventually make more than min_nr_regions regions,
> but it will take time.  If the aggregation interval is long, the delay
> could be problematic.  There was actually a report [1] of the case.
> 
> Split regions larger than the size at the beginning of the kdamond main
> loop, to fix the problem.  This means the behavior is slightly changed.
> That is, the initial monitoring regions that the user set ain't be
> strictly respected, in terms of the number of the regions.  It is
> difficult to imagine a use case that actually depends on the behavior,
> though, so this change should be fine.
> 
> Note that the size limit is aligned by damon_ctx->min_region_sz and
> cannot be zero.  That is, if min_nr_region is larger than the total size
> of monitoring regions divided by ->min_region_sz, that cannot be
> respected.
> 
> [1] https://lore.kernel.org/CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8e4cf71e2a3ed..fd1b2cbfe2c80 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1316,6 +1316,40 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  	return sz;
>  }
>  
> +static void damon_split_region_at(struct damon_target *t,
> +				  struct damon_region *r, unsigned long sz_r);
> +
> +/*
> + * damon_apply_min_nr_regions() - Make effect of min_nr_regions parameter.
> + * @ctx:	monitoring context.
> + *
> + * This function implement min_nr_regions (minimum number of damon_region
> + * objects in the given monitoring context) behavior.  It first calculates
> + * maximum size of each region for enforcing the min_nr_regions as total size
> + * of the regions divided by the min_nr_regions.  After that, this function
> + * splits regions to ensure all regions are equal to or smaller than the size
> + * limit.  Finally, this function returns the maximum size limit.
> + *
> + * Returns: maximum size of each region for convincing min_nr_regions.
> + */
> +static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
> +{
> +	unsigned long max_region_sz = damon_region_sz_limit(ctx);
> +	struct damon_target *t;
> +	struct damon_region *r, *next;
> +
> +	max_region_sz = ALIGN(max_region_sz, ctx->min_region_sz);
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region_safe(r, next, t) {
> +			while (damon_sz_region(r) > max_region_sz) {
> +				damon_split_region_at(t, r, max_region_sz);
> +				r = damon_next_region(r);
> +			}
> +		}
> +	}
> +	return max_region_sz;
> +}
> +
>  static int kdamond_fn(void *data);
>  
>  /*
> @@ -1672,9 +1706,6 @@ static void kdamond_tune_intervals(struct damon_ctx *c)
>  	damon_set_attrs(c, &new_attrs);
>  }
>  
> -static void damon_split_region_at(struct damon_target *t,
> -				  struct damon_region *r, unsigned long sz_r);
> -
>  static bool __damos_valid_target(struct damon_region *r, struct damos *s)
>  {
>  	unsigned long sz;
> @@ -2778,7 +2809,7 @@ static int kdamond_fn(void *data)
>  	if (!ctx->regions_score_histogram)
>  		goto done;
>  
> -	sz_limit = damon_region_sz_limit(ctx);
> +	sz_limit = damon_apply_min_nr_regions(ctx);
>  
>  	while (!kdamond_need_stop(ctx)) {
>  		/*

As the commit message is saying, and Akinobu pointed out [1], this patch is
incomplete.  It doesn't cover the online updates of monitoring regions and
min_nr_regions.  I was planning to solve this case first and continu works for
the online updates.  The followup work was taking time more than I expected,
mainly because I wanted to do that in an efficient way.  That is,
damon_apply_min_nr_regions() iterates regions twice.  I wanted to reduce that.
But now I realize maybe I was thinking too much.

Just calling damon_apply_min_nr_regions() after kdamond_merge_regions() like
below should work in a not that inefficient way.  I believe it is not that
inefficient because it will be executed only in aggregation interval.  We are
doing the region iterations multiple times per sampling interval, which is 1/20
of the aggregation interval by default and smaller portion of the aggregation
interval in experimental setups, anyway.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3371,10 +3371,13 @@ static int kdamond_fn(void *data)
                        max_nr_accesses = ctx->ops.check_accesses(ctx);

                if (time_after_eq(ctx->passed_sample_intervals,
-                                       next_aggregation_sis))
+                                       next_aggregation_sis)) {
                        kdamond_merge_regions(ctx,
                                        max_nr_accesses / 10,
                                        sz_limit);
+                       /* online updates might be made */
+                       sz_limit = damon_apply_min_nr_regions(ctx);
+               }

                /*
                 * do kdamond_call() and kdamond_apply_schemes() after
@@ -3434,7 +3437,6 @@ static int kdamond_fn(void *data)
                                sample_interval;
                        if (ctx->ops.update)
                                ctx->ops.update(ctx);
-                       sz_limit = damon_region_sz_limit(ctx);
                }
        }
 done:
'''

If nobodys finds some problems on this, I will post RFC v2 of this after
squashing the above diff into this patch, probably within this weekend.


[1] https://lore.kernel.org/CAC5umygPq8+FQWTG73-QPOKHT1P5=N2+qFkrRfZAkL_7G=gQXQ@mail.gmail.com


Thanks,
SJ

[...]
