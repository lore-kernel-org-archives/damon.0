Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFE3B14DE
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300211; cv=none; b=O8kEyIHEJvYOHNJOk8wiSfOF+sgJZi7fSXGCgCiCYvYF5nBPFUc3uc4MnQJNDi7AT0Kr81qXVFDuGJONkHVXzOLxctWGawo/ip1DkMYnMLyGuFoyc/2ZDyl/BECyUyTDkho3FNKdAAt9ViRjZQmQQc67WU9IMjlKnjbIa2LX+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300211; c=relaxed/simple;
	bh=K4Q3PzJl2fwzFkTiZzFJROEBo3YLJsbzZRdwIG06zzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfR2ZdxtxRPE82UfkvHTBVK0RXntrNY4ywKUY4diMwL+9rLXZrDt7uIgCd5LGXY/xb8E/GH9QFYUNf9BOAgepQ6aEtENFQhkVgaZeZJMqoP4D/gcem6vtS1jrKyygWOoWueLF0zbN+nhY2AuPhbXgCSAhVZSmOop1Bef2aV7xOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVNIqttZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVNIqttZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468071F000E9;
	Fri, 17 Jul 2026 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300203;
	bh=hpoDbkpWPWe5oeENVsNvxgXftp2iBTgOru9aO7k8B5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVNIqttZqPYy0d2zl/6EVyYRX6jt/1fPxQ4layx6t9kirCHi65XLuQd7qr8S7zw8R
	 c184fJRCIWBo1HIcmb0mZlGSjGZ1rLD13Upf2muRoWYm0XpDusnzIDyz9EjRKB8RN6
	 +EapPjx2DaFMtJGLd3++wfV3lmkGWWb1gpSXaYzpBJdVFRCJeKKiBa9oFWJtj3xI7m
	 dLAykRS5G1jZqn4lxfJoJK+use0t6/Fz/tpLQWaoQ4ILCmqgSRTBL40bo5i/6s0WLR
	 hkkaQjiS/qUgRn97IATRHZei7UxoAcC/8w2rWsnvkJv4urCFDb/oyQQSTp1QLEeTKp
	 Z2J1DTH9opC5w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 4/7] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Fri, 17 Jul 2026 07:56:34 -0700
Message-ID: <20260717145635.92237-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717144904.836FC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 14:49:04 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it shares the exact same logic flaw fixed here. In `damon_apply_min_nr_regions()`, if `damon_split_region_at()` fails to allocate a new region (e.g., due to memory pressure), it leaves `r` unmodified. However, the inner `while` loop unconditionally executes `r = damon_next_region(r);`. If `r` was the last region in the list, `damon_next_region(r)` will return a pointer derived from the list head (`&t->regions_list`), resulting in a fake `damon_region` pointer pointing into the middle of the `damon_target` struct or preceding memory. The loop then evaluates `damon_sz_region(r)` on this fake region, reading garbage memory. If the garbage evaluates to a size greater than `max_region_sz`, it will invoke `damon_split_region_at()` on the fake region, causing an out-of-bounds write and list corruption (overwriting `r_fake->ar.end` and `t->regions_list`), or an infinite loop lockup if allocations keep failing.
> --
> 
> --- Patch [4]: [RFC PATCH v1.1 4/7] mm/damon/core-kunit: handle region split failure in filter_out() ---
> commit 571c1400b8cb843c3acdb1ded0915fd9807f302f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: handle region split failure in filter_out()
> 
> This commit fixes a bug in the DAMON kunit tests where test execution
> continued even if a region failed to split as expected. By exiting early
> when the number of regions does not match expectations, it prevents
> dereferencing invalid pointers and potential memory corruption.
> 
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 322a295ac2cec..eddf3a0484583 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1365,6 +1365,8 @@ static void damos_test_filter_out(struct kunit *test)
> >  	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
> >  	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
> >  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> > +	if (damon_nr_regions(t) != 2)
> > +		goto out;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it shares the exact same logic
> flaw fixed here.
> 
> In mm/damon/core.c:damon_apply_min_nr_regions():
> 
> 		damon_for_each_region_safe(r, next, t) {
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
> 		}
> 
> If damon_split_region_at() fails to allocate a new region (e.g., due to memory
> pressure), it leaves r unmodified. However, the inner while loop
> unconditionally executes r = damon_next_region(r).
> 
> If r was the last region in the list, damon_next_region(r) will return a
> pointer derived from the list head (&t->regions_list), resulting in a fake
> damon_region pointer. The loop then evaluates damon_sz_region(r) on this fake
> region, reading garbage memory.
> 
> If the garbage evaluates to a size greater than max_region_sz, it will invoke
> damon_split_region_at() on the fake region.
> 
> Can this lead to an out-of-bounds write and list corruption, or an infinite
> loop lockup if allocations keep failing?

This is a known issue that I'm separately working on.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717143445.91207-1-sj@kernel.org?part=4


Thanks,
SJ
