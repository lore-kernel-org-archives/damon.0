Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98E2931D0
	for <damon@lists.linux.dev>; Wed, 15 Jul 2026 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085550; cv=none; b=WPpyW6+6hbZW3nL2XhUlua3UyWI934cu+tUKvQytSHIzsvFjNN0mZUrMi5VxaNL33eZ2IYi4qCX8ddaGtinku01ZMtmzJ8cCULjMhMLAPnry6xXxG81VuFDrNm+tpHB68Dt2qlIZs7758szrtGI9YVyHaN9jV50QKULBvlgb17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085550; c=relaxed/simple;
	bh=r9TO2tVPxEj5fsclUTqLRtdXD9/dF0FgXHH8mW/AH/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUdpNVvyzQHzyR/RbGS+T6uve9+ZE+2leDnasylyAGLZJdWQ82lf5iMWgSBt63hPZSAY53UggeU3gjwG9VWM0ch3k0hc0zyyINn4aSqEFayhI0wvJoRaGWK3UwWcALLmn3S4NED0a1utjuFXPtDj6pzJXRsWpgkE81S9sXMMdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl7pbzPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl7pbzPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683501F000E9;
	Wed, 15 Jul 2026 03:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085548;
	bh=0Vna8O5R9wGfL5yq3c2nZTYhNog7Ot68sGVH8koPtmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cl7pbzPH5sxsuuB++bbeQIl+2wplhvrsmADdp+qJCKS7VRVguAYbqw4TafgFbbWK/
	 zb1OTjBW2KAJyI6MIUOmREoRWDdmNKF6GKS0iczRHUB3QTclOITfc1/26dUdbBss0b
	 W/Flmmk+5p3ta0rFh22zsWen8iacqePkKCU+HLgEOisZq2ws6AHCMkZpRp/E8I+cWb
	 fGus+qUD1C14OJFGFcuEQ3g9HOBIOUQTgZz7vQ0jwNHU1mOutOWiL1xS1VwKDrWg1n
	 /O7pSFv+/thP+iWfNCa0tXOQqb/u3rQu6P4wqCwnL9ENpR9uv2e8t2luIbgbBGR2L6
	 nR+J4T6bJzAxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 2/6] mm/damon/tests/core-kunit: catch test failure
 in test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260715031002.108504-3-sj@kernel.org>
References: <20260715031002.108504-1-sj@kernel.org>
 <20260715031002.108504-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 03:19:07 +0000
Message-Id: <20260715031908.683501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch correctly identifies that `KUNIT_EXPECT_EQ()` does not=
 abort test execution on failure, which causes undefined behavior in subseq=
uent code if the test expectation is not met. However, it leaves the exact =
same anti-pattern unfixed in several other test helper functions within the=
 DAMON test suite. This can lead to out-of-bounds (OOB) array reads, NULL p=
ointer dereferences, and slab corruption when test failures occur.
--

--- Patch [2]: [PATCH v1.1 2/6] mm/damon/tests/core-kunit: catch test failu=
re in test_merge_regions_of() ---
commit ce2690fbbc97573d0a06744653f652063e18c91b
Author: SJ Park <sj@kernel.org>
Date:   Wed Jul 15 03:09:57 2026 +0000

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

This commit fixes an issue where KUNIT_EXPECT_EQ() failures do not abort
the test, leading to potential NULL pointer dereferences in subsequent
code. It addresses this in damon_test_merge_regions_of() by explicitly
checking the expectation and skipping the rest of the test if it fails.

Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 485472ddebd19..eba643762132f 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kuni=
t *test)
>  	damon_merge_regions_of(t, 9, 9999, ctx, true);
>  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
> +	if (damon_nr_regions(t) !=3D 6)
> +		goto out;
>  	for (i =3D 0; i < 6; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
>  	}
> +out:
>  	damon_free_target(t);
>  	damon_destroy_ctx(ctx);
>  }

[Severity: Medium]
This is a pre-existing issue, but while you are fixing this anti-pattern
here, the exact same missing abort condition exists in several other
functions within the DAMON test suite.

For example, in mm/damon/tests/core-kunit.h:damos_test_commit_dests_for():

    KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
    for (i =3D 0; i < dst.nr_dests; i++) {
        KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);

If the expectation fails, could this loop read out-of-bounds on
src_node_id_arr since it iterates based on dst.nr_dests?

Similarly, in mm/damon/tests/core-kunit.h:damon_test_split_at():

    r_new =3D damon_next_region(r);
    KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);

Could damon_next_region() yield an invalid pointer if the split fails,
causing a crash when r_new->ar.start is accessed unconditionally?

The same unbounded array access or unsafe pointer dereference pattern
appears to exist in:
- mm/damon/tests/core-kunit.h:damos_test_commit_quota_goals_for()
- mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for()
- mm/damon/tests/core-kunit.h:damos_test_filter_out()
- mm/damon/tests/vaddr-kunit.h:damon_do_test_apply_three_regions()

Would it make sense to update these remaining occurrences in a follow-up or
v2 of this patch to prevent slab corruption or NULL pointer dereferences
during test failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715031002.1085=
04-1-sj@kernel.org?part=3D2
