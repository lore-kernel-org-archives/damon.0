Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E72F25
	for <damon@lists.linux.dev>; Fri, 17 Jun 2022 10:16:13 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VGeV2s9_1655460031;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VGeV2s9_1655460031)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 18:00:31 +0800
From: Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: about DAMON lru_sort
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
References: <20220615165105.12361-1-sj@kernel.org>
Message-ID: <65066228-82f7-84a4-6fcc-d8954da60369@linux.alibaba.com>
Date: Fri, 17 Jun 2022 18:00:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220615165105.12361-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi sj,

I have another question,  if the mglru patch merge into upstream, which 
is more accurate, whether it can be proved with test data, or 
combination them to use ?

On 6/16/22 12:51 AM, SeongJae Park wrote:
> Hi Xin,
>
> On Wed, 15 Jun 2022 17:50:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Hi sj,
>>
>>       I have seen the DAMON + LRU codes detailedly， i really think it is
>> a good idea, but i have a few question,  why we can not to monitor whole
>> per node zone automatically,  i think it is hard to pass a physical
>> address when you do not  sure which physical address range to choose.
>>
>>       for example,  i do not care which physical address range need to be
>> minitored, i just want know the whole memory which includes how much
>> inactive pages and
>>
>> to better reclaim them.
> Thank you for this question, Xin!  For the use case, I think you can get the
> physical address range for the whole memory using '/proc/iomem' or similar
> things[1].  If you could use DAMON_LRU_SORT module instead of manually using
> DAMOS with DAMOS_LRU_(DE)PRIO action, you can further reduce such efforts,
> because it tries to cover almost whole memory by default[2].  If I'm missing
> something, please let me know.
>
> [1] https://github.com/awslabs/damo/blob/next/_damo_paddr_layout.py#L135
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/mm/damon/lru_sort.c?h=damon/next-2022-06-09-19-55-on-v5.19-rc1-mm-unstable#n277
>
>
> Thanks,
> SJ
>
>>       I just put forward my idea in a superficial way and look forward to
>> your reply，thanks.
>>
>> -- 
>> Best Regards!
>> Xin Hao

-- 
Best Regards!
Xin Hao

