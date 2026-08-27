Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE1476058
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842253; cv=none; b=VeZdLHI+XCbxiBGuJ90bEFhfUb9l90DocE686+z0Wh8iXgyJ8fAhtJ3s073zzOMyAcnmu0XWkjcHqE6RWQvtpMqCJ955U1VAXmOc6XnHNSx2LlQIFXDJrMDzZ/mwXrKoBgVVCsEYLkvg19nlLIHZVgmQ6t2Kwt+cQY9GFs5Aq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842253; c=relaxed/simple;
	bh=pEGbXzbe9GnkN2EGwA5VlojA3eGtFB2R1KBypd/5GPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtX61u+og45vTx+xq3LpaeC/lresrke/rPsuvW+GzZoQkHLZTKk6apdqUUVIsfryEkR357dTCtPWvVUbzmbTT04WEMpr52+ldItOXiwL67eaFi8/onzG4Dduci6CKtdlKUylVxREYuJt+OV3XUtvbW+3aIr8WuxVeCee0Sw2PsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz3D7yaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz3D7yaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD731F00A3A;
	Thu, 27 Aug 2026 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787842241;
	bh=W5qWhy6arAbx6kF7rfD51RUf/bicyyjLyHCY2U5A2Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vz3D7yaDS77CLQh0/p41Nk0JoiDoyk47BN8jyhlJNWUOX1wtf0CNydu6EvzPmhf5q
	 jP9sbyYGFm141ZTppPqm13REgwMct/VXYniBiG1XLs4Kb5WVeefqe8bBS8enWILZxf
	 IEYaFpLgs+bWHssksmw3EjDwDrAtApHGcFiTIzbEQD8rG9nwj4YpEdnk89NLC+XRwB
	 pfQfL0hEqVmne0SxVQH5eMLXQ+RN29mByyvOTGXOfPsWldelFXRII9Z3xbck2n4Pet
	 i7oQ33pHOpW7Q3QnvhZEtUC2ibw9uFpEiKC+jsimPNszdZAUoxpLeWiS5Ac0siTfOL
	 JjPcULWKkGJ7A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/3] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Thu, 27 Aug 2026 07:50:33 -0700
Message-ID: <20260827145034.124718-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827141738.124105-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 07:17:37 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu, 27 Aug 2026 13:59:58 +0000 sashiko-bot@kernel.org wrote:
[...]
> > [Severity: High]
> > Does this unconditional reset of last_psi_total truncate the measurement
> > window for running goals that are updated via sysfs?
> > 
> > When a user updates a running DAMON context via sysfs that includes an
> > existing DAMOS_QUOTA_SOME_MEM_PSI_US goal, this overwrites the running
> > goal's last_psi_total with the current time's PSI value, without resetting
> > the overall charged_from interval timer. 
> > 
> > Could this produce an artificially small current_value, causing the feedback
> > loop tuner to falsely assume memory pressure is low and erroneously increase
> > the scheme's quota?
> 
> When the entire context is committed, damos->next_apply_sis is also updated, so
> this problem doesn't happen.  However, we allow commit_schemes_quota_goals
> sysfs command to directly commit goals.  In the case, this issue can happen.
> 
> We could handle the corner case.  But I start feeling this is adding too much
> complexity for the small bug.  As also mentioned on the original commit
> message, the impact is transient and minor.  Users can also set additional
> quotas or quota goals as guardrails.  I will keep the original behavior as is,
> and just add comments about it.  We can revisit if a real user gets real
> problem from the documented behavior.

While writing the documentation I found myself don't really like this random
behavior.  Another solution is initializing the field as UINT64_MAX at new
quota goal creation (damos_new_quota_goal()).  When the ->current_value for the
goal is calculated in damos_set_quota_goal_current_value(), it can check the
UINT64_MAX case and set the current value same to target value, so that this
tuning round make no change to the tuned quota.  The last_psi_total will be
updated to real value and make effect from the next round.

damos_commit_quota_goal_union() will also be updated to set the destination
goal's last_psi_total to the source goal's value.  Let's assume the source was
made with damos_new_quota_goal() and the last_psi_total field is not modified.
It should be a safe assumption since normal API callers are supposed to use
damos_new_quota_goal(), and don't reuse a goal that were updated by kdamond.
So the next round tuning will be skipped, but works without unexpected effect
from the next round.  If the destination goal was the PSI goal, this makes the
goal to skip next round auto-tuning for no good reason.  But that should be
fine.  DAMOS auto-tuning is basically for long term best-effort, not short-term
fully deterministic control.

> 
> > 
> > >  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
> > >  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
> > >  		dst->nid = src->nid;
> > 
> > [ ... ]
> > 
> > > @@ -1143,7 +1148,6 @@ static void damos_commit_quota_goal(
> > >  	dst->target_value = src->target_value;
> > >  	if (dst->metric = DAMOS_QUOTA_USER_INPUT)
> > >  		dst->current_value = src->current_value;
> > > -	/* keep last_psi_total as is, since it will be updated in next cycle */
> > >  	damos_commit_quota_goal_union(dst, src);
> > >  }
> > 
> > [Severity: Medium]
> > Since the semantics of damos_commit_quota_goal() have changed to explicitly
> > overwrite last_psi_total rather than preserve it, should the corresponding
> > KUnit test be updated as well?
> > 
> > The existing KUnit test in mm/damon/tests/core-kunit.h
> > (damos_test_commit_quota_goal_for()) expects the old preservation behavior:
> > 
> > if (dst_last_psi_total && src->metric = DAMOS_QUOTA_SOME_MEM_PSI_US)
> > 	KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);
> > 
> > Without updating this assertion, there appears to be a mismatch between the
> > new code behavior and what the test expects.
> 
> Good catch.  I usually run kunit without CONFIG_PSI, so didn't encounter the
> issue.  However, as I'm changing my mind to keep the behavior but just update
> the documents, this is irrelevant.

So relevant kunit test case may also be updated.


Thanks,
SJ

[...]
