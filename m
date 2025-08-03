Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7C2E3712
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754196192; cv=none; b=RannT3RZ43BJlG0HoGBbqzeVxTtC0tkuBwnYHKZTFYGprNwNv+oGTCDvULn0QoVM3eFQs8uBtaZJ3jEbsF2qeJH6kFmRW98L+/Gojv7jDtK55fvoH5P++uUfbwGdvptTzxSKyLralBR+mhLp1Nvd0ZPhBKuuN7B0+0nCDWhGN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754196192; c=relaxed/simple;
	bh=ARiS0qWmblhIuhTyt+3Sf8YOTmF2vldfXZgJpp35ECo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gyN2qhrPrMl02VObiPBJIpP58Fk+yddDDwjOhCr5E+4UYdfYTOk+IQwFRhYJqObXtMOpjJ71KbOAt0DpraoYk+jTu6Soj4cj5/2K3H8BuLH7wzuAbldJsUs5M7w7lwv+0gh8GOH3sqHXyD1Aia3fLJXBiirC2vZIzYvIa0UNNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-55-688ee8d8908b
Message-ID: <68a36ae4-5dc0-4023-b850-2af0401d6d75@sk.com>
Date: Sun, 3 Aug 2025 13:43:03 +0900
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
References: <20250803042208.50634-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250803042208.50634-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnke6NF30ZBstWCVs8+f+b1eLEiwSL
	e2v+s1oc/vqGyYHFY+esu+wem1Z1snls+jSJ3ePF5pmMASxRXDYpqTmZZalF+nYJXBkLNq9j
	LZhtVHHmwhnGBsbtGl2MnBwSAiYSp4/8Zoax9056zghi8wpYSsx99Y2pi5GDg0VAReL2DymI
	sKDEyZlPWEBsUQF5ifu3ZrCD2MwCBRKPz71hBbGFBTwldj/6xAQRF5GY3dkGNl5EQFHi3OOL
	YDVCAkYSm7+fB+tlE1CTuPJyElg9p4CxxMH1/1khes0kurZ2MULY8hLNW2cDzeECOnMOm8Tr
	a7dZIG6WlDi44gbLBEbBWUjum4Vk9ywks2YhmbWAkWUVo1BmXlluYmaOiV5GZV5mhV5yfu4m
	RmCQL6v9E72D8dOF4EOMAhyMSjy8O771ZgixJpYVV+YeYpTgYFYS4T3X1Z0hxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgTH2qch05eR1Nc82ZtU+vH1o
	lRLDQ8VijobwPuYapfiUGb+Wvy56qxvD4HQqtLA4Z9qf2uN5f3L9Dll8dujKbOCY0Xb++cX6
	A6JCtTUPZTkLUqvffd1b+G2md0AWkzeD9RyTBaXr05jWmwU0n77Z6ds5qzA0+eX2D/L7ZZ98
	dI3SfMJz2/DLBiWW4oxEQy3mouJEAEK5GL1uAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsXCNUNLT/fGi74Mg69ruC2e/P/NanHiRYLF
	4bknWS3urfnPanH46xsmB1aPnbPusntsWtXJ5rHp0yR2jxebZzJ6LH7xgSmANYrLJiU1J7Ms
	tUjfLoErY8HmdawFs40qzlw4w9jAuF2ji5GTQ0LARGLvpOeMIDavgKXE3FffmLoYOThYBFQk
	bv+QgggLSpyc+YQFxBYVkJe4f2sGO4jNLFAg8fjcG1YQW1jAU2L3o09MEHERidmdbcwgtoiA
	osS5xxfBaoQEjCQ2fz8P1ssmoCZx5eUksHpOAWOJg+v/s0L0mkl0be1ihLDlJZq3zmaewMg3
	C8kZs5CsmIWkZRaSlgWMLKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECQ3ZZ7Z+JOxi/XHY/
	xCjAwajEw7vjW2+GEGtiWXFl7iFGCQ5mJRHec13dGUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MJVlTHn9+wOFXvz3StYHnfuMa1r83D0+u4Txu0t7T
	yPLvS3KX1MbkrSoimsaf/c1bFT6aJXKw3zZccKPAeMuFHw+XfX4pPuPFcs6gjCMr61zNZYrn
	T1wSFZuUnRt8rUFJzlTZs7/wmGpky++FzzVS115sKrFoubopVYYvJPlA+IFXpp/3X25VYinO
	SDTUYi4qTgQAe20XPFUCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On 8/3/2025 1:22 PM, SeongJae Park wrote:
> On Sun, 3 Aug 2025 11:03:12 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
>> Hi SeongJae and Sang-Heon,
>>
>> On 8/2/2025 1:50 AM, SeongJae Park wrote:
>>> On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>>>
>>>> Hi, Honggyu
>>>>
>>>> On Fri, Aug 1, 2025 at 8:35 PM Honggyu Kim <honggyu.kim@sk.com> wrote:
>>>>>
>>>>> Hi Sang-Heon and SeongJae,
>>>>>
>>>>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
>>>>>> Hello Sang-Heon,
>>>>>>
>>>>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>>>>>>
>>>>>>> Nowadays, damos operation actions support more various operation set.
>>>>>>> But comments(also, generated documentation) doesn't updated.
>>>>>>> So, fix the comments with current support status.
>>> [...]
>>>>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>> [...]
>>>>>>>      * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
>>>>>>>      * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
>>>>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
>>>>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
>>>>>>
>>>>>> Nice!
>>>>>
>>>>> But doesn't it make confusion about whether this pages out to disk or does
>>>>> demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
>>>>> demotion, but it looks "reclaim" includes pageout and demotion together in my
>>>>> understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.
>>>
>>> To my understanding, DAMOS_PAGEOUT can also do demotion when demotion_enabled
>>> is set.  Am I missing something?
>>
>> Actually no, please see below.
> 
> I'm unsure to what point you are saying "no".  Are you saying DAMOS_PAGEOUT can
> also do demotion when demotion_enabled is set?  Or not?  Could you please
> clarify, and add more explanations about why you think so?

I checked it again and found I pointed out in the wrong place. Please see below.

> 
>>
>> do_demote_pass in shrink_folio_list()
>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122
>>
>> The do_demote_pass is used here.
>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L1302
>>
>> can_demote() implementation returns false when demotion_enabled is on.
>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L351
> 
> I'm again get confused.  Isn't it opposite?

The thing is that DAMOS_PAGEOUT call sequence is as follows.

   DAMOS_PAGEOUT
   -> damon_pa_pageout
   -> reclaim_pages
   -> reclaim_folio_list

In reclaim_folio_list(), it sets "no_demotion = 1" in scan_control, then invokes
shrink_folio_list().
https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L2237

Inside shrink_folio_list(), it calls can_demote() and it returns false even if 
demotion_enabled is true.
https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L352-L353

> 
> ```
> static bool can_demote(int nid, struct scan_control *sc,
>                         struct mem_cgroup *memcg)
> {
>          int demotion_nid;
> 
>          if (!numa_demotion_enabled)
>                  return false;
> ```
> 
> It returns "false" when demotion_enabled is "off" (unset).  Am I reading
> something wrong...?

The full implementation of can_demote is as follows.  It checks whether
"no_demotion" is set.

static bool can_demote(int nid, struct scan_control *sc,
		       struct mem_cgroup *memcg)
{
	int demotion_nid;

	if (!numa_demotion_enabled)
		return false;
	if (sc && sc->no_demotion)
		return false;

	demotion_nid = next_demotion_node(nid);
	if (demotion_nid == NUMA_NO_NODE)
		return false;

	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
	return mem_cgroup_node_allowed(memcg, demotion_nid);
}

Hope this is helpful.

> 
>>
>> The replated commit is as follows.
>> mm/migrate: add sysfs interface to enable reclaim migration
>> https://github.com/torvalds/linux/commit/20b51af15e014cac63b58a4f8b8b323ac35bccce
>>
>>>
>>>>
>>>> My intention was just to synchronize with the Design documentation.
>>>>
>>>> So how about changing the description to `Page out the region`, Would
>>>> this be also confusing?
>>>> I feel like it would be clearer than using word "reclaim"
>>
>> I don't have a good idea but it looks like recusive explanation.
>>
>>>
>>> In my opinion, "reclaim" is good.
>>
>> I wish there could be better term that distinguishes between swap out and
>> demotion.  In my understanding "reclaim" includes both swap out and demotion.
> 
> "Reclaim" also includes writeback operations.
> 
> I agree we have many rooms to improve in terms of terminologies.  But, I'd
> argue we don't need to have only 1:1 mapping terminologies.  Othrwise, maybe we
> don't need any documentation at all but just code.  "Reclaim" is a good general
> terminology for describing an effort to get free pages on a memory domain (NUMA
> node, zone, etc), in my opinion.
> 
> To be honest, btw, I'm not a fan of "promote/demote", and that was one of the
> reasons I insisted "DAMOS_MIGRATE_{HOT,COLD}" instead of
> "DAMOS_{PROMOTE,DEMOTE}".

I do agree, I feel the current memory tiering system doesn't represent the
tiered memory topology so promote/demote might not be good terms for now.

> 
>>
>> I also found that man page explanation about MADV_PAGEOUT is "reclaim these
>> pages".  If this is correct, then maybe demotion isn't included in "reclaim".
> 
> I interpret the term "reclaim" on the man page with a flexibility including my
> above definition, and hence I don't think this is contradicting in a very bad
> way against what I'm understanding.  That is, I interpret the documentation
> says MADV_PAGEOUT can also do demote pages under certain conditions.
> 
> I didn't write the documentation, so I may be completely wrong.  I also
> frustratingly lost my resource to validate the main question of this discussion
> (whether DAMOS_PAGEOUT can also do demotion or not), for now.  I'd like to
> continue this discussion based on code rather than a documentation that _might_
> be right or wrong, and preferrably based on real tests if you or I have a good
> testing setup.

The code I showed above explains well enough about this.

Thanks,
Honggyu
