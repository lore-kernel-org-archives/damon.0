Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7C175A81
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615152; cv=none; b=CbUNkwxVQWw+pgNu/sSs24a2sx7ci8JNdbCoE5Cz952wwK2kSGsxZetDl6wMzuAivz5QI2SiS8Kv/u6yE6DXnk24si3n04rWYNA/SQzASoWBomSWrYRot8LFv5rYjLJg3hfnwuNp/tmoqgeygKg8E0bUjAoVtuOzYGvzyiW49f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615152; c=relaxed/simple;
	bh=9n9REaGYgVz2c6Dy2efIB33ubXQjcxf4y40140W1siM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGw9a5k1WXaA5NFwoIgKuzlRZ9Pv8+gGxYhl6cdQZd5A5J3xf7D0ZVPVvWyifPfboY+/P4rRIRbA9dxju99rt+bCa4EH8gxWfhmccHn14quDxPnTw3uKnG7i5oh24FmInao/SA7ucN5H5EkMBGftiB5DR0GCs/rB9R1VwB3CUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdkJH+pl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdkJH+pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BF31F00AC4;
	Sat,  1 Aug 2026 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785615151;
	bh=xBZAwdgI5oS4BCWABWbFDBrTYe5VIXZPnP3jRylXV+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdkJH+plNStqEqjWaXzTDtXH9PK1Yi7gJqxJcnlv61IBhzlNdeNvze12Q9XeMwKlD
	 dKIlBHbgxKn/MlXbxJt27Rb9qcZA8TRqRXgM+mCRwUnm0CQavBadUaW/13Q41myv8M
	 NiEvHju9gKbgvcSU+USBTvB/kooaKfnYRCJxIJaApulz2jTYuonFSMcFqoO1R+Xqs6
	 Qe1NX3Z1vAzNnpqfdvEluiknJqXRzfB+3lBnVQeiSgxlqff7NUyiRObRbcVsqp7nxb
	 ltcO23E+WiEFoVWBEvxI6KsiVAqkOmjpSgPqpKtCygvBpHyj9Ym/N4x0o95HiFmNFF
	 oivkJAJutaZbQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/9] mm/damon/vaddr: respect folio end for DAMOS_STAT
Date: Sat,  1 Aug 2026 13:12:22 -0700
Message-ID: <20260801201224.114332-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801185013.8E4481F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 18:50:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Direct dereference of PTE pointer `*pte` instead of using the local safely fetched `ptent`.
> 
> Pre-existing issues:
> - [High] Batched PTE advancement blindly skips interleaved folios and PTE-level Accessed/Young bits within a large folio's virtual footprint.
> - [High] The exact page iteration bug fixed in `damos_va_stat_pmd_entry()` is also present in `damos_va_migrate_pmd_entry()` but was missed by this patch.
> --
> 
> --- Patch [5]: [RFC PATCH 5/9] mm/damon/vaddr: respect folio end for DAMOS_STAT ---
> commit 20f53909d4e28dc2c1b2dd4ce52890349fc6c85d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: respect folio end for DAMOS_STAT
> 
> For applying DAMOS_STAT action to a region, DAMON virtual address space
> operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
> pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
> filters to folios of addresses of the region in the pmd.  It starts from
> the walking address and advances the address by the size of the folio of
> the address until it goes out of the pmd or the region.
> 
> Link: https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 0648400b2d65b..035cd509f6b58 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -831,6 +831,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  		return 0;
> >  
> >  	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> > +		unsigned long page_idx;
> > +
> >  		nr = 1;
> >  		ptent = ptep_get(pte);
> >  
> > @@ -844,7 +846,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  
> >  		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
> >  			*sz_filter_passed += folio_size(folio);
> > -		nr = folio_nr_pages(folio);
> > +		page_idx = folio_page_idx(folio, pte_page(*pte));
> 
> [Severity: Medium]
> Is it safe to directly dereference *pte here instead of using the local
> safely fetched ptent?
> 
> Reading a PTE directly on 32-bit architectures (like x86 PAE) can result in
> a torn read if the hardware concurrently updates the Accessed/Dirty bits,
> potentially leading to an incorrect PFN and subsequent wild pointer
> arithmetic.
> 
> The local snapshot ptent was already obtained via ptep_get(pte) and should
> likely be used here.

Good catch, I will fix this in the next version.

> 
> > +		nr = folio_nr_pages(folio) - page_idx;
> 
> [Severity: High]
> This is a pre-existing issue, but does this batched PTE advancement blindly
> skip interleaved folios and PTE-level Accessed/Young bits within a large
> folio's virtual footprint?
> 
> For PTE-mapped large folios, hardware tracks the Accessed bit independently
> per 4K PTE. By checking only the first PTE and blindly skipping the rest,
> DAMON ignores accesses to subsequent pages of the folio, potentially
> classifying hot memory as cold.
> 
> Furthermore, if userspace partially unmaps or interleaves different mappings,
> the blind pte += nr skips those unrelated folios completely without
> verifying they map the same folio.

Good points that can further improved.  But seems handling these will make it
too complicated, compared to the gain from the improvements.  I will keep this
as is unless others raise different opinions.

> 
> >  		s->last_applied = folio;
> >  	}
> >  	pte_unmap_unlock(start_pte, ptl);
> 
> While reviewing this patch, I noticed the exact page iteration bug fixed in
> damos_va_stat_pmd_entry() is also present in damos_va_migrate_pmd_entry()
> but was missed by this patch.
> 
> [Severity: High]
> This is a pre-existing issue, but does the DAMOS migrate action also advance
> the PTE pointer unconditionally by the full size of the large folio?
> 
> mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
> 	...
> 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> 		...
> 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> 				migration_lists);
> 		nr = folio_nr_pages(folio);
> 	}
> 	...
> }
> 
> If the scanning starts in the middle of a large folio, it will advance past
> the end of the large folio and skip unrelated folios that follow it, failing
> to migrate them.

Yes, a later patch in this series will fix it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=5


Thanks,
SJ
