Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128320E03F
	for <damon@lists.linux.dev>; Thu, 28 Aug 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345122; cv=none; b=gBPHFnPvSmmO1Afa4cWiPN9hBxDTtJYfv8XHUuQ8sXkpoQBaQCbwNU41yedVGAD5Ceyc8BwFpoQpsiOayCVJRddRlUk5CbC6c1k29aF8qcXzj8fVIwNh351MFJLxIXSyhKNoFhZQEDkeldXtORys+NqYveVVfbhv67xLz4kv28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345122; c=relaxed/simple;
	bh=3O3uHOYrSjX5eIAnrOgb2x6/7x18qBCfNirsOPKZZAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lN9iG4rI0p2v3NHUWQCOrqjr0er2u4TE21HhKJC/z5tdxYxmxsb0nxantHh4nipefvhZWNPwmBz83QpKYSXC9J8vcSuXIjQneglEmoT836V/qcZFCBfZC8J5JpQRnLQdBYRBvKcdwJOQaWTPAEZxSfH2AlJKyz3Ui49Qd/Ux3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cC3r93xGmz2VRHr;
	Thu, 28 Aug 2025 09:35:37 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E1DE1A0188;
	Thu, 28 Aug 2025 09:38:36 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 09:38:35 +0800
Message-ID: <2c0477d5-217e-40fa-aa26-1dde19280779@huawei.com>
Date: Thu, 28 Aug 2025 09:38:34 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for
 DAMOS_PAGEOUT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>, <kernel-team@meta.com>,
	kernel test robot <lkp@intel.com>
References: <20250827180743.47876-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250827180743.47876-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/28 2:07, SeongJae Park 写道:
> On Wed, 27 Aug 2025 19:37:38 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> Hi SJ,
>>
>> 在 2025/8/27 10:42, SeongJae Park 写道:
>>> On Wed, 27 Aug 2025 10:21:41 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>>>
>>>> 在 2025/8/26 22:21, SeongJae Park 写道:
>>>>> On Tue, 26 Aug 2025 12:51:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>>>>>
>>>>>> Hi SJ,
>>>>>>
>>>>>> 在 2025/8/26 11:21, SeongJae Park 写道:
> [...]
>>>> Please consider approving this fix.
>>> I'm yet in travel, and I'd like to take more time on thinking about the proper
>>> fix.  Quanmin, could you share more details about your test setups, both for
>>> the compiling success case and failing case?
>> Apologies for disturbing you during your travels. Please allow me to explain:
> No worry, I'm the one who would like to apologize, for delayed response :)
> I'm back from the travel, btw.
>
>> When CONFIG_PHYS_ADDR_T_64BIT is enabled on "i386" [1], the phys_addr_t type
>> becomes 64-bit, requiring the use of the do_div function. We are in agreement
>> on this point.
>>
>> On arm32, if LPAE (which we intend to support in this series) is enabled,
>> CONFIG_PHYS_ADDR_T_64BIT will also be enabled. In this case, pa / addr_unit
>> will involve 64-bit division and similarly require the do_div function.
>> Obviously, such link errors should normally occur under these circumstances.
>> Unfortunately, the expected anomalies did not manifest in my previous tests.
>> This may be related to some incorrect adjustments I had made to my local build
>> environment quite some time ago — though I cannot be entirely certain. That
>> said, I have since cleaned up the old configurations and ensured the current
>> environment is clean and normal. For now, we have confirmed the actual problem
>> and its root cause, shall we focus on fixing it?
> Thank you for sharing the details.  I wanted to better understand where the
> issue happens and not, to clearly understand the root cause and make a proper
> fix based on that.  I think we can now focusing on fixing it.
>
>> In summary, after introducing addr_unit, we expect that any 32-bit architecture
>> should support monitoring of 64-bit phys_addr_t. Therefore, we can consider the
>> following adjustment:
>>
>> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
>>
>> Or at least adjust it to:
>>
>> #if defined(__i386__) || (defined(__arm__) && defined(CONFIG_PHYS_ADDR_T_64BIT))
>>
>> I have thoroughly re-validated the feature functionality today and confirmed the
>> correctness of the aforementioned modifications. Therefore, could I kindly ask
>> you to consider the aforementioned modifications when you have some free time?
> Thank you for the suggestion and testing, Quanmin!
>
> I was thinking making the change for only i386 is right since I was mistakenly
> thinking the issue happens only on i386.  Now it is clear I was wrong and we
> have at least two cases.  And I agree your suggestion will fix both cases.
>
> But I'm bit concerned i386 and arm might not all the case, so wannt make the
> fix more generalized.  My understanding of the problem, which is enlightened
> thanks to you, is that not every config supports dividing 64 bit with 32 bit.
> And div_u64() is suggested in general for dividing 64 bit with 32 bit.  So,
> what about making the if condition more general but specific to the root cause,
> like below?
>
> static unsigned long damon_pa_core_addr(
>                 phys_addr_t pa, unsigned long addr_unit)
> {
>         /*
>          * Use div_u64() for avoiding linking errors related with __udivdi3,
>          * __aeabi_uldivmod, or similar problems.  This should also improve the
>          * performance optimization (read div_u64() comment for the detail).
>          */
>         if (sizeof(pa) == 8 && sizeof(addr_unit) == 4)
>                 return div_u64(pa, addr_unit);
>         return pa / addr_unit;
> }
>
> Because the sizeof() result can be known at compile time, I think it shouldn't
> cause the linking time error, and I confirmed that by passing the i386 test
> case that kernel test robot shared.
>
> Could I ask your opinion, Quanmin?  If you think that works, I could post v3 of
> this patch series with the above fix.

Great! I believe this approach is better. This modification is more generic
and eliminates the need to deal with those messy configs.

I have also re-validated based on this change, and it is working correctly.

Thanks,
Quanmin Yan

