Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73F43F097
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336506; cv=none; b=tKVInKv8NMtK28xheikU6HvEfY3DQ+pkSCRplcLThNOB6Ct1oTDSj+wzKy9pvjiPqKR2YfwKFUUlMMF0nXT7oPFzhoXHlUhKufTuZqbdgCsZecBL5IDuHOm3SgvmbTbWIT24HR2vWnveIv3uY/s7zuilFNQ2S9XA4eNz4wdMpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336506; c=relaxed/simple;
	bh=fV4E1r4Eht3N1ZXPefjcLMnZLMQ6KbKvp7iqr8Q1Mxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcQtDlGT5BiG8S7n9yF7K77U8NtKt4XNhad/DEcWmyTBVHqTCz07rOszmyTRnTI7Fy77RKmsdrQeQ46q1D7eqjrhb45itTKDuYwU4mxfeVP8tvjSJc+afaWTDQzyIdITFq6udRWMYQJcatLRfb3yvZUeKtome6k0+3W4SDaQqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgCGGk6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgCGGk6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8BD1F000E9;
	Sat, 18 Jul 2026 01:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336505;
	bh=HtinoZj+A5IbfXZgUmhDBbirpbrVx47VPncHO4/qn50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XgCGGk6PUuhmQa33q7OPRAQWQ2sy+i82Yy9pyp8XuEOQaJRL57Yib1vPrarbf2QGC
	 bcIHmI/+K9pKhcx47fRaywel7Kk8s9RUsV2vVmnXJtfiY+OjSgrYXoapWlvRzGbR6y
	 SBU5umDDeNcr5s5WwU7dCYE8kIguVsUgDhRJbjeaFOpnwsNcpSDU6wyQwhDHqwEhJQ
	 s91uFEUuuvOpxlJ1VJAY2Txd59dXQUr7A4XdN+KukENoAxqypU90Zydrm8zrLiIK/o
	 wLdMSDJ/KbiwALSNrj2GwOFmgpaoJttq9umDASSAU+x4Nh3Hy+hYgIsVdae8IZozTi
	 IK/zHAOv0MHsw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 5/7] mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
Date: Fri, 17 Jul 2026 18:01:37 -0700
Message-ID: <20260718010138.90134-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718002544.2C7741F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 00:25:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] If `damos_commit_dests()` fails to allocate the `weight_arr` array, it returns `-ENOMEM` but leaves the `dst` context partially modified with a NULL `weight_arr` and an incorrect `nr_dests`, leading to a NULL pointer dereference during DAMOS scheme execution.
> - [Medium] Missing out-of-bounds array bounds checks in the test functions `damos_test_commit_quota_goals_for()` and `damon_test_commit_target_regions_for()` when iterating over tested items.
> --
> 
> --- Patch [5]: [PATCH 5/7] mm/damon/core-kunit: skip wrong dest walk in commit_dests_for() ---
> commit 937f902e215bffeba8d97bcc0725b5bfbb643c41
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
> 
> This patch fixes a potential out-of-bounds access in the KUnit tests for
> damos_commit_dests(). It exits early in damos_test_commit_dests_for()
> if the expected number of destinations does not match the actual number.
> 
> Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index eddf3a0484583..9b8c20a50ad53 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1008,6 +1008,8 @@ static void damos_test_commit_dests_for(struct kunit *test,
> >  	skip = false;
> >  
> >  	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
> > +	if (dst.nr_dests != src_nr_dests)
> > +		goto out;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the function being
> tested, could damos_commit_dests() leave the destination context in a
> corrupted state on allocation failure?
> 
> If kmalloc_array() fails to allocate weight_arr, it returns -ENOMEM but
> leaves dst->weight_arr as NULL without resetting dst->nr_dests:
> 
> mm/damon/core.c:damos_commit_dests() {
> 	...
> 		dst->weight_arr = kmalloc_array(src->nr_dests,
> 			sizeof(*dst->weight_arr), GFP_KERNEL);
> 		if (!dst->weight_arr) {
> 			/* ->node_id_arr will be freed by scheme destruction */
> 			return -ENOMEM;
> 		}
> 	}
> 	...
> }
> 
> Would a subsequent execution in damos_va_migrate_dests_add() dereference this
> NULL array when iterating over dst->nr_dests, leading to a system crash?

Yes, and another patch in this series fixes it.

> 
> [Severity: Medium]
> This is a pre-existing issue, but does the same out-of-bounds array access
> vulnerability exist in other test functions in this file?
> 
> Similar to the fix applied here, the loops in
> damos_test_commit_quota_goals_for() and
> damon_test_commit_target_regions_for() iterate over items without bounds
> checking, only verifying the length after the loop completes.
> 
> For example, in damos_test_commit_quota_goals_for():
> 
> mm/damon/tests/core-kunit.h:damos_test_commit_quota_goals_for() {
> 	...
> 	damos_for_each_quota_goal(goal, &dst->quota) {
> 		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
> 		...
> 	}
> 	...
> }
> 
> Could these loops exceed the bounds of arrays like src_goals[] or
> expect_start_end[] if the tested function produces more elements than
> expected?

Yes, and another patch in this series fixes it.

> 
> >  	for (i = 0; i < dst.nr_dests; i++) {
> >  		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
> >  		KUNIT_EXPECT_EQ(test, dst.weight_arr[i], src_weight_arr[i]);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260718001442.87129-1-sj@kernel.org?part=5


Thanks,
SJ
