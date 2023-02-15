Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063D195
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 01:04:14 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VbhhtKI_1676423044;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbhhtKI_1676423044)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 09:04:05 +0800
Message-ID: <3180bded-7beb-c994-7f13-2d75eeb82516@linux.alibaba.com>
Date: Wed, 15 Feb 2023 09:04:04 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/4] mm: change to return bool for isolate_lru_page()
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, naoya.horiguchi@nec.com,
 linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
 mike.kravetz@oracle.com, willy@infradead.org, damon@lists.linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230214193204.72057-1-sj@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230214193204.72057-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/15/2023 3:32 AM, SeongJae Park wrote:
> On Tue, 14 Feb 2023 21:59:30 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> The isolate_lru_page() can only return 0 or -EBUSY, and most users did
>> not care about the negative error of isolate_lru_page(), except one user
>> in add_page_for_migration(). So we can convert the isolate_lru_page() to
>> return a boolean value, which can help to make the code more clear when
>> checking the return value of isolate_lru_page().
>>
>> Also convert all users' logic of checking the isolation state.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/folio-compat.c   | 12 +++---------
>>   mm/internal.h       |  2 +-
>>   mm/khugepaged.c     |  2 +-
>>   mm/memcontrol.c     |  4 ++--
>>   mm/memory-failure.c |  4 ++--
>>   mm/memory_hotplug.c |  2 +-
>>   mm/migrate.c        |  9 ++++++---
>>   mm/migrate_device.c |  2 +-
>>   8 files changed, 17 insertions(+), 20 deletions(-)
>>
> [...]
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index a1e8c3e9ab08..17ed80707518 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1668,7 +1668,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   		 * LRU and non-lru movable pages.
>>   		 */
>>   		if (PageLRU(page))
>> -			ret = isolate_lru_page(page);
>> +			ret = !isolate_lru_page(page);
> 
> This may change return value of this function.  That is, this function will
> return 1 instead of -EBUSY after this change.  It's not a real issue as no
> caller of this function takes care of the return value, though.

Yes, I've also thought about this. OK, I can keep the original logic 
here by adding a new variable. Thanks.

isolated = isolate_lru_page(page);
ret = isolated ? 0 : -EBUSY;
