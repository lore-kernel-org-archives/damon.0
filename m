Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6C1A23A0
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754199728; cv=none; b=FxooY22RN4EXo3Trk+nogiE5kskaqmk9KEaYf4yjsO6NGaVAnuiegW1D9O9xF7NDv5tQv3R/6edv9toQTPOfvXmmu849Mbqqbght79RYHPTDauy4lyi9xoGjQBZUnsc9oe26BrraJXoknckVSjn6F8TAvqMwY1Qhlm4yn7C5jVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754199728; c=relaxed/simple;
	bh=nWvWoSjh7x/5CkFQfyDQNQORnceueExtfiNH7IyyFFU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DMRYRHA2v9nGPoINVpX5RDb/c8DkoklpuSbXzgtdVVtv7EnaZZAMfjxfy0BMYzEMUEE4l6vkfvud9VzBZQrmyM/7hf6lsr0iwYx04Yy8Tmk+3Aelum7ibLGfjAq+llg1cIAkVDH/ytQZYT7yPfSSWno1lIFubJWd9UIDxNsdnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-8c-688ef6a62620
Message-ID: <356d8739-d47a-4d62-bec2-38ce8f4a91a1@sk.com>
Date: Sun, 3 Aug 2025 14:41:58 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Sang-Heon Jeon <ekffu200098@gmail.com>,
 damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Content-Language: ko
To: SeongJae Park <sj@kernel.org>
References: <20250803053028.51309-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250803053028.51309-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXC9ZZnke6yb30ZBj3z5S2e/P/NanHiRYLF
	vTX/WS0Of33D5MDisXPWXXaPTas62Tw2fZrE7vFi80zGAJYoLpuU1JzMstQifbsEroyZfz0L
	9ipWLPnwlK2Bcbt0FyMnh4SAiUT/p2vsMHbn5V+sIDavgKXEpUMP2EBsFgEViQd71zNCxAUl
	Ts58wgJiiwrIS9y/NQOsl1mgQOLxuTdgvcICnhK7H31igoiLSMzubGMGsUUEFCXOPb4IVMPB
	ISRgJLF+WyRImE1ATeLKy0lg5ZwCxhJb9kOUMwuYSXRt7WKEsOUlmrfOBopzAZ05g01i5vn3
	rBA3S0ocXHGDZQKj4Cwk581CsnoWklmzkMxawMiyilEoM68sNzEzx0QvozIvs0IvOT93EyMw
	xJfV/onewfjpQvAhRgEORiUe3h3fejOEWBPLiitzDzFKcDArifCe6+rOEOJNSaysSi3Kjy8q
	zUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBYVXr2sOM6tkhZeY9tr/J+lcgc
	uPxqew3T/derkxrd/NoW88tPNpv6lynxv8KdMFMp4Z3XJ/ZkXvvAfk1j97abWpPqFvD2J0to
	JZhHCL+bMPGhR5Hv/Yif3WUXP3Q557OsqLIQMazX/28s/t9mq/put6KJj99v054w934i57WT
	evvOLpt3fbWDEktxRqKhFnNRcSIAFzshh20CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsXCNUNLT3fZt74Mg4PLJC2e/P/NanHiRYLF
	4bknWS3urfnPanH46xsmB1aPnbPusntsWtXJ5rHp0yR2jxebZzJ6LH7xgSmANYrLJiU1J7Ms
	tUjfLoErY+Zfz4K9ihVLPjxla2DcLt3FyMkhIWAi0Xn5FyuIzStgKXHp0AM2EJtFQEXiwd71
	jBBxQYmTM5+wgNiiAvIS92/NYAexmQUKJB6fewPWKyzgKbH70ScmiLiIxOzONmYQW0RAUeLc
	44tANRwcQgJGEuu3RYKE2QTUJK68nARWzilgLLFlP0Q5s4CZRNfWLkYIW16ieets5gmMfLOQ
	XDELyYZZSFpmIWlZwMiyilEkM68sNzEzx1SvODujMi+zQi85P3cTIzBgl9X+mbiD8ctl90OM
	AhyMSjy8O771ZgixJpYVV+YeYpTgYFYS4T3X1Z0hxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcr
	PDVBSCA9sSQ1OzW1ILUIJsvEwSnVwBg7RWgN053jD/c+q+QQP8DlEd97y5Z/9Y0YBf0psn8T
	gxuUZ6inx6/PU0suXbFo5ak6zmPl7ixlu5LjcvVlio8edC3wOvMyQfTvHJ4dN4+nX5/clHhz
	peOdddzaNZNTzAKl+etNXzctK+zPFHVR19yyJEyx4+X7M1snVBzw37bVYoLhpsXyDkosxRmJ
	hlrMRcWJAIspxaFUAgAA
X-CFilter-Loop: Reflected



On 8/3/2025 2:30 PM, SeongJae Park wrote:
> On Sun, 3 Aug 2025 13:43:03 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae,
>>
>> On 8/3/2025 1:22 PM, SeongJae Park wrote:
>>> On Sun, 3 Aug 2025 11:03:12 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
>>>
>>>> Hi SeongJae and Sang-Heon,
>>>>
>>>> On 8/2/2025 1:50 AM, SeongJae Park wrote:
>>>>> On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>>>>>
>>>>>> Hi, Honggyu
>>>>>>
>>>>>> On Fri, Aug 1, 2025 at 8:35 PM Honggyu Kim <honggyu.kim@sk.com> wrote:
>>>>>>>
>>>>>>> Hi Sang-Heon and SeongJae,
>>>>>>>
>>>>>>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
>>>>>>>> Hello Sang-Heon,
>>>>>>>>
>>>>>>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>>>>>>>>
>>>>>>>>> Nowadays, damos operation actions support more various operation set.
>>>>>>>>> But comments(also, generated documentation) doesn't updated.
>>>>>>>>> So, fix the comments with current support status.
>>>>> [...]
>>>>>>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>>>> [...]
>>>>>>>>>       * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
>>>>>>>>>       * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
>>>>>>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
>>>>>>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
>>>>>>>>
>>>>>>>> Nice!
>>>>>>>
>>>>>>> But doesn't it make confusion about whether this pages out to disk or does
>>>>>>> demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
>>>>>>> demotion, but it looks "reclaim" includes pageout and demotion together in my
>>>>>>> understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.
>>>>>
>>>>> To my understanding, DAMOS_PAGEOUT can also do demotion when demotion_enabled
>>>>> is set.  Am I missing something?
>>>>
>>>> Actually no, please see below.
>>>
>>> I'm unsure to what point you are saying "no".  Are you saying DAMOS_PAGEOUT can
>>> also do demotion when demotion_enabled is set?  Or not?  Could you please
>>> clarify, and add more explanations about why you think so?
>>
>> I checked it again and found I pointed out in the wrong place. Please see below.
>>
>>>
>>>>
>>>> do_demote_pass in shrink_folio_list()
>>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122
>>>>
>>>> The do_demote_pass is used here.
>>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L1302
>>>>
>>>> can_demote() implementation returns false when demotion_enabled is on.
>>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L351
>>>
>>> I'm again get confused.  Isn't it opposite?
>>
>> The thing is that DAMOS_PAGEOUT call sequence is as follows.
>>
>>     DAMOS_PAGEOUT
>>     -> damon_pa_pageout
>>     -> reclaim_pages
>>     -> reclaim_folio_list
>>
>> In reclaim_folio_list(), it sets "no_demotion = 1" in scan_control, then invokes
>> shrink_folio_list().
> 
> Thank you, this clarifies.  DAMOS_PAGEOUT doesn't demote pages even if
> demotion_enabled is set.  Thank you for enlightening me.

Thank you too. Glad to hear that.

> 
> So, "reclaim" means "reclaim".  shrink_folio_list() can do demotions when
> demotion_enabled is set.  I hence still don't think this patch is saying
> something very wrong, and how it could be improved.  Do you have more specific
> change suggestions for this patch for an improvment?

I would just like to make the term "reclaim" clearer and we may be able to 
define what "reclaim" is.  I think we can choose between the following two
different definitions.

Definition 1. "reclaim" includes "pageout" and "demotion".
In this case, we better clarify all the other documents that mentions about
those terms.

Definition 2. "reclaim" only includes "pageout", but "demotion" is out of scope.
In this case, shrink_folio_list just do pageout, but "demotion" is only
exceptional case so we can say the "demotion" escapes from "reclaim" logic.

We might have to clarify the term "reclaim" for those cases whether it includes 
"demotion" or not.  We might have to discuss with other mm developers together.

Thanks,
Honggyu
