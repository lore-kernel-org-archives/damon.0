Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764DC3FD14D
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299921; cv=none; b=X8EVPa4XVRgb7DX7cFV+mH7VI/dldRY/CGGXzUfjVd74FENdV560PNTS4OI13m9xqEWhn0g9HkEQXSQyOh+lamPXPR/z6yQt2KSqJsQFsYGhZ8+CpXid4TrvUjMyKhO21Q8YSDxEPZfa+TUXREbbGbOtArloqy4YNClGRAimvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299921; c=relaxed/simple;
	bh=2qCSm8H40BVHpqv1eMjqnLzhKwDyFTL9VRSPg09Hfw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYbKTTrcQKPuxvL+R/Imt4FYjN6OV7XSK9LkLNvW2Oz9wNGrWkVI5ce+B9cmcPK6fWt3WSWAc1WMjCabKprVhadc4yVx+culIjW1ZkzFSpCscLwuttqCFFQhf9VyaftscE48Aic2aMFCh+ZmQCb+zja6oMG2UWx1kAoLkoH/XMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj62rn4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj62rn4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5CE1F00A3A;
	Fri, 17 Jul 2026 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784299916;
	bh=iPbeR2W1dl33AmClqU/lYmexw9eFBeaSfIxQbtrx9FU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hj62rn4wisEC//In4fL/efP+9HyvyIsZUbPbUHyUpdcyd3TcYiYc+bOHQ74C1d1Vk
	 kmTd/c7ZaQSJeDPznG0W9nn7xZtPRaoVeK2aYn2z8HbF/xlBKbXCEfAngByRA9JWCe
	 Z83UsJzItcnbQK9yNGgpK0WVzotV7jzyi5X2c1oaqKaSBs8r60smOWmwo7pFjQh5FX
	 pUKTlfL/V/VpBYdCmeMbFi/Lr+famf3u5F7vKp/1ZXeVa6Ly0V2efaWljJydYgX/qD
	 72OpMglSACohtP4rFr4WnzpiFMODq5HY9G2FtFHoUpxdKM2tCCcY+NP0XkwLzhF9AG
	 M/AduFnP0nAdg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 2/7] mm/damon/core-kunit: check region count
 before testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717143445.91207-3-sj@kernel.org>
References: <20260717143445.91207-1-sj@kernel.org>
 <20260717143445.91207-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:51:56 +0000
Message-Id: <20260717145156.6D5CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Severe out-of-bounds slab write and infinite kernel loop in `d=
amon_apply_min_nr_regions()` due to unchecked `damon_split_region_at()` fai=
lures.
--

--- Patch [2]: [RFC PATCH v1.1 2/7] mm/damon/core-kunit: check region count=
 before testing in split_at() ---
commit d2fdc98cf0d62ffe11b7dca50c29ff7c72e1fcd6
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: check region count before testing in split_at()

This commit fixes a potential invalid pointer dereference in the kunit tests
by checking if the region count changed as expected after a split attempt.
Since region splits can fail, it ensures the test exits early rather than
accessing an invalid next region.

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

[Severity: Critical]
This is a pre-existing issue, but since this patch correctly notes that
damon_split_region_at() can fail, does the same unhandled failure cause an
out-of-bounds access in the core code?

Looking at mm/damon/core.c:damon_apply_min_nr_regions():

			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}

If damon_split_region_at() fails to allocate a sub-region under memory
pressure, it silently returns. The loop then unconditionally executes
r =3D damon_next_region(r). Since no new sub-region was created, it skips t=
he
remainder of the original region and advances to the next one.

If this happens on the last region in the list, r evaluates to the list head
at &t->regions_list, pushing the region pointer out-of-bounds to
(char *)t - 24. The loop would then read garbage bytes for the region
boundaries.

If those garbage bytes evaluate to a size greater than max_region_sz, could
it call damon_split_region_at() again on this invalid pointer? If a
subsequent allocation succeeds, r->ar.end =3D new->ar.start could write a
user-monitored address into the out-of-bounds slab memory, potentially
corrupting memory 16 bytes before the damon_target object.

Additionally, if allocations consistently fail, could the fake region's next
pointer wrap back to the first valid region and create an unbreakable infin=
ite
loop in the kdamond thread?

>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717143445.9120=
7-1-sj@kernel.org?part=3D2
