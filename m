Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC327FD6D;
	Wed,  8 Apr 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657236; cv=none; b=hFA74MME9bOFZu0E5yLxcJ9LlxD6V3yfZUFn2rlTAd9IrDbCyV9Wotfhyy1+32S34+6fLHZAbP+FaN+fjffreb2kA5c68sGEQFEemjm3KeF7HtkAvFT2j/FjZFJ8TKl5osZ0LgPnbignXpnsUqxXKNMnh4sLbT0X5rIF/lX5Rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657236; c=relaxed/simple;
	bh=G7UsI035wI5orPhSU3xE/Y5v0SdHInqMR58UEOUbkME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0O8k0YURXIpMvhDDOstCe0Wsf3617KWIe+fKXdXnsvMN+GdPoAS0ahi4rC3XMY02VNeHM4BeeHITXcWk8NYZCxg9bYWeQiKbBmc1RmcOYHa/CbPiUEjS+5dcdNvaATo+G/V4F0hcIVxjkJ6N1arYWf35fOnZxPYn9jogFA0O6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5/+NWsz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5/+NWsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B02C19424;
	Wed,  8 Apr 2026 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775657235;
	bh=G7UsI035wI5orPhSU3xE/Y5v0SdHInqMR58UEOUbkME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5/+NWszb6/Ie8fH6WTzo+0siwhQ9wok1hskRkrt94a7cxEovLBjErhQ1R6t5SWS+
	 j7eLZae3eNlVAqHWLPgCjfjRCw/ZKIg8a/IWQco8czjSj9xwZWRieU+CdVLQL9i6Nr
	 VnlbNsFFwwX9hHvSfthGAI8CcnWA0jHtQTlYz2AIa+2JrBwKDjkW+Voq08Qu+XLshY
	 KYkdmRuGqqVifSAxFbPy2GYpZnoB/hRJNtElaX3u6NsXWyI7ZYM6PI89GT3IE+N2dr
	 k3o3w2Q5pf5X106mtG8nc+Drsze473grNO4yB3ixfzc2tzjvK8v6IxFJuk0LgMkrnm
	 9GinOU+jUTyrQ==
From: SeongJae Park <sj@kernel.org>
To: Lin Ruifeng <linruifeng4@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	chenjun102@huawei.com,
	tongtiangen@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: support freeze kdamond
Date: Wed,  8 Apr 2026 07:07:07 -0700
Message-ID: <20260408140708.89729-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408080652.1745410-1-linruifeng4@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Lin,


Thank you for sharing this patch.

On Wed, 8 Apr 2026 16:06:52 +0800 Lin Ruifeng <linruifeng4@huawei.com> wrote:

> During suspend and resume, the data monitored by kdamond is
> no longer meaningful. Meanwhile, since kdamond may involve
> I/O operations, it is necessary to freeze it.

I'm not used to PM freezer, and maybe because of that, I'm not fully
understanding the motivation of this patch.  Could you please elaborate the
existing problem and how this patch is fixing or improving it?


Thanks,
SJ

> 
> Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
> ---
>  mm/damon/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3e1890d64d06..5cd1f0aed66b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/string_choices.h>
> +#include <linux/freezer.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/damon.h>
> @@ -2753,6 +2754,7 @@ static int kdamond_fn(void *data)
>  
>  	complete(&ctx->kdamond_started);
>  	kdamond_init_ctx(ctx);
> +	set_freezable();
>  
>  	if (ctx->ops.init)
>  		ctx->ops.init(ctx);
> @@ -2774,6 +2776,8 @@ static int kdamond_fn(void *data)
>  		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
>  		unsigned long sample_interval = ctx->attrs.sample_interval;
>  
> +		try_to_freeze();
> +
>  		if (kdamond_wait_activation(ctx))
>  			break;
>  
> -- 
> 2.43.0
