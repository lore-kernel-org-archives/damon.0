Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874E194
	for <damon@lists.linux.dev>; Sat, 27 May 2023 02:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C59C433EF;
	Sat, 27 May 2023 02:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685154725;
	bh=6yooBvheHKI+vBto37tEhoVjPjXcHeAsQbQFuaxF9SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=Fi9HR5yOl26i1ImnXJq9YKMVKdwvNf8PKMJr/PTv24loJtVvdccwm1pP7BlgztHcc
	 skmqnJbpUTUBTX8aZKpcguYHBaiVLCkmXgKV4iXR8mrqnyJ8lG2vtoKUr1/dBe9hJk
	 RQE5NwYRG7uNO+r56Sb915yyysh08ZEwnJlcBCrYV38zZ8REA6sPBy8tC90K0aTQLg
	 J6mY39awDIlELoYkwX5M2Y1sRGhIfxac8cBGpBA5O+H/G9YIOaE3ijfX4/bfUm6Qas
	 h2PoWDGfCQtvwwZrxVVY5GhP2btwVt/kaz+L2diWB/pS+i/KnqFGmBMdoTCoIEgsOb
	 m0vgScZ8gQwpQ==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()
Date: Fri, 26 May 2023 19:31:49 -0700
Message-Id: <20230527023149.8441-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230527023330.23535-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi Kefeng,

Thank you so much for this awesome patch!

On Sat, 27 May 2023 10:33:30 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> If 'aggr_interval' is smaller than 'sample_interval', max_nr_accesses becomes
> zero which leads to divide error in damon_nr_accesses_to_accesses_bp(), let's
> validate the values of them in damon_set_attrs() to fix it, which similar to
> others attrs check.
> 
> Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com

I think it would be good to add the link to the report, e.g.,
"Link: https://lore.kernel.org/damon/00000000000055fc4e05fc975bc2@google.com/"

> Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")

Could you please add 'Cc: <stable@vger.kernel.org> # 6.3.x-' ?

Also, checkpatch.pl raises below warnings.

```
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#61: 
If 'aggr_interval' is smaller than 'sample_interval', max_nr_accesses becomes

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#66: 
Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")

total: 0 errors, 2 warnings, 8 lines checked
```

Could you please resolve those by wrapping the commit messages and adding
'Closes:' tag?  'Closes:' tag might be able to replace the 'Link:' tag I
supposed above.  I have no strong opinions there but having both may harm
nothing.

Other than those,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d9ef62047bf5..91cff7f2997e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -551,6 +551,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  		return -EINVAL;
>  	if (attrs->min_nr_regions > attrs->max_nr_regions)
>  		return -EINVAL;
> +	if (attrs->sample_interval > attrs->aggr_interval)
> +		return -EINVAL;
>  
>  	damon_update_monitoring_results(ctx, attrs);
>  	ctx->attrs = *attrs;
> -- 
> 2.35.3
> 
