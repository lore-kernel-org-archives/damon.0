Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E542983A
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381988; cv=none; b=TPUEMflXjmYjMVpqq4oHoi9YOV8DeFH237IDCrjV+WGcrvaARdhtYl23Wr7xm1eMm0SY5tJ2swFWgmt59xe6EmNCLTLOVJqzngpfwRTL+gNfEKuHCvyj3rS1CiHqP8eJJEWIPtCmodDCg+SoAX8+0iWIDFzcplZ3vV4m7SR1xxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381988; c=relaxed/simple;
	bh=mjnd9xaXoR6IdNAM1UcKszLrnuL2KK8UJmy4iBgMEno=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CCQMgfsWdI+jhIP46thl8xCL7PGkcD70/4mNKcAcyqLZIR3NHm7GZHSxOy6/oY6EIvKXiF9uRcvtGyC6xexPvoe5jnxR+mZWpGDgzlTTWC3v9otXWbiS/XeqZGTMjOOlwz8+rltIYNBDqcYg5mvQp5fgQ1I4r02Q4jQCH0xOm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g4gnz35sLzHnH5d;
	Tue, 28 Apr 2026 21:12:23 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 47D2140571;
	Tue, 28 Apr 2026 21:13:05 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 16:13:04 +0300
Message-ID: <246657e0-62b0-45e6-88e5-b3a770cea3aa@huawei-partners.com>
Date: Tue, 28 Apr 2026 16:13:04 +0300
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
References: <20260428003914.113299-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260428003914.113299-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/28/2026 3:39 AM, SeongJae Park wrote:
> Thank you for reviewing, Asier!
> 
> On Mon, 27 Apr 2026 16:21:19 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>>
>>
>> On 4/26/2026 11:52 PM, SeongJae Park wrote:
>>> Update damon_commit_ctx() to commit installed data probes, too.
>>>
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> ---
> [...]
>>> +static int damon_commit_filters(struct damon_probe *dst,
>>> +		struct damon_probe *src)
>>> +{
>>> +	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
>>> +	int i = 0, j = 0;
>>> +
>>> +	damon_for_each_filter_safe(dst_filter, next, dst) {
>>> +		src_filter = damon_nth_filter(i++, src);
>>> +		if (src_filter)
>>> +			damon_commit_filter(dst_filter, src_filter);
>>> +		else
>>> +			damon_destroy_filter(dst_filter);
>>> +	}
>>> +
>>> +	damon_for_each_filter_safe(src_filter, next, src) {
>>> +		if (j++ < i)
>>> +			continue;
>>> +
>>> +		new_filter = damon_new_filter(src_filter->type,
>>> +				src_filter->matching, src_filter->allow);
>>> +		if (!new_filter)
>>> +			return -ENOMEM;
>> We should bail out here. If we return an error, we have already
>> committed some of the filters already. If there is an error, we
>> should remove any fill that was already added.
> 
> The cleanup will be done by the caller.  That is, damon_commit_ctx() caller
> should destroy the ctx when the return value is imposing a commit failure.
> 

Acked. I reviewed all the callers for damon_commit_ctx, and you are right,
they all destroy ctx in case of an error.

>>> +		damon_add_filter(dst, new_filter);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
>>> +{
>>> +	struct damon_probe *dst_probe, *next, *src_probe, *new_probe;
>>> +	int i = 0, j = 0, err;
>>> +
>>> +	damon_for_each_probe_safe(dst_probe, next, dst) {
>>> +		src_probe = damon_nth_probe(i++, src);
>>> +		if (src_probe) {
>>> +			err = damon_commit_filters(dst_probe, src_probe);
>>> +			if (err)
>>> +				return err;
>>> +		} else {
>>> +			damon_destroy_probe(dst_probe);
>>> +		}
>>> +	}
>>> +
>>> +	damon_for_each_probe_safe(src_probe, next, src) {
>>> +		if (j++ < i)
>>> +			continue;
>>> +
>>> +		new_probe = damon_new_probe();
>>> +		if (!new_probe)
>>> +			return -ENOMEM;
>> The same as before, we should bail out.
> 
> Ditto.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

