Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10557B
	for <damon@lists.linux.dev>; Sat, 18 Jun 2022 15:17:13 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VGjgolV_1655565423;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VGjgolV_1655565423)
          by smtp.aliyun-inc.com;
          Sat, 18 Jun 2022 23:17:04 +0800
From: Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: about DAMON lru_sort
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
References: <20220617170434.106076-1-sj@kernel.org>
Message-ID: <888e1dfc-6ccc-6a06-bef0-e2c8aedfb667@linux.alibaba.com>
Date: Sat, 18 Jun 2022 23:17:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220617170434.106076-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi sj,

On 6/18/22 1:04 AM, SeongJae Park wrote:
> Hi Xin,
>
> On Fri, 17 Jun 2022 18:00:30 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Hi sj,
>>
>> I have another question,  if the mglru patch merge into upstream, which
>> is more accurate, whether it can be proved with test data, or
>> combination them to use ?
> I think a fair comparison should be made with fair amount of combinations, of
> course.
>
> I'm unsure if I'm fully understanding your question.  Could you please clarify
> your points?

I spent some time comparing damon and mglru, I was curious to see how 
each of them would play out in the memory reclamation scenario, or if 
each had its own appropriate scenario，so If I want to reclaim memory in 
my service, which one do I choose between damon and mglru?, i think 
others people know about them also have the same confusion.

 From my humble point of view, I think damon is suitable for long cycle, 
targeted active reclaim or others, and mglru  is suitable for the whole 
system.








>
> Thanks,
> SJ
> [...]

-- 
Best Regards!
Xin Hao

