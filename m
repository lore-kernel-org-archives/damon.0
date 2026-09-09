Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BE1EB5E3
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926408; cv=none; b=skLj3BJDtycl02K1KIW7/rm5rFx/d5YTrWbuORMFo5mlSY/GOrGYqYaOhKAhHzwnIUb/5/xmxzJfC/lEMGaW/Md1kaQ3LNzk6jpzjA4IHZOk1byAKKnFTHm7TDM8xTDGDs0j61bV78FScdnDPgC/u44jHIkmgteamiDnE3/h1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926408; c=relaxed/simple;
	bh=3/1tX/h2Ls6dIPUPoGXbVVnVvy808IKZ52ZMh7J1Ebc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n1JHKvE/IApDdx8JmXfAVU8MPeDG1MjyGdH4L2BqVOcG4ezRrOS3NHAfiA5TZtKDS4Hl6hqpyF2u6O3/ThoShmHMzCQY9xWTmFxRRPm/ulBmCtsXp09cW+Uciuf3Ha5yMqGGMAHX8Iy1wFGMvQLXUdiEzSGSIvO1jPfLsO5B1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLkVhrZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLkVhrZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7CE1F00A3A;
	Wed,  9 Sep 2026 04:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926407;
	bh=gOsMA634D0vVUcRGxbp0qSUB1iSKicIC9+h0OArLHZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLkVhrZbHtkPQDCDfgVCA/JAptF6agihLu/f8nW55a495fcooZ9D9YkdWT6pDrrKM
	 T9TM9ulPP0f3KGmUexr1FGH5epY68H12ZCXLUTjbYbOdu0DHrK/4lL5lrnvBngFjhq
	 F4i7tgl/+L9/Ts+ec8b2bhYBylYPkXF4cryOzlxRtoyERFGc+CPewOeQw4DbkIHDs1
	 WRBgG9IoiXkAuUiJtGkH7nZnvcZxejARA2CHICA1e17TFjSGfCAEK6V+id2bDBj2BB
	 PX9yQbyNoK8BuPd6sU6ujktzAyahuxFIp91xfyQs4qWpIF0CXuXncDIHXzFjLKs8oM
	 DXoVP7PnhIAww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/vaddr-kunit: check region count in
 three_regions test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909034903.150500-1-sj@kernel.org>
References: <2026090820-shadiness-speculate-ce42@gregkh>
 <20260909034903.150500-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:00:06 +0000
Message-Id: <20260909040006.DA7CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing early exit on region count mismatch can lead to a NULL poi=
nter dereference in damon_test_merge_regions_of().
- [High] Missing early exit on region count mismatch can lead to out-of-bou=
nds array read in damon_test_set_regions().
--

commit 3ac2a42fcb13001506625ee82bd4439b241b1513
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr-kunit: check region count in three_regions test

damon_do_test_apply_three_regions() iterates regions after a=20
damon_set_regions() call assuming the region count matches the expected=20
number. If it fails, __nth_region_of() can return NULL, leading to a NULL=20
dereference during the test. This commit fixes the issue by explicitly=20
testing if the number of regions changed as expected and exiting early on=20
failure.

Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]

> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 292736d3f3954..c0546447b21e6 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -149,12 +149,17 @@ static void damon_do_test_apply_three_regions(struc=
t kunit *test,
> =20
>  	damon_set_regions(t, three_regions, 3);
> =20
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
> +	if (damon_nr_regions(t) !=3D nr_expected / 2)
> +		goto out;
> +

[Severity: High]
This isn't a bug introduced by this patch, but since we're fixing missing=20
early exits on region count mismatches here, there are similar vulnerabilit=
ies=20
in mm/damon/core-test.h that might need the same treatment.

In mm/damon/core-test.h:damon_test_merge_regions_of():

	damon_merge_regions_of(t, 9, 9999);
	/* 0-112, 114-130, 130-156, 156-170 */
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
	for (i =3D 0; i < 5; i++) {
		r =3D __nth_region_of(t, i);
		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);

Can this lead to a NULL pointer dereference?=20

If damon_merge_regions_of() produces fewer than 5 regions due to a test=20
failure, KUNIT_EXPECT_EQ logs the failure but continues execution. The loop=
=20
attempts to fetch the 5th region using __nth_region_of(), which returns NUL=
L.=20
Dereferencing r->ar.start then causes a panic.

[Severity: High]
This is a pre-existing issue, but there is also a potential out-of-bounds=20
read in mm/damon/core-test.h:damon_test_set_regions():

	unsigned long expects[] =3D {8, 16, 16, 24, 24, 28};
	int expect_idx =3D 0;
...
	damon_set_regions(t, &range, 1);

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
	damon_for_each_region(r, t) {
		KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
	}

Can this lead to an out-of-bounds array read?=20

If damon_set_regions() produces more than 3 regions due to a bug in the=20
tested logic, KUNIT_EXPECT_EQ logs a failure but continues. The loop=20
damon_for_each_region(r, t) then iterates over all regions, causing expect_=
idx=20
to exceed the bounds of the 6-element expects[] array when accessing=20
expects[expect_idx++].

>  	for (i =3D 0; i < nr_expected / 2; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
>  	}
> =20
> +out:
>  	damon_destroy_target(t);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909034903.1505=
00-1-sj@kernel.org?part=3D1
