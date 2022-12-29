Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9510EB
	for <damon@lists.linux.dev>; Thu, 29 Dec 2022 02:17:01 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NjBkM4qZkz9t71;
	Thu, 29 Dec 2022 10:12:59 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 10:16:20 +0800
Message-ID: <b8a22086-0053-1da2-f7b1-2d60f484b800@huawei.com>
Date: Thu, 29 Dec 2022 10:16:19 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v3 0/7] mm: convert page_idle/damon to use folios
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <vishal.moola@gmail.com>, <willy@infradead.org>,
	<david@redhat.com>
References: <20221228175504.149395-1-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221228175504.149395-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2022/12/29 1:55, SeongJae Park wrote:
> Hi Kefeng,
> 
> On Wed, 28 Dec 2022 19:34:06 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> v3:
>> - more thoroughly converting in page_idle_get_folio() suggested by Matthew
>>    also do it in damon_get_folio().
>> - address some commets from SeongJae
>>
>> v2:
>> - drop unsafe pfn_to_online_folio(), convert page_idle_get_page() and
>>    damon_get_page() to return a folio after grab a reference
>> - convert damon hugetlb related functions
>> - rebased on next-20221226.
>>
>> Kefeng Wang (7):
>>    mm: page_idle: Convert page idle to use folios
>>    mm/damon: introduce damon_get_folio()
>>    mm/damon: convert damon_ptep/pmdp_mkold() to use folios
>>    mm/damon: paddr: convert damon_pa_*() to use folios
>>    mm/damon: vaddr: convert damon_young_pmd_entry() to use folio
>>    mm/damon: remove unneed damon_get_page()
>>    mm/damon: vaddr: convert hugetlb related function to use folios
> 
> Thank you so much for your efforts on this work.  I found I forgot mentioning
> some trivial typos in the first, the sixth and the seventh patches, so
> commented.  I should have commented those earlier, sorry.
> 
Oh，please forgive my bad English spelling, and thanks for Andrew with 
corrected word when patches are queued.

> Other than those,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks you very much.


> 
> 
> Thanks,
> SJ
> 
>>
>>   mm/damon/ops-common.c | 38 +++++++++++++++-------------
>>   mm/damon/ops-common.h |  2 +-
>>   mm/damon/paddr.c      | 58 +++++++++++++++++++------------------------
>>   mm/damon/vaddr.c      | 38 ++++++++++++++--------------
>>   mm/page_idle.c        | 47 ++++++++++++++++++-----------------
>>   5 files changed, 91 insertions(+), 92 deletions(-)
>>
>> -- 
>> 2.35.3
>>
