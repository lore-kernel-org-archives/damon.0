Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B442D3733
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931037; cv=none; b=dUk3p3/vA4Nx4H+52fBHMcUI9v7lPYZc5Be3l+iHtP6AET9PEchgbPr6IT9+vHKzEz6HlwAaKTG0YozF5hiMlLvBfkbdgFd4O1xb558gnwYjSQ14ZPzp/xYAVGZBgeszGVXgTZmidGD7DrhmEeUfsqWYjQUdqq+1f91MYVSQIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931037; c=relaxed/simple;
	bh=A2x9Y27bEOVeAkGvYYH3pEhy0GAq3R58kcj0tC++uEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PueLBWTDl2gp466UGIZlnCfirEG5Mha7oYDxaz4IJTSp230DGjWx5wn57y0+L7lbiDAYqybOnKdsYolRSJtGkRvZ4uA1xll433tT5Yb99E9Ds0vkjXwKANf/GoyGGxeZMyAvooW3HIORZaHDz9/GzJnSuX+T0eLy51HZUBFpfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY+/6CKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY+/6CKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB8B1F00A3A;
	Wed,  9 Sep 2026 05:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931035;
	bh=rhUcmLDsgts9xzSivHGiLeaZZjhGSKKU3TQpKsRBEqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XY+/6CKzb22JCvMS4/Dqbv5ulLn878P7NFnTHVEPwMg9XpjNeBLxlooK4r7AvrotK
	 b84UsqndjjFc1/DTawbTz7mFVlGReOG+DVoNcfwpMgeIdbMI0kdsGMqfJSBE66SAFZ
	 Eohwg7z6HTbju0mjPeDbK/InCyQbx3XYUjbtXdx8dFdyoxr5DklksYfyM8dOKWBkE/
	 WtQw/4rWM/UcL6OqCzHVjQuWGC/WCxCuhKWzscTBxR2BYds6ZcmgXQMjsnzlJ/0rDx
	 5a0rfjlzz1pSMXDPDfdkscfh8UeI/bnXcgZucxpkx8gUDJ+pScThNLnjJwga2DXX3t
	 oUa8oaZcGs8yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/ops-common: use nr_accesses moving sum
 for quota score
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909050521.225965-1-sj@kernel.org>
References: <2026090846-defendant-neglector-22c4@gregkh>
 <20260909050521.225965-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:17:14 +0000
Message-Id: <20260909051715.3DB8B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to fix the issue by using a new helper=
 function `damon_nr_accesses_mvsum()`, but this function is never defined o=
r called.
--

commit 3c964119e352fe243aaf217b238b33be4fa99148
Author: SJ Park <sj@kernel.org>

mm/damon/ops-common: use nr_accesses moving sum for quota score

Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific apply
interval"), DAMOS scheme can be applied at any time.  At that time,
nr_accesses may not be fully aggregated.  But the quota prioritization
score is calculated using the not fully aggregated count.  As a result,
the performance of DAMOS could be degraded.  Fix by using
damon_nr_accesses_mvsum() instead.

Link: https://lore.kernel.org/20260719161136.90191-1-sj@kernel.org

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index ceaa2a6e1c9a3..929aab600c745 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -101,8 +101,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,
>  	unsigned int age_weight =3D s->quota.weight_age;
>  	int hotness;
> =20
> -	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
> -		damon_max_nr_accesses(&c->attrs);
> +	freq_subscore =3D mult_frac(r->nr_accesses_bp / 10000,
> +			DAMON_MAX_SUBSCORE,
> +			damon_max_nr_accesses(&c->attrs));

[Severity: Medium]
The commit message claims to fix the issue by using a new helper function
damon_nr_accesses_mvsum(), but this function is never defined or called.

Instead, the implementation in damon_hot_score() manually inlines the moving
sum calculation (r->nr_accesses_bp / 10000).

Is there a missing patch that adds damon_nr_accesses_mvsum(), or should the
commit message be updated to match the inline calculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909050521.2259=
65-1-sj@kernel.org?part=3D1
