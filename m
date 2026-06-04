Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496F3AFAE1
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550742; cv=none; b=LlRZCkPHP9ZUcIxK9BhsJwm53SGhQU8gdonOHSb5ILiDD8Aj84b6zbEnU+gT0eeaby6bo5B4i3CZPGK1bLR8mLabAYtGUSC6bPGrDPdjrfYdZ6YXy91T9MD498x20LBqZC5YsdLUxBdWbbHYvUgbxNBNol32Mu3mfBBwBg1T1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550742; c=relaxed/simple;
	bh=3drrMPyLHtoS9bhodCses/W4qONDjG8VB8OplRh2eYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/YpP61XnocHFDrb8tTymwZlfXEJGSSrPZECCj+VtVkx7Cxc5Hikc7nYRtJRPMF0wcKOa549kgcCQcgvXI+4ymehlqWQh7v9ipmS8J6jKE53W6p/Wql2qgybo5ppfndqb0+Sgym3okAo1LHuryA0lRP4iJ4y5Ur+bnoRBAsoBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLDFaQLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLDFaQLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2CD1F00893;
	Thu,  4 Jun 2026 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780550741;
	bh=PxNLdM4OmMaCZupiMmqa4gG6nRL+OxmeqX7L7Aeva1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bLDFaQLM05+h4ristA1Qg9/WHafYAAr511m+VAYnVSWs7d9BpFSI68uLhIQej2LQu
	 xlLtbG32HsfugMYAYUxkHUQnU3WBeFMDhFFODo220+LsdNz6nQAhQki/Brv6ZAXqSX
	 QJ2GtYvzm6Ykydz7UJIZSEW467AYac6HPdQzWp7wiB3LSE5Izradq3KdWvG1QK8X8W
	 U++3okc/FK9WGXsiTolwpLuGQ/WNQpuAxeO8QA5nJinPaqkxM4D/Fd4CZHqFtpJ3fB
	 ZtJsd4qWXekAfEsx5079iFKyI5wKH2WghyBPjmh83kdvIpC+avHsWxizTmC7HQ6FJo
	 1xTEyh6PvHvhQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/core: always put commit-failed target's pids
Date: Wed,  3 Jun 2026 22:25:30 -0700
Message-ID: <20260604052531.69908-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604045715.68720-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  3 Jun 2026 21:57:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 04 Jun 2026 04:37:55 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] `damon_commit_target_fail()` incorrectly skips PID cleanup for sysfs test contexts due to uninitialized callbacks.
> > 
> > Pre-existing issues:
> > - [High] PID reference leak on multiple error paths during context conversion from paddr to vaddr bypasses the newly added cleanup logic.
> > --
> > 
> > commit 9659672aa95ce46b9511dd7216240c3314476900
> > Author: SeongJae Park <sj@kernel.org>
> > Subject: mm/damon/core: always put commit-failed target's pids
> > 
> > This commit fixes a PID leak that occurs when damon_commit_target() fails.
> > It adds damon_commit_target_fail() to handle putting the already-committed
> > PIDs when cleaning up after a failed commit.
> > 
> > Link: https://lore.kernel.org/20260320020056.835-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -1387,6 +1387,31 @@ static int damon_commit_target(
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * damon_commit_target_fail() - handle damon_commit_target() failure.
> > > + * @dst:	Commit destination context
> > > + * @failed:	Commit failed destination target
> > > + * @src:	Commit source context
> > > + *
> > > + * This function is called by damon_commit_targets() for dammon_commit_target()
> > > + * failure for immediate states cleanups.
> > > + */
> > > +static void damon_commit_target_fail(struct damon_ctx *dst,
> > > +		struct damon_target *failed, struct damon_ctx *src)
> > > +{
> > > +	struct damon_target *target;
> > > +
> > > +	if (!damon_target_has_pid(src))
> > > +		return;
> > > +	if (damon_target_has_pid(dst))
> > > +		return;
> > 
> > [Severity: High]
> > Does this early return handle sysfs test contexts correctly?
> > 
> > When damon_sysfs_new_test_ctx() creates a context using damon_new_ctx(),
> > the ops structure is zero-initialized. Since DAMON_OPS_VADDR evaluates
> > to 0, damon_target_has_pid() will return true for this test context,
> > but its cleanup_target callback is still NULL.
> > 
> > If damon_commit_target() fails while copying to this test context,
> > will this return early and skip PID cleanup, trusting a NULL callback
> > to handle it later during destruction?
> 
> Good catch, I will fix this in the next revision.
> 
> > 
> > > +	damon_for_each_target(target, dst) {
> > > +		if (target == failed)
> > > +			return;
> > > +		put_pid(target->pid);
> > > +	}
> > > +}
> > 
> > [ ... ]
> > 
> > > @@ -1432,6 +1459,7 @@ static int damon_commit_targets(
> > >  				src_target, damon_target_has_pid(src),
> > >  				src->min_region_sz);
> > >  		if (err) {
> > > +			damon_commit_target_fail(dst, NULL, src);
> > >  			damon_destroy_target(new_target, NULL);
> > >  			return err;
> > >  		}
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does this cleanup logic miss other
> > error paths during a paddr to vaddr conversion?

FYI, it is indeed not caused by this patch.  But it is what this patch was
supposed to fix together.  So I'm gonna fix it in the next revision.

> > 
> > When converting a DAMON context from paddr to vaddr, damon_commit_targets()
> > copies PIDs and increments their reference count in the first loop.
> > If an error occurs before this point in the second loop:
> > 
> >     damon_for_each_target_safe(src_target, next, src) {
> >         ...
> >         if (src_target->obsolete)
> >             return -EINVAL;
> >         new_target = damon_new_target();
> >         if (!new_target)
> >             return -ENOMEM;
> >         ...
> > 
> > These paths return directly without calling damon_commit_target_fail()
> > to clean up the already committed PIDs.
> > 
> > Additionally, if damon_commit_targets() succeeds but damon_set_attrs()
> > fails later in damon_commit_ctx(), it returns before the dst operations
> > are updated.
> > 
> > In all these cases, the destination context is left with paddr
> > operations where cleanup_target is NULL. When damon_destroy_ctx() is
> > called, will it skip dropping these PID references and leak them?
> 
> Good finding.  I will fix these in the next revision.


Thanks,
SJ

[...]
