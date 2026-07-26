Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE724908B8
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785084247; cv=none; b=Ynp1DuyXAIzo8bT97y7yeLf7kRhmTQPISEYXV5TWzAsvRnas3D6/aYGw9A5qhKB7aBp81i8FI1SblHQdNnciD7ebzEkeVsEsICi9yXB7PLLv97KWWTQYO3sba92G9Aw1OiODIBwAzGtR4/b3gbmg6g1Yln+Vf6iws6OhlFxV/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785084247; c=relaxed/simple;
	bh=OhZRTiVBQWAfAJzMVI6DYSoJwn90CfgSHUtrszZJdOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYS+NcxM1az6eFwVWffZyGJAITIF731FefrA7n7Z2T1JHhwW3xqe8pFpFfTNEbNhg0tkqI2UXJV1ZnyYmnzVw0Q/2IzUCD+y9Cml/TC/6Sq5zVlD6lZcXOw5fgYKw05VL61je2FLcoNzfGH8eYzNdEMVzG9FkEhDvzwUm6akUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoUrJZFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoUrJZFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E97A1F000E9;
	Sun, 26 Jul 2026 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785084246;
	bh=vo+Ci9PJ7l7dpr6gty+wAB7/Ww6APCiE/Gc5GBXdAbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoUrJZFDIgrJEuZ+DJP57DQmtsi9kZVbeKgpDn+z+534i+iWxA1gKNl6lJO3+zqKO
	 RbCwH2wBTYsO5R01zy+c3LTc1f/d+FGIPsnqtBwWM6NZhAVzLI2UbFVWTKsN0X9JrD
	 KgBCzwd47joJjgjShoCtNWfeSHAdrGnUuyw+0wnxxk0v/dgl2HkKTHPyJxPpBnRsxQ
	 szFLA7GsAE/YExwWjfAlKVEd/ZZ/eQJS3OyD0wBnVtmdKafHCb6hqC/Onf3r+Kpgqu
	 0bgYvd5UTHF9shlnocvUdllOCuRVsI+3gdFxk4GNpCu+H1gAJHxus5ZJ9woMoZ+c82
	 FMb0+ireWI1Jg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	dayou5941@163.com,
	damon@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Sun, 26 Jul 2026 09:43:54 -0700
Message-ID: <20260726164356.87940-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726020034.93D041F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 02:00:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Invalid address and PTE advancement after page-to-folio conversion for large folios in DAMON scanning loops.
> - [High] DAMON migration causes NR_ISOLATED_ANON and NR_ISOLATED_FILE counter underflow.
> --
> 
> --- Patch [1]: [PATCH v3] mm/damon/ops-common: putback folios on invalid migrate nid ---
> commit 1f243815b710aba6f1b966b6f98b83cb7c51edeb
> Author: liyouhong <liyouhong@kylinos.cn>
> 
> mm/damon/ops-common: putback folios on invalid migrate nid
> 
> damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> and then call damon_migrate_pages().  When target_nid is invalid (including
> the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
> without putting the folios back to the LRU.
> 
> Callers then discard the list head while those folios remain isolated with
> an extra reference taken by folio_isolate_lru().  The pages stay off the
> LRU for as long as the mapping exists (anon active+inactive counts drop
> while RSS does not), and the leftover references can pin the pages after
> the mapping is gone.
> 
> Put the folios back on the invalid-nid path so ignored migration requests
> still return them to the LRU.
> 
> Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Cursor:grok-4.5
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index e59f77eca83b2..0981a5e3af172 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> [ ... ]
> 
> While reviewing this migration fix, I noticed a couple of pre-existing issues
> in the DAMON migration code:
> 
> mm/damon/vaddr.c:damos_va_migrate_pmd_entry() {
> [ ... ]
> 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> 		nr = 1;
> 		ptent = ptep_get(pte);
> 
> 		if (pte_none(ptent) || !pte_present(ptent))
> 			continue;
> 		folio = vm_normal_folio(walk->vma, addr, ptent);
> 		if (!folio)
> 			continue;
> 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
> 			continue;
> 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
> 				migration_lists);
> 		nr = folio_nr_pages(folio);
> 	}
> [ ... ]
> }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this iteration overshoot
> the end of large folios?
> 
> If the current PTE corresponds to a tail page (meaning we are at an offset
> into the folio), adding the full folio_nr_pages() to both pte and addr seems
> like it will advance past the end of the folio, skipping subsequent, unrelated
> memory.
> 
> This same pattern appears in damos_va_stat_pmd_entry(), damon_pa_migrate(),
> and damon_pa_stat().

Known issue.  I'm working on it.

> 
> 
> mm/damon/vaddr.c:damos_va_migrate_dests_add() {
> [ ... ]
> isolate:
> 	if (!folio_isolate_lru(folio))
> 		return;
> 
> 	list_add(&folio->lru, &migration_lists[i]);
> }
> 
> [Severity: High]
> This is a pre-existing issue, but does this isolation miss incrementing the
> isolated VM stats?
> 
> Folios are isolated here and added to the migration list, but I don't see
> NR_ISOLATED_ANON or NR_ISOLATED_FILE being updated.
> 
> Later, when the core migrate_pages() code processes these folios via
> damon_migrate_pages():
> 
> mm/migrate.c:migrate_folio_done() {
> [ ... ]
> 	if (likely(!page_has_movable_ops(&src->page)) && reason != MR_DEMOTION)
> 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> 				    folio_is_file_lru(src), -folio_nr_pages(src));
> [ ... ]
> }
> 
> Will this decrement cause the node page state counters to underflow?
> 
> Since the counters weren't incremented originally during DAMON's isolation, it
> looks like a successful migration will drop the isolated stat and wrap it
> around. This could hang memory reclaim since too_many_isolated() might
> perpetually return true.
> 
> This also seems to apply to damon_pa_migrate().

Good catch.  Sounds correct.  No blocker for this patch.  I will work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726014815.1280757-1-dayou5941@163.com?part=1


Thanks,
SJ
