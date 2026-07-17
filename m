Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FE3033E3
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300160; cv=none; b=iSNQDvFHh1kUIWiXq7DucqLjykuFv0SzbJM6YBAB/tC69Xt8a1THZTL0etYoUuFi05BTcKQw9PveB8o/an/6jxJ1gQbZi+R5JF5kRQvo4FY43PoHd+rkUteqj0wKIozOz6a+FMlrjUg+/KXKfD73g+1G3NuAd3VZ7oTf9Gz40pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300160; c=relaxed/simple;
	bh=xLvnQFAR/Uzn5ZdmiPCigeS3pBrbKB9xnysCFUov0QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxepvY/N7E9FLI1KVf7l3BPYtCpnOgxDUIPtsh1fbfDPFjEGlmGOEYpUXLyQfHTO4DkrHRPLBf2b+izyXMKmQiVanp47Ckkd4HGftbTFNabyQhINgClBPjN/b5GPxe/8mGYDgTwNxUUKaVHhKMLyDupPnLSQhpJLm1ZcTOD24BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/mqCXt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/mqCXt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D251C1F00A3A;
	Fri, 17 Jul 2026 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300157;
	bh=lx2OWW9xi5t88z/iouK2QZwEdQwgue7mQFDRl+wdwZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/mqCXt/NfjX4GOcYJ/vvRRJBmk99lh+N59Xpvlbt+rkQ3CBh+5Cr4CVgy6uz0VAq
	 Wnmgey45AnJceMlFlVIkPZxmVjqEPJWiArbd/J0EULY9kIgBw4dSzL3SY7kIQaPwhO
	 AsmhBMcjec2uVfRR1itGkiIjptzwhM5zQXpOog/wW7FQS2WFJvPFcg6MD2HlyDTZu2
	 46kUqmytL4vrU0aE0Txg0Gxbc+Ux0R994GhBqm2oYCYfxYCqbDEvLK5Jju23zJdx7w
	 LTf8AQRsaFBWP0cRJ5B31CUuAJP76XhSFKjW/R9CRpZUPCoN7JhrsxksD6eoVj/9hT
	 vCt3g1c3ueGvw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 3/7] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Fri, 17 Jul 2026 07:55:49 -0700
Message-ID: <20260717145551.92109-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717145050.1D6331F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 14:50:49 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Out-of-bounds array read in KUnit test helpers due to missing array bounds check and ignored return values
> --
> 
> --- Patch [3]: [RFC PATCH v1.1 3/7] mm/damon/vaddr-kunit: check region count in three_regions test ---
> commit b2d38d564a3004fa6df02a9f1d54af3423302437
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr-kunit: check region count in three_regions test
> 
> This commit adds a check in damon_do_test_apply_three_regions() to ensure
> damon_set_regions() succeeded in setting the expected number of regions.
> This prevents a potential NULL pointer dereference during test iteration.
> 
> Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > index 61f844336ffb5..6a95441d193ae 100644
> > --- a/mm/damon/tests/vaddr-kunit.h
> > +++ b/mm/damon/tests/vaddr-kunit.h
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing this test fix, I noticed
> similar missing bounds checks and unhandled return values in
> mm/damon/tests/core-kunit.h that can cause out-of-bounds array reads.
> 
> In damon_test_commit_target_regions_for():
> 
> 	damon_commit_target_regions(dst_target, src_target, 1);
> 	i = 0;
> 	damon_for_each_region(r, dst_target) {
> 		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
> 		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
> 		i++;
> 	}
> 
> If memory allocation fails inside damon_commit_target_regions(), it returns
> an error without modifying dst_target. Because the return value is ignored
> here, could this iterate over the original regions of dst_target and read
> past the end of the expect_start_end stack array?
> 
> A similar pattern appears in damos_test_commit_quota_goals_for():
> 
> 	damos_commit_quota_goals(&dst, &src);
> 
> 	i = 0;
> 	damos_for_each_quota_goal(goal, (&dst)) {
> 		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
> 		KUNIT_EXPECT_EQ(test, goal->target_value,
> 				src_goals[i++].target_value);
> 	}
> 
> Does ignoring the return value of damos_commit_quota_goals() risk an
> out-of-bounds read on src_goals[] if the destination goals are not updated
> and retain more items than expected?
> 
> Finally, in damos_test_commit_dests_for():
> 
> 	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
> 	for (i = 0; i < dst.nr_dests; i++) {
> 		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
> 		KUNIT_EXPECT_EQ(test, dst.weight_arr[i], src_weight_arr[i]);
> 	}
> 
> Since KUNIT_EXPECT_EQ does not abort test execution on failure, could an
> out-of-bounds read occur on src_node_id_arr[] and src_weight_arr[] if
> dst.nr_dests ends up larger than src_nr_dests?

These issues are fixed by other patches in this series.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717143445.91207-1-sj@kernel.org?part=3


Thanks,
SJ
