Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788A383316
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936168; cv=none; b=F2cGF6hbVvLm6EKKrFtwYx6ZGEgTuBM0ygQ3XzjRhyipwr9ik2wLgP50Sy3mTg0pSjhfOmbpSIkpRXxLgLZvuxyjZtzh5GN+sQBq+69yQea2u8gWiRmoy++enNRivfprZa0nXl/VDILBQ31VjPN/e5tZk/MG+VxXZAfcO/mrSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936168; c=relaxed/simple;
	bh=DG43b9fqFGOlnnqKWRG/GDEjX+T31QSyaClwpFkhYA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DP+jc42EWsLi58lt0MyEre0q0mV+v7LJlxMvuXYkFpvYpvKEiN60DLUT57yVKt34HXCq2tJtD6IVBhAsZPhwMdztKnx4uwgRq45hF8mBoWQtRssHWynXrXI3lfHPangLvPrISuVIgtdz/wfvsP212MbPr4o3DTxQM5AGdhMAC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVno648v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVno648v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582411F00A3D;
	Wed,  9 Sep 2026 06:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936166;
	bh=ENfK+PXYs1smDfU84tJtCztXbhYiw3RQaxRIVlWlcVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVno648vHLK8SQYhzs2IWqj4XxPk0aJ6nVfauWY14BU08LcurgpxA5aI7tS5/0zFw
	 Z+irU2C2SVcjQEDqlxraEeffnwbc8jZrnmD0qs2oy2ei59mzYIKfj0YKrvpE9x40kX
	 4/lbga2OJflhgQJP+TeaHgmxZrAPRKoX7kuvcoi7jRV8QtseGY6Eo1ablEYGGzRF2y
	 cAqdhbJgU4eZfJi1gOeWiGGbKpD4p52CqTUJIxIpRWs8TAHa5NOgKUBJ5lEacmy8Fq
	 ij/JMYrNHwD+CweM2aY3846JJyEWj6Fm4XeIq0tnPYe7kz7ujCFJAen88f2RH8xFej
	 5+YEwUbDoJCBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909063159.63420-1-sj@kernel.org>
References: <2026090808-phoniness-repaying-46f0@gregkh>
 <20260909063159.63420-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:42:45 +0000
Message-Id: <20260909064246.582411F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked expectation failure leads to NULL pointer dereference in=
 `damon_do_test_apply_three_regions()`.
- [High] Unchecked expectation failures when splitting regions lead to out-=
of-bounds reads and invalid frees (slab corruption).
- [High] Unchecked expectation failures allow an out-of-bounds read on the =
stack-allocated `expects` array in `damon_test_set_regions()`.
--

commit 3412543f0a4dba58f4602d79dd62e10b9925d6a5
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after its
initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It does a
per-region test with a hard-coded number of regions that is correct only
if the expectation was met.  As a result, __nth_region_of() could return
NULL, and the test code can dereference NULL pointers.  Fix the issue by
catching the expectation failure and skip the per-region tests.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 6687778752728..7a3a923dec7cf 100644
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
This isn't a bug introduced by this patch, but since this patch fixes an
unchecked KUNIT_EXPECT_EQ() failure, does the same issue exist in
damon_do_test_apply_three_regions() in mm/damon/tests/vaddr-kunit.h?

mm/damon/tests/vaddr-kunit.h:damon_do_test_apply_three_regions() {
	...
	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);

	for (i =3D 0; i < nr_expected / 2; i++) {
		r =3D __nth_region_of(t, i);
		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
	}
	...
}

If damon_set_regions() fails to create the expected number of regions,
__nth_region_of() returns NULL, leading to a NULL pointer dereference
when accessing r->ar.start.

[Severity: High]
This is a pre-existing issue, but can unchecked expectation failures when
splitting regions lead to out-of-bounds reads and slab corruption?

mm/damon/tests/core-kunit.h:damon_test_split_at() {
	...
	damon_split_region_at(t, r, 25);
	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

	r_new =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);
	...
}

A similar pattern exists in damos_test_filter_out():

mm/damon/tests/core-kunit.h:damos_test_filter_out() {
	...
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
	damon_destroy_region(r2, t);
	...
}

If the region split fails, damon_next_region() returns an invalid pointer
derived from the list head. Dereferencing it reads out-of-bounds, and
passing it to damon_destroy_region() causes a SLUB BUG.

[Severity: High]
This is a pre-existing issue, but does damon_test_set_regions() have an
out-of-bounds read on the expects[] array if the expectation fails?

mm/damon/tests/core-kunit.h:damon_test_set_regions() {
	...
	unsigned long expects[] =3D {8, 16, 16, 24, 24, 28};
	...
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
	damon_for_each_region(r, t) {
		KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
	}
	...
}

If there are more than 3 regions, the loop increments expect_idx past the
bounds of the stack-allocated expects[] array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909063159.6342=
0-1-sj@kernel.org?part=3D1
