Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F65269B1C
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691831; cv=none; b=XvpaRarKutAAN0PToOML4K3GMDoy7FUE9GlwPsAvxrkeFJYIPbmrHvYYfu092l8sIOrcopDz2FfovLKJw9FoDnT+JaRSFZJB/5l5nn1Sh5JUbdFy3QkBnfOW9ZZjTcHpRAywiEo+sKzGoKFugyrZ6aJkcN6Xj+4KwThEYeFZh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691831; c=relaxed/simple;
	bh=3bBAcpkjJw8dHoLx7WneKNwn245i2usK9svggA420WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1zWxph+WJbJhnK8sZErGCIPwr0VliEBAJpKmB/anFN+Gx5SRxqid0MMoxFWeM/a0etHqI0sliHqhGuJC7RNpUYzC7S5C+pBcqb+SzDG6wuPnIC0EmfE6mE0jG5eDpRck7HFaphT7K3i5yEMo5jZmHo6r5zE+cp35LzoIm0T6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biEQRwzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biEQRwzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC4F1F000E9;
	Sun,  2 Aug 2026 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785691830;
	bh=PxVmMGIT1lm8rsq4juy+1lq2veF9qRul6pZzS/zReGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=biEQRwzUx1gokSwa1MHyOQaoVjqF8/06vbRCvrhE76iTrW0JfcYa1Ek7wHGo+5gwj
	 LJyfwcNjY38hR/p5np339it6G8lLA6kcJGcuxW94fu1oiTCZ7tk13c4dE8o0Iddq8U
	 Ep1NqpzbcsdebtyM6hfEIhmOIR2OgDrgovYkdr86I08Bddx1npJppV9Y0m62vxBfpf
	 zUG1NQjX9AJcWU7GcImZ4c1SDuqvmRiuN6M0cvkErtztSIbfcljyG6a3vzjGkcz4XW
	 5m+IQV6dhcQ3Bno+K2/yI52sBHsRyY2ssZmgLEj7K8K2SYg5hfqgkF9oBedj9bBLX4
	 AGR3PdRtj3eWA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/2] mm/damon/lru_sort: error out for >10000 active_mem_bp
Date: Sun,  2 Aug 2026 10:30:18 -0700
Message-ID: <20260802173021.762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802163652.4C5DF1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:36:51 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The newly added validation check for `active_mem_bp` can be bypassed via a Time-Of-Check to Time-Of-Use (TOCTOU) race condition, resulting in division by zero.
> 
> Pre-existing issues:
> - [High] The function `damos_get_in_active_mem_bp()` triggers a division by zero if the system tracks no active or inactive LRU pages.
> - [High] Writing to the `commit_inputs` module parameter while DAMON is initialized but not running indefinitely suspends the writing process.
> --
> 
> --- Patch [2]: [RFC PATCH v2 2/2] mm/damon/lru_sort: error out for >10000 active_mem_bp ---
> commit e683bbcbac1ca0611d9909a3bb95074271d3aa04
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/lru_sort: error out for >10000 active_mem_bp
> 
> damos_quota_score() can trigger division by zero if the target value is
> zero.  DAMON_LRU_SORT lets users set the target value for the hot memory
> scheme via active_mem_bp parameter.  It avoids setting it as the target
> value if the parameter value is zero.  However, it also sets the cold
> memory scheme with a target value that is calculated as '10000 -
> active_mem_bp + 2'.  Hence, if a user sets active_mem_bp 10002, the cold
> memory scheme's quota goal target value can be zero.  As a result,
> division by zero can be triggered.  Fix by returning an error when the
> user tries to start DAMON with >10000 active_mem_bp parameter value.
> 
> Link: https://lore.kernel.org/20260801213028.5127-1-sj@kernel.org
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 7e077084cb03a..3920d5042f109 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -233,6 +233,8 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
> >  
> >  	if (!active_mem_bp)
> >  		return 0;
> > +	if (10000 < active_mem_bp)
> > +		return -EINVAL;
> >  	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
> 
> [Severity: High]
> Since active_mem_bp is a global module parameter, can its value change between
> the bounds check and the call to damos_new_quota_goal()?
> 
> If a concurrent write updates active_mem_bp to 10002 immediately after the
> check completes, the cold memory scheme's quota goal target value could still
> end up being zero, resulting in the division by zero this patch aims to
> prevent.
> 
> Would caching the value locally with READ_ONCE() avoid this race?

Such race cannot happen to my understanding, thanks to the param_lock.

> 
> >  	if (!goal)
> >  		return -ENOMEM;
> 
> While reviewing this code, I also noticed a couple of pre-existing issues.
> 
> This isn't a bug introduced by this patch, but in mm/damon/core.c:
> 
> mm/damon/core.c:damos_get_in_active_mem_bp() {
>     ...
> 	active = global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_ANON) +
> 		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
> 	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
> 		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> 	total = active + inactive;
> 	if (active_ratio)
> 		return mult_frac(active, 10000, total);
> 	return mult_frac(inactive, 10000, total);
> }
> 
> [Severity: High]
> Can mult_frac() trigger a division by zero if total is 0?
> 
> If the system tracks no active or inactive LRU pages, or if per-CPU counter
> drifts clamp the global state to 0, total will evaluate to 0 and be used as
> the denominator.

Known issue.  I'm working on it.

> 
> 
> This is also a pre-existing issue, but in mm/damon/lru_sort.c:
> 
> mm/damon/lru_sort.c:damon_lru_sort_commit_inputs_store() {
>     ...
> 	/*
> 	 * Skip damon_call() if ctx is not initialized to avoid
> 	 * NULL pointer dereference.
> 	 */
> 	if (!ctx)
> 		return -EINVAL;
> 
> 	err = damon_call(ctx, &control);
>     ...
> }
> 
> [Severity: High]
> Does damon_call() require the kdamond thread to be actively running?
> 
> If the module is initialized but DAMON has not been enabled, it appears
> damon_call() will queue the request and wait indefinitely on a completion
> that will never be signaled by the stopped thread, causing the writing
> process to hang in an uninterruptible sleep state.
> 
> Could we check damon_is_running(ctx) before calling damon_call()?

Nice finding.  I will separately work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162050.89477-1-sj@kernel.org?part=2


Thanks,
SJ
