Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05079DA
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787883732; cv=none; b=qJx2JBmk2SXhKyZ5FhVV/KrnOMs9oj5RBV/ztLhjU5AOv38wVMvbUqorsFjb1h66irnCqlTnRlqoC5P0z1vrwIEqKYX91po0D7AchshXUtWGYWsjJu3/s6XHQeauIBG3gsAMPkMglvYpeP6c4C82WE2u5dasQqTcy9YX8Rv/FVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787883732; c=relaxed/simple;
	bh=zZ8kLg/ydXtPY92LaRUDshQ3rycdwNDtH/NHYtRBgHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXZqlIaskkORWZyuL+Lfumzorb9XbbhfKsKOJ8H/hqrlP35ZT7pxhRY/KEgZadq9VSt8ymnN/09DRqz1naqJa9xy1WtWwRhU9eo68BkUcNWhsY8+bjb2cJxDT0FHuCCIfcLQjZFUQ0HLOEbbViNn54k+fSc/LelcC+gtqbF/7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKPCAOtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKPCAOtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFB11F000E9;
	Fri, 28 Aug 2026 02:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787883731;
	bh=TnDiHqmEZ3LjWplksRMgeyy9LZU9D9+Sgl+jfogMGVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKPCAOtzkkpbD0UFgM84/IfD5jqUb1BthQPKOSmeOYK7vWpI5zjaDjyRgVACNpjFA
	 KsefWHz8OYH9Tfg/3bAUTLYNkCgbNlrAAJoTMMvzd7/rL3TrIPmobHcCvHgicw/xRe
	 eYG9HmrQ/4Llzg5komFBqCxW8+oI2jAGmNBx4+AZNF9kLZuO6iqriQLU250+pSJ6Zi
	 tCsf7bs2YN8LGuEsO9W9CujiMJ0Q2l3BuFfSjLQs+0sKf/z/Py3heB7QCQNhvkq9Uu
	 7zfZsxr7sXQoLZssaNhWkwNU6RKgXn/AldPJUCns6UX/B9//56E2KgVYsNSNHX6W0a
	 D2fXQ95Ct010g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 2/4] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Thu, 27 Aug 2026 19:22:02 -0700
Message-ID: <20260828022203.122333-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828015524.5F0AA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 01:55:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Integer underflow when initializing last_psi_total causes severe quota throttling instead of maintaining the quota.
> --
> 
> commit 216061cc4d3a0304d1961ab1798b65cbf748aa6c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
> 
> This commit handles an uninitialized last_psi_total for PSI metric DAMOS
> quota goals by initializing it to U64_MAX. During the first tuning round,
> it detects this state and attempts to set last_psi_total such that the
> first iteration has no unexpected effect on the quota.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..b0c8e22ab5404 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3018,6 +3022,10 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
> >  		break;
> >  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> >  		now_psi_total = damos_get_some_mem_psi_total();
> > +		/* uninitialized last_psi_total; make no effect this round */
> > +		if (goal->last_psi_total == U64_MAX)
> > +			goal->last_psi_total = now_psi_total +
> > +				goal->target_value;
> >  		goal->current_value = now_psi_total - goal->last_psi_total;
> 
> [Severity: High]
> Does this arithmetic result in an integer underflow on the first tuning
> round?
> 
> If goal->last_psi_total is set to (now_psi_total + goal->target_value), the
> calculation on the very next line becomes:
> 
> goal->current_value = now_psi_total - (now_psi_total + goal->target_value)
> 
> This evaluates to -goal->target_value. Since current_value is an unsigned
> long, this underflows to an astronomically large value. Will the feedback
> loop interpret this as a massive over-achievement and drastically throttle
> the quota to its minimum, causing the exact opposite of the intended
> "no effect this round" behavior?

Argh, correct.  I will fix this like below.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3394,9 +3394,10 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
                now_psi_total = damos_get_some_mem_psi_total();
                /* uninitialized last_psi_total; make no effect this round */
                if (goal->last_psi_total == U64_MAX)
-                       goal->last_psi_total = now_psi_total +
-                               goal->target_value;
-               goal->current_value = now_psi_total - goal->last_psi_total;
+                       goal->current_value = goal->target_value;
+               else
+                       goal->current_value = now_psi_total -
+                               goal->last_psi_total;
                goal->last_psi_total = now_psi_total;
                break;
        case DAMOS_QUOTA_NODE_MEM_USED_BP:
'''

> 
> >  		goal->last_psi_total = now_psi_total;
> >  		break;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260828014659.121058-1-sj@kernel.org?part=2


Thanks,
SJ
