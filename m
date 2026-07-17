Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594322ACEB
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299851; cv=none; b=KRuFSOVSHkVKkXk9saoAE8BzCaKOMcT2LmEY+AX6ItaYQJY9CKIbJo1UgV3ROsmgqWwew9V8bVBzExKoXpIqVGSF2TKn7UdKpa8xuhtCUgw9vO+CSQkzqmspY1vsxQggshThyE5eMdJCaBBUnTtSPfRsWlJWsHU4Y5XUxj+jCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299851; c=relaxed/simple;
	bh=lHg/UmIWd7/1hIQ8Lg1kHAK5V9foZ7K4CwueaisuJEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gvb7ucroeZ2z036BrG8/tqNV0R2xMsSVhBeXaJMGK8vSSwNegBPAr7c7YDbzgtI4NsORlMm9jin/GtKs6f/7qw4sICq7OWFjovMkxIGOF1bq2I5AP0N6xISPATPYca1KtV7+0p4EjdSoA3lTZILKSTLfPi/ZZegVdB7kdsJBZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwRLMKZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwRLMKZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6331F000E9;
	Fri, 17 Jul 2026 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784299850;
	bh=wI21uGkhNcRxLkJpoOD/zYLtH1FRoOw++p3DcDUk0V0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwRLMKZqXluoo0nb0rQRHBmCSk6VV4J3hFTYKvbbL++MjV7mBRcKL7wiP0pDHBNAw
	 aFK8lKeDAsMCKJ9tSBKlOFbkKdEmwxos7MtEYNvul0p07s3C7LvvtPRRDUyQlHAAAg
	 Wm82Flk75sWovJwd0GKLrn244zA3SCeZjuZkVTNeb+SI7QZfIS4IbQSZDLt3+NA8Ny
	 FOLnjEgoAPBYmrkA+ngf8fc5k9PpQefq4WauoFB40H6cKrCYIlgstoA8BIqgOJKrTS
	 pgKqoO4JGjFEK/Q6o7NtD4MzubWp2i0y4Uq67kemnHNScDo2onuXQfj1gkr/hmu8nm
	 IB7c/kq36r5FA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 3/7] mm/damon/vaddr-kunit: check region count
 in three_regions test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717143445.91207-4-sj@kernel.org>
References: <20260717143445.91207-1-sj@kernel.org>
 <20260717143445.91207-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:50:49 +0000
Message-Id: <20260717145050.1D6331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array read in KUnit test helpers due to missing arra=
y bounds check and ignored return values
--

--- Patch [3]: [RFC PATCH v1.1 3/7] mm/damon/vaddr-kunit: check region coun=
t in three_regions test ---
commit b2d38d564a3004fa6df02a9f1d54af3423302437
Author: SJ Park <sj@kernel.org>

mm/damon/vaddr-kunit: check region count in three_regions test

This commit adds a check in damon_do_test_apply_three_regions() to ensure
damon_set_regions() succeeded in setting the expected number of regions.
This prevents a potential NULL pointer dereference during test iteration.

Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 61f844336ffb5..6a95441d193ae 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing this test fix, I noticed
similar missing bounds checks and unhandled return values in
mm/damon/tests/core-kunit.h that can cause out-of-bounds array reads.

In damon_test_commit_target_regions_for():

	damon_commit_target_regions(dst_target, src_target, 1);
	i =3D 0;
	damon_for_each_region(r, dst_target) {
		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
		i++;
	}

If memory allocation fails inside damon_commit_target_regions(), it returns
an error without modifying dst_target. Because the return value is ignored
here, could this iterate over the original regions of dst_target and read
past the end of the expect_start_end stack array?

A similar pattern appears in damos_test_commit_quota_goals_for():

	damos_commit_quota_goals(&dst, &src);

	i =3D 0;
	damos_for_each_quota_goal(goal, (&dst)) {
		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
		KUNIT_EXPECT_EQ(test, goal->target_value,
				src_goals[i++].target_value);
	}

Does ignoring the return value of damos_commit_quota_goals() risk an
out-of-bounds read on src_goals[] if the destination goals are not updated
and retain more items than expected?

Finally, in damos_test_commit_dests_for():

	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
	for (i =3D 0; i < dst.nr_dests; i++) {
		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
		KUNIT_EXPECT_EQ(test, dst.weight_arr[i], src_weight_arr[i]);
	}

Since KUNIT_EXPECT_EQ does not abort test execution on failure, could an
out-of-bounds read occur on src_node_id_arr[] and src_weight_arr[] if
dst.nr_dests ends up larger than src_nr_dests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717143445.9120=
7-1-sj@kernel.org?part=3D3
