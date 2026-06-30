Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215C22424C
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829504; cv=none; b=cIefxIb2F0Z5Jw2n9YPrCgE5LRcdFB6CTQUd1kI6WmmkkKr+pYnb2N0zFUzcxXjp4tl0L6it9Kjr6yQJbUdDNwrC9pcNcM1gpSEY2aEoi8i9Gmv7p/wdJ4aZYVU1IO65duSv/XKwLCZVG27WFpraEegow7h+SBS6yLlpf3j2TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829504; c=relaxed/simple;
	bh=Hj1PsWdoPrBDHrgQ/uY2Jp5WrmZD4VEi3Nry/VJmDLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rdfJkOvST6xuF+ZQJcQuyNY1g0WebCxOGWDRjTbHvBugpbBOED0wTnj/TqxjvY09/KvylLmmRzi5u0imU7EcmVnOBKnui5hWH5FDTD7w/48TPbtBsOpqJam4vCgonmeh9SxC68pR8hdU7d8lDaXphhfbrgfIx68gONO1OBetvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKkLLpQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKkLLpQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7100A1F000E9;
	Tue, 30 Jun 2026 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829503;
	bh=T258iS9xRM7W+MR5bvljNzLMNfOUkMswJ7YvzCJx5to=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKkLLpQNibUHaPh2GLuB3sVizQkLGELzgG+2E7KVZ6RPi500ElXomozz2UugLyOAe
	 U4FyzwKXQj8ZnfAm5SfzHxphjhkoqFTHQyPPKLZsEi+zB9A88GRMmou4k85vtt+gpU
	 Oz8WmhG13SwsP3ep0FoO3Vu89Luz5A1TsIUXNwdproxXKHaZ+YUB6wAk9InN+YptL/
	 3rnegn1t0Cfrx9/YNfwKtdvldvb7ld5c7TxOmkWeNPTJW4P6YwpiSbNNAXxXbNaaPm
	 J9iakQkgFaxsb5Zi1fNv5p9cdcyWVsTpWa9iClulvx3DygLGeU/PLtz3M20yV2iAxK
	 NMb1ropljsOQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] mm/damon/tests/core-kunit: test damon_rand()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630141726.92246-4-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
 <20260630141726.92246-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:25:02 +0000
Message-Id: <20260630142503.7100A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The lower bound check `KUNIT_EXPECT_GE(test, rnd, 0)` is a tauto=
logy and fails to test the lower bound offset logic.
- [Low] The test completely misses the 64-bit slow path of `damon_rand()`.
--

commit 3514b0c5edd38e0cdd6bf2d3e8b3ba10d7e617d2
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: test damon_rand()

This commit introduces a kunit test for the damon_rand() PRNG to ensure that
the generated output respects the expected bounds.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index a00168730445d..0ec7d14d354e7 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> +static void damon_test_rand(struct kunit *test)
> +{
> +	struct damon_ctx ctx;
> +	int i;
> +
> +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> +	for (i =3D 0; i < 10000; i++) {
> +		unsigned long rnd =3D damon_rand(&ctx, 0, 10);

[Severity: Low]
Does this test miss the 64-bit fallback path in damon_rand()?

Looking at the implementation of damon_rand(), it contains specific logic f=
or
spans exceeding U32_MAX. By hardcoding a span of 10, the test exclusively
exercises the 32-bit fast path and leaves the 64-bit arithmetic
(mul_u64_u64_shr) completely untested.

Could we add cases that test spans larger than U32_MAX?

> +
> +		KUNIT_EXPECT_GE(test, rnd, 0);

[Severity: Medium]
Is this comparison inherently tautological?

Since rnd is an unsigned long, rnd >=3D 0 is always true, which renders this
assertion ineffective and might trigger compiler warnings for tautological
comparisons.

Additionally, because the test uses 0 for the lower bound, does it properly
verify that damon_rand() correctly applies the lower bound offset to its
output? If the implementation failed to add the lower bound, this test would
not catch it.

> +		KUNIT_EXPECT_LE(test, rnd, 9);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630141726.9224=
6-1-sj@kernel.org?part=3D3
