Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AE4C92
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334628; cv=none; b=MV6Cr5/sZlwAA8uyGxL+CXFZyP7oD2JS/1HR/CaltGAul+dT5LX2wUiD364EqKFKkzd/EwqVPinhr7Dd+qq7Z0iKw4jui84eJTENVhEN83StBmD/zT7P+ikqoDlKfhjZbBm0+PbV7N805RYo6Rs38T1ZQgsgS8Q4W7ZlphYm/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334628; c=relaxed/simple;
	bh=aThXhkk2zwPTe22+KQY4M6lYx3kmP74i09AOJZwSeHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ja+FZurWL05u7ROAoB69X+bjPR/GyQeEZGIYVvHKLY67ZbN3aRr+PhzXnCqTmhmedo8ZEcEQBOMt+u1pIjDsWe2/aBfQrrmhk8Ac9igumBMp2p4T5mb5o3efqQ63kI0+5Ja7boIBlrN333EZoXtNKbk0SyGqpm4BhG0b2RlnQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W36/K9cY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W36/K9cY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0315D1F000E9;
	Sat, 18 Jul 2026 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334627;
	bh=9MgAWlzdOSoyvbybQ3Fawofe8SLPmORA6XNtoVYYBMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W36/K9cYbHYg9zKIRJABUnLvA855Fywzjbm+7FEz5X+y3Fvn9+mz4lpWd4mz+3/AA
	 N7ymauxU6UvTKzVtZzeX2s+31iwwBeDFu1vRoX9JvUds4l+wmYaLTlLT9MfoTEkz2H
	 v/AKB0yYLX6zFhGy+6y2RUYmxKyjQCuuny7v5/I13HjkfmttlXA1zu5orLFbye/y7o
	 nm/nrEBYThA1yHNQj8y/qOBvKz1G7JYHKeS97eC4qD86cmbltagN+H2vcMMaCc2Sjh
	 tSn4DWou8y9OwXiZPov/z0+OomwovCf/mB4k1NXbyr8v5LKukPj8pUr3radsacvI0d
	 K8rhkYmZRDziw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] mm/damon/core-kunit: check region count before
 testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260718001442.87129-3-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
 <20260718001442.87129-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 00:30:26 +0000
Message-Id: <20260718003027.0315D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent allocation failure inside `damon_split_region_at()` causes =
an improper pointer traversal into the list head in `damon_apply_min_nr_reg=
ions()`, resulting in a potential infinite loop and out-of-bounds memory co=
rruption.
- [Medium] The patch fixes an invalid pointer dereference upon split alloca=
tion failure in `damon_test_split_at()`, but misses an identical vulnerabil=
ity in `damos_test_filter_out()`.
--

--- Patch [2]: [PATCH 2/7] mm/damon/core-kunit: check region count before t=
esting in split_at() ---
commit 97ba538eacadf2d58d517d9d0f86ecaac4b3851f
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core-kunit: check region count before testing in split_at=
()

This commit fixes an issue in the KUnit tests where damon_test_split_at()
could dereference invalid pointers if a region split fails to allocate
memory. The fix tests if the number of regions was changed as expected
and exits early upon failure.

Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index eba643762132f..322a295ac2cec 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -155,6 +155,10 @@ static void damon_test_split_at(struct kunit *test)
>  	r->age =3D 10;
>  	damon_add_region(r, t);
>  	damon_split_region_at(t, r, 25);
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;
> +
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

[Severity: Medium]
This isn't a bug introduced by this patch, but this exact same vulnerability
seems to exist later in this file in damos_test_filter_out().

If damos_filter_match() internally fails to allocate memory during a region
split, the test continues and damon_next_region(r) returns the list head.

mm/damon/tests/core-kunit.h:damos_test_filter_out() {
...
	/* region started before the range */
	r->ar.start =3D 1;
	r->ar.end =3D 4;
	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
	/* filter should have split the region */
	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
	damon_destroy_region(r2, t);
...
}

Should the test also be checking the region count and returning early here,
before we pass an invalid pointer to damon_destroy_region() and corrupt the
slab?

[Severity: High]
This is a pre-existing issue, but I'm also concerned about silent allocation
failures from damon_split_region_at() in core kernel paths.

Looking at damon_apply_min_nr_regions():

mm/damon/core.c:damon_apply_min_nr_regions() {
...
	damon_for_each_target(t, ctx) {
		damon_for_each_region_safe(r, next, t) {
			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}
		}
	}
...
}

If damon_split_region_at() silently fails to allocate memory, it returns
without splitting the region. The while loop then incorrectly advances r
to the next region.

If this allocation failure occurs on the last region in the list,
damon_next_region(r) will return the list head.

The loop condition damon_sz_region(r) > max_region_sz will evaluate memory
located before the damon_target struct.

If those garbage values evaluate to true, could this result in an out-of-bo=
unds
access loop or corrupt memory? Should damon_split_region_at() return an
error code that callers can check?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718001442.8712=
9-1-sj@kernel.org?part=3D2
