Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148183C455B
	for <damon@lists.linux.dev>; Mon,  4 May 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914368; cv=none; b=ctqvum31EatwAx5pOpHPhiEfO6ntlf6wEjZH3hr++KePG0I2HvWQWtJ7eSSHpjFAAtoS9Y1wBCWF265CjWXN8mklAFHQTeswqQdxl/YDgBmSDFSg/uhReU6hePZtFGR+tI6ZC7OPFurpLeKwDm5hawotsivHFxT6CNxRnPbrVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914368; c=relaxed/simple;
	bh=HrXiCxVzZ8l7SccEo0sG25u3dyUh2F6URjQCbyV9xcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FaTa14+BVUPia3dnHC/eT67/PeLEXUpcOL6TDoBDX6wwHA/fpd+gVo4TF5XUifCIxaZYvUU7HtkkXAFzaJ0saS1cOgjLe3TmHUkz6Jup1ozlYyq0BSPyF8d5qEIOTrrwnxVSybUxJZSyFxI24tb4Yqm4rJCJKLV/tq2rNPhOIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puehRdFI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puehRdFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529EBC2BCB8;
	Mon,  4 May 2026 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914367;
	bh=HrXiCxVzZ8l7SccEo0sG25u3dyUh2F6URjQCbyV9xcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=puehRdFIeEmZOjKv5/JgpNqeEBtvdvwrINkC0gs4MH14qoYRK9NZvL3l3iipqYo/T
	 h73qA2bktiuJqPIqlzMR34OchNa1c3hY0D2LV7Th9w3fBIlehiQdadFixBr98HBeny
	 p0y0z/bzTaMH6WG+A7I7Aq1xSO3Po/aH4x/zlL5GnH9b74ROjSvbUB48rYZez2J5PI
	 i1St5DkgHdU4ei2Nx5Gt1XEjCIJB22is/c9qIOsfxhfX6l/6t2UECBKzw/SF09Gdek
	 5RZMShG+7qeB6SVr4/60xjz+965OlYeWM/BsGtj00okXw+IaS6GEJtWhlZoh18T1vg
	 XBMO2D6o5Bkag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core: disallow time-quota setting zero
 esz
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260504130127.25364-1-sj@kernel.org>
References: <20260504130127.25364-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 17:06:06 +0000
Message-Id: <20260504170607.529EBC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `ctx` parameter in `damos_set_effective_quota()`=
 is unused, and the function incorrectly uses the `DAMON_MIN_REGION` macro =
instead of `ctx->min_sz_region`.
--

commit 8afd735e4c663dcbcca090e71f37ad10c37c705a
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: disallow time-quota setting zero esz

When DAMOS scheme throughput is very slow, the time quota can make the
effective size quota smaller than the context's minimum region size, causing
actions to be skipped. This commit attempts to fix the problem by ensuring
the effective size quota is at least the minimum region size.

Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2124,7 +2124,8 @@ static unsigned long damos_quota_score(struct damos=
_quota *quota)
>  /*
>   * Called only if quota->ms, or quota->sz are set, or quota->goals is no=
t empty
>   */
> -static void damos_set_effective_quota(struct damos_quota *quota)
> +static void damos_set_effective_quota(struct damos_quota *quota,
> +		struct damon_ctx *ctx)
>  {
>  	unsigned long throughput;
>  	unsigned long esz =3D ULONG_MAX;

[ ... ]

> @@ -2150,6 +2151,7 @@ static void damos_set_effective_quota(struct damos_=
quota *quota)
>  		else
>  			throughput =3D PAGE_SIZE * 1024;
>  		esz =3D min(throughput * quota->ms, esz);
> +		esz =3D max(DAMON_MIN_REGION, esz);

Should this be using ctx->min_sz_region instead of DAMON_MIN_REGION?

The commit message mentions bounding the effective size quota to
damon_ctx->min_region_sz, and the ctx parameter was successfully added
to the function signature.=20

However, the ctx parameter is left unused here and the macro is used as a
hardcoded bound instead. Since ctx->min_sz_region can be dynamically
configured, can the effective size quota still fall below it with this
implementation?

>  	}
> =20
>  	if (quota->sz && quota->sz < esz)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504130127.2536=
4-1-sj@kernel.org?part=3D1
