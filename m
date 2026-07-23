Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AD3264D6
	for <damon@lists.linux.dev>; Thu, 23 Jul 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814675; cv=none; b=C/aqCZdhC9DDURrjwOMbwy0+Ju2hMMp07gGW86YxYZS1OldqNDQaJXLwuPSWVvJ7fc6lP4MiCio+wMHcjvEq3RbimdxBWv8UG/PknvK4ksiCXNfJgb5nDGn7RWzxTimyLw1qaM7QQ7hnJc44PeRGjDNbi02YaDF/KbGERmNGCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814675; c=relaxed/simple;
	bh=oul2lr0dcPk7SL8sMTQsLtTx2yYdmlshBtp0+6KpqUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCleZPIp953ZBZyOFrJP5N0TIAHBADL1rvNLutzKTq3IBbTDWQ7LNlP7zo7VC78/Zv0BfXrxSx3E5oucaTXmaLB4x12T7L0jq8WvINJ5clG53iEDHUCv/lQPWKRb644HxjRxBYaJpDdKyEMNVF6NRueNnfrS+6pmIopGKzF4zMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIoZ4VP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIoZ4VP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADFD1F000E9;
	Thu, 23 Jul 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814673;
	bh=YiIc5BwJh3NOrvY00qOAI4WMVDc7bwVWp4LMDyn7Qk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIoZ4VP1/MM53rkgwz6jvmM415wGLnYN+zAkE+wqBE1jLxqL+OZQ5F40M6oSpD8EL
	 2XV+gYNLHrup9ML3GqvlFSZfIxwpSuEA83t5azQhG7lbDusXKZ4eYxcP3EmM+7csRf
	 83dZyVwJBDLED7VSLUvfOxPNKOmoTJY439bvgXfy5IqcSvnf3LSZulbhOM0ovDGHMU
	 F5F0/7ooMTFgPhSWC+5m/0CRECX/fMaPMuFrvo+eSYWpSVqDP4LIDQUdEjkRNSLGGO
	 xsYRzfuw9RPzYCxS0B3gzWTOTkxP101wAmKREZTlfT9hCeZ/3ch2PCSpa3Znon5z10
	 XaIfTFXKgMy3g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	dayou5941@163.com,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Thu, 23 Jul 2026 06:50:40 -0700
Message-ID: <20260723135042.87076-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723062427.D719C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 23 Jul 2026 06:24:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect Loop Advancement / Bounds Oversight (PFN advancement bug)
> - [High] Missing yield in unbounded list putback loop
> --
> 
> --- Patch [1]: [PATCH] mm/damon/ops-common: putback folios on invalid migrate nid ---
> commit b4aa488aeb8640931363ab9a919f2ae6536d57ba
> Author: liyouhong <liyouhong@kylinos.cn>
> mm/damon/ops-common: putback folios on invalid migrate nid
> 
> This commit extracts the LRU putback logic into a helper function and
> uses it to return folios to the LRU when damon_migrate_pages() is called
> with an invalid target_nid. This prevents folios from remaining isolated
> from the LRU permanently.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index e59f77eca83b2..1286fe54b0d9d 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -330,12 +330,22 @@ static unsigned int __damon_migrate_folio_list(
> >  	return nr_succeeded;
> >  }
> >  
> > +static void damon_putback_folio_list(struct list_head *folio_list)
> > +{
> > +	struct folio *folio;
> > +
> > +	while (!list_empty(folio_list)) {
> > +		folio = lru_to_folio(folio_list);
> > +		list_del(&folio->lru);
> > +		folio_putback_lru(folio);
> > +	}
> > +}
> 
> [Severity: High]
> This is a pre-existing issue, but can this tight loop cause CPU soft lockups?
> 
> If a DAMON scheme isolates a massive region that fails to migrate, or is
> given an invalid migration NID, the isolated folio list could scale to
> millions of folios. Because this loop takes the LRU lock for each folio
> without a yield point, could it monopolize the CPU and cause severe latency
> spikes? Should there be a cond_resched() in this loop?

Users could set the maximum size of regions with max_nr_regions parameter.  We
could revisit this if it turns out the knob is not really useful, from the real
world.

> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but do these unconditionally sized advancements
> elsewhere in the DAMON codebase risk skipping uninspected memory regions?
> 
> In mm/damon/paddr.c:damon_pa_pageout():
> 
>     addr += folio_size(folio);
> 
> And similarly in mm/damon/vaddr.c:damos_va_migrate_pmd_entry() and
> damos_va_stat_pmd_entry():
> 
>     nr = folio_nr_pages(folio);
> 
> When a DAMON region starts in the middle of a large folio (a tail page), or
> a PTE walk encounters a partially mapped large folio, advancing the pointer
> by the total folio size or total number of pages overshoots the bounds. Does
> this silently skip adjacent, unrelated PTEs and physical addresses?

Known issue.  I'm working on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260723061246.1878435-1-dayou5941@163.com?part=1


Thanks,
SJ
