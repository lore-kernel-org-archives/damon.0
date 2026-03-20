Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0037A4B7;
	Fri, 20 Mar 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019521; cv=none; b=HG1twjGEg5QA+meZtrYBo4giDtQV3btFCyR7IWraHG1B/YloC/u006kCI6pwDp+rijA0MhFWst+o1rQoHmPaGbuFw+oyrSeJQvh7175bz4KK9jz96Jvs7xOYS98D2xKjtcLxzg/bp4nPMPY/bCtBCzaHG1MCax2Lc0hx/CRkJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019521; c=relaxed/simple;
	bh=p2F28LNpMDUeRHCnHa5wYw3eMG12pSgtr/9O++IOtu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYy1eMSNOwd5VWNXGGAtBNbEAhfeFNWhH/9u3ASd20OzLeLXgiBSPWCnrFpAEOXHzqkJjHf4umb9aF2IDk8/wHpWcSdBq5TEXWRgaX4Y9wZYIHB1qxenCUw+r3W/QU49ySzd1BaTyVThEVs+rNq7Z+mO5GsogvbBKHl1D0m01zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4P7XvUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4P7XvUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76155C4CEF7;
	Fri, 20 Mar 2026 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019520;
	bh=p2F28LNpMDUeRHCnHa5wYw3eMG12pSgtr/9O++IOtu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4P7XvUv6r0ihfu5+hQzvdKhtfjBHi0cTKN5U+N5iDM9Uy4yI8pi9Bc537HBI/qB2
	 ykmDv7gZiiTaTtJHb26v4XEagCabdkBmiuo3+ECx9Fwlpw2r8wAEhO2mXp/XBSaobQ
	 dqZbIGoKocOI1kc0C51CP+E48xJ8ogBpPjvpAfHzdWHW7+MEYooPESdommOwiA1la+
	 yF4QinKPehif9qf9y8X8DVMOfCTSV6m/o9xwuXTQWPq//1mYmgki7wL/5tY49Fxt9E
	 TRXqn68NvKO2fgkg9J8FjlpWq3ziUgtufnEuNOIfnt66l5FVR0aAhEhiaMUlK3R4do
	 q4oVZdZPxueJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Fri, 20 Mar 2026 08:11:51 -0700
Message-ID: <20260320151152.99020-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 22:21:44 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON supports only start and stop of the execution.  When it is
> stopped, its internal data that it self-trained goes away.  It will be
> useful if the execution can be paused and resumed with the previous
> self-trained data.
> 
> Introduce per-context API parameter, 'paused', for the purpose.  The
> parameter can be set and unset while DAMON is running and paused, using
> the online parameters commit helper functions (damon_commit_ctx() and
> damon_call()).  Once 'paused' is set, the kdamond_fn() main loop does
> only limited works with sampling interval sleep during the works.  The
> limited works include the handling of the online parameters update, so
> that users can unset the 'pause' and resume the execution when they
> want.  It also keep checking DAMON stop conditions and handling of it,
> so that DAMON can be stopped while paused if needed.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 2 ++
>  mm/damon/core.c       | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3a441fbca170d..421e51eff3bd2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -811,6 +811,8 @@ struct damon_ctx {
>  	 * intervals tuning
>  	 */
>  	unsigned long next_intervals_tune_sis;
> +	/* pause kdamond main loop */
> +	bool pause;
>  	/* for waiting until the execution of the kdamond_fn is started */
>  	struct completion kdamond_started;
>  	/* for scheme quotas prioritization */
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 339325e1096bc..0b6cb63d64d0e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1331,6 +1331,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>  		if (err)
>  			return err;
>  	}
> +	dst->pause = src->pause;
>  	dst->ops = src->ops;
>  	dst->addr_unit = src->addr_unit;
>  	dst->min_region_sz = src->min_region_sz;
> @@ -2978,6 +2979,14 @@ static int kdamond_fn(void *data)
>  		 * kdamond_merge_regions() if possible, to reduce overhead
>  		 */
>  		kdamond_call(ctx, false);
> +		while (ctx->pause) {
> +			if (kdamond_need_stop(ctx))
> +				goto done;
> +			kdamond_usleep(ctx->attrs.sample_interval);
> +			/* allow caller unset pause via damon_call() */
> +			kdamond_call(ctx, false);
> +			damos_walk_cancel(ctx);

Sashiko comment
(https://sashiko.dev/#/patchset/20260319052157.99433-2-sj@kernel.org) and my
reply below.

: Can this cause spurious cancellations of DAMOS walk requests if the context
: is unpaused?
: 
: If kdamond_call() processes a commit that sets ctx->pause = false, and a new
: walk request is queued concurrently or immediately after, this unconditional
: call to damos_walk_cancel() will cancel the newly submitted request before
: the loop condition is evaluated again to exit the loop.
: 
: Would it be safer to verify if the context is still paused before cancelling,
: perhaps by checking if (ctx->pause) before calling damos_walk_cancel()?

Yes, it can cause unnecessary cancel of damos_walk() request.  But cancelling a
few more damos_walk() request is no big deal.  The caller and user can show it
is cancelled, and just ask it again.

So, not a problem.


Thanks,
SJ

[...]
