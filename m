Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE27261A
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336005; cv=none; b=hEtO4ERt+7gSVbCnDYeLntHiwDuGPgz7zZx+ctaIr7wwBhKllja3h3sTagYWFT0enfsPlYEDad760q/doR5nYmLW2nxsYS5c8o0FkmUGMDaJok+V1zyyxO+CKtYvlL4ql0n/8OM1/iDXmMRwkG9OcavsTY6+PWuZwAL4VVsm5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336005; c=relaxed/simple;
	bh=9qSX8XcgH4dxn6SRopq6B0BZXW2Ic8pio06B5oVlARo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3lbiJVohL9xFC1Gi/GGXiFHo4OkheMs1rokT0OL/zFdJTWRTXkb9SXPzRYA+VC6X47+F9r21XvGd3c2zLi8uTtnIhufCwhUFSshmYKTgM0a2eJevBqJMcuIzH8lJ/pJaDntd1J0ALCQmiiZpsXPjod0MMYHg8CEAehdSrQI13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEsxvcWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEsxvcWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61081F000E9;
	Sat, 18 Jul 2026 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336003;
	bh=lN8FeIDPHfAJ7Tp6LeIf8nnEy3/WNZuNWNF1JacSikE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEsxvcWpZH/9qUZ2X3gglwcZPgpDWCI0rkDPym1zlmk07fvbH4Zxp9CfGYX/LfeNQ
	 IOnUAnbtfgJBnOyPgcwgcAPI+qqj4WzpLUJHNtjCrMU76jDgprE0oS8W3/62AziJdM
	 iY2Q7kN9yB21zb6nF3BXnwKoVSKXjrMCyDeubxer0RNzCb32Dzr+0IVPeVhUdppHf2
	 TIMITWPtDTYKfrFHdUT3XISCtiK4i+rMV/G2JiYhGjQTlO5TjDuJBZqNNO5lRVXSKU
	 6d8SuB/YsPsT/CjtHEkaMtscVl6YIRyBHGp8BY/TSPHl8YqeEuSYnBRNOBySY7BQfD
	 363pkpoEuw4tA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/7] mm/damon/core: initialize damos->last_applied
Date: Fri, 17 Jul 2026 17:53:15 -0700
Message-ID: <20260718005316.89585-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718003220.DEDC31F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 00:32:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Uninitialized memory use in DAMOS quota goals allocation (last_psi_total and nid).
> - [High] damos_quota_init() modifies the passed quota struct, unintentionally resetting runtime quota statistics of actively running schemes.
> --
> 
> --- Patch [1]: [PATCH 1/7] mm/damon/core: initialize damos->last_applied ---
> commit 316d27ac2ea17607b5c9df656020658fa1b425df
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: initialize damos->last_applied
> 
> This commit initializes the last_applied field of the damos scheme struct to
> NULL in damon_new_scheme(). This prevents an uninitialized value from causing
> a DAMON scheme to unexpectedly skip applying an action to a folio the very
> first time.
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
> 
> [Severity: High]
> This is a pre-existing issue, but does damos_quota_init() unintentionally reset 
> the runtime statistics of actively running schemes?
> 
> When updating a DAMON context via sysfs, damon_commit_ctx() calls 
> damon_new_test_ctx() which iterates over running schemes and calls 
> damon_new_scheme(), passing the active &src_scheme->quota pointer.
> 
> Inside damon_new_scheme(), it executes:
> scheme->quota = *(damos_quota_init(quota));
> 
> If damos_quota_init() directly modifies the passed pointer:
> 
> mm/damon/core.c:damos_quota_init() {
>     quota->esz = 0;
>     quota->total_charged_sz = 0;
>     quota->total_charged_ns = 0;
>     quota->charged_sz = 0;
>     ...
> }
> 
> It appears this silently clears the tracking variables of the actively running 
> scheme, potentially breaking the ability to track memory usage limits.

No.  The damon_new_scheme() is for a case the commit is adding new scheme to
the destination context.  There is no data to erase.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing initialization,
> I noticed a potential issue with quota goals. Are the metric-specific fields in
> damos_new_quota_goal() left uninitialized?
> 
> When allocating a new goal via sysfs or damon_commit_ctx():
> 
> mm/damon/core.c:damos_new_quota_goal() {
>     ...
>     goal = kmalloc_obj(*goal);
>     ...
> }
> 
> It seems fields like last_psi_total and nid are not zero-initialized.
> 
> Later, damos_commit_quota_goal_union() misses the switch case for 
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, leaving dst->nid uninitialized.
> 
> This can result in using garbage values when calculating current_value:
> 
> mm/damon/core.c:damos_set_quota_goal_current_value() {
>     ...
>     goal->current_value = damos_get_node_eligible_mem_bp(c, s, goal->nid);
>     ...
> }

This is no issue.  The caller should set the nid.  And core functions using the
nid validates it before really using it.

> 
> And for PSI goals:
> 
> mm/damon/core.c:damos_set_quota_goal_current_value() {
>     ...
>     goal->current_value = now_psi_total - goal->last_psi_total;
>     goal->last_psi_total = now_psi_total;
>     ...
> }
> 
> Could subtracting an uninitialized last_psi_total underflow and cause the 
> quota tuner to aggressively zero out the quota?

Good finding.  I will separately fix this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260718001442.87129-1-sj@kernel.org?part=1


Thanks,
SJ
