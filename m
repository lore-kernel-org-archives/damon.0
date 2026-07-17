Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D535E95E
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299747; cv=none; b=At+ehfClyx+4NmtjQrbPDLNfyLpLEnTgq7BFmdhwtunCdm+oPnusJwJfA3d4Tlr88aUbQjZconM/MQ872UAt8VxBdGrs9O35aIgoUG0x9/304sDqEuITKOtdkj+JW499gt0g6w+C0emjVrrPt+aokiPC8koJ+vQImqKASE1dfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299747; c=relaxed/simple;
	bh=wVS7SLoh2HlfDspBxzPBFb35rechFHYcudRmzU9oFSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7HuSHEsaAYBWsftgF8JXAE0LkzE/mFHZavKNss71CrcBxYbVE3yDbnwj8wwl0aVPxjPc3Z86oKhEBgH6DUg9epnV4mdPcn8pgWMF6rSXcN7JOC3JfCRi2ZFAWWvf72ibsfvQyX+x8NXznqlsc/26jK/kmrwnJ/qyNvZVqqdXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knh7CoAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knh7CoAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836FC1F000E9;
	Fri, 17 Jul 2026 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784299744;
	bh=kla5iyjKCC8Jkh2rUxWPlT4aPO7d1omTmz8dwE55gTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Knh7CoAqcVZdVdCW8N4BKNmdQ6Wk7eyqQEq+Zs6OvSUuKsk8XbtUnR7IeTemwGnDJ
	 4NMTfAXsgpOwZya7sbrk7jNxMB9e6nxikKZXdtLuO4hD/UBNrelsywbBXAB4nKGczZ
	 EeKYz/Q1Hb83N3s9SKq5xi1lXPZhtXoNUitKWgYSTJjq4mLv5CZcp8EuzZu8eUqV/s
	 15HUC9OhIi44xP3DhuY6oMta7sU3eL2iLN74zmu609QDjDMrkatCgansjp3Utb0621
	 VVggSzVpLrOOPHQ9M24M9HcvybjZBlSQ7COuHxl8zDGN21WUA0kUI/oIYSWBAfAo3u
	 tN3U2DoKHyUPQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 4/7] mm/damon/core-kunit: handle region split
 failure in filter_out()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717143445.91207-5-sj@kernel.org>
References: <20260717143445.91207-1-sj@kernel.org>
 <20260717143445.91207-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:49:04 +0000
Message-Id: <20260717144904.836FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it shares the ex=
act same logic flaw fixed here. In `damon_apply_min_nr_regions()`, if `damo=
n_split_region_at()` fails to allocate a new region (e.g., due to memory pr=
essure), it leaves `r` unmodified. However, the inner `while` loop uncondit=
ionally executes `r =3D damon_next_region(r);`. If `r` was the last region =
in the list, `damon_next_region(r)` will return a pointer derived from the =
list head (`&t->regions_list`), resulting in a fake `damon_region` pointer =
pointing into the middle of the `damon_target` struct or preceding memory. =
The loop then evaluates `damon_sz_region(r)` on this fake region, reading g=
arbage memory. If the garbage evaluates to a size greater than `max_region_=
sz`, it will invoke `damon_split_region_at()` on the fake region, causing a=
n out-of-bounds write and list corruption (overwriting `r_fake->ar.end` and=
 `t->regions_list`), or an infinite loop lockup if allocations keep failing.
--

--- Patch [4]: [RFC PATCH v1.1 4/7] mm/damon/core-kunit: handle region spli=
t failure in filter_out() ---
commit 571c1400b8cb843c3acdb1ded0915fd9807f302f
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: handle region split failure in filter_out()

This commit fixes a bug in the DAMON kunit tests where test execution
continued even if a region failed to split as expected. By exiting early
when the number of regions does not match expectations, it prevents
dereferencing invalid pointers and potential memory corruption.

Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 322a295ac2cec..eddf3a0484583 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1365,6 +1365,8 @@ static void damos_test_filter_out(struct kunit *tes=
t)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (damon_nr_regions(t) !=3D 2)
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but it shares the exact same log=
ic
flaw fixed here.

In mm/damon/core.c:damon_apply_min_nr_regions():

		damon_for_each_region_safe(r, next, t) {
			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}
		}

If damon_split_region_at() fails to allocate a new region (e.g., due to mem=
ory
pressure), it leaves r unmodified. However, the inner while loop
unconditionally executes r =3D damon_next_region(r).

If r was the last region in the list, damon_next_region(r) will return a
pointer derived from the list head (&t->regions_list), resulting in a fake
damon_region pointer. The loop then evaluates damon_sz_region(r) on this fa=
ke
region, reading garbage memory.

If the garbage evaluates to a size greater than max_region_sz, it will invo=
ke
damon_split_region_at() on the fake region.

Can this lead to an out-of-bounds write and list corruption, or an infinite
loop lockup if allocations keep failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717143445.9120=
7-1-sj@kernel.org?part=3D4
