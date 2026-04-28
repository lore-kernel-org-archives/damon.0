Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24C42E01B
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381822; cv=none; b=eqSzRq4uqIXcudWGaSDiI1vcXCvuqbRp7IZPCk55VHeMMgczDiTJ6lUk+sEgzzTtg+qCc7edS04iS+2xKvuRi8zVlCqJl5Bhb1F50iAo4sRJ485hq6TbVUGcmq1NlIFQuDytUgQioSKhYkMLsu2PDjjpeKvEuZNWCA3U3NH0Soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381822; c=relaxed/simple;
	bh=5EK/Al9mZnq5gBqeyW4xxHlTPmUl4OLMnUVAolLI2Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VKCOMoZwd0U/xwnE4v+sPxKVPADuXGPDmBVVeLAFpH7FJzI8Ji+35fijecvWrQvBESX5w8IVlviLbIx/jdjx0O9LGDBSpTDpnhqUVfaDAdX2kKfyfCCc+hYqtakv5EVPODvExmXmqzj1L9Ly1qhE6HPH//xKkeHP8Oml8P+fzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g4glW0psdzJ46bk;
	Tue, 28 Apr 2026 21:10:15 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F5AC40574;
	Tue, 28 Apr 2026 21:10:19 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 16:10:18 +0300
Message-ID: <69c46d43-c283-4064-9347-817841e532e6@huawei-partners.com>
Date: Tue, 28 Apr 2026 16:10:18 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/19] mm/damon/sysfs: implement filter dir files
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260428004454.113463-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260428004454.113463-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/28/2026 3:44 AM, SeongJae Park wrote:
> On Mon, 27 Apr 2026 16:24:10 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>>
>>
>> On 4/26/2026 11:52 PM, SeongJae Park wrote:
>>> Implement sysfs files under the data probe filter directory for letting
>>> users to configure each filter.
>>>
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> ---
> [...]
>>> +static ssize_t type_show(struct kobject *kobj,
>>> +		struct kobj_attribute *attr, char *buf)
>>> +{
>>> +	struct damon_sysfs_filter *filter = container_of(kobj,
>>> +			struct damon_sysfs_filter, kobj);
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(damon_sysfs_filter_type_names); i++) {
>>> +		const struct damon_sysfs_filter_type_name *type_name;
>> Can we move this declaration to the top of the function?
> 
> Unfortunately other parts of sysfs.c and sysfs-schemes.c including
> operations_show/store(), type_show/sotre(), metric_show/store()  are also using
> this pattern.  I'd like to keep the style consistency, if I'm not missing
> something and you don't mind.

Yes, it makes sense to keep the code consistent.

> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

