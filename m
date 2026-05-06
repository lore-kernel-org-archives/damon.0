Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAF347516
	for <damon@lists.linux.dev>; Wed,  6 May 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100046; cv=none; b=JH/RsKPIicQk00FzknCUtuqqOyHYBF+NqMOZBpkGRJ4QifLXE3kF3d11jWvxaGXnQs2UB9VJKo64YZb9CDYqRDZVqhHM4HLtX/oKsbSqOF1PE5kIIaXW3EfdbQB5a5Rl/uOvNgKXZeA8jBm1HbL/H+GaUH9k6GLTMqPRkKi6ykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100046; c=relaxed/simple;
	bh=1pxr5K78ZjRa9BxzqhoKuzPUViadJ/IdXUJ74skQGco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AGJpOIZcm5BdSrqS9lJPQd177+JT99/KKkxqT/wXngdG7gaQ87Ix9GEF6eEqfeegfSiiR6YringkWOupi52J45Y4UkuGg3kdEDoFkZudcCJtRlBK/Vh6/qcDa8pSto2FRlO1R1gNsLXtm7sFC9C4ZFsbO+iuUdxEntChfFkskNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLvzilJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLvzilJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C53C2BCB0;
	Wed,  6 May 2026 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778100046;
	bh=1pxr5K78ZjRa9BxzqhoKuzPUViadJ/IdXUJ74skQGco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tLvzilJMxbmoPavACuZPesNZBtFPh7Y9UHN/I3SEMn+aqFnTg6IJpjDwpe/3FGKQW
	 BBvuUFW8HfIZjWrw1coJ/KlbAuxGW5mpNo7BVCxEimdmoeM4sj24GgsVsZ26CpDUhc
	 wuGb0natnH0QgQmV1aWSv7GKzGFJ2kgI3wAwOpfSzkXoDtbfK6zicPetgtooawsu+u
	 dxJ7MUA/UaeMXroN+79vjnhCUmu3UPKyN+Djkx/76RHx8IH68ida6Gg5FsBLJLycgi
	 3Cq8aPry1CeHgx8PnoHB0L7/oOI4I69E2GbxEDfdKJ4AdLs7DHYMwNm/e6xRhlbOZu
	 hJ2qwsd7A23yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y v2] mm/damon/core: disallow time-quota setting
 zero esz
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260506165211.10410-1-sj@kernel.org>
References: <20260506165211.10410-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:40:45 +0000
Message-Id: <20260506204045.F0C53C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix: DAMOS scheme can still unexpectedly deactivate if =
using quota goals without a time quota.
--

commit ce7d104c8087fff14fb782b89848659312c204fa
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: disallow time-quota setting zero esz

This commit addresses an issue where DAMOS time quota can reduce the
effective size quota below the minimum region size. This causes no actions
to be applied, unexpectedly deactivating the scheme. The fix enforces a
lower bound of min_sz_region on the effective size quota when a time quota
is used.

Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 87b6c9c2d6471..feec1b0c2babe 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2150,6 +2151,7 @@ static void damos_set_effective_quota(struct damos_=
quota *quota)
>  		else
>  			throughput =3D PAGE_SIZE * 1024;
>  		esz =3D min(throughput * quota->ms, esz);
> +		esz =3D max(ctx->min_sz_region, esz);
>  	}
> =20
>  	if (quota->sz && quota->sz < esz)

Could this still leave a case where the scheme is unexpectedly deactivated
if quota goals are used without a time quota?

If a scheme is configured with quota goals (!list_empty(&quota->goals)) but
no time quota (quota->ms =3D=3D 0), the bounds check added here inside the
if (quota->ms) block is bypassed.

When the system metric over-achieves, the feedback loop in
damon_feed_loop_next_input() can limit quota->esz_bp to its minimum of
10000, which evaluates to an esz of 1:

	if (!list_empty(&quota->goals)) {
		unsigned long score =3D damos_quota_score(quota);

		quota->esz_bp =3D damon_feed_loop_next_input(
				max(quota->esz_bp, 10000UL),
				score);
		esz =3D quota->esz_bp / 10000;
	}

During scheme application, damos_apply_scheme() calculates the size using
ALIGN_DOWN(1 - 0, ctx->min_sz_region). Since min_sz_region is typically
PAGE_SIZE, this evaluates to 0 and the action is skipped entirely.

Because the feedback loop increases esz_bp multiplicatively, it would take
multiple charge windows for esz to grow from 1 back to min_sz_region after
the score drops. During this period, the scheme applies 0 actions despite
the score indicating they are needed.

Should the max(ctx->min_sz_region, esz) bound be applied outside the
if (quota->ms) block to ensure any auto-tuned esz is properly bounded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506165211.1041=
0-1-sj@kernel.org?part=3D1
