Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31E1D5CC9
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308306; cv=none; b=ff/q/rqsL0ePQCrvVqM0eztp+FObW2f6Q6tvwJe+rb3hB5TcR0ndfNpdEIo1XnMTa1RUQQLyzLF1onN49wm/HwTVHMnAEjIMv8ZWVYAtqAqm2hzHmwhQyIU+RiyzhSE8zZ2HvdcEqftzAHJSafaXvWVeuKnaGEWmVXSYgA5pXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308306; c=relaxed/simple;
	bh=wefhyFLTLjZh0sgGkLL2Kpjg5ji4zDJf/wLQCrCKtPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2MHCe6suZvaQEKsKEwgzb8Wl6wM9K5mTSDRoL6RxEKU5TCFa1pkyJEgtr3CgohaoBOcdhVmQMqvpzjlP+JFcCwMuG8ikEDoQuDXxDARQBAjsTF3TOcaww2Jtea+gf4FAjl8VmZiyUm8Z6AFlG1bOPOoSP4kP5TdR2HbsktAsic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctvd0jd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctvd0jd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B379B1F000E9;
	Wed,  2 Sep 2026 00:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308304;
	bh=X7NdkrqJ1eE9lJJZvTZUijiDea16HXq6OW7+l1hbA6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ctvd0jd4OgFfugU6E+khFn13sR5kZSGkbD/ygi6cWBNeifiXlF1YtlcMaBi9ch9UE
	 /W0v0uBfhjPyjw6yFZU2gGzr4VmtEW7O68/RQbUBrmMXYtOtgiFWospzW3+KwvHDlw
	 9UuN8tGVpVwTdRy2pK/tO4+sReRBD4CnPDDihIcRMsCbMHnykhax5umj9MHd2HKFal
	 CNKDhxwlQmBeHlCXEqwG+phPVZPBY9YWzAdykJCVoyC0SV/juZb/Ic6wu9JE/fLP37
	 yi+kDkA7F+d/Kfu98wgYTcWbH/oUbVAdjKIB/0gidXoTzHJP8occ1rHWEXFxQlOg+V
	 343qC1vrSloKw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Nathan Gao" <zcgao@amazon.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
Date: Tue,  1 Sep 2026 17:18:16 -0700
Message-ID: <20260902001818.107537-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901202420.D8C781F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 20:24:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unaligned addresses passed to mmu_notifier_clear_young and set_huge_pte_at for PMD and HugeTLB pages cause out-of-bounds clearing of accessed bits and page table corruption.
> - [High] Incorrect advancement of PTE pointers for large folios in DAMON's vaddr operations skips unrelated PTEs.
> --
> 
> commit e20303b2de84c12df7877f523196d088cede0a4e
> Author: Nathan Gao <zcgao@amazon.com>
> 
>     mm/damon/ops-common: use a page-aligned address in damon_ptep_mkold()
>     
>     __damon_va_prepare_access_check() picks a random byte address within the
>     region and stores it in r->sampling_addr. damon_va_mkold() passes it into
>     a page table walk, which hands it to damon_ptep_mkold() as the address of
>     the page to sample.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 7a2e40bc7baed..3a5f5cdeb2017 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -46,6 +46,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
> >  	bool young = false;
> >  	unsigned long pfn;
> >  
> > +	/*
> > +	 * Arch implementation of ptep_test_and_clear_young() may require
> > +	 * aligned @addr
> > +	 */
> > +	addr = PAGE_ALIGN_DOWN(addr);
> > +
> >  	if (likely(pte_present(pteval)))
> >  		pfn = pte_pfn(pteval);
> >  	else
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while this fixes the
> unaligned address issue for damon_ptep_mkold(), the PMD and HugeTLB
> paths are identically vulnerable.
> 
> In mm/damon/ops-common.c:damon_pmdp_mkold(), the unaligned address is
> still passed directly to the MMU notifier:
> 
> 	if (likely(pmd_present(pmdval)))
> 		young |= pmdp_test_and_clear_young(vma, addr, pmd);
> 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE);
> 
> Does this cause the cleared range to spill over into the next PMD mapping?
> 
> Similarly, in mm/damon/vaddr.c:damon_hugetlb_mkold():
> 
> 	if (pte_young(entry)) {
> 		referenced = true;
> 		entry = pte_mkold(entry);
> 		set_huge_pte_at(mm, addr, pte, entry, psize);
> 	}
> 
> 	if (mmu_notifier_clear_young(mm, addr,
> 				     addr + huge_page_size(hstate_vma(vma))))
> 		referenced = true;
> 
> Can passing the unaligned address to architecture-specific page table
> modifiers like set_huge_pte_at() corrupt multi-entry contiguous blocks,
> and does the MMU notifier suffer from the same out-of-bounds clearing here?

I find no evidence about this for now.

> 
> [Severity: High]
> This is a pre-existing issue, but there appears to be a logic error with
> how large folios are handled during page table walks in DAMON.
> 
> In mm/damon/vaddr.c:damos_va_stat_pmd_entry() and
> damos_va_migrate_pmd_entry():
> 
> 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> 		nr = 1;
> 		ptent = ptep_get(pte);
> 		
> 		if (pte_none(ptent) || !pte_present(ptent))
> 			continue;
> 		
> 		folio = vm_normal_folio(walk->vma, addr, ptent);
> 		if (!folio)
> 			continue;
> 		
> 		...
> 		nr = folio_nr_pages(folio);
> 	}
> 
> If the folio is partially mapped, or if the loop starts in the middle
> of a large folio, wouldn't advancing by the entire folio size
> (folio_nr_pages) overshoot the mapping bounds and silently skip
> unrelated PTEs?

I'm separatively working [1] on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901201001.33271-1-zcgao@amazon.com?part=1

[1] https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org


Thanks,
SJ
