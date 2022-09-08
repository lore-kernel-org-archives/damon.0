Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FA5394
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 18:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ED4C433D6;
	Thu,  8 Sep 2022 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662660078;
	bh=Eyd2f05euQSrEzSKY+ufNZEqbz628QYuj+cOfZCVgsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3ufNtX2TZLK5JUIePjDK/1DoHi233A3+qec1xZgYh2N7ixgnrTO4VcB4hnjvfFwj
	 XV8+G/lxu0GdoLUSgUorkwnCUgQqdLOiJxRJz/NGKhA7td8zTjQOC7jgWTlHj+pJIw
	 gyU/iwWIKsVY/uYiPEZSQ/JyJpu/YxNeS8m6RyOgRvj/u0sWBXdm9I4CeFg3aUJ+iO
	 +V/nPDixo8kMEWsf6mEy2ag7d6SJKQxdVN9PpN29oOE5VHk1LCMtwa3Tu/Ypba4kZ6
	 BU7pOZe4oe1u9Rnn/ZlAFEs4FrpBKRk4aM3y4b7ixvteaIiKG3qhyyYYC1aU4ioySJ
	 m1eYt6wAH+12Q==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon: simplify damon_ctx check in damon_sysfs_before_terminate
Date: Thu,  8 Sep 2022 18:01:15 +0000
Message-Id: <20220908180116.33879-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908021912.70481-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just for a record.  Apparently Andrew has already added this in mm:
https://lore.kernel.org/mm-commits/20220907223146.C7CF4C433D6@smtp.kernel.org/


Thanks,
SJ

On Thu, 8 Sep 2022 10:19:12 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_before_terminate() func, it need to check whether
> ctx->ops.id supports 'DAMON_OPS_VADDR' or 'DAMON_OPS_FVADDR', there we
> can use damon_target_has_pid() instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7488e27c87c3..88f208ff235d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2309,7 +2309,7 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t, *next;
> 
> -	if (ctx->ops.id != DAMON_OPS_VADDR && ctx->ops.id != DAMON_OPS_FVADDR)
> +	if (!damon_target_has_pid(ctx))
>  		return;
> 
>  	mutex_lock(&ctx->kdamond_lock);
> --
> 2.31.0
