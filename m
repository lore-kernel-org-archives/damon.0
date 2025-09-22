Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F759192B66
	for <damon@lists.linux.dev>; Mon, 22 Sep 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539803; cv=none; b=S2Q+RUxl/UVeiszd46SS8PxV6Z+qbEx64Q4Bj8JdTv+/Per77tZXpxkO9k8Ecko1DP+T2H3+dzbx+2Oh5YD0wOo5YLS2AmGvJbRVS5yiQQOZgsdGXI0Xd34lhVk+BN7Si5YznDnFoeUqXQwYLDZM0qxAnYo2f0RXCKUdGESYSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539803; c=relaxed/simple;
	bh=b7pgu0IoROHjcpKnMQJ5bcgio5bDtNJmEOWrB0KVmrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mak+2bCbFQKS5wDGUbFjJIuzXt6V1p2UH87CwzrWX+lUbYjTpDsCbuLiQBDUYnwIqSFdDkwwZPu8zmjITwvnLjKgRUl6qnu3DBKj1vLAsJIE0Rt9RJ6qkIFJOFt3//x74kxnJJEc1bu4f+CBsJs5ynrulD/QOS5yDN75ydp0YQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cVgRN4FnTz6L5wF;
	Mon, 22 Sep 2025 19:11:44 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BE2A140432;
	Mon, 22 Sep 2025 19:16:32 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 14:16:31 +0300
Message-ID: <5a9dd164-8dca-4852-a6ab-bab752a37810@huawei-partners.com>
Date: Mon, 22 Sep 2025 14:16:31 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/damon/core: introduce priority concept for
 DAMON
To: Enze Li <lienze@kylinos.cn>, <sj@kernel.org>, <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <enze.li@gmx.com>
References: <20250922101022.362822-1-lienze@kylinos.cn>
 <20250922101022.362822-2-lienze@kylinos.cn>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20250922101022.362822-2-lienze@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi,

On 9/22/2025 1:10 PM, Enze Li wrote:
> This patch introduces a priority-based scheme application mechanism to
> DAMON, enhancing its ability to prioritize memory management operations
> for specific processes.  Currently, DAMON applies schemes uniformly
> across all monitored processes without regard to their relative
> importance.  This change allows users to assign a priority value to each
> target process, influencing the frequency with which schemes are applied.
> 
> The core implementation modifies kdamond_apply_schemes to track and apply
> schemes according to user-defined priorities.  For instance, if process A
> has priority 50 and process B has priority 30, damon_do_apply_schemes
> will be called 50 times on A for every 30 times on B.  This ratio
> ensures that higher-priority processes receive more frequent attention
> from DAMON's operations, which can be critical for performance-sensitive
> workloads or prioritized tasks.
> 
> The change maintains the overall fairness and non-starvation properties
> by cycling through targets proportionally.  Existing behavior is
> preserved for targets without a priority assigned, ensuring backward
> compatibility.  This provides system administrators with finer control
> over how DAMON’s memory optimizations are distributed, making the
> subsystem more adaptable to varied use cases and performance
> requirements.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  include/linux/damon.h |  2 +
>  mm/damon/core.c       | 91 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f13664c62ddd..a6d3ce186fdc 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -102,6 +102,8 @@ struct damon_target {
>  	unsigned int nr_regions;
>  	struct list_head regions_list;
>  	struct list_head list;
> +	unsigned int priority;
> +	struct list_head pr_list;
>  };
>  
>  /**
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 106ee8b0f2d5..c336914d03cc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/string_choices.h>
> +#include <linux/list_sort.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/damon.h>
> @@ -28,6 +29,11 @@ static DEFINE_MUTEX(damon_lock);
>  static int nr_running_ctxs;
>  static bool running_exclusive_ctxs;
>  
> +static LIST_HEAD(priority_list);
> +static bool init_priority_list;
> +static int priority_level;
> +static int priority_tick;

What would happen if you have 2 kdamond threads running at the same time? 
I guess that you will end up a data race in priority_tick.

> +
>  static DEFINE_MUTEX(damon_ops_lock);
>  static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
>  
> @@ -474,6 +480,7 @@ struct damon_target *damon_new_target(void)
>  	t->nr_regions = 0;
>  	INIT_LIST_HEAD(&t->regions_list);
>  	INIT_LIST_HEAD(&t->list);
> +	t->priority = 0;
>  
>  	return t;
>  }
> @@ -2154,6 +2161,72 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  	quota->min_score = score;
>  }
>  
> +static int damon_priority_head(void)
> +{
> +	struct damon_target *t = list_first_entry_or_null(&priority_list,
> +						struct damon_target, pr_list);

Don't we need to check for a null pointer here?

> +
> +	return t->priority;
> +}
> +
> +static int damon_priority_find_next(void)
> +{
> +	struct damon_target *t;
> +
> +	list_for_each_entry(t, &priority_list, pr_list)
> +		if (priority_level > t->priority) {
> +			priority_level = t->priority;
> +			return t->priority;
> +		}
> +	return damon_priority_head();
> +}
> +
> +static bool kdamond_targets_priority_enabled(struct damon_ctx *c)
> +{
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, c)
> +		if (t->priority > 0)
> +			return true;
> +	return false;
> +}
> +
> +static int damon_priority_cmp(void *priv, const struct list_head *a,
> +			      const struct list_head *b)
> +{
> +	struct damon_target *ta = container_of(a, struct damon_target, pr_list);
> +	struct damon_target *tb = container_of(b, struct damon_target, pr_list);
> +
> +	if (ta->priority < tb->priority)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static bool kdamond_targets_priority_init(struct damon_ctx *c)
> +{
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, c)
> +		list_add_tail(&t->pr_list, &priority_list);
> +
> +	list_for_each_entry(t, &priority_list, pr_list)
> +		pr_debug("damon target priority %d %p\n", t->priority, t->pid);
> +
> +	list_sort(NULL, &priority_list, damon_priority_cmp);
> +
> +	list_for_each_entry(t, &priority_list, pr_list)
> +		pr_debug("damon target priority after sort %d %p\n",
> +			 t->priority, t->pid);
> +
> +	init_priority_list = true;
> +	priority_level = damon_priority_head();
> +	priority_tick = priority_level;
> +	pr_debug("damon target priority init level=%d tick=%d\n",
> +		 priority_level, priority_tick);
> +	return true;
> +}
> +
>  static void kdamond_apply_schemes(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
> @@ -2162,6 +2235,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	unsigned long sample_interval = c->attrs.sample_interval ?
>  		c->attrs.sample_interval : 1;
>  	bool has_schemes_to_apply = false;
> +	bool priority_enabled = false;
>  
>  	damon_for_each_scheme(s, c) {
>  		if (c->passed_sample_intervals < s->next_apply_sis)
> @@ -2178,10 +2252,23 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	if (!has_schemes_to_apply)
>  		return;
>  
> +	priority_enabled = kdamond_targets_priority_enabled(c);
> +	if (priority_enabled && !init_priority_list)
> +		kdamond_targets_priority_init(c);

What happens if you later add a new target? priority_list is already
initialized, which means that list sorting will not take place and it will 
break your logic.

> +
>  	mutex_lock(&c->walk_control_lock);
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> -			damon_do_apply_schemes(c, t, r);
> +		if (priority_enabled == false ||
> +		    (priority_enabled == true && t->priority == priority_level &&
> +		     priority_tick-- > 0)) {
> +			if (priority_enabled == true && priority_tick <= 0) {
> +				priority_level = damon_priority_find_next();
> +				priority_tick = priority_level;
> +			}
> +			pr_debug("tick() %d(%d)\n", priority_level, priority_tick);
> +			damon_for_each_region_safe(r, next_r, t)
> +				damon_do_apply_schemes(c, t, r);
> +		}
>  	}
>  
>  	damon_for_each_scheme(s, c) {

-- 
Asier Gutierrez
Huawei

