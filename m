Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2382DF13A
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777437543; cv=none; b=OaiwzMLQbFddIQVHwxUeLZzvgApVESm6DX3hHb9DXuePgvBwRoZsv9gJuDABEvPgT2y+gAo/i4xMB5RYr3lscEVN07MCny1zd3RHh3YgQa1Yp1lcvaQPaKj+V9bRVqBtpDEPdd32onUw18B88M2yfyNquegCvBSyjpQwCmvYex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777437543; c=relaxed/simple;
	bh=gZXmbSDCBhZKzmAHaUVPxkN+wl9q2RtCVUbYW/ehPDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtOdlOI7MIURTMh5Kr9s3NF3cnYMM0QvHamFcjE4BFCT4YlU2POjliV+rQPFcZJXtqDSZNaDRPfmCD0kLtisDCan8bVPxeUtszjgUrRW0XK5V/UBud8Nd0Ojer0Ka9ox4tISDNPancBLpHwpoLX+USLjlab18RaWMb9mmCK7Ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLoJGR+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLoJGR+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FFDC19425;
	Wed, 29 Apr 2026 04:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777437543;
	bh=gZXmbSDCBhZKzmAHaUVPxkN+wl9q2RtCVUbYW/ehPDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iLoJGR+kRUbtHo6TEFcuLr3xu2Ftci470X2mBGM9Frxb6i+QLhf/1EklZfEUxGhyq
	 JjDskXS3PoZ6YD//enC2HSOnxuM536TQ+/fc2qm1HlXfAdGN87kN4vJaLBmVHktA9X
	 glcEg+t6V9fzID58XVnLiYTzzdjb8RvtTvEU3gF/p3DPiHL3MlEBlIlmFR1eEwn49k
	 +o5pTGGNytWBvy4UVKrsOObim4up+VLhVjZb/vHgbDeVgDabY1DFAFJcNDWONGbC9s
	 4tJ23L9bw7I2Jxn3DgryzSOGcMltJxLFuvkFAtadX01SyB6KlK2J3nQt1dRC77EkD4
	 CBrVtxLYpKZzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon: introduce
 damon_set_region_system_rams_default()
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260429041232.90257-2-sj@kernel.org>
References: <20260429041232.90257-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 04:39:02 +0000
Message-Id: <20260429043902.E8FFDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The default region setup creates a single contiguous bounding box =
encompassing all System RAM resources, incorrectly including unpopulated me=
mory holes.
- [High] Integer overflow during physical address boundary calculation (`ar=
g.res.end + 1`) can cause DAMON initialization to fail.
--

commit cd855b0d7d334ccf9a13e1331105a3281e5b0aeb
Author: SeongJae Park <sj@kernel.org>

mm/damon: introduce damon_set_region_system_rams_default()

Introduces a default target setup for DAMON that sets a physical address
range covering all System RAM resources when the caller doesn't specify
a region.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 05e4bef367db..980a31cd3498 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> +static bool damon_find_system_rams_range(unsigned long *start,
> +		unsigned long *end, unsigned long addr_unit)
> +{
> +	struct damon_system_ram_range_walk_arg arg =3D {};
> +
> +	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
> +	if (!arg.walked)
> +		return false;
> +	*start =3D damon_res_to_core_addr(arg.res.start, addr_unit);
> +	*end =3D damon_res_to_core_addr(arg.res.end + 1, addr_unit);

Can arg.res.end + 1 overflow here?

If a 32-bit system has physical memory extending to the end of the address
space, arg.res.end will be the maximum representable value. Adding 1 would
overflow to 0, making *end 0. The subsequent check if (*end <=3D *start)
would then evaluate to true, causing the function to silently return false
and abort initialization with -EINVAL.

> +	if (*end <=3D *start)
> +		return false;
> +	return true;
> +}
[ ... ]
> +int damon_set_region_system_rams_default(struct damon_target *t,
> +			unsigned long *start, unsigned long *end,
> +			unsigned long addr_unit, unsigned long min_region_sz)
> +{
> +	struct damon_addr_range addr_range;
> +
> +	if (*start > *end)
> +		return -EINVAL;
> +
> +	if (!*start && !*end &&
> +		!damon_find_system_rams_range(start, end, addr_unit))
> +		return -EINVAL;
> +
> +	addr_range.start =3D *start;
> +	addr_range.end =3D *end;
> +	return damon_set_regions(t, &addr_range, 1, min_region_sz);

Does this create a single bounding box encompassing all System RAM resource=
s,
including unpopulated memory holes?

On systems with sparse physical memory layouts, this combined range will
encompass massive memory holes. Because DAMON uses uniform random sampling
within a region to estimate access frequencies, samples landing in the gaps
will inherently register as unaccessed, diluting the perceived access rates
and preventing effective adaptive region splitting and merging.

Could the implementation instead construct an array of multiple ranges,
one for each distinct System RAM resource, and pass them to
damon_set_regions()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429041232.9025=
7-1-sj@kernel.org?part=3D1
