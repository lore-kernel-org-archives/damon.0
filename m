Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD12BE03B
	for <damon@lists.linux.dev>; Wed, 20 May 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285284; cv=none; b=l9L/QZ4ByR4ciLJyl+xk4rlrIg2w8q9JnrT9SESzUVZg8kGtOki6dRw6TiHAFGqtUzhLMP25pHShkR3Hpmf7tdrjjg5mJlFPKyVpGQVegVaCGh7PvkrPjH2uNamrOdTpvTP/xbN1TZxf9jJDp+SCuUCeSNEqOrLx7dEnnggp7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285284; c=relaxed/simple;
	bh=QB4YqFtFs8JIOViMl4LI8Ivkp6gRqr0gJQU2mkTxgaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDx/i96EwQJmobUYfgxzVZFDTdK6ZPAYcjEjC7Um2HgR/jWmo4+a4Whf94r5sRcgX4GAr4nuYk2oR9jqRKvtYDvdoxgGuVRjvTg4wkL+NW8iULyYBzhY+wPQRuDpRmZ93iG/ZgpbT7m/CstvG+TCtUEa65o5C3nxZEBgTVeORmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOqWKYXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOqWKYXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AFD1F000E9;
	Wed, 20 May 2026 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779285282;
	bh=xHMQ3Noyab8sb/9m6XjQKRRneT+w8N9thfvrAXYytHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOqWKYXrxXh2J98rkJpZ/HYMxKpAj3hJQAgmnWnn49ko+3xRGJGoQGHKE0KO2plKp
	 K00mcGVYz9ILWv1rFPRuG/VGjwmxhjNzvyJ+235B9WoR2twivgKHoBgEt5m6UcWTDF
	 lqyI25CI2lhju5sDoHOh55mysQJI7HyqwvsY2Lz8D2UhUd1p4g0nJjUZBP7zrwpJDy
	 Oni3fefXeJ6Wl6S/iVSyzO+LGJFmkW4Ce5R+QMYgBLe6ehYwxpyxL2FUJRYleSoEYL
	 xr6cE95a+FnnPrUS5rApQZqYK27cUToa7XuWWllxsROPQPbPCjGv9zR+d9TAMUwRo2
	 JlIXSRimrkKMw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 04/14] mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
Date: Wed, 20 May 2026 06:53:57 -0700
Message-ID: <20260520135358.169417-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520063841.7C04C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 06:38:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The dynamically allocated `ranges` array is never freed, resulting in a memory leak.
> - [Medium] The return value of `damon_set_regions()` is ignored, which can lead to a NULL pointer dereference if memory allocation fails.
> --
> 
> commit 178b94e956635731d61e076b1aa09699c5f9b686
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/vaddr-kunit: replace damon_add_region() with damon_set_regions()
> 
> This commit updates the DAMON vaddr unit tests to use damon_set_regions()
> for setting up target region boundaries. This replaces the manual setup
> loop that previously used damon_add_region().
> 
> > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > index 98e734d77d517..23be9c3be75fa 100644
> > --- a/mm/damon/tests/vaddr-kunit.h
> > +++ b/mm/damon/tests/vaddr-kunit.h
> [ ... ]
> > @@ -132,20 +132,24 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
> >  				unsigned long *expected, int nr_expected)
> >  {
> >  	struct damon_target *t;
> > +	struct damon_addr_range *ranges;
> >  	struct damon_region *r;
> >  	int i;
> >  
> >  	t = damon_new_target();
> >  	if (!t)
> >  		kunit_skip(test, "target alloc fail");
> > +
> > +	ranges = kmalloc_array(nr_regions / 2, sizeof(*ranges), GFP_KERNEL);
> > +	if (!ranges) {
> > +		damon_destroy_target(t, NULL);
> > +		kunit_skip(test, "ranges alloc fail");
> > +	}
> >  	for (i = 0; i < nr_regions / 2; i++) {
> > -		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> > -		if (!r) {
> > -			damon_destroy_target(t, NULL);
> > -			kunit_skip(test, "region alloc fail");
> > -		}
> > -		damon_add_region(r, t);
> > +		ranges[i].start = regions[i * 2];
> > +		ranges[i].end = regions[i * 2 + 1];
> >  	}
> > +	damon_set_regions(t, ranges, nr_regions / 2, DAMON_MIN_REGION_SZ);
> 
> [Severity: Medium]
> Is it safe to ignore the return value of damon_set_regions() here?
> 
> If damon_set_regions() encounters an allocation failure, it returns -ENOMEM,
> leaving the target with fewer regions than intended. Could this lead to a
> NULL pointer dereference in the subsequent test code if it attempts to access
> regions that failed to allocate?

Nice catch.  I will check the results and skip in the case of failure.

> 
> [Severity: Medium]
> Does this code leak the ranges array?
> 
> It appears ranges is dynamically allocated via kmalloc_array() but is never
> freed before the function returns, and damon_set_regions() does not take
> ownership of this memory.

Good finding.  I will free it.

> 
> >  
> >  	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520062858.167011-1-sj@kernel.org?part=4


Thanks,
SJ
