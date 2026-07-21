Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36A38E5DC
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643545; cv=none; b=Y/eSKmJuq/fOGgnZdWNgueUJOnE18RcsX03yGvsadDa3daZYVsIApiHnoe0Km5Vz6vWEK5nZYb+RICJlPhvl1JPauXBVPtfhBYwft0adANNJ/rw91aKS3VLQqW7w6HuzzV23KfQE6iV72onOCGcd/Ls4ZIliatE1DWLkBtdgzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643545; c=relaxed/simple;
	bh=4rz0ESYTmTj8GpzgAaSv0C/4UYN+Epcg4w4mB7Y50Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA5KhjJ31AIvFAmn63hwoxtNewmgG9R/jH+YuIuCWuq3FHnPnNvXQM7UkRW90ecBOFatHFykncT0R45YBFTOp5pNCeuVvMyzpKFMD1f0+2Auwvt24aWeyy6r1g+wwN7xA/L3R30+Bv2XgNMcZG/OL+NrI2OkphTnwDV2Z0irG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzCi1/SK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzCi1/SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68231F00A3A;
	Tue, 21 Jul 2026 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643543;
	bh=qstRcO/LnbWrxdN3koq7G0RWMhU866hHEhlkE1FkYbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HzCi1/SKcDl6PjO7YP147L0uGc8i1CN+uZo6zJpgkPP7QEUlFjnjkbiZNX6r1BpRf
	 HGWU86jxLJIBoSL+Pn99wB189jHQTn09s4BthaN/oqXXg4g3qEiknv12cuWzoDNnZ4
	 m4bdBmgBi0ZH/tWRW888bXnKlsaEYkTuDNgw5LLN7JTcSnrvlZjwObNh01w5G6YHRM
	 RtlULOvfI3IM+sgrxJtCGqD1rEs4GeGC6kXAT6hNFJskp294vruYWSlUsh/yiimVhz
	 dFVzqV4mHrp2Gqqeoo2rbEsCd6xrMkMZmTP5TkqB/A0OwVI4baSW/3fY0nQ012RZTl
	 vA2auOPPXPtwg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/ops-common: prevent migration fallback to non-target nodes
Date: Tue, 21 Jul 2026 07:18:59 -0700
Message-ID: <20260721141900.73606-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721140716.C39B01F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 14:07:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] alloc_migration_target() overrides non-blocking gfp flags for large folios, causing kdamond to stall in synchronous direct reclaim.
> --
> 
> --- Patch [1]: [PATCH v3] mm/damon/ops-common: prevent migration fallback to non-target nodes ---
> commit 18e8e5ad17abc759ddf7302875cde768864ba912
> Author: Jiahui Zhang <jiahuitry@outlook.com>
> 
> mm/damon/ops-common: prevent migration fallback to non-target nodes
> 
> This commit modifies DAMON's migration target allocation to use __GFP_THISNODE.
> This prevents the allocator from silently falling back to other nodes when the
> target node is full, which previously caused misleading migration statistics.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index d7d7f100389b0..e59f77eca83b2 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -312,7 +312,7 @@ static unsigned int __damon_migrate_folio_list(
> >  		 * instead of migrated.
> >  		 */
> >  		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> > -			__GFP_NOMEMALLOC | GFP_NOWAIT,
> > +			__GFP_NOMEMALLOC | GFP_NOWAIT | __GFP_THISNODE,
> 
> [Severity: High]
> This is a pre-existing issue, but does adding __GFP_THISNODE here cause kdamond
> to unexpectedly stall in synchronous direct reclaim when migrating large folios?
> 
> When migrate_pages() is called, it uses alloc_migration_target() in
> mm/migrate.c. For large folios, alloc_migration_target() unconditionally
> overrides the non-blocking GFP flags requested by DAMON:
> 
> mm/migrate.c:alloc_migration_target() {
> 	...
> 	if (folio_test_large(src)) {
> 		/*
> 		 * clear __GFP_RECLAIM to make the migration callback
> 		 * consistent with regular THP allocations.
> 		 */
> 		gfp_mask &= ~__GFP_RECLAIM;
> 		gfp_mask |= GFP_TRANSHUGE;
> 		order = folio_order(src);
> 	}
> 	...
> }
> 
> Because GFP_TRANSHUGE includes __GFP_DIRECT_RECLAIM, the allocation can block.
> Previously, without __GFP_THISNODE, the allocator could fall back to another
> node. By enforcing __GFP_THISNODE on a full target node, this forced direct
> reclaim will trigger, stalling the kdamond thread and preventing kswapd wakeups.
> 
> Could alloc_migration_target() be updated to respect the caller's intent to
> not block?

The new behavior looks fine for now.  DAMON-based memory tiering is usually for
proactive use, so no much memory pressure is expected.  We migth need to
revisit this later for making it more cleaner, though.  Maybe it should be more
similar to that of do_move_pages_to_node().


Thanks,
SJ

[...]
