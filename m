Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A541C2F2
	for <damon@lists.linux.dev>; Mon, 13 Jul 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954085; cv=none; b=n1RUkFeVYKAN7s+YtsU6zW6ZJQLEpKIKQQ3VmDGJrScGsL+6686mLpZttqLrNg0bF+bIZL6t874RC2KSNdxxH8fiFQBudfUqMX5mb8laFbJuxRW9CoKx3aUNKHdg4sOg/WBOSXNczQQ0FRIELu6bnKnUYXHLkY3iXU9mte6EG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954085; c=relaxed/simple;
	bh=0cY+TH2orxVeilb1agNyF3KgsT/Pz85auiOitqglEgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKceQdE0yKYb31IcEyprnLQLKFSUN3Yz6tmoF/J8ly2uI0NH5rchQVk/eckAsmowU/iUJHWC5JPiQKTz2tBZjNHJ2FYrptZhyZn6T3g39cTX+z/xHT3nf+kL/ZnKV+tGuwMxa2BHEZXe9oBrh5WM+OxdTRZs4qJ8566urfsnFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWays48u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWays48u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA161F000E9;
	Mon, 13 Jul 2026 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783954084;
	bh=hBMk+fOlbJveogE5re7Nn/FoZf0Nt5Qg/hMm8UtTlqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWays48uss6rKi2IvsNsXOsLIVRKL6/+5hovBovlBDxHQSUlG7hm6FcXcazfjvS1I
	 VkkC3R/eawR9fGyolV0NaaPB667l2G3WEjFFkz8EAM7hgZy5+kR2UyX3U2+EpSeXvG
	 ZqZ67CpJkNu6phRsAwfnSzYmUKyL7ZJX6hGDEmH8SbcPjrR0trrnJqCIPiB1AxHhAP
	 xdDxnTEq9gimCNIN+Xls6MN/jA8+VS1t9+35kvYWD0JrcL3pFAX/07WbHt2PemXA6f
	 8FODpmlV/WseKuYo8eVvU1CCjJYCfCvTKY/VU0hVs7Xh/TO9FkPuuCQrUkvttssRHC
	 DbS5wn0CVPZ9Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 2/5] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Mon, 13 Jul 2026 07:47:55 -0700
Message-ID: <20260713144757.39740-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713140806.D0CC61F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 13 Jul 2026 14:08:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the fix is incomplete. The exact same vulnerability (NULL dereferences or out-of-bounds array accesses upon test expectation failure) exists in several other DAMON KUnit test functions. The patch correctly notes that `KUNIT_EXPECT_EQ()` does not abort execution, leading to NULL dereferences if subsequent code assumes the expectation was met. However, identical brittle patterns exist in `damon_do_test_apply_three_regions()` (which dereferences the result of `__nth_region_of()` without checking for NULL), `damos_test_commit_dests_for()` (which loops over `dst.nr_dests` and can dereference a `NULL` `src_node_id_arr`), and `damos_test_commit_quota_goals_for()` / `damon_test_commit_target_regions_for()` (which iterate based on the destination's size and can read out of bounds from the source arrays).
> --
> 
> --- Patch [2]: [RFC PATCH v1.2 2/5] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of() ---
> commit 5b98cb20c5802f828e4e3cf09a813b6c47d58774
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
> 
> KUNIT_EXPECT_EQ() does not abort the execution of test code when the
> expectation is not met.  But damon_test_merge_regions_of() code after
> its initial KUNIT_EXPECT_EQ() call assumes the expectation is met.
> 
> Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 6ad73559dd8ea..a99363720e677 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >  	damon_merge_regions_of(t, 9, 9999, ctx);
> >  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
> >  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
> > +	if (damon_nr_regions(t) != 6)
> > +		goto out;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this fix need to be
> applied to several other DAMON test functions that follow the same pattern?
> 
> If a test expectation fails, these functions also assume the expectation
> was met, which can lead to NULL pointer dereferences or stack out-of-bounds
> reads.
> 
> In mm/damon/tests/vaddr-kunit.h:damon_do_test_apply_three_regions():
> 
>     for (i = 0; i < nr_expected / 2; i++) {
>         r = __nth_region_of(t, i);
>         KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
> 
> If damon_set_regions() leaves fewer regions than expected,
> __nth_region_of() returns NULL and r->ar.start dereferences it.
> 
> In mm/damon/tests/core-kunit.h:damos_test_commit_dests_for():
> 
>     for (i = 0; i < dst.nr_dests; i++) {
>         KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
> 
> If dst.nr_dests is greater than src_nr_dests, it can access
> src_node_id_arr[i] out of bounds (which can also be NULL).
> 
> In mm/damon/tests/core-kunit.h:damos_test_commit_quota_goals_for():
> 
>     damos_for_each_quota_goal(goal, (&dst)) {
>         KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
> 
> This iterates over dst's goals without verifying against nr_src_goals,
> potentially accessing the src_goals stack array out of bounds.
> 
> In mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for():
> 
>     damon_for_each_region(r, dst_target) {
>         KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
> 
> This blindly loops over dst_target's regions, leading to potential
> out-of-bounds reads on expect_start_end if it exceeds nr_expect_regions.
> 
> Could these functions be updated as well to prevent the test suite
> from oopsing on expectation failures?

I didn't check each one, but sounds right to me.  I will further check and work
on those later.

> 
> >  	for (i = 0; i < 6; i++) {
> >  		r = __nth_region_of(t, i);
> >  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
> >  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
> >  	}
> > +out:
> >  	damon_free_target(t);
> >  	damon_destroy_ctx(ctx);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713135838.32730-1-sj@kernel.org?part=2


Thanks,
SJ
