Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398701A262A
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927336; cv=none; b=ADYeCAjgNkXuQ1T2tzTIUCsbbyrgiHJZtxWvJ0/sAr27cLaP7A8kjzNhNfwnD7vbRDPK6zsgJwZKQ00OuzaUk3YF4IC1SyAP7vCE3fXrkF85tSEt+oCo8mp0pPgQdriV+c1pLf3UP3/LSs/9oaRAlnAX+Qrte1ZlOD6KWNjM5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927336; c=relaxed/simple;
	bh=oT5NnfqNjvsR7ILtzNOslFbEq3+xq1RBMFPmEhSMZ5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BX6kRbd+h/zJsZkKl+JMU5JeFBwwxkVRqSqcXr0LNK+kRV2Zm/XCEVyLMs/wXvT0os6bVxeg/gZJjCWaMz3f7COBbqMc8B/nDJAskzYXk0oGEdK94pQkmh1ZLpeMeJa6Al97rEZ/1G4b5HM+43UOBKcd7GTTrWjHTptFxZVkVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAQMGxJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAQMGxJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6631F00A3A;
	Wed,  9 Sep 2026 04:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927335;
	bh=yTkqCBcjt4ENSIArutSvSWoQElbtSQ0wMz3wSk4fqh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAQMGxJ6x56mVEv0qjxtyGL4dKV7lOR5yJU9P8Lv/6rsEJ9qVplzA3FeYEuJ7jwcX
	 5JZnyeO0HOKAWBrMaG5kvz1xu1H9BP4vbcTwZO+Br1d2Z2EIGutRJ6y065dzGhk/b7
	 ndSwjAc3Q1AeTPkhwNX+V33ruX2gi3/XI9YZqGoexTTx482hhwR0sz//cazVIfmoGS
	 1YU91k2+tVXWFhGveVbnLpIM1cxWRSOePSCTonJT4OgGgrn4LKz/ZTj/CuXvPXy36S
	 G2YmMZfPMNygxwQUw3QjZAWO35uXPjvOIBNgC5tXik0nD08a+7z44p3xpcHKLLrYLV
	 xbNrmCc9MkQBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core-kunit: handle region split failure
 in filter_out()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909040431.171803-1-sj@kernel.org>
References: <2026090830-think-magical-cf80@gregkh>
 <20260909040431.171803-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:15:34 +0000
Message-Id: <20260909041534.EA6631F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The exact same missing check for region split failure exists in `d=
amon_test_split_at()`, leading to an out-of-bounds read.
--

commit fd822a4546c77b8ec92e7e67206ab99aafb176a1
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core-kunit: handle region split failure in filter_out()

The damos_test_filter_out() test checks if damos_filter_match() splits a
region as expected, but continued regardless of split successes. As a
result, the later part of the test could dereference invalid pointers
returned from damon_next_region() or corrupt memory from
damon_destroy_region(). This commit fixes it by exiting early when the
region split fails.

Link: https://lore.kernel.org/20260718001442.87129-5-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 6687778752728..801407b481cdc 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -588,6 +588,8 @@ static void damos_test_filter_out(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;
>  	r2 =3D damon_next_region(r);

[Severity: High]
This is a pre-existing issue, but since this patch fixes the missing split
verification here, should a similar check be added to damon_test_split_at()=
 in
the same file?

In damon_test_split_at(), the code calls damon_split_region_at() and then
unconditionally accesses the next region:

	damon_split_region_at(t, r, 25);
	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

	r_new =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);

If the split fails, r remains the only region in the list. Calling
damon_next_region(r) would then return an invalid pointer derived from the
list head. Dereferencing r_new->ar.start could cause an out-of-bounds read
and a potential kernel panic.

Does damon_test_split_at() need an early exit if the split fails to prevent
this memory corruption during testing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909040431.1718=
03-1-sj@kernel.org?part=3D1
