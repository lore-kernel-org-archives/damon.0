Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186042EEBC
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831300; cv=none; b=DFnDc8q30itg+YBui2h/wunU0pWNR9lPf+GZmQlsAG+HrS8vMN//rY8yPil/WcVrFyLIbE+iptHldZuoKbRDFPFizEMftzVav3/QCZwDmOd2wt0sNHu7mKi6f3ajGJvZE1PlJ0kDsVfkLPYdDeL4JtEIlib2PC5nY5kPLWW9VVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831300; c=relaxed/simple;
	bh=ge0N5n2jDlrG35kqUaWfXTXy5x8MrqPSepuTS6AuEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpeO2490KOR3uv2fCVYYC4BxcP3KSUPycjbKEPyYxx/ehZQvyg8yjKXFWGWeBKa3+Gq6S5c/y3Jya1gTP22/wJ9JwI1xIIvBo4v5Z6HjZJCsy18ofHIB40EaMyUoXuB2zBNAaHsBn9unXiLhM0DOzJ64zmajL251gPdkCFS7Db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeRulfJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeRulfJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09911F000E9;
	Tue, 30 Jun 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831299;
	bh=4y5VBCHZLxSpxg9L8gOfuSOoR7z4hptNQejQI6Ge/jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeRulfJ0vWGuRxz7tTREaIXtBEe7ate1B7c0/GQohqr6+TXRtZQlLmCyqWCQPqL4s
	 4REmAEINcl7ar4fYl3XGuF5aQVvsyfZupf1iP4BSFGkzevayWTDunaKDeSmDVnA+Gd
	 mo6LVAqx/3Ihzt8iNgHODmH0CdzvFQc7O4S8vEnRL/yJagCfMOWK574YbWCY8dEFW1
	 f7lGy7oxHR1SzbCm5f1GJMsJVMwnKAk3iOwYzlVM0m7hIijBzCbxFQfdmPjUHgaJG2
	 DexziG2pDOeEAHYADeD3p10tBJqSG6GRSRWsNb9RhNe119IKJid3UJSM90hF22D1mL
	 1/Y3n0nMbS1nA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Tue, 30 Jun 2026 07:54:50 -0700
Message-ID: <20260630145451.93002-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630142503.7100A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 14:25:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The lower bound check `KUNIT_EXPECT_GE(test, rnd, 0)` is a tautology and fails to test the lower bound offset logic.
> - [Low] The test completely misses the 64-bit slow path of `damon_rand()`.
> --
> 
> commit 3514b0c5edd38e0cdd6bf2d3e8b3ba10d7e617d2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test damon_rand()
> 
> This commit introduces a kunit test for the damon_rand() PRNG to ensure that
> the generated output respects the expected bounds.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index a00168730445d..0ec7d14d354e7 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> 
> [ ... ]
> 
> > +static void damon_test_rand(struct kunit *test)
> > +{
> > +	struct damon_ctx ctx;
> > +	int i;
> > +
> > +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> > +	for (i = 0; i < 10000; i++) {
> > +		unsigned long rnd = damon_rand(&ctx, 0, 10);
> 
> [Severity: Low]
> Does this test miss the 64-bit fallback path in damon_rand()?
> 
> Looking at the implementation of damon_rand(), it contains specific logic for
> spans exceeding U32_MAX. By hardcoding a span of 10, the test exclusively
> exercises the 32-bit fast path and leaves the 64-bit arithmetic
> (mul_u64_u64_shr) completely untested.
> 
> Could we add cases that test spans larger than U32_MAX?

As I previously replied, that could be a good enhancement future work.  Not a
blocker for this patch, though.

> 
> > +
> > +		KUNIT_EXPECT_GE(test, rnd, 0);
> 
> [Severity: Medium]
> Is this comparison inherently tautological?
> 
> Since rnd is an unsigned long, rnd >= 0 is always true, which renders this
> assertion ineffective and might trigger compiler warnings for tautological
> comparisons.
> 
> Additionally, because the test uses 0 for the lower bound, does it properly
> verify that damon_rand() correctly applies the lower bound offset to its
> output? If the implementation failed to add the lower bound, this test would
> not catch it.

Again, nice improvement candidate rather than a blocker for this patch.


Thanks,
SJ

[...]
