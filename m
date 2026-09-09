Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354C26A1AC
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925832; cv=none; b=Nxj5d//pBJtUGSDFL8Lg+CgPcLutLG9Xt1B4PC4RSF5gV9QT+Po4Zlsa7XzdO4I9s0QZHNWYx5M4hSF8lhUfcDyr33+xSAxlHUbZ3sRH5ZPOpKk+vVbqFJ6s1TLkMqpEo/tcta0mcUqGO4zpk6RJIUrlUrCrYaRK0rVwZy4hehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925832; c=relaxed/simple;
	bh=1Iyb+H7MaoR0IduvVIas9q2UMsnabRRcaI8PRrjOfE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l6g4FXWZ1pNQyO05xA2wlesdJzzHWPc30QBEauPvLhr0cvtUMpdChV5XIX9LhvoBaHMNaTfZCBnXKTb9cU8shp9flsRRwxkAZSYOUX7fAg8M9E7w28VzggIUVFt48jzPwuPJt9r/aqKBNdjE7M54HqNI/M6qAiNfbyXMV2/tVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVV4MUqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVV4MUqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83231F00A3A;
	Wed,  9 Sep 2026 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925830;
	bh=AqgT/bxCct/brze6ru1BDo9UGFTFG0g9XOKfMdN5vbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eVV4MUqNHuj39/HTH0sdtnMEhzPAs3eTqA2JZ3fPxu7HpPYzsoqcs/skYD+YZ1ykL
	 qHuSjAMayqwrbrKTCMSGSDAMTzEYsKL85icbMWTsuyTanPel7ylJh+2Tg34xIHsfLY
	 dupU5bErmw16y0j9HGcGhsNfHBr37pC10TN+/hxw2HxHPR+P6xIuVrb4aBOWniajUD
	 OcWdQBc9fTXt3mkVEX1/yTS1CR/FFCUGPzTe30VSzRw+ULAc3SK6TSU/c9VXUZyoD3
	 z02ZenIpg70kD+AQblrLiC2JagZkxU9ZbQMaPkPoRUnrL75Es2nA8aVMjEp2YxlQCB
	 jcX43QLOYAi4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909034038.133054-1-sj@kernel.org>
References: <2026090809-perky-underfeed-c314@gregkh>
 <20260909034038.133054-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:50:30 +0000
Message-Id: <20260909035030.B83231F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The identical NULL pointer dereference bug fixed by this patch in =
`damon_test_merge_regions_of()` is also present in `damon_do_test_apply_thr=
ee_regions()`, making this an incomplete fix.
- [High] Out-of-bounds pointer dereference in `damon_test_split_at()` due t=
o unhandled failure of `damon_split_region_at()`.
--

commit 8d430ac7e5b2f68aa2392c6b505d7132a6bdebdb
Author: SJ Park <sj@kernel.org>
Date:   Wed Sep 9 03:40:38 2026 +0000

    mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

This commit fixes a NULL pointer dereference in damon_test_merge_regions_of=
()
caused by assuming KUNIT_EXPECT_EQ() aborts on failure. It catches the
expectation failure to skip the subsequent per-region tests that would othe=
rwise
crash.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]

> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index c19da2e3d4936..3350293761c4c 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -251,11 +251,14 @@ static void damon_test_merge_regions_of(struct kuni=
t *test)
>  	damon_merge_regions_of(t, 9, 9999);
>  	/* 0-112, 114-130, 130-156, 156-170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> +	if (damon_nr_regions(t) !=3D 5)
> +		goto out;
>  	for (i =3D 0; i < 5; i++) {
>  		r =3D __nth_region_of(t, i);

[Severity: High]
This isn't a bug introduced by this patch, but the identical NULL pointer
dereference bug fixed here in damon_test_merge_regions_of() is also present
in damon_do_test_apply_three_regions() within mm/damon/vaddr-test.h:

	r =3D __nth_region_of(t, i);
	KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);

If damon_va_apply_three_regions() fails to create the expected number of
regions, the target t will contain fewer regions than expected. The test lo=
op
unconditionally calls __nth_region_of(), which returns NULL for the missing
regions. Because KUNIT_EXPECT_EQ() does not abort the test, r->ar.start
immediately dereferences the NULL pointer.

Does it make sense to fix this occurrence in
damon_do_test_apply_three_regions() as well?

[Severity: High]
This is a pre-existing issue, but there is an out-of-bounds pointer
dereference in damon_test_split_at() in this same file (mm/damon/core-test.=
h)
due to an unhandled failure:

	damon_split_region_at(c, t, r, 25);
	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

	r =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);

If memory allocation for the new region fails inside damon_split_region_at(=
),
it silently returns and leaves r as the only element in the list. When the
test executes r =3D damon_next_region(r), its list.next points to the list =
head
(&t->regions_list).

The damon_next_region() macro uses container_of() which subtracts the offset
of the list field, yielding a bogus pointer 16 bytes before the allocated
struct damon_target memory. The subsequent KUNIT_EXPECT_EQ() then dereferen=
ces
this bogus pointer.

Should this unhandled error path be addressed similarly?

>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
>  	}
> +out:
>  	damon_free_target(t);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909034038.1330=
54-1-sj@kernel.org?part=3D1
