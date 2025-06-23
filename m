Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D932566A
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647541; cv=none; b=aWDiSZ5F3ExcIF636QhK/hGpEz4Y6bbZqIv9QqHkHRJM5t2Xg9zWQLqJr2BhpbAkdu6jQKZQh93//iv1d6P0olqzPlbY3l8DA+ygffY+/hMoWNjkVE7rLCEISQ1Jm648ja87WdXnp3NKTy4MyIz+Vyf8pNTNYexFtNGhCCFm1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647541; c=relaxed/simple;
	bh=f90SNUYG077U5zkXpY15fIC7d8dqy6J6zniGxIHwNPg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gJd6cHfacS+poT1bCmtW44ygPSuuvfu3+Zc7Dgk+cwH9Qs1s/1dPoQ+xriJp0bfjVQN38sW71P1Ia2sMHtcZz1M64+MhH47YGaHHMHa0ucYqL6Oj+dKMIkD/UDBxjTHO28YPXRlOA8p4ET0pDwz8UdipJChCASc0faZ9uUJSIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1e-6858c2eea3e4
Message-ID: <86e91607-f008-4fc1-8660-021b8e257a10@sk.com>
Date: Mon, 23 Jun 2025 11:58:53 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 1/3] mm/damon: do not allow creating zero size region
To: SeongJae Park <sj@kernel.org>
References: <20250622160453.47161-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250622160453.47161-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnoe67QxEZBtcXC1jMWb+GzeLJ/9+s
	FvfW/Ge1OPz1DZMDi8emVZ1sHps+TWL3ODHjN4vHi80zGQNYorhsUlJzMstSi/TtErgyHjdf
	YSmYLV6x5tchxgbGJYJdjJwcEgImEk+evmCDsd9O62MEsXkFLCW2Hf7DBGKzCKhKzP03kwki
	LihxcuYTFhBbVEBe4v6tGewgNrPATEaJN6d4QGxhAU+JV0/XgM0UEVCUOPf4IiuILSRgJHHp
	7wYmiHoRidmdbcwgNpuAmsSVl5PA4pwCxhINnV9ZIGrMJLq2djFC2PIS29/OAarnArpzBZvE
	1ZmXoY6WlDi44gbLBEbBWUjum4Vkxywks2YhmbWAkWUVo1BmXlluYmaOiV5GZV5mhV5yfu4m
	RmCgL6v9E72D8dOF4EOMAhyMSjy8CTwRGUKsiWXFlbmHGCU4mJVEeA85hWUI8aYkVlalFuXH
	F5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYKwM2n1ir5VXgsCZqnn1X8W/
	RR6OnP1HMO3KWYGbn1kCXr5h3WGpr5B/S4Jdc8VHP2PdaMW3N/+Vmyk1MrmLnX2QemZSrwPb
	5ufb17C/jCyV2/LCs/AT77utq377+C+TrjGy29N8+nLVrJ7/17UUQjX5+PcYTU2PTFylukPj
	0sJH5hbC3gzXApRYijMSDbWYi4oTAVAJ46pwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXCNUNLT/fdoYgMg4czOS3mrF/DZvHk/29W
	i8NzT7Ja3FvzH8j6+obJ4ve2FWwObB6bVnUCiU+T2D1OzPjN4vFi80xGj2+3PTwWv/jAFMAW
	xWWTkpqTWZZapG+XwJXxuPkKS8Fs8Yo1vw4xNjAuEexi5OSQEDCReDutjxHE5hWwlNh2+A8T
	iM0ioCox999MJoi4oMTJmU9YQGxRAXmJ+7dmsIPYzAIzGSXenOIBsYUFPCVePV3DBmKLCChK
	nHt8kRXEFhIwkrj0dwMTRL2IxOzONmYQm01ATeLKy0lgcU4BY4mGzq8sEDVmEl1buxghbHmJ
	7W/nME9g5JuF5IxZSEbNQtIyC0nLAkaWVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIGBvKz2
	z8QdjF8uux9iFOBgVOLhXeEdkSHEmlhWXJl7iFGCg1lJhPeQU1iGEG9KYmVValF+fFFpTmrx
	IUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+Ot44yfl3rK785IdshRS3A715p5NL9i
	q87D9wd7lzxSOL727p0He3Sijn+UMj0sdtziist952cGkuVXj+dV/j7yt0ZZY+KGG+X6/bdO
	fHJ2k3qs7l3lP/XIv1/vf9xftcs0rtzwpv/nZrVANQfNa5y7vKZVm9Ra1+w73mnV9S/++O0d
	9lpy2xyUWIozEg21mIuKEwFAGD8ZYAIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks for the kind review as always!

On 6/23/2025 1:04 AM, SeongJae Park wrote:
> On Sun, 22 Jun 2025 21:09:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Creating zero size region leads a divide by zero error inside
>> damon_get_intervals_score() as follows.
>>
>>    static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>>    {
>>        struct damon_target *t;
>>        struct damon_region *r;
>>        unsigned long sz_region, max_access_events = 0, access_events = 0;
>>        unsigned long target_access_events;
>>        unsigned long goal_bp = c->attrs.intervals_goal.access_bp;
>>
>>        damon_for_each_target(t, c) {
>>            damon_for_each_region(r, t) {
>>                sz_region = damon_sz_region(r);
>>                max_access_events += sz_region * c->attrs.aggr_samples;
>>                access_events += sz_region * r->nr_accesses;
>>            }
>>        }
>>        target_access_events = max_access_events * goal_bp / 10000;
>>        return access_events * 10000 / target_access_events;  /* divide by zero! */
>>    }
> 
> Thank you for finding this issue!  Coudl you please further share how zero size
> region can be made, and if user-space can make the situation?

The initial values of node*_start_addr and node*_end_addr inside
/sys/module/mtier/parameters/ are all zeros so I saw this problem easily by
setting Y to "enabled".

>>
>> This patch makes a NULL return for such cases when creating a region
>> inside damon_new_region().
> 
> I agree zero size region could look silly.  But I don't really think it should
> be prohibited.  What about modifying damon_get_intervals_score() instead?
> Maybe we can set target_access_events as 1 in this case.

Hmm... I don't get what you mean by setting "target_access_events" to 1 for such
cases.  Could you please explain more?

> 
>>
>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
>> ---
>>   mm/damon/core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index b217e0120e09..44740da337fd 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -126,8 +126,11 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>>        if (!region)
>>                return NULL;
>>
>> +     if (start == end)
>> +             return NULL;
If you're okay, then I'd like to modify this as follows again.

+     if (start >= end)
+             return NULL;

What do you think about this?

>>        region->ar.start = start;
>>        region->ar.end = end;
>> +
> 
> Above new line is unnecessary in my opinion.

Sure. will remove it in the next version.

Thanks,
Honggyu

> 
>>        region->nr_accesses = 0;
>>        region->nr_accesses_bp = 0;
>>        INIT_LIST_HEAD(&region->list);
>> --
>> 2.34.1
> 
> 
> Thanks,
> SJ

