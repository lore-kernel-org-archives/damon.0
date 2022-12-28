Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B4A2A
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 02:06:24 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NhZWy1ZvNzkX25;
	Wed, 28 Dec 2022 10:01:50 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 10:06:21 +0800
Message-ID: <f6741372-de20-0fea-a876-07dc4248356a@huawei.com>
Date: Wed, 28 Dec 2022 10:06:20 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2 2/7] mm: damon: introduce damon_get_folio()
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <vishal.moola@gmail.com>, <willy@infradead.org>,
	<david@redhat.com>
References: <20221227194257.2744-1-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221227194257.2744-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2022/12/28 3:42, SeongJae Park wrote:
> Hi Kefeng,
> 
> Could we use 'mm/damon:' prefix instead of 'mm: damon:' for the patch subjects?

Sure.

> 
> On Tue, 27 Dec 2022 20:27:09 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Introduce damon_get_folio(), and the temporary wrapper function
>> damon_get_page(), which help us to convert damon related function
>> to use folios, and it will be droped once the conversion is completed.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/damon/ops-common.c | 14 ++++++++------
>>   mm/damon/ops-common.h |  8 +++++++-
>>   2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
>> index 75409601f934..ff38a19aa92e 100644
>> --- a/mm/damon/ops-common.c
>> +++ b/mm/damon/ops-common.c
>> @@ -16,21 +16,23 @@
>>    * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
>>    * NULL.
>>    *
>> - * The body of this function is stolen from the 'page_idle_get_page()'.  We
>> + * The body of this function is stolen from the 'page_idle_get_folio()'.  We
>>    * steal rather than reuse it because the code is quite simple.
>>    */
>> -struct page *damon_get_page(unsigned long pfn)
>> +struct folio *damon_get_folio(unsigned long pfn)
>>   {
>>   	struct page *page = pfn_to_online_page(pfn);
>> +	struct folio *folio;
>>   
>>   	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
>>   		return NULL;
>>   
>> -	if (unlikely(!PageLRU(page))) {
>> -		put_page(page);
>> -		page = NULL;
>> +	folio = page_folio(page);
>> +	if (unlikely(!folio_test_lru(folio))) {
>> +		folio_put(folio);
>> +		folio = NULL;
>>   	}
> 
> I think Matthew's comment for 'page_idle_get_folio()'[1] could applied here?
> 

Will change too.

> 
> [1] https://lore.kernel.org/damon/Y6s2HPjrON2Sx%2Fgr@casper.infradead.org/
> 
>> -	return page;
>> +	return folio;
>>   }
>>   
>>   void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
>> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
>> index 8d82d3722204..4ee607813981 100644
>> --- a/mm/damon/ops-common.h
>> +++ b/mm/damon/ops-common.h
>> @@ -7,7 +7,13 @@
>>   
>>   #include <linux/damon.h>
>>   
>> -struct page *damon_get_page(unsigned long pfn);
>> +struct folio *damon_get_folio(unsigned long pfn);
>> +static inline struct page *damon_get_page(unsigned long pfn)
>> +{
>> +	struct folio *folio = damon_get_folio(pfn);
>> +
>> +	return &folio->page;
> 
> I think we should check if folio is NULL before dereferencing it?

I could add comment here, thanks.

> 
>> +}
>>   
>>   void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
>>   void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
>> -- 
>> 2.35.3
>>
