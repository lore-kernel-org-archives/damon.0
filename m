Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2C1A683B
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334552; cv=none; b=PgK0+XBL2Oov1CxAMh0y29qjkUiOguyIW7lOlpMPFQ0kb3Riyl9tSOA8+obsGpKJfKs2aUbdq6dpntF25/nCmjGZvyGucakiPS9eLJgEFSeNKi+05/Ud/Qt4niWJpkXK8dsawPA82vROnqgRS7sk4iaOwihDjRHQgHZeDjlMa+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334552; c=relaxed/simple;
	bh=727G38gNT4qcEkEH1rMARaEqqrpQJmH2/II/MwbQxpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zjckqxb0U07wracw/aYeDw8kVYkTyfn5F9wateU4NreE6WBCdkxW5ifPbGavj1RqHQEpr5gO4BMQ622apZtq/fvM8BBFyrP4uv7NYMAEbrU758a27bWCardx9jhlNtSMVCqAQ5wadJVQVvH+qPLgp0Hab0KsL+RuylQjhjXJTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4+D6vbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4+D6vbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611AE1F000E9;
	Sat, 18 Jul 2026 00:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334550;
	bh=uT9O9v2hyEN7yKT2bklX5iOv1ylMymqVVkx0DK4bOgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4+D6vbIJZxNjzCLpns4cfDKMUPWz9oZoKaLymUwKNJUU7/9sQ3X5eXHu+D3qWvV3
	 pMmPUx/nGI50A+KNqMSVCi9/Sk/Bupe105DN7vYrpEmeTkJPjo+XuX9xTmMwYcuBPO
	 9NCW53+ivwpeEqPcrDq/sjQN842+nRima5/4AzxPdkeIePXBkhwFMM/CfykxMpg/3u
	 M/FbhnCJXUo1ZkDsMG32KyJH+5Z2pbn52czFdt5/DfmSj3Kn9XywNj8fbwKdGnqW6Y
	 06YNeO03BltoAB6K+8vQ5ei25mmLD2iTVFOITV8pO/Ewd3OrAtYp4BR56vA+/sc22/
	 bdQ6M87yNZpOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in
 filter_out()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260718001442.87129-5-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
 <20260718001442.87129-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 00:29:09 +0000
Message-Id: <20260718002910.611AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `damon_apply_min_nr_regions()`, `damon_split_regions_of()`, and=
 `kdamond_split_regions()`, if `damon_split_region_at()` fails to allocate =
memory for a new region, the loop variable `r` is still unconditionally adv=
anced to the next region. This leads to iterating past the end of the regio=
n list, reading from out-of-bounds memory, and potentially causing memory c=
orruption.
--

--- Patch [4]: [PATCH 4/7] mm/damon/core-kunit: handle region split failure=
 in filter_out() ---
commit 8274c3713b297d606d32992612a8cbd24ac04759
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: handle region split failure in filter_out()

This commit modifies the kunit test damos_test_filter_out() to add early
exit checks when damon_nr_regions() does not return the expected value. This
prevents the test from dereferencing invalid pointers if
damon_split_region_at() fails. It fixes memory corruption that could occur
during test runs.

Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 322a295ac2cec..eddf3a0484583 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1365,6 +1365,8 @@ static void damos_test_filter_out(struct kunit *tes=
t)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;
>  	r2 =3D damon_next_region(r);

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a similar pattern in mm/damon/c=
ore.c
where damon_split_region_at() failures might not be handled safely.

In damon_apply_min_nr_regions():

mm/damon/core.c:damon_apply_min_nr_regions() {
    ...
			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}
    ...
}

If damon_split_region_at() fails to allocate memory due to memory pressure =
and
silently returns, does the unconditional call to damon_next_region(r) advan=
ce
past the end of the list?

If `r` was the last region in the target's list, could `r` become the list =
head
and point to memory before the struct damon_target?

If so, the condition while (damon_sz_region(r) > max_region_sz) could read
from out-of-bounds memory.

If the resulting garbage size exceeds max_region_sz, it might call
damon_split_region_at() on the invalid pointer, which could then corrupt the
heap by writing to r->ar.end.

The same pattern appears in damon_split_regions_of():

mm/damon/core.c:damon_split_regions_of() {
    ...
			damon_split_region_at(t, r, sz_sub);
			sz_region =3D sz_region - sz_sub;
			r =3D damon_next_region(r);
    ...
}

And also in kdamond_split_regions():

mm/damon/core.c:kdamond_split_regions() {
    ...
				damon_split_region_at(t, r, sz_sub);
				sz_region =3D sz_region - sz_sub;
				r =3D damon_next_region(r);
    ...
}

Can these paths also wrap around the list and cause out-of-bounds accesses
during memory pressure in the kdamond thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718001442.8712=
9-1-sj@kernel.org?part=3D4
