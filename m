Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC5372B3D
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101263; cv=none; b=ThPcxAT+OZ5cqP95sEUKSP3jTHfEMBCtUt4rNtUQ1ZkvE77XSUNdnkoDIlvqvPtOn48N5On6W77kuYkE7o2Jt8DSsG8eLlDij/7FvGvVp5uClWHjFPwbKTQWqYlXpNV78AMb5sp4t5gIAg4EVYyvXcCmwyJTuKCAKkNZAjtdwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101263; c=relaxed/simple;
	bh=k0pBD0qwbUHvsi+BlSOrmkpA009atZMaOmnMvPgSE0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaOCdWqUUy6SIs/EGv/0xvx4TMLa4NRXlQmyD6GuGtvY/h2CAB93mnAI+6xv92PjUJJbQescxJT2egXWr/Gc4Y1vLOOqvm1Y7lEGheLSj4xqxG/0IUj+Yw6CpE2Nt/rCFlZ1vp3nE9zib11kw68gadg0zXGyclWrtNBPYjWpvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTIq0g9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTIq0g9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B3A1F000E9;
	Sun, 26 Jul 2026 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101261;
	bh=zgEAYE47NR2/3qsePINq5l7x9fWNNCDuKBhhNZ7O8hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XTIq0g9zzksWqhOQt+q/L8vUQyiBEF7UeEoOiA3m/cbYIq1X1n7b6x26fz6pDilAU
	 0CFZ3H11YKAtzeiS38UF96hcIJSBvVRwxiazOp2Q14gh/XiIfA1NNMhNIUJmzUU7hk
	 WmkjCBNC5Kf2x1MTS4rwKn9tfYg4bjO/zAzamSZ6T52knSc3rfGJyO0wklam8jvz4/
	 hgIwaA0PUSG6yHtEbJljYuDGUS55LwTtcNKVwazLw+vWEKAzaXkud6OZkmCXvOJ34C
	 eua+H6bwh/jc57OqHa/V1BeD1cIMOdx47zo/NBXh1OqkRBJ8UulNofOh4YCpc2XkzF
	 UoWPkUe+OseyA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}
Date: Sun, 26 Jul 2026 14:27:33 -0700
Message-ID: <20260726212734.4224-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726211048.8B8EA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 21:10:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Early return in damon_migrate_pages() leaves isolated folios on the caller's list, causing memory leaks, stat inflation, and stack UAF.
> --
> 
> --- Patch [1]: [RFC PATCH] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD} ---
> commit 1efec5dea2b48b50043eba6bdae1821a99318049
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}
> 
> Callers of migrate_pages() should adjust NR_MIGRATED_{ANON,FILE} for
> isolations and putback of the folios. This patch fixes DAMOS_MIGRATE_{HOT,COLD}
> which mistakenly missed the stat adjustment, potentially confusing compaction
> and reclaim.
> 
> Link: https://github.com/damonitor/damo
> Link: https://lore.kernel.org/20260726164356.87940-1-sj@kernel.org
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index e59f77eca83b2..9809fa12b09a8 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> 
> [ ... ]
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5a6a78054784a..5c6c3a597fd0b 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -346,6 +346,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
> >  
> >  		if (!folio_isolate_lru(folio))
> >  			goto put_folio;
> > +		node_stat_add_folio(folio, NR_ISOLATED_ANON +
> > +				folio_is_file_lru(folio));
> >  		list_add(&folio->lru, &folio_list);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but if s->target_nid is invalid
> (e.g., if it defaults to NUMA_NO_NODE), damon_migrate_pages() returns early
> without draining the folio list:
> 
> mm/damon/ops-common.c:damon_migrate_pages() {
> 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> 			!node_state(target_nid, N_MEMORY))
> 		return nr_migrated;
>     ...
> }
> 
> Since folio_list is a stack variable here in damon_pa_migrate() and is passed
> to damon_migrate_pages() later in this function, wouldn't this early return
> permanently leak the isolated folios and cause a use-after-free when the stack
> variable goes out of scope? 
> 
> Furthermore, with this patch applied, doesn't this error path also permanently
> inflate the newly added NR_ISOLATED stats because the cleanup loop in
> damon_migrate_folio_list() is never reached?
> 
> A similar issue appears to exist in mm/damon/vaddr.c:damos_va_migrate(),
> where priv.migration_lists is freed without checking if any folios were left
> behind by an early return.

Good finding, but this is a known issue.  liyouhong is working [1] on this
issue.  This patch will also further updated to decrement the stat value on the
new putback logic.

[1] https://lore.kernel.org/20260726014815.1280757-1-dayou5941@163.com

> 
> >  put_folio:
> >  		addr += folio_size(folio);
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726205548.2287-1-sj@kernel.org?part=1


Thanks,
SJ
