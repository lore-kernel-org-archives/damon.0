Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E163B9
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249167; cv=none; b=WMQYuhD5e4/UdE90y8JEV8cmr7wOX/6D0FdiMvaYIB8Dlz5T9kAaPFPnt87K/i8q3ruILL8kfu1Fo2AIzVQGB3mtX/pSyA2ZYE9tweXHK4sFLK6Bat/JP81FYRHWeQrG02PFJoAEDrC6f8D/KYBUd2z8giFfGi4oLmIALTHWk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249167; c=relaxed/simple;
	bh=0jorlJhm6JpO62dIBcDN5AbcRoa7m3VcCUcAHlqeKr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzm7+tuOawyTTyvVTLSSSsJe4erikL7ofllg2ZP45z/1CRihDMLB1effVF0x5y55CcJ3RM9BOzq/oKfDR+Ol6X9/mLTPfyP1NULfGkFlMTr6HITnrQ95LcDbRLNVrAlMVEFN2sr36dz4iKwuHVLL13yEMj4JCrN2I5/TAJZVIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTmzpqnm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTmzpqnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8881F000E9;
	Fri, 17 Jul 2026 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784249165;
	bh=1gCq8K2fH3gngOpvNv5a4QiQdAsD71Swe7klmlCxw6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mTmzpqnmfx+fdxa6lc5tKltF+V21E/YBVXX5wuDUR6xG9DrJCzCOwi6KRCpNbvngv
	 1W14HzJA6Ikr2K0CHC6wCdZAWBSPWfP9H+lJimr3skH2o0b2Dot3b2uhxiuO2jFzlK
	 57fMErc7SkeQ2hYuvdvPG6ke4NPsfnimpIQSVpycew9q0Z0ScNm3E4tNRhjL+OGpXB
	 SvGoU5GYaV5jQsJwgnH3oOxGv9HUcUcNbdnG0sjpabrYBqfhC0IxrEAl0/nndmm+aE
	 B807PHQ2SP/22ZJCbIQYVy+qLpNuBAMrVv1NPBhPoQjGr7065ESMaZGmsQC7YZAttn
	 sOhmCxobyQ2FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] mm/damon/core-kunit: handle region split failure in
 filter_out()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717003022.119437-5-sj@kernel.org>
References: <20260717003022.119437-1-sj@kernel.org>
 <20260717003022.119437-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 00:46:05 +0000
Message-Id: <20260717004605.9D8881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds an early exit check `if (damon_nr_regions(t) !=3D 2=
) goto out;` to prevent an invalid pointer dereference when the first regio=
n split test fails, but misses the exact same vulnerability in the second r=
egion split test directly below it.
- [High] In `damon_apply_min_nr_regions`, if `damon_split_region_at` fails =
to allocate memory, the inner loop advances to the next list entry without =
inserting a new region, leading to an out-of-bounds read and write when it =
reaches the list head.
--

--- Patch [4]: [PATCH 4/7] mm/damon/core-kunit: handle region split failure=
 in filter_out() ---
commit 705cf12a4e8501ec816031495df35460614c42c2
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: handle region split failure in filter_out()
   =20
damos_test_filter_out() checks if damos_filter_match() of an address
filter splits the region as expected. But the test continued regardless of
whether the split succeeded, which could lead to dereferencing invalid
pointers or corrupting memory. This adds an early exit check on the first
test block to prevent continuing on failure.

Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 322a295ac2cec..bd3bbd421392f 100644
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
>  	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
>  	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
> @@ -1384,6 +1386,7 @@ static void damos_test_filter_out(struct kunit *tes=
t)
>  	KUNIT_EXPECT_EQ(test, r2->ar.end, 8);
>  	damon_destroy_region(r2, t);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does this second region split
test have the same vulnerability as the one fixed above?

If damos_filter_match() fails to split the region in this second test block
(e.g. due to memory allocation failure), damon_nr_regions(t) would remain 1.
r2 would be assigned damon_next_region(r), which could incorrectly resolve
to the damon_target list head.

Calling damon_destroy_region(r2, t) would then call kmem_cache_free() on
this out-of-bounds pointer, potentially corrupting memory. Should another
early exit check be added here as well?

> +out:
>  	damon_free_target(t);
>  	damos_free_filter(f);
>  }

[Severity: High]
This is a pre-existing issue, but while looking at region splits, could a
similar unchecked failure cause memory corruption in mm/damon/core.c?

In damon_apply_min_nr_regions():

			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}

If damon_split_region_at() fails due to memory pressure, it does not split
the region. The call to damon_next_region(r) then erroneously advances r to
the next element.

If r was the last region, it becomes the list head (&t->regions_list). The
loop condition then evaluates damon_sz_region(r) on the list head, which
reads memory 32 bytes before the damon_target struct allocation. If this
difference exceeds max_region_sz, damon_split_region_at() could be called
on the list head, which might subsequently write to r->ar.end, corrupting
SLUB metadata or preceding objects.

Should damon_split_region_at() return an error code so callers can verify
if the split actually succeeded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717003022.1194=
37-1-sj@kernel.org?part=3D4
