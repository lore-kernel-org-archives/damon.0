Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B215AD
	for <damon@lists.linux.dev>; Wed, 15 Feb 2023 01:21:44 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VbhW-Bq_1676424093;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbhW-Bq_1676424093)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 09:21:34 +0800
Message-ID: <208eb79f-d064-36be-fece-a91007802379@linux.alibaba.com>
Date: Wed, 15 Feb 2023 09:21:33 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 0/4] Change the return value for page isolation
 functions
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 muchun.song@linux.dev, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
 osalvador@suse.de, mike.kravetz@oracle.com, willy@infradead.org,
 damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
 <5064ee08-792f-14f2-6f2d-26e81af8a239@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5064ee08-792f-14f2-6f2d-26e81af8a239@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/15/2023 1:52 AM, David Hildenbrand wrote:
> On 14.02.23 14:59, Baolin Wang wrote:
>> Now the page isolation functions did not return a boolean to indicate
>> success or not, instead it will return a negative error when failed
>> to isolate a page. So below code used in most places seem a boolean
>> success/failure thing, which can confuse people whether the isolation
>> is successful.
>>
>> if (folio_isolate_lru(folio))
>>          continue;
>>
>> Moreover the page isolation functions only return 0 or -EBUSY, and
>> most users did not care about the negative error except for few users,
>> thus we can convert all page isolation functions to return a boolean
>> value, which can remove the confusion to make code more clear.
>>
>> No functional changes intended in this patch series.
>>
>> Changes from v1:
>>   - Convert all isolation functions to return bool.
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

> 
> Although it's controversial if
> 
> if (!ret)
>      ret = -EBUSY;
> else
>      ret = 0;
> 
> is really appealing to the readers eye :)
> 
> ret = ret ? 0 : -EBUSY;
> 
> It's still confusing.
> 
> would be better as
> 
> ret = isolated ? 0 : -EBUSY;
> 
> IOW, not reusing the "int ret" variable.

Yes, pretty clear. Will do in next version.
