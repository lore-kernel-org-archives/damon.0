Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24F3112BC;
	Sat, 21 Mar 2026 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123931; cv=none; b=EQaec3qNCVLoS6OAnZ84J3PWE/dQFKv3owIkv1RzOVdKbQNWjq8MqWNzyCAIFcVjBw+xLUm7gWpiU08+j4zX0xo050e/9wl99SZl+2Nrk3l5XRIBd9RMdFAyAsqS3iN6VW/QTjqx4wRRpvCL6LREznDPYLu1g/h0VZ0H+8im5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123931; c=relaxed/simple;
	bh=cl5skSWeXYfzEvV3BWZZ553P3t0zldUQcyJLsloSk8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sveG9TlFlKCXEK6e6zpipA4n9AmJv1nfSZPBG3hjaKY+fDib7Nq4kTMHZRxLCzdQ0DJEZ07167+6v/GJ82XrH69zJOXWZA6ySzjLuTUPHtbNOKRfsQ7qm2p9MIwAycVYSirUXVfI4OuuP3uoe/y2tlGkCKyvk0GDAPUKMD85Hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPACzhOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPACzhOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EDBC2BC87;
	Sat, 21 Mar 2026 20:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123931;
	bh=cl5skSWeXYfzEvV3BWZZ553P3t0zldUQcyJLsloSk8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPACzhOwayGfROGLOQrnGcwVSK9GpewHA+L6cnyAh05hz3fKM5XJ+I/Y30u9zt8oG
	 4SK6ghNvVsilMP/PhK48C9v7N4iKlyPx9JsSKpE5+erUzMjXP5VWeSf3HdC4tzBYLd
	 XkD9ewcg+BZXYRoBvfeYEvi6JpS83adxzjT486L2uGJ0+q+EE1jnnDg/6cLuQJhHAe
	 iclYoJt9oiQoaMjfBDMbXkGcnn4NWMXEQMcBBx5JLcTaeW3gcGrw4vf2i5UbZZ15aJ
	 8PzluNJ+zRQO0prCzhMxGc6IvvIqsPxKQdnV0n7+3x3Nz54MpS64DUkvtx0XGp8q2i
	 Sc03nhbJU8jpA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko) [PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sat, 21 Mar 2026 13:12:04 -0700
Message-ID: <20260321201205.95756-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260321181343.93971-2-sj@kernel.org
# start of sashiko.dev inline review
commit b56d17c42c1dc6d883f3a75d785a05ba53b5c35b
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce damon_ctx->paused

This commit introduces a paused parameter to the DAMON context API.
It allows users to pause and resume kdamond execution while preserving
self-trained data. The main loop is updated to perform limited work
and sleep when the context is paused.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..ce010009ca13 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
>  		kdamond_call(ctx, false);
>  		if (ctx->maybe_corrupted)
>  			break;
> +		while (ctx->pause) {
> +			if (kdamond_need_stop(ctx))
> +				goto done;
> +			kdamond_usleep(ctx->attrs.sample_interval);

This isn't a bug, but polling with kdamond_usleep() using the sample
interval could cause many wakeups per second even while the context is
paused. Would it be more efficient to use a waitqueue here to consume
near-zero CPU until the thread is explicitly woken?

> +			/* allow caller unset pause via damon_call() */
> +			kdamond_call(ctx, false);

If a parameter update fails during kdamond_call() and sets
ctx->maybe_corrupted to true, the loop will continue to run or exit the
pause loop and proceed to kdamond_apply_schemes() with corrupted
structures.

Is it possible to bypass the corruption safeguard here? Should we check
ctx->maybe_corrupted inside this loop to safely terminate the thread?

> +			damos_walk_cancel(ctx);

If kdamond_call() processes a request that unpauses the context, this
will immediately cancel any pending or concurrent damos_walk() requests
before the loop condition is re-evaluated.

Could this cause spurious cancellations of walk requests when unpausing
the context?

> +		}
>  		if (!list_empty(&ctx->schemes))
>  			kdamond_apply_schemes(ctx);
>  		else


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260321181343.93971-2-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260321181343.93971-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
