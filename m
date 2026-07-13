Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F221FF25
	for <damon@lists.linux.dev>; Mon, 13 Jul 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951688; cv=none; b=fo5pRprNPNu9Z8by5KKYwSr24wYjI7SXT++xI17eCsPumEX99s/oHeT9SDB6u78h9wpZvPRezP9c7Wl089pl7xR80RcHJeM8VW3eu6dHVLD1IQ0fBwzv1hbP2UE21K+c5WZJmd2837oOZI8IeWfwfLUKhH7gATZOmmStlf6DVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951688; c=relaxed/simple;
	bh=03w5HOB/yBIYt9eRqMsqg6lyTPo7hzCyNG3bLgYHiIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qTrN/+ewEKAHDkZucZrLrmIsNLxrGtKpbEkloAP7oPKudkO6QheIDrXf91e3jGOi2623TXnCD+pjh8u6IQiiMYUioU9m+dhTQA0kIbmI0ejXYuGhXHoF9agQO/dmHwQ2OB/60qxHpyp4bhrlOk2uWf5nuz6V2/4Y2M/452yfSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv9bmx5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv9bmx5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC61F00A3A;
	Mon, 13 Jul 2026 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951687;
	bh=5bGw+Kff0oToHh/FSZHxIX2QxqOFg/254+vvg6uE3mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qv9bmx5M/bryEJy9Co/xkvW7wA3WrBNzCeZqN9QI4teE8d3JucJFx6fnIE+HohWHK
	 2ihxQgMVYr19BdXtKTV+0c3TuCGPMHx9/CNyaH63OZ040P46OCLD2WNm9GuKC8pvCo
	 f/cHeJg39LU/mGLcX6AvOSQX12I5gcmJpZFsBOy6/LymYjWCS4grEC3VshyJ6SHe1o
	 RyIBHDWol16zDdTIEKKzph2p4kmuiXUQ/0bPmvYQib2GFflek58rhHOoy8eGms8uWg
	 9qGU/04SY3oA3iCKF2kHxoDcN1jK00n2piVEXcbbQfo2F/pvcc66mhMThYPZOD8bWX
	 Sf3hUKb5Xy71A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 2/5] mm/damon/tests/core-kunit: catch test
 failure in test_merge_regions_of()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260713135838.32730-3-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
 <20260713135838.32730-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:08:06 +0000
Message-Id: <20260713140806.D0CC61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the fix is incom=
plete. The exact same vulnerability (NULL dereferences or out-of-bounds arr=
ay accesses upon test expectation failure) exists in several other DAMON KU=
nit test functions. The patch correctly notes that `KUNIT_EXPECT_EQ()` does=
 not abort execution, leading to NULL dereferences if subsequent code assum=
es the expectation was met. However, identical brittle patterns exist in `d=
amon_do_test_apply_three_regions()` (which dereferences the result of `__nt=
h_region_of()` without checking for NULL), `damos_test_commit_dests_for()` =
(which loops over `dst.nr_dests` and can dereference a `NULL` `src_node_id_=
arr`), and `damos_test_commit_quota_goals_for()` / `damon_test_commit_targe=
t_regions_for()` (which iterate based on the destination's size and can rea=
d out of bounds from the source arrays).
--

--- Patch [2]: [RFC PATCH v1.2 2/5] mm/damon/tests/core-kunit: catch test f=
ailure in test_merge_regions_of() ---
commit 5b98cb20c5802f828e4e3cf09a813b6c47d58774
Author: SJ Park <sj@kernel.org>

mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after
its initial KUNIT_EXPECT_EQ() call assumes the expectation is met.

Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 6ad73559dd8ea..a99363720e677 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kuni=
t *test)
>  	damon_merge_regions_of(t, 9, 9999, ctx);
>  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
> +	if (damon_nr_regions(t) !=3D 6)
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does this fix need to be
applied to several other DAMON test functions that follow the same pattern?

If a test expectation fails, these functions also assume the expectation
was met, which can lead to NULL pointer dereferences or stack out-of-bounds
reads.

In mm/damon/tests/vaddr-kunit.h:damon_do_test_apply_three_regions():

    for (i =3D 0; i < nr_expected / 2; i++) {
        r =3D __nth_region_of(t, i);
        KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);

If damon_set_regions() leaves fewer regions than expected,
__nth_region_of() returns NULL and r->ar.start dereferences it.

In mm/damon/tests/core-kunit.h:damos_test_commit_dests_for():

    for (i =3D 0; i < dst.nr_dests; i++) {
        KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);

If dst.nr_dests is greater than src_nr_dests, it can access
src_node_id_arr[i] out of bounds (which can also be NULL).

In mm/damon/tests/core-kunit.h:damos_test_commit_quota_goals_for():

    damos_for_each_quota_goal(goal, (&dst)) {
        KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);

This iterates over dst's goals without verifying against nr_src_goals,
potentially accessing the src_goals stack array out of bounds.

In mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for():

    damon_for_each_region(r, dst_target) {
        KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);

This blindly loops over dst_target's regions, leading to potential
out-of-bounds reads on expect_start_end if it exceeds nr_expect_regions.

Could these functions be updated as well to prevent the test suite
from oopsing on expectation failures?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713135838.3273=
0-1-sj@kernel.org?part=3D2
