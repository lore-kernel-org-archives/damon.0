Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A2BE5E;
	Sun,  6 Jul 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838322; cv=none; b=Vt+w2wy1E8hFaLe6pr7TTqWiKU31VO225AAA3IIh/UTCyTiuNx0+lCtJhFvOVhSu9kxJzD2nRBP147YBpZ6dQY1JyXxANKn7SepR0yDjQ4v1cnWJWA9KvUL9vCmDgyWSacfEKkk/MMk0N6qFKZImGUuB/5Nu100jtA1M43NCCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838322; c=relaxed/simple;
	bh=fuwfaSr+3I1Fal35XypZa6Kem5PO110174ZtTHvNU5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mun0MyPfDEv9D9R8yi5wLj4WQOtF2MQAec4JxPaMhHh6RDw2Xb5aWGMS11UEUw+THP1OQNfLZ5WLvh+cP6j/L0X1qSEg6TwCjWmrBdXuFnR2kErCf0cbewlAYmNRhBgWFJ6iKCHUjqZWlvNmO0L/rmvwjLFbYRXaP1XBjDS6SCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibt9kFji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibt9kFji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43717C4CEED;
	Sun,  6 Jul 2025 21:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751838321;
	bh=fuwfaSr+3I1Fal35XypZa6Kem5PO110174ZtTHvNU5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ibt9kFjigAs2QRJmsNS9Gxti+O2/aPAbTYv/uI+13WlXaXVUo9uW6IxQGfGl5bZge
	 GXKF0E7wY+JQz2YqD05ZDEOJM3oB2U1uQM1IW3j96rtx6SQ63Rfhibwvgt4EFgUuhl
	 kxRLDiMZFlo6o2SHAckx0WQsUfScSkE2LfUn0lXwUJgvORv6p+K6WNxt5L6H496Mgf
	 uVg2FByZa4eIDAjkSm+u1LSTmZPdMCqHqCYn2r64GIjauIzRAgkRz1ur7NlnsrnK1R
	 mNIQ6vVIPIpYQj9+zLK1iOBD/kE7gXldfj1fUpoGUkr1JyPfCTT63DKer/538BP8QG
	 Y3ysO+eOcLZdg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/14] mm/damon/core: introduce repeat mode damon_call()
Date: Sun,  6 Jul 2025 14:45:18 -0700
Message-Id: <20250706214518.56529-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  6 Jul 2025 13:00:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_call() can be useful for reading or writing DAMON internal data
> for one time.  A common pattern of DAMON core usage from DAMON modules
> is doing such reads and writes repeatedly, for example, to periodically
> update the DAMOS stats.  To do that with damon_call(), callers should
> call damon_call() repeatedly, with their own delay loop.  Each caller
> doing that is repetitive.  Introduce a repeat mode damon_call().
> Callers can use the mode by setting a new field in damon_call_control.
> If the mode is turned on, damon_call() returns success immediately, and
> DAMON repeats invoking the callback function inside the kdamond main
> loop.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
[...]
> @@ -2389,6 +2393,7 @@ static void kdamond_usleep(unsigned long usecs)
>  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  {
>  	struct damon_call_control *control;
> +	LIST_HEAD(repeat_controls);
>  	int ret = 0;
>  
>  	while (true) {
> @@ -2407,8 +2412,18 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  		mutex_lock(&ctx->call_controls_lock);
>  		list_del(&control->list);
>  		mutex_unlock(&ctx->call_controls_lock);
> -		complete(&control->completion);
> +		if (!control->repeat)
> +			complete(&control->completion);
> +		else
> +			list_add(&control->list, &repeat_controls);
>  	}
> +	control = list_first_entry_or_null(&repeat_controls,
> +			struct damon_call_control, list);
> +	if (!control || cancel)
> +		return;
> +	mutex_lock(&ctx->call_controls_lock);
> +	list_add_tail(&control->list, &ctx->call_controls);
> +	mutex_unlock(&ctx->call_controls_lock);
>  }

Below fixup should be added on this.  Without it, the repeat_controls handling
is never executed, so callback will be invoked only once.

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a4dc76dd023..3c0c3cef43e7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2402,7 +2402,7 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
                                struct damon_call_control, list);
                mutex_unlock(&ctx->call_controls_lock);
                if (!control)
-                       return;
+                       break;
                if (cancel) {
                        control->canceled = true;
                } else {

I'll add this on next version of this series.


Thanks,
SJ

[...]
