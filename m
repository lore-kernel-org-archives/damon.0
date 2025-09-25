Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737271D6AA
	for <damon@lists.linux.dev>; Thu, 25 Sep 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798685; cv=none; b=OMEoBWQZQtfRITED72fDsG5XdK6ESkvUxdW80lixb6hYzdZepaht4tQo/40K5YDX5GFn2+1JDccEG7KOfwtTFa/qBVTPmgoMBrQLfaFREOJafM/rQr28sRoK7RL1TUTYNF9nynHVGjKRzjyUTPvJd6jUxpS9QFc6VYC0yq6Ha5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798685; c=relaxed/simple;
	bh=RPGqskfNBJK2KMmXjQXlBPrIMbJaFtxk9HC8aROB+yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TpQreblcI7ZCPIFgDNQvphqx3eRLNvfCQWFuKvHgHwy38JjJRWqQDd2AYG5xGn2d2gGc4M2L1LBmtAgbDFAUmtqGe07FOVf2fkEBop5YzPSItDxtqmhM9/EUARQCaFm/VWQVVsl26ht97RcH/foNBEN2YwcLWj4Cqbd+BocPDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cXWCH6TvDz24hsP;
	Thu, 25 Sep 2025 19:07:39 +0800 (CST)
Received: from dggpemr200006.china.huawei.com (unknown [7.185.36.167])
	by mail.maildlp.com (Postfix) with ESMTPS id BBC1C140149;
	Thu, 25 Sep 2025 19:11:14 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by dggpemr200006.china.huawei.com
 (7.185.36.167) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 19:11:14 +0800
Message-ID: <eaee73bd-21cc-4da2-86a8-fe6a9576ab51@huawei.com>
Date: Thu, 25 Sep 2025 19:11:13 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] mm/damon: softlockup when kdamond walk page with cpu
 hotplug
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "Paul E . McKenney"
	<paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <zouyipeng@huawei.com>, Hugh Dickins
	<hughd@google.com>
References: <20250920104220.1399-1-sj@kernel.org>
Content-Language: en-US
From: Xinyu Zheng <zhengxinyu6@huawei.com>
In-Reply-To: <20250920104220.1399-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr200006.china.huawei.com (7.185.36.167)



On 9/20/2025 6:42 PM, SeongJae Park wrote:
> On Fri, 19 Sep 2025 20:56:56 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
>> On Thu, 18 Sep 2025, SeongJae Park wrote:
>>
>>> Hello,
>>>
>>> On Thu, 18 Sep 2025 03:00:29 +0000 Xinyu Zheng <zhengxinyu6@huawei.com> wrote:
>>>
>>>> A softlockup issue was found with stress test:
> [...]
>> This had me worried for a while: thought we might be needing to change
>> lots of other places, and scatter cond_resched()s here and there.
>>
>> But no: no need for cond_resched()'s, this is all just a confusion about
>> where pmd migration entries are handled: a pmd migration entry is accepted
>> by pmd_trans_huge_lock(), but is not accepted by pmd_trans_huge().
>>
>> See fs/proc/task_mmu.c for mm_walk examples of trying pmd_trans_huge_lock(),
>> then pte_offset_map_lock() if it failed, or ACTION_AGAIN if that failed too.
>>
>> When I ACTION_AGAINed damon_mkold_pmd_entry() and damon_young_pmd_entry()
>> in 6.5, I didn't realize that the pmd migration entries were reaching the
>> pte_offset_map_lock(), with corrupt results (or did pmd_bad() filter them
>> out? I didn't think so, but it'll take me too long now to work out whether
>> a pmd migration entry counts as pmd_bad or not); but knew that the new
>> pte_offset_map_lock() filtered them out safely if there was a race.
>>
>> But they've been reaching it without any race, so yes the ACTION_AGAIN
>> would send the mm_walk back again and again for as long as the pmd
>> migration entry remained there: not good, and Xinyu finds a lockup
>> when hotplugging CPU without preemption.
> 
> Thank you for your detailed and kind explanation, Hugh!
> 
>>
>> My suggested patch below (please take it over SJ, and do with it what
>> you will), converting damon_mkold_pmd_entry() and damon_young_pmd_entry()
>> to use pmd_trans_huge_lock() as I'd been expecting, so handling the
>> pmd migration entry up in that block.  (Side note: patch against 6.17-rc,
>> but I see mm.git adds also a damos_va_stat_pmd_entry(), which would
>> better be converted to the same pmd_trans_huge_lock() pattern -
>> though I notice you're not setting ACTION_AGAIN in that one.)
>>
>> But I have to admit, there's very little gained by using ACTION_AGAIN
>> in these functions: it helps not to miss the range when racing against
>> THP collapse or split, but you're already content to miss the extent
>> if it has a pmd migration entry, and there can still be an instant when
>> the range which used to have a page table does not yet show the THP.
>>
>> So if you prefer a smaller fix (but a larger source file!), just
>> dropping the walk->action = ACTION_AGAIN lines should be good enough.
> 
> I agree all your points.
> 
> I'd prefer the smaller source file following your suggested change below (using
> pmd_trans_huge_lock()) in long term.  But, for a short term, I'd prefer the
> smaller fix (dropping walk->action = ACTION_AGAIN) since it should also be
> merged into stable@, up to 6.5.y.
> 
> So, I'd like to suggest as following.  Let's drop the
> 'walk->action = ACTION_AGAIN' like the below attached one, for now.  After it
> is confirmed to fix the issue and merged into relevant trees including stable
> trees, let's revisit the code to cleanup following pmd_trans_huge_lock()
> pattern.
> 
> Please let me know if I'm missing something, or you have other opinions.
> 
> Xinyu, could you please test if the below attached patch fixes your issue and
> let us know the result?
> 
> If Xinyu confirms the validity of the fix and no one objects to the above plan,
> I will post the fix as a formal one with a better commit message.
> 

Hi, SJ. The below attached patch is works!

These days, I reproduced the same softlockup scenario for three times. 
It can be reproduced around an hour when I increase the memory pressure.
Then I patched the below fix, and ran the same testcase whole day, 
softlock didn't trigger again.

Sorry for the long wait. Thanks again for your solution and explanation!

> 
> Thanks,
> SJ
> 
> [...]
> 
> ==== >8 ====
>  From 743cafda8982624229541741dbfe5ff252328ac0 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Sat, 20 Sep 2025 03:35:34 -0700
> Subject: [PATCH] mm/damon/vaddr: do not try page table walk again
> 
> For a quick fix of a softlockup issue:
> https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  From 743cafda8982624229541741dbfe5ff252328ac0 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Sat, 20 Sep 2025 03:35:34 -0700
> Subject: [PATCH] mm/damon/vaddr: do not try page table walk again
> 
> For a quick fix of a softlockup issue:
> https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/vaddr.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 8c048f9b129e..7e834467b2d8 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -328,10 +328,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>   	}
>   
>   	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte) {
> -		walk->action = ACTION_AGAIN;
> +	if (!pte)
>   		return 0;
> -	}
>   	if (!pte_present(ptep_get(pte)))
>   		goto out;
>   	damon_ptep_mkold(pte, walk->vma, addr);
> @@ -481,10 +479,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>   #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
>   
>   	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> -	if (!pte) {
> -		walk->action = ACTION_AGAIN;
> +	if (!pte)
>   		return 0;
> -	}
>   	ptent = ptep_get(pte);
>   	if (!pte_present(ptent))
>   		goto out;


Xinyu Zheng

