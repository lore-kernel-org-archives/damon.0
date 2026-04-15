Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE82F83A0
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216953; cv=none; b=fufBwGUMVu1SezKiQiW7bRYX1JH/ZxEq83r8Ouc1zny12gO4Xk+VsLZi95SNtP4YYxrZRr6yX79/qHUl/142RKElYz7K1/526u0JOfr1MUs88VZGK9oAdx7f0aonXAxA76siu5dBsJGvSTHUxrjkjQHZUQGw6T9DXoBNIGZgS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216953; c=relaxed/simple;
	bh=Y9Iydy4zHc9vNd2vNxdNHLwj66zaoArgIolMu2hfF4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qrQdHQnU4EIvdUbKWj1O31QQil8XjWBSvMl25dFjmic5HG7SND7RrFru9CIEGhm4hULl+2T0cCipL4+PXlvuzByXNOYYkDmGz305xdpHlh5svZ++zn7/xCGQQRKcEzCuA9Yb0kFG/rn8bwoEA1wdO5ypR3cDA8kNlbIlYOzzcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUrkJlob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUrkJlob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E4EC19425;
	Wed, 15 Apr 2026 01:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216953;
	bh=Y9Iydy4zHc9vNd2vNxdNHLwj66zaoArgIolMu2hfF4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JUrkJlobVm5sVH7ajLOo6CBY1P3Po/ZGPNQEflIvxq0ZlGwXuh0zTUQBcvtXqaA0w
	 vrNKyLHTty+fCIyD40G17WZySTdz7IqbCI2l2hvfEOkoV6hB6LpL8kLW8t4ZJR7sKv
	 PAeVhruN39RiMtVLSYb7Ze5uLkn+4YxJiQ+wTeQKxGKAFCMopK+vq6bm0GGBuSnGKI
	 YzyRGcz1TGVBrSxtEEXHQE+vxI4Gi36/7zsQTbo4u+kGF7eADUBgPkVgw3vHLRR5W9
	 NDdn2meGerXBixeSBQIvQ/AcSlITXJwlOO2QajmtZzyQQ38drJMkBRLp/l0/9FGTII
	 AcWq2cJrkdNfQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/7] mm/damon: introduce
 damon_set_region_system_rams_default()
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260415012048.76508-2-sj@kernel.org>
References: <20260415012048.76508-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 01:35:52 +0000
Message-Id: <20260415013553.43E4EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Creation of a single bounding box region for all System RAM severe=
ly degrades monitoring accuracy on sparse memory topologies by including no=
n-RAM holes.
--

commit 8f8f43643f81a1ce41ad12d7eb7416faa6e23114
Author: SeongJae Park <sj@kernel.org>

mm/damon: introduce damon_set_region_system_rams_default()

This commit introduces a function to set the default target region to
cover all System RAM resources instead of just the largest one. It finds
the start of the first resource and the end of the last resource, and
sets this bounding box as the target region.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 12544c60531d3..91e14caa4f6a1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> +static int damon_system_ram_walk_fn(struct resource *res, void *arg)
> +{
> +	struct damon_system_ram_range_walk_arg *a =3D arg;
> +
> +	if (!a->walked) {
> +		a->walked =3D true;
> +		a->res.start =3D res->start;
> +	}
> +	a->res.end =3D res->end;
> +	return 0;
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

Could this create a single bounding box region that includes large non-RAM
holes on systems with sparse memory layouts?

Since damon_system_ram_walk_fn() only records the minimum start address and
maximum end address across all System RAM resources, creating a single
contiguous damon_addr_range from this bounding box includes any
intervening address gaps.

On multi-socket NUMA systems or devices with large MMIO holes, this
could result in massive address ranges not backed by actual RAM. Because
DAMON uniformly samples random addresses within each region, sampling
might predominantly hit these unbacked memory holes.

Would this dilute the access sampling and cause actively used memory to be
incorrectly classified as cold? Should the code gather discrete System RAM
ranges into an array of struct damon_addr_range and pass them to
damon_set_regions() with nr_ranges > 1 to exclude holes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415012048.7650=
8-1-sj@kernel.org?part=3D1
