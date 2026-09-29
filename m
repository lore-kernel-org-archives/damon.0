Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23050B8B1
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677573; cv=none; b=WqqMU3G3g8sMmESec8jgmy8f5w4QTiJ9/uLsxn366UiW08fPk0wbB3ARSiA+duK2sZqsigwgqlf37CiZoGlIYNO9AMZDS1mYeZFKFU1vLOObSMRD0XmVIH5grqgS1IivdgvC0nrs1nzN33lGZVgii2zFiKWXDx0CXtykQ8gkZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677573; c=relaxed/simple;
	bh=n1+xW9dNZzwF5uMdLCLD/54UyzViRBGpY0EqNDvSaWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s8pr0jcaASxioAGRkUYYJM9WNYd7VH+tOF2Kx96K78QkUD0RtI7eOFsa8kzD2VDl/JLGr21roMiERqSM3xAUrPWxHwsS14cyZwtN+F2DlWt8/wryO8OCQIby8N+/VZgQ+6kbP7UfdjVK+cYneq+yjJ/5etoImvcvwptWrk9YNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=QOVoSUlA; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="QOVoSUlA"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fT4o9d/2vlBFcR99884BysVogSlpXFQqRDgo+bJW/Q8=;
	b=QOVoSUlA6uxSUZ/8KC9VBGBcbFjtEbI0KjLLjDtHtjN5UYJR5iWXetzv0+byKAzqNQJknHaj9
	RJQyjJZBN6mqM9Gsjv88ata+Ws5W8Vqr3pl9JT2RD1B/l6CZTrQAPhswxUc4WnDP4alDF0iCW2c
	xhXjxrjHg8+z6ZvKC1PPx4g=
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hvDpc1xzszJ46ZV;
	Tue, 29 Sep 2026 18:25:44 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D1B4340575;
	Tue, 29 Sep 2026 18:25:58 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 13:25:58 +0300
Message-ID: <c19759f2-c28c-4b7e-a587-0a4087e85997@huawei-partners.com>
Date: Tue, 29 Sep 2026 13:25:57 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm/damon/core: add complement argument to
 damos_new_quota_goal()
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-3-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260929080113.41708-3-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 9/29/2026 11:01 AM, SJ Park wrote:
> damos_quota_goal->complement needs to be manually set by each API
> callers.  It is easy to make mistakes.  Extend the quota goal
> constructor, damos_new_quota_goal() to receive and set the complement
> flag value. Also update all callers to use the new signature.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h       | 2 +-
>  mm/damon/core.c             | 7 ++++---
>  mm/damon/lru_sort.c         | 5 +++--
>  mm/damon/reclaim.c          | 5 +++--
>  mm/damon/sysfs-schemes.c    | 2 +-
>  mm/damon/tests/core-kunit.h | 3 ++-
>  samples/damon/mtier.c       | 2 +-
>  7 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 42234839ce29..63050eb2206a 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1090,7 +1090,7 @@ bool damos_filter_for_ops(enum damos_filter_type type);
>  void damos_destroy_filter(struct damos_filter *f);
>  
>  struct damos_quota_goal *damos_new_quota_goal(
> -		enum damos_quota_goal_metric metric,
> +		enum damos_quota_goal_metric metric, bool complement,
>  		unsigned long target_value);
>  void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
>  void damos_destroy_quota_goal(struct damos_quota_goal *goal);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 1ab5154511e6..86fee9ca03a4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -691,7 +691,7 @@ void damos_destroy_filter(struct damos_filter *f)
>  }
>  
>  struct damos_quota_goal *damos_new_quota_goal(
> -		enum damos_quota_goal_metric metric,
> +		enum damos_quota_goal_metric metric, bool complement,
>  		unsigned long target_value)
>  {
>  	struct damos_quota_goal *goal;
> @@ -700,6 +700,7 @@ struct damos_quota_goal *damos_new_quota_goal(
>  	if (!goal)
>  		return NULL;
>  	goal->metric = metric;
> +	goal->complement = complement;
>  	goal->target_value = target_value;
>  	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
>  		goal->last_psi_total = U64_MAX;
> @@ -1262,8 +1263,8 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
>  	damos_for_each_quota_goal_safe(src_goal, next, src) {
>  		if (j++ < i)
>  			continue;
> -		new_goal = damos_new_quota_goal(
> -				src_goal->metric, src_goal->target_value);
> +		new_goal = damos_new_quota_goal(src_goal->metric,
> +				src_goal->complement, src_goal->target_value);
>  		if (!new_goal)
>  			return -ENOMEM;
>  		err = damos_commit_quota_goal(new_goal, src_goal);
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 273efa3c913e..64e086985eb5 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -233,12 +233,13 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
>  
>  	if (!active_mem_bp)
>  		return 0;
> -	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
> +	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, false,
> +			active_mem_bp);
>  	if (!goal)
>  		return -ENOMEM;
>  	damos_add_quota_goal(&hot_scheme->quota, goal);
>  	/* aim 0.2 % goal conflict, to keep little ping pong */
> -	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
> +	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP, false,
>  			10000 - active_mem_bp + 2);
>  	if (!goal)
>  		return -ENOMEM;
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 42a2c9cb1343..014b0779ea6d 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -233,7 +233,7 @@ static int damon_reclaim_apply_parameters(void)
>  	damon_set_schemes(param_ctx, &scheme, 1);
>  
>  	if (quota_mem_pressure_us) {
> -		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
> +		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US, false,
>  				quota_mem_pressure_us);
>  		if (!goal)
>  			goto out;
> @@ -241,7 +241,8 @@ static int damon_reclaim_apply_parameters(void)
>  	}
>  
>  	if (quota_autotune_feedback) {
> -		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
> +		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, false,
> +				10000);
>  		if (!goal)
>  			goto out;
>  		goal->current_value = quota_autotune_feedback;
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index bfb6f0bc3f21..06af417bc9a2 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2869,7 +2869,7 @@ static int damos_sysfs_add_quota_score(
>  		if (!sysfs_goal->target_value)
>  			continue;
>  
> -		goal = damos_new_quota_goal(sysfs_goal->metric,
> +		goal = damos_new_quota_goal(sysfs_goal->metric, false,
>  				sysfs_goal->target_value);
>  		if (!goal)
>  			return -ENOMEM;
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 2111faa58153..5a924edb171f 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1014,6 +1014,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
>  		 * Make it kfree()-able.
>  		 */
>  		goal = damos_new_quota_goal(dst_goals[i].metric,
> +				dst_goals[i].complement,
>  				dst_goals[i].target_value);
>  		if (!goal)
>  			goto out;
> @@ -2411,7 +2412,7 @@ static void damos_test_esz_goal_temporal(struct kunit *test)
>  	}
>  	damon_add_scheme(ctx, s);
>  
> -	goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
> +	goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, false, 10000);
>  	if (!goal) {
>  		damon_destroy_ctx(ctx);
>  		kunit_skip(test, "quota goal alloc fail");
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 27dc88bdf7a0..a2e311082cd4 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -163,7 +163,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	damon_set_schemes(ctx, &scheme, 1);
>  	quota_goal = damos_new_quota_goal(
>  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
> -			DAMOS_QUOTA_NODE_MEM_FREE_BP,
> +			DAMOS_QUOTA_NODE_MEM_FREE_BP, false,
>  			promote ? node0_mem_used_bp : node0_mem_free_bp);
>  	if (!quota_goal)
>  		goto free_out;

LGTM

Reviewed-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

-- 
Asier Gutierrez
Huawei

