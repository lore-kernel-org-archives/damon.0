Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788840243C
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970164; cv=none; b=kLRVKJeMClbh96PRcvo5al2DDBlg/D3y/lzSumCQ/lNL+uyV/ZQruxK0cAf/5no8jNZFCr1ydalZ2IHVB+qIOcFa4kvq6hIntNWZLLF5q5tj8HomtauQZcjfk7Mla9e5X72bNeHPtb1B6TWX/XJIemsU28yDYXjZlLwaP2MnMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970164; c=relaxed/simple;
	bh=i3S2fn2XC+YfLkn36Lv4D3Gxl3LAootFRl9VWhwlcAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RUu22rNv/DpbvRtg2XAgqAvwrUXtirHobEKcTLSg8zhwmVw66n2oXz9dzFJvB1dZKYKe8XXy7DvfZKayujhP49n8B5W0vZMeRMSS3Ci6JVIMa4KQpTWmXSUadu2DQ7wSNV+jHXZfd79MqCfqUNPsy98ctmIdnatWGY71INt4EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4flWs03LK4zJ46CX;
	Tue, 31 Mar 2026 23:15:32 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 11DE140571;
	Tue, 31 Mar 2026 23:15:51 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Mar 2026 18:15:50 +0300
Message-ID: <4fe88a6b-2d9a-455b-9ab0-5ff153e0e88d@huawei-partners.com>
Date: Tue, 31 Mar 2026 18:15:50 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE
 scheme action
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260331013109.66590-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260331013109.66590-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 3/31/2026 4:31 AM, SeongJae Park wrote:
> Hello Asier,
> 
> On Mon, 30 Mar 2026 14:57:58 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> This patch set introces a new action:  DAMOS_COLLAPSE.
>>
>> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
>> working, since it relies on hugepage_madvise to add a new slot. This
>> slot should be picked up by khugepaged and eventually collapse (or
>> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
>> enabled, khugepaged will not be working, and therefore no collapse
>> will happen.
> 
> I should raised this in a previous version, sorry.  But, that is only a half of
> the picture.  That is, khugepaged is not the single THP allocator for
> MADV_HUGEPAGE.  IIUC, MADV_HUGEPAGE-applied region also allocates huge pages in
> page fault time.  According to the man page,
> 
>     The kernel will regularly scan the areas marked as huge page  candidates
>     to replace  them with huge pages.  The kernel will also allocate huge pages
>     directly when the region is naturally aligned to the huge page size (see
>     posix_memalign(2)).
> 
> I think the description is better to be wordsmithed or clarified.  Maybe just
> pointing the MADV_COLLAPSE intro commit (7d8faaf15545 ("mm/madvise: introduce
> MADV_COLLAPSE sync hugepage collapse")) for the rationale could also be a good
> approach, as the aimed goal of DAMOS_COLLAPSE is not different from
> MADV_COLLAPSE.
> 
>>
>> DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
>> the address range synchronously.
>>
>> This new action may be required to support autotuning with hugepage
>> as a goal[1].
>>
>> [1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
>>
>> ---------
>> Benchmarks:
> 
> I recently heard some tools could think above line as the commentary
> area [1] separation line.  Please use ==== like separator instead.  For
> example,
I will fix it for the next version.
> 
>     Benchmarks
>     ==========
> 
>>
>> Tests were performed in an ARM physical server with MariaDB 10.5 and 
>> sysbench. Read only benchmark was perform with uniform row hitting,
>> which means that all rows will be access with equal probability.
>>
>> T n, D h: THP set to never, DAMON action set to hugepage
>> T m, D h: THP set to madvise, DAMON action set to hugepage
>> T n, D c: THP set to never, DAMON action set to collapse
>>
>> Memory consumption. Lower is better.
>>
>> +------------------+----------+----------+----------+
>> |                  | T n, D h | T m, D h | T n, D c |
>> +------------------+----------+----------+----------+
>> | Total memory use | 2.07     | 2.09     | 2.07     |
>> | Huge pages       | 0        | 1.3      | 1.25     |
>> +------------------+----------+----------+----------+
>>
>> Performance in TPS (Transactions Per Second). Higher is better.
>>
>> T n, D h: 18324.57
>> T n, D h 18452.69
> 
> "T m, D h" ?
Right, my bad. I will fix it.
> 
>> T n, D c: 18432.17
>>
>> Performance counter
>>
>> I got the number of L1 D/I TLB accesses and the number a D/I TLB
>> accesses that triggered a page walk. I divided the second by the
>> first to get the percentage of page walkes per TLB access. The
>> lower the better.
>>
>> +---------------+--------------+--------------+--------------+
>> |               | T n, D h     | T m, D h     | T n, D c     |
>> +---------------+--------------+--------------+--------------+
>> | L1 DTLB       | 127248242753 | 125431020479 | 125327001821 |
>> | L1 ITLB       | 80332558619  | 79346759071  | 79298139590  |
>> | DTLB walk     | 75011087     | 52800418     | 55895794     |
>> | ITLB walk     | 71577076     | 71505137     | 67262140     |
>> | DTLB % misses | 0.058948623  | 0.042095183  | 0.044599961  |
>> | ITLB % misses | 0.089100954  | 0.090117275  | 0.084821839  |
>> +---------------+--------------+--------------+--------------+
>>
>> - We can see that DAMOS "hugepage" action works only when THP is set
>>   to madvise. "collapse" action works even when THP is set to never.
> 
> Make sense.
> 
>> - Performance for "collapse" action is slightly lower than "hugepage"
>>   action and THP madvise.
> 
> It would be good to add your theory about from where the difference comes.  I
> suspect that's mainly because "hugepage" setup was allocating more THP?
Correct. I will add a better description of the behaviour.
>> - Memory consumption is slighly lower for "collapse" than "hugepage"
>>   with THP madvise. This is due to the khugepage collapses all VMAs,
>>   while "collapse" action only collapses the VMAs in the hot region.
> 
> But you use thp=madvise, not thp=always?  So only hot regions, which
> DAMOS_HUGEPAGE applied, could use THP.  It is same to DAMOS_COLLAPSE use case,
> isn't it?
> I'd rather suspect the natural-aligned region huge page allocation of
> DAMOS_HUGEPAGE as a reason of this difference.  That is, DAMOS_HUGEPAGE applied
> regions can allocate hugepages in the fault time, on multiple user threads.
> Meanwhile, DAMOS_COLLAPSE should be executed by the single kdamond (if you
> utilize only single kdamond).  This might resulted in DAMOS_HUGEPAGE allocating
> more huge pages faster than DAMOS_COLLAPSE?
This well could be the case. The database used 32 threads, so we may have
simultaneously faults in all those threads, hence the behavior.
> 
>> - There is an improvement in THP utilization when collapse through
>>   "hugepage" or "collapse" actions are triggered.
> 
> Could you clarify which data point is showing this?  Maybe "Huge pages" /
> "Total memory use" ?  And why?  I again suspect the fault time huge pages
> allocation.
Looking at the performance counters and the percentage of TLB accesses
that triggered a page walk. I will clarify this point in the next version.
> 
>> - "collapse" action is performance synchronously, which means that
>>   page collapses happen earlier and more rapidly.
> 
> But these test results are not showing it clearly.  Rather, the results is
> saying "hugepage" was able to make more huge pages than "collapse".  Still the
> above sentence makes sense when we say about "collapsing" operations.  But,
> this test is not showing it clearly.  I think we should make it clear the
> limitation of this test.
I will add another table clarifying this. My point was that the allocation
in my tests happened earlier and faster using "collapse" than "hugepage".
>>   This can be
>>   useful or not, depending on the scenario.
>>
>> Collapse action just adds a new option to chose the correct system
>> balance.
> 
> That's a fair point.  I believe we also discussed pros and cons of
> MADV_COLLAPSE, and concluded MADV_COLLAPSE is worthy to be added.  For
> DAMOS_COLLAPSE, I don't think we have to do that again.
> 
>>
>> Changes
>> ---------
>> RFC v2 -> v1:
>> Fixed a missing comma in the selftest python stript
>> Added performance benchmarks
>>
>> RFC v1 -> RFC v2:
>> Added benchmarks
>> Added damos_filter_type documentation for new action to fix kernel-doc
> 
> Please put changelog in the commentary area, and consider adding links to the
> previous revisions [1].
Ack
> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> ---
> 
> Code looks good to me.  Nonetheless I'd hope above commit message and benchmark
> results analysis be more polished and/or clarified.
> 
> [1] https://docs.kernel.org/process/submitting-patches.html#commentary
> 
> 
> Thanks,
> SJ

Thanks for the review.

I will run some more tests today. The test try to hit every row in the database,
which may not be realistic. Usually only some parts of the table are really hot.
I will change the test to get something closer to a normal distribution on the
table hit.

-- 
Asier Gutierrez
Huawei

