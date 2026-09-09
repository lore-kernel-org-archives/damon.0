Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2ED21CFE0
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926485; cv=none; b=qGKTg5RdgpdryOkLKb+cX+pHPkZtxXz5Q6L4iRwIhbHG05FBh6+IY9w+Px5xGYUc8in2zoqtfDklYFzDZPuCLQDkSOT4WAzWI8s79L+K3Tav6LPi2/1CTD8Gb1xAjL9JvnffQptNzXvGjRh0tW9ZmOqSS9CYJu4o85yNFTX5M4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926485; c=relaxed/simple;
	bh=QEOHhrWH6VTUWA8dUtCjjiwDxzlU2bxI1+FEhP0Ymdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pEpZt85HkflrJjwdNDZ8g7MlkdSLt2Oqu4dqvPUUXcCwViPlIYiHPt1eUxZCjlAMBXBP/4gDyaq9RWY2yxFv57KGr9hWXdEf1cbJyLagbOSD+kHtAnbfaLFvj9gWt6W5KY60Ijb9H274log+4f9UVE+ErSy0rqW7/WjzojDvACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiTmdO5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiTmdO5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B2D1F00A3A;
	Wed,  9 Sep 2026 04:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926483;
	bh=8EbzBM1VGtbNgl4Yvdzxq1TN4yTdmoAKSd6EoDpai+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oiTmdO5B1YHdVGWzq5VWOQ/McrsQYql/T+L64fMr/XRf7uVFUsyfCvRaOzeOfcOjL
	 VTR4ZKQqldI8I7S/ywlZdrCF6fbASbMozJ6sfKaRFDAeVZNSoDUP7Pk5VkQn3KuDAR
	 BpGs8S917jGvwVTY9+HIHHqFNujoaH0vJut0seWzJ61tRi3M+L43+9PsD6N0piVaso
	 Djnvuigq2s+WxyBanOf9JbDUl+EUSdX5ZGGn7kxcZUBokxHES9iGZniNAEWdkAq4pj
	 GjUzd0VJA+aLxjrvfqBVpMNllhSYyJ0wIZ34F98JKHtiIf2K/UT/rAlPoru4RDS/8X
	 GC0vAFc3Msnmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/vaddr-kunit: check region count in
 three_regions test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909035105.154326-1-sj@kernel.org>
References: <2026090821-fancy-avoid-db90@gregkh>
 <20260909035105.154326-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:01:22 +0000
Message-Id: <20260909040123.67B2D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing checks for expected region counts in DAMON kunit tests cau=
se NULL pointer dereferences and out-of-bounds accesses.
- [High] Missing NULL checks for `damon_new_ctx()` allocations in KUnit tes=
ts lead to kernel oopses.
--

commit 18eda53adc9f6ea23835c180d70b57969be3e82f
Author: SJ Park <sj@kernel.org>

    mm/damon/vaddr-kunit: check region count in three_regions test
   =20
    damon_do_test_apply_three_regions() iterates regions after a setup call
    assuming it would succeed at setting the number of regions to the expec=
ted
    one. Fix it by testing if the number of regions was changed as expected
    and exit early for the failure to prevent a NULL dereference.
   =20
    Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
    Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]

> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 72206dda95ecf..ffa76998dd63c 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -155,12 +155,17 @@ static void damon_do_test_apply_three_regions(struc=
t kunit *test,
> =20
>  	damon_va_apply_three_regions(t, three_regions);
> =20
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
> +	if (damon_nr_regions(t) !=3D nr_expected / 2)
> +		goto out;
> +

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a missing NULL che=
ck
for the damon_new_ctx() allocation earlier in this same function:

mm/damon/vaddr-test.h:damon_do_test_apply_three_regions() {
	struct damon_ctx *ctx =3D damon_new_ctx();
	...
	damon_add_target(ctx, t);
}

If damon_new_ctx() fails under memory pressure, does this cause a NULL poin=
ter
dereference in damon_add_target()?

Similarly, does damon_test_split_evenly() miss a NULL check for
damon_new_ctx()?

mm/damon/vaddr-test.h:damon_test_split_evenly() {
	struct damon_ctx *c =3D damon_new_ctx();
	...
	damon_destroy_ctx(c);
}

Will damon_destroy_ctx() unconditionally dereference it if c is NULL?

[Severity: High]
This is a pre-existing issue, but it appears there are identical missing
region count checks in other test functions that can lead to NULL pointer
dereferences or out-of-bounds accesses.

For instance, in mm/damon/core-test.h:damon_test_merge_regions_of():

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
	for (i =3D 0; i < 5; i++) {
		r =3D __nth_region_of(t, i);
		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
	}

If the regions are fewer than expected, will __nth_region_of() return NULL
and be unconditionally dereferenced?

Similarly, in mm/damon/core-test.h:damon_test_split_at():

	damon_split_region_at(c, t, r, 25);
	...
	r =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);

If damon_split_region_at() fails, r remains the only element, so does
damon_next_region(r) resolve to the list head offset, leading to an
out-of-bounds read on r->ar.start?

And in mm/damon/vaddr-test.h:damon_test_split_evenly_succ():

	damon_for_each_region(r, t) {
		if (i =3D=3D nr_pieces - 1)
			break;
		KUNIT_EXPECT_EQ(test,
				r->ar.start, start + i++ * expected_width);
		KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
	}
	KUNIT_EXPECT_EQ(test, r->ar.start, start + i * expected_width);

If damon_va_evenly_split_region() fails, does the loop terminate normally
without hitting the break condition, causing an out-of-bounds read when
accessing r->ar.start after the loop?

>  	for (i =3D 0; i < nr_expected / 2; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
>  	}
> =20
> +out:
>  	damon_destroy_ctx(ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909035105.1543=
26-1-sj@kernel.org?part=3D1
