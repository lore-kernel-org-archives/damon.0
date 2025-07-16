Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B7BA3D
	for <damon@lists.linux.dev>; Wed, 16 Jul 2025 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643135; cv=none; b=f6n+sHVLDOoR4JkpBcmdmesbXnjRu0BvIBNNwx6YQKyoqwi4CRSwQom9fIFunaTUMME8b1bcSXu51QkaZyRr1seaEdTAlcqn5d9IXL17MIsZemWXIZ5RojKFF1soLYF+IZIgcd/R+6WXnoYurXzAsNJmMiLIqssDUhC6ErOyf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643135; c=relaxed/simple;
	bh=KVPq5YZ7ao2kg8HQya16vo7K/y5khjCB2vV5QjcuKGs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eDEKXihQHlRmMdg3M4mfEJK854DLcu5LdSl3eHjij0lCXKVbxossAjC25wSqXx/N/rAcBwSMmRObLSKVYyFbDr7VobkuJ2BphjEsZNfeUB+T87cmcU6kyRv8KjzaLPP1K+3A3TNsGPL0d2ZHRExC5zkdS6W3QB/QRZJTj28dyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-78-68773639fce4
Message-ID: <4c83fac5-0990-4280-9a21-969d83582112@sk.com>
Date: Wed, 16 Jul 2025 14:18:48 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: support periodic and automated
 stats update
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250716025118.92544-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250716025118.92544-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsXC9ZZnka6lWXmGQcdsUYs569ewWTw50M5o
	8eT/b1aLfReB3IVtS1gsLu+aw2Zxb81/VovDX98wOXB4bFrVyeax6dMkdo8TM36zeLzYPJPR
	Y3HfZFaPcxcrPD5vkgtgj+KySUnNySxLLdK3S+DKWHljH1tBv0LFpKuXWRoYP0t2MXJySAiY
	SEzof8UGY78/dJcFxOYVsJRYvmYSkM3BwSKgKnF8vgxEWFDi5MwnYCWiAvIS92/NYO9i5OJg
	FnjBKHF+72+wOcICURI7f/ezg9jMAiISszvbmEFsEQFFiXOPL7KC2EICRhK/385gArHZBNQk
	rrycBGZzChhL3G88wQzRaybRtbWLEcKWl9j+dg4zyDIJgctsEpvu72SFOFpS4uCKGywTGAVn
	ITlwFpLds5DMmoVk1gJGllWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgbGyrPZP9A7GTxeCDzEK
	cDAq8fDusC7LEGJNLCuuzD3EKMHBrCTCO/kSUIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfy
	FCGB9MSS1OzU1ILUIpgsEwenVANjwvK9j+bMOxJ3ffG8Mu+dkrbXPOTj5x78d/3vwYm7k+P6
	rzScOL94MQNPk3zXmTVL/xV/F3Vc5+OxR7Vz3eSy0wxtPxY9+KC98Xd13oImru+/D729qJDy
	dF7m/y+NKdL8FrwVdyrvRkou4lO6vCUj63QCV1zZrZit5b8WVBXtu9addvnhIpsprEosxRmJ
	hlrMRcWJADDWs1uRAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXCNUNLT9fSrDzDYPI+Tos569ewWTw50M5o
	8eT/b1aLfReB3MNzT7JaLGxbwmJxedccNot7a/6zWhz++obJgdNj06pONo9Nnyaxe5yY8ZvF
	48XmmYwei/sms3qcu1jhsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDJW3tjHVtCvUDHp6mWW
	BsbPkl2MnBwSAiYS7w/dZQGxeQUsJZavmQRkc3CwCKhKHJ8vAxEWlDg58wlYiaiAvMT9WzPY
	uxi5OJgFXjBKnN/7mw0kISwQJbHzdz87iM0sICIxu7ONGcQWEVCUOPf4IiuILSRgJPH77Qwm
	EJtNQE3iystJYDangLHE/cYTzBC9ZhJdW7sYIWx5ie1v5zBPYOSbheSOWUhWzELSMgtJywJG
	llWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBgb+s9s/EHYxfLrsfYhTgYFTi4d1hXZYhxJpY
	VlyZe4hRgoNZSYR38iWgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQi
	mCwTB6dUA+PyZ/ODKi9+87vWwWZvkMa/llGxJ1XO0qnw6svwq/1n2RhUix48b5VrjUzYddS2
	6GL5Jke7Bct/rPgQ1+s7e+31ORsZz9ifPV+5J8r36/fbE2Yo/Exj9t0ZrKwcdeDPTMOdNU9P
	ZFr2zJslOF+kmzWsv8Pz+oo5wU1eM24zPmKqFehc/1otx02JpTgj0VCLuag4EQBGPn4EeAIA
	AA==
X-CFilter-Loop: Reflected



On 7/16/2025 11:51 AM, SeongJae Park wrote:
> On Wed, 16 Jul 2025 10:58:06 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae,
>>
>> On 7/16/2025 8:43 AM, SeongJae Park wrote:
>>> On Wed, 16 Jul 2025 07:20:57 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
>>>
>>>> Hi SeongJae,
>>>>
>>>> On 7/13/2025 5:46 AM, SeongJae Park wrote:
>>>>> DAMON sysfs interface provides files for reading DAMON internal status
>>>>> including DAMOS stats.  The content of the files are not automatically
>>>>> updated, though.  Users should manually request updates of the contents
>>>>> by writing a special command to 'state' file of each kdamond directory.
>>>>> This interface is good for minimizing overhead, but causes the below
>>>>> problems.

[...snip...]

>>>>> Introduce a new sysfs file, namely refresh_ms, for asking DAMON sysfs
>>>>> interface to repeat the essential contents update with a user-specified
>>>>> time delay.
>>>>
>>>> Thanks for working on this, but I have a few questions.
>>>> 1. Could you please list up what are the "essential contents"?
>>>
>>> Thank you for asking this.  The contents are auto-tuned monitoring intervals,
>>> DAMOS stats, and auto-tuned effective size quota.
>>
>> Thanks, but I meant the specific list of damon knobs refreshed.  If there are
>> too many knobs, then don't have to list them all.
> 
> I guess you are saying about sysfs files?  Yes, I think listing those all is
> unnecessary.

OK. No problem then.

>>> I will add these on the next version cover letter.
>>
>> Thanks.
>>
>>>> 2. Does it mean that it is different from writing "commit" to "state"?
>>>> 3. If not, then is there equivalent action to writing something to "state"?
>>>
>>> "refresh_ms" works same to other DAMON parameter files.  You can set it before
>>> starting DAMON, or "commit" new values (including 0 for turning this refresh
>>> off) in runtime.
>>>
>>> I'm not that confident if I understood your point very well, especially what
>>> "it"s mean.  Let me know if I'm misunderstanding something.
>>
>> I mean writing "commit" to "state" refresh all knobs,
> 
> Assuming "knobs" mean sysfs files, this is incorrect.  Writing "commit" to
> "state" passes the parameters written on appropriate files to running kdamond.
> It doesn't update any sysfs files until a "update_*" keyword is written to the
> "state" file.

I thought writing "commit" to "state" applies config changes and updates all the
readable sysfs files together, but it doesn't.  Thanks for the correction.

> 
>> but it seems "refresh_ms"
>> internally refresh paritial knobs so I was wondering what are refreshed and what
>> aren't.
>>
>> Regarding the "equivalent action", I was also wondering if there is a command
>> that works same as "refresh_ms" internally does among the command below.
>>
>>     update_tuned_intervals
>>     commit_schemes_quota_goals
>>     update_schemes_stats
>>     update_schemes_tried_regions
>>     update_schemes_tried_bytes
>>     clear_schemes_tried_regions
>>     update_schemes_effective_quotas
>>
>> https://docs.kernel.org/admin-guide/mm/damon/usage.html#kdamonds-n
>>
>> In other words, if there is the same command listed above, then users might be
>> able to run a script that regularaly write the command to the current "state"
>> even without this "refresh_ms".  I know having "refresh_ms" is much better
>> though.
> 
> Thank you for this nice question.  Yes.  Enabling "refresh_ms" is roughly same
> to periodically writing
> "update_{tuned_intervals,schemes_stats,schemes_effective_quotas" to "state"
> file.

OK. I get that "refresh_ms" does periodic write the combination of them to
"state" without "update_{schemes_tried_regions,schemes_tried_bytes}.

In other words, it is same as periodic execution of the follows.

   echo update_tuned_intervals > state
   echo update_schemes_stats > state
   echo update_schemes_effective_quotas > state

That makes my question clear.  Thanks for the explanation!

Thanks,
Honggyu

> 
> 
> Thanks,
> SJ
> 
> [...]
