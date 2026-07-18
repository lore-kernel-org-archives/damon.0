Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC0FBE1
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334180; cv=none; b=nk+LL2eTZpl+lFywy8928SgR3AiCcES3h/lTGQnPAo4ivbFdhDkJx3Y4xQ7JIuIBlDSq/kKh6u5bfU3hlgsNSQvzfkkZUSVO3OqSoqDC8jrhTgl9ifI5Ty3SZD2XauOCjs1n1frcHSdazPdc77/CU5mAKAEkRitZUAN5hj2b8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334180; c=relaxed/simple;
	bh=0AMDQeXsD9DHtctZ23QEjvBiVHDxSYC9lbAo1sMcE0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgB8LPK4BsibjsbdZQPVSX9L0rgyG/rRo56RgMkjDVzGq/dTU2drMbtcfjKYMlcNRBSDa/Jl2HDxJzzpfw7GbtCn9lJfgS6Aj0mHrBrTLtir22B0i0h7VZaU4iTkVRrrAevicMjcMtacqAj7G/V9TPOEgbRg0w+tSkVkS7qYBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhwIXkTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhwIXkTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3851F000E9;
	Sat, 18 Jul 2026 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334178;
	bh=hd0ZtUB3MX2B/5fNulpDLI5RRr3dq8B242fxESOyY80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YhwIXkTjRqrSop5O4FcKY6883NSKJkzXhw1Zglbhym2+my3aGov7IJFmcNfS+ZeT1
	 gLm35e540rDWEpL3fjULJpMnR3T2sn93tlus2lpdx+PM4sEv9fU7sMR41P7T3oxKwR
	 RHEJdvoe8/ghohjbdPF9XS5kszS6jHTYaqbFLjF46FaI19uwn+u+mCxEiVyg45jLoy
	 MpBR4cvcNqAqyOGmHYI4UZtg7pfieGOOkwQp32j64nuTkS0Q4QDf9/OlmJ6kS2UdwG
	 qb3s78a6cjhfiWxTU3A5sifhILDxAEzbh7SUwdhAHb8zlcna9BbF8aj8+r2oUWdIPT
	 vwDaj3iUulqfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in
 commit_quota_goals()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260718001442.87129-7-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
 <20260718001442.87129-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 00:22:57 +0000
Message-Id: <20260718002258.6A3851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Out-of-bounds array read in damon_test_commit_target_regions_for=
() due to missing region count validation before traversing dst_target.
--

--- Patch [6]: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk =
in commit_quota_goals() ---
commit 4bcb5123bbb5f6b4908f1d776a8608ef05a89501
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_go=
als()

This commit addresses an out-of-bounds array access in the KUnit test
damos_test_commit_quota_goals_for(). If the number of created quota goals
does not match the expected count, blindly traversing them can cause the te=
st
to read past the bounds of the expected values array. The patch adds a count
validation and an early exit to avoid this invalid traversal.

Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 9b8c20a50ad53..fbf986aee2dea 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -861,6 +862,14 @@ static void damos_test_commit_quota_goals_for(struct=
 kunit *test,
> =20
>  	damos_commit_quota_goals(&dst, &src);
> =20
> +	damos_for_each_quota_goal(goal, &dst)
> +		nr_dst++;
> +	damos_for_each_quota_goal(goal, &src)
> +		nr_src++;
> +	KUNIT_EXPECT_EQ(test, nr_dst, nr_src);
> +	if (nr_dst !=3D nr_src)
> +		goto out;
> +
>  	i =3D 0;
>  	damos_for_each_quota_goal(goal, (&dst)) {
>  		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);

[Severity: Medium]
This isn't a bug introduced by this patch, but should a similar early exit
check be added to damon_test_commit_target_regions_for() to prevent an
out-of-bounds read?

Just like the issue fixed here, damon_test_commit_target_regions_for()
iterates over dst_target regions without validating the region count against
nr_expect_regions first:

mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for() {
    ...
	damon_commit_target_regions(dst_target, src_target, 1);
	i =3D 0;
	damon_for_each_region(r, dst_target) {
		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
		i++;
	}
	KUNIT_EXPECT_EQ(test, damon_nr_regions(dst_target), nr_expect_regions);
    ...
}

If damon_commit_target_regions() incorrectly leaves more regions in dst_tar=
get
than nr_expect_regions, the loop will read past the end of the
expect_start_end[] array before reaching the KUNIT_EXPECT_EQ count validati=
on
at the end of the function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718001442.8712=
9-1-sj@kernel.org?part=3D6
