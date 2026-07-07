Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BF318BA6
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432944; cv=none; b=ViWhQdF806AjLVYPtQ306JaUw6L+Zw8gsoAbPHQMd6pU1caCs967R6DPVX2FdO4a8a8AIKrJxKerYM1dualeWCl8Qzk0NlsBBhp0PeaPce5diqWlYH8mQPv58fKTYAIsmyS5OMDGKUTlcqwBz/PZmrlbVhmbYhG64Bg5+letC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432944; c=relaxed/simple;
	bh=3fEeERq126u6rmjt2ISa55I+MmzI4p8hSgNboYHLB84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EbUu7RBBSrfBkgt2oOQGJP32CedRmkmJHUtSEwRth+vCcDopg+V4V0cn7pzvkOuLgUJYiKNQmFN076tHITVZcghU3cGWTIfBN2IE++XWTQFubzyhqmh5ydHhIKuEDmrrf2liubKDpNkf4gyyJn4pwx35Z4q1JVxN04McILRiIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1hSMaik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1hSMaik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E91F000E9;
	Tue,  7 Jul 2026 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432942;
	bh=kDzWO7VXojvmHgHScIOvosV5CKWHe24qyK02sbY4kRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1hSMaiki8vOqG6kpQsjFiqPDWBsrxxcQ9FzYnKR37F5alaDxw3h5GyA3w4D+cMsY
	 VXFAdYUrvn19IdQenQyUDQpdgiUWIt17g6ipD4seaT6MYtX3khVdOVAm0nbYKW4F2+
	 DRkUhl6EWFBZ/wXTFmOx+dM97iHeOE9sZLvsE8fJEwQAQPCb/q5D38OK3xYghv7+nN
	 mQZpXI7ZFBHcsVcJPNV+/FZdIC57bA71OmmfvXYKOIib8fOmMfX26mHkVn0EQyHQQE
	 SLUu9QvqRtcAka39r1xmt/UD71/aWB06Rnc7sM71WaBbX3ou+c54v0KbCoYJ8m46LF
	 HagQELsExtF9Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 4/7] mm/damon/core:
 s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260707135038.90068-5-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
 <20260707135038.90068-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:02:21 +0000
Message-Id: <20260707140221.DD3E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The KUnit test `damon_test_sample_count_to_bp` unconditionally f=
ails on 32-bit architectures due to integer overflow in `aggr_interval` ini=
tialization.
- [Low] The commit message erroneously claims to remove an obsolete divisio=
n-by-zero comment that is not present in the patch diff.

Pre-existing issues:
- [High] Arithmetic overflow in `damon_sample_bp_to_count()` and `damon_sam=
ple_count_to_bp()` on all architectures when `nr_samples_per_aggr` is large.
--

--- Patch [4]: [RFC PATCH v1.1 4/7] mm/damon/core: s/nr_accesses_to_accesse=
s_bp/sample_count_to_bp/ ---
commit 3660ea5f51f638ba678520c22cb275f27a0966b1
Author: SJ Park <sj@kernel.org>
mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/

This commit renames damon_nr_accesses_to_accesses_bp() to
damon_sample_count_to_bp() to better reflect its behavior. It also mentions
removing an obsolete division-by-zero comment.

>     Also remove the obsolete comment about division-by-zero.  Commit
>     35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
>     damon_hot_score()") modified damon_nr_samples_per_aggr() to always
>     return non-zero.  Hence no division-by-zero of the note can happen.

[Severity: Low]
This isn't a bug, but the commit message states it removes an obsolete
division-by-zero comment. However, this comment does not appear to be
removed in the diff below. Was it already removed by an earlier commit
in the series?

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index dea63083917b0..718268df27fa7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
>  	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
>  }

[Severity: High]
This is a pre-existing issue, but can this multiplication silently
overflow on architectures where unsigned int is 32-bit?

If a privileged user configures DAMON attributes via sysfs such that
aggr_interval / sample_interval > 429,496, damon_nr_samples_per_aggr()
will return a large 32-bit unsigned integer. The multiplication
bp * damon_nr_samples_per_aggr(attrs) could then exceed 32 bits, resulting
in incorrect sample counts and potentially flawed memory management policie=
s.

> =20
> -/* Convert nr_accesses to access ratio in bp (per 10,000) */
> -static unsigned int damon_nr_accesses_to_accesses_bp(
> -		unsigned int nr_accesses, struct damon_attrs *attrs)
> +/* convert sample count to ratio in bp (per 10,000) */
> +static unsigned int damon_sample_count_to_bp(
> +		unsigned int count, struct damon_attrs *attrs)
>  {
> -	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
> +	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This is also a pre-existing issue, but does mult_frac() run into a similar
32-bit overflow?

The mult_frac macro evaluates the remainder multiplication (count * 10000)
as a 32-bit unsigned int. If count >=3D 429,497, this could overflow, leadi=
ng
to a flawed ratio calculation.

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 224a3ecaa0701..9e631b19b184a 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -575,14 +575,14 @@ static void damon_test_set_regions(struct kunit *te=
st)
[ ... ]
> -static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> +static void damon_test_sample_count_to_bp(struct kunit *test)
>  {
>  	struct damon_attrs attrs =3D {
>  		.sample_interval =3D 10,
>  		.aggr_interval =3D ((unsigned long)UINT_MAX + 1) * 10
>  	};

[Severity: Medium]
Does this test initialization unconditionally fail on 32-bit architectures?

On 32-bit systems, unsigned long is 32 bits, causing ((unsigned long)UINT_M=
AX + 1)
to wrap to 0. This makes aggr_interval =3D 0.

> =20
> -	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
> +	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(123, &attrs), 0);
>  }

Because aggr_interval is 0, damon_nr_samples_per_aggr() safely returns 1.
The call to damon_sample_count_to_bp(123, &attrs) then computes
123 * 10000 / 1, which evaluates to 1,230,000. This would fail the
KUNIT_EXPECT_EQ assertion that expects 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135038.9006=
8-1-sj@kernel.org?part=3D4
