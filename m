Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48B2D2496;
	Sun, 22 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199228; cv=none; b=aQDOuvbANkYZd3rv1txNyHgELJ32b4c61jKaANJpgPojAKjz2e8M3u2tEy7611yO4QZcsEsWjU3iKybnKzrUMfmkL6OOPc1amvbxvmEespNv+7o606x8TT569wpKg2fpgziD8IEH5zqiFfegU4DT047pKk44Nr2o+hm4dcnfIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199228; c=relaxed/simple;
	bh=Ss5BI9ZraEpcbTh44hxtWEqyuu3rnCobU89l18kEuAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdcusvGOcvJFFOzjPP84T1+Hjc4T5xjczPZXNU+id5L63fpcARnXizz2hQk7NdGFXCkmHcEv0h9wWUiw7kiDG/PKupq+MREREWvNihT5PzgPZxcJ+PhJJloJte2PhMFl7ERxwAMnXjjTQYcaNCr3F2pCcKDzgWMXwHUuKT26jP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjBOEJQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjBOEJQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BAAC19424;
	Sun, 22 Mar 2026 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199228;
	bh=Ss5BI9ZraEpcbTh44hxtWEqyuu3rnCobU89l18kEuAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjBOEJQsea7kiJPdwi4VppT0vsqbwLIf8zzl0dh2dZPd+7AoKsvWIjyP3+dak/tTQ
	 X1gS+SWAp7toHMWxQ9X5hKUGKsRdrYJDZiz3hTaDSbX5dv6Wwzsv/oOqgSwv3/50tN
	 FQE14urHdHLjjDdTyJ1xUF7w19eIJyXLAAvrQECxoONZRowUMf5QopYSQA7asnCHLM
	 iBTuiTQ3tMLcqf1FliMCSK1yQA5mI6q9o25SbH0ef5Om7wV2W+5G/Sk8ukUwNKgXDy
	 nML0MwN/tDJICImBdDc9RGe8i60y++2r0HC9e2NFilTwW8zxhzqTcmR8mLmOI1c0Ve
	 /1r9pYrfU55TA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sun, 22 Mar 2026 10:06:59 -0700
Message-ID: <20260322170700.83123-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260322155728.81434-2-sj@kernel.org
# start of sashiko.dev inline review
commit 2a3be2c8b6c327ef72163cd54e6121ef72b9c932
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce damon_ctx->paused

DAMON supports only start and stop of the execution. When it is
stopped, its internal data that it self-trained goes away. It will be
useful if the execution can be paused and resumed with the previous
self-trained data.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..0ab2cfa848e6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
>  		kdamond_call(ctx, false);
>  		if (ctx->maybe_corrupted)
>  			break;
> +		while (ctx->pause) {
> +			damos_walk_cancel(ctx);

Is it safe to repeatedly call damos_walk_cancel() here?

In damos_walk(), the walk_control_lock is dropped after setting
ctx->walk_control to check damon_is_running(), which opens a race window.

Concurrently, kdamond_fn() calls damos_walk_cancel(), which reads
ctx->walk_control, drops the lock, and completes the old request.

If a new caller invokes damos_walk() and successfully registers a new
walk_control, could damos_walk_cancel() resume, reacquire the lock,
and unconditionally set ctx->walk_control = NULL, dropping the new
request?

This might leave the new caller permanently deadlocked in
wait_for_completion().

> +			kdamond_usleep(ctx->attrs.sample_interval);

Could this result in a busy loop if sample_interval is 0?

The DAMON API allows attrs.sample_interval to be 0 (for example, when
tuning is disabled via goal.aggrs == 0).

If sample_interval is 0, this invokes usleep_range_idle(0, 1), which
sleeps for at most 1 microsecond using an hrtimer.

Since the normally expensive monitoring operations are bypassed while
paused, would this cause the thread to loop almost instantly and create
an interrupt storm?

> +			/* allow caller unset pause via damon_call() */
> +			kdamond_call(ctx, false);
> +			if (kdamond_need_stop(ctx) || ctx->maybe_corrupted)
> +				goto done;
> +		}
>  		if (!list_empty(&ctx->schemes))
>  			kdamond_apply_schemes(ctx);
>  		else


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260322155728.81434-2-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260322155728.81434-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
