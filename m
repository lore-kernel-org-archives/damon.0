Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1C3BB133
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788106537; cv=none; b=kBKCLqflrO389DHJZY1sQmVTQ8C+W7Lulekw0N0cvNwS1p2Al3EJfcBBA5hiSz6xaOsMQ999KJDsXDAtj5eA5Xzml8iuIWXd+LF7RqcG0gTzCHLmNoJVwpqDbLu3slPeONnBZBBtw9d1vFIZW13f6yCEktbdMgDSWP+0KKfs9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788106537; c=relaxed/simple;
	bh=kZkWUqbWtJEKt76nbH3NP475OXlr1ks0DO2YDL5Y6ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEuwRaUNlv9aHH+GLZTWDhZS9m9YFzXItaYqi4aUw15iPNLVlJNpWh8a874dPbSDQ6b9cp18XRS6iDIbe/J7M8ArYADRokw2Xd8Ld+BMcw7HJO3oZsEkouuUodh6vhr9P4I8QFZ0DS7jGt+Q6Yz00CQ8Hv0wAqYufyeJPu33Glg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsSBuVGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsSBuVGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307841F000E9;
	Sun, 30 Aug 2026 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788106535;
	bh=D5AGAO0fBcsYlbM5gug24TAj5XHHSBQIzfb2oA/JbLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsSBuVGgPptmddvvFRp++oDCCc5TjG/Fv8sVnJ4ytmwlAQUu5+5q7NOo2jgt2QUtf
	 qHgAVVc08Nq/Ls9VwjtINpy6Unlnnsn7vTNoxp4pym3yePpiOnIjnUYaQA66toM3yL
	 Y5KdtVnnMlawbDXl93YGPG2zxBgtk41i+rViHP5vAEoQAhp3YDpBZjGdk/E40C3H9m
	 NB+oiNa+gX3xDzi23MMHU8T9plFFCYNlEX1TK1P+/FV7eCdiz724StDzLUZtMTSNNO
	 2VEeafoCV33lHyibiNs2lxlUkCh+sOfSAqZiOP310i2TsGonZEdxvCgO5K5Vy+g0CU
	 0fV5YXxBkybxQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH 3/6] mm/damon/paddr: support hugetlb folios in access monitoring
Date: Sun, 30 Aug 2026 09:15:26 -0700
Message-ID: <20260830161528.99344-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830052936.44F301F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 05:29:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Non-atomic huge PTE modification in damon_hugetlb_mkold() causes a TOCTOU race with hardware page table walkers, silently dropping dirty bits.
> - [High] Incorrect physical address advancement when starting from a tail page of a large folio.
> --
> 
> commit fa7cc985c2891991281afce141ed40264af354fe
> Author: Krishna Iyer <kiyer@crusoe.ai>
> 
>     mm/damon/paddr: support hugetlb folios in access monitoring
>     
>     DAMON's physical address space monitoring is blind to hugetlb-backed
>     memory. Every access check starts at damon_get_folio(), which rejects
>     folios that are not on the LRU lists. This commit adds
>     damon_get_folio_incl_hugetlb() to additionally accept hugetlb folios.
> 
> [ ... ]
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 62004206ca310..ece101d346844 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> 
> [ ... ]
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this non-atomic huge PTE modification
> drop hardware dirty bits?
> 
> In damon_hugetlb_mkold() in mm/damon/ops-common.c:
> 
> 	pte_t entry = huge_ptep_get(mm, addr, pte);
> 	struct folio *folio = pfn_folio(pte_pfn(entry));
> 	unsigned long psize = huge_page_size(hstate_vma(vma));
> 
> 	folio_get(folio);
> 
> 	if (pte_young(entry)) {
> 		referenced = true;
> 		entry = pte_mkold(entry);
> 		set_huge_pte_at(mm, addr, pte, entry, psize);
> 	}
> 
> If a hardware page table walker sets the dirty bit concurrently between the
> read and the write, does the non-atomic writeback via set_huge_pte_at()
> silently overwrite and clear the dirty bit?

I'm planning to work on fixing this.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this physical address
> advancement skip memory pages?
> 
> In damon_pa_pageout() in mm/damon/paddr.c:
> 
> 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
> 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
> 		folio = damon_get_folio(PHYS_PFN(addr));
> ...
> put_folio:
> 		addr += folio_size(folio);
> 		folio_put(folio);
> 	}
> 
> If the region's start address is not naturally aligned to the folio boundary
> and lands on a tail page of a large folio, does adding the full folio size
> overshoot the start of the next folio?
> 
> The same pattern appears in damon_pa_stat() where it also over-accounts the
> filter size:
> 
> 		if (damos_pa_filter_out(s, folio))
> 			goto put_folio;
> 		else
> 			*sz_filter_passed += folio_size(folio) / addr_unit;
> ...
> put_folio:
> 		addr += folio_size(folio);
> 		folio_put(folio);

Known issue.  Fix is cooking:
https://lore.kernel.org/20260802162631.90304-1-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260830051407.50008-1-kiyer@crusoe.ai?part=3


Thanks,
SJ
