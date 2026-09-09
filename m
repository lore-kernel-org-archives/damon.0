Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7551492E37
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927542; cv=none; b=Gi7UbAfpCzB5tzootx/cIfBEeayvuXa4r46KsWRfgBexIxz+8uhj3Ts0Yy+mZxrThjExr7w/M9+OrcZTbUfZuTy4yy3hSNJCagQ/NSr2GxGtBXV9gyi/6IWbq9MFLcHjffPZHfjWY9t860xBH99sE6Rutafd6F8z0yLr0XJ1KAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927542; c=relaxed/simple;
	bh=EwDW/N/SBWHwdhGDIYWxUQGRoMbUM3TbIoiHGJlTyKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8Y1rYIAegz5KJZs80jfS/K6oW/AR9UmOP8+Vd1qLGq4PLe0N1vU85TUMW1iZ2PDbZPwqP91l5PedV0qfK6i6j/cqTG2gd+OK0yCyodOtitdjsOm5OvX6aLAY9/2TKZ7bIK2buHb3zZH52UyAMOq/Ntehl2j8evCuWhcfNFZnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxrpWf7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxrpWf7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D65F1F00A3A;
	Wed,  9 Sep 2026 04:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927540;
	bh=mqvXRNBTXQEfDLNEeJfjjYRjmpV45hS4tnOZ9KWdDxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxrpWf7IO2E+EIAsP09LgWJIkTYhhMB0ezI+bQq84Jo9Q4pxWC/SlbliTB7kKqUrQ
	 R3YUZO3cuk/FFQHMWP433wThdqbmKiAp7qjoadzd8O1uISrc/pM7PGtEovtbwh/xpL
	 qIicerOltAtuFkOp6p3NSJSKRwuiCYXAsWSLPR5xSalgE56vhfRaUAoRW5SNJY/YCS
	 brPE/IJYBF7rXK+1TN+DiG/GuGrjpuY4wOIrH2zb78z8J4hcf1HNdYuxCeaWe7uRt5
	 3TPAmYXQA/ljd7RdZj+Wdkdl1P02PCQgD1Ws3Hs8IcxcSLb8eH227qLheWCSInXVtH
	 hmf3rUd+N68jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core-kunit: handle region split failure
 in filter_out()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909040931.177877-1-sj@kernel.org>
References: <2026090831-handshake-cytoplasm-0b8a@gregkh>
 <20260909040931.177877-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:18:59 +0000
Message-Id: <20260909041900.4D65F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL pointer checks for memory allocations in `damos_test_=
filter_out()`.
- [High] Invalid pointer dereference in `damon_test_split_at()` upon alloca=
tion failure.
- [High] NULL pointer dereference in `damon_test_merge_regions_of()` on tes=
t failure.
--

commit 020584f45aa55bb3f0f5c526132499202f23f3f1
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: handle region split failure in filter_out()
   =20
damos_test_filter_out() test checks if damos_filter_match() of an address
filter splits the region as expected under a given condition.  But, the
test continued regardless of the split successes.  As a result, the later
part of the test could dereference invalid pointers that returned from
damon_next_region().  Further, it could corrupt memory from
damon_destroy_region().
   =20
The consequent user impact (memory corruption) is quite bad.  The
realistic user impact would be limited, though.  It would affect only test
run setups.
   =20
Fix it by exiting early for the number of regions test failure.
   =20
The issue was discovered [1] by Sashiko.
   =20
Link: https://lore.kernel.org/20260718001442.87129-5-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index d7737f5df6688..a9d852e666657 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -552,6 +552,8 @@ static void damos_test_filter_out(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;
>  	r2 =3D damon_next_region(r);
>  	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
>  	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
> @@ -565,11 +567,14 @@ static void damos_test_filter_out(struct kunit *tes=
t)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;
>  	r2 =3D damon_next_region(r);
>  	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
>  	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
>  	damon_destroy_region(r2, t);
> =20
> +out:
>  	damon_free_target(t);
>  	damos_free_filter(f);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this test miss NULL
pointer checks for memory allocations earlier in the same function?

If memory allocation fails (e.g., during KUnit OOM simulation),
damos_new_filter(), damon_new_target(), or damon_new_region() will
return NULL. The returned pointers f, t, and r are immediately
dereferenced without any verification:

mm/damon/tests/core-kunit.h:damos_test_filter_out() {
	f =3D damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
	f->addr_range =3D (struct damon_addr_range){
		.start =3D DAMON_MIN_REGION * 2, .end =3D DAMON_MIN_REGION * 6};

	t =3D damon_new_target();
	r =3D damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
	damon_add_region(r, t);
    ...
}

While this only impacts test environments, KUnit tests should not trigger
kernel panics on allocation failures. This is a standard already followed
by other tests in the same file which safely use
kunit_skip(test, "alloc fail");


[Severity: High]
This is a pre-existing issue, but could this code dereference an invalid
pointer upon allocation failure?

damon_split_region_at() silently returns without splitting if
damon_new_region() fails to allocate memory. In damon_test_split_at(), if
the split fails, r remains the last region. damon_next_region(r) will then
use container_of() on the list head, returning an invalid pointer outside
the bounds of struct damon_target. Dereferencing this pointer reads
memory out of bounds:

mm/damon/tests/core-kunit.h:damon_test_split_at() {
    ...
	damon_split_region_at(t, r, 25);
	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

	r_new =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);
    ...
}

This requires an allocation failure during test execution, which is the exa=
ct
same class of vulnerability that this patch addresses for
damos_test_filter_out().


[Severity: High]
This is a pre-existing issue, but could this test trigger a NULL pointer
dereference on failure?

The test expects 5 regions to remain after a merge operation. It verifies
this with KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);. However,
KUNIT_EXPECT_EQ does not abort test execution if the expectation fails. If
the merge operation results in fewer than 5 regions, the subsequent loop
will call __nth_region_of(t, i) with an out-of-bounds index, returning a
NULL pointer. The NULL pointer is then unconditionally dereferenced by
r->ar.start:

mm/damon/tests/core-kunit.h:damon_test_merge_regions_of() {
    ...
	damon_merge_regions_of(t, 9, 9999);
	/* 0-112, 114-130, 130-156, 156-170 */
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
	for (i =3D 0; i < 5; i++) {
		r =3D __nth_region_of(t, i);
		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
    ...
}

Should KUNIT_ASSERT_EQ be used instead of KUNIT_EXPECT_EQ to safely abort
the test and prevent the subsequent NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909040931.1778=
77-1-sj@kernel.org?part=3D1
