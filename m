Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F83FA5E9
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381697; cv=none; b=sW+eOYJ6C9i4x7ryxCdknCdc4IDvUuH5EpEp/zqIU58xd+VleAHm5v7tEqkOpSiiWvR8g55d4wYWlMHAlv1/5qQBH7v99IvyDeOb5mG9rDqTVSWutDnuAbRagwLTWx9lDc/mN3K5EfAAHvDauEzjUNX+U71bcLRv2Rr8JdzJQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381697; c=relaxed/simple;
	bh=zbbzoKJNLBEQyLMRAGK9bvxUVpwHUjj1Pg7klQus1WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OYuikf7Bzn3DyAMxYkzMRa2mCDBfzCC7FAjXpa6eKBk6vRIpRcla5qd3FTaUJVGtMpZbzVoVbBYGisUbUglPHRHXmZiQ5+5ctv1uAx/FLP90ZgBjbvJCVeKLlsAk5xXd5P0G/oHT5A+73rygiguwUg8H59fBU9Wq7+PfUV8Qal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g4ghK5MYZzHnGjW;
	Tue, 28 Apr 2026 21:07:29 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 937D740569;
	Tue, 28 Apr 2026 21:08:11 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 16:08:11 +0300
Message-ID: <b9bf118d-05e7-4b2d-9442-8568108eb106@huawei-partners.com>
Date: Tue, 28 Apr 2026 16:08:10 +0300
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
References: <20260428004830.113597-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260428004830.113597-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/28/2026 3:48 AM, SeongJae Park wrote:
> Thank you for review, Asier!
> 
> On Mon, 27 Apr 2026 16:25:12 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>>
>>
>> On 4/26/2026 11:52 PM, SeongJae Park wrote:
>>> Add user-installed data probes to DAMON core API parameters, so that
>>> user inputs for data probes are passed to DAMON core.
>>>
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> ---
>>>  mm/damon/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
>>> index 2e0b7eca6bcbf..8007961295d3d 100644
>>> --- a/mm/damon/sysfs.c
>>> +++ b/mm/damon/sysfs.c
>>> @@ -1855,6 +1855,40 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
>>>  	return damon_set_attrs(ctx, &attrs);
>>>  }
>>>  
>>> +static int damon_sysfs_set_probes(struct damon_ctx *ctx,
>>> +		struct damon_sysfs_probes *sys_probes)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < sys_probes->nr; i++) {
>>> +		struct damon_sysfs_filters *sys_filters =
>>> +			sys_probes->probes_arr[i]->filters;
>>> +		struct damon_probe *c;
>>> +		int j;
>>> +
>>> +		if (!sys_filters)
>>> +			continue;
>>> +		c = damon_new_probe();
>>> +		if (!c)
>>> +			return -ENOMEM;
>>> +		damon_add_probe(ctx, c);
>>> +
>>> +		for (j = 0; j < sys_filters->nr; j++) {
>>> +			struct damon_sysfs_filter *sys_filter =
>>> +				sys_filters->filters_arr[j];
>>> +			struct damon_filter *t;
>> Move the declaration of these two variables to the top of the
>> function.
> 
> I have no strong preference, but because this function is not very short, I
> think having declaration here makes reading the code easier.  Also, this style
> is used in multiple places of sysfs.c including damon_sysfs_add_targets().
> 
> So if I'm not missing something and you don't mind, I'd like to keep the
> current style.

Thanks fine. I just got used to declare the variables at the beginning
of the function to help the compiler optimize the code. But modern
compilers may be smart enough to figure it out and optimize the code
anyway.

> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

