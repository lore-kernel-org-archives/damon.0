Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE863D76
	for <damon@lists.linux.dev>; Fri, 15 Jul 2022 17:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1AEC34115;
	Fri, 15 Jul 2022 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657904860;
	bh=aggAZRjimU1oJPtRHtLMPAK6iTKXIlW41DBUfmAz8qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U19kf46l/YYlZcR9ZNwU59Pd+entD/+0E42IdwLJFyTvElEzF8tmSew0f/9PSprgT
	 WeFOpO4fsrwt20+WWwEtNDGz9yLdg28CBv1BTPKrPhw9RJJn1MAdYd4quRbCadhuhJ
	 qnrNzyp2dJbYeSX24E/VaPy+MIjINjRjWHqa6X3fCh3Hm/inmQueUiF4375kuWbPNF
	 86Orwu7OjmZILw3eS+JHKH9Mi9io5viMs3LIOfIzM8RHMQrFwqcT1PE5+D9jFmgann
	 5hpz3JW6h30aP5xnm4d0OE4P7qfm2uOXci+V9gF2nxi11cp5+xUpAfSrutjX4g1x0Y
	 q961dkZXCvNJA==
From: SeongJae Park <sj@kernel.org>
To: Yuanzheng Song <songyuanzheng@huawei.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: fix 'enabled' is incorrectly set because 'system_wq' is not initialized
Date: Fri, 15 Jul 2022 17:07:36 +0000
Message-Id: <20220715170736.126498-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715061609.48463-1-songyuanzheng@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yuanzheng,


On Fri, 15 Jul 2022 06:16:09 +0000 Yuanzheng Song <songyuanzheng@huawei.com> wrote:

> The 'enabled' will be incorrectly set because the 'system_wq'
> might not initialized yet. This results in 'enabled=true',
> but the 'damon_reclaim_timer' is inactive. So fix it by moving
> the judgment logic of the 'damon_reclaim_initialized' to the
> start position of the enable_store().

Thank you for this patch!

In the case, however, 'damon_reclaim_init()' will activate
'damon_reclaim_timer', which will check the 'enabled' and start DAMON later.
So 'enabled' will inconsistently set while DAMON_RECLAIM is not really enabled
for a moment, but those will eventually be consistent.  This patch could reduce
the duration of the inconsistent state.

However, this would break boot-time DAMON_RECLAIM enabling, which adds
'damon_reclaim.enabled=true' to the kernel parameter, as this change will set
'enabled' as 'false' in the early 'damon_reclaim_enabled_store()', so that the
later 'damon_reclaim_initialized()' activated 'damon_reclaim_timer' shows
'enabled' as 'false' and therefore doesn't start DAMON.

If there is anything I'm missing, please let me know.


Thanks,
SJ

> 
> Fixes: 294928293813 ("mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized")
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
> ---
>  mm/damon/reclaim.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index e69b807fefe4..b13d5a02bf2e 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -374,13 +374,14 @@ static bool damon_reclaim_initialized;
>  static int damon_reclaim_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	int rc = param_set_bool(val, kp);
> -
> -	if (rc < 0)
> -		return rc;
> +	int rc;
>  
>  	/* system_wq might not initialized yet */
>  	if (!damon_reclaim_initialized)
> +		return -EINVAL;
> +
> +	rc = param_set_bool(val, kp);
> +	if (rc < 0)
>  		return rc;
>  
>  	schedule_delayed_work(&damon_reclaim_timer, 0);
> -- 
> 2.25.1
