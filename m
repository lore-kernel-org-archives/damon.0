Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D83F9A0E
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300096; cv=none; b=oAyPUds/uMvW4TLlSf3KoHKqvwbbJJRvmz50rcOjjayiYmG0fkLu7Y2jmjOFg2rpinICtteHRTeet4I6R/WtDZWNJtzYSgXM8VjowKSnJHsRdd/VmNLK4lhD43/LvJV5DygHZrgSsBT48ccfHqJkD8+vGMESAYG97aZTLh3V5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300096; c=relaxed/simple;
	bh=46QN26aCkZfHyhF4zMYrYqkny4yjYb0Chedw9TKiIK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc8RGNRCNgeIw07pZiGRfk8R4m5j+IFnhJDaD5b7/ZtrxuwfEm/hQ6GsuNiSFdODWKm4KjSUZ+Ao11kAB4uCjHiLOTQL3nKYq5L07ZOXkQb6rjoxlFxWvavyb/nRQ8m9QPAHAUUKAzPOSI4+bSRwtu6gKyHLjaDw3Ey3ZTNsgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjiNZg1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjiNZg1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412B81F000E9;
	Fri, 17 Jul 2026 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300094;
	bh=T6Tqs/fSvbRN4c/JIZ/uNeOELaj8bZXpuuZTVGjrVuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjiNZg1N4baBM+gg770In7yKLVk3ANBjSJBQ2CrPN/O7Wv6zt75akvpgCvFcv42eJ
	 VZVdVz7b0FQ5NVdyNpd6lsvqV7pdztEN6iwIq/HU7BbEuBP2WMZqTVKNIn1ArRsUTe
	 Wf/qIb23FHcYrjpQl3PUd93pI0Mrg8OzcNDGsTfeMhHfZCX/hihQYDtGS9GhTlQB55
	 jnEGFKJSA9zjlmf1k72KXfpe313hz8M3VW0wq/a70BNx/AguqbGh1kE75aot9x4no+
	 mfpmPuUnOEZPU2Yzu/tpA8GuPOj9EI8od0tmofNcYtvueOVleY4MwZ1HqwZ0rSziri
	 evqoj7B/bfJCw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 2/7] mm/damon/core-kunit: check region count before testing in split_at()
Date: Fri, 17 Jul 2026 07:54:46 -0700
Message-ID: <20260717145447.91982-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717145156.6D5CE1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 14:51:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Severe out-of-bounds slab write and infinite kernel loop in `damon_apply_min_nr_regions()` due to unchecked `damon_split_region_at()` failures.
> --
> 
> --- Patch [2]: [RFC PATCH v1.1 2/7] mm/damon/core-kunit: check region count before testing in split_at() ---
> commit d2fdc98cf0d62ffe11b7dca50c29ff7c72e1fcd6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: check region count before testing in split_at()
> 
> This commit fixes a potential invalid pointer dereference in the kunit tests
> by checking if the region count changed as expected after a split attempt.
> Since region splits can fail, it ensures the test exits early rather than
> accessing an invalid next region.
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
> [Severity: Critical]
> This is a pre-existing issue, but since this patch correctly notes that
> damon_split_region_at() can fail, does the same unhandled failure cause an
> out-of-bounds access in the core code?
> 
> Looking at mm/damon/core.c:damon_apply_min_nr_regions():
> 
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
> 
> If damon_split_region_at() fails to allocate a sub-region under memory
> pressure, it silently returns. The loop then unconditionally executes
> r = damon_next_region(r). Since no new sub-region was created, it skips the
> remainder of the original region and advances to the next one.
> 
> If this happens on the last region in the list, r evaluates to the list head
> at &t->regions_list, pushing the region pointer out-of-bounds to
> (char *)t - 24. The loop would then read garbage bytes for the region
> boundaries.
> 
> If those garbage bytes evaluate to a size greater than max_region_sz, could
> it call damon_split_region_at() again on this invalid pointer? If a
> subsequent allocation succeeds, r->ar.end = new->ar.start could write a
> user-monitored address into the out-of-bounds slab memory, potentially
> corrupting memory 16 bytes before the damon_target object.
> 
> Additionally, if allocations consistently fail, could the fake region's next
> pointer wrap back to the first valid region and create an unbreakable infinite
> loop in the kdamond thread?

This is a known issue that I'm separately working on.

> 
> >  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
> >  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717143445.91207-1-sj@kernel.org?part=2


Thanks,
SJ
