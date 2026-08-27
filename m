Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB34779BB
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840270; cv=none; b=irTvUWo6/yKjIx4iwOgLUubvl4js4WZMDhI6i2cc/TjdTe+mkFo7/QlrMUtqxk0j1EDM66PJbsBoEAuYu3vPf73n4noUYLv7pS49krV1JRCHsVYHLSsGaGZ3rL83hUSjnSG1/yGAI6uriT24zuFZwb3aZgQkW24X5hvKoXqVg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840270; c=relaxed/simple;
	bh=G2XDzIAldJjQ523+PmcJHbV+TFcHLCn/7m2MKPvcML8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUJWdkYUufEGZ94fkVA2BDIOdny0e8cohbnbtjoZWQ9pmlz1fZJQIl5GdAT4CLH/M4CykFDqJxIOpecpMWgbJ3S3+Ek6Q0lomjHU5FY3coRD7UnMuhrS22oMvlu/HBuBmlA5VxA+mgglUGmK37OvPd9BJokWoetg/VuKM+Z1TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikUp3ISB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikUp3ISB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896FF1F000E9;
	Thu, 27 Aug 2026 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787840265;
	bh=zJY64QtrCU7ujj+KHajrS5vtfuZvoiMJyxC59Yof9nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ikUp3ISB7tjpgsqkhcR1Jw/T2wL5upXxcUbWj21sBoyraR0dmlLrlxhkSfPnh8Q5h
	 X2MS0hUDvcOIsbZbG1YuOw/SbYiPt20yCuwjyS3IhyCTeKJ/U3bqAHALBA7VnVcYCV
	 SR6iurpSXGDAAzGCEuK7N1fYNcIQFRi/wf+UO/kpJlMxFtBeuLLADu7m1Si8jeY2pN
	 /QqlQ6oWtTxF2407tpI6oOHBLMK2CCWYWG31bZW2lBuD7zmenZdVn5nxxtYhk0U8Kl
	 MNi7+Sm0laKI+V3a4r/WMlcIPlMthIaDQAh6UlIvEYmaFuER4Oy/MWFEqxGWAEPwdD
	 IyHXm6V5MHryQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/3] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Thu, 27 Aug 2026 07:17:37 -0700
Message-ID: <20260827141738.124105-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827135958.940FB1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 13:59:58 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unconditionally resetting last_psi_total in damos_commit_quota_goal_union() breaks the feedback loop measurement interval for existing goals during sysfs updates.
> - [Medium] The patch changes the semantics of damos_commit_quota_goal() to explicitly overwrite last_psi_total instead of preserving it, but leaves behind a KUnit test assertion that expects preservation.
> --
> 
> commit 8007d7351717974f3d1ef45ed438346542307389
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: initialize damos_quota_goal->last_psi_total
> 
> This patch initializes the last_psi_total for DAMOS_QUOTA_SOME_MEM_PSI_US
> quota goals to prevent the first iteration of the feedback loop from using
> an uninitialized value. It introduces initialization at the start of kdamond
> and during each goal commit.
> 
> Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..723ab998b63c7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1118,10 +1118,15 @@ static struct damos_quota_goal *damos_nth_quota_goal(
> >  	return NULL;
> >  }
> >  
> > +static u64 damos_get_some_mem_psi_total(void);
> > +
> >  static void damos_commit_quota_goal_union(
> >  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
> >  {
> >  	switch (dst->metric) {
> > +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> > +		dst->last_psi_total = damos_get_some_mem_psi_total();
> > +		break;
> 
> [Severity: High]
> Does this unconditional reset of last_psi_total truncate the measurement
> window for running goals that are updated via sysfs?
> 
> When a user updates a running DAMON context via sysfs that includes an
> existing DAMOS_QUOTA_SOME_MEM_PSI_US goal, this overwrites the running
> goal's last_psi_total with the current time's PSI value, without resetting
> the overall charged_from interval timer. 
> 
> Could this produce an artificially small current_value, causing the feedback
> loop tuner to falsely assume memory pressure is low and erroneously increase
> the scheme's quota?

When the entire context is committed, damos->next_apply_sis is also updated, so
this problem doesn't happen.  However, we allow commit_schemes_quota_goals
sysfs command to directly commit goals.  In the case, this issue can happen.

We could handle the corner case.  But I start feeling this is adding too much
complexity for the small bug.  As also mentioned on the original commit
message, the impact is transient and minor.  Users can also set additional
quotas or quota goals as guardrails.  I will keep the original behavior as is,
and just add comments about it.  We can revisit if a real user gets real
problem from the documented behavior.

> 
> >  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
> >  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
> >  		dst->nid = src->nid;
> 
> [ ... ]
> 
> > @@ -1143,7 +1148,6 @@ static void damos_commit_quota_goal(
> >  	dst->target_value = src->target_value;
> >  	if (dst->metric = DAMOS_QUOTA_USER_INPUT)
> >  		dst->current_value = src->current_value;
> > -	/* keep last_psi_total as is, since it will be updated in next cycle */
> >  	damos_commit_quota_goal_union(dst, src);
> >  }
> 
> [Severity: Medium]
> Since the semantics of damos_commit_quota_goal() have changed to explicitly
> overwrite last_psi_total rather than preserve it, should the corresponding
> KUnit test be updated as well?
> 
> The existing KUnit test in mm/damon/tests/core-kunit.h
> (damos_test_commit_quota_goal_for()) expects the old preservation behavior:
> 
> if (dst_last_psi_total && src->metric = DAMOS_QUOTA_SOME_MEM_PSI_US)
> 	KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);
> 
> Without updating this assertion, there appears to be a mismatch between the
> new code behavior and what the test expects.

Good catch.  I usually run kunit without CONFIG_PSI, so didn't encounter the
issue.  However, as I'm changing my mind to keep the behavior but just update
the documents, this is irrelevant.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260827134429.123023-1-sj@kernel.org?part=1
> 


Thanks,
SJ
