Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1438DC71
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337229; cv=none; b=ivt82GIRK29JaEiXKK2pfc6LMSqQ5MieXtSAhvikAc7WfG1bg4hvtzsn9ZYIGlETIYs/KxHzc4+nZXALVVgFBbBVU77W699by7bZQAuVdoLHWxxUb1pK14WmmwurHGwviw0/WAEsizvzDVPJ0ADc8T64sjEXt1G95HfSGCqz8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337229; c=relaxed/simple;
	bh=doGBliFmP1wc0FDCDJVycVNkUXpaPFxntTb4SmDeuUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i1KUCAycMdsr0sPQOwLaMu97LRDkc2uK7Zt7ufc+eejA7UWARHWoATtcm4KO3NPUSJiNnhIHWgsC7eLm0MSjBvsNBpa7PzcwHToH+Bz9TO+POUsSC1hlRQdUPVFuD6DCiPC68BhMer+KTq5CP8OB5FS0KUkSP8rfLjGEUddWHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM8oa31k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM8oa31k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57B61F000E9;
	Wed, 29 Jul 2026 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337227;
	bh=KFn/A2IOu5mE7xIM0Bg1INXJGrZVrw9BPfNrF87rcFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UM8oa31kgOjhKWmlsHMh3syd9EGs1e2jk+Su5uzYD7S6lzwq+rnDCwANy/S39EHAj
	 mxHl9UlTRY4uMnI1F5g1Oq+P7BdHuAT5FrhYbbzYqW+duhcsgbg/cAnwyCter5K3lg
	 dTKJTSm0kk0AigApUvKbvjzVcQ/aKz0U/pomWFPog1bsM04aGyMA4hN+wOpI7Um5vP
	 B5j8FgA3GDvJoTRPdAcUdOvumV2FllR2MjOG3nL99wDTuccOC25z5GxjlPB6eSdP9a
	 MKTcVcgCK4S20hCW+QIdTyPLko1xuFLtp95A5/eEE1Mj19npaMYTUW8MIaPm4GYt7c
	 IcDZTT0AHIZEw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] mm/damon/tests/core-kunit: add
 damon_commit_probes() test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729144738.90895-3-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
 <20260729144738.90895-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:00:27 +0000
Message-Id: <20260729150027.B57B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing cleanup in the error path of `damon_test_commit_probes_f=
or` causes a memory leak of dynamically allocated test structures.
- [Medium] Missing bounds check in `damon_test_commit_probes_for` can lead =
to a NULL pointer dereference when a test assertion fails.
--

--- Patch [2]: [RFC PATCH 2/6] mm/damon/tests/core-kunit: add damon_commit_=
probes() test ---
commit 490c9d2d6b4090811aaa428df3f6d9ce89e2d406
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: add damon_commit_probes() test

Add kunit test to ensure damon_commit_probes() updates destination DAMON
context with source probes as expected.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 6cbe22accabfb..6577410ace3da 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> +static void damon_test_commit_probes_for(struct kunit *test,
> +		unsigned int dst_weights[], int nr_dst_probes,
> +		unsigned int src_weights[], int nr_src_probes)
> +{
> +	struct damon_ctx *dst, *src;
> +	int err;
> +	struct damon_probe *dst_probe, *src_probe;
> +
> +	dst =3D damon_test_help_setup_probes(dst_weights, nr_dst_probes);
> +	if (!dst)
> +		kunit_skip(test, "dst alloc fail");
> +	src =3D damon_test_help_setup_probes(src_weights, nr_src_probes);
> +	if (!src) {
> +		damon_destroy_ctx(dst);
> +		kunit_skip(test, "src alloc fail");
> +	}
> +
> +	err =3D damon_commit_probes(dst, src);
> +	KUNIT_EXPECT_EQ(test, err, 0);
> +	if (err)
> +		return;

[Severity: Medium]
Does this error path leak the dst and src context structures?

If damon_commit_probes() returns an error, the early return here skips the
cleanup calls to damon_destroy_ctx(dst) and damon_destroy_ctx(src) at the e=
nd
of the function.

> +	nr_dst_probes =3D 0;
> +	damon_for_each_probe(dst_probe, dst)
> +		nr_dst_probes++;
> +	nr_src_probes =3D 0;
> +	damon_for_each_probe(src_probe, src)
> +		nr_src_probes++;
> +	KUNIT_EXPECT_EQ(test, nr_dst_probes, nr_src_probes);
> +	nr_dst_probes =3D 0;
> +	damon_for_each_probe(dst_probe, dst) {
> +		src_probe =3D damon_nth_probe(nr_dst_probes, src);
> +		KUNIT_EXPECT_EQ(test, src_probe->weight, dst_probe->weight);

[Severity: Medium]
Could this result in a NULL pointer dereference if the destination context =
ends
up with more probes than the source context?

KUNIT_EXPECT_EQ() does not abort test execution if the previous check for
nr_dst_probes =3D=3D nr_src_probes fails. If dst has more probes, damon_nth=
_probe()
will return NULL, and the next line accessing src_probe->weight will crash =
the
test runner.

> +		nr_dst_probes++;
> +	}
> +	damon_destroy_ctx(dst);
> +	damon_destroy_ctx(src);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144738.9089=
5-1-sj@kernel.org?part=3D2
