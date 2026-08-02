Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50B30148A
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692515; cv=none; b=r++nh5/KpFcJhbNJMH0GQka5kLa1swVGSQT41MP+ALEMJcn5CbR8U0Z26DWubLrsVeYCDvsUG1ZkgautJMmzRk0C7lhkgnCr/7ztSvSd05T4fIVIrUNMOEwrI9iJWWGuctkPTiCvfCctELYhWyTNcyXeYU2Q+ROBTL1oveMb2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692515; c=relaxed/simple;
	bh=7EcxKFugURkS7Hm/IB3kWtblSMiVAiHf8hmC3nFHqqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQr6ceXidEoGXZkeih79f2Tai62LCU3brzuzMBIy2hJsvpDVkWf2wgHNyJhG+EwMsFzRAgtLwtWrNAVIUXOZNNd18uMl6bcCxj1X8lHNJc4cO5QB/pWmUt5mKok3HQzaP+2jmIsy9W+uMJjQ6Nu2Dmd7qdhhHz9Zo8izlm4ntWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAuGUHFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAuGUHFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6315D1F000E9;
	Sun,  2 Aug 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692514;
	bh=LhIbwtD/4o3SaPSxiKrhDc64q/5lu1XPg93nERwJVFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAuGUHFqASJ2ZFytsIkpgdYAkD/APOdEeSAgBEf2wenY0n7jN1GetiwH4zJt8beJI
	 DVzoCYz+0/uMgMRurM3IbsChAWV31sbsqQPe8/BZJdG8FVFapAiedh5C7+GLWRuA8Z
	 /uAlDzLYJqlBjqZWOyC9NsUDedRqx1gvm3M/OVrAlBtEAb6yssb3SntGnWd5jqEaV8
	 F/5Dr4TTqD3OG8UJFXeIpHOwgffKCIDSerz+1GBNgUC3WHUwsEYkXY7YEPBNDjfZG+
	 wsmrqyrZHq12IB8MSMvMcyw4QHKqofsQY5vTR/tTAhTXS1aGh8AtdB9k9jMWj0acFE
	 3YwZcEF024avQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 2/9] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Sun,  2 Aug 2026 10:41:44 -0700
Message-ID: <20260802174146.1437-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802164314.73A571F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:43:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The patch incompletely fixes the uninitialized `last_psi_total` variable usage. While it initializes `last_psi_total` when the `kdamond` thread starts, it fails to initialize it for schemes or quota goals added dynamically at runtime via sysfs.
> --
> 
> --- Patch [2]: [RFC PATCH v1.1 2/9] mm/damon/core: initialize damos_quota_goal->last_psi_total ---
> commit ca3c4694fe111f676d0de56148cf986c02532428
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: initialize damos_quota_goal->last_psi_total
> 
> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total. It is not initialized at the beginning.
> This commit initializes the value at the beginning of kdamond.
> 
> Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e2900d0c984c9..3bdbf4fbf7147 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3744,6 +3755,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
> >  	damon_for_each_scheme(scheme, ctx) {
> >  		damos_set_next_apply_sis(scheme, ctx);
> >  		damos_set_filters_default_reject(scheme);
> > +		damos_init_quota_goal_last_psi(scheme);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this completely fix the uninitialized
> variable usage?
> 
> While this initializes last_psi_total when the kdamond thread starts, it
> appears goals added dynamically at runtime via sysfs will still be
> uninitialized.
> 
> When a goal is parsed from sysfs, memory is allocated without zeroing the
> structure, leaving last_psi_total filled with slab garbage:
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_add_quota_score() {
>     ...
>     goal = damos_new_quota_goal(sysfs_goal->metric,
>             sysfs_goal->target_value);
>     ...
> }
> 
> During the context commit phase, the goal is dynamically allocated but
> last_psi_total is intentionally bypassed:
> 
> mm/damon/core.c:damos_commit_quota_goals() {
>     ...
>     new_goal = damos_new_quota_goal(
>             src_goal->metric, src_goal->target_value);
>     ...
> }
> 
> When the feedback loop executes, this uninitialized memory is consumed:
> 
> mm/damon/core.c:damos_set_quota_goal_current_value() {
>     ...
>     goal->current_value = now_psi_total - goal->last_psi_total;
>     ...
> }
> 
> Will this cause a random, extremely large or small initial quota adjustment
> when a user adds a new DAMON scheme or quota goal with the
> DAMOS_QUOTA_SOME_MEM_PSI_US metric to a running context via sysfs?

Good catch.  To handle this, the fix will be little bit complicated.  It may
not deserve stable@ backport.  I will drop this from the next version of this
series and work on more complete fix.

> 
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=2
> 


Thanks,
SJ
