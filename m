Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499E13635E
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336552; cv=none; b=Un4633p7XkS2aPdY/vxdZX+0iw+89RcvL2jjPDTz9aytvpN8dK3LgkfhT0bFuU1YIEJdv50WB1N+anX3t6pf/xo55jncWaV7F0E5ZqExXgYNcKelwihDLOzVttiOaCKGywItzHpcuU+qqD2iI0NRMBX4yQzoJ3zTlbVdl0TklKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336552; c=relaxed/simple;
	bh=Fv5HqTJfCgD+fDfVEOQW0XKtfL18hHhkvKH+4AeDSng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGLWaaH2kWWqVFCh0m8lzX59rMWVlNtltUgrOuOBGbqsdjSl5cc9G+4Bn1mswZFXmve48rG3CtFBzUc6ZaH298K8SIwOd42KvwtI1Ru/QS5iSwPTm3g1OgSMZII6KzWYWPjKHrKgj0VXAMfC2WgQL1lS64QCmQDf3KD3lrP9nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2F7sKKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2F7sKKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E6D1F000E9;
	Sat, 18 Jul 2026 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336551;
	bh=quWuGLYIZjObnsZWqZ4ffaVWmjuc740zGET1Y7ieHbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2F7sKKIjUBzFQzB9aQ0jP/DZ2IgrTZkDNaNfQNNSUdQhpaxDBYcXQ5sBaBSiUd0g
	 gNkZE8CGVjSFBqQp3rH9HpYqoL4jy8/huphQ1dKVZkH7Z6z9q4OyC/WxhUE6wAMhCo
	 O83sHutlFV9K+BRB2XOaGuDEoMHRpSCdbGbqd07ueWWOQi1H0h2/pz/Zf9u4nW1Ma3
	 4sKXel14yV/zmTGVrAuwg5TcClS9OVpuHBIXTwBiwkIs8hyofhTBVS7yVWGb2n4pEU
	 uTvLhKEnxPY3EXfNCj5GSKRS6XRQDvMOi9snfcXXHA4jDjGGC5x8deYNSNfOctcNG5
	 3NQh1Ty3+1Gbw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
Date: Fri, 17 Jul 2026 18:02:21 -0700
Message-ID: <20260718010222.90262-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718002258.6A3851F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 00:22:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Out-of-bounds array read in damon_test_commit_target_regions_for() due to missing region count validation before traversing dst_target.
> --
> 
> --- Patch [6]: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals() ---
> commit 4bcb5123bbb5f6b4908f1d776a8608ef05a89501
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
> 
> This commit addresses an out-of-bounds array access in the KUnit test
> damos_test_commit_quota_goals_for(). If the number of created quota goals
> does not match the expected count, blindly traversing them can cause the test
> to read past the bounds of the expected values array. The patch adds a count
> validation and an early exit to avoid this invalid traversal.
> 
> Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 9b8c20a50ad53..fbf986aee2dea 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -861,6 +862,14 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
> >  
> >  	damos_commit_quota_goals(&dst, &src);
> >  
> > +	damos_for_each_quota_goal(goal, &dst)
> > +		nr_dst++;
> > +	damos_for_each_quota_goal(goal, &src)
> > +		nr_src++;
> > +	KUNIT_EXPECT_EQ(test, nr_dst, nr_src);
> > +	if (nr_dst != nr_src)
> > +		goto out;
> > +
> >  	i = 0;
> >  	damos_for_each_quota_goal(goal, (&dst)) {
> >  		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but should a similar early exit
> check be added to damon_test_commit_target_regions_for() to prevent an
> out-of-bounds read?
> 
> Just like the issue fixed here, damon_test_commit_target_regions_for()
> iterates over dst_target regions without validating the region count against
> nr_expect_regions first:
> 
> mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for() {
>     ...
> 	damon_commit_target_regions(dst_target, src_target, 1);
> 	i = 0;
> 	damon_for_each_region(r, dst_target) {
> 		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
> 		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
> 		i++;
> 	}
> 	KUNIT_EXPECT_EQ(test, damon_nr_regions(dst_target), nr_expect_regions);
>     ...
> }
> 
> If damon_commit_target_regions() incorrectly leaves more regions in dst_target
> than nr_expect_regions, the loop will read past the end of the
> expect_start_end[] array before reaching the KUNIT_EXPECT_EQ count validation
> at the end of the function.

Yes, and another patch in this series fixes it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260718001442.87129-1-sj@kernel.org?part=6


Thanks,
SJ
