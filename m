Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AC2EDD70;
	Thu, 26 Mar 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532617; cv=none; b=Fnqrp1wT+7ALYpMlSYZ68XGT1JgEWygM73JQAwr5RKCt21nSzAhEHaxH+yyXgSpPc2gB17BWZypE6OsJfgNLeN+s6HSjL8OjIKepmmJKQ2PflbBBHxjMEM+xhax14t27KODviJx0brT6/dFH6NCLs+w4Q6II5QUqD4CSjDZB5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532617; c=relaxed/simple;
	bh=nk0Mdre4v1viW8JBlbFncIzJhJccn/rmA5Bx5nxUNzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+VbOpMkCuqVpEBne/5k5mlZx9f5a/CUqthwATEBlAYoCyhdfS4rrtjx0ARMzCU1fhbpD53cO+50HjDOuOMYqEQ+hWwbPv0DvxRfv2EL+AWppvnshK4xT86aFJpjlKqrg+tqeC8nJKumLTkzC+rACF6ZYYQUz0A/w8VKH0T95cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXFL1wlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXFL1wlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9781C116C6;
	Thu, 26 Mar 2026 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532617;
	bh=nk0Mdre4v1viW8JBlbFncIzJhJccn/rmA5Bx5nxUNzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXFL1wlXJd4uxRJSa0WrDUDRqCzaFsXqiIKqhJFYJEZRbUCz2RRktkdm1waxjShwy
	 LQWSa/H6/KLntrERss9EHxpp3gBItF5uermP3OjPehZccDq79Kf4VPcW2Qv3qOFyKP
	 TWWZ50aaoQKAUMiDiz90vrKBrL6l/fu0R3R+0AWmG/r6dw0QyBhQeu8hRk28so4f/n
	 IgRdlADsEVsguMIVEqX9xAPFM9JRyQeUcrvlQxvjN9DpUTF01yp/FV/mZk9EBYlXOI
	 lMW0ObYiA+2gqCHIQLCfZF9Vrpz4Z22ajNBvtIDM7YB/Jor/ouBKU/KZqjB8Vy6g25
	 xNIBAVGEZQmUw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 2/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 06:43:29 -0700
Message-ID: <20260326134330.90521-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326062347.88569-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260326062347.88569-3-sj@kernel.org
# start of sashiko.dev inline review
commit b886bf00a72b1462f29533c91c431cd2ba3fa3a6
Author: SeongJae Park <sj@kernel.org>
mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock

This commit introduces a call_controls_obsolete flag to protect damon_call()
from racing with the kdamond termination sequence. This replaces the previous
after-registration damon_is_running() check.

Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b8..a2b553e2c5a81 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1629,10 +1600,12 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
>  	INIT_LIST_HEAD(&control->list);
>  
>  	mutex_lock(&ctx->call_controls_lock);
> +	if (ctx->call_controls_obsolete) {
> +		mutex_unlock(&ctx->call_controls_lock);
> +		return -ECANCELED;
> +	}
>  	list_add_tail(&control->list, &ctx->call_controls);
>  	mutex_unlock(&ctx->call_controls_lock);
> -	if (!damon_is_running(ctx))
> -		return damon_call_handle_inactive_ctx(ctx, control);

Does this removal cause an indefinite wait if damon_call() is invoked on an
unstarted context?

For a newly allocated damon_ctx, call_controls_obsolete is zero-initialized
to false. Without the damon_is_running() check, if a caller invokes
damon_call() before damon_start(), it appears the request will be queued and
block on wait_for_completion() indefinitely since no kdamond thread is
running to handle or cancel it.

>  	if (control->repeat)
>  		return 0;
>  	wait_for_completion(&control->completion);
[ ... ]
> @@ -3062,6 +3038,9 @@ static int kdamond_fn(void *data)
>  	damon_destroy_targets(ctx);
>  
>  	kfree(ctx->regions_score_histogram);
> +	mutex_lock(&ctx->call_controls_lock);
> +	ctx->call_controls_obsolete = true;
> +	mutex_unlock(&ctx->call_controls_lock);
>  	kdamond_call(ctx, true);
>  	damos_walk_cancel(ctx);

Can this sequence also cause a spurious -ECANCELED failure when a context is
restarted?

When restarting a context, kdamond_fn() signals kdamond_started before
calling kdamond_init_ctx():

        complete(&ctx->kdamond_started);
        kdamond_init_ctx(ctx);

If damon_start() unblocks and immediately invokes damon_call(), couldn't it
observe the stale call_controls_obsolete == true from the previous run and
return -ECANCELED, since kdamond_init_ctx() has not yet reset the flag?

Also, is damos_walk() vulnerable to the same termination race being fixed
here for damon_call()?

In kdamond_fn(), damos_walk_cancel() processes cancellations before
ctx->kdamond is set to NULL. If damos_walk() is called during this window,
it checks damon_is_running() (which still returns true), sets the walk
control, and blocks on wait_for_completion().

Since cancellations are already processed, will it wait indefinitely?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260326062347.88569-3-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260326062347.88569-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
