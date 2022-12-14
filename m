Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43F7F
	for <damon@lists.linux.dev>; Wed, 14 Dec 2022 01:10:10 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWy1c43YRzlW11;
	Wed, 14 Dec 2022 09:09:08 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 09:10:06 +0800
Message-ID: <8693c37b-f709-4c63-eac6-418c32b80e7e@huawei.com>
Date: Wed, 14 Dec 2022 09:10:06 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, SeongJae
 Park <sj@kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<damon@lists.linux.dev>, <vishal.moola@gmail.com>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-2-wangkefeng.wang@huawei.com>
 <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
 <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
 <Y5iQkmjj1ISoTWAF@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y5iQkmjj1ISoTWAF@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected


On 2022/12/13 22:47, Matthew Wilcox wrote:
> On Tue, Dec 13, 2022 at 08:13:31PM +0800, Kefeng Wang wrote:
>> On 2022/12/13 19:40, David Hildenbrand wrote:
>>> On 13.12.22 10:27, Kefeng Wang wrote:
>>>> Introduce a wrapper function pfn_to_online_folio(), which calls
>>>> pfn_to_online_page() and returns the folio of the page found,
>>>> or null if no page.
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>    include/linux/memory_hotplug.h | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/linux/memory_hotplug.h
>>>> b/include/linux/memory_hotplug.h
>>>> index 9fcbf5706595..e841e4fb52a7 100644
>>>> --- a/include/linux/memory_hotplug.h
>>>> +++ b/include/linux/memory_hotplug.h
>>>> @@ -265,6 +265,13 @@ static inline void
>>>> pgdat_kswapd_unlock(pg_data_t *pgdat) {}
>>>>    static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
>>>>    #endif /* ! CONFIG_MEMORY_HOTPLUG */
>>>>    +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
>>>> +{
>>>> +    struct page *page = pfn_to_online_page(pfn);
>>>> +
>>>> +    return page ? page_folio(page) : NULL;
>>>> +}
>>> Who guarantees that page_folio() is safe and stable at that point?
>>>
>>> IIRC, that's very tricky. We could have the page concurrently getting
>>> freed and the folio dissolved.
>> So the caller should consider this,  lock or get the folio in the caller?
> The caller only has a pfn; it doesn't have the folio at the time of
> the call.  David is right, this function cannot safely exist.
Thanks fro all the advises from David/Matthew/SeongJae,  will rethink 
this converting.
>
