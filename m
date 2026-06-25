Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AC2BE7CD
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364433; cv=none; b=jy1BjzWZ4zQ9Mh05Jh26syZLBQWqR3EtIKU8Ksx4HLtZFIgFZj0ADOpUEckFIAXEB/VIFNRWzxE0CJyLrsf3GSvaahPzloiyR93FV8mV5s+95hv11ZO9ZqO8k4Ysqw0kqK2O2HW9eJgj8RaXxJzVJY0oRBYdCzf4LiGGBhPR35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364433; c=relaxed/simple;
	bh=jONQF8HL84rPS6szokOqZjYjQQ7oiNiCrWstNb/aBec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QSMESn5FCEqAFN3hglG2oMNizCJh9TBkjPCJUU3QvBwBl7zq8zzUHbd9OklT0Ubf3x985uy8vjw+wjbXUYCSSnbufOsocKltQcvFgGxjIOJWtu/J2x5BmZo6lmxGMxIGvwAe74D3FwIoSwwFOMYDxlNKlRcEriYCzv0CVUe+kLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrxb0PG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrxb0PG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040991F00A3A;
	Thu, 25 Jun 2026 05:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364432;
	bh=bDCZMECh0lV86MpIHfnOBnLOIi8mh+6VIqkwfXU7scA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nrxb0PG5VZKCVXj5PKhVikZYT2s87084asc9/5QXIixku5ekanfnceYEZ++AlYtTs
	 8dR3yi7S0dYIfmp3YriwfdQ/CoULFDQFbqAWGK5vPAFN0Kwhqww9nM/rP9UlBGSQKV
	 7EE89nAJngP2kL3wZEmZ5A069clvdLNQIp2gDUMhdtixFudDTMISYZNZ/hcppKwPbq
	 PpWW7nTwKL+E2MuSojYAKyr5RiDb4uoSo4sK7hVaL6x7gi11YcQEifu5LWccINEzcF
	 +l0lGvbVzjRw0PQuJif4eBefzVP5FuCLP8rug4Ad+QjDJ4rhppttLHReEJhld/d/W/
	 2mYNWsr8TSlZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 03/11] mm/damon/tests/core-kunit: test
 damon_rand()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260625050756.91115-4-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
 <20260625050756.91115-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:13:51 +0000
Message-Id: <20260625051352.040991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The KUnit test uses a non-deterministic seed with tight probabil=
ity bounds, which will cause sporadic test failures.
--

commit bc9f1073820b74c3fbb6ac52d5ca363629f99f3d
Author: SeongJae Park <sj@kernel.org>

mm/damon/tests/core-kunit: test damon_rand()

Commit 9012c4e647df ("mm/damon: replace damon_rand() with a per-ctx
lockless PRNG") optimized DAMON for better performance.  Add a kunit
test for ensuring the pseudo randomness quality.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 1cfb8c176b873..756f3b9e2ed3b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> @@ -1460,6 +1460,26 @@ static void damon_test_is_last_region(struct kunit=
 *test)
>  	damon_free_target(t);
>  }
> =20
> +static void damon_test_rand(struct kunit *test)
> +{
> +	struct damon_ctx ctx;
> +	int counts[10] =3D {};
> +	int i;
> +
> +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> +	for (i =3D 0; i < 10000; i++) {
> +		unsigned long rnd =3D damon_rand(&ctx, 0, 10);
> +
> +		KUNIT_EXPECT_GE(test, rnd, 0);
> +		KUNIT_EXPECT_LE(test, rnd, 9);
> +		counts[rnd]++;
> +	}
> +	for (i =3D 0; i < 10; i++) {
> +		KUNIT_EXPECT_GE(test, counts[i], 900);
> +		KUNIT_EXPECT_LE(test, counts[i], 1100);

[Severity: Medium]
The test uses a true random seed to initialize the PRNG state, making the
test output non-deterministic. Is it possible that these tight expectation
bounds will cause sporadic test failures in automated CI environments?

Statistically, a binomial distribution with n=3D10,000 and p=3D0.1 has a
standard deviation of 30. The allowed variation of +/- 100 is roughly
+/- 3.33 standard deviations. The probability of any single bin falling
outside this range is around 0.086%.

Over 10 bins, does this mean the test could spuriously fail about 0.86%
of the time (roughly 1 in 117 runs)?

> +	}
> +}
> +
>  static struct kunit_case damon_test_cases[] =3D {
>  	KUNIT_CASE(damon_test_target),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625050756.9111=
5-1-sj@kernel.org?part=3D3
