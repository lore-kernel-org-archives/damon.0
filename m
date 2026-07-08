Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4563B14D8
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475000; cv=none; b=eYBVhyknRY30egxtl0o0UDeyy10Osg6Vbi6jD+LEiO5aDhqcxu91jyz38IKSd1z+sTpxRqMyRAvJfuUWgFTFfP4hbEGjymDbMMJKy4eesFzAh2cCEJvbw4M2yAmn2YGiXh2lY4P7uHaeZvtGdcGVAPHSQgNTaYo/kThScH7EcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475000; c=relaxed/simple;
	bh=+qKZHMouXgCNL5e70BOstT+DLA8hR2kXzT3HzC8SQ6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJZZkUCvih9z/obFLwTEdTM9EPFT2mOQWzc0P6+ntfGIuG51DqqNY34Ecq6ITuwJTk5pXg0NVbNzabtery6kOM1ByvCDB/m10sXHgtKCX2exRlQQEy8LCqPygnOyKdbZvpvsMfoPYl/JkG2OXj0jH8REUZXsxn5aA8Hp+rlT2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjeUjd5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjeUjd5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7DF1F00A3A;
	Wed,  8 Jul 2026 01:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474999;
	bh=rJOEc7TLtUV4cdbU1Msw666x4Q2/nWr7TjNzhqOu6SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjeUjd5miHYJfL2l39j5fafzGCG0narIg3n5r0QZVu/zPINuCpxDHjZxQU4NCDGK+
	 JzbU6mrXMuqTDDZ+4DD1O8MnPYcZK8i8LmHim4sT40EYlZPVq6u2nCCjIg83QSwxeL
	 Bk0LgzDx6ptL3H1M4oDe9BBn3Wviewry/FghF2E+L1NgENNcZqUB9Hhb6F2NU+qEaG
	 UNOQai4oRBgEiT87eJieiqUkijRvwQF9pQEAHrOb8sJUNe6mPT/ZJSkyz8Qwb6BdTx
	 I4SRgDrUk5C3TI0H8TeaSo6EsZrVgxe9916V/qyfoG2hIouADZrxof2MxJeAQCPC8g
	 98/LMi84Yh98Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 1/7] mm/damon/core: remove comment and test for
 nr_to_bp() divide-by-zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708013252.95888-2-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
 <20260708013252.95888-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:43:18 +0000
Message-Id: <20260708014318.CC7DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to entirely remove the test code, but =
instead leaves a broken, orphaned test function causing build failures.
--

--- Patch [1]: [RFC PATCH v1.2 1/7] mm/damon/core: remove comment and test =
for nr_to_bp() divide-by-zero ---
commit d67544b646a2eb5eb3336e5b2555a05dd0f2f18c
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero

This patch removes obsolete comments and test code related to division by z=
ero
in DAMON's nr_accesses_to_accesses_bp() function, noting that earlier commi=
ts
prevent zero aggregation intervals from reaching this code.

> Commit 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme
> intervals in damon_hot_score()") modified damon_nr_samples_per_aggr() to
> always return non-zero.  Hence no division-by-zero of the note can
> happen.  Remove the obsolete comment on the function.  The test code was
> written to test the division-by-zero case, which cannot happen anymore.
> Having it makes no sense.  Entirely remove the test code and its
> comment.

[Severity: Medium]
The commit message states that the test code was entirely removed, but the
diff shows the test being rewritten to damon_test_max_nr_accesses() instead.

Also, should the commit message reference damon_max_nr_accesses() here
instead of damon_nr_samples_per_aggr(), given the function that is actually
being tested in the diff?

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 0124f83b39b83..b2a280556b841 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -575,26 +575,20 @@ static void damon_test_set_regions(struct kunit *te=
st)
>  			}, 3);
>  }
> =20
> -static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> +static void damon_test_max_nr_accesses(struct kunit *test)
>  {
>  	struct damon_attrs attrs =3D {
> -		.sample_interval =3D 10,
> -		.aggr_interval =3D ((unsigned long)UINT_MAX + 1) * 10
> +		.sample_interval =3D 0,
> +		.aggr_interval =3D 0,
>  	};

[ ... ]

> +	/* Zero aggregation interval doesn't cause division by zero */
> -	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
> +	KUNIT_EXPECT_EQ(test, damon_max_nr_accesses(attrs), 1);

[Severity: Medium]
Will this cause a build failure?

Looking at damon_max_nr_accesses(), it expects a pointer to struct damon_at=
trs
rather than a struct passed by value. Passing attrs here directly looks lik=
e it
will result in an incompatible type error during compilation.

[ ... ]

> @@ -1572,7 +1566,6 @@ static struct kunit_case damon_test_cases[] =3D {
>  	KUNIT_CASE(damon_test_split_above_half_progresses),
>  	KUNIT_CASE(damon_test_ops_registration),
>  	KUNIT_CASE(damon_test_set_regions),
> -	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
>  	KUNIT_CASE(damon_test_update_monitoring_result),
>  	KUNIT_CASE(damon_test_set_attrs),
>  	KUNIT_CASE(damon_test_mvsum),

[Severity: Medium]
Does removing this test case from the array orphan the newly rewritten test
function above?

Since damon_test_max_nr_accesses() is declared as static and is no longer
referenced by damon_test_cases[], it appears this will trigger a
-Wunused-function warning when compiling the tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708013252.9588=
8-1-sj@kernel.org?part=3D1
