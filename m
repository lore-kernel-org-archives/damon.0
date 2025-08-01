Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70219E96A
	for <damon@lists.linux.dev>; Fri,  1 Aug 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049054; cv=none; b=ndRAzKegWWKh7Ftux11QRCL7lHqSLwfDJ7CyVbX2av3kdhHh0HLuLfxg1N+phJz6xExB7yYFuBSJn/4bzWut6urFNFXFYkXz5OFCK9LX8E1zlQmINGRusqOcpGTCpNavOm3le+p8/fLgofuDXwQ/azs2HY/o0Y8rSHAUGynTm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049054; c=relaxed/simple;
	bh=bvyEmK6hIleyuKk9Si/tK27HQEyw8CPYgjt2mAeuES4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UNNiCcNValbeZCjsE5JOqEAEVjh2o3V+qOI9iTyddAl6Z0QxN5gmAGFFuASgfEvxP+8v2//pkKBoLh/7TDHgfNEQrXhLiRknLpxpYKDPqhrz5GKlQd9B7Y5vG1ERCDgmZQ72MPBONiXXYNMTMS+MVC47bfJe9IOh9RYZBeHWgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d1-688ca68a1765
Message-ID: <679e90f5-cbeb-4078-ad76-a075fa5d7afa@sk.com>
Date: Fri, 1 Aug 2025 20:35:38 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Content-Language: ko
To: SeongJae Park <sj@kernel.org>, Sang-Heon Jeon <ekffu200098@gmail.com>
References: <20250731175827.16060-1-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250731175827.16060-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnkW73sp4Mg6NsFk/+/2a1OPEiweLe
	mv+sFoe/vmFyYPHYOesuu8emVZ1sHps+TWL3eLF5JmMASxSXTUpqTmZZapG+XQJXRtunLWwF
	75Qrjs2fw9bAeEami5GTQ0LARGLesXY2GHvtxL+sIDavgKXEm7YmFhCbRUBF4sj1V0wQcUGJ
	kzOfgMVFBeQl7t+awQ5iMwu4SVy9fg/MFhbwlNj96BMTRFxEYnZnGzOILQIUv75lPtguIQEj
	iVNr/jKC2GwCahJXXk4Cq+cUMJaY/PwEC0SvmUTX1i5GCFteYvvbOUBzuIDunMImsfPLDXaI
	oyUlDq64wTKBUXAWkvtmIdk9C8msWUhmLWBkWcUolJlXlpuYmWOil1GZl1mhl5yfu4kRGOTL
	av9E72D8dCH4EKMAB6MSD6/Awu4MIdbEsuLK3EOMEhzMSiK857qAQrwpiZVVqUX58UWlOanF
	hxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhhFWE9JF9s5nNT5vf/JqplqFZfMNzF2
	BEc13DCPb66wdn7/03T7z2jGnXzPOuxnLZ53JWTVjYnrLwpVBKafVllvuoMvziCqd829qdGx
	1eHbWorfCt/sX+gSqTyBQ+xd0OPJPGezw8OnWjBaJenGG/OIvnlUMyEhasZl+zOTTh8UZZjc
	/1ZOWlmJpTgj0VCLuag4EQC+EQ+TbgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXCNUNLT7drWU+GwcEGfYsn/3+zWpx4kWBx
	eO5JVot7a/6zWhz++obJgdVj56y77B6bVnWyeWz6NInd48XmmYwei198YApgjeKySUnNySxL
	LdK3S+DKaPu0ha3gnXLFsflz2BoYz8h0MXJySAiYSKyd+JcVxOYVsJR409bEAmKzCKhIHLn+
	igkiLihxcuYTsLiogLzE/Vsz2EFsZgE3iavX74HZwgKeErsffWKCiItIzO5sYwaxRYDi17fM
	ZwOxhQSMJE6t+csIYrMJqElceTkJrJ5TwFhi8vMTLBC9ZhJdW7sYIWx5ie1v5zBPYOSbheSM
	WUhWzELSMgtJywJGllWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBQbus9s/EHYxfLrsfYhTg
	YFTi4RVY2J0hxJpYVlyZe4hRgoNZSYT3XBdQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqC
	kEB6YklqdmpqQWoRTJaJg1OqgTHQIm5bh78L193qOXeLJTK9vO/8rXPPXFbh28otsMzb+w3b
	62TpXaX/N1pOkYw9Yn/KaqrKbJlObZEdl2649ty8mP2Qf96kDVYGZU5/s464lPxN15963S1c
	fOdX+eatDXJrnnVbveaSCd/4l+9W0pZ5582+GniwmmbXd3U4/muRCSzaPcvxnBJLcUaioRZz
	UXEiAGrw5dBWAgAA
X-CFilter-Loop: Reflected

Hi Sang-Heon and SeongJae,

On 8/1/2025 2:58 AM, SeongJae Park wrote:
> Hello Sang-Heon,
> 
> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
>> Nowadays, damos operation actions support more various operation set.
>> But comments(also, generated documentation) doesn't updated.
>> So, fix the comments with current support status.
> 
> Thank you for catching this and fixing!
> 
>>
>> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>> ---
>> I also found below patch(https://lore.kernel.org/damon/20250730200239.60984-1-sj@kernel.org/T/#t)
>> So, Is it means that DAMOS_STAT is only supported by paddr now?
> 
> No.  'vaddr' supports DAMOS_STAT.  The patch is not adding DAMOS_STAT support
> on vaddr, but extending the support for DAMOS filters.
> 
> Thank you for checking the thread and asking this question, though.  I see this
> as an important signal of another rooms to improve on the documentation.
> 
>> If my understanding is correct, then we need to fix Design documentation
>> and comments both.
>>
>> However, since it will be fixed soon. Keeping current status is also
>> affordable. So could you check this point as well?
>>
>> ---
>>
>>   include/linux/damon.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index cddf82eaac4e..0870e9f48b0f 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -128,7 +128,7 @@ struct damon_access_report {
> 
> Seems you are using damon/next as your baseline.  If there is no real
> dependencies to damon/next, please use mm-new as your baseline.  For more
> contexts about that, please refer to the DAMON maintainer-profile[1].
> 
>>    *
>>    * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLNEED.
>>    * @DAMOS_COLD:              Call ``madvise()`` for the region with MADV_COLD.
>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEOUT.
>> + * @DAMOS_PAGEOUT:   Reclaim the region.
> 
> Nice!

But doesn't it make confusion about whether this pages out to disk or does
demotion to the lower tier memory?  It's because PAGEOUT action doesn't do
demotion, but it looks "reclaim" includes pageout and demotion together in my
understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.

Thanks,
Honggyu

>>    * @DAMOS_HUGEPAGE:  Call ``madvise()`` for the region with MADV_HUGEPAGE.
>>    * @DAMOS_NOHUGEPAGE:        Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>>    * @DAMOS_LRU_PRIO:  Prioritize the region on its LRU lists.
>> @@ -146,8 +146,8 @@ struct damon_access_report {
>>    * The support of each action is up to running &struct damon_operations.
>>    * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
>>    * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
>> - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
>> - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
>> + * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD,
>> + * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.
> 
> Thank you for updating this!
> 
> But, now I find this place is having outdated information that partially
> duplicated with the DAMON design document[2].  I think the design document is
> better to maintain this kind of details.  What about keeping the high level
> information but giving a reference to the documentation for details, for
> example, like below?
> 
>      @@ -143,11 +143,9 @@ struct damon_access_report {
>        * @DAMOS_STAT:                Do nothing but count the stat.
>        * @NR_DAMOS_ACTIONS:  Total number of DAMOS actions
>        *
>      - * The support of each action is up to running &struct damon_operations.
>      - * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
>      - * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
>      - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
>      - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
>      + * The support of each action is up to running &struct damon_operations.  Refer
>      + * to 'Operation Action' section of Documentation/mm/damon/design.rst for
>      + * status of the supports.
>        */
> 
> Thanks,
> SJ
> 
> 
> [1] https://origin.kernel.org/doc/html/next/mm/damon/maintainer-profile.html#scm-trees
> [2] https://origin.kernel.org/doc/html/next/mm/damon/design.html#operation-action

