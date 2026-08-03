Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEF411FBB
	for <damon@lists.linux.dev>; Mon,  3 Aug 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766733; cv=none; b=Hc28kVhleABi6jblrqqr9KU3Br93jLa96LtgkvYrXL/GGMIFn4NqJcImhrZSbHgBbQ7d9JuVA+wm2G/4FP16am2SE50vqCVcezDDFxounyXRBRRjgj1Otzpw2xTJA7q8wB9DE/offYFx/G/ABDXNQzgXEVqbUAsBKMAo7oq08Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766733; c=relaxed/simple;
	bh=lgavOA6Nt8kQC0vSaKHfQq4j09dppHYLNWLDP54EVU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV4VASIt5JdCDVZhLEb/vsAUlzUMHaWYrc94UlbJ85/IHNPQuAzfGgiF02IGca63UQt0j4zbvVqukiN8/fv9jE0lmstqyVm08CvKFRYlOMm2VlQwNDXAQei/6PEj9MYcydvLPcinNQQuiydEAy9nQgEUhpbYN6vc34P5UzyTJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2qmckhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2qmckhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541061F000E9;
	Mon,  3 Aug 2026 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766731;
	bh=sjfaZldo+G7RFzR1L3Xtm7BLkKHUl3yoUS3jS+MVKLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2qmckhLBc/rBmzuMWJDVSO7mfKCW1ac7YUsub/jGecL+GaXOiF2SrLLO8Nlwzwuq
	 hqND8NGsDsVs2rBFvd3TegRB1J1I5JFi3jnWcgXmDmcYJAxuR3DV0Gi6LvGlLC5MqC
	 nKCOPnXYi7hMWHNU6QdrTeI+WNWKr7s/vPjT8y/CVQdK2ArbQTxRnILk3nQ6EvPrQN
	 0tnU2CGe1v86tN4WotTxC/F/yPiwI6tvhn/0AdwrMAp6HAAmxWTfqOKJHWjI6iSMeO
	 NJxus2UfFm/QtuGB6Amye3xJs3japB9ICS6XRCVNtM/93+qPFkkxV/k8v2wxxo7fAn
	 92AaTYnB6JcIA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/2] samples/damon/mtier: error out for zero quota goal target values
Date: Mon,  3 Aug 2026 07:18:41 -0700
Message-ID: <20260803141843.17390-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803140653.604A01F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 03 Aug 2026 14:06:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] The safety check for zero values evaluates global module parameters without `READ_ONCE()`, introducing a TOCTOU race window that bypasses the patch's defense.
> - [Low] The newly added comment references a non-existent function `damos_quota_store()` instead of `damos_quota_score()`.
> 
> Pre-existing issues:
> - [High] The core API `damos_new_quota_goal()` fails to validate `target_value != 0`, forcing ad-hoc checks in caller modules and leaving the subsystem vulnerable to division by zero.
> - [High] The DAMON LRU sort module computes a quota goal target value from an unvalidated module parameter, allowing users to trigger a division by zero crash.
> --
> 
> --- Patch [1]: [PATCH 1/2] samples/damon/mtier: error out for zero quota goal target values ---
> commit 8e87b5068bfcd9e35bdbd23dadaa97f649431adb
> Author: SJ Park <sj@kernel.org>
> 
> samples/damon/mtier: error out for zero quota goal target values
> 
> This patch prevents a division by zero in damos_quota_score() by returning
> an error when a user configures DAMON with zero target values for the
> node0_mem_used_bp or node0_mem_free_bp module parameters.
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
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in the comment. Should
> damos_quota_store() be damos_quota_score()?
> 
> > +	if (!node0_mem_used_bp || !node0_mem_free_bp)
> > +		goto free_out;
> >  	quota_goal = damos_new_quota_goal(
> >  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
> >  			DAMOS_QUOTA_NODE_MEM_FREE_BP,
> >  			promote ? node0_mem_used_bp : node0_mem_free_bp);
> 
> [Severity: High]
> Can a concurrent sysfs write bypass this safety check?
> 
> The module parameters node0_mem_used_bp and node0_mem_free_bp are read
> multiple times without READ_ONCE(). 
> 
> A concurrent thread could set a non-zero value to pass the check, and then
> overwrite it with zero before damos_new_quota_goal() reads the parameter
> again.
> 
> Would this re-introduce the division by zero crash?
> 
> This same double-read pattern appears to be present in other DAMON modules:
> 
> mm/damon/lru_sort.c:damon_lru_sort_add_quota_goals() {
>         if (!active_mem_bp)
>                 return 0;
>         goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
> ...
> }
> 
> mm/damon/reclaim.c:damon_reclaim_apply_parameters() {
>         if (quota_mem_pressure_us) {
>                 goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
>                                 quota_mem_pressure_us);
> ...
> }
> 
> Should these parameters be cached in local variables or read with READ_ONCE()
> to prevent a Time-of-Check to Time-of-Use race?

No, such race is avoided by param_lock.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but does the core API damos_new_quota_goal()
> need a check for a zero target_value?
> 
> Currently, callers are responsible for validating the target value to avoid
> a division by zero in damos_quota_score(). If damos_new_quota_goal()
> validated this and returned NULL when target_value is 0, it would protect
> the entire DAMON subsystem systematically without relying on ad-hoc checks
> in caller modules:
> 
> mm/damon/core.c:damos_new_quota_goal() {
>         struct damos_quota_goal *goal;
> 
>         goal = kmalloc_obj(*goal);
>         if (!goal)
>                 return NULL;
>         goal->metric = metric;
>         goal->target_value = target_value;
>         ...
> }

I'm planning to make a long term fix in the core layer later.

> 
> 
> [Severity: High]
> This is a pre-existing issue, but can the LRU sort module trigger a division
> by zero despite parameter validation?
> 
> In damon_lru_sort_add_quota_goals(), the cold scheme's quota goal is
> computed dynamically:
> 
> mm/damon/lru_sort.c:damon_lru_sort_add_quota_goals() {
> ...
>         goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
>                         10000 - active_mem_bp + 2);
> ...
> }
> 
> If a user configures the active_mem_bp module parameter to exactly 10002
> via sysfs, the resulting target_value evaluates to 0. 
> 
> Since this value is passed directly to damos_new_quota_goal(), wouldn't this
> crash the kernel in damos_quota_score()?

The next patch of this series fixes the bug.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260803134034.15217-1-sj@kernel.org?part=1


Thanks,
SJ
