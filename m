Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6B19ADA4
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782365887; cv=none; b=qsyUcJAaFOqyVS487VLBDJrSxKB27aRixLfItHqkeFn5Vtw2UbdhMcnzPaef4gHcPglUnKXIVMkfbokc/Gz+k4Uww4zsz0GRbHry5C+ZWYZjDIxwruVwl0BLwfHqRudqHmR0NkW3yeTeb/kCcx5OmyIN9EEZvXtcW6hiCd7Wdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782365887; c=relaxed/simple;
	bh=e/YLCJ2cpy5NsukRlrAxLorAqM2PItYwprEZRGzU1Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdaFWuF5ycgtMTXQaZfIXr2DdPcVwPpWxh8C6wbZFrDDWQKxoU5DTZuGhj7LptmeTDBZKHq+oHR2hMo5tr0pO0flgEotrxRa8cOQ2YiI/bAWeg2xYA7aJx2sa6zffjE7J8H0GbJTItwgdf/E0ngjp4Xk/xCJNRWsu3kbKK3aOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRyYkUbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRyYkUbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A358A1F000E9;
	Thu, 25 Jun 2026 05:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782365886;
	bh=GjORBhJJCuzre1OXE3OpMwJeeNkIyzkpfvXKLTve+Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRyYkUbzJGuwTSuosz8s9G96SiaauKe4RL99XJIv0nFCsG7whQv6SrrxYixSJerBb
	 0pDyYw2EwvZ/ZdbnKHGZkJ/D6SpR8ZDKOGZyMbaIHyHBR356i1BkBmpi1jdNvARKri
	 0TSLqIT8WiG4f1iQpcQEjNfDpmJSWJK8CRA1McaCAP3TMDCgZ6tjaivXQi/kJEot/O
	 Mb+gaZwk8kapYofkUD8Vwis7GNXH8y2m9rCJACS0ec1bsVusFWAlNMz4WZKeS/tIB/
	 cZNjtENQA8dKg/Lo4aURHSBb2OKgAtu8ycEGqf8xamUtHH2DPyF/fJjmvTMe82Qoq1
	 hTLX30G/YBySA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Wed, 24 Jun 2026 22:37:50 -0700
Message-ID: <20260625053751.92864-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625051352.040991F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jun 2026 05:13:51 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The KUnit test uses a non-deterministic seed with tight probability bounds, which will cause sporadic test failures.
> --
> 
> commit bc9f1073820b74c3fbb6ac52d5ca363629f99f3d
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test damon_rand()
> 
> Commit 9012c4e647df ("mm/damon: replace damon_rand() with a per-ctx
> lockless PRNG") optimized DAMON for better performance.  Add a kunit
> test for ensuring the pseudo randomness quality.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 1cfb8c176b873..756f3b9e2ed3b 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> 
> [ ... ]
> 
> > @@ -1460,6 +1460,26 @@ static void damon_test_is_last_region(struct kunit *test)
> >  	damon_free_target(t);
> >  }
> >  
> > +static void damon_test_rand(struct kunit *test)
> > +{
> > +	struct damon_ctx ctx;
> > +	int counts[10] = {};
> > +	int i;
> > +
> > +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> > +	for (i = 0; i < 10000; i++) {
> > +		unsigned long rnd = damon_rand(&ctx, 0, 10);
> > +
> > +		KUNIT_EXPECT_GE(test, rnd, 0);
> > +		KUNIT_EXPECT_LE(test, rnd, 9);
> > +		counts[rnd]++;
> > +	}
> > +	for (i = 0; i < 10; i++) {
> > +		KUNIT_EXPECT_GE(test, counts[i], 900);
> > +		KUNIT_EXPECT_LE(test, counts[i], 1100);
> 
> [Severity: Medium]
> The test uses a true random seed to initialize the PRNG state, making the
> test output non-deterministic. Is it possible that these tight expectation
> bounds will cause sporadic test failures in automated CI environments?
> 
> Statistically, a binomial distribution with n=10,000 and p=0.1 has a
> standard deviation of 30. The allowed variation of +/- 100 is roughly
> +/- 3.33 standard deviations. The probability of any single bin falling
> outside this range is around 0.086%.
> 
> Over 10 bins, does this mean the test could spuriously fail about 0.86%
> of the time (roughly 1 in 117 runs)?

Good catch.  I will modify the test to widen the bound to [800, 1200].


Thanks,
SJ

[...]
