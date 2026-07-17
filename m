Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D1194C96
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784250787; cv=none; b=Hx4y//YrvXJ5TxIfgkHiwhVoVJKE41O6OUfYbXBw4HaSb2kKaoKo1rHxBnq2W/KKST0cMTivmOXLG8xDi0O5i8Q2M5baXtwvdzOvzyAeopeldGyVLlVnXi/WZo7g2ciloyGleTopwu1GWq8rM4yQN0xwcioB5lPbzBShUFLIl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784250787; c=relaxed/simple;
	bh=Bw5Wo9CGltNN+R7087ojg+L3p7irukplK7eIZlx5zAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD/BYWg6GM2PEjJHhMJBCaEqhhOEWe1vCin1P2pMOleLFPLa2cqCpf1rD0LAZncXmdsfxivOROk586oqRyMLqap3r0YXdiqWCp4Eo+43oi8xqF2mkMF75qxYWrJW+xFGHrq369NERx2D4otiCCbWSa4OhqGcZ1abgd0+jsbsO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgsz+r+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgsz+r+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36061F000E9;
	Fri, 17 Jul 2026 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784250785;
	bh=iEkhKkRZPjhqpnud25FnOI7Od6DZPKY9RfpFDcuZvUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mgsz+r+nReAEYN9PFSq2NTZwC/lYg9x6itryJyLAJUTJAjetGXqHoUEf1OYFJNDbW
	 3A414YrbnzHPHhbd/pPHhs2y4BIyfp4aMkWiZ9BaKXvSFq/VPsm0/rCRrk2rbIUi94
	 amxifNWda50fPaXAidgM6wJsXfxg5yskjLOGcT4hJUujp4JJAfXwFvwxOHsG8T5YLy
	 wGzhaZciMrqiBT1ViinvIhdiQHVATPzRxZtIVkqWZLiN/mjJvHtjL7SXJY1iVN7mfY
	 5sC/jxilSAMMMQCpn3I5+OVJTKJuL2br7JddadrSCpGGH0sALD6/a89cFH4a1FuVl6
	 fKRzaI+hq7cYQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/7] mm/damon/core: initialize damos->last_applied
Date: Thu, 16 Jul 2026 18:12:56 -0700
Message-ID: <20260717011257.120550-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717005220.7CB001F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 00:52:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect PTE advancement for large folios in vaddr stat scanning and migration.
> - [High] Commit of DAMON parameters corrupts the active scheme's quota state by zeroing dynamic fields in-place.
> - [High] Failure in `damos_commit_dests` leaves the active scheme in an inconsistent state, leading to a NULL pointer dereference.
> --
> 
> --- Patch [1]: [PATCH 1/7] mm/damon/core: initialize damos->last_applied ---
> commit 90344a381581ba5ad7a7c87826b18bf948659516
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: initialize damos->last_applied
> 
> This commit fixes an issue where the damos->last_applied field was being used
> without initialization, leading to DAMON unexpectedly skipping the application
> of DAMOS actions for a folio the first time per scheme. It addresses this by
> initializing the field in damon_new_scheme().
> 
> Link: https://lore.kernel.org/20260714055436.120034-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 603b102ff80f9..20d267c615faf 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -705,6 +705,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
> >  	INIT_LIST_HEAD(&scheme->ops_filters);
> >  	scheme->stat = (struct damos_stat){};
> >  	scheme->max_nr_snapshots = 0;
> > +	scheme->last_applied = NULL;
> >  	INIT_LIST_HEAD(&scheme->list);
> >  
> >  	scheme->quota = *(damos_quota_init(quota));
>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this in-place zeroing
> corrupt the active scheme's quota state?
> 
> Looking at damon_new_scheme(), it passes the provided quota pointer to
> damos_quota_init(), which zeros out dynamic fields directly:
> 
> mm/damon/core.c:damos_quota_init() {
>     ...
>     quota->esz = 0;
>     quota->total_charged_sz = 0;
>     ...
> }
> 
> When damon_commit_ctx() applies new parameters to an active context, it copies
> schemes by calling damon_new_scheme() with a pointer to the running context's
> scheme quota.
> 
> Could this wipe out the current quota charge window progress and reset the
> goal tuner's feedback loop (esz_bp) on every parameter commit, causing
> inconsistent tuning pressure?

No.  damon_new_scheme() is called only for new scheme addition.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but can the failure path in damos_commit_dests()
> lead to a NULL pointer dereference?
> 
> In mm/damon/core.c:damos_commit_dests(), if memory allocation fails for
> dst->node_id_arr or dst->weight_arr, the function returns -ENOMEM:
> 
> mm/damon/core.c:damos_commit_dests() {
>     ...
>     dst->node_id_arr = kmalloc_array(src->nr_dests,
>         sizeof(*dst->node_id_arr), GFP_KERNEL);
>     if (!dst->node_id_arr) {
>         dst->weight_arr = NULL;
>         return -ENOMEM;
>     }
>     ...
> }
> 
> However, dst->nr_dests is updated later. If the allocation fails while
> updating an active context during __damon_commit_ctx(), could the active
> scheme be left with weight_arr == NULL but a non-zero nr_dests?
> 
> If so, would this cause a kernel panic when kdamond resumes and calls
> damos_va_migrate_dests_add(), which iterates up to dests->nr_dests and
> unconditionally dereferences dests->weight_arr[i]?

No.  If damon_commit_ctx() fails, kdamond stops due to 'maybe_corrupted' field.
There is no way to resume it.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but does the PTE iteration in
> damos_va_stat_pmd_entry() and damos_va_migrate_pmd_entry() overshoot large
> folios?
> 
> In both functions, when a valid folio is found, the loop increment is set to
> the total number of pages in the folio:
> 
> mm/damon/vaddr.c:damos_va_stat_pmd_entry() {
>     ...
>     if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
>         *sz_filter_passed += folio_size(folio);
>     nr = folio_nr_pages(folio);
>     s->last_applied = folio;
>     ...
> }
> 
> If the current PTE maps a tail page of a large folio (for example, if the VMA
> starts in the middle of a large folio), wouldn't advancing pte += nr and
> addr += nr * PAGE_SIZE overshoot the end of the large folio?
> 
> Could this cause DAMON to skip subsequent PTEs in the mapped page table that
> might belong to entirely different folios, missing stats and migration actions
> for them?

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717003022.119437-1-sj@kernel.org?part=1


Thanks,
SJ
