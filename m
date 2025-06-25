Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0A35280
	for <damon@lists.linux.dev>; Wed, 25 Jun 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890264; cv=none; b=Ub3mkApqvQlK3+MBHNIVb3WKR9MPvTyCspB23/3zS5xbAKn0iPjz4Uvm4BXUA3btgvx8yHHliF3jMA5Mg9Td+r/kea1XtUU1/gT6s2XfNQjF5jDfYmsVB9/VEV73iycJvjfoBVhjZzT3A5Ci0osyitLjhCLpKs5lzJ+AICVaOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890264; c=relaxed/simple;
	bh=J24So0xVDU73haA03vtUiFsD+fNwlmPaMv6mY7NEs/g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DiY9oiIzk72RVRI8602H0PqXd2pf8S4uwQu+Pu2JNuaVbjTymVnm5u0/amCnXkuIMS08EkmvTp5s6yD9eXE7Tcb+PfvL6oADyq7XSsZbUPKIoPJpMfnQIjkjWwECL6ZK/zI/pl+kSyYJ4aoloX7KuVY2Y+1HsFX21Vw6+kn1cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-24-685c770e56cc
Message-ID: <697aed09-80ff-41d4-b1cb-321c9fd9ff23@sk.com>
Date: Thu, 26 Jun 2025 07:24:14 +0900
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
References: <20250623180305.44277-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250623180305.44277-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnkS5/eUyGwf9+Zos569ewWTz5/5vV
	4t6a/6wWh7++YXJg8di0qpPNY9OnSeweJ2b8ZvF4sXkmYwBLFJdNSmpOZllqkb5dAldG7w32
	ghWKFc2zHrA1MM6Q7GLk4JAQMJGYM9mpi5ETwuzewgRi8wpYSlw5eYINxGYRUJU4NWUbC0Rc
	UOLkzCdgtqiAvMT9WzPYQWxmgZmMEm9O8YDYwgKeEq+ergHrFRFQlDj3+CIriC0kYCSxf+0l
	Foh6EYnZnW3MIDabgJrElZeTwPZyChhL7Hz4lgmixkyia2sXI4QtL7H97Rygei6gOxewSTze
	dIYN4mhJiYMrbrBMYBScheS+WUh2zEIyaxaSWQsYWVYxCmXmleUmZuaY6GVU5mVW6CXn525i
	BAb5sto/0TsYP10IPsQowMGoxMO74Vp0hhBrYllxZe4hRgkOZiUR3mnmURlCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGIPWxH5+fJ47Z2ZzEevSZU9m
	XpzMsLTuZGaEryZX/qGqYPPYt0tXtnt7ZBuEJ7+7NLeuruPM5bvWM4t8jqz74usylW+b7gOt
	893GPZf3G3Z+Ny1dYLk/OWvGYvcHDeeOffZYMdPbedpClrtxu+YHF6m4JS+UYEh96qjKVrku
	SW+KVXPRvBBrTyWW4oxEQy3mouJEAE65hpJuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXCNUNLT5evPCbD4PUvc4s569ewWTz5/5vV
	4vDck6wW99b8B7K+vmGy+L1tBZsDm8emVZ1A4tMkdo8TM36zeLzYPJPR49ttD4/FLz4wBbBF
	cdmkpOZklqUW6dslcGX03mAvWKFY0TzrAVsD4wzJLkZODgkBE4k53VuYQGxeAUuJKydPsIHY
	LAKqEqembGOBiAtKnJz5BMwWFZCXuH9rBjuIzSwwk1HizSkeEFtYwFPi1dM1YL0iAooS5x5f
	ZAWxhQSMJPavvcQCUS8iMbuzjRnEZhNQk7jychLYXk4BY4mdD98yQdSYSXRt7WKEsOUltr+d
	wzyBkW8WkjNmIRk1C0nLLCQtCxhZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG8bLaPxN3
	MH657H6IUYCDUYmHd8O16Awh1sSy4srcQ4wSHMxKIrzTzKMyhHhTEiurUovy44tKc1KLDzFK
	c7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjXWWou6FJueOKdsdV8hqDOTc/1016ddtTV
	EMwwkXvU8ZfrnH3a+Xspf73+66pUxIVUnK1OLvkwV4lXJOkYz6Qy8R+b3T8fDNY33a/24iCn
	TJXPpgLRaWlsBq+M5Dtswh8Wv2QrEz9fEC9z23t9/KfyyEWVKjWhQq/uWzgldXctjfzTHnRt
	uxJLcUaioRZzUXEiAMDpu6FfAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

Sorry for the late response.

On 6/24/2025 3:03 AM, SeongJae Park wrote:
> On Mon, 23 Jun 2025 11:58:53 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae,
>>
>> Thanks for the kind review as always!
> 
> My pleasure :)
> 
>>
>> On 6/23/2025 1:04 AM, SeongJae Park wrote:
>>> On Sun, 22 Jun 2025 21:09:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
>>>
>>>> Creating zero size region leads a divide by zero error inside
>>>> damon_get_intervals_score() as follows.
>>>>
>>>>     static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>>>>     {
>>>>         struct damon_target *t;
>>>>         struct damon_region *r;
>>>>         unsigned long sz_region, max_access_events = 0, access_events = 0;
>>>>         unsigned long target_access_events;
>>>>         unsigned long goal_bp = c->attrs.intervals_goal.access_bp;
>>>>
>>>>         damon_for_each_target(t, c) {
>>>>             damon_for_each_region(r, t) {
>>>>                 sz_region = damon_sz_region(r);
>>>>                 max_access_events += sz_region * c->attrs.aggr_samples;
>>>>                 access_events += sz_region * r->nr_accesses;
>>>>             }
>>>>         }
>>>>         target_access_events = max_access_events * goal_bp / 10000;
>>>>         return access_events * 10000 / target_access_events;  /* divide by zero! */
>>>>     }
>>>
>>> Thank you for finding this issue!  Coudl you please further share how zero size
>>> region can be made, and if user-space can make the situation?
>>
>> The initial values of node*_start_addr and node*_end_addr inside
>> /sys/module/mtier/parameters/ are all zeros so I saw this problem easily by
>> setting Y to "enabled".
> 
> Thank you for clarifying!  Please add this description on the commit message if
> you send a next version of this patch, with Fixes: tag.

OK. I will add "Fixes: tag.

>>>>
>>>> This patch makes a NULL return for such cases when creating a region
>>>> inside damon_new_region().
>>>
>>> I agree zero size region could look silly.  But I don't really think it should
>>> be prohibited.  What about modifying damon_get_intervals_score() instead?
>>> Maybe we can set target_access_events as 1 in this case.
>>
>> Hmm... I don't get what you mean by setting "target_access_events" to 1 for such
>> cases.  Could you please explain more?
> 
> I mean, something like below.
> 
> @@ -1449,6 +1449,7 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>                  }
>          }
>          target_access_events = max_access_events * goal_bp / 10000;
> +       target_access_events = target_access_events ? : 1;
>          return access_events * 10000 / target_access_events;
>   }

I actually didn't mean the code, but just wondered if setting 
"target_access_events" to 1 makes sense in this context.

I now think that it doesn't make any difference because applying DAMOS actions
to zero size regions as it's just no-ops.  So I can take your change.

>>>
>>>>
>>>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>>>> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
>>>> ---
>>>>    mm/damon/core.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>>>> index b217e0120e09..44740da337fd 100644
>>>> --- a/mm/damon/core.c
>>>> +++ b/mm/damon/core.c
>>>> @@ -126,8 +126,11 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>>>>         if (!region)
>>>>                 return NULL;
>>>>
>>>> +     if (start == end)
>>>> +             return NULL;
>> If you're okay, then I'd like to modify this as follows again.
>>
>> +     if (start >= end)
>> +             return NULL;
>>
>> What do you think about this?
> 
> I still prefer fixing the found bug on the spot.  I don't think having zero or
> negative size regions is really somewhat we always prohibit.

I can split "target_access_events" change patch from this regardless of this
with "Fixes" tag.

But I don't get why you think zero size region is acceptable.  Do you see any 
benefits or have special reasons allowing zero size regions?

Thanks,
Honggyu

> 
> 
> Thanks,
> SJ
> 
> [...]
> 

