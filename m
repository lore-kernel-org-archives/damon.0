Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD7303A07;
	Tue, 17 Mar 2026 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773721219; cv=none; b=Lt3WAD4mYgvghrsNIVa+nuLX3R+XDkfGl/2QP1HCXrzKG0L5XWp/LmDHyfd89/gs66AFnNttnmONXoMtusBJoS0tonyZScNhxTPuoANN5alIFPpkWb+X6eP1st4BJ3QO9BgQcYpCJM/QxNXGY4pBGXnYL4GHXAeawjeO3WpC2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773721219; c=relaxed/simple;
	bh=23xGg58bJG78ilar/UOp6dw7ygNrFd4ZTJiNrpATcpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnkXLs08Dnrd4RnbLWplpeeochj75sKQzuq/78rAAISG4eiAp9FAGsrJoq69ew1wzRZPRZHT3pgM9pWBCHT7WRHxnbzrIfNJGQIgAuy7igbyEl7lFjDgI9oZ9CFyyeIVVsq2t4xPkvhPwCTrV/7UMw6zKt6FZVlZ3gsIZfjFgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYJS9k5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYJS9k5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D12C4CEF7;
	Tue, 17 Mar 2026 04:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773721218;
	bh=23xGg58bJG78ilar/UOp6dw7ygNrFd4ZTJiNrpATcpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYJS9k5brCcJ7gX0JQ064uktnvzfvajkunSH1JmktVAjJsDRv6pGacksFDukIwFg2
	 bGz1h5FrCaBBZsPKKCat45sMF6fzoQIzplEoYohR5ZJ2y/qY/fjUlrpS14TLIVCthY
	 jlVMC8a0PgztYDTuYbAQIk5ymOICAkHoQ8s7o25IyJS1YgbAIDlJX0WSJCPOA/t1F6
	 vKL2BxZtp+C+VkUEbvlEAr4L65uuKrGQCB2hqDRaU4dcg0KWQAzBfnBxSoAiW/LMb0
	 Cj5tdZ1q81FG1ADI5wEXfH+8s+A+/00aoV8nE55f5iXH0ANEjCVKc3zju1bMbH1O3v
	 GjCOSRjtdkcRg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Mon, 16 Mar 2026 21:20:16 -0700
Message-ID: <20260317042017.781-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 15 Mar 2026 14:00:00 -0700 SeongJae Park <sj@kernel.org> wrote:

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
>  mm/damon/core.c       | 8 ++++++++
>  2 files changed, 10 insertions(+)
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
> index f9854aedc42d1..1e9f6aa569fd2 100644
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
> @@ -2978,6 +2979,13 @@ static int kdamond_fn(void *data)
>  		 * kdamond_merge_regions() if possible, to reduce overhead
>  		 */
>  		kdamond_call(ctx, false);
> +		while (ctx->pause) {
> +			if (kdamond_need_stop(ctx))
> +				goto done;
> +			kdamond_usleep(ctx->attrs.sample_interval);
> +			/* allow caller unset pause via damon_call() */
> +			kdamond_call(ctx, false);
> +		}

sashiko.dev comments [1] below.  Let me reply in line.

: Could this cause a deadlock if a walk request is initiated while DAMON is
: paused?
: 
: Looking at kdamond_fn(), when ctx->pause is true, the thread stays in the
: while (ctx->pause) loop and skips kdamond_apply_schemes(). If a user
: triggers a sysfs command that initiates a walk (like writing
: update_schemes_tried_regions), the sysfs thread calls damos_walk() and waits
: for walk_control->completion.
: 
: Since the kdamond thread is paused, the completion is never signaled, and the
: blocked sysfs writer will hold the global damon_sysfs_lock permanently. This
: prevents further interactions with the DAMON sysfs interface, making it
: impossible to even unpause the context.

Correct.  I was able to trigger the deadlock on my tet setup.

: 
: Should we call damos_walk_cancel(ctx) inside the pause loop to abort pending
: walk requests, similar to what is done in kdamond_wait_activation()?

Good suggestion.  I will add below attaching fixup change on the next spin.  I
confirmed the deadlock cannot be triggered after applying the fixup.

[1] https://sashiko.dev/#/patchset/20260315210012.94846-2-sj@kernel.org


Thanks,
SJ

[...]
=== >8 ===

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3405,6 +3405,7 @@ static int kdamond_fn(void *data)
                        kdamond_usleep(ctx->attrs.sample_interval);
                        /* allow caller unset pause via damon_call() */
                        kdamond_call(ctx, false);
+                       damos_walk_cancel(ctx);
                }
                if (!list_empty(&ctx->schemes))
                        kdamond_apply_schemes(ctx);
