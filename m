Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C815A2
	for <damon@lists.linux.dev>; Fri, 19 Aug 2022 02:12:43 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMdxGnC_1660875154;
Received: from 30.240.99.21(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMdxGnC_1660875154)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 10:12:35 +0800
Message-ID: <5c1c4b01-5ada-5c25-7181-a6f6c2c1f6ed@linux.alibaba.com>
Date: Fri, 19 Aug 2022 10:12:34 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH V2 1/2] mm/damon/lru_sort: Move target memory region check
 to head of func
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220818171145.51607-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220818171145.51607-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/8/19 上午1:11, SeongJae Park 写道:
> Hi Xin,
>
>
> On Thu, 18 Aug 2022 18:57:31 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon_lru_sort_apply_parameters(), if "monitor_region_start"
>> and "monitor_region_end" is not a valid physical address range,
>> There no need to run the remainder codes in it.
> The function, 'damon_lru_sort_apply_parameters()', checks validity of
> parameters and construct the DAMON context one by one.  For example,
> 'damon_set_attrs()' returns an error if the parameters are invalid.  So the
> intended flow is,
>
> 1. check DAMON attributes parameters,
> 2. apply DAMON attributes parameters,
> 3. check scheme parameters,
> 4. apply scheme parameters,
> 5. check target region parameters, and
> 6. apply target region parameters.
>
> Therefore what this patch does is making the target regions validity check to
> be done earlier than validity checks of other parameters.  There is no special
> reason to check the region earlier than others.  Also, this change makes the
> flow of the function a little bit weird in my humble opinion, as the flow will
> be
>
> 1. check target region parameters,
> 2. check DAMON attributes parameters,
> 3. apply DAMON attributes parameters,
> 4. check scheme parameters,
> 5. apply scheme parameters, and
> 6. apply target region parameters.

Ok, understand what you mean,   my fix looks ugly,  buy any apply above 
are not not necessary if one of them checks failed, why not check all 
fisrt and then apply them, like this:

1. check target region parameters,

2. check DAMON attributes parameters,

3. check scheme parameters,

>
> So I'd argue this patch seems not really needed, sorry.
>
>
> Thanks,
> SJ
>
> [...]
