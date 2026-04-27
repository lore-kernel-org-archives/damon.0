Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB93C4574
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296084; cv=none; b=cXyC9uQuAQ+MrniH+wWgmvu5sLx+Gpn1332O3GZTnVlKhsLIZEdUI3jGitrzzN8Pxkx/Q+4hohHdDq5fkIibp4HwKw0hKETT3S10WxPBHrhgusBHo+aVy+l6AktldZSB7eO9EtynvcRUBkNjwXU7Unw6sYyf3wgnoDBtJAqcTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296084; c=relaxed/simple;
	bh=ZiXo0+f9zQRuFTpXDVrTa8Z/Sz+jMa3I3+pq5qF9JgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJU7klOzLMoRVNb5//JzmVVcn9ha4YlvQ1NgPOQvuH59gSGewPAB8rWtWRnKqucU6ag3ZxKcYmj5Q03TzAVslz0RbBB3DdEuHg/Koimsg1WAdo03PspwFHZeTTH/Zl+7fnTvQ750sYJueN6D+Ugp0MagTgpQEpUphBTs9krtfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g442043pkzHnGhT;
	Mon, 27 Apr 2026 21:20:40 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FB1C40584;
	Mon, 27 Apr 2026 21:21:20 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:21:19 +0300
Message-ID: <c09f7c82-88d3-4870-9805-f22394b08583@huawei-partners.com>
Date: Mon, 27 Apr 2026 16:21:19 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/19] mm/damon/core: commit probes
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260426205222.93895-1-sj@kernel.org>
 <20260426205222.93895-5-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260426205222.93895-5-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/26/2026 11:52 PM, SeongJae Park wrote:
> Update damon_commit_ctx() to commit installed data probes, too.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 170abba8fdf2a..2ab1d6dd47da4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -129,11 +129,34 @@ void damon_add_filter(struct damon_probe *p, struct damon_filter *f)
>  	list_add_tail(&f->list, &p->filters);
>  }
>  
> +static void damon_del_filter(struct damon_filter *f)
> +{
> +	list_del(&f->list);
> +}
> +
>  static void damon_free_filter(struct damon_filter *f)
>  {
>  	kfree(f);
>  }
>  
> +static void damon_destroy_filter(struct damon_filter *f)
> +{
> +	damon_del_filter(f);
> +	damon_free_filter(f);
> +}
> +
> +static struct damon_filter *damon_nth_filter(int n, struct damon_probe *p)
> +{
> +	struct damon_filter *f;
> +	int i = 0;
> +
> +	damon_for_each_filter(f, p) {
> +		if (i++ == n)
> +			return f;
> +	}
> +	return NULL;
> +}
> +
>  struct damon_probe *damon_new_probe(void)
>  {
>  	struct damon_probe *p;
> @@ -171,6 +194,18 @@ static void damon_destroy_probe(struct damon_probe *p)
>  	damon_free_probe(p);
>  }
>  
> +static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> +{
> +	struct damon_probe *p;
> +	int i = 0;
> +
> +	damon_for_each_probe(p, ctx) {
> +		if (i++ == n)
> +			return p;
> +	}
> +	return NULL;
> +}
> +
>  #ifdef CONFIG_DAMON_DEBUG_SANITY
>  static void damon_verify_new_region(unsigned long start, unsigned long end)
>  {
> @@ -1412,6 +1447,72 @@ static int damon_commit_targets(
>  	return 0;
>  }
>  
> +static void damon_commit_filter(struct damon_filter *dst,
> +		struct damon_filter *src)
> +{
> +	dst->type = src->type;
> +	dst->matching = src->matching;
> +	dst->allow = src->allow;
> +}
> +
> +static int damon_commit_filters(struct damon_probe *dst,
> +		struct damon_probe *src)
> +{
> +	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
> +	int i = 0, j = 0;
> +
> +	damon_for_each_filter_safe(dst_filter, next, dst) {
> +		src_filter = damon_nth_filter(i++, src);
> +		if (src_filter)
> +			damon_commit_filter(dst_filter, src_filter);
> +		else
> +			damon_destroy_filter(dst_filter);
> +	}
> +
> +	damon_for_each_filter_safe(src_filter, next, src) {
> +		if (j++ < i)
> +			continue;
> +
> +		new_filter = damon_new_filter(src_filter->type,
> +				src_filter->matching, src_filter->allow);
> +		if (!new_filter)
> +			return -ENOMEM;
We should bail out here. If we return an error, we have already
committed some of the filters already. If there is an error, we
should remove any fill that was already added.
> +		damon_add_filter(dst, new_filter);
> +	}
> +	return 0;
> +}
> +
> +static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
> +{
> +	struct damon_probe *dst_probe, *next, *src_probe, *new_probe;
> +	int i = 0, j = 0, err;
> +
> +	damon_for_each_probe_safe(dst_probe, next, dst) {
> +		src_probe = damon_nth_probe(i++, src);
> +		if (src_probe) {
> +			err = damon_commit_filters(dst_probe, src_probe);
> +			if (err)
> +				return err;
> +		} else {
> +			damon_destroy_probe(dst_probe);
> +		}
> +	}
> +
> +	damon_for_each_probe_safe(src_probe, next, src) {
> +		if (j++ < i)
> +			continue;
> +
> +		new_probe = damon_new_probe();
> +		if (!new_probe)
> +			return -ENOMEM;
The same as before, we should bail out.
> +		damon_add_probe(dst, new_probe);
> +		err = damon_commit_filters(new_probe, src_probe);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  /**
>   * damon_commit_ctx() - Commit parameters of a DAMON context to another.
>   * @dst:	The commit destination DAMON context.
> @@ -1453,6 +1554,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>  	}
>  	dst->pause = src->pause;
>  	dst->ops = src->ops;
> +	err = damon_commit_probes(dst, src);
> +	if (err)
> +		return err;
>  	dst->addr_unit = src->addr_unit;
>  	dst->min_region_sz = src->min_region_sz;
>  

-- 
Asier Gutierrez
Huawei

