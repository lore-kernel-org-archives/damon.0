Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E087B
	for <damon@lists.linux.dev>; Thu, 16 Feb 2023 02:07:14 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VbmFOuB_1676513225;
Received: from 30.97.48.85(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbmFOuB_1676513225)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 10:07:06 +0800
Message-ID: <baf51a97-0d28-119a-691a-e3ecb799d806@linux.alibaba.com>
Date: Thu, 16 Feb 2023 10:07:05 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 4/4] mm: change to return bool for
 isolate_movable_page()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sj@kernel.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, naoya.horiguchi@nec.com,
 linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
 mike.kravetz@oracle.com, damon@lists.linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <cb877f73f4fff8d309611082ec740a7065b1ade0.1676424378.git.baolin.wang@linux.alibaba.com>
 <Y+z91pcxAuygc92J@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y+z91pcxAuygc92J@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/15/2023 11:44 PM, Matthew Wilcox wrote:
> On Wed, Feb 15, 2023 at 06:39:37PM +0800, Baolin Wang wrote:
>> Now the isolate_movable_page() can only return 0 or -EBUSY, and no users
>> will care about the negative return value, thus we can convert the
>> isolate_movable_page() to return a boolean value to make the code more
>> clear when checking the movable page isolation state.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> A couple of nits below, not worth respinning the patch series for:
> 
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index c88b96b48be7..6b252f519c86 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -71,7 +71,7 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>>   		unsigned long private, enum migrate_mode mode, int reason,
>>   		unsigned int *ret_succeeded);
>>   extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>> -extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>> +extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
> 
> You can drop the 'extern' here.
> 
>> +++ b/mm/memory_hotplug.c
>> @@ -1668,18 +1668,18 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   		 * We can skip free pages. And we can deal with pages on
>>   		 * LRU and non-lru movable pages.
>>   		 */
>> -		if (PageLRU(page)) {
>> +		if (PageLRU(page))
>>   			isolated = isolate_lru_page(page);
>> -			ret = isolated ? 0 : -EBUSY;
>> -		} else
>> -			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>> -		if (!ret) { /* Success */
>> +		else
>> +			isolated = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>> +		if (isolated) { /* Success */
> 
> I would have dropped the "/* Success */" here.  Before, commenting
> "!ret" is quite sensible, but "isolated" seems obviously success to me.

Right. Hope Andrew can help to drop this unnecessary comment:)

Thanks for reviewing.
