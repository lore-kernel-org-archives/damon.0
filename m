Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E75A2A
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 01:26:24 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NhYdp6tvSzkX1s;
	Wed, 28 Dec 2022 09:21:50 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 09:26:22 +0800
Message-ID: <a1e8633d-3338-8d62-4bac-2e54a5808f61@huawei.com>
Date: Wed, 28 Dec 2022 09:26:21 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2 4/7] mm: damon: paddr: convert damon_pa_*() to
 use folios
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <vishal.moola@gmail.com>, <willy@infradead.org>,
	<david@redhat.com>
References: <20221227195004.2809-1-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221227195004.2809-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2022/12/28 3:50, SeongJae Park wrote:
> Hi Kefeng,
> 
>> With damon_get_folio(), let's convert all the damon_pa_*() to use folios.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/damon/paddr.c | 59 +++++++++++++++++++++---------------------------
>>   1 file changed, 26 insertions(+), 33 deletions(-)
>>
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 6334c99e5152..728a96c929fc 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -33,17 +33,15 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
>>   
>>   static void damon_pa_mkold(unsigned long paddr)
>>   {
>> -	struct folio *folio;
>> -	struct page *page = damon_get_page(PHYS_PFN(paddr));
>> +	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
>>   	struct rmap_walk_control rwc = {
>>   		.rmap_one = __damon_pa_mkold,
>>   		.anon_lock = folio_lock_anon_vma_read,
>>   	};
>>   	bool need_lock;
>>   
>> -	if (!page)
>> +	if (!folio)
>>   		return;
>> -	folio = page_folio(page);
>>   
>>   	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
>>   		folio_set_idle(folio);
>> @@ -58,7 +56,6 @@ static void damon_pa_mkold(unsigned long paddr)
>>   
>>   	if (need_lock)
>>   		folio_unlock(folio);
>> -
> 
> Seems unnecessary change?

oh, will drop this change, thanks

> 
> Thanks,
> SJ
