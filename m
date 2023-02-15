Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88715AD
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 01:06:54 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vbhgqjj_1676423204;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbhgqjj_1676423204)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 09:06:45 +0800
Message-ID: <76f1e8d2-1ef0-4317-061b-c7de33f20626@linux.alibaba.com>
Date: Wed, 15 Feb 2023 09:06:44 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
To: Mike Kravetz <mike.kravetz@oracle.com>, SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeelb@google.com, muchun.song@linux.dev, naoya.horiguchi@nec.com,
 linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
 willy@infradead.org, damon@lists.linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230214180324.71585-1-sj@kernel.org>
 <20230214180708.71645-1-sj@kernel.org> <Y+vRK7kYP0xVZ9Ya@monkey>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y+vRK7kYP0xVZ9Ya@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/15/2023 2:21 AM, Mike Kravetz wrote:
> On 02/14/23 18:07, SeongJae Park wrote:
>> On Tue, 14 Feb 2023 18:03:24 +0000 SeongJae Park <sj@kernel.org> wrote:
>>
>>> On Tue, 14 Feb 2023 21:59:31 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
>>>> care about the negative value, thus we can convert the isolate_hugetlb()
>>>> to return a boolean value to make code more clear when checking the
>>>> hugetlb isolation state. Moreover converts 2 users which will consider
>>>> the negative value returned by isolate_hugetlb().
>>>>
>>>> No functional changes intended.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>   include/linux/hugetlb.h |  6 +++---
>>>>   mm/hugetlb.c            | 12 ++++++++----
>>>>   mm/memory-failure.c     |  2 +-
>>>>   mm/mempolicy.c          |  2 +-
>>>>   mm/migrate.c            |  2 +-
>>>>   5 files changed, 14 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index df6dd624ccfe..5f5e4177b2e0 100644
>> [...]
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 53010a142e7f..c5136fa48638 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2128,7 +2128,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>>   		if (PageHead(page)) {
>>>>   			err = isolate_hugetlb(page_folio(page), pagelist);
>>>>   			if (!err)
>>>> -				err = 1;
>>>> +				err = -EBUSY;
>>>
>>> Again, I think this is confusing.  'err' is 'bool', not 'int'.
>>
>> I mean, 'err' is not 'bool' but 'int', sorry.  See? This confuses me ;)
>>
> 
> Yes,
> in the case here (and elsewhere) I like David's suggestion of using a separate
> bool such as 'isolated' to capture the return value of the isolate function.
> Then, the statement:
> 
> 	err = isolated ? 0 : -EBUSY;
> 
> would be pretty clear.

Yes, much better, will do. Thanks.
