Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FFE54B
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251123; cv=none; b=VBds2TJyVnIHE+QtTZyrezZzQd10l2FyW+5Rr5OXsi2ulpSvP6QwLVJiYRZUMbCm2kUJcXam4qB6QO7MR4QzefcrRsJDcRJC/aGlMvmToR29DIrxFrDLGIIL/pmEt5EMyOZRXzjnEKwZz+ZvMyJtfoSEkBzQ/PcbCY9q0ZhmEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251123; c=relaxed/simple;
	bh=EcRV8dgL3ZU67hAhYD4RY1suGVXMah5Dd3yBLoMmJdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jK00Httf1QuSrsX60R4kQKlMuGnGpO4eKv2hv/dbpoHaSHFvB/K7ZhDZL99LiDkggRfkuo7Um54Fa2gHjQKTDDtpkqXrDN6U1lL5hqMvZkAhNVSvRgOPwC7SS3XUjWY7XhfDswCEahXZFZUDaNTwWnZa/WVzum816Py03826Ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA2NvTzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA2NvTzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774401F000E9;
	Fri, 17 Jul 2026 01:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784251121;
	bh=eA9UFMIfF6HTa5d58DoWCQ3zj4lbu3L2rOZgNoIUEoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hA2NvTzb8eH1LphcEm+LyW6KL674FOUXyvYLCvymiMlxKY/ffSuv0bwODdLawqexY
	 oc8K3E6gZRYsdr9JTSgtI5fHGKccklb/DyhhB87rQLOaYGjkPoenqoB8rv6nnbYUVy
	 kA+bui0ztonVBQo7nNjsU+Q0Cn7e4tbaguvU9fDGqFt2d/SDuNH9gQzYvEhbsERL2n
	 7YYvV9YZCWQY95BBSULqeGx+QqpQttwxJuHkhZO2PzCDJ38LouckzfioXIaP4tp5z8
	 yoOjtmNVndl9IV50FHvqs0CPMvMpR9I94sUAEjlZggTici6bkRqvgtd66p6Y84NA1N
	 eySot3EnLTyaw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/7] mm/damon/core-kunit: check region count before testing in split_at()
Date: Thu, 16 Jul 2026 18:18:32 -0700
Message-ID: <20260717011834.120715-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717004417.9F9F31F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 00:44:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Kernel memory corruption in `damon_apply_min_nr_regions()` due to unhandled split failure.
> - [Medium] Incomplete test fix for memory allocation failure in `damos_filter_match()` leading to test crash.
> - [Medium] Missing upper bound checks in test loops leading to Out-Of-Bounds array reads.
> --
> 
> --- Patch [2]: [PATCH 2/7] mm/damon/core-kunit: check region count before testing in split_at() ---
> commit c03465ac93de9ac544447d782c3c2ea15bf60ab1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: check region count before testing in split_at()
> 
> damon_test_split_at() tests the next region that is assumed to be created by
> damon_split_region_at(). But the split might fail. In this case, the test is
> updated to check if the number of regions changed as expected and exit early.
> 
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index eba643762132f..322a295ac2cec 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -155,6 +155,10 @@ static void damon_test_split_at(struct kunit *test)
> >  	r->age = 10;
> >  	damon_add_region(r, t);
> >  	damon_split_region_at(t, r, 25);
> > +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> > +	if (damon_nr_regions(t) != 2)
> > +		goto out;
> > +
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but it looks like the exact
> same pattern being fixed here is present in damos_test_filter_out().
> 
> If damos_filter_match() fails to allocate memory, it returns without
> splitting the region. The test logs a failure for the region count mismatch
> but execution continues unconditionally:
> 
> mm/damon/tests/core-kunit.h:damos_test_filter_out() {
>         /* filter should have split the region */
>         ...
>         KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
>         r2 = damon_next_region(r);
>         ...
>         damon_destroy_region(r2, t);
> }
> 
> Since r is the only item in the list, does damon_next_region(r) resolve to
> an out-of-bounds pointer that is then passed to damon_destroy_region(),
> causing list and slab corruption during test execution?

That's what fixed by a later patch of this series.

> 
> [Severity: High]
> This is a pre-existing issue, but since we are handling split failures in 
> the tests, does mm/damon/core.c:damon_apply_min_nr_regions() suffer from a
> similar problem in production code?
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
>         damon_for_each_target(t, ctx) {
>                 damon_for_each_region_safe(r, next, t) {
>                         while (damon_sz_region(r) > max_region_sz) {
>                                 damon_split_region_at(t, r, max_region_sz);
>                                 r = damon_next_region(r);
>                         }
>                 }
>         }
> }
> 
> If damon_split_region_at() fails to allocate memory, it silently returns. 
> The loop then unconditionally advances r = damon_next_region(r). If r was 
> the last region, this returns a bogus pointer derived from the list head. 
> 
> The loop condition damon_sz_region(r) then evaluates garbage memory. If it
> happens to evaluate to greater than max_region_sz, the loop re-enters and
> passes the bogus pointer to damon_split_region_at(). Could this lead to
> out-of-bounds writes and list corruption under memory pressure?

Good finding, not necessarily a blocker of this series.  I will separately work
on this.

> 
> [Severity: Medium]
> This is also a pre-existing issue, but while reviewing the kunit tests, I 
> noticed several test loops lack upper bound checks against the destination
> counts. 
> 
> For example, in damos_test_commit_dests_for():
> 
> mm/damon/tests/core-kunit.h:damos_test_commit_dests_for() {
>         KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
>         for (i = 0; i < dst.nr_dests; i++) {
>                 KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
>         ...
> }
> 
> If the code under test incorrectly leaves dst.nr_dests greater than
> src_nr_dests (for instance, when src_nr_dests is 0), the loop iterates out 
> of bounds and dereferences src_node_id_arr[i]. 
> 
> The same unbounded iteration pattern appears to exist in 
> damos_test_commit_quota_goals_for() and damon_test_commit_target_regions_for(). 
> Could these also be fixed to prevent out-of-bounds reads during test failures?

Those are fixed by the later patches of this series.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717003022.119437-1-sj@kernel.org?part=2


Thanks,
SJ
