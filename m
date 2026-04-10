Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95983C2763
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828694; cv=none; b=GmLH3iaeme/kmhDwtsn80SsItF+QvyaGOdmZxeDBdXs5mkZEqRPueuPj7TJMCXdWBin8/3YW6Vn/FV1vxL9kAGL4R8IrgXmRE3HPj1n4ZdWmFRzsvS2nw6u9RJuRabJXYG9RVIAJI1MB3fOzsZ73HEnPVJs5tPykxATD0oPDHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828694; c=relaxed/simple;
	bh=Yq0pcicllP/Ez2lgctEQ5fQ4x7hGNj+JwjVHDJE+4Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dub5CypzfVGtW/vMAWoYJ7PeHCsBlgYHJM36BixqT+qsFG/seMCCzVzoqtmLspl5kkYSbnnc5dvz1NqpFEePxSBXnWZzKKdfvah06Q9OvPFR0V7DbYssmkDFbzSNU6VCtcseHdvRRpTNA7FztaPDWDmI4xWCNS0wmXfqFlPJsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7q5/Ot/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7q5/Ot/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E5C19421;
	Fri, 10 Apr 2026 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775828694;
	bh=Yq0pcicllP/Ez2lgctEQ5fQ4x7hGNj+JwjVHDJE+4Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7q5/Ot/qTsyqcIE59d5XHyVIMML/BK/405Fb6R8a4WdqaON5t5jLE8b53er3DUpi
	 44Dqi2d2pfi/Sk905c8rfaCf2olrArSJfAYAU/Ltnm3H1g/e/xukTbvBg3YFn6c9kz
	 utSUvmsRm82mbuNYAdJ7M9Szb1jTKr97PaibSFf1zBkWgs5E3atDOeZpdQhTIOMG7o
	 MZMf4UrLM4uanm0F6addq/ODFaSHmwd9keVP/U23QldWj7f68nf0KTnyGEGLc4VVKw
	 fo7rq123CCCFvSkqHyHcN6i7Z5tl/NbO3MfuO+M/JWWQ1vImKeBrkyezL8V1rzWjY5
	 lmYZw8ErSySxg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 06:44:50 -0700
Message-ID: <20260410134451.81846-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410100822.196999-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Apr 2026 18:08:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Sashiko found some issues.
> 
> Forwarding sashiko review in a reply format with my inline
> comments below, for details of my view and doing discussions
> via mails if needed.
> 
> > # review url: https://sashiko.dev/#/patchset/20260410044259.95877-3-aethernet65535@gmail.com
> > # start of sashiko.dev inline review
> > commit 7a816b41f4b321b6a513227bef0e50f3bc1e86f1
> > Author: Liew Rui Yan <aethernet65535@gmail.com>
> > 
> > mm/damon/reclaim: validate min_region_size to be power of 2
> > 
> > This commit adds an early validation in damon_reclaim_apply_parameters() to
> > check if min_region_sz is a power of 2. It attempts to prevent kdamond from
> > terminating unexpectedly by catching invalid values before they reach
> > damon_commit_ctx().
> > 
> > > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > > index 86da147786583..2747eef5919d1 100644
> > > --- a/mm/damon/reclaim.c
> > > +++ b/mm/damon/reclaim.c
> > > @@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
> > >  	param_ctx->addr_unit = addr_unit;
> > >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> > 
> > Is it possible for a concurrent sysfs write to change addr_unit between these
> > two reads, allowing an invalid value to bypass the new validation?
> > 
> > The global variable addr_unit is read twice without READ_ONCE(), once to set
> > param_ctx->addr_unit, and again to calculate param_ctx->min_region_sz.
> > 
> > If addr_unit is changed from a non-power-of-2 to a power-of-2 between the two
> > reads, the validation below might succeed using the new value, while the
> > invalid addr_unit is committed to the active context.
> 
> I believe this is possible, because the current call to
> damon_reclaim_apply_parameters() is asynchronous and does not hold the
> 'kernel_param_lock' during execution, so this situation should be
> possible.
> 
> However, I'm still unsure whether your suggested changes should be
> included in this patch.

We already addressed this with by defining it as an expected behavior that the
user should avoid.  And the queued patch [2] from Liew will make commits
synchronous and fix this issue together for the mainline.  Let me know if I'm
missing something.

> 
> > 
> > > +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > > +		err = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > 
> > Does this early check mask a structural issue in the core API?
> > 
> > Looking at damon_commit_ctx() in mm/damon/core.c:
> > 
> > int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> > {
> >         ...
> >         dst->maybe_corrupted = true;
> >         if (!is_power_of_2(src->min_region_sz))
> >                 return -EINVAL;
> >         ...
> > 
> > If a different caller passes an invalid min_region_sz, it will still trigger
> > this same trap.
> > 
> > Could the root cause be addressed by moving the maybe_corrupted flag update
> > below the validation checks inside damon_commit_ctx()?
> > 
> > Are there other ways damon_commit_ctx() could leave the context corrupted?
> > 
> > If a user dynamically enables features that require memory allocation,
> > damon_commit_ctx() calls damon_commit_schemes() which attempts to allocate
> > memory via damos_commit_quota_goals().
> > 
> > If this allocation fails with -ENOMEM, it returns an error but leaves
> > dst->maybe_corrupted = true on the active context, permanently terminating
> > kdamond.
> > 
> 
> I discussed this in my previous reply. But I realized there might have
> been some misundertanding in my previous explanation. What I wanted to
> say is that there might indeed be some issues with 'maybe_corrupted' in
> damon_commit_ctx() that need adjustment, but that's not within the scope
> of this patch.

I agree.

> 
> > Can a concurrent sysfs write cause a divide-by-zero panic in this same
> > function?
> > 
> > Looking further down in damon_reclaim_apply_parameters():
> > 
> >         if (quota_mem_pressure_us) {
> >                 goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
> >                                 quota_mem_pressure_us);
> > 
> > The global module parameter quota_mem_pressure_us is read twice without
> > READ_ONCE().
> > 
> > If a concurrent write changes its value to 0 immediately after the if
> > condition passes, a quota goal with a target_value of 0 is added.
> > 
> > When DAMON evaluates the quota score in damos_quota_score(), it uses the
> > macro mult_frac(goal->current_value, 10000, goal->target_value). Dividing
> > by a goal->target_value of 0 will cause a kernel panic.
> 
> I tried to reproduce this issue, but without success. 
> 
> However, based on the code, I believe the problem exists because I
> didn't find any checks preventing 'goal->target_value=0'. Please let me
> know if I've missed anything.

As I mentioned above, it is unallowed user inputs [1], and Liew's queued patch
[2] will fix this for mainline.

> 
> > 
> > A similar sequence exists for quota_autotune_feedback.
> > 
> > >  	if (!damon_reclaim_mon_attrs.aggr_interval) {
> > >  		err = -EINVAL;
> > >  		goto out;
> > >  	}
> > 
> > 
> > # end of sashiko.dev inline review
> > # review url: https://sashiko.dev/#/patchset/20260410044259.95877-3-aethernet65535@gmail.com
> 
> # hkml [1] generated a draft of this mail.  You can regenerate
> # this using below command:
> #
> #     hkml patch sashiko_dev --for_forwarding \
> #             20260410044259.95877-3-aethernet65535@gmail.com
> #
> # [1] https://github.com/sjp38/hackermail
> 
> Best regards,
> Rui Yan

[1] https://lkml.kernel.org/r/20260329153052.46657-2-sj@kernel.org
[2] https://lore.kernel.org/20260402155733.77050-4-sj@kernel.org


Thanks,
SJ
