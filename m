Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468958836
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754186606; cv=none; b=MJ9O+o5RG2jl5I6RnrDFTogEx5soz2CmGEwh0bW4igHZdRrD5aS+4TcwO9co54Gq/RWXNBZpxRZalh6V5zhof+U4k2hbhMlu2rwQOtOXaVPagg57w2CQZyA14NWKVUdcNwCAwVic+bqRH5EQNxJ8AB6bC5a5dDGdArQWyI29qKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754186606; c=relaxed/simple;
	bh=jmEgQV3fo6ohPlV/ZCYDRg9GQnystRslrtLIQfkLULY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Je4yJeCvkfap0dbdGYSCQpf+cByIfODHXM8HxV3jwFFx/3Ps788bG2byAVu3ComrNvC6nuKbHXdj7U6VPNdD9DT31pzgEgPMSzJvEFZRWM81Ix49zwGNWTvIOgPFZP+s8jBKYJsszJhk/5OTSgPpgj6q2s463WlmJzUgHUphPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-c6-688ec3604c23
Message-ID: <a31c84fc-71ac-4aa2-9bfb-123868a91cd3@sk.com>
Date: Sun, 3 Aug 2025 11:03:12 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
To: SeongJae Park <sj@kernel.org>, Sang-Heon Jeon <ekffu200098@gmail.com>
References: <20250801165041.8350-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250801165041.8350-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnoW7i4b4MgykzWS2e/P/NanHiRYLF
	vTX/WS0Of33D5MDisXPWXXaPTas62Tw2fZrE7vFi80zGAJYoLpuU1JzMstQifbsErowtFxex
	FjwVrZjYdYq9gfGvYBcjJ4eEgInEjk13WWHs7y/Ws4PYvAKWEhdfzGUGsVkEVCQ+/Z7BCBEX
	lDg58wkLiC0qIC9x/9YMsHpmATeJq9fvgdnCAp4Sux99YgKxRYDs61vms3UxcnAICRhKbD6k
	CFEuIjG7sw1sPJuAmsSVl5PAyjkFjCRe3uxkgqgxk+ja2sUIYctLNG+dDVTPBXTmHDaJqWvf
	skHcLClxcMUNlgmMgrOQnDcLyY5ZSGbNQjJrASPLKkahzLyy3MTMHBO9jMq8zAq95PzcTYzA
	IF9W+yd6B+OnC8GHGAU4GJV4eHd8680QYk0sK67MPcQowcGsJMJ7rqs7Q4g3JbGyKrUoP76o
	NCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjibX2sTpxG7O9LvfY2GODHed+
	Ucp9umbV8qrz2RHfr01I7Uw/zly322miC9d6vvcTmW+nvmvafbMtytvD91ccd7JPc7BTIe8u
	4ZIq4XlKmwSK9273/3Z55flTdlW7l+r1lJop7nBZ8eVGY87z92rHVj6R2beGhb2+O3Cpwab5
	8hHuU7U4AhWVWIozEg21mIuKEwEkA30ZbgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsXCNUNLTzfhcF+GwZ4X5hZP/v9mtTjxIsHi
	8NyTrBb31vxntTj89Q2TA6vHzll32T02repk89j0aRK7x4vNMxk9Fr/4wBTAGsVlk5Kak1mW
	WqRvl8CVseXiItaCp6IVE7tOsTcw/hXsYuTkkBAwkfj+Yj07iM0rYClx8cVcZhCbRUBF4tPv
	GYwQcUGJkzOfsIDYogLyEvdvzQCrZxZwk7h6/R6YLSzgKbH70ScmEFsEyL6+ZT5bFyMHh5CA
	ocTmQ4oQ5SISszvbwMazCahJXHk5CaycU8BI4uXNTiaIGjOJrq1djBC2vETz1tnMExj5ZiG5
	YhaSUbOQtMxC0rKAkWUVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYMguq/0zcQfjl8vuhxgF
	OBiVeHh3fOvNEGJNLCuuzD3EKMHBrCTCe66rO0OINyWxsiq1KD++qDQntfgQozQHi5I4r1d4
	aoKQQHpiSWp2ampBahFMlomDU6qB8c5Dyc/m5U8NCuxZTh+pixezLVbIvLZw7Zbdhv2T/0yZ
	e1pM+X3qmmvbpgvaVrpZndTw1V7AopX28pOJMmfYlI1RD/ZIaylrFWSUf7Q+oWTofnDP8lO7
	b279rzOx6tOXlSpP7YKc8k6HbZTb8C5gY0r4mqgpm0+frcvvu1U1ecZ9M8e6je9NtyixFGck
	GmoxFxUnAgC/05lTVQIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae and Sang-Heon,

On 8/2/2025 1:50 AM, SeongJae Park wrote:
> On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
>> Hi, Honggyu
>>
>> On Fri, Aug 1, 2025 at 8:35 PM Honggyu Kim <honggyu.kim@sk.com> wrote:
>>>
>>> Hi Sang-Heon and SeongJae,
>>>
>>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
>>>> Hello Sang-Heon,
>>>>
>>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>>>>
>>>>> Nowadays, damos operation actions support more various operation set.
>>>>> But comments(also, generated documentation) doesn't updated.
>>>>> So, fix the comments with current support status.
> [...]
>>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
> [...]
>>>>>     * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
>>>>>     * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
>>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
>>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
>>>>
>>>> Nice!
>>>
>>> But doesn't it make confusion about whether this pages out to disk or does
>>> demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
>>> demotion, but it looks "reclaim" includes pageout and demotion together in my
>>> understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.
> 
> To my understanding, DAMOS_PAGEOUT can also do demotion when demotion_enabled
> is set.  Am I missing something?

Actually no, please see below.

do_demote_pass in shrink_folio_list()
https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122

The do_demote_pass is used here.
https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L1302

can_demote() implementation returns false when demotion_enabled is on.
https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L351

The replated commit is as follows.
mm/migrate: add sysfs interface to enable reclaim migration
https://github.com/torvalds/linux/commit/20b51af15e014cac63b58a4f8b8b323ac35bccce

> 
>>
>> My intention was just to synchronize with the Design documentation.
>>
>> So how about changing the description to `Page out the region`, Would
>> this be also confusing?
>> I feel like it would be clearer than using word "reclaim"

I don't have a good idea but it looks like recusive explanation.

> 
> In my opinion, "reclaim" is good.

I wish there could be better term that distinguishes between swap out and
demotion.  In my understanding "reclaim" includes both swap out and demotion.

I also found that man page explanation about MADV_PAGEOUT is "reclaim these 
pages".  If this is correct, then maybe demotion isn't included in "reclaim".

Thanks,
Honggyu
