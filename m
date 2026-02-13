Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C970311C1D
	for <damon@lists.linux.dev>; Fri, 13 Feb 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974551; cv=none; b=jM3OPUu1XBW7XiV6Fspgypc+Sok1W4LITEHYWuu7dPvKKJHbPSshBv6DKUySEqmyqh5B77rmNPvvbu65RthglyvK8k9riyER39hgC9T6JE9xxCJs1VZBc5kvLhFMwGnHQ1/41+PKdrZbPV6jDLtUamIJIPBRkWtJ8lkRBvXOlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974551; c=relaxed/simple;
	bh=b9ZAvC/Bij029/l5Yf17/oAnvdaXhzrJSzLH1xPSajU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uh819Gl1F/JPVlMaNSO+rx/UbaHj58SQMLGgXCHxN0j2uDdDX5SosHFNonaOarArHgD89+nPKsDYL+yjuf/CUP9Yp38etcbq7fvTHJn/sUEdC7AWCsBTEfw7cNNfOfGUncxQeF0P0Fr4YgUGxgBYKuDG3IBRJq5yBLW8Rn08Ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fC6Bj4nnMzJ46Yd;
	Fri, 13 Feb 2026 17:22:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id EC1AF40585;
	Fri, 13 Feb 2026 17:22:24 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Feb 2026 12:22:24 +0300
Message-ID: <eebad564-10c1-4ce9-953d-c859cd87dc88@huawei-partners.com>
Date: Fri, 13 Feb 2026 12:22:23 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/damon: remove unused code
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260212154157.75372-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260212154157.75372-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi,

On 2/12/2026 6:41 PM, SeongJae Park wrote:
> On Thu, 12 Feb 2026 09:43:26 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> damon_target is not used by get_scheme_score operations, nor with
>> virtual neither with physical addresses.
> 
> Good finding, thank you for this patch, Asier!
> 
> The subject seems bit ambiguous, though.  What about "remove unused target
> param of get_scheme_score()" ?
> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Other than the subject,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Also, DAMON patches are recommended to use mm-new as thier baseline [1] unless
> there are other reasons to not to do so.  But I found 'git am' of this patch on
> the mm-new fails.  It works on the master of mm.git, which is a commit of
> Linus' tree, though.  So, maybe this patch is not using mm-new as the baseline?
> Please consider using mm-new as the baseline next time, or specify why you use
> choose different tree as the baseline.
> 
> Assuming you are ok to the subject change (let me know if you are not), I'm
> attaching a new version of this patch that has changed the subject with my
> suggestion, and manually resolved the conflicts on mm-new, for Andrew's
> convenience.  I also applied that to my tree (damon/next), and I will repost it
> if Andrew miss this (as we are in the middle of merge window, maintainers could
> miss many things).
> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> 
> 
> Thanks,
> SJ
> 
> [...]
> ======= >8 =======
> From e09d66bb116604c9dc5b22540641e991d977ea6b Mon Sep 17 00:00:00 2001
> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Date: Thu, 12 Feb 2026 09:43:26 +0000
> Subject: [PATCH] mm/damon/: remove unused target param of get_scheme_score()
> 
> damon_target is not used by get_scheme_score operations, nor with
> virtual neither with physical addresses.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Link: https://patch.msgid.link/20260212094326.906497-1-gutierrez.asier@huawei-partners.com
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  3 +--
>  mm/damon/core.c       | 10 +++++-----
>  mm/damon/paddr.c      |  3 +--
>  mm/damon/vaddr.c      |  3 +--
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a4fea23da8576..9a88cf8d152d8 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -647,8 +647,7 @@ struct damon_operations {
>  	void (*prepare_access_checks)(struct damon_ctx *context);
>  	unsigned int (*check_accesses)(struct damon_ctx *context);
>  	int (*get_scheme_score)(struct damon_ctx *context,
> -			struct damon_target *t, struct damon_region *r,
> -			struct damos *scheme);
> +			struct damon_region *r, struct damos *scheme);
>  	unsigned long (*apply_scheme)(struct damon_ctx *context,
>  			struct damon_target *t, struct damon_region *r,
>  			struct damos *scheme, unsigned long *sz_filter_passed);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 5e2724a4f285e..925908415a041 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1679,15 +1679,15 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
>  		r->age <= s->pattern.max_age_region;
>  }
>  
> -static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
> -		struct damon_region *r, struct damos *s)
> +static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
> +		struct damos *s)
>  {
>  	bool ret = __damos_valid_target(r, s);
>  
>  	if (!ret || !s->quota.esz || !c->ops.get_scheme_score)
>  		return ret;
>  
> -	return c->ops.get_scheme_score(c, t, r, s) >= s->quota.min_score;
> +	return c->ops.get_scheme_score(c, r, s) >= s->quota.min_score;
>  }
>  
>  /*
> @@ -2011,7 +2011,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
>  				s->max_nr_snapshots <= s->stat.nr_snapshots)
>  			continue;
>  
> -		if (damos_valid_target(c, t, r, s))
> +		if (damos_valid_target(c, r, s))
>  			damos_apply_scheme(c, t, r, s);
>  
>  		if (damon_is_last_region(r, t))
> @@ -2309,7 +2309,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  		damon_for_each_region(r, t) {
>  			if (!__damos_valid_target(r, s))
>  				continue;
> -			score = c->ops.get_scheme_score(c, t, r, s);
> +			score = c->ops.get_scheme_score(c, r, s);
>  			c->regions_score_histogram[score] +=
>  				damon_sz_region(r);
>  			if (score > max_score)
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 9bfe488268407..5cdcc5037cbc1 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -343,8 +343,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  }
>  
>  static int damon_pa_scheme_score(struct damon_ctx *context,
> -		struct damon_target *t, struct damon_region *r,
> -		struct damos *scheme)
> +		struct damon_region *r, struct damos *scheme)
>  {
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 83ab3d8c37920..4e3430d4191d1 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -986,8 +986,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  }
>  
>  static int damon_va_scheme_score(struct damon_ctx *context,
> -		struct damon_target *t, struct damon_region *r,
> -		struct damos *scheme)
> +		struct damon_region *r, struct damos *scheme)
>  {
>  
>  	switch (scheme->action) {

Yes, I will change the subject.

My bad, I didn't try the patch against mm-next. Indeed, as you
suggested, it doesn't compile. I will submit a new version
of this patch after checking it works with mm-next.

-- 
Asier Gutierrez
Huawei

