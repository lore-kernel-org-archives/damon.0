Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A8D531
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925958; cv=none; b=P/V4Vwz0ka46Dgv7M2tH9mD4PgytukfT/OpfHngw7gbMZ/JtBXTxuZqWUcNrBhh+Mgw7bvcqjqgbtlZlJnxwUFFQ8pbPpn7ucM+o8pKsOChHw4ixXfTIEMBEepzPTBQiWCTRvqpZYUZOEl+lLf5f+kj/PqPf4Hi+B4okebIxBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925958; c=relaxed/simple;
	bh=blMzQEkIAtUWCPIaaOe2tzckf7ZzjCHGwcA00dJ+sJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DXhCteAeBIteveuGsTzvwa4zdU8+Eap12wxeCvCzGgR6Y/ZljxBId9NyPGlKc4sXrVrRFOhiCunHuspsAd3nk992iYpHvtoR0gQwBzO5wTlTCOjvdCtGMphL3dCUQnt6o1KMEHGDzWe4AlAyMRvx/hkOcIcXN5qVAUfB7+gMyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9CG0Jge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9CG0Jge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1AF1F00A3A;
	Wed,  9 Sep 2026 03:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925957;
	bh=obReIqf4JYJl1YvwL9WSVGTCJIUaLDU333tXR40Qz5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9CG0JgeiQT6WasV0VaYrHmRY1DYnJLgi0lYLdt9RX0CamL/JOKdisu4rD7bmqrTZ
	 FM/CNtUDsm0gGQjh56OUlSUBGqVdWHvYPtYDsTEQffkWi+rqbKrWWyXwBJoNhZbuAU
	 cT/Dy6Tt6c8JJPmXfUklpub69NyPFXhqH8K4E3IXImhOcsYhF5whrAeX9CZ/7m+slh
	 kbob5giWkKYvT2pW4UeBaKlZJPviNnfVvMgcDUx4Bovb5sYO6wcEakpwbXk9ms08NW
	 w55qLPVV09iXZZtYxEtpd9Fj5mzugyQxuXB//IRojyoPfunxrY/9ybSy0OhicGSrVj
	 LEFiP/oft1SKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909034257.139428-1-sj@kernel.org>
References: <2026090809-vice-ribbon-cf5a@gregkh>
 <20260909034257.139428-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:52:36 +0000
Message-Id: <20260909035237.5A1AF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing failure check in `damon_test_split_at()` assumes `damon_sp=
lit_region_at()` always succeeds, leading to a heap out-of-bounds read if i=
t fails.
- [High] Missing failure check in `damon_test_set_regions()` can lead to a =
stack out-of-bounds array read if `damon_set_regions()` creates more than 3=
 regions.
--

commit 734d67a5ef8e651363b657168887a0a497532892
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met. This commit fixes a potential NULL pointer
dereference in damon_test_merge_regions_of() by explicitly checking the
number of regions and skipping the per-region test if it doesn't match
the expected value. The user impact on realistic setups should be negligible
as it is a unit test.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]

> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index d8fef225930a5..094714172e581 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -253,11 +253,14 @@ static void damon_test_merge_regions_of(struct kuni=
t *test)
>  	damon_merge_regions_of(t, 9, 9999);
>  	/* 0-112, 114-130, 130-156, 156-170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> +	if (damon_nr_regions(t) !=3D 5)
> +		goto out;
>  	for (i =3D 0; i < 5; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
>  	}
> +out:
>  	damon_free_target(t);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since the patch specifically
aims to fix missing test-failure aborts, there is a similar missing failure
check in damon_test_split_at() that can lead to a heap out-of-bounds read:

mm/damon/core-test.h:damon_test_split_at() {
    ...
    damon_split_region_at(t, r, 25);
    KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
    KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

    r =3D damon_next_region(r);
    KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
    ...
}

If memory allocation fails internally in damon_split_region_at(), the region
is not split. KUNIT_EXPECT_EQ() records a failure but does not abort
execution.

Will the test unconditionally execute r =3D damon_next_region(r) in this
scenario?

Because the region was not split and remains the only element,
damon_next_region() evaluates to an invalid list head pointer. Could
dereferencing this to read r->ar.start cause a heap out-of-bounds read?

[Severity: High]
This is a pre-existing issue, but it shares the exact anti-pattern that the
patch fixes nearby. Another identical omission exists in
damon_test_set_regions():

mm/damon/core-test.h:damon_test_set_regions() {
    ...
    damon_set_regions(t, &range, 1);

    KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
    damon_for_each_region(r, t) {
        KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
        KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
    }
    ...
}

If a logic bug in damon_set_regions() outputs 4 or more regions, the test
continues without aborting.

Since the test unconditionally loops over all regions via
damon_for_each_region(r, t) and accesses the 6-element static array expects,
can this exceed the array bounds?

Would using expects[expect_idx++] twice per loop lead to a stack out-of-bou=
nds
read if more than 3 regions exist?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909034257.1394=
28-1-sj@kernel.org?part=3D1
