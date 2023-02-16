Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E097B
	for <damon@lists.linux.dev>; Thu, 16 Feb 2023 02:04:35 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VbmFO5J_1676513068;
Received: from 30.97.48.85(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbmFO5J_1676513068)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 10:04:29 +0800
Message-ID: <cca8918f-e8c2-8f2c-cbb9-5797631ab3eb@linux.alibaba.com>
Date: Thu, 16 Feb 2023 10:04:29 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, naoya.horiguchi@nec.com,
 linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
 mike.kravetz@oracle.com, willy@infradead.org, damon@lists.linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230215202548.92462-1-sj@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230215202548.92462-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/2023 4:25 AM, SeongJae Park wrote:
> On Wed, 15 Feb 2023 18:39:36 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
>> care about the negative value, thus we can convert the isolate_hugetlb()
>> to return a boolean value to make code more clear when checking the
>> hugetlb isolation state. Moreover converts 2 users which will consider
>> the negative value returned by isolate_hugetlb().
>>
>> No functional changes intended.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
> [...]
>>   include/linux/hugetlb.h |  6 +++---
>>   mm/hugetlb.c            | 13 ++++++++-----
>>   mm/memory-failure.c     |  2 +-
>>   mm/mempolicy.c          |  2 +-
>>   mm/migrate.c            |  7 +++----
>>   5 files changed, 16 insertions(+), 14 deletions(-)
>>
> [...]
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 3a01a9dbf445..16513cd23d5d 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2925,13 +2925,16 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
>>   		 */
>>   		goto free_new;
>>   	} else if (folio_ref_count(old_folio)) {
>> +		bool isolated;
>> +
>>   		/*
>>   		 * Someone has grabbed the folio, try to isolate it here.
>>   		 * Fail with -EBUSY if not possible.
>>   		 */
>>   		spin_unlock_irq(&hugetlb_lock);
>> -		ret = isolate_hugetlb(old_folio, list);
>> +		isolated = isolate_hugetlb(old_folio, list);
>>   		spin_lock_irq(&hugetlb_lock);
>> +		ret = isolated ? 0 : -EBUSY;
>>   		goto free_new;
> 
> Nit.  I'd personally prefer to set 'ret' before entering this critical section
> to keep the section short, but this would be just a mean comment that wouldn't
> worth request respin.

Yes, good catch. And I see Andrew has helped to do this (Thanks Andrew).

Thanks for reviewing.
