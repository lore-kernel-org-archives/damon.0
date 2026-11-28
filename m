Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795891900;
	b=REGTr7Z+WuweoJxsDHfmli3C37QJYk1YPPXU+mG5MII5pfho4xMvUnbYcMgx0D5JoGhz
	 gUHVCat8OHDpvjxXyj6H/0gnVzvGORpVFZAkyrvxJ7AXt9XwkEQLOFHO+C+knpfuDsjrJ
	 FU+ACqczbhtfTdhtuQOLsRA8WfLO7mV4YKz8pmRmnb14qC43RAv9KV74wxTe76q6wlrF4
	 btAWc0d7YTev7TEy1MF610ztlEWNdYRH3dYcYYk6lZNWiX0ZIVXd+WaxhbwDh9nMsA8eK
	 lRYnc2ygBnwbVQaMZIdoxxlckdl9TJgobNlfU4sUl9zAef8MB354vMoHKUela4/NQhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795891900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KwzcBGqFWH2/a4gFLMNLRtkYwV7+ussapyh0PyYiT1k=;
	b=f1m4Unq2AanNNDwUt+vey6ugCYqqGDoUTgFMcss01y2inQgb3zprlbObosxjDYu3AQ6A
	 lqhxZurSWJM8woG7yOaWSSb1E85iNPkLFQQtJZCO58yLS6SEkWskBkDcTmm3FG1OujDpW
	 I6BCIN+tix5ldI1K4rSh/xlexPa7m6wEQoLZu85l6+rp017HMY0FjzGLpKZoto1uybgyx
	 NC9Swec0bOIIWaCWhkPcaSfkaJzHx/Bc866OVGgj5s4lFWUcToC53/R9IKVNnJ0tSTteH
	 2n2A6QBUUPoCW/l5xI5yymCliR8LF7huwDbCeXF16TjIilqxzGnx/akjUZWOAg/l6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=u9+dIkKL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24B606A31C;
	Sat, 28 Nov 2026 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=u9+dIkKL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7141C1F000C1;
	Sat, 28 Nov 2026 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795891899;
	bh=KwzcBGqFWH2/a4gFLMNLRtkYwV7+ussapyh0PyYiT1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=u9+dIkKLDDkgMiwHFQBPEwr8Ya0UCsY8D4w5/MXELHGGa9q/Fc0T7TZHNWg/tJElc
	 Ba7NHs30Lkq6Y9jTOoZUQ2I4BSMTLrbVX2650y2WBANyEure6njiU5B9mxDXjo/WZv
	 JGhY0BmEtK0NqDXqIn60X8A9r79TFeQxDuDBMxDg=
Date: Sat, 28 Nov 2026 10:51:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev, linux-mm@kvack.org, Lin
 Ruifeng <linruifeng4@huawei.com>
Subject: Re: [PATCH] mm/damon/core: let kdamond freezable
Message-Id: <20261128105138.568d35b02dbc712d486a6676@linux-foundation.org>
In-Reply-To: <20261128184311.161492-1-sj@kernel.org>
References: <20261128184311.161492-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Nov 2026 10:43:10 -0800 SJ Park <sj@kernel.org> wrote:

> Subject: [PATCH] mm/damon/core: let kdamond freezable

Let's use "make kdamond freezable".

> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/damon.h>
>  #include <linux/delay.h>
> +#include <linux/freezer.h>
>  #include <linux/kthread.h>
>  #include <linux/memcontrol.h>
>  #include <linux/mm.h>
> @@ -3845,7 +3846,7 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t;
>  
> -	if (kthread_should_stop())
> +	if (kthread_freezable_should_stop(NULL))
>  		return true;
>  
>  	if (!ctx->ops.target_valid)
> @@ -4056,6 +4057,7 @@ static int kdamond_fn(void *data)
>  
>  	sz_limit = damon_apply_min_nr_regions(ctx);
>  
> +	set_freezable();
>  	while (!kdamond_need_stop(ctx)) {
>  		/*
>  		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could

Nice.
