Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1635CB8F
	for <damon@lists.linux.dev>; Tue, 24 Mar 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360206; cv=none; b=nmov7A8n6UhHq7cvL040phv+EZkzAZW8uXlyrt75GtzHIjdaEbdurdWRfeWDw2P9wnR5xE+e+DioZg3nV/bU8KBvk/wHY/RpO2/nFQ/qhIgFVWszZ8Y1lk1KXs6jscF8yzwcAsUEh4NQns2AjPbCVFdaYMXZKLeZgV667FKst1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360206; c=relaxed/simple;
	bh=wKkVFhmmmrujf7T1rdRcEqGhgceCF+oxKA5yIqAv7xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZdCdFQTssDdqDViAmN3+/4Uk8je0Ec4oBMwHjYTlMorDM+0TCYCbpoM0marx9qGZKDLgUY/wt/YLVk3UphGzj4M3H/wnddDNl0HcePpNPTYd3SpwZ3ga1NY2aJzAeJc/K0FUJGVT5W4WbO1RUOGHCEyyGGf8JRtoSq592HXPg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgBHJ2l1wzJ46F7;
	Tue, 24 Mar 2026 21:49:48 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 5629E40584;
	Tue, 24 Mar 2026 21:49:55 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 16:49:54 +0300
Message-ID: <b1922673-9900-4c15-a8ca-b086115b1e86@huawei-partners.com>
Date: Tue, 24 Mar 2026 16:49:54 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (sashiko review) [RFC PATCH v2 1/1] mm/damon: support
 MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <ljs@kernel.org>,
	<Liam.Howlett@oracle.com>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20260324004119.87026-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260324004119.87026-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 3/24/2026 3:41 AM, SeongJae Park wrote:
> On Mon, 23 Mar 2026 17:29:36 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
>> Forwarding Sashiko review for doing discussions via mails.
>>
>> # review url: https://sashiko.dev/#/patchset/20260323145646.4165053-2-gutierrez.asier@huawei-partners.com
>> # start of sashiko.dev inline review
>> commit eaed291e6fae91842b1836c68bab867d53525db5
>> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
>>
>> This commit introduces a new DAMON action, DAMOS_COLLAPSE. It allows
>> DAMON to synchronously collapse an address range by calling madvise
>> with MADV_COLLAPSE.
>>
>> Link: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
>>
>> [ ... ]
>>> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
>>> index 3aa5c91548a5..c6476e63f4fb 100755
>>> --- a/tools/testing/selftests/damon/sysfs.py
>>> +++ b/tools/testing/selftests/damon/sysfs.py
>>> @@ -123,11 +123,12 @@ def assert_scheme_committed(scheme, dump):
>>>              'pageout': 2,
>>>              'hugepage': 3,
>>>              'nohugeapge': 4,
>>> -            'lru_prio': 5,
>>> -            'lru_deprio': 6,
>>> -            'migrate_hot': 7,
>>> -            'migrate_cold': 8,
>>> -            'stat': 9,
>>> +            'collapse': 5
>>> +            'lru_prio': 6,
>>
>> Will this cause a Python syntax error when executing the selftest? It looks
>> like there is a missing comma after 'collapse': 5, which might break the
>> execution of the DAMON sysfs test suite.
> 
> I think sashiko is correct.  We need to add a comma.
I will fix it. Missed it, my bad
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

