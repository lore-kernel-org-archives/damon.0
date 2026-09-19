Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894C3911DF
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781011; cv=none; b=X7elyibhpVt5RtfOUvD58gI6bAsz6ljjhloxq281nyhZqpYdh3F84xzVv9bpVRx5luBgJ8D7nliOWL5iV5pLFzq4xpmt7V17aMKDFERKMeNpGBsNjzlWoO86GJcYjtE9YA1kXDfyFlrYxj2tkqx8DKsC5goYrgDBZWwN0AOd/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781011; c=relaxed/simple;
	bh=3Vc20TvNt2M0kic0xWQRXjDUcf/rcO5aRsBZqwmNm2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNoB1TcYp/+0hRUN/DdeIFxtwUaHRoXvZrCIFC/AmW5vWt93y5qVy6Uyng0Ucwpes91khtnQXoRcmuGPdKKlNAOSIX8XCOPwZDmRGGdjz+MglioXcJmoCARsGRYikEyu38A3GpyMDI4fK6eQZ3jGsJbV7txLusTRHgyAFY/OaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJR2THlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJR2THlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7141F00898;
	Sat, 19 Sep 2026 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781008;
	bh=nVvpdhD2FRVsnFAt5yvywigTYO/jeCojeG8R4RdoQJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJR2THlk+QQWj08C7F/08czP+afqxdSV0G59nQxglI1doVLNn4UKTZ73fzi4lIYOQ
	 ZhsfYKCgiA+d4RwD7PvQEkRC1RtS61SFtDz17GXg3yI5tBN9kqPE1HcJ0Q+SUWy93j
	 leAAjHYU1cJrX/5tRCykYLnWqxHRWdBwENA/fqRRCSjAuH5NXkIX/2O3KM6wix/gLe
	 F1r5QEnLLRuOOTgyPcLR7rDb4MGKmX03ilkFVZsJWdBwLAqhLobB2w3e0ViXBYixlI
	 kGrwcidP9KPJDLDXC+Gh+PWWhK1/aCM/mqcvcZXyF3+0TSFZR7mF+/12OrNsvXFYVM
	 1JdZJnhNLQBHQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/7] mm/damon: add complement argument to
 damos_new_quota_goal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-3-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:23:27 +0000
Message-Id: <20260919012327.DA7141F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: damon: hardcoded false complement flag when cloning quota goals
--

commit 9116ea6f94ac9ade4ef359ba8351ef835957bf80
Author: SJ Park <sj@kernel.org>

mm/damon: add complement argument to damos_new_quota_goal()

This commit extends the damos_new_quota_goal() constructor to accept and
set the 'complement' flag value. It also updates all API callers to use
the new signature, which aims to prevent mistakes where the complement
flag was previously set manually.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9fd08cbfacd8c..932ca3ad0e593 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1262,8 +1263,8 @@ int damos_commit_quota_goals(struct damos_quota *ds=
t, struct damos_quota *src)
>  	damos_for_each_quota_goal_safe(src_goal, next, src) {
>  		if (j++ < i)
>  			continue;
> -		new_goal =3D damos_new_quota_goal(
> -				src_goal->metric, src_goal->target_value);
> +		new_goal =3D damos_new_quota_goal(src_goal->metric, false,
> +				src_goal->target_value);

[Severity: Low]
Does this code discard the 'complement' flag from 'src_goal'?

By hardcoding 'false' here instead of passing 'src_goal->complement', the
copied goal initially loses its complement state. While it appears
damos_commit_quota_goal() immediately overwrites the flag with the correct
value, passing 'false' defeats the purpose of the explicit constructor
argument and could create a brittle pattern.

>  		if (!new_goal)
>  			return -ENOMEM;
>  		err =3D damos_commit_quota_goal(new_goal, src_goal);

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 5ff0436c58441..bba97ad449110 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -929,7 +929,7 @@ static void damos_test_commit_quota_goals_for(struct =
kunit *test,
>  		 * damos_commit_quota_goals() will kfree() the dst goals.
>  		 * Make it kfree()-able.
>  		 */
> -		goal =3D damos_new_quota_goal(dst_goals[i].metric,
> +		goal =3D damos_new_quota_goal(dst_goals[i].metric, false,
>  				dst_goals[i].target_value);

[Severity: Low]
Does this discard the 'complement' flag from 'dst_goals[i]'?

Hardcoding 'false' instead of passing 'dst_goals[i].complement' might
break future tests that attempt to verify complemented goals, as the
destination goals in the test framework will lose their intended complement
state.

>  		if (!goal)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D2
