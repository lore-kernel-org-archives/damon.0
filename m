Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBE34D907
	for <damon@lists.linux.dev>; Wed,  4 Mar 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619500; cv=none; b=oeNtRnbXMUbhRm/Vzl+DAsf9nEsswiPvIpK7u2Drsm7Bsix/izv8ta1gYepEdO+mEWgRlNBq89NU6qmKkfztTIYyYvig1LPOJgnXNtvj0pxfQdCat3Utr5dzSMVgkyXDMb0Awv5ryCVEA9IygPnYkZ7eeh/5fq8enwkeYsIL+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619500; c=relaxed/simple;
	bh=0zn+LbproCpNWENeZ/zrbO6FPbtiD/kK+psmwahvqCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CW3EsA/Jio6dQwcDRLPhLmhyPTLhn1elfssxfq3Y55AS2tOLcH57FqnIgeOGaG7AUznnLlZ7bzJY687dqKScCtwdZg74gfDN1A0toCLa0Wkg3GuDG49s8WejqH3mmABhsTKhgxQHIQ0kb0EFQkQ23a0xVb3+OThnvwJ0EmOC6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQpWP5v7jzHnHGQ;
	Wed,  4 Mar 2026 18:17:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AA2D40569;
	Wed,  4 Mar 2026 18:18:17 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 13:18:16 +0300
Message-ID: <abdb1acc-5f88-483f-af49-45276ab66ff0@huawei-partners.com>
Date: Wed, 4 Mar 2026 13:18:16 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/10] mm/damon/core: allow quota goals set zero
 effective size quota
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260304044122.79394-1-sj@kernel.org>
 <20260304044122.79394-3-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260304044122.79394-3-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 3/4/2026 7:41 AM, SeongJae Park wrote:

I find the name of this function confusing. The function doesn't
actually set anything. Maybe better damos_quota_is_set()
> +/*
> + * damos_quota_set() - Return if the given quota is actually set.
> + * @quota:	The quota to check.
> + *
> + * Returns true if the quota is set, false otherwise.
> + */
> +static bool damos_quota_set(struct damos_quota *quota)
> +{
> +	return quota->esz || quota->sz || quota->ms ||
> +		!damos_quota_goals_empty(quota);
> +}
> +


-- 
Asier Gutierrez
Huawei

