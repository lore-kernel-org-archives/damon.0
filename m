Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88B519E17
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678440; cv=none; b=TZP/c2KDiNnjOQndLoJ+E2IktBAFhmDY5FuauiTdut2VSTqqxXDV5gG9Yj4UB3K5TOlXsztJN+tVQ+cwQ3LY9fEmi1VPyv/Io00wdDickhQjwEONXBJ1MkGsaHADirP7zFnvOeGs3NjcRj24leBYOK0YLqyl2l8HpBAj18etey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678440; c=relaxed/simple;
	bh=EFp+IIgLsS53IWlkb+HfsQhxHwEld0wQyO9Fu+1g4bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=toHOlfgRTD5OZbR1Y+tlFQrDL99xm4Iu/+GgC6Hve7lCOTwWpdulgfBgrosaua8DMhV/5HiInKDeB1gBG3KH+esSA7ycJoFcWcM4U73Vktb9o4NJ7TYt3Xj1bzWYP6k1DHUZ1G6eJojOSnP+40TArh/K0HntD+TVTewADcQlZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=BomE8Z/A; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="BomE8Z/A"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zV15/2vXc2zmmCBC0wBRxIby3C3ggjhlTWNSwlGL0ro=;
	b=BomE8Z/Agr0yj3ehCeSYnRmn1e64OrhvSs/g1NC/W0zvjSqOBYpNDl8KaxE3XefivF9VN1jBj
	r+XraTw0qNIDUXuOko8ijMpOqXyBBSb+fqu1faPa4dJXTHpL4d0npNsa0q3xkHitf4XVevIs0bE
	cHYdkGcNMgCPtlHy0mPPOZg=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hvDml6Y8jzJ46Xx;
	Tue, 29 Sep 2026 18:24:07 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CA0F4058B;
	Tue, 29 Sep 2026 18:24:22 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 13:24:21 +0300
Message-ID: <9e07dbdd-3b02-4175-b343-c8cb6f9885e0@huawei-partners.com>
Date: Tue, 29 Sep 2026 13:24:20 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm/damon/core: introduce damos_quota_goal->complement
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-2-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260929080113.41708-2-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 9/29/2026 11:01 AM, SJ Park wrote:
> Introduce damos_quota_goal->complement for specifying whether to use a
> complemented value of the given goal target metric.  Add the field to
> the data structure and implement essential core support.  Handle the
> flag in the quota goal commit and current quota goal metric value
> retrieval.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  2 ++
>  mm/damon/core.c       | 26 +++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6a29dc2ac8db..42234839ce29 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -169,6 +169,7 @@ enum damos_quota_goal_metric {
>  /**
>   * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
>   * @metric:		Metric to be used for representing the goal.
> + * @complement:		Use the complement of the metric.
>   * @target_value:	Target value of @metric to achieve with the tuning.
>   * @current_value:	Current value of @metric.
>   * @nid:		Node id.
> @@ -191,6 +192,7 @@ enum damos_quota_goal_metric {
>   */
>  struct damos_quota_goal {
>  	enum damos_quota_goal_metric metric;
> +	bool complement;
>  	unsigned long target_value;
>  	unsigned long current_value;
>  	/* metric-dependent fields */
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 5ecbea5d71e1..1ab5154511e6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1224,6 +1224,7 @@ static int damos_commit_quota_goal(
>  	if (!src->target_value)
>  		return  -EINVAL;
>  	dst->metric = src->metric;
> +	dst->complement = src->complement;
>  	dst->target_value = src->target_value;
>  	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
>  		dst->current_value = src->current_value;
> @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi_total,
>  		struct damos_quota_goal *goal, struct damos *s)
>  {
>  	u64 last_psi_total = goal->last_psi_total;
> +	unsigned long val;
>  
>  	goal->last_psi_total = now_psi_total;
>  	if (last_psi_total != U64_MAX) {
> -		goal->current_value = now_psi_total - last_psi_total;
> +		val = now_psi_total - last_psi_total;
> +		if (goal->complement) {
> +			if (val < s->quota.reset_interval * 1000)
> +				val = s->quota.reset_interval * 1000 - val;
> +			else
> +				val = 0;
> +		}
> +		goal->current_value = val;
>  		return;
>  	}
>  	/* uninitialized last_psi_total; make no effect this round */
> @@ -3255,6 +3264,21 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  	default:
>  		break;
>  	}
> +	if (!goal->complement)
> +		return;
> +
> +	/* updte current_value to complemented value */
There is a typo there. It should be "update". Also, what is the 
purpose of this comment? It doesn't explain anything, which may
not be obvious.> +
> +	/* for user_input, users set complemented value on their own */
> +	if (goal->metric == DAMOS_QUOTA_USER_INPUT)
> +		return;
> +	/* damos_set_psi_current_val() handles complement flag itself */
> +	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> +		return;
> +	if (goal->current_value < 10000)
> +		goal->current_value = 10000 - goal->current_value;
> +	else
> +		goal->current_value = 0;
>  }
>  
>  /* Return the highest score since it makes schemes least aggressive */

-- 
Asier Gutierrez
Huawei

