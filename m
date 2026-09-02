Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DE337B81
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326860; cv=none; b=ppKQWWbwaTkYpQxJyCZsZbkzBgEeKhqMZrmR3S9zdP08VH5UTSmpusS6HF6a05KpPOoKPzDdpB3kwHBGqzCzl0/MNlxnAzWwVKT/b5D852DfNWFlc+A8ODrHMOmsiXTNdBYJkfzWuuLYz4GIB9WHxvBm/l/Wq157C6sVAzwullE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326860; c=relaxed/simple;
	bh=XhCdpG2HrQ31ykf6c185JwVDhbYmMEQ+5gUidBcDLS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p366HMcvvk4pBGg3Q++AkwJ+ozAq++bYuR3nolBW3kEdZC8wygTwKLU3w1rAFCX4QwphaAewEIfsbuntA/0grx/7mwjWSTBVdn0U0Lub6+Geeeox1O8hbgEup8e7iS/I6xBU7vpZKnEkLsJhxxwO7gfI/ic1S0MgnddwO5ScKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iuuUuge/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iuuUuge/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788326849; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qwdv+UbQCGldirDEB3P2J/UCKAxWJ9JAmpEwFtpt4cI=;
	b=iuuUuge/qYxV2tdVYUC47rIamgkb+DawnRMuDZ2tHZg/lUnNpvodvtkFgbCsrVeZJpiIdMywQIaUUMHVh3ihon/KnlD39WCAWihD99qDZZEOM0NXk3EsIc6lYN/lkqtuU09UXNQMj22s2rhwt3RADrzRHiOpc2JBT+/0yArlmxI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XABT1vy_1788326848;
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XABT1vy_1788326848 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 13:27:29 +0800
Message-ID: <34fda62f-a2d0-4db8-9590-c8dc834674b8@linux.alibaba.com>
Date: Wed, 2 Sep 2026 13:27:27 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/damon/ops-common: use a page-aligned address in
 damon_ptep_mkold()
To: Nathan Gao <zcgao@amazon.com>, sj@kernel.org, akpm@linux-foundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 david@kernel.org, ryan.roberts@arm.com
References: <20260902031655.84721-1-zcgao@amazon.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260902031655.84721-1-zcgao@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 11:16 AM, Nathan Gao wrote:
> __damon_va_prepare_access_check() picks a random byte address within the
> region and stores it in r->sampling_addr. damon_va_mkold() passes it into
> a page table walk, which hands it to damon_ptep_mkold() as the address of
> the page to sample:
> 
>    damon_va_mkold(mm, r->sampling_addr)
>      damon_va_walk_page_range(mm, addr, addr + 1)
>        damon_mkold_pmd_entry()
>          damon_ptep_mkold(pte, vma, addr)
>            ptep_test_and_clear_young(vma, addr, pte)
>            mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> 
> For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> clearing of the young flag for large folios"), the contpte helper walked
> exactly CONT_PTES entries from the aligned-down page table pointer and
> used @addr only to pass down to each entry, so an unaligned value was
> harmless:
> 
>          ptep = contpte_align_down(ptep);
>          addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>          for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> 
> Now the range to walk is derived from @addr instead: end = addr +
> nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
> page of a contpte block, the sub-page offset puts end just past the
> block boundary, so the round-up lands a whole block further and the
> walk clears PTE_AF in CONT_PTES entries beyond the sampled block. For
> the last block in a page table page, those entries are past the end of
> that page, so the walk writes into the page that follows.
> 
> Triggered by the full 7.1/7.2 kernel selftest suite on arm64 (EC2
> c/m6g.4xlarge). The kernel sometimes crashes at or shortly after the
> DAMON test.
> 
> What the overrun does depends on the page that happens to follow the
> page table, so there is no single signature. If that page is read-only,
> the write faults in the sampling path itself:
> 
>    Unable to handle kernel write to read-only memory at virtual address ffff0003c5d2d000
>      FSC = 0x0f: level 3 permission fault
>      CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>    CPU: 10 UID: 0 PID: 3487 Comm: kdamond.2
>    pc : contpte_test_and_clear_young_ptes+0x70/0xc0
>    lr : damon_ptep_mkold+0x1e8/0x1f8
>    Call trace:
>     contpte_test_and_clear_young_ptes+0x70/0xc0 (P)
>     damon_mkold_pmd_entry+0x150/0x170
>     walk_pmd_range+0x110/0x2b0
>     walk_pud_range+0x10c/0x208
>     walk_pgd_range+0x134/0x258
>     __walk_page_range+0x98/0x1b0
>     walk_page_range_vma_unsafe+0x90/0x148
>     walk_page_range_vma+0x28/0x40
>     damon_va_walk_page_range+0x114/0x2b8
>     damon_va_prepare_access_checks+0xec/0x1a8
>     kdamond_fn+0x534/0x770
>     kthread+0x128/0x138
>     ret_from_fork+0x10/0x20
> 
> Otherwise the page is writable, the PTE_AF clearing succeeds silently
> and the damage only surfaces later, in whatever happened to own the
> page, so the backtrace is unrelated to DAMON and differs between runs.
> 
> Pass a page-aligned address to the ptep_test_and_clear_young() call in
> damon_ptep_mkold(), which is the only place DAMON can reach
> contpte_test_and_clear_young_ptes() from. Nothing else sees the aligned
> address, and r->sampling_addr itself is left as is, so the sampling and
> region bookkeeping semantics are unchanged.
> 
> Fixes: 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for large folios")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Gao <zcgao@amazon.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
