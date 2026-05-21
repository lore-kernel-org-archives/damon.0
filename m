Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21A30FC03
	for <damon@lists.linux.dev>; Thu, 21 May 2026 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341055; cv=none; b=Ph4hvgyS0gDYuQCy+oxZlwt+beSQCU1ZeyCTDiPEhHz+G76G45USDV1tfx0GhkaBeahixkpCQ0Dr/RyF9EnssYOk1fMvQ9VtuAAeg6PBsZt9OOFGdLIcE5pfcKdg0iFTA+VXFKl7qI4Qwo/CmzrwdZeTZKUYiWtCbi9DHh9AcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341055; c=relaxed/simple;
	bh=EWepQBDNe65DdAeXCxYmpZ0pjbAO2QKbMbfQPi4TTsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyKB/QKfUIY4lAofyMXutx3uXrzN6rnvob6MnmFrsBnhMAoLK5fxCMhEhaCdJjaGQXV0NlsAg4gL+ZPyd+AZj31Paf9olIyqHCOFHBfjzh6eE79bsYuxISiorzzu/A5KRy9C+IqdYirhWMavTTpMuZNeWYtK3ZkF/gMcH2J5yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GweKHaYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GweKHaYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0851F000E9;
	Thu, 21 May 2026 05:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779341054;
	bh=yh/ER6NyTpt01Wh08O9Gm8RLFAgZrQHMHUVK54CY3xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GweKHaYomcZKgzVmSOmeGp0nalIfPNaHy6ZqHX6ps6a8bEtISVL0f5z0eYAAlxVmo
	 ObW4KbMxRvIMDo93H0yfccpRIluV8ze6ShA2R7Dn4NTkYQk6LDyHxkN89G+N9ZAGaT
	 VPtg4/QeFzWC8PpREXohhvOfcX9LBtb/S6y/ZP+zSs8JJvEnYZKEhOxe2osxco18Ib
	 o5qA0M4rHumdP0YKgNYJ8CLuJc/KJKdc8ne089yzWi042ubp4gVDFxkmB5I9sNggd5
	 GnXSX8zzJ0RdMt195IpRkDAOmlnq3RmX8ltlQR+oP5u5w/YHTRbkP8LB8J99GYP6KK
	 2OjL/mKAgRm1Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 04/14] mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
Date: Wed, 20 May 2026 22:24:10 -0700
Message-ID: <20260521052411.89029-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521040526.620A81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 04:05:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Memory leak of the `damon_target` structure and attached regions when `damon_set_regions()` fails.
> --
> 
> commit e0458a31c6f6c7f46d6a9ef3e90d4098d89686fd
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
> 
> This commit updates the DAMON virtual address operation set unit tests to
> use damon_set_regions() instead of damon_add_region() for region setup. This
> aligns the tests with how other DAMON API callers set up regions.
> 
> > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > index 98e734d77d517..de30db9b753e5 100644
> > --- a/mm/damon/tests/vaddr-kunit.h
> > +++ b/mm/damon/tests/vaddr-kunit.h
> > @@ -132,22 +132,32 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
> >  				unsigned long *expected, int nr_expected)
> >  {
> >  	struct damon_target *t;
> 
> [ ... ]
> 
> >  	t = damon_new_target();
> >  	if (!t)
> >  		kunit_skip(test, "target alloc fail");
> > +
> > +	ranges = kmalloc_array(nr_regions / 2, sizeof(*ranges), GFP_KERNEL);
> > +	if (!ranges) {
> > +		damon_destroy_target(t, NULL);
> > +		kunit_skip(test, "ranges alloc fail");
> > +	}
> 
> [ ... ]
> 
> > +	if (damon_set_regions(t, ranges, nr_regions / 2,
> > +				DAMON_MIN_REGION_SZ)) {
> > +		kfree(ranges);
> > +		kunit_skip(test, "damon_set_regions() fail");
> 
> [Severity: Medium]
> Does this error path leak the damon_target structure and its attached regions?
> 
> Unlike the earlier kmalloc_array() error path which calls
> damon_destroy_target(t, NULL) before skipping, this failure path seems
> to omit the cleanup. Because kunit_skip() aborts test execution via a
> long jump, the target allocated via damon_new_target() wouldn't get freed.
> 
> >  	}
> > +	kfree(ranges);
> >  
> > -	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
> > +	if (damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ))
> > +		kunit_skip(test, "second damon_set_regions() fail");
> 
> [Severity: Medium]
> Could the same memory leak occur here? 
> 
> If the second damon_set_regions() fails, kunit_skip() is called without
> first freeing the target structure.

Good points.  I will fix these in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260521035349.87565-1-sj@kernel.org?part=4


Thanks,
SJ
