Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DA492E47
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926212; cv=none; b=HPiA8PjcyXV1lhh3rhRTCp534RUgpq3UP++AZwnqWfOH6tULAeGoBgBQCGEeLnGI2u/RNbtEnK1kzKBeDBCteDhDx5DAkGFzATLKmVeFoTRYLGYR1I1/YhUG2zC1YMjXVvWZ0zyZgh2qfq9/CPjbHqwnMTYvN2iXCix0zWMaXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926212; c=relaxed/simple;
	bh=hWDpiUCrvzCX8Yg+AGkp/bWSFtdVi+MXY0lb7IW6Qro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F1cPtaln3xqS5bssIU7kxaJPq20qqMwEv7pdDNuIHiV4PRsjw2VPXWVgz/1G3W6RDp0nZV0xemWRf2kvSRL96d1E6YnWZ3KFnd+Q7gcuJRjNUsR9TmZbtibYeMB6pzDFJSfD7dG+CJDZslMNULZDsZvudLx9zp1GJRF+t861LhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjnUmONd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjnUmONd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2B91F00A3A;
	Wed,  9 Sep 2026 03:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926211;
	bh=Ojpc84TxPtX1gu8TvK+285txzQf8yR0Atl0xuGAy5NE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjnUmONdQPciKRXSBe196p4dFXS9Y2fB2kBRkUf8qWpJvKR+iP0KjKo4MLPdzHEsh
	 XME20rBvlYw6JPD5Q7no7/U09E/HSFCIfhz1ys3mXQoEGF/c3N2R2CbrN8rKyMI4zG
	 PA8tBKrn9P1+31+NwW6rgkerZhdj8cFVR8fVplT2ldBUuQfADdK9DbYNcMJx02eU35
	 CuHIFj1PvfMKXjX/9crpm4gcpfa8Kjcjl5iF+CUKm5jI/DHSDp2tesClXy4jjDuxKq
	 M3XwFpEwcqnDgpgCcUmFQMLuCfvPL2SfhHEoDi79lvFsQszRUaMRODheUyvitv/4j5
	 P9nNokz4KvEHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/vaddr-kunit: check region count in
 three_regions test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909034509.142303-1-sj@kernel.org>
References: <2026090819-haiku-machinist-83fa@gregkh>
 <20260909034509.142303-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:56:50 +0000
Message-Id: <20260909035651.1E2B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: The same vulnerable test pattern fixed by this pat=
ch in `vaddr-kunit.h` also exists in `mm/damon/tests/core-kunit.h` within `=
damon_test_merge_regions_of()`, where a hardcoded loop accesses regions via=
 `__nth_region_of()` after an unchecked operation.
--

commit 95900378d75f76847738ad9f2040d727e3455432
Author: SJ Park <sj@kernel.org>

    mm/damon/vaddr-kunit: check region count in three_regions test

This commit adds a check in damon_do_test_apply_three_regions() to verify
that damon_set_regions() updated the region count as expected. If the count
is wrong, it exits early to prevent a potential NULL pointer dereference
when accessing the regions.

Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]

> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index ed2845d9f9a95..9eead9882dcce 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -149,12 +149,17 @@ static void damon_do_test_apply_three_regions(struc=
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

[Severity: High]
This is a pre-existing issue, but should a similar fix also be applied to
mm/damon/tests/core-kunit.h?

Looking at damon_test_merge_regions_of() in mm/damon/tests/core-kunit.h,
there is an identical vulnerable pattern:

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
	for (i =3D 0; i < 5; i++) {
		r =3D __nth_region_of(t, i);
		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);

If a regression causes damon_merge_regions_of() to return fewer than 5
regions, the KUNIT_EXPECT_EQ() check will log a failure but will not abort
execution.

Will the subsequent loop continue executing past the actual number of
regions, causing __nth_region_of(t, i) to return NULL? Does this result
in a NULL pointer dereference when accessing r->ar.start that crashes the
test execution environment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909034509.1423=
03-1-sj@kernel.org?part=3D1
