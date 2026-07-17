Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B876E54B
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249075; cv=none; b=tz2UOYFNLqkhtBclYGJGEclCimbN/sBbX8LaeYnv4bx517hZm+v9Ho2v4p1d2F4Zn7d3adbw6w3fZpBxf8ezygyICiFiZ7p8THqbSVoo1K7IeI67Kk1/443XrINZJNtIYI27H5T0oA79ql680eqbdI25KJ6E1MJbFJNEBGCwC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249075; c=relaxed/simple;
	bh=tL+Zq+jAFuL05XOZUXecWW+CMzaskqI7ZGD/wo05Fqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8ClbkwjfCjPALnMsdR00tgpre78zvWtCLLqKMrmXVeMYCL93hl46ynJqA1bDs3sfoi2gbZwbpxeqZjwJYJq6X/TGzvb5mLlMLXIH76l8qogyoZssC/u1QSx4LKTnbyIsxaQbK9db8Iz/N7MmJtY+VdmaoXQZ4MzBPwSFBiAvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeopSfCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeopSfCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CBC1F000E9;
	Fri, 17 Jul 2026 00:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784249073;
	bh=Jrr/iPmz+Y69cnN3l9S8Snzmlj5gJq+8ckpAFhTSe+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeopSfCr/bzEMg1lZanHN3889a+P5w/FmxgQGa9ZgXKKYLFYeS5cWIjuLExrOOhkZ
	 kGVpLSaN8+FwCm/1PIcB23GoUpvjMEQE6TTYdjKVQ2urtXvsfdIBFJc1S6xfmem/RV
	 Cwmbd6/ZrJIEB7CPsh7loeRIbN8qQ0+1BAAXV/kPMEb0mszRKoVXdDfiGJEbUQrbOB
	 y0aElWo2HixP8JWC78a1RH8V8Fm0uGmjwqjgFN9U6RusCTsMRPOJ2jdpdBZYwb/vDo
	 KWyD/vts0apkcEAqkBJbWCbzzWM9VCHUzTyWrCHXvu9mGJCMHiEu+0nLkWIirrefNJ
	 q85xOI9laP4fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in
 commit_quota_goals()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260717003022.119437-7-sj@kernel.org>
References: <20260717003022.119437-1-sj@kernel.org>
 <20260717003022.119437-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 00:44:33 +0000
Message-Id: <20260717004433.98CBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing error check in `damon_test_commit_target_regions_for()` =
leads to an out-of-bounds read if `damon_commit_target_regions()` fails.
--

--- Patch [6]: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk =
in commit_quota_goals() ---
commit 9bf8891739c4d265498b06b272b3083da8b65ed2
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()

This commit fixes an out-of-bounds access in
damos_test_commit_quota_goals_for() by verifying the number of quota goals
matches the expected amount before traversing them. This prevents test setu=
ps
from crashing if damos_commit_quota_goals() creates an unexpected number of
goals.

Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
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
This is a pre-existing issue, but since this patch fixes this exact pattern=
=20
for quota goals, does damon_test_commit_target_regions_for() need a similar=
=20
fix for target regions?

If damon_commit_target_regions() fails (for example, due to a memory=20
allocation failure), it returns an error code and leaves dst_target's=20
regions unmodified. The test code currently ignores the return value and=20
blindly iterates over dst_target:

mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for() {
...
	damon_commit_target_regions(dst_target, src_target, 1);
	i =3D 0;
	damon_for_each_region(r, dst_target) {
		KUNIT_EXPECT_EQ(test, r->ar.start, expect_start_end[i][0]);
		KUNIT_EXPECT_EQ(test, r->ar.end, expect_start_end[i][1]);
		i++;
	}
...
}

In a case where the original number of destination regions is larger than=20
the number of expected regions, could this loop execute more times than the=
=20
size of expect_start_end[] and cause an out-of-bounds read on the stack arr=
ay?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717003022.1194=
37-1-sj@kernel.org?part=3D6
