Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F08A2A
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 01:18:30 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NhYXZ6bbtzJqkC;
	Wed, 28 Dec 2022 09:17:18 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 09:18:24 +0800
Message-ID: <0afd9944-d30a-c3e0-0fa3-4f609c49af84@huawei.com>
Date: Wed, 28 Dec 2022 09:18:23 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2 1/7] mm: page_idle: Convert page idle to use
 folios
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>, <vishal.moola@gmail.com>,
	<david@redhat.com>
References: <20221227122714.161224-1-wangkefeng.wang@huawei.com>
 <20221227122714.161224-2-wangkefeng.wang@huawei.com>
 <Y6s2HPjrON2Sx/gr@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y6s2HPjrON2Sx/gr@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2022/12/28 2:14, Matthew Wilcox wrote:
> On Tue, Dec 27, 2022 at 08:27:08PM +0800, Kefeng Wang wrote:
>> -static struct page *page_idle_get_page(unsigned long pfn)
>> +static struct folio *page_idle_get_folio(unsigned long pfn)
>>   {
>>   	struct page *page = pfn_to_online_page(pfn);
>> +	struct folio *folio;
>>   
>> -	if (!page || !PageLRU(page) ||
>> -	    !get_page_unless_zero(page))
>> +	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
>>   		return NULL;
> 
> Mmmm, no.  PageLRU hides a compound_head() call.  Try doing this instead:
> 
> 	if (!page || PageTail(page))
> 		return NULL;
> 	folio = page_folio(page);
> 	if (!folio_test_lru(folio) || !folio_try_get(folio))
> 		return NULL;
> 	if (page_folio(page) != folio || !folio_test_lru(folio)) {
> 		folio_put(folio);
> 		folio = NULL;
> 	}
> 
Thanks Matthew, this is more complete, will update.
> 	return NULL;
> 
> 
