Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34973C4574
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296316; cv=none; b=ulfsyFNsH5dr+wOpreeHqndP/rKUkWrjaQdTsobz7uStSD+X0vnOYzmTewq2Ah4alvFXbiELQO9K30tPy29I4MJZ0mZaRmF87ympaL7bK2NnfmSjtCrmY5HuUbXnHLuXe6AlFgTAlkiTehJc/8FvxAegsZRn3G1PqBWm/qfgQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296316; c=relaxed/simple;
	bh=Y2ZuKwVCb06b78qiGd/LMC1INxWQJCTKgEsLUlKgmXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qB+WbevCDe+wB/kO4iLbLPHUv5WD1dHcZrhlL4k8aCIERMoZHjHDMNwsej3V3MzagwYoBs2d4TkAKHM+TBXG4rSo/iRUF4Fszo6MFb/OMqVviB7C3XCfvlsPVQDv/6YKsTcWlgFaBD4VG5iXTSynjbFYOfIn7SYQ19D8C2M7EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g447B6cf0zJ46XJ;
	Mon, 27 Apr 2026 21:25:10 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 3ED494058C;
	Mon, 27 Apr 2026 21:25:13 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:25:12 +0300
Message-ID: <d08d7ffd-8d51-474d-bf57-887e09cf1b05@huawei-partners.com>
Date: Mon, 27 Apr 2026 16:25:12 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/19] mm/damon/sysfs: setup probes on DAMON core API
 parameters
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260426205222.93895-1-sj@kernel.org>
 <20260426205222.93895-15-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260426205222.93895-15-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/26/2026 11:52 PM, SeongJae Park wrote:
> Add user-installed data probes to DAMON core API parameters, so that
> user inputs for data probes are passed to DAMON core.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 2e0b7eca6bcbf..8007961295d3d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1855,6 +1855,40 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
>  	return damon_set_attrs(ctx, &attrs);
>  }
>  
> +static int damon_sysfs_set_probes(struct damon_ctx *ctx,
> +		struct damon_sysfs_probes *sys_probes)
> +{
> +	int i;
> +
> +	for (i = 0; i < sys_probes->nr; i++) {
> +		struct damon_sysfs_filters *sys_filters =
> +			sys_probes->probes_arr[i]->filters;
> +		struct damon_probe *c;
> +		int j;
> +
> +		if (!sys_filters)
> +			continue;
> +		c = damon_new_probe();
> +		if (!c)
> +			return -ENOMEM;
> +		damon_add_probe(ctx, c);
> +
> +		for (j = 0; j < sys_filters->nr; j++) {
> +			struct damon_sysfs_filter *sys_filter =
> +				sys_filters->filters_arr[j];
> +			struct damon_filter *t;
Move the declaration of these two variables to the top of the
function.
> +
> +			t = damon_new_filter(sys_filter->type,
> +					sys_filter->matching,
> +					sys_filter->allow);
> +			if (!t)
> +				return -ENOMEM;
> +			damon_add_filter(c, t);
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int damon_sysfs_set_regions(struct damon_target *t,
>  		struct damon_sysfs_regions *sysfs_regions,
>  		unsigned long min_region_sz)
> @@ -1967,6 +2001,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
>  				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
>  	ctx->pause = sys_ctx->pause;
>  	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
> +	if (err)
> +		return err;
> +	err = damon_sysfs_set_probes(ctx, sys_ctx->attrs->probes);
>  	if (err)
>  		return err;
>  	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);

-- 
Asier Gutierrez
Huawei

