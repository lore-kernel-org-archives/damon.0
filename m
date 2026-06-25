Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA1351C17
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396543; cv=none; b=JLlZ1fvEIQ0uNfDAMmTFcBbzKS4rxpxQWYnjJaPJ+iYQeowYWf7PmgeHAKOJrwris6rL21oiPYCO2/ZCTssGiJNV0hLKs0PAk3r/SvwC1Mo+fRPlQrY9k8/57Fw2Aq9+fTbkfimTIS3KedKg7NNzSCww+Ezii7U4ts8uS/rBh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396543; c=relaxed/simple;
	bh=V9QOgHNrtIZw/knvSsLYPuFB8thfz0CA5sfrGH+AVEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz+4IImxhT80ebrUyWj++VmUnxHHDo/klT/8KIKJQ0U+PJjsDNEjNOzugyXNMdbloY/ZhHIZXGexOgaI+1Uvj6QytjvITCWU0E62zxpHN0RcWf1prbQW8RncsVnK3mXd3Bv1fD2QV13obBjnTwEAEFFV1i8gNKMa8IHpY+EdADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/BBMGG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/BBMGG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBD21F000E9;
	Thu, 25 Jun 2026 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396541;
	bh=9MU8JuLK9IKvGdEk5rm42o8O1nqs1tzqVYLyPxz97og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/BBMGG8ZnuLaB/F500WJN4kBK54C5EdRuUVKQrmzlVWNz+vsW0FXinQ5QwAYRhgV
	 j91yMsSJEQ6q3uqN6LEb3vi6/s23hGT5qjg0t2/q2COX2X4qESNIHtfa6pf70d3GPj
	 nYYAey7gqbfgXXhmP6NSM7z1KlGtiuPAMBrfhKyn7LTfmMCiTlC1SuSIc3j13nGX8P
	 w7YrZSwGQUPzhIMlrs6nSWh4JngTBTpjTh2qx4+gTJmCIp9LGwOZ+uiLByPNfuoK/5
	 uuONKLsp4Rk/DqT2HRHIbMNesTjqp3/fGeWvopnG2UAOqydJQnOzdO9EPjykiXEpQJ
	 cBFyfLzOQ+vuA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Thu, 25 Jun 2026 07:08:51 -0700
Message-ID: <20260625140853.102403-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625053751.92864-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Jun 2026 22:38:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 25 Jun 2026 05:13:51 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The KUnit test uses a non-deterministic seed with tight probability bounds, which will cause sporadic test failures.
> > --
> > 
> > commit bc9f1073820b74c3fbb6ac52d5ca363629f99f3d
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/tests/core-kunit: test damon_rand()
> > 
> > Commit 9012c4e647df ("mm/damon: replace damon_rand() with a per-ctx
> > lockless PRNG") optimized DAMON for better performance.  Add a kunit
> > test for ensuring the pseudo randomness quality.
> > 
> > > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > > index 1cfb8c176b873..756f3b9e2ed3b 100644
> > > --- a/mm/damon/tests/core-kunit.h
> > > +++ b/mm/damon/tests/core-kunit.h
> > 
> > [ ... ]
> > 
> > > @@ -1460,6 +1460,26 @@ static void damon_test_is_last_region(struct kunit *test)
> > >  	damon_free_target(t);
> > >  }
> > >  
> > > +static void damon_test_rand(struct kunit *test)
> > > +{
> > > +	struct damon_ctx ctx;
> > > +	int counts[10] = {};
> > > +	int i;
> > > +
> > > +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> > > +	for (i = 0; i < 10000; i++) {
> > > +		unsigned long rnd = damon_rand(&ctx, 0, 10);
> > > +
> > > +		KUNIT_EXPECT_GE(test, rnd, 0);
> > > +		KUNIT_EXPECT_LE(test, rnd, 9);
> > > +		counts[rnd]++;
> > > +	}
> > > +	for (i = 0; i < 10; i++) {
> > > +		KUNIT_EXPECT_GE(test, counts[i], 900);
> > > +		KUNIT_EXPECT_LE(test, counts[i], 1100);
> > 
> > [Severity: Medium]
> > The test uses a true random seed to initialize the PRNG state, making the
> > test output non-deterministic. Is it possible that these tight expectation
> > bounds will cause sporadic test failures in automated CI environments?
> > 
> > Statistically, a binomial distribution with n=10,000 and p=0.1 has a
> > standard deviation of 30. The allowed variation of +/- 100 is roughly
> > +/- 3.33 standard deviations. The probability of any single bin falling
> > outside this range is around 0.086%.
> > 
> > Over 10 bins, does this mean the test could spuriously fail about 0.86%
> > of the time (roughly 1 in 117 runs)?
> 
> Good catch.  I will modify the test to widen the bound to [800, 1200].

In my second thought, the logic is quite straightforward.  I will simply drop
the randomness test, and keep only the bound test.


Thanks,
SJ

[...]
