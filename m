Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D325193
	for <damon@lists.linux.dev>; Fri, 19 Aug 2022 02:02:15 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMdxZUX_1660874213;
Received: from 30.240.99.21(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMdxZUX_1660874213)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 09:56:54 +0800
Message-ID: <5bc7f671-ad41-6a0c-535e-861b130992d9@linux.alibaba.com>
Date: Fri, 19 Aug 2022 09:56:53 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH V2 2/2] mm/damon/lru_sort: Remove struct of
 damon_lru_sort_ram_walk_arg
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20220818172322.51705-1-sj@kernel.org>
From: haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220818172322.51705-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2022/8/19 上午1:23, SeongJae Park 写道:
> Hi Xin,
>
> On Thu, 18 Aug 2022 18:57:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> The struct of 'damon_lru_sort_ram_walk_arg' is the same with struct of
>> 'damon_addr_range', so, there no need to redefine it, just use struct of
>> 'damon_addr_range' instead.
> Reducing code is always good, thanks.  However, I think the type of the 'start'
> and 'end' fields of 'struct damon_addr_range' might be changed in a future.
OK,  get it.
> It's very unlikely, though.  Also, we might add some more fields to the struct
> in a future.  After all, the purpose of 'struct damon_addr_range' is not saving
> the 'start' and 'end' fields of 'struct resource'.  I'd like to avoid making
> any possible dependency here, sorry.
>
>
> Thanks,
> SJ
>
> [...]
