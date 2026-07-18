Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A11862
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336441; cv=none; b=kMXSDpl3q6yGNAzvcs+gqi9d0h29NjPQVZo0rHwU+KhUHog3iC4jZIuxqh/a6ZfPNTCGGdb/SHUmkCxz4PO88SO2jjuQKKWdVE/IZnAw4w7yvh5j6u5I+T9K5wcHjq5rnMg3KMAT1AeCBa8xJ343xm3/LciUgwYm6Q0gzCojYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336441; c=relaxed/simple;
	bh=v8Oi1a10FIdXS8JiTQyV6ObZwMJPZx7gcpYHk7yH9Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXW+xfohKikIjhk8ecF1HEWijgCS33J9yY7GFAkRYMU6G6qgS1TIGM94mVwb4z93utnvMeZB5msGiRtrTJGJnhiAZ8WrQv3POFQqmdoyR8vRGTg1mVfA4NeTbBx3xxsYIKUO1HwOVT1QBvzWFeNC2adtmNh2h5/Tu/qjWGrMx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1oKGCyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1oKGCyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CA71F000E9;
	Sat, 18 Jul 2026 01:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336440;
	bh=05lNeTSef9I9OQj3/7jQGSixXw3dvNN5Sh0Dq8hFmsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1oKGCyZvErXWIK97lYnKfWgxQPA4IR6yqWA5lLX25kMAfAIAfdltHD44Rcw+XfaO
	 41A/dP4j5iyNmJXKFgOKtcC6WIBp//2KE7OVlqWcywdXqUYX4jhe2cMPmFZ2/xvK1+
	 P1RqjDuBA/SJt/VMplU+n6gtAyl8M8uu7/TngeD+KhdyMu3RbvqQCB0YJdE/Hxbk2n
	 PfbBQvVyliUXy63YGNhU9BGLIznwDO/+CC0DvIRqGycdP2XgkyHVdMvbn+h4T/GEuh
	 yWeomGBmjgq1aPX2HfjJ78JzWYETPQGKj7fsrT0iWEVhLhkj6AVOXrMPzuTPF1ErV0
	 YDuH+VPWIHB3w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Fri, 17 Jul 2026 18:00:30 -0700
Message-ID: <20260718010031.89993-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718002910.611AE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 00:29:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] In `damon_apply_min_nr_regions()`, `damon_split_regions_of()`, and `kdamond_split_regions()`, if `damon_split_region_at()` fails to allocate memory for a new region, the loop variable `r` is still unconditionally advanced to the next region. This leads to iterating past the end of the region list, reading from out-of-bounds memory, and potentially causing memory corruption.
> --
> 
> --- Patch [4]: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in filter_out() ---
> commit 8274c3713b297d606d32992612a8cbd24ac04759
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: handle region split failure in filter_out()
> 
> This commit modifies the kunit test damos_test_filter_out() to add early
> exit checks when damon_nr_regions() does not return the expected value. This
> prevents the test from dereferencing invalid pointers if
> damon_split_region_at() fails. It fixes memory corruption that could occur
> during test runs.
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
> >  	r2 = damon_next_region(r);
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a similar pattern in mm/damon/core.c
> where damon_split_region_at() failures might not be handled safely.
> 
> In damon_apply_min_nr_regions():
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
>     ...
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
>     ...
> }
> 
> If damon_split_region_at() fails to allocate memory due to memory pressure and
> silently returns, does the unconditional call to damon_next_region(r) advance
> past the end of the list?
> 
> If `r` was the last region in the target's list, could `r` become the list head
> and point to memory before the struct damon_target?
> 
> If so, the condition while (damon_sz_region(r) > max_region_sz) could read
> from out-of-bounds memory.
> 
> If the resulting garbage size exceeds max_region_sz, it might call
> damon_split_region_at() on the invalid pointer, which could then corrupt the
> heap by writing to r->ar.end.

Yes, I'm separately working [1] on it.

> 
> The same pattern appears in damon_split_regions_of():
> 
> mm/damon/core.c:damon_split_regions_of() {
>     ...
> 			damon_split_region_at(t, r, sz_sub);
> 			sz_region = sz_region - sz_sub;
> 			r = damon_next_region(r);
>     ...
> }
> 
> And also in kdamond_split_regions():
> 
> mm/damon/core.c:kdamond_split_regions() {
>     ...
> 				damon_split_region_at(t, r, sz_sub);
> 				sz_region = sz_region - sz_sub;
> 				r = damon_next_region(r);
>     ...
> }
> 
> Can these paths also wrap around the list and cause out-of-bounds accesses
> during memory pressure in the kdamond thread?

No, the above two cases are hallucinations.  The example code snippet is
different from the real ones.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260718001442.87129-1-sj@kernel.org?part=4

[1] https://lore.kernel.org/20260718004301.88883-1-sj@kernel.org


Thanks,
SJ
