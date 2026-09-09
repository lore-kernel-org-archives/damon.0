Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C833D4E4
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925266; cv=none; b=O7DH70k98/lEkq7qneVSZVtbqDZU7BNpVhgz1QZ3BMyV6KllIY6W2cyEyL6HU5YPpGXhHMIXxJRNmP2l24k8TBK4gJw3KT1Kbvxnp8FrR1PJrEpNf+oAdVKBXWOFk9utq61COe9oga6Vj2HTgO21pYzqDQ/jZ2sBNk8iMAirf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925266; c=relaxed/simple;
	bh=wFnpHDEVqZY3mAbNtmwOVx3bSvMDEy2eKUm6EBxLrWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDlz8QRu/ZHM26XK3meFEKEPYIq7XKOR9Aghrh/DJyGL5Bim/QgjpbNMpba+nbUEQKIRWpiDP7ztDKc20vdT+EpH8K7C6nzraQaFbkBLvspWVvXVAsR8IEkvRKExWWM6P+3kIjmdIkoFJ8cr4lZ0Z+mWDpM5FqvvJEn/E7mb4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNGJsHAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNGJsHAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EB21F00A3A;
	Wed,  9 Sep 2026 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925265;
	bh=o1EtI/aNIoLhJFb2g3Vxo/O71y9hbFb3jntUb/n4Xyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNGJsHAk/usH9PeAEZkYye/JTwKxzYWV9NwQ2XeeJJNEIAPtiiKFkZIENe5AAD3hF
	 m01CjIz332duIsH2BmE1yYxcEWrM24OxHGnJumjet/7KbyZUP2FWURTB7L0d0WkP7D
	 BPH8rI/8iYlyqWz5uLdrV/VGrMIWM4ucuphNhjE9oY4Fb73tA2/lTn4VcIj/cHuPR0
	 n4OV4DAgO6Qdhu6ncS4XeGZnsI8+EMGPMdS9h/sNuF1S0o6f3kvaSEFyKp7+ivmcwh
	 eNCNm7tFj36FtxRMVpR5rZ4Po86QtiEkyfT+lE2zyTTQ5MFDoAXu/d85SKTZD9Q2jq
	 gCU7Xl0QLlvCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909033217.123340-1-sj@kernel.org>
References: <2026090808-snowy-dynamic-3f12@gregkh>
 <20260909033217.123340-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:41:04 +0000
Message-Id: <20260909034104.C8EB21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch is an =
incomplete fix. It addresses an unhandled KUNIT_EXPECT_EQ failure in `damon=
_test_merge_regions_of()` that causes a NULL pointer dereference, but ident=
ical unhandled test failures exist in four other test functions across the =
DAMON kunit test suite, leading to kernel panics and out-of-bounds memory a=
ccesses.
--

commit a4abe0e36a0fa52342ceb358e02a1259ba2ec1d5
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/tests/core-kunit: catch test failure in test_merge_region=
s_of()

This commit fixes a potential NULL pointer dereference in the DAMON kunit
tests by aborting the test execution in damon_test_merge_regions_of() if
the initial KUNIT_EXPECT_EQ() expectation is not met.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index d7737f5df6688..1053d7acd8e45 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -264,11 +264,14 @@ static void damon_test_merge_regions_of(struct kuni=
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
This isn't a bug introduced by this patch, but this fix appears incomplete.
While it addresses the unhandled test failure in damon_test_merge_regions_o=
f(),
would it make sense to apply similar bailouts to other test functions in the
suite that have identical unhandled expectations?

For example, in mm/damon/tests/core-kunit.h:damos_test_filter_out():

    KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
    r2 =3D damon_next_region(r);
    KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
    KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
    damon_destroy_region(r2, t);

If the region fails to split, damon_nr_regions(t) remains 1, and
damon_next_region(r) evaluates to a bogus pointer. Calling=20
damon_destroy_region() will attempt to free this invalid address, causing
a kernel panic.

Similarly, in mm/damon/tests/core-kunit.h:damon_test_split_at():

    damon_split_region_at(t, r, 25);
    KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
    KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
    r_new =3D damon_next_region(r);
    KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);

If damon_split_region_at() fails, damon_next_region() returns an
out-of-bounds pointer, leading to an out-of-bounds read when accessing
r_new->ar.start.

In mm/damon/tests/core-kunit.h:damon_test_set_regions():

    KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
    damon_for_each_region(r, t) {
        KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
        KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
    }

If the region count exceeds expectations (>3), expect_idx overflows the
6-element expects stack array, leading to a stack buffer out-of-bounds
read.

Finally, in mm/damon/tests/vaddr-kunit.h:damon_do_test_apply_three_regions(=
):

    for (i =3D 0; i < nr_expected / 2; i++) {
        r =3D __nth_region_of(t, i);
        KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
        KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
    }

If the resulting regions are fewer than expected, __nth_region_of() returns
NULL, leading to a direct NULL pointer dereference.

Are there plans to catch these other unhandled test failures in a follow-up
patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909033217.1233=
40-1-sj@kernel.org?part=3D1
