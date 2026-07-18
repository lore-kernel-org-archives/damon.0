Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546217BB21
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336136; cv=none; b=qTm9Dsggv3MJw2Bb9J2s43kcJIyNbvrapIOVjnh6q2iRsC3XpZv73rOArqUXly2fUVlLy/7mZaeDA/N3dJ20ylGQm6cod01KTsY+WSYEWn+X3kRA6jpMcEcVoSro+DTh0PMQ5S+6h1ZpJRY7vwRcgqqc4vCr0ApfUwbe174bpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336136; c=relaxed/simple;
	bh=aLEmP1bHtAH6ydGIsEooaB1/5NSHZTTVPYgFiMkJ6ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx5YelVSgunFvjY2329bL0bvCm26ix9zVo5v7IXLexK0dNU6AQaDo5z04+zg6Fz1vIYeD7xq0FF0qwgG5/eefgG/jI+dEfYjrN4gx2azy8Ci4s6ZUZCn/qBm3NVlQ9dLhz//mvkCbCTB3yDCzDFwa3j8mhTaqN78pzQWRNoHRGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6k98dCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6k98dCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B6D1F000E9;
	Sat, 18 Jul 2026 00:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336135;
	bh=Obufe059moG/hLedH4mbxDex9NkdfrTAXRuS/YuCHIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6k98dCefz/VH74gQv5QXWPqevLBBLxGBqOB1QWJw36rThMB6HON7uR9iIkPi3o9h
	 jtRGxNedxfafTaNbeHElJ9Ki3kHSwosjv9JVKbg0tUN+DjnUe+788o7hjNgF3qNZLH
	 WBc5ynkC9d3toZ4HeRdqcTuOvdXBCPEgR5/BflP2lzci8JSNrJJlyTpRy3bryZLHpR
	 Rwd5xRSDG2fXaLyx2Mrbj9BKV7bHY54aD4d03Ies84uNLKkgWx0WJhLQEXLm64S8r2
	 5N54US4ULrAR0CFivQhNruFkYzSKyilRu1+V8wJaZdbvfCGRSPlhjWA7ilmihdKczW
	 1RezxY5wPtGPw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/7] mm/damon/core-kunit: check region count before testing in split_at()
Date: Fri, 17 Jul 2026 17:55:27 -0700
Message-ID: <20260718005528.89746-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718003027.0315D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 00:30:26 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Silent allocation failure inside `damon_split_region_at()` causes an improper pointer traversal into the list head in `damon_apply_min_nr_regions()`, resulting in a potential infinite loop and out-of-bounds memory corruption.
> - [Medium] The patch fixes an invalid pointer dereference upon split allocation failure in `damon_test_split_at()`, but misses an identical vulnerability in `damos_test_filter_out()`.
> --
> 
> --- Patch [2]: [PATCH 2/7] mm/damon/core-kunit: check region count before testing in split_at() ---
> commit 97ba538eacadf2d58d517d9d0f86ecaac4b3851f
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core-kunit: check region count before testing in split_at()
> 
> This commit fixes an issue in the KUnit tests where damon_test_split_at()
> could dereference invalid pointers if a region split fails to allocate
> memory. The fix tests if the number of regions was changed as expected
> and exits early upon failure.
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
> >  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
> >  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but this exact same vulnerability
> seems to exist later in this file in damos_test_filter_out().
> 
> If damos_filter_match() internally fails to allocate memory during a region
> split, the test continues and damon_next_region(r) returns the list head.
> 
> mm/damon/tests/core-kunit.h:damos_test_filter_out() {
> ...
> 	/* region started before the range */
> 	r->ar.start = 1;
> 	r->ar.end = 4;
> 	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
> 	/* filter should have split the region */
> 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
> 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
> 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> 	r2 = damon_next_region(r);
> 	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
> 	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
> 	damon_destroy_region(r2, t);
> ...
> }
> 
> Should the test also be checking the region count and returning early here,
> before we pass an invalid pointer to damon_destroy_region() and corrupt the
> slab?

This is fixed by a later patch of this series.

> 
> [Severity: High]
> This is a pre-existing issue, but I'm also concerned about silent allocation
> failures from damon_split_region_at() in core kernel paths.
> 
> Looking at damon_apply_min_nr_regions():
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
> ...
> 	damon_for_each_target(t, ctx) {
> 		damon_for_each_region_safe(r, next, t) {
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
> 		}
> 	}
> ...
> }
> 
> If damon_split_region_at() silently fails to allocate memory, it returns
> without splitting the region. The while loop then incorrectly advances r
> to the next region.
> 
> If this allocation failure occurs on the last region in the list,
> damon_next_region(r) will return the list head.
> 
> The loop condition damon_sz_region(r) > max_region_sz will evaluate memory
> located before the damon_target struct.
> 
> If those garbage values evaluate to true, could this result in an out-of-bounds
> access loop or corrupt memory? Should damon_split_region_at() return an
> error code that callers can check?

I'm separately working [1] on it.

[1] https://lore.kernel.org/20260718004301.88883-1-sj@kernel.org

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260718001442.87129-1-sj@kernel.org?part=2


Thanks,
SJ
