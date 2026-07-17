Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70829E54B
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249059; cv=none; b=O4oQto4mYRsTAWnNdkeq4RFNqVV3pT2dYiViti3bNgJ6LW4qPfx+wQKRVUaQuzO1EzJh1NNNZfb1Xot9cPjkJGAOT51q8zKJWhpbspnRa+mvIWPhC9GAzvZMzbDp8vIo4PsyRVAniL2LpmKl2MopwIJ5PHxprrRUTl+xMML6zcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249059; c=relaxed/simple;
	bh=6T+NGpPxz3rp7RW2oMlZFLBxEDrJeIU31xpVppYi2yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p9NPEh4IK9LVCPblUrX09Tx9fLBUnIkF9ai9w49FS0pehxOrdk5XG75vvQpEj2sjyTMRKCopLOLj4H7QiBKW7d0vArG3mtPUTiIyKeKgczRMSvosLeFbLsYeAaeqxwTUW3gbR3kxWzezWQ5jBQauvBCh0V6XsllOmhHtxKJ+BDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT0kU3kW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT0kU3kW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9F31F000E9;
	Fri, 17 Jul 2026 00:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784249058;
	bh=w1iW/p//M6Ht9PoxysvE2GGY96MCXeP2K/6pLmMKhKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DT0kU3kWDBFxBE1JuTUCEXkw0oQkVZxtt/lUpwhD7t4FQ9JJEX0A6F/ENov3+Yy0A
	 JrmkrO3UAZt8WXbVIdH6Ftam3rjfF71SzAumln1m6fOzndRA+Mp3/PHLeI4jFXYSO0
	 NFlPIyJneE0KzH26XISCLbVXq1wxrRyJW7DLMPVANsG88DKOCrTvoSgTCleA/xPxbV
	 keM42+JYDBex/6thU+A8KGjzbW4JGPPAWkL6ibfYFNoy8kYrYIua+9PTl5fq7PSkhx
	 vw5CI5ULZOd/VaudkJGmaFaQRUluqPot3+XFTdLJm0jPpprUjaeP1qrkwtlU/1NF7v
	 E8XdQWrbzCl5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] mm/damon/core-kunit: check region count before
 testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717003022.119437-3-sj@kernel.org>
References: <20260717003022.119437-1-sj@kernel.org>
 <20260717003022.119437-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 00:44:17 +0000
Message-Id: <20260717004417.9F9F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel memory corruption in `damon_apply_min_nr_regions()` due to =
unhandled split failure.
- [Medium] Incomplete test fix for memory allocation failure in `damos_filt=
er_match()` leading to test crash.
- [Medium] Missing upper bound checks in test loops leading to Out-Of-Bound=
s array reads.
--

--- Patch [2]: [PATCH 2/7] mm/damon/core-kunit: check region count before t=
esting in split_at() ---
commit c03465ac93de9ac544447d782c3c2ea15bf60ab1
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: check region count before testing in split_at()

damon_test_split_at() tests the next region that is assumed to be created by
damon_split_region_at(). But the split might fail. In this case, the test is
updated to check if the number of regions changed as expected and exit earl=
y.

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

[Severity: Medium]
This isn't a bug introduced by this patch, but it looks like the exact
same pattern being fixed here is present in damos_test_filter_out().

If damos_filter_match() fails to allocate memory, it returns without
splitting the region. The test logs a failure for the region count mismatch
but execution continues unconditionally:

mm/damon/tests/core-kunit.h:damos_test_filter_out() {
        /* filter should have split the region */
        ...
        KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
        r2 =3D damon_next_region(r);
        ...
        damon_destroy_region(r2, t);
}

Since r is the only item in the list, does damon_next_region(r) resolve to
an out-of-bounds pointer that is then passed to damon_destroy_region(),
causing list and slab corruption during test execution?

[Severity: High]
This is a pre-existing issue, but since we are handling split failures in=20
the tests, does mm/damon/core.c:damon_apply_min_nr_regions() suffer from a
similar problem in production code?

mm/damon/core.c:damon_apply_min_nr_regions() {
        damon_for_each_target(t, ctx) {
                damon_for_each_region_safe(r, next, t) {
                        while (damon_sz_region(r) > max_region_sz) {
                                damon_split_region_at(t, r, max_region_sz);
                                r =3D damon_next_region(r);
                        }
                }
        }
}

If damon_split_region_at() fails to allocate memory, it silently returns.=20
The loop then unconditionally advances r =3D damon_next_region(r). If r was=
=20
the last region, this returns a bogus pointer derived from the list head.=20

The loop condition damon_sz_region(r) then evaluates garbage memory. If it
happens to evaluate to greater than max_region_sz, the loop re-enters and
passes the bogus pointer to damon_split_region_at(). Could this lead to
out-of-bounds writes and list corruption under memory pressure?

[Severity: Medium]
This is also a pre-existing issue, but while reviewing the kunit tests, I=20
noticed several test loops lack upper bound checks against the destination
counts.=20

For example, in damos_test_commit_dests_for():

mm/damon/tests/core-kunit.h:damos_test_commit_dests_for() {
        KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
        for (i =3D 0; i < dst.nr_dests; i++) {
                KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i=
]);
        ...
}

If the code under test incorrectly leaves dst.nr_dests greater than
src_nr_dests (for instance, when src_nr_dests is 0), the loop iterates out=
=20
of bounds and dereferences src_node_id_arr[i].=20

The same unbounded iteration pattern appears to exist in=20
damos_test_commit_quota_goals_for() and damon_test_commit_target_regions_fo=
r().=20
Could these also be fixed to prevent out-of-bounds reads during test failur=
es?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717003022.1194=
37-1-sj@kernel.org?part=3D2
