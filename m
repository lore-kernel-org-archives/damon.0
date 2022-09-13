Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D93C10
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 15:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D93C433C1;
	Tue, 13 Sep 2022 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663082278;
	bh=UFuyDwznO8ZwtLcStnaZ9JsjmgrVUXjXM/FFOXRJBaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C188hfqeWizeKtA5CVnQ2eNvWzPCg9IkKG9N294NZzM5ScgNCZ+MJDnhGLLthPZSP
	 TJnsh6FIEiAbpfkIZtoMaE94TfEszHZ3vn9twzQjImtTa+SanqkU5QWpUcEeLl+JRZ
	 rCkb5Cu147gCnQCH9T3Rm0FeZJoXJRer60fODjXyyU/KdcMXeizWXOVxhz+3CNp0gn
	 ROu8r8RFNGTgEaclFhF9N+MLE0pgHiAD5V0gz1ExjB8AlX4YlxCEcYQbYvD8zikrVn
	 ddpsHOd4P+VfrkFyVokDCGNvJgzKKk+1RYZJBASqSYvrVv4hHm6qgiOU/yra92Y1zU
	 FSjLBX1CRp1uQ==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: add MADV_COLLAPSE support in damos_action
Date: Tue, 13 Sep 2022 15:17:55 +0000
Message-Id: <20220913151755.103334-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913114735.22841-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

On Tue, 13 Sep 2022 19:47:35 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> MADV_COLLAPSE has large different with MDVA_HUGE in dealing with huge
> pages, it doesn't need to rely on 'khugepage' thread to create THP.
> So combining with it will give damon users more options.

I think this is a simple and worthy change, but... could you put some more
detailed explanation of the scenario that the action could be used?  Also, it
would be good to have some evaluation results you got with this change.

Also, to my understanding, MADV_COLLAPSE is not merged in the mainline yet,
right?  I believe it will make it in v6.1-rc1.  That said, to make Andrew's
burden less, how about delaying this change until MADV_COLLAPSE is mainlined?
If you have some numbers showing clear and great benefit of this change, I
think it would be worthy to add immediately, though.


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/vaddr.c      | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 016b6c9c03d6..c44f9410d997 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -97,6 +97,7 @@ enum damos_action {
>  	DAMOS_PAGEOUT,
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
> +	DAMOS_COLLAPSE,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index c2c08c1b316b..58c0d068563d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -655,6 +655,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_COLLAPSE:
> +		madv_action = MADV_COLLAPSE;
> +		break;
>  	case DAMOS_STAT:
>  		return 0;
>  	default:
> -- 
> 2.31.0
