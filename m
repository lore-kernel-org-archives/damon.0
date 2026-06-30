Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8E3AB289
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793096; cv=none; b=oysjeDm+mMwbEf9jH6O7MLdjGGccmiWvYsRFzcKRzuddhAW/TlsBzfl/8V7TmfkhD3quW3K0TAzAYkDTW73k7AarWlSK8rBmLYJ2tvoM+awMuIBULXI2shsfbslu2QwGkHPpBTJ0xrnvQEspk26WYrzBZ6hpo3kBevzL7KUoizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793096; c=relaxed/simple;
	bh=S0Qm5Je7U1n7zdv9t6iFZXlp/H/mXhkMoUUg3XrMbSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRLCo3VHvLq3c9wZmyPC8+L8fC8/joee9Wx5hvDasxu9vQk9s+8RXlSuvP80WdxbdZ1Vo/fsQFNuvIy2qDa7PLazFq+WVkUXPq5Lwb08UCcu+250qKTBMARrlZ75rIK+EGGf5PEE4Uegs4kJJ7yIEHSOJwO9pcQXScilHblzI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL1y+7oE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL1y+7oE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7441F000E9;
	Tue, 30 Jun 2026 04:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793094;
	bh=WYkI3X7NxrJc+jVKsYcsqMrTRgrwEQgFAfEvpssT5iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kL1y+7oEoNYObfaD6D+2j6m0udMmaKB2iRbglls2FLIMaqnlIPrOAg3pMLcGggi4m
	 Y+dfE0zoJDP8yswhhBQEsV+QCscVWEWN8sTK7w5HkNmS4+0iFsj/aHWm7Q0MvpnLvf
	 OtqxONKk8YhfuoZA7VpCg5NX/8XISvuxg0PxxhcdLm2P9D9b+J1Jj0oAWduThMQanA
	 Qh+x98b5vuj2smhfM4JjndKtra1u6jkqCZJkZQP+Aeh4SSnTqWimKu2DaR+iNshHIJ
	 8aYfbtu0sZYjCaVu+fTQzCpcZthkI5qY6qSbCMJM3jXYhwi5JvCIxpZadM06jWLYvA
	 UBcSSQsJyuUvA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Mon, 29 Jun 2026 21:18:06 -0700
Message-ID: <20260630041806.151124-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040828.9D1F11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:08:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The introduced validation logic in `damon_set_regions()` is flawed and fails to prevent the `WARN_ONCE` and divide-by-zero crashes it intends to fix. Distinct valid regions within the same alignment block bypass the check, leading to duplicated overlapping regions, inverted hole regions, and a kernel panic.
> --
> 
> commit 79a8d61a7b1112d3a6da1cff84b7f4a28c66e465
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: validate ranges in damon_set_regions()
> 
> This commit attempts to fix a zero-length region issue that could lead to
> a WARN_ONCE and a divide-by-zero crash in DAMON. It adds a validation
> loop in damon_set_regions() to reject empty or invalid target regions
> before they are processed.
> 
> Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
> Cc: <stable@vger.kernel.org> # 5.16.x
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 027250e43c66f..3dd2750c2ef20 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -356,6 +356,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  	unsigned int i;
> >  	int err;
> >  
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
> > +				ALIGN(ranges[i].end, min_region_sz))
> > +			return -EINVAL;
> > +	}
> > +
> 
> [Severity: High]
> This is a pre-existing issue, but does this validation fully prevent the
> divide-by-zero crash?
> 
> If a user provides two unaligned regions that fall within the same
> min_region_sz block (for example, [10, 20] and [20, 30]), this check will
> evaluate ALIGN_DOWN(10) >= ALIGN(20), which becomes 0 >= 4096. This allows
> them to bypass rejection.
> 
> Because they pass, damon_set_regions() inflates both regions to [0, 4096],
> creating identical overlapping regions in the list.
> 
> If a subsequent update covers these regions (like [0, 8192]), the
> intersecting boundaries are adjusted but first->ar.end is left at 4096 and
> last->ar.start at 0. This leads to damon_fill_regions_holes() creating an
> inverted hole region:
> 
> mm/damon/core.c:damon_fill_regions_holes() {
>     ...
> 		if (r->ar.end != next->ar.start) {
> 			newr = damon_new_region(r->ar.end, next->ar.start);
>     ...
> }
> 
> Calling damon_new_region(4096, 0) triggers the WARN_ONCE(start >= end) and
> results in a region with a negative size (ULONG_MAX - 4095).
> 
> When damon_merge_two_regions() eventually tries to merge [0, 4096] with
> [4096, 0], the combined size underflows to exactly 0, causing a panic here:
> 
> mm/damon/core.c:damon_merge_two_regions() {
>     ...
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
>     ...
> }
> 
> Should the alignment check be stricter, or does damon_set_regions() need
> additional logic to merge or reject identically aligned overlapping blocks?

Nice catch.  Apparently it is a bug tht is different from the one this patch is
fixing.  So no blocker for this patch.  I will further work on the newly found
bug.


Thanks,
SJ

[...]
