Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47401E511
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251433; cv=none; b=hmoN5AMRHE18anUHsM4n0d9G1yzNBHsQHVQjCq9L6V9xqM0w794HGFm27iRZ4slSmzD7PpWO+a7fM1zSNcHTSS6HHSZlrib5qGCmOL067rL/Do1S0s1/1ZvLta/x9SHbczerwTfrbvAfs75aEZ02JTHpvsIHkPAU6lFa80TekJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251433; c=relaxed/simple;
	bh=/ba2o7Uriqbv5yglZiMmgzyrd29ouKSURO5GUCgt+VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ3rVUL8IxMU3tjhmYIhsvyQrsnVqLMvqeeaWeHbNW7b5RKoslrWedkGl8wH72jea33QpuXXHBrU0Rzdf8AnX9REnvj2hYPhA6F8PPesUuyMHTDN8JOdgpNqPmjVdHNhYwbfAV63C7K2ljr1IgqnJNoCfsCmVTlitYssXFjgL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbwT1Ne2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbwT1Ne2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497D91F000E9;
	Fri, 17 Jul 2026 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784251432;
	bh=/8wXzDGL72XXvxPaV2WE/Xl4fGk5W/f4qiNq3Bl7mjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbwT1Ne2FV6uhCJ/Y458QH6WM27o0c1b8n37hR2Z/BwQzEXcTByvD3+7gk7SD3YDR
	 hBdVahitnMyqeXpmcVauCDmev5y+lU0JnaHw2Adcma8Fa5Kgu6uPEnhhvYVwieqM6W
	 d4jz4cLOlJXBrRK+JmsceNlKF/KD1fy6S6aLY6vkFYbNwvXmJcyWEdFvvH7QSdyUV3
	 4nXLHc1YcwhK/xQE7vvmVqdccC2u3eMnBLxEtIQgkwScWVrr6Kq4k53ZtbfrmAbAdi
	 zLSoTXASknJcjx3BuVFc7gy6zYJw7I/BHfE6V5GZmrNmbb+iTGzv5ygHdUsFpIUb6h
	 lqGbbOQjgLlUA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
Date: Thu, 16 Jul 2026 18:23:43 -0700
Message-ID: <20260717012345.121121-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717004433.98CBC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 00:44:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Missing error check in `damon_test_commit_target_regions_for()` leads to an out-of-bounds read if `damon_commit_target_regions()` fails.
> --
> 
> --- Patch [6]: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals() ---
> commit 9bf8891739c4d265498b06b272b3083da8b65ed2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
> 
> This commit fixes an out-of-bounds access in
> damos_test_commit_quota_goals_for() by verifying the number of quota goals
> matches the expected amount before traversing them. This prevents test setups
> from crashing if damos_commit_quota_goals() creates an unexpected number of
> goals.
> 
> Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org
> 
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
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
> This is a pre-existing issue, but since this patch fixes this exact pattern 
> for quota goals, does damon_test_commit_target_regions_for() need a similar 
> fix for target regions?
> 
> If damon_commit_target_regions() fails (for example, due to a memory 
> allocation failure), it returns an error code and leaves dst_target's 
> regions unmodified. The test code currently ignores the return value and 
> blindly iterates over dst_target:
> 
> mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for() {
> ...
> 	damon_commit_target_regions(dst_target, src_target, 1);
> 	i = 0;
> 	damon_for_each_region(r, dst_target) {
> 		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
> 		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
> 		i++;
> 	}
> ...
> }
> 
> In a case where the original number of destination regions is larger than 
> the number of expected regions, could this loop execute more times than the 
> size of expect_start_end[] and cause an out-of-bounds read on the stack array?

Yes, and that is fixed by another patch in this series.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717003022.119437-1-sj@kernel.org?part=6


Thanks,
SJ
