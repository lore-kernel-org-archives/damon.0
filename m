Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018792676C2
	for <damon@lists.linux.dev>; Fri, 27 Jun 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023767; cv=none; b=JDvncgc8EFTTEg9psrvmZnqs0GvU2jbexpYoSp41MRftUZb3CB9fEHIAksd+QdAsq7RKPsm3/e+MvEB4KYpcHAg4Wj0lc3BqUCMLRTkDZrBcOW/33EjhKYGSfM+fKshkbMmh/ILuJHuAFjyy/UiooNz5M9LTBKFzMgGzZSfITBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023767; c=relaxed/simple;
	bh=aclM/+2IHevRI7UI/KirLjRXi5WiVp6bDO+sAwlm1VM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6+687axXpzVqbHF0myDXJkvPU/LdjeazKBXFVUu/2J3a5xqEFQ9KBGPxYf9qlbXWvJNiIlfiyWn/WiQpkrKTKBZwXakbdPD949zVT1VHYeq3rWVKCWkOdH8vJ7dfIbS7veMCly64I0teBTF1pqQ46IqQKt6+T3QEbvnNNu2Adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-83-685e808e50ef
Message-ID: <c1b4b514-1629-40f5-88db-00353606ea22@sk.com>
Date: Fri, 27 Jun 2025 20:29:18 +0900
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
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250626152713.333339-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250626152713.333339-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnkW5fQ1yGwZQNNhZz1q9hs3jy/zer
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9Tsz4zeLxYvNMxgCWKC6blNSczLLUIn27BK6MhdP+
	sxRcFq14cqaBvYHxikAXIyeHhICJxLbD11hh7CMrPjGD2LwClhKrL+wBi7MIqEq8W76CCSIu
	KHFy5hMWEFtUQF7i/q0Z7CA2s8BMRok3p3hAbGEBT4lXT9ewQcRFJGZ3toHNFBFQlDj3+CLY
	TCEBY4lJe36C9bIJqElceTkJbD4n0A3N+55C9ZpJdG3tYoSw5SW2v50DNIcL6M4FbBJbF/Ux
	QhwtKXFwxQ2WCYyCs5DcNwvJ7llIZs1CMmsBI8sqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMBA
	X1b7J3oH46cLwYcYBTgYlXh4N1TGZQixJpYVV+YeYpTgYFYS4eW9FpshxJuSWFmVWpQfX1Sa
	k1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgXHWlce9/y7k3vFyOOC8UCfRdYf3
	H4kJfbkzpUOFPfy45+zuFV7FH3JbxTFrR7gvh+mfhsdnPrb2/f19SPXPi9WbhIrMd0Vo1S0u
	3sXftm/iJW4e+88LHvwJKXu1+0ltuemHM5dLeJQ+ZO/iWcdtxz/ndfWKvzyKAed/TWk6edrD
	do77pdRjE9OUWIozEg21mIuKEwHsv3W+cAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXCNUNLT7evIS7D4NlqE4s569ewWTz5/5vV
	4vDck6wW99b8B7K+vmGy+L1tBZsDm8emVZ1A4tMkdo8TM36zeLzYPJPR49ttD4/FLz4wBbBF
	cdmkpOZklqUW6dslcGUsnPafpeCyaMWTMw3sDYxXBLoYOTkkBEwkjqz4xAxi8wpYSqy+sIcV
	xGYRUJV4t3wFE0RcUOLkzCcsILaogLzE/Vsz2EFsZoGZjBJvTvGA2MICnhKvnq5hg4iLSMzu
	bAObKSKgKHHu8UWwmUICxhKT9vwE62UTUJO48nIS2HxOoBua9z2F6jWT6NraxQhhy0tsfzuH
	eQIj3ywkZ8xCsmIWkpZZSFoWMLKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzkZbV/Ju5g
	/HLZ/RCjAAejEg/vhsq4DCHWxLLiytxDjBIczEoivLzXYjOEeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGOX5lJyFr/Xpy/XPXPeF++OTdVdyTyXd2byj
	kD8szNY+4prgeZVPtRFWLJEiVTYhza/qaySf3Awz0curefDAnGH7qnsFf+WlUp+E7btxIiQ9
	62TTzC8qnh/FT1+6IFGud0ve9+aakzfi7e0MbWPateLO7LrockncUdw55sjub9xiCjlVprPS
	lFiKMxINtZiLihMBuCZ3l2ACAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On 6/27/2025 12:27 AM, SeongJae Park wrote:
> On Thu, 26 Jun 2025 07:24:14 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae,
>>
>> Sorry for the late response.
> 
> No worry!
> 
>> On 6/24/2025 3:03 AM, SeongJae Park wrote:
>>> On Mon, 23 Jun 2025 11:58:53 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> [...]
>>> I mean, something like below.
>>>
>>> @@ -1449,6 +1449,7 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>>>                   }
>>>           }
>>>           target_access_events = max_access_events * goal_bp / 10000;
>>> +       target_access_events = target_access_events ? : 1;
>>>           return access_events * 10000 / target_access_events;
>>>    }
>>
>> I actually didn't mean the code, but just wondered if setting
>> "target_access_events" to 1 makes sense in this context.
>>
>> I now think that it doesn't make any difference because applying DAMOS actions
>> to zero size regions as it's just no-ops.  So I can take your change.
> 
> Thank you for clarifying, looking forward to your fix! :)

Will send it within a few days.  Thanks for your patience.

> 
> [...]
>>> I still prefer fixing the found bug on the spot.  I don't think having zero or
>>> negative size regions is really somewhat we always prohibit.
>>
>> I can split "target_access_events" change patch from this regardless of this
>> with "Fixes" tag.
>>
>> But I don't get why you think zero size region is acceptable.  Do you see any
>> benefits or have special reasons allowing zero size regions?
> 
> In short, I don't anticipate special benefits of allowing zero size region.
> But that's smae to this change.
> 
> I even have small concern about this change.
> 
> This change might make people assume any damon_region would have non-zero
> positive size.  I think that's wrong assumption.  Any DAMON core and API caller
> code can set the start and the end addresses with arbitrary values.
> 
> I think making the assumption true could be beneficial since it will help
> writing code with less corner cases.  But to make the assumption true, we
> should first check if any existing code is violating it, and if any existing
> code that written with current assumption (region size can be zero) can be
> broken.  After that, we should also prevent future code violating it.
> 
> And if the assumption becomes truth, we get one more rule.  I, at least, prefer
> having as less rules as possible.  My taste may be weird, but this is my humble
> feeling and opinion.

I see.  You don't want to make breaking changes even in this case, then I can
leave it as is.  Thanks for the explanation!

Thanks,
Honggyu

> 
> 
> Thanks,
> SJ
> 
> [...]
> 

