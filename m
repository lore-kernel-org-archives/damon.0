Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DC34A3BF
	for <damon@lists.linux.dev>; Thu, 21 May 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342075; cv=none; b=SWWWbjSV1D1QAUaT5jJwP9N1cY4aAXjeH//OdAu66RsWCmfOC1zjfgfcpwPqaarigw5MZ2dspYiqA6SnqmuEE7/Bn2HJhx2jxko/3phh+V0wlEbR/DH8cEg2o1uW9Tc9wQlOIsZJ08NnTRPA+PZQ6kMAGR7oQNqSx9KB+ouXWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342075; c=relaxed/simple;
	bh=u+J4zLP7pg8bp1+A0nXB8EhQtHA6nU4Wms8LHSOC4a4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYjHtbNm09XAI1uyaVsaYalNSkELLnlhGMTKYIPLByglX2gCCa27GBrUg1Etnh8y1AshXgnIjLiEFUvryhZH4tT/D7whAieKmMruexbewjBGNZYhk7OIIQcLzI7bwJGYpv0KgdOmssFv9dfdWenm2tXmvO8ptU2mFxWZH26lWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kustyDRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kustyDRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDC61F000E9;
	Thu, 21 May 2026 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779342073;
	bh=rtP1aZAx641NiTBPZqj6X70ERp01e/9U6gbOXEzH2a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kustyDRSs41nz5+VaiO3jSL+H4VFXFYenC0qibxQwRsJWYxVeZnhs8OFm9FIizvOT
	 jKHUrrUGLm15lV0GB81jSN01WuurRhsQzqJTe4Yt0LzavsmFSYydavMu1botzQWIdV
	 ZlhZBzc7RNrBNb+ixgXrCp6TrSEf9wAVJKOQGk5hinSUohtV+wINwQteGxJVAB8dk1
	 7xJMKdqCEmDjdabuZBFTWt9BqgfdPXVo0LHK89x34IL9VTmCJFlpvJ4N6CxoLjGy4J
	 Js5hAI4pJD8+kebKdDibe7vkrzrJJXA6hjjGnkUGzISvZPjwMjuFK/7yI5EIT6X5IU
	 +Kf6UdxWaeXdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test split above
 max_nr_regions/2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260521045236.115749-3-jiayuan.chen@linux.dev>
References: <20260521045236.115749-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 05:41:13 +0000
Message-Id: <20260521054113.AFDC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new unit test `damon_test_split_above_half_progresses` fails=
 to effectively test its target logic and introduces architecture-dependent=
 flakiness due to relying on default page sizes.
--

commit 41d857e275ff50ce39c3b59f85362709927d922a
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon/tests/core-kunit: test split above max_nr_regions/2

This commit adds a kunit test to exercise kdamond_split_regions() when the
total region count is already above max_nr_regions / 2. It asserts that the
function can still produce new regions without overshooting the maximum
region limit.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 866f716e5760d..c87933c58785b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> +static void damon_test_split_above_half_progresses(struct kunit *test)
> +{
> +	struct damon_ctx *c;
> +	struct damon_target *t;
> +	struct damon_region *r, *big;
> +	unsigned long start;
> +	unsigned int nr_before, nr_after, i;
> +	const unsigned int nr_small =3D 799;
> +	const unsigned long small_sz =3D 10;
> +	const unsigned long big_sz =3D 1000000;
> +
> +	c =3D damon_new_ctx();

[Severity: Medium]
Does this introduce a test regression on architectures with large page size=
s?

Because damon_new_ctx() sets c->min_region_sz to the default PAGE_SIZE,
this test might become flaky or fail on architectures with larger pages.

For example, on architectures with a 256KB page size, the random split math
could calculate a sub-region size that aligns down to 0, which would skip
the split. On architectures with 1MB pages, the test would deterministically
fail because the big region size (1,000,000) is smaller than=20
2 * min_region_sz.

Will this cause the KUNIT_EXPECT_GT(test, nr_after, nr_before) assertion
below to randomly or deterministically fail since no regions will be split?

[ ... ]
> +	nr_after =3D damon_nr_regions(t);
> +	KUNIT_EXPECT_GT(test, nr_after, nr_before);
> +	KUNIT_EXPECT_LE(test, (unsigned long)nr_after,
> +			c->attrs.max_nr_regions);

[Severity: Medium]
Does this test actually exercise the budget constraint logic to ensure the
region limit isn't overshot?

Since the setup only provides a single splittable "big" region, and
damon_split_zero_age_regions() skips newly inserted regions during its
traversal, wouldn't this only ever produce at most 1 new region before
terminating?

If it can only split once, it seems structurally impossible for the test to
reach or exceed the remaining budget of 700 regions, which might defeat the
stated purpose of checking if the function overshoots the limit.

> +
> +	damon_destroy_ctx(c);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521045236.1157=
49-1-jiayuan.chen@linux.dev?part=3D2
