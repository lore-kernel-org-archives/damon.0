Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326167E
	for <damon@lists.linux.dev>; Mon,  6 Mar 2023 01:10:44 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVL6G5K44znWg5;
	Mon,  6 Mar 2023 09:07:50 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 09:10:36 +0800
Message-ID: <04645c9e-2188-da5c-30da-4c4694c7283c@huawei.com>
Date: Mon, 6 Mar 2023 09:10:35 +0800
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
References: <20230303183925.113520-1-sj@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230303183925.113520-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected



On 2023/3/4 2:39, SeongJae Park wrote:
> Hi Kefeng,
> 
> On Fri, 3 Mar 2023 16:43:42 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Omit three lines by unified folio_put(), and make code more clear.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/damon/paddr.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 3fda00a0f786..2ef9db0189ca 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
>>   			accessed = false;
>>   		else
>>   			accessed = true;
>> -		folio_put(folio);
>>   		goto out;
> 
> Because you moved 'out' label to not include *folio_sz setting, folio_sz will
> not set in this case.  It should be set.
oh, it should be fixed.
> 
>>   	}
>>   
>>   	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
>> -	if (need_lock && !folio_trylock(folio)) {
>> -		folio_put(folio);
>> -		return false;
>> -	}
>> +	if (need_lock && !folio_trylock(folio))
>> +		goto out;
>>   
>>   	rmap_walk(folio, &rwc);
>>   
>>   	if (need_lock)
>>   		folio_unlock(folio);
>> -	folio_put(folio);
>>   
>> -out:
>>   	*folio_sz = folio_size(folio);
>> +out:
>> +	folio_put(folio);
> 
> Before this change, folio_size() is called after folio_put().  Shouldn't it be
> called before folio_put()?  If so, could we make a separate fix for that first,
> and then make this change on top of it, so that it can be easily applied to
> relevant stable kernels?
> 
Yes， I could separate it, after folio_put(), the folio could be 
re-allocated and the folio_size calculation is not right.
> 
> Thanks,
> SJ
> 
>>   	return accessed;
>>   }
>>   
>> -- 
>> 2.35.3
>>
>>
