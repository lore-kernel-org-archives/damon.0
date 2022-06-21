Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD5A28
	for <damon@lists.linux.dev>; Tue, 21 Jun 2022 08:45:42 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VH0dWR7_1655801131;
Received: from 30.97.48.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VH0dWR7_1655801131)
          by smtp.aliyun-inc.com;
          Tue, 21 Jun 2022 16:45:32 +0800
Message-ID: <f79ad32f-50a3-be1a-0cac-d00f579e7077@linux.alibaba.com>
Date: Tue, 21 Jun 2022 16:45:39 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/damon: Use set_huge_pte_at() to make huge pte old
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com,
 songmuchun@bytedance.com, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20220620172742.48766-1-sj@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220620172742.48766-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi SeongJae,

On 6/21/2022 1:27 AM, SeongJae Park wrote:
> Hi Baolin,
> 
> On Mon, 20 Jun 2022 10:34:42 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> The huge_ptep_set_access_flags() can not make the huge pte old according
>> to the discussion [1], that means we will always mornitor the young state
>> of the hugetlb though we stopped accessing the hugetlb, as a result DAMON
>> will get inaccurate accessing statistics.
>>
>> So changing to use set_huge_pte_at() to make the huge pte old to fix this
>> issue.
>>
>> [1] https://lore.kernel.org/all/Yqy97gXI4Nqb7dYo@arm.com/
>>
>> Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
> 
> As the commit has merged in from v5.17, I guess it would be better to do below?
> 
> Cc: <stable@vger.kernel.org>

Yes, thanks for reminding. Hope Andrew can help to add the stable tag 
when picking up this patch.

> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Other than that,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks.
