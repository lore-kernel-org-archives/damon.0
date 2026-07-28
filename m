Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965B2D8364
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216826; cv=none; b=HDv3VmFeZEfJ2D8p4TGASPKJzdtn8b8ZkxtvC8E3eVDVJmzkpykoLB8+4ddWUsqfhGHlmoXi3MZxf+k9IPfwCzMQIp6bL1sOUN4tMMv8LbtuWRyWoKCxfu2hi3Zq2qf3gyNXkAao6r2eoI0ZniaKae0nECGoJAa4ePlZ8cRnsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216826; c=relaxed/simple;
	bh=luCat/qIFjRzl3hrD25AsQzb6uCsRvK44oyKZ5IL278=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dbxi5v0aMWhrcHqW169LurMb85B6amW2Md1dRj8bVhfGZ9cbqwxxpL2MJdZJqzJrtuUOqmSLrHLr9kqTiy22wbg078nydgqmZF/Y/fLrz7WRUHrUExbwfIBOtLyNmKML76WkMA47owulUlrgfTyVZ3VfPDeUvqFcFbmybCzEQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK5b4Hsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK5b4Hsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42901F000E9;
	Tue, 28 Jul 2026 05:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216824;
	bh=buOEjON6uKdYkVmwt8Ylt76lD7+ys0DIcuQHaJoeQak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dK5b4HshvcHbtyq5peUykPvv/Q+hvj57C2G7MQH8cfYe8oM6lf6J4zKb7aDVcqVt+
	 UURFnvOPygZ9NhjuAg43buylcm6HpFNYf9Xd7neqE71nD0PWvCW0+TUi09sjGhLn84
	 M+GP/UIvbG/7WcUnQ2n/2wVTe7Ttc4QPduibF+YNjH0VYqGRWOME8OEZYRp0f9UYm6
	 0awT0R/Rpupz8pc7K7piHh72u01PgEIC+HbJxh5OS57AuddgQNfP0zzCYXPAGLWzf5
	 Hxm1m40iw3Hu/DEtcd2qRzU60wqvIyD14vQNBF81ih7VgiMuXwrZdeoOj4vcwNTAvE
	 wJq4IycESZEiw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/10] mm/damon/tests/core-kunit: test
 damon_nr_samples_per_aggr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728052811.192712-8-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
 <20260728052811.192712-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:33:44 +0000
Message-Id: <20260728053344.A42901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `damon_test_nr_samples_per_aggr` test uses tauto=
logical assertions that will always pass, failing to detect the regressions=
 it was intended to prevent. Additionally, the test setup overflows to zero=
 on 32-bit architectures.
--

--- Patch [7]: [RFC PATCH 07/10] mm/damon/tests/core-kunit: test damon_nr_s=
amples_per_aggr() ---
commit 50a7320dda40ca169bc23924caa1421599f78314
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()

This commit adds a kunit test for damon_nr_samples_per_aggr() to ensure
that extreme interval setups are handled properly without returning zero
or random overflowed values.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 3041b8288ec26..511f2856d343c 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> +static void damon_test_nr_samples_per_aggr(struct kunit *test)
> +{
> +	struct damon_attrs attrs =3D {
> +		.sample_interval =3D 0,
> +		.aggr_interval =3D 0,
> +	};
> +
> +	/* Zero aggregation interval doesn't cause division by zero */
> +	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
> +
> +	/* Too large aggregation interval doesn't cause overflow */
> +	attrs.aggr_interval =3D (unsigned long)UINT_MAX + 1;

[Severity: Medium]
On 32-bit systems where unsigned long is 32-bits wide, does this assignment
overflow to 0?

If it overflows, the test would configure an interval of 0 instead of a val=
ue
larger than UINT_MAX, failing to test the large-interval scenario.

> +	KUNIT_EXPECT_GE(test, damon_nr_samples_per_aggr(&attrs), 0);
> +	KUNIT_EXPECT_LE(test, damon_nr_samples_per_aggr(&attrs), UINT_MAX);
> +}

[Severity: Medium]
Since damon_nr_samples_per_aggr() returns an unsigned int, are these
assertions tautological?

An unsigned int is inherently always >=3D 0 and <=3D UINT_MAX. This means t=
he
test will pass regardless of the function's return value, and it wouldn't
catch if the function unexpectedly returned 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052811.1927=
12-1-sj@kernel.org?part=3D7
