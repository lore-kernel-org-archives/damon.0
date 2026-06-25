Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84533067C
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397876; cv=none; b=L1bvN3ZZDFtzB+zSWVVt7jtyuvpXvrprW9L4RWZE/jWGcSod1HuH2vkJRTP2mvbOrJT5RK3Toa9WJFnc5mSmRhOFCvvNjm0dYSCRfoCJt1M/MJWhYzt/jRzMlwMRgbYCV/Sm+Nw1ANrt4TCvOzmiLLZ1GYOWpVshFcyIaKeu2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397876; c=relaxed/simple;
	bh=WAGJtSANnGX5QpYAm4bq/m6E834+BPkZvIQqaJ+G/Kk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOfNpk0d0dDvhSLIYFv4kLX0sKy+LlAIWutShSP8tkgfAbGOIrhCm84ruZqq24cpABTYP5+o6P+pP4Syt6teFQ9lpWpyvYDjy+kAPhB2HGhOagu2lmeanRZkvmMa3tvPv/BmYQ6WFBT9dFisFM5GyTHNbSZKD1CvL7DhzQuAu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJgx2GYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJgx2GYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8303B1F000E9;
	Thu, 25 Jun 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397875;
	bh=tNsNPFbHZjGJqQQk2mDZ1nXC5t8rhgEmpfGeXAmcjCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJgx2GYLkt7s5s52aHL6f/4+YZ6BvdzdRoHe8BLdiXTLTXgJWby2qUm1RsX/kMlIN
	 LZPBEVBRVlWVwdpRpRCHP1OKlZQ96Yctipb1CBEBkiNQcWAF4N7t5lDM6/4jwuFSz1
	 zZCAou+/Lczmm8Dx74/toOafFBpUbO9xpTI47GaMLVdTXL6Ery5HDgk7eNFtOQAnwV
	 E4RJKpb4uzrZBKIXdweK0CucUa1UFIN5ZTXlff7RQpmCg9nJEpDF7TicuVplwGeL/V
	 /tULAgDCBOqyljzE66QvKuTgAPgmk7E6MNhh5+XrC/69ixzzLEImYFlgGxsI2Ioyh0
	 CE8Om4H5Z73AQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 03/11] mm/damon/tests/core-kunit: test
 damon_rand()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260625142357.103500-4-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
 <20260625142357.103500-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:31:14 +0000
Message-Id: <20260625143115.8303B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `counts` array computes a histogram of the generated random num=
bers, but the results are never validated.
--

commit 545f6f76f7e281c6063dff020687345d3e3d45e4
Author: SeongJae Park <sj@kernel.org>

mm/damon/tests/core-kunit: test damon_rand()

This commit adds a kunit test for damon_rand() to ensure the generated
output falls within the specified bounds. It follows a recent change
that optimized DAMON to use a per-context lockless PRNG.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 1cfb8c176b873..eec7cb325a431 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1460,6 +1460,22 @@ static void damon_test_is_last_region(struct kunit=
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

[Severity: Low]
Are we missing a validation check here? The counts[] array computes a histo=
gram
of the generated random numbers, but the accumulated data is never read or
verified after the loop terminates.

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625142357.1035=
00-1-sj@kernel.org?part=3D3
