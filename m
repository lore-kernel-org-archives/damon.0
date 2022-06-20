Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5917B
	for <damon@lists.linux.dev>; Mon, 20 Jun 2022 02:14:06 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VGpNzPb_1655690910;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VGpNzPb_1655690910)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 10:08:30 +0800
From: Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: about DAMON lru_sort
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
References: <20220618221430.110362-1-sj@kernel.org>
Message-ID: <f15d9420-4514-b98b-1208-bfebf92cab75@linux.alibaba.com>
Date: Mon, 20 Jun 2022 10:08:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220618221430.110362-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/19/22 6:14 AM, SeongJae Park wrote:
> Hi Xin,
>
> On Sat, 18 Jun 2022 23:17:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Hi sj,
>>
>> On 6/18/22 1:04 AM, SeongJae Park wrote:
>>> Hi Xin,
>>>
>>> On Fri, 17 Jun 2022 18:00:30 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>>
>>>> Hi sj,
>>>>
>>>> I have another question,  if the mglru patch merge into upstream, which
>>>> is more accurate, whether it can be proved with test data, or
>>>> combination them to use ?
>>> I think a fair comparison should be made with fair amount of combinations, of
>>> course.
>>>
>>> I'm unsure if I'm fully understanding your question.  Could you please clarify
>>> your points?
>> I spent some time comparing damon and mglru, I was curious to see how
>> each of them would play out in the memory reclamation scenario, or if
>> each had its own appropriate scenario，so If I want to reclaim memory in
>> my service, which one do I choose between damon and mglru?, i think
>> others people know about them also have the same confusion.
>>
>>   From my humble point of view, I think damon is suitable for long cycle,
>> targeted active reclaim or others, and mglru  is suitable for the whole
>> system.
> Please note that I haven't read MGLRU patches in detail, and therefore some of
> my answers might wrong.  To my humble understanding, MGLRU is an approach for
> making the page granularity access scanning more lightweight and the LRU lists
> finer grained.  DAMON_LRU_SORT is a similar approach.  I think the differences
> are the method of access scanning and proactiveness.
>
> MGLRU uses an optimized form of page granularity access scanning, so it would
> provide quite accurate results but the overhead could increase as the size of
> the memory to scan increase.  Meanwhile, DAMON provides upperbound limited
> overhead but its accuracy could relatively lower than page granularity
> approaches.  Also, DAMON is designed for finding not only cold pages but also
> hot pages (by default, DAMON conceptually scans all memory every 5ms).
>
> MGLRU works in the reactive manner as similar to current reclaim logic, though
> it provides a way to proactively incur the LRU-lists sorting (or, aging).  That
> is, LRU lists would not be well prepared when the first aging of MGLRU is
> incurred.  DAMON_LRU_SORT is for making LRU lists proactively prepared for
> later uses including reclaim.
>
> Therefore, I think using DAMON_LRU_SORT together with MGLRU would make sense.
> In the case, DAMON_LRU_SORT makes LRU-lists more prepared for later reclamation
> before the first aging, and MGLRU will make the later reclaim more efficient.
Ok, Thank you very much for your detailed reply.
>
>
> Thanks,
> SJ
>
> [...]

-- 
Best Regards!
Xin Hao

