Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851335AC2F
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926449; cv=none; b=PT00+b3QYqigEVnYlZGdnepFRVMdW4N1j4YUaaFTWLam2l6GGili2ImyeRQhd7I2wlMkZTH/sSqtE8D8y6lhrus71MQouxJSzc6oivr1TapctGyQlKuGIEKUOBi3yT5SDe4k/+a/q21iennd5ynp6HItctNdCM1hrU41xWTGfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926449; c=relaxed/simple;
	bh=KZTH/HE5EA2blV847vZLalzs7gMy4oU8ezHSozWzGQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tVYOmNYzr1HKH9FjYUKUIlrrhkdG+Db7CIt0SUaLy3INkOM3OmcQiXpA63iggd07LL0y+uNjudsfFEh25nYNO7KtzMAItrcaFW7h8nqN5miCbVjpJahD2qnzy8MB0ykz5VFsU8Q5jXFMCZQq/Pjui2LJOuYFyW6p14BDoe0+tgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrFH2kzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrFH2kzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9871F00A3A;
	Wed,  9 Sep 2026 04:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926447;
	bh=jIthEmXFQoqIX4lPFXhJMmtz9iKOf1P6gUcAERVbXBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrFH2kzMFsIYPcmBo0fPYfSa9SUGH/XNnKC4Gz7vV7AgDx132z8JWIs3flYK0NqAw
	 3CUmsmF9fq5wFV5wVtYiBRTUvqEJrAhENX3yzjnQKRMiiU8C+m1YcATLYhPgFztaQv
	 qJlWUOzBlGclTpzhsaML9eLgvwqai+c3vRNY6B4i5Vs7hOCwiabBWVX9wcFXD+DPst
	 6FuEZQclpNyTDfgFiDNXvmVORWklnNTNIDdZ38952kstqNwe6uVO9pg+OiGpsXuQRf
	 9Z1pSmMq8D5eu5yJRuTEdzYThsm4AO2DB6yHjBNW1bYcdwLsvbrXsMvWuvHa6dqx5V
	 Wj286E5KPgDSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/vaddr-kunit: check region count in
 three_regions test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909034702.147367-1-sj@kernel.org>
References: <2026090820-flakily-douche-e51f@gregkh>
 <20260909034702.147367-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:00:47 +0000
Message-Id: <20260909040047.9F9871F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing maple tree preallocation before calling `vma_mas_store()` =
in `__link_vmas()` can trigger a `BUG_ON()`.
- [High] Out-of-bounds read in damon_test_split_at on memory allocation fai=
lure.
--

commit 2d4b725be5cfa292d091f09d09b2d8ec22b7965e
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr-kunit: check region count in three_regions test

This commit fixes a potential NULL pointer dereference in the DAMON kunit
tests. It ensures that damon_do_test_apply_three_regions() checks if the
expected number of regions was successfully set before iterating over them,
exiting early if the allocation failed.

Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]

> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index dda3c186ffefe..bed92599e9782 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -141,12 +141,17 @@ static void damon_do_test_apply_three_regions(struc=
t kunit *test,
> =20
>  	damon_set_regions(t, three_regions, 3);
> =20
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
> +	if (damon_nr_regions(t) !=3D nr_expected / 2)
> +		goto out;
> +
>  	for (i =3D 0; i < nr_expected / 2; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
>  	}
> =20
> +out:
>  	damon_destroy_target(t);
>  }

As a side note, looking at __link_vmas() earlier in the same file:

mm/damon/vaddr-test.h:__link_vmas() {
...
	mas_lock(&mas);
	for (i =3D 0; i < nr_vmas; i++)
		vma_mas_store(&vmas[i], &mas);
	mas_unlock(&mas);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
vma_mas_store() repeatedly here without any preceding call to
mas_preallocate()?

If dynamic node allocation fails under memory pressure during
mas_store_prealloc(), mas_wr_store_entry() sets an error state on the
maple state.

mas_store_prealloc() concludes with a BUG_ON(mas_is_err(mas)), which
will panic the system when damon_test_three_regions_in_vmas() runs.

Also, looking at damon_test_split_at() in mm/damon/core-test.h:

mm/damon/core-test.h:damon_test_split_at() {
...
	damon_split_region_at(t, r, 25);
	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

	r =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
...
}

[Severity: High]
This is a pre-existing issue, but could this cause an out-of-bounds read if
damon_split_region_at() fails to allocate memory for the new region?

If damon_split_region_at() fails, it returns silently without splitting the
region. When damon_next_region(r) is called, list.next points to the list h=
ead
(&t->regions_list) since r is the only item in the list.

The container_of macro then yields an out-of-bounds pointer located before
the start of the damon_target struct. Accessing r->ar.start will read adjac=
ent
slab memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909034702.1473=
67-1-sj@kernel.org?part=3D1
