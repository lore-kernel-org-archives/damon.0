Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882843F8C1
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037707; cv=none; b=e0gKtKgbHPlxQwDiqNhwVLutSfz58AWGjp8nHOwqnIu73Rug0VKFJscjvKuncCi8xMCRUDX0WetHPwOInZ1oKHahT6wqBwtIw2GPu9xzwG0/7cOKbnPOgglHeAiLMRgaSWEuuSIxig3lhTCwjvn2A5JZOq90fXD06nDKwnXAJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037707; c=relaxed/simple;
	bh=1MjTXC318u3nJVNVp7LHyyWTdo2Ed57FjJ3W0V0vxtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jaCB5NzLFR29XeTyYuOtqEGEeNpu6xEgZdTRx7UVFNnmH5A1Jh6SPcsXRK+mvK0/rxeBfod6oip4domUUDb16TbNDuOS4S5ubCas0/txvyNxIPhhbnu7x3JPLosWRBWUA+Dt5xWApQ1sIKgl9aO3dSvra/2pD9W43WPQBQF3DLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjIypGB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjIypGB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A77C1F000E9;
	Tue, 14 Jul 2026 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037706;
	bh=MsiFIzf3FPoujVQesSWSPNpbSdgWZnQ/3tSxFitXXss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FjIypGB1GUYd8pkyyzhdhvmp6ZxeTp056lcFWtT02OPnty5fKP5vRcPaG7w8oOtwN
	 oZSlbmAHLpkGVuEk1fEiUzEs8XoJclbc3XIkUtmizWaNftnjEdzhTgezMfz3iQeShm
	 UVNHJ9N82ayj+YY8yX4AbhwlcjAEaRe3pREPNBuo5RKY2JP2E6E/d3WQT/8VKXO5KJ
	 g1G6guTspR4Xjg9G8CLW/57NcjYUIFcfsycnfN6oV1jWMmMm7PG5U2DBmDrkewnhWS
	 5ttINpQFLfmgaMhH8c7s3Ssazq/FzWPUCE+U8f9v/jNYNs4926Kzfyl8IgcR/eJC13
	 Re3Cfl42wUduQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260714135236.92699-3-sj@kernel.org>
References: <20260714135236.92699-1-sj@kernel.org>
 <20260714135236.92699-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:01:45 +0000
Message-Id: <20260714140146.1A77C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch attemp=
ts to fix a crash where unit tests continue execution despite a failed KUNI=
T_EXPECT_EQ() condition and misses several identical vulnerable patterns in=
 the same file. In multiple other test functions, if a tested function fail=
s and the KUNIT expectation is not met, the tests will continue and perform=
 out-of-bounds array accesses or invalid list traversals leading to slab co=
rruption.
--

--- Patch [2]: [PATCH 2/5] mm/damon/tests/core-kunit: catch test failure in=
 test_merge_regions_of() ---
commit 951f8b5681b80f05d0ef2d36767a3d72e546ac33
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

This commit addresses a panic in damon_test_merge_regions_of(). If the init=
ial
KUNIT_EXPECT_EQ() expectation is not met, the code previously continued exe=
cuting
a per-region test assuming the incorrect hard-coded number of regions, lead=
ing
to a NULL pointer dereference. The fix catches the expectation failure and
skips the per-region tests.

Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 485472ddebd19..eba643762132f 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kuni=
t *test)
>  	damon_merge_regions_of(t, 9, 9999, ctx, true);
>  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
> +	if (damon_nr_regions(t) !=3D 6)
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but while addressing the crash
here, could we also fix identical pre-existing regressions in the rest of t=
his
file?

In several other test functions, if a tested function fails and the
KUNIT_EXPECT_EQ() condition is not met, execution continues and causes
out-of-bounds array accesses or invalid pointer dereferences.

For example, in damos_test_commit_dests_for():

	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
	for (i =3D 0; i < dst.nr_dests; i++) {
		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);

If dst.nr_dests is larger than src_nr_dests, doesn't this loop read out
of bounds on src_node_id_arr[]?

Similarly, in damon_test_split_at() and damos_test_filter_out():

	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
	r2 =3D damon_next_region(r);
	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
	damon_destroy_region(r2, t);

If the split fails and there is only 1 region, does damon_next_region() ret=
urn
an invalid pointer for the list head? If so, passing it to
damon_destroy_region() could lead to slab corruption.

A similar pattern also exists in damon_test_commit_target_regions_for() and
damos_test_commit_quota_goals_for(). Should similar expectation checks and
early exits be applied to these functions to prevent kernel panics during t=
est
failures?

>  	for (i =3D 0; i < 6; i++) {
>  		r =3D __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
>  	}
> +out:
>  	damon_free_target(t);
>  	damon_destroy_ctx(ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714135236.9269=
9-1-sj@kernel.org?part=3D2
