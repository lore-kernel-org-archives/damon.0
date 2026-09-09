Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074130D3FF
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927209; cv=none; b=MoUy3jvQtQlJAalRyZh1P6SsokpiAwKWECBLW7JNk2wp6yYSjKQEhUT16kFDVOOhpDecfn3JCDmbCXIxkDpZaZN1GnX5hnjGGmUg4VJKfL1COoO6Dj1/XnnBclvVF85yYG+JguMZ43ZGmgTrP9GFOXqRVDbIfp+8NETXfY68M74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927209; c=relaxed/simple;
	bh=Q9C2t+puCFzWhB4bPe3Jx9vOBRm+qdtnD38NYHrf/sE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dZ1FZtUmzelPujV8EJM0upGArXiMltqj8nNL1M86OvjzfOT7/jbL6aYv3Xb10NJX16cYuEfZDs0COwnE5G4Dh+vpIhrSG4BrPeG980JhMYueaVPdjmEmbd+bp4XlQr1N0Cg6sTsxm32p4nQ+m6ysgcJhTe5jeOtHhVkpvqgcSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTFc2nKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTFc2nKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB821F00A3A;
	Wed,  9 Sep 2026 04:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927207;
	bh=0r5yGvQvASK0PZZ8/ZcrPRvfrUJ0Rr/Dpulakncb5XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTFc2nKTSJnDotMTbWchwL6KNmNXishUB/JqlQUMQ5G3RqZD1WLQws1ieZV9h5Ofd
	 qqdQ03b+H2Mm9eySbJjKJf2uk/IroRxJTitZbrCMrnq9Ma7kg2v6499OvYgR4HKqVA
	 rpf4Ehl4d7d6MIAx5Nz5yVSX/xLauT8+HKToABZLtUtj1drKwTF0ycDKXmasE59ykO
	 oW/OBmXMQK69fpyjR3IWPjsDrI28QCRFrAmtcjakcWnaDMBcUVuE/TEQAslxWK+BPL
	 oCsxNE1wUTT5K132GfoOkxQDxrTSwHqVJymiiinI5lUUdDN1/uSjwdenyx1NMAHH0k
	 /AwfhXUiuvLwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core-kunit: check region count before
 testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909040016.165245-1-sj@kernel.org>
References: <2026090820-attest-sheep-bc32@gregkh>
 <20260909040016.165245-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:13:26 +0000
Message-Id: <20260909041327.4EB821F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch addresses an invalid pointer dereference in `damon_tes=
t_split_at()` by checking `damon_nr_regions(t) !=3D 2` after a split failur=
e, but misses the exact same vulnerability in `damos_test_filter_out()`, wh=
ich will cause a kernel panic if a split fails.
--

commit eea94ba78cece48ae60d9049e4528675f25050ea
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: check region count before testing in split_at()

The commit addresses an issue in damon_test_split_at() where a failure
during region splitting would cause the subsequent code to dereference an
invalid pointer. By checking if the region count is 2 after the split,
the test now correctly exits early on failure. This fixes a potential
memory corruption issue during test execution.

Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]

> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index a2aa410d6d0d0..f2f0978495086 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -162,6 +162,10 @@ static void damon_test_split_at(struct kunit *test)
>  	}
>  	damon_add_region(r, t);
>  	damon_split_region_at(t, r, 25);
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;
> +

[Severity: Medium]
This is a pre-existing issue, but does damos_test_filter_out() in the same
file suffer from the exact same missing failure check?

If memory allocation fails during region splitting in __damos_filter_out(),
damon_nr_regions(t) remains 1. The test code expects 2, but KUNIT_EXPECT_EQ=
()
does not abort execution:

	/* filter should have split the region */
	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
	damon_destroy_region(r2, t);

Could passing the invalid pointer returned by damon_next_region() to
damon_destroy_region() lead to a crash when it executes list_del() and
kmem_cache_free() on the corrupted pointer?

A similar pattern also occurs slightly later in the same function:

	/* filter should have split the region */
	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
	damon_destroy_region(r2, t);

Should similar early exits be added in damos_test_filter_out() to prevent
this?

>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
> =20
> @@ -169,6 +173,7 @@ static void damon_test_split_at(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
> =20
> +out:
>  	damon_free_target(t);
>  	damon_destroy_ctx(c);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909040016.1652=
45-1-sj@kernel.org?part=3D1
