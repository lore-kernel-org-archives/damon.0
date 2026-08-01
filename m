Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D723ABBF
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785619837; cv=none; b=I/c8xW7djwbduBBuRedNXI79FwKkYZmTz4jkv7oA4ucUJYhdYzMGwzgvPCa4P4plVjyqbufZfztqpk1VSgc5eU/AS/Y31+JbaMRMDmkOjY15SPmWFFytAkfavIIF1//3k7tLrP8RnoiukB1oPTNCo1euFPvmbYcYCCXlYMhctiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785619837; c=relaxed/simple;
	bh=iBYWiHYOuZdksxDTpzrv8R8jovYqfM+YMoQPVfxJQzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5Czyrz/QaJ1tbY+4/rbNanJlpU3ImE24G0gbSKJO/4i9MrACuntOtSjdv4/E5LtqqPNAErgyz3vWbigFDRL6hQnDIZi8R/IYVNq8Gy9bhV+xOC1eFSrc5zFN6mdBkUAdIS4bNnpP3y0+8Kv5yNjUIm6GqPnte0oDGWUitpEDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7ne5kjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7ne5kjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763BF1F00AC4;
	Sat,  1 Aug 2026 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785619835;
	bh=ABsX8koIpsNyxAfLrIpKLGe9iYI8YR2PduqcFaI+4Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I7ne5kjWHQied14eX5r57RRLfYdzp15R6eQ1YdIde4R+ezw8I2DDoQ+U0nIIgmqs8
	 EGx1V+KYKsrogSei89f5vD1TNHZWyjNzX79NZheXUG7DJ6zHjDgADk4Wx2pB+J4Ilh
	 6rsLZ3Vj3+69wmTYN89Z3VK80+hTAL9AFkFdEaG/TnG/J1XtcOBLkYUHGlAIJff++A
	 NsOc+aAGOocp7VdOlBv5TvZO4RPzKLkfReqQ0LufJgkunZQGs2lFB8wqhGzi0XNPkg
	 SNgE0rek2UMyF1SncAOm+KAewHDDoJ2nLjkDzDLm8QGIDngTwR2oL3ujxugcbdq5JT
	 AGXQDpZEC0PyA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] samples/damon/mtier: error out for zero quota goal target values
Date: Sat,  1 Aug 2026 14:30:26 -0700
Message-ID: <20260801213028.5127-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801212550.C07BB1F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 21:25:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch addresses a division by zero in the mtier sample module but leaves the core vulnerability unpatched. In `mm/damon/lru_sort.c`, setting the `active_mem_bp` module parameter to 10002 results in a `target_value` of 0, triggering the same division by zero Oops in the core framework.
> - [High] `damos_new_quota_goal()` allocates `damos_quota_goal` using `kmalloc_obj()`, leaving `last_psi_total` uninitialized. This causes wildcard auto-tuning behavior for PSI-based quota goals on their first cycle.
> --
> 
> --- Patch [1]: [RFC PATCH] samples/damon/mtier: error out for zero quota goal target values ---
> commit 1b5b3916c23bf9b477a9c0308b9b7d82d8503f36
> Author: SJ Park <sj@kernel.org>
> 
> samples/damon/mtier: error out for zero quota goal target values
> 
> This commit modifies the DAMON mtier sample to return an error when started
> with a zero value for node0_mem_used_bp or node0_mem_free_bp. This prevents a
> division by zero Oops in damos_quota_score() when target_value is zero.
> 
> Link: https://lore.kernel.org/20260801202657.117135-1-sj@kernel.org
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index ac9c24b92ead8..d1123ebbfab90 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -156,6 +156,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  	if (!scheme)
> >  		goto free_out;
> >  	damon_set_schemes(ctx, &scheme, 1);
> > +	/* zero target value causes division by zero in damos_quota_store() */
> > +	if (!node0_mem_used_bp || !node0_mem_free_bp)
> > +		goto free_out;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this fix leave the core
> vulnerability unpatched?
> 
> Since the underlying issue is in damos_quota_score() when target_value is 0:
> 
> mm/damon/core.c:damos_quota_score() {
>     ...
>     mult_frac(goal->current_value, 10000, goal->target_value)
>     ...
> }
> 
> It appears other modules can still trigger this Oops.  For example, if a user
> writes 10002 to the active_mem_bp parameter in the damon_lru_sort module, the
> cold scheme quota goal calculation will result in a zero target value:
> 
> mm/damon/lru_sort.c:damon_lru_sort_add_quota_goals() {
>     ...
>     goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
>                                 10000 - active_mem_bp + 2);
>     ...
> }
> 
> Should the zero check be handled centrally in damos_new_quota_goal() or
> damos_quota_score() to prevent similar crashes from other modules?

Good catch.  Eventually I will fix this in core.  But let's make
easy-to-backport hotfixes for stable kernels at the moment.  I will add a fix
for lru_sort.

> 
> >  	quota_goal = damos_new_quota_goal(
> >  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
> >  			DAMOS_QUOTA_NODE_MEM_FREE_BP,
> >  			promote ? node0_mem_used_bp : node0_mem_free_bp);
> 
> [Severity: High]
> This is a pre-existing issue, but does damos_new_quota_goal() leave fields
> uninitialized?
> 
> Looking at damos_new_quota_goal(), it allocates the struct using kmalloc_obj()
> without zeroing the memory:
> 
> mm/damon/core.c:damos_new_quota_goal() {
>     ...
>     goal = kmalloc_obj(*goal);
>     if (!goal)
>         return NULL;
>     goal->metric = metric;
>     goal->target_value = target_value;
>     INIT_LIST_HEAD(&goal->list);
>     return goal;
> }
> 
> This leaves union fields like last_psi_total uninitialized.  When a PSI-based
> quota goal is evaluated for the first time, this uninitialized value is used
> in the feedback loop calculation:
> 
> mm/damon/core.c:damos_set_quota_goal_current_value() {
>     ...
>     goal->current_value = now_psi_total - goal->last_psi_total;
>     ...
> }
> 
> Could this uninitialized memory usage corrupt the auto-tuning feedback loop?

A fix [1] of the bug is under review.

[1] https://lore.kernel.org/20260801173554.94710-3-sj@kernel.org

> 
> >  	if (!quota_goal)
> >  		goto free_out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801211315.2456-1-sj@kernel.org?part=1


Thanks,
SJ
