Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAA7E5
	for <damon@lists.linux.dev>; Sat, 10 Sep 2022 01:04:38 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPCsG6y_1662771868;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPCsG6y_1662771868)
          by smtp.aliyun-inc.com;
          Sat, 10 Sep 2022 09:04:29 +0800
Message-ID: <a8514371-9cf4-1d99-5266-84db9ce6fa13@linux.alibaba.com>
Date: Sat, 10 Sep 2022 09:04:28 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220908151042.239189ddb1635c0f598c6fd2@linux-foundation.org>
 <20220908221653.131120-1-sj@kernel.org>
 <20220909154434.5870e33657a11d53320861e7@linux-foundation.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220909154434.5870e33657a11d53320861e7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/9/10 上午6:44, Andrew Morton 写道:
> On Thu,  8 Sep 2022 22:16:53 +0000 SeongJae Park <sj@kernel.org> wrote:
>
>> Reviewed-by: SeongJae Park <sj@kernel.org>
> Cool.  I rewrote the changelog significantly:

Thanks for all of your hard work and detailed review !

>
> From: Xin Hao <xhao@linux.alibaba.com>
> Subject: mm/damon/sysfs: change few functions execute order
> Date: Thu, 8 Sep 2022 16:19:32 +0800
>
> There's no need to run container_of() as early as we do.
>
> The compiler figures this out, but the resulting code is more readable.
>
> Link: https://lkml.kernel.org/r/20220908081932.77370-1-xhao@linux.alibaba.com
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>   mm/damon/sysfs.c |   24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
>
> --- a/mm/damon/sysfs.c~mm-damon-sysfs-change-few-functions-execute-order
> +++ a/mm/damon/sysfs.c
> @@ -1031,8 +1031,7 @@ static ssize_t nr_schemes_show(struct ko
>   static ssize_t nr_schemes_store(struct kobject *kobj,
>   		struct kobj_attribute *attr, const char *buf, size_t count)
>   {
> -	struct damon_sysfs_schemes *schemes = container_of(kobj,
> -			struct damon_sysfs_schemes, kobj);
> +	struct damon_sysfs_schemes *schemes;
>   	int nr, err = kstrtoint(buf, 0, &nr);
>   
>   	if (err)
> @@ -1040,6 +1039,8 @@ static ssize_t nr_schemes_store(struct k
>   	if (nr < 0)
>   		return -EINVAL;
>   
> +	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
> +
>   	if (!mutex_trylock(&damon_sysfs_lock))
>   		return -EBUSY;
>   	err = damon_sysfs_schemes_add_dirs(schemes, nr);
> @@ -1237,8 +1238,7 @@ static ssize_t nr_regions_show(struct ko
>   static ssize_t nr_regions_store(struct kobject *kobj,
>   		struct kobj_attribute *attr, const char *buf, size_t count)
>   {
> -	struct damon_sysfs_regions *regions = container_of(kobj,
> -			struct damon_sysfs_regions, kobj);
> +	struct damon_sysfs_regions *regions;
>   	int nr, err = kstrtoint(buf, 0, &nr);
>   
>   	if (err)
> @@ -1246,6 +1246,8 @@ static ssize_t nr_regions_store(struct k
>   	if (nr < 0)
>   		return -EINVAL;
>   
> +	regions = container_of(kobj, struct damon_sysfs_regions, kobj);
> +
>   	if (!mutex_trylock(&damon_sysfs_lock))
>   		return -EBUSY;
>   	err = damon_sysfs_regions_add_dirs(regions, nr);
> @@ -1440,8 +1442,7 @@ static ssize_t nr_targets_show(struct ko
>   static ssize_t nr_targets_store(struct kobject *kobj,
>   		struct kobj_attribute *attr, const char *buf, size_t count)
>   {
> -	struct damon_sysfs_targets *targets = container_of(kobj,
> -			struct damon_sysfs_targets, kobj);
> +	struct damon_sysfs_targets *targets;
>   	int nr, err = kstrtoint(buf, 0, &nr);
>   
>   	if (err)
> @@ -1449,6 +1450,8 @@ static ssize_t nr_targets_store(struct k
>   	if (nr < 0)
>   		return -EINVAL;
>   
> +	targets = container_of(kobj, struct damon_sysfs_targets, kobj);
> +
>   	if (!mutex_trylock(&damon_sysfs_lock))
>   		return -EBUSY;
>   	err = damon_sysfs_targets_add_dirs(targets, nr);
> @@ -1962,8 +1965,7 @@ static ssize_t nr_contexts_show(struct k
>   static ssize_t nr_contexts_store(struct kobject *kobj,
>   		struct kobj_attribute *attr, const char *buf, size_t count)
>   {
> -	struct damon_sysfs_contexts *contexts = container_of(kobj,
> -			struct damon_sysfs_contexts, kobj);
> +	struct damon_sysfs_contexts *contexts;
>   	int nr, err;
>   
>   	err = kstrtoint(buf, 0, &nr);
> @@ -1973,6 +1975,7 @@ static ssize_t nr_contexts_store(struct
>   	if (nr < 0 || 1 < nr)
>   		return -EINVAL;
>   
> +	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
>   	if (!mutex_trylock(&damon_sysfs_lock))
>   		return -EBUSY;
>   	err = damon_sysfs_contexts_add_dirs(contexts, nr);
> @@ -2737,8 +2740,7 @@ static ssize_t nr_kdamonds_show(struct k
>   static ssize_t nr_kdamonds_store(struct kobject *kobj,
>   		struct kobj_attribute *attr, const char *buf, size_t count)
>   {
> -	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
> -			struct damon_sysfs_kdamonds, kobj);
> +	struct damon_sysfs_kdamonds *kdamonds;
>   	int nr, err;
>   
>   	err = kstrtoint(buf, 0, &nr);
> @@ -2747,6 +2749,8 @@ static ssize_t nr_kdamonds_store(struct
>   	if (nr < 0)
>   		return -EINVAL;
>   
> +	kdamonds = container_of(kobj, struct damon_sysfs_kdamonds, kobj);
> +
>   	if (!mutex_trylock(&damon_sysfs_lock))
>   		return -EBUSY;
>   	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
> _
