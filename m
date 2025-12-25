Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337542A1B2
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766624850; cv=none; b=Ntc2AjIK1xe5mBd/x6R/Ex9YKD4YqxnGzTXMgnefo9nV5f5o2Rg8Qdyc3hhA6vMFfCUJPz5AKDAm+m/PLu/0w28jriHWCRbmnEDKt4LCpXkzNDdce6vO6NvQJnEW08iX7aepE+RJHv8EEdLO7xh1qHWnY1PoaOtrrP8NT/S2qBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766624850; c=relaxed/simple;
	bh=AI9rBkTfUwqknwjaDpIIAVHasx1YLalXCFloURsFIag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6eShIaPz/xYqwvGpy8+FAT3XrmlWrRNOMcM90FI+wKZqqnZ8lXPf4Dkjg5wnW7eO6/cP9oIfsmA6nQIg/7S5pionQtWlj4ItQI+HnbNGxr+Qqher9u6/xXJRmTHMLQMPhdyWw6DO7hLCPRuVGjiqbbYXmIuvLTuUFj6ZaCYhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7n7o4qI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7n7o4qI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0F4C4CEF7;
	Thu, 25 Dec 2025 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766624849;
	bh=AI9rBkTfUwqknwjaDpIIAVHasx1YLalXCFloURsFIag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7n7o4qIqBAS50cMbyAzX2vGXpbmTQTH8YAawbEinmTeKB/ThmYU5wKvETkRKsTyb
	 eeAjlx5DoF4vlDOh8Bw3QuN5nXIRPbE+zb3DAPAoyEQ6zBaFM11hV2n4o9LEUqgfby
	 26dq65ASK+wE4v2ajYjM42VZlN08X0scfGCWeCJRktJhHT9FwZFo3wFpKOcA+5mEGX
	 MDp8ja0uGqwKxqs3fPuOcCf3URFBfYogLMwSaY5FndsSlrodZ7CRQTsD+Hjo362dbn
	 9qFQze58t/Ur/qcTj36gnP++vHy9pJNozh2aOIJ4SZxVYIve3Q5bSug1jTc10UaNDe
	 wwbsqX8svz5NQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Wed, 24 Dec 2025 17:07:21 -0800
Message-ID: <20251225010722.14746-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224124355.31667-1-rgbi3307@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> The kdamond_call() function is executed repeatedly in the kdamond_fn()
> kernel thread.  The kdamond_call() function is implemented as a while loop.
> Therefore, it is important to improve the list processing logic here to
> ensure faster execution of control->fn().

That depends on how critical the performance is, and how much complexity the
optimization introduces.  I have no idea about if the performance of
kdamond_call() is really important.  If you have a realistic use case that
shows it, sharing it would be nice.

> For ease of explanation,
> the data structure names will be abbreviated as follows:
> 
> damon_call_control.list: C.list
> ctx->call_controls: CTX.head
> repeat_controls: R.head
> 
> the execution flow of the while loop of the kdamond_call() function,
> 
> Before modification:
> Old while loop:
> 
>         CTX.head <-----> C.list <-----> C.list <----> C.list
>         ^                   |                           |
>         |               if (C.repeat)            if (!C.repeat)
>    restore: only one        |                           |
>    list_add_tail()        list_del()                  list_del()
>         |                   |                           |
>         +                   |                       complete()
>         R.head <------ list_add()
> 
> To process C.repeat above, we use an additional list, repeat_controls.

Your above abbreviation didn't explain what C.repeat is.  Maybe you mean
'damon_call_control.repeat'?

> The process of adding C.list to repeat_controls and then restoring it back
> to CTX.head is complex and inefficient.

I agree.

> Furthermore, there's the problem
> of restoring only a single C.list to CTX.head.

I had to take some time on understanding what this mean.  And it seems you are
working on an old version of the tree, and therefore saying about an issue that
already fixed by commit 592e5c5f8ec6 ("mm/damon/core: fix memory leak of repeat
mode damon_call_control objects").

Please use mm-new as a baseline of DAMON patches, unless there are special
reasons.  If there are special reasons, please explicitly specify.

> 
> Below, repeat_controls is removed and the existing CTX.head is modified to
> loop once(1st rotation).  This simplifies list processing and creates a
> more efficient structure.
> 
> Modified while loop:
> Not used repeat_controls:
> 
>         CTX.head <-----> C.list <-----> C.list <----> C.list <-------+
>                             |                           |            |
>                         if (C.repeat)            if (!C.repeat)      |
>                             |                           |            |
>                           list_del()                  list_del()     |
>                             |                           |            |
>                             |                       complete()       |
>                             |                                        |
>                           first --------> list_add_tail() -----------+
> 
>         if (C.list == first) break;
> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  mm/damon/core.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 824aa8f22db3..babad37719b6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
>   */
>  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  {
> -	struct damon_call_control *control;
> -	LIST_HEAD(repeat_controls);
> -	int ret = 0;
> +	struct damon_call_control *control, *first = NULL;
> +	unsigned int idx = 0;
> 
>  	while (true) {
>  		mutex_lock(&ctx->call_controls_lock);
>  		control = list_first_entry_or_null(&ctx->call_controls,
>  				struct damon_call_control, list);
>  		mutex_unlock(&ctx->call_controls_lock);
> -		if (!control)
> +
> +		/* check control empty or 1st rotation */
> +		if (!control || control == first)
>  			break;
> -		if (cancel) {
> +
> +		if (++idx == 1)
> +			first = control;
> +
> +		if (cancel)
>  			control->canceled = true;
> -		} else {
> -			ret = control->fn(control->data);
> -			control->return_code = ret;
> -		}
> +		else
> +			control->return_code = control->fn(control->data);
> +
>  		mutex_lock(&ctx->call_controls_lock);
>  		list_del(&control->list);
>  		mutex_unlock(&ctx->call_controls_lock);
> +
>  		if (!control->repeat) {
> +			/* run control->fn() one time */
>  			complete(&control->completion);
>  		} else if (control->canceled && control->dealloc_on_cancel) {
>  			kfree(control);
> -			continue;
>  		} else {
> -			list_add(&control->list, &repeat_controls);
> +			/* to repeat next time */
> +			mutex_lock(&ctx->call_controls_lock);
> +			list_add_tail(&control->list, &ctx->call_controls);
> +			mutex_unlock(&ctx->call_controls_lock);
>  		}
>  	}

Let's suppose there are two damon_call_control objects on the
ctx->call_controls.  The first one has ->repeat unset, while the second one
has.  Then, it seems the 'break' condition will never met and therefore this
loop will never finished.  Am I missing something?

> -	control = list_first_entry_or_null(&repeat_controls,
> -			struct damon_call_control, list);
> -	if (!control || cancel)
> -		return;
> -	mutex_lock(&ctx->call_controls_lock);
> -	list_add_tail(&control->list, &ctx->call_controls);
> -	mutex_unlock(&ctx->call_controls_lock);

As I mentioned above, apparently you are using an old version of the tree that
not having commit 592e5c5f8ec6 ("mm/damon/core: fix memory leak of repeat mode
damon_call_control objects") that modified this part.  Please use mm-new as a
baseline, or specify reasons why you cannot do so.

>  }
> 
>  /* Returns negative error code if it's not activated but should return */
> --
> 2.43.0


Thanks,
SJ
