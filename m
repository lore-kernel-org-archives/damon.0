Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E27C
	for <damon@lists.linux.dev>; Wed,  8 Mar 2023 01:03:19 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PWYrk5DBCz16Nxd;
	Wed,  8 Mar 2023 09:00:22 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 09:03:09 +0800
Message-ID: <4f0970e5-1a9d-4e07-c368-5a96a6da9e71@huawei.com>
Date: Wed, 8 Mar 2023 09:03:09 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/3] mm/damon/paddr: minor refactor of damon_pa_young()
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>
References: <20230307180023.152415-1-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230307180023.152415-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2023/3/8 2:00, SeongJae Park wrote:
> On Tue, 7 Mar 2023 09:22:33 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>>
>>
>> On 2023/3/7 5:27, SeongJae Park wrote:
>>> Hi Kefeng,
>>>
>>> On Mon, 6 Mar 2023 09:56:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>>>
>>>>
>>>> On 2023/3/6 9:10, Kefeng Wang wrote:
>>>>>
>>>>>
>>>>> On 2023/3/4 2:39, SeongJae Park wrote:
>>>>>> Hi Kefeng,
>>>>>>
>>>>>> On Fri, 3 Mar 2023 16:43:42 +0800 Kefeng Wang
>>>>>> <wangkefeng.wang@huawei.com> wrote:
>>>>>>
>>>>>>> Omit three lines by unified folio_put(), and make code more clear.
>>>>>>>
>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>> ---
>>>>>>>     mm/damon/paddr.c | 11 ++++-------
>>>>>>>     1 file changed, 4 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>>>>>> index 3fda00a0f786..2ef9db0189ca 100644
>>>>>>> --- a/mm/damon/paddr.c
>>>>>>> +++ b/mm/damon/paddr.c
>>>>>>> @@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr,
>>>>>>> unsigned long *folio_sz)
>>>>>>>                 accessed = false;
>>>>>>>             else
>>>>>>>                 accessed = true;
>>>>>>> -        folio_put(folio);
>>>>>>>             goto out;
>>>>>>
>>>>>> Because you moved 'out' label to not include *folio_sz setting,
>>>>>> folio_sz will
>>>>>> not set in this case.  It should be set.
>>>>> oh, it should be fixed.
>>>>>>
>>>>>>>         }
>>>>>>>         need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
>>>>>>> -    if (need_lock && !folio_trylock(folio)) {
>>>>>>> -        folio_put(folio);
>>>>>>> -        return false;
>>>>>>> -    }
>>>>
>>>> Hi SJ,  apart from above issue, it looks that this branch need the
>>>> folio_size() setting, right?
>>>
>>> folio_sz is effectively used by caller of damon_pa_young() only if this
>>> function returns true, so this branch doesn't need to set folio_sz.
>>
>> __damon_pa_check_access() store last_addr, last_accessed and
>> last_folio_sz, even damon_pa_young() return false, the following check
>> still use last_folio_sz,
>>
>>     ALIGN_DOWN(last_addr, last_folio_sz) == ALIGN_DOWN(r->sampling_addr,
>> last_folio_sz)
>>
>> but last_folio_sz is not up to date, so I think it need to update, and
>> update last_folio_sz is harmless, which could let's unify the return
>> path, correct me if I am wrong.
> 
> Ah, you're right.  Thank you for kind explanation.  I was out of my mind for
> some reason.  Maybe we could just do 'goto out' in the branch.

Yes, will update this patchset with this change.
> 
> 
> Thanks,
> SJ
