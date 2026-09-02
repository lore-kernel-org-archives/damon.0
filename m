Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E177080D
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316487; cv=none; b=bwrmm++8rJFYxqIKVPr0nBKKYu2VeQPrMtYbHLe/YyVTMxDdNjBifJc+5xrzIb5am2rG3dq9GaOt115Jr3y4JDozhPqywfxmxMfOYx6keZAg2v0IFEmHd4zuuz35K+3XbCztSKwqqPGZeucXWfzAFeIU8ssYyE7eTs9d5mHsKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316487; c=relaxed/simple;
	bh=N5kuQisIWGCvBPX1Sl+zaSJAsUfu8V9chEb4hY2+YTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gonmLKxLcBy25xpOGv2wbn9aYJm99eoBaR40dBHEwP8DP0tlQkvFyqwrVOJsQ8xPBeJunKzlg0SoHMScvhWBHyAG/hI5hnfHdtV8ukcfPRu4iDqrwm2rwBkio1edrcM/VYmziX4+TSZNMFKACayNsqGliGwdudcm7jq77h2Jj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O3eeOop9; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O3eeOop9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788316481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d2ZO4JyQfYg3YFJgj1rtHn543boKrzvkS+tanZwl4YA=;
	b=O3eeOop9NrnC/PkyelG/R8kaMPO+DNAPJw0sTiRhK1Cwqs0oyoIcrET8ul9PF8ieGeXXnZREygHSMNCskNs7GE6VR+12O7ILvgvJu9+/Nc8elCvmwCPQjPvhZdyjlSIqrV7o6HeWy7cQLAFeNJQBRdG3dJmI79RiOja/vDyaIKs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XAAqVXz_1788316480;
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XAAqVXz_1788316480 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 10:34:40 +0800
Message-ID: <ee0f3f47-f6c0-4b3c-807c-db80385db3b8@linux.alibaba.com>
Date: Wed, 2 Sep 2026 10:34:39 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/damon/ops-common: use a page-aligned address in
 damon_ptep_mkold()
To: SJ Park <sj@kernel.org>, Nathan Gao <zcgao@amazon.com>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@kernel.org, ryan.roberts@arm.com
References: <20260902001142.107226-1-sj@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260902001142.107226-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 8:11 AM, SJ Park wrote:
> On Tue, 1 Sep 2026 13:10:01 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> 
>> __damon_va_prepare_access_check() picks a random byte address within the
>> region and stores it in r->sampling_addr. damon_va_mkold() passes it into
>> a page table walk, which hands it to damon_ptep_mkold() as the address of
>> the page to sample:
>>
>>    damon_va_mkold(mm, r->sampling_addr)
>>      damon_va_walk_page_range(mm, addr, addr + 1)
>>        damon_mkold_pmd_entry()
>>          damon_ptep_mkold(pte, vma, addr)
>>            ptep_test_and_clear_young(vma, addr, pte)
>>            mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
>>
>> For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
>> clearing of the young flag for large folios"), the contpte helper walked
>> exactly CONT_PTES entries from the aligned-down page table pointer and
>> used @addr only to pass down to each entry, so an unaligned value was
>> harmless:
>>
>>          ptep = contpte_align_down(ptep);
>>          addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>>          for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
>>
>> Now the range to walk is derived from @addr instead: end = addr +
>> nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
>> page of a contpte block, the sub-page offset puts end just past the
>> block boundary, so the round-up lands a whole block further and the
>> walk clears PTE_AF in CONT_PTES entries beyond the sampled block. For
>> the last block in a page table page, those entries are past the end of
>> that page, so the walk writes into the page that follows.
> 
> I just wanted to call out again that I'm wondering if we could restore the
> unaligned address support in the helper.  E.g., as a very dirty hack that I can
> imagine off the top of my head,
> 
> '''
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -30,6 +30,7 @@ static inline pte_t *contpte_align_addr_ptep(unsigned long *start,
>                                               unsigned long *end, pte_t *ptep,
>                                               unsigned int nr)
>   {
> +       *start = PAGE_ALIGN_DOWN(*start);
>          /*
>           * Note: caller must ensure these nr PTEs are consecutive (present)
>           * PTEs that map consecutive pages of the same large folio within a
> '''
> 
> I and Nathan have no strong clue, so we are looking for Baolin and others'
> opinion.
> 
> While waiting for the opinions, I and Nathan agree we should stop bleeding with
> a pinpoint hotfix change in DAMON.

Thanks for the reporting.

IMO, we could let the arch low-level functions handle the alignment of 
addr, but that would also require changing functions like 
contpte_clear_young_dirty_ptes(), contpte_set_ptes() and so on, which 
would cause a lot of churn? (they also assume that addr is page aligned).

Since the arch low-level functions basically assume that addr is 
page-size aligned, and the addr handling in the mm core is also mostly 
page-size aligned, I think the caller guaranteeing that addr is 
page-size aligned is a reasonable fix. So:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
