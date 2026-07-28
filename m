Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026E2673AA
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218099; cv=none; b=obj00QjWSh7FIAmKBmdV3l1ZVLlEAUoLYii/fWLo2/WOTgFsQDAKRn5XuupII1wr7SLjVQEEoV2trZtQkUQFVF/Or1jqaZ/gahQR8Pvht14UTXhQdP2eeHb35WYuGbGSU4Kp5JBU5Y24VxKUzJu8pJkIMxuKJnlDYxd1y0TY8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218099; c=relaxed/simple;
	bh=UukOAA4skU5sCJuGTHz5l1Pjdl3wt+mRNsishm6rB2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyjcrXMcAcwxywjO0tdKRP3nn96d5etdl8mhbYKUAwOIKwaKo9A+uS08T1PWX1qrU0YSgKRKI67JhRzk7VgSp+ER5lRNqXYM0rjZHJwM2D8G1ZfmLErSdL+nhfdigQWABQSXZCT6MGJEgxd5GOpEQCynzARWNWla2KMhGU75bmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQvDm+od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQvDm+od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C80C1F000E9;
	Tue, 28 Jul 2026 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785218098;
	bh=hzTFXJ1zYIr211CIYWNcSNVzHaliRu9hAfevZaDZi4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQvDm+odtld006zY8GyVctg4vkhK4ArjowSeToIuosngQXGKFjGNxNJ83Sk+s7SBn
	 v1x1YWfONsTXEl8wGBPwGQ9WPUrZayZEbDdeLoVLYg4gKp3zVn/Se7grt/xGytEW15
	 kbt699VBhOKFhJk4UV589rz4cFcZ230OUjX3sSucyHabmOJA7VNT+2EuUUvxBsO35z
	 wgNxHNT9d8jTezpCIAQ3whc8JIqUkfM25E/HIVZCFqFiQn3v9m7CCZNkk9Hk8W0hm0
	 hQ9b2036nI6Q7U1OKpsrxP6mgMhOXmYrsg2gdjcRSbFAmTv9+Bz9Kq6HLElaTHKqiF
	 FtkQtjjUymA3g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 07/10] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Mon, 27 Jul 2026 22:54:48 -0700
Message-ID: <20260728055449.211281-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728053344.A42901F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 05:33:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `damon_test_nr_samples_per_aggr` test uses tautological assertions that will always pass, failing to detect the regressions it was intended to prevent. Additionally, the test setup overflows to zero on 32-bit architectures.
> --
> 
> --- Patch [7]: [RFC PATCH 07/10] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr() ---
> commit 50a7320dda40ca169bc23924caa1421599f78314
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
> 
> This commit adds a kunit test for damon_nr_samples_per_aggr() to ensure
> that extreme interval setups are handled properly without returning zero
> or random overflowed values.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 3041b8288ec26..511f2856d343c 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> 
> [ ... ]
> 
> > +static void damon_test_nr_samples_per_aggr(struct kunit *test)
> > +{
> > +	struct damon_attrs attrs = {
> > +		.sample_interval = 0,
> > +		.aggr_interval = 0,
> > +	};
> > +
> > +	/* Zero aggregation interval doesn't cause division by zero */
> > +	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
> > +
> > +	/* Too large aggregation interval doesn't cause overflow */
> > +	attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
> 
> [Severity: Medium]
> On 32-bit systems where unsigned long is 32-bits wide, does this assignment
> overflow to 0?
> 
> If it overflows, the test would configure an interval of 0 instead of a value
> larger than UINT_MAX, failing to test the large-interval scenario.

Yes, this is for testing on 64bit system.  I will add this to the comment.

> 
> > +	KUNIT_EXPECT_GE(test, damon_nr_samples_per_aggr(&attrs), 0);
> > +	KUNIT_EXPECT_LE(test, damon_nr_samples_per_aggr(&attrs), UINT_MAX);
> > +}
> 
> [Severity: Medium]
> Since damon_nr_samples_per_aggr() returns an unsigned int, are these
> assertions tautological?
> 
> An unsigned int is inherently always >= 0 and <= UINT_MAX. This means the
> test will pass regardless of the function's return value, and it wouldn't
> catch if the function unexpectedly returned 0.

Good catch.  The test should ensure the return value on 64 bit system is
exactly UINT_MAX.  I will do so.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728052811.192712-1-sj@kernel.org?part=7


Thanks,
SJ
