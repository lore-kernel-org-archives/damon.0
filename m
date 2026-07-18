Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FC18C008
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334345; cv=none; b=g6iKawzJeznG9y89M5DnaZw5C+viEhHOxokFyQxGmq1q+k1VnIdK+pfdJmBs2P+jhoN33BlTZr04DD1rInbeXmsoeGrrjadxg6q5dLtePoQqM4ZzoF4qdtEucxz7c3746rbz1+onJFKwKqqmJ9uDf/iPUpQzGoWLacRLQoSP0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334345; c=relaxed/simple;
	bh=tn+F6qNkdEqULempuekOYFupZpRuE/mSN7JoHra5Zvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L2izcqgmRsnzbxvB+lPHWF5nUNYY9U0vwuXsqvBBndk5/ye95mNz5fBD4nuhQuvVKCk9gn0kR/rvZukOkMKp922XMkoi6ITZd+x6/iScRflUFw83sFMgytypDyMpmDC4/SP/kcu5xg3hGoJcptAjChe4hBPuC13l+blgTUGvYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOfYC21g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOfYC21g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7741F000E9;
	Sat, 18 Jul 2026 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334344;
	bh=eRB1Kgv2wj7LO6/b/SPs5Ek9yD6vttkWRkrItkb7hV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOfYC21gnz+puZeBzpMVEwhV4vbVp7/nV9XZFyqeib0TZ6RNcrGWA6nLInIWOUT4R
	 SQIIZ3BRKBW+sQ5Nz+ARRk+ryjABcsnOn2pKaL3jwl+BmxA74McxLRMjn85xJ/CMGu
	 xLUmjbNlNUF2jSYYCjScuLHRIxkoXKHhNGhvJoiM2SF9uFFEzqASSAAGbsBoue26s5
	 /hL5xRwPaHUqufyktXVqxucr1F0ZPfRp13oCz85605PZPR4OKb9uoNServBuLZyDaD
	 aA75gr9oMWztGLvyBvjfBT6p5IajoIEUnSNCVqEWMuRkMbOz+cC4y001xG3lAfABaK
	 Cx2l43av3wKOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] mm/damon/core-kunit: skip wrong dest walk in
 commit_dests_for()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260718001442.87129-6-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
 <20260718001442.87129-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 00:25:43 +0000
Message-Id: <20260718002544.2C7741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `damos_commit_dests()` fails to allocate the `weight_arr` array=
, it returns `-ENOMEM` but leaves the `dst` context partially modified with=
 a NULL `weight_arr` and an incorrect `nr_dests`, leading to a NULL pointer=
 dereference during DAMOS scheme execution.
- [Medium] Missing out-of-bounds array bounds checks in the test functions =
`damos_test_commit_quota_goals_for()` and `damon_test_commit_target_regions=
_for()` when iterating over tested items.
--

--- Patch [5]: [PATCH 5/7] mm/damon/core-kunit: skip wrong dest walk in com=
mit_dests_for() ---
commit 937f902e215bffeba8d97bcc0725b5bfbb643c41
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()

This patch fixes a potential out-of-bounds access in the KUnit tests for
damos_commit_dests(). It exits early in damos_test_commit_dests_for()
if the expected number of destinations does not match the actual number.

Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index eddf3a0484583..9b8c20a50ad53 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1008,6 +1008,8 @@ static void damos_test_commit_dests_for(struct kuni=
t *test,
>  	skip =3D false;
> =20
>  	KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
> +	if (dst.nr_dests !=3D src_nr_dests)
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the function being
tested, could damos_commit_dests() leave the destination context in a
corrupted state on allocation failure?

If kmalloc_array() fails to allocate weight_arr, it returns -ENOMEM but
leaves dst->weight_arr as NULL without resetting dst->nr_dests:

mm/damon/core.c:damos_commit_dests() {
	...
		dst->weight_arr =3D kmalloc_array(src->nr_dests,
			sizeof(*dst->weight_arr), GFP_KERNEL);
		if (!dst->weight_arr) {
			/* ->node_id_arr will be freed by scheme destruction */
			return -ENOMEM;
		}
	}
	...
}

Would a subsequent execution in damos_va_migrate_dests_add() dereference th=
is
NULL array when iterating over dst->nr_dests, leading to a system crash?

[Severity: Medium]
This is a pre-existing issue, but does the same out-of-bounds array access
vulnerability exist in other test functions in this file?

Similar to the fix applied here, the loops in
damos_test_commit_quota_goals_for() and
damon_test_commit_target_regions_for() iterate over items without bounds
checking, only verifying the length after the loop completes.

For example, in damos_test_commit_quota_goals_for():

mm/damon/tests/core-kunit.h:damos_test_commit_quota_goals_for() {
	...
	damos_for_each_quota_goal(goal, &dst->quota) {
		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
		...
	}
	...
}

Could these loops exceed the bounds of arrays like src_goals[] or
expect_start_end[] if the tested function produces more elements than
expected?

>  	for (i =3D 0; i < dst.nr_dests; i++) {
>  		KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
>  		KUNIT_EXPECT_EQ(test, dst.weight_arr[i], src_weight_arr[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718001442.8712=
9-1-sj@kernel.org?part=3D5
