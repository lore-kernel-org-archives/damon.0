Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E32F36
	for <damon@lists.linux.dev>; Wed,  7 Sep 2022 16:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A21C433D7;
	Wed,  7 Sep 2022 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662569849;
	bh=zTO/JfNwKwxbPNU1PGY3F5bXy5SfDDKgvFHJFPd1TEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILOjycA43nB7oJr1Us0s8EOOx5f9vtBZsyQt/FuiKrWGfVI2LQnI2si7Nf/7PG7Vf
	 opEOd+hUtUzDwlw4npYwrkyFd3MJ3rYcSbyT70zifnLIghl849odWL/53zZwZOufw0
	 3wrNYRdoDqbndbYwc8OYZxFekoIqxaWpjgi+IA04ZB8wKVQBeQfkVlleEMKGJ91yrl
	 kj43j2v9rdVG/C0I0P8Fw2V3WBAyUqRBYptEwerMnTP0rG+oUB/LQ3Ta4h6dkAFscV
	 qCkrnYjq67WvBUdtL0s9bG+q2g7NgvVXcT2Ev9Pwcxo+Nro+T62xnaXi2JkM1v7V5i
	 Huxf4iafbOX+g==
From: SeongJae Park <sj@kernel.org>
To: Xin Hao <xhao@linux.alibaba.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Simply damon_ctx check in damon_sysfs_before_terminate
Date: Wed,  7 Sep 2022 16:57:26 +0000
Message-Id: <20220907165726.52151-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907084116.62053-1-xhao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

Nit: I'd suggest to 's/Simply/simplify/' in the subject.

On Wed, 7 Sep 2022 16:41:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_before_terminate() func, it need to check whether
> ctx->ops.id supports 'DAMON_OPS_VADDR' or 'DAMON_OPS_FVADDR', there we
> can use damon_target_has_pid() instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Other than the above trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

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
