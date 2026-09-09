Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12622492E34
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925590; cv=none; b=snRWtbPTpiMv+jtH3JWAoM1irv11eal3eay3fHDaNE/bYrqONMDBCF9tnwOYZFxEV0vys1FTxaYlUtbfpsGy/X5lkqLUAgBROn/J97FssPy3hQtdJF4c1uWUaz9X8nciMV1KzAvVuO9O5YMBwPwlHOj6SFLHu9eYLNLdwoDC+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925590; c=relaxed/simple;
	bh=NpoUsCt/6CqrOzi10kEOb38tpIaEqz3C4ue1SqzeZSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbEDDNOUuhtNPjh9EJBSt8bioXV2M/hQwjZVp6NzH9MUbz+9RXdz1G+j8Xfk9eUsguFrHfftT7Q/c9CdHbANLk4zzKCu/tjL0KcJBNtUt3cQ6ccMW+LQoqEkJVDiu9IXKBnkTeIaNzSZksUQ5UOmz5J8XQnXKB/2jhboaXgy8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFJN6pTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFJN6pTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876A21F00A3A;
	Wed,  9 Sep 2026 03:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925588;
	bh=rIFeej3Q0gseXNi7Es9WYHpry64RZYdFxWItRwNIsc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFJN6pTkAhy8T6V1vZbIz1mmpv8dtiDwBweMHppmVhllVPjTv3OpVYA85SrVddKVE
	 gaO8uR8+N5LrscXQ3dOw7op3THEqrBUGggGI8D20lVYQrVC7M9vrUeGqBVPAFVcScS
	 J6E3CswdFk0NiT6PPCVLqUw7P1il9E5hTYO+rtF4Yiaf0q5yU4Xl5iJGj9EF24clA/
	 8+a4dk5syhFIS1PNBSbfArIcjZpSfM5z+oJ3p8tiNgceKEVGA67X5usHoOgFqtzH2D
	 sWIIoxmqPY2mTZ+WBwp0qjU2T8qLUK+0Oxp0uUOEmSFIUDxqHnp1nY4ZVSZ1SxvPXZ
	 +gO4RMotlVpwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909033449.123677-1-sj@kernel.org>
References: <2026090808-subscript-extortion-d6f9@gregkh>
 <20260909033449.123677-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:46:28 +0000
Message-Id: <20260909034628.876A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses a missing execution abortion on expectation fa=
ilure in `damon_test_merge_regions_of()`, but fails to fix identical vulner=
abilities in several other test functions where unmet expectations or faile=
d operations lead to invalid memory accesses, out-of-bounds reads, and kern=
el heap corruption.
--

commit 6344f23ed0a644a799bb1ef7adb4c771a412bbdc
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after its
initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  Fix the iss=
ue
by catching the expectation failure and skipping the per-region tests to
avoid NULL pointer dereferences.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]

> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index a2aa410d6d0d0..2e191cc4a1b3d 100644
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
This is a pre-existing issue, but this patch addresses the missing execution
abort for damon_test_merge_regions_of() while leaving identical issues
in other test functions.

In mm/damon/vaddr-test.h:damon_do_test_apply_three_regions():

	for (i =3D 0; i < nr_expected / 2; i++) {
		r =3D __nth_region_of(t, i);
		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
	}

If the target holds fewer regions than nr_expected / 2, could
__nth_region_of() return a NULL pointer, leading to a NULL pointer
dereference?

In mm/damon/core-test.h:damos_test_filter_out():

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
	damon_destroy_region(r2, t);

If the region split fails, does r remain the last element?  If so, would
damon_next_region(r) return a pseudo-pointer derived from the list head,
causing garbage reads and potentially corrupting the kernel heap during
damon_destroy_region()?

There is also a second instance of this in damos_test_filter_out():

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
	damon_destroy_region(r2, t);

Does this second unmet region split expectation also cause a pseudo-pointer
to be passed to damon_destroy_region(), crashing the system?

In mm/damon/core-test.h:damon_test_split_at():

	r =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);

If damon_split_region_at() fails silently, does damon_next_region(r) return=
 a
pseudo-pointer that is immediately dereferenced, causing an out-of-bounds
read?

In mm/damon/core-test.h:damon_test_set_regions():

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
	damon_for_each_region(r, t) {
		KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
	}

If damon_nr_regions(t) is unexpectedly greater than 3, will the loop execute
more times than the size of the 6-element expects array?  Could this cause
expect_idx to overrun and trigger an out-of-bounds stack read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909033449.1236=
77-1-sj@kernel.org?part=3D1
