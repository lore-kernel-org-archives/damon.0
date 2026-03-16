Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203911EDA32
	for <damon@lists.linux.dev>; Mon, 16 Mar 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644637; cv=none; b=rI1eqQP9L6MYNsoJo54JVDdOPGCC5BD8EuOdH0thFD7iqUVy34foihmvbYJwe3Ca5ZasF3fYpvqBV1sfBcnUmfrrMQzTKeK59NKQmYVLJ0hT2ubUVzFVhkxpuuxoSspaB+e9MM2C315ki+XG83QdJkVibTn71xPnPYCWV8hqRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644637; c=relaxed/simple;
	bh=L/zNqJBvev2JM3221xuETJU1Q5vcPaTuyGVhY/2nzPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VZItiOJKKdOAJRUUWPuSzHZTBPafPBXqDe12vRHNZYJk64hSMNdyUxGQw2IuqAXEnUr6d3jwCeLSB3CSQAUOFArNWdGNUK9NmL0qvpLnPAQouP2TGK2NWQ2RhIsAzLqiE6jFlmy7/44n6UVkcAmr80qn5U/NmwlpZGxHWpIViQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZ5dR06FQzJ46CZ;
	Mon, 16 Mar 2026 15:02:51 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 1229F4056A;
	Mon, 16 Mar 2026 15:03:45 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 10:03:44 +0300
Message-ID: <66131775-180b-4b9f-b7ce-61a3e077b6e6@huawei-partners.com>
Date: Mon, 16 Mar 2026 10:03:43 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/damon: guard THP-specific DAMOS actions with
 CONFIG_TRANSPARENT_HUGEPAGE
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260314165156.86647-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260314165156.86647-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 3/14/2026 7:51 PM, SeongJae Park wrote:
> Hello Asier,
> 
> On Sat, 14 Mar 2026 09:38:12 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> MADV_HUGEPAGE and MADV_NOHUGEPAGE are guarded and they are not
>> available when compiling the kernel without TRANSPARENT_HUGEPAGE
>> option. Therefore, DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE shouldn't be
>> available to the user either.
> 
> That makes many sense to me.  But, I'd prefer having ifdef as minimum as
> possible because ifdef increases amount of code that I need to maintain per
> different configurations.  I understand use of ifdef can make the resulting
> kernel image more optimized.  But, unless the benefit of optimization is
> obviously big enough, I'd prefer simplicity of the code in general.
> 
> When TRASPARENT_HUGEPAGE is off, DAMOS_[NO]HUGEPAGE will just silently fail.  I
> think that's not a bad user experience if the silently fail is kindly informed.
> How about updating document for that, but keeping the code as is?
> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> ---
>>  Documentation/mm/damon/design.rst | 6 ++++--
>>  include/linux/damon.h             | 2 ++
>>  mm/damon/sysfs-schemes.c          | 2 ++
>>  mm/damon/vaddr.c                  | 2 ++
>>  4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
>> index 29fff20b3c2a..207219ee10d4 100644
>> --- a/Documentation/mm/damon/design.rst
>> +++ b/Documentation/mm/damon/design.rst
>> @@ -460,9 +460,11 @@ that supports each action are as below.
>>   - ``pageout``: Reclaim the region.
>>     Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
>>   - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
>> -   Supported by ``vaddr`` and ``fvaddr`` operations set.
>> +   Supported by ``vaddr`` and ``fvaddr`` operations set when
>> +   TRANSPARENT_HUGEPAGE is enabled.
>>   - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
>> -   Supported by ``vaddr`` and ``fvaddr`` operations set.
>> +   Supported by ``vaddr`` and ``fvaddr`` operations set when
>> +   TRANSPARENT_HUGEPAGE is enabled.
> 
> I like the above change.  I'd suggest make it just describe the current
> behavior in a better way.  E.g., "Supported by vaddr and fvaddr.  When
> CONFIG_TRANSPARENT_HUGEPAG is disabled, however, the application of the action
> will just fail always.
> 
>>   - ``lru_prio``: Prioritize the region on its LRU lists.
>>     Supported by ``paddr`` operations set.
>>   - ``lru_deprio``: Deprioritize the region on its LRU lists.
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 3a441fbca170..b3fcbe84b5d7 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -138,8 +138,10 @@ enum damos_action {
>>  	DAMOS_WILLNEED,
>>  	DAMOS_COLD,
>>  	DAMOS_PAGEOUT,
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  	DAMOS_HUGEPAGE,
>>  	DAMOS_NOHUGEPAGE,
>> +#endif
>>  	DAMOS_LRU_PRIO,
>>  	DAMOS_LRU_DEPRIO,
>>  	DAMOS_MIGRATE_HOT,
> 
> Also, sashiko.dev commented [1] some conrens as below:
> 
> '''
> Does adding this #ifdef shift the integer values of subsequent actions like
> DAMOS_STAT when CONFIG_TRANSPARENT_HUGEPAGE is disabled?
> The kernel selftest tools/testing/selftests/damon/sysfs.py uses drgn to read
> the internal damos->action enum value and expects hardcoded integer values
> (such as 'stat': 9).
> Additionally, modifying enum layouts based on kernel configuration can break
> BPF and drgn tracing tools that rely on stable DWARF/BTF types.
> '''
> 
That's a good catch, I didn't think about it.
> There is no selftest using DAMOS action that defined after DAMOS_HUGEPAGE, so
> this change should be _safe_.  But the code does have a hard-coded mapping of
> DAMOS action to value, in sysfs.py file under the DAMON selftests directory.
> Maintaining it correctly with future tests for different configuration may be
> challenging.
> 
> So I'd again prefer not adding ifdef.
> 
> [...]
> 
> To summarize again, how about fixing the document but keeping the code as is?
If the expected behaviour is to silently fail, I agree, documenting this
should be the best option. I will submit a new patch with the documentation
update.
> 
> [1] https://sashiko.dev/#/patchset/20260314093813.1359737-1-gutierrez.asier%40huawei-partners.com
> 
> 
> Thanks,
> SJ
> 

-- 
Asier Gutierrez
Huawei

