Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585E328267
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324842; cv=none; b=f8zNf9naVVhU4Cifxgpsoff1pvbbD8+PfAhLnj3rlfbBvBgYbmzpY8NDcKwJef4Ols48J28cd7R0olO4kxpri6Ck5MW+WrS5lVUxiJYySL23Y9ECGuNd+Mmhu4mb1NnnigP5K66ZgDZ+VtzOo5xp+Gw3rU0SuCCCdupAItlVAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324842; c=relaxed/simple;
	bh=/mJ0b9T2dCA7VbVKR0TGQAgA5Y3eV53FCCUcQnFau4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfsGDokKke3mtmuNWMYOeExXYKbJhqXZS2y7SXLOsGKfcLylqNMzeXNGDAxdwDz4wz0mkdKeUsGbG93M6BHIfITWCOI3tPvvwmhtX0fWAdT89LlXWw4dgDSLFeHXmbHUfU9747rvZj+ZZr3zL/LL2yXS3gW0S229cyT+huRGqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcwmN6MM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcwmN6MM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59B51F000E9;
	Wed,  2 Sep 2026 04:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788324841;
	bh=V3Pjb+IWgX6Nyh3fovxLhQRxGUPG9awuRYiqeoqmj/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lcwmN6MMFARMa1dFxtYIXwLrxCikvXlzkoFRmvIpULP6I8+ZTqIe2L73Sq03O8MLq
	 k5vVmcUImwyT8gu5fWALHuZWZ/nzbFL2buP+DyRFNI94VGMyEacxd6SqeLWwb5xNZ4
	 SoWlbf8bnxLIl03sCp7X76NT0xZVWaZw8RBtKLaQvDuUuMKrKUEvzK/nUKKB1b4IMW
	 MItvYdc2zgTEs1nHOd3vR/QNRWKvdDfx5Lv3R5SGm5QzeRhrwPLtV+BwuFgEvTK4Uf
	 adzxd3Yo0mxG5O8yCSQrawttODJsFgI+N4VQc79PhgQ4odmWjSb9yRy3wgRnZrMLxS
	 kNQKYpalr/1Rw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Krishna Iyer" <kiyer@crusoe.ai>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Tue,  1 Sep 2026 21:53:52 -0700
Message-ID: <20260902045354.69587-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902031216.D2B281F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 03:12:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Non-atomic clearing of huge PTE young bit silently overwrites hardware dirty bit
> --
> 
> commit 04cc6d81cf1593c6fb092b306da28db5569a3f11
> Author: Krishna Iyer <kiyer@crusoe.ai>
> 
> mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
> 
> This commit adds hugetlb branches to the damon_folio_mkold_one and
> damon_folio_young_one rmap walkers. It reuses damon_hugetlb_mkold to properly
> age huge PTEs and introduces a new helper damon_hugetlb_young for checking
> their accessed state.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index f5fe92b825bbc..373b25db59505 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -193,10 +193,15 @@ static bool damon_folio_mkold_one(struct folio *folio,
> >  
> >  	while (page_vma_mapped_walk(&pvmw)) {
> >  		addr = pvmw.address;
> > -		if (pvmw.pte)
> > -			damon_ptep_mkold(pvmw.pte, vma, addr);
> > -		else
> > +		if (pvmw.pte) {
> > +			if (folio_test_hugetlb(folio))
> > +				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
> > +						addr);
> 
> [Severity: High]
> This is a pre-existing issue, but does expanding the use of
> damon_hugetlb_mkold here expose us to hardware dirty bit overwrites?
> 
> Looking at damon_hugetlb_mkold in mm/damon/ops-common.c, it performs a
> non-atomic read-modify-write on the huge PTE:
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
> If the hardware sets the dirty bit after software reads the PTE via
> huge_ptep_get, but before it writes it back via set_huge_pte_at, the kernel
> will silently discard the newly dirtied state. This can lead to data
> corruption as the page might be dropped assuming it is clean.
> 
> Since DAMON monitoring can be configured to monitor hugetlb VMAs, triggering
> this path, can this non-atomic clearing be safely avoided or addressed here?

Pre-existing issue that not a blocker of this patch.
I'm working on the issue.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902025700.17975-1-kiyer@crusoe.ai?part=2


Thanks,
SJ
