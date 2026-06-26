Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86A12CDA5
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433521; cv=none; b=GMH9dmkpkNwXHu9uoBtP4TAd4bkZS6dqBzM9MFckf9sh8QPhenk5uK8pwu3TAkW6MwIKiWVLKgz7HoP0LOtri6TtShQhOqZBSBzTS/1sippzfTisHol/uX1PljsSFe9/kqm9NoEHr1j7l6S/mh8JqLuaWR9ga6DP0x/I6xD4l1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433521; c=relaxed/simple;
	bh=hKSj2P+QWjf+G+aDasSWqMSMZw8Ur2D6mgkwrODSpkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggxelL/3/hnI+e5c1lgRSzmqlkkDb9g5jvaTIPHzDM7bFxRHDZWpmodTrohEiH2mo87GkbKnF1kBiLDEGEwX9WJvpvsI4tb4BCltMFjhtMjHjQKsLTyM7AF2jm9KSAVvfikR/gKZUx+mIaWLvt2+tyMQu6k/GVhCfYenMQ1ALio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDXnbZgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDXnbZgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BBB1F000E9;
	Fri, 26 Jun 2026 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433519;
	bh=hmDIh8kw2pyN74NBwbBJY+RErWxVPFxFMbwNZ5jZido=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDXnbZgosgCfA6D42WnCa4GFLxHiM6kOirdfl9t1BRI5RNoc3lfBXQQuJRrKydi73
	 bWCkIrDNy8TupFDNBFRycpYnPrGWS+fpxISCKPdoP3PfaCYWKqVujs2pfhaUxm4A8o
	 0cH4rlWM8HXRJmbJnOivI4g4WP7RmPQJenDpK8KO24VtUoh9ZV85/i7/T92wDLCyC/
	 RBZAxpzxDHIS2buVD1sQb07yvL0LrztFF8ojMUbTivSwU4EKL3xrXRUHQ+Fhd3z/mb
	 LEnURPqg3UZk9HvM14jbnPZhRF9E4h+SSWYyFD7rD9RVh15uXcUHVyM9SdJCvDzuSj
	 Vh++mp2JOaTmA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 03/11] mm/damon/tests/core-kunit: test
 damon_rand()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260626001644.85825-4-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
 <20260626001644.85825-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 00:25:19 +0000
Message-Id: <20260626002519.C1BBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete test coverage: the test misses the 64-bit execution bran=
ch of damon_rand().
--

commit e5514cf11386fbde6faace5ed2dc4b93fedc4bf8
Author: SeongJae Park <sj@kernel.org>

mm/damon/tests/core-kunit: test damon_rand()

This commit adds a KUnit test for the recently introduced lockless PRNG in
damon_rand(). It validates that the generated numbers stay within the
requested bounds.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 1cfb8c176b873..282670b0fa908 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> @@ -1460,6 +1460,20 @@ static void damon_test_is_last_region(struct kunit=
 *test)
>  	damon_free_target(t);
>  }
> =20
> +static void damon_test_rand(struct kunit *test)
> +{
> +	struct damon_ctx ctx;
> +	int i;
> +
> +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> +	for (i =3D 0; i < 10000; i++) {
> +		unsigned long rnd =3D damon_rand(&ctx, 0, 10);

[Severity: Low]
Does this test miss the 64-bit execution branch of damon_rand()?

The damon_rand() function implements two distinct calculation paths: one for
spans <=3D U32_MAX and a 64-bit fallback for larger spans using
mul_u64_u64_shr().

Because this test hardcodes the bounds 0 and 10, the span evaluates to
<=3D U32_MAX. This guarantees that only the 32-bit path is executed, leaving
the 64-bit logic entirely untested on 64-bit architectures.

Would it be helpful to add another iteration or separate test case with a
span greater than U32_MAX to ensure full coverage of damon_rand()?

> +
> +		KUNIT_EXPECT_GE(test, rnd, 0);
> +		KUNIT_EXPECT_LE(test, rnd, 9);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626001644.8582=
5-1-sj@kernel.org?part=3D3
