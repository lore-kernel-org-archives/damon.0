Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9947CC9E
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039043; cv=none; b=JZCW87hRG/EH69uNilUXaIzHYvQsd5zhn/hsLcDztrp34ZKcqgQCuROIVd62zMu06xfJ5su0DbcPSl7YLmgbML/rel9zXvQ83gmYfdc6AlA413YuXq+yx5/JLqhBdJO9txdlpsmU4BRXrhMEv1QAAnoN1LpN900fk0C2gX6WGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039043; c=relaxed/simple;
	bh=jDImtieConR/gc3t5zE3ej5sOTqsz37LAkx8ABU41CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5aXT3plNAkp/U7N7/J5YwpZLBNVrhWeIOrOt4JB5VdPfIzRXvnzGy5aTMcasRtbNTos3Rmb/2jq3UBeRrzrm9NE8FR4v8zcyO9WO60bT+mbax5EtBxYbVDFi4Egk5aJdOI37aGJdlfCzRUp/kCj3UJAffXGvph0h6xyOgUNH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF3H46X7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF3H46X7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0201F000E9;
	Tue, 14 Jul 2026 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039041;
	bh=C0DkRwtzrrC24UDeyxmpiknpmBnT1yebLnBmOrDt47I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fF3H46X7v2dyAI7KcrLqsNIYQfKJEd5ci/wfgQ/UbikOkvJ3GtxWXtPFNxIU7PBNK
	 K4v0vXiddj5at9jfpQvHwKiDfXgFyF+Gg1Nszw8SQZTIfXwe42FAmFNWA9TOkNXymf
	 RHaaUJQus43Dea1SdPesIu6B9EQEKPnUc+zrNonk6rFhcAov80WfZ0AEz+0CI1PBVK
	 GnZsSQaKohv0RCyI/291qNMbMe/ZvMJcZWRMEd53qnw2Td9wojg/5NZxgzw7Hmrrfb
	 PiuznTfp/mQnRiFF3M10ZMj9d3icFt2iZgPGJtlP70kpTVoiMgDF/bgr3gJgNcHeaX
	 UVFkoemutKLQg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/5] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue, 14 Jul 2026 07:23:51 -0700
Message-ID: <20260714142352.100478-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714140146.1A77C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 14:01:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch attempts to fix a crash where unit tests continue execution despite a failed KUNIT_EXPECT_EQ() condition and misses several identical vulnerable patterns in the same file. In multiple other test functions, if a tested function fails and the KUNIT expectation is not met, the tests will continue and perform out-of-bounds array accesses or invalid list traversals leading to slab corruption.
> --
> 
> --- Patch [2]: [PATCH 2/5] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of() ---
> commit 951f8b5681b80f05d0ef2d36767a3d72e546ac33
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
> 
> This commit addresses a panic in damon_test_merge_regions_of(). If the initial
> KUNIT_EXPECT_EQ() expectation is not met, the code previously continued executing
> a per-region test assuming the incorrect hard-coded number of regions, leading
> to a NULL pointer dereference. The fix catches the expectation failure and
> skips the per-region tests.
> 
> Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 485472ddebd19..eba643762132f 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >  	damon_merge_regions_of(t, 9, 9999, ctx, true);
> >  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
> >  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
> > +	if (damon_nr_regions(t) != 6)
> > +		goto out;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while addressing the crash
> here, could we also fix identical pre-existing regressions in the rest of this
> file?
> 
> In several other test functions, if a tested function fails and the
> KUNIT_EXPECT_EQ() condition is not met, execution continues and causes
> out-of-bounds array accesses or invalid pointer dereferences.
> 
> For example, in damos_test_commit_dests_for():
> 
> 	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
> 	for (i = 0; i < dst.nr_dests; i++) {
> 		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
> 
> If dst.nr_dests is larger than src_nr_dests, doesn't this loop read out
> of bounds on src_node_id_arr[]?
> 
> Similarly, in damon_test_split_at() and damos_test_filter_out():
> 
> 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> 	r2 = damon_next_region(r);
> 	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
> 	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
> 	damon_destroy_region(r2, t);
> 
> If the split fails and there is only 1 region, does damon_next_region() return
> an invalid pointer for the list head? If so, passing it to
> damon_destroy_region() could lead to slab corruption.
> 
> A similar pattern also exists in damon_test_commit_target_regions_for() and
> damos_test_commit_quota_goals_for(). Should similar expectation checks and
> early exits be applied to these functions to prevent kernel panics during test
> failures?

Same class of issues were reported before, and I'm separately working on this.

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
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714135236.92699-1-sj@kernel.org?part=2


Thanks,
SJ
