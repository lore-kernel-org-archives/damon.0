Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2A3F787F
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146853; cv=none; b=NBX7ml8EXXMV5Sno13YOicI5u3jYGVHAxroCQbTflsh5mufhRGWc+hrbrkkX8rNk7kPqVkyS4cV4NLEFBMQa0aWgLriohBh0ek+/ogkEaWdtB+2LE0M0RslhwEzu7FWk7WCD1xz1iQwcO62XxXUjk4hQSkNMOna36OVbdQwuG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146853; c=relaxed/simple;
	bh=JyOq//3XD7c5yhodVBZ2TnYZUxeGZDETKxYS09I4Jks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q3NT3xDJZwyw61kZ1rlxCOaPiIAXIqkSOhGXJQH3E/oMVBw/K05qCk1NyoQIHX7XQTN/FA20GkfDao/0VWsOkzpRlXhRbzxVxAd030inspJdcHRwV2J/NRQOLQE6clW2J6uaK2Hd+2TkcYSTv6ik3VczVfXmt7RaWK26eP0/fPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVdhP086; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVdhP086"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8B01F000E9;
	Mon, 27 Jul 2026 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146851;
	bh=Z8A2f3dkAarbeSRhml+f6qi7evPdoGKQ7V+ebtj8gtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVdhP086cu3CkO1UnmgGqnpRDajo8l1gsRu4MUlJhUKOhVuw0/5iDHBYpBj5eT0Q4
	 BxJB6wS5c0C4s6e0ekPR/EflLv6AE1ZDiVfJpvDxXK5EMbCWi6b0g7xcO8ncK43blK
	 yJz837JMvwNcEjYUtafWZWb/FuQV0DaqGHOlVtQeWxkwPiwatXK9r3BR8cXKBz2Yfl
	 ECVwaOIDE4VJ1pDhTjbMlnL18d7hZ4evjFIeo+TwNOKn7iOUZe7KZOkrN5FkrOdDTr
	 4PkdG3edZFvsSNaLKKuXQeBrDtC/f9ybMzv1HaPrrW0ePKtev2M9YmWH30nSuQ2UQH
	 jg/PGyuxL6t/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with
 per-range regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260727095429.143527-1-jiayuan.chen@linux.dev>
References: <20260727095429.143527-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:07:31 +0000
Message-Id: <20260727100731.BC8B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Time-of-check to time-of-use (TOCTOU) race condition in `damon_fin=
d_system_rams()` leads to a heap out-of-bounds write during concurrent memo=
ry hotplug.
- [High] DAMON initialization fails with `-EINVAL` on systems with sub-page=
 System RAM gaps due to alignment overlap in `damon_set_regions()`.
--

--- Patch [1]: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas w=
ith per-range regions ---
commit 20fb01bf6e8e4cefc6016dfc073fb77c95ca3511
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon/core: cover discrete System RAM areas with per-range regions

This commit changes how DAMON sets default monitoring regions for System RA=
M.
Instead of a single region covering all RAM (and the holes between), it now
creates separate regions for each discrete System RAM area. This excludes
large memory holes from being monitored.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..365c43271c0c6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> +static int damon_find_system_rams(struct damon_addr_range **ranges_out,
> +				  unsigned long addr_unit)
> +{
> +	struct damon_system_ram_range_walk_arg arg =3D { .addr_unit =3D addr_un=
it };
> +	struct damon_addr_range *ranges;
> =20
> +	/* First pass: count the coalesced ranges. */
>  	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
> -	if (!arg.walked)
> -		return false;
> -	*start =3D damon_res_to_core_addr(arg.res.start, addr_unit);
> -	*end =3D damon_res_to_core_addr(arg.res.end + 1, addr_unit);
> -	if (*end <=3D *start)
> -		return false;
> -	return true;
> +	if (!arg.nr_ranges)
> +		return 0;
> +	ranges =3D kvmalloc_objs(*ranges, arg.nr_ranges, GFP_KERNEL);
> +	if (!ranges)
> +		return -ENOMEM;
> +	/* Second pass: fill in the coalesced ranges. */
> +	arg.ranges =3D ranges;
> +	arg.nr_ranges =3D 0;
> +	arg.has_prev =3D false;
> +	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);

[Severity: High]
Can this race with memory hotplug events and cause an out-of-bounds write?

walk_system_ram_res() is called twice without holding memory hotplug locks.
If a new System RAM region is hotplugged between or during the second pass,
the number of visited regions could exceed the allocated buffer size.

If that happens, damon_system_ram_walk_fn() would write past the end of the
kvmalloc-allocated buffer:

mm/damon/core.c:damon_system_ram_walk_fn() {
	...
	if (a->ranges) {
		a->ranges[a->nr_ranges].start =3D start;
		a->ranges[a->nr_ranges].end =3D end;
	}
	a->nr_ranges++;
	...
}

> +	*ranges_out =3D ranges;
> +	return arg.nr_ranges;
>  }

[ ... ]

> @@ -3984,14 +4021,25 @@ int damon_set_region_system_rams_default(struct d=
amon_target *t,
>  			unsigned long addr_unit, unsigned long min_region_sz)
>  {
>  	struct damon_addr_range addr_range;
> +	struct damon_addr_range *ranges;
> +	int nr_ranges, err;
> =20
> -	if (!*start && !*end &&
> -		!damon_find_system_rams_range(start, end, addr_unit))
> -		return -EINVAL;
> +	if (*start || *end) {
> +		addr_range.start =3D *start;
> +		addr_range.end =3D *end;
> +		return damon_set_regions(t, &addr_range, 1, min_region_sz);
> +	}
> =20
> -	addr_range.start =3D *start;
> -	addr_range.end =3D *end;
> -	return damon_set_regions(t, &addr_range, 1, min_region_sz);
> +	nr_ranges =3D damon_find_system_rams(&ranges, addr_unit);
> +	if (nr_ranges < 0)
> +		return nr_ranges;
> +	if (!nr_ranges)
> +		return -EINVAL;
> +	*start =3D ranges[0].start;
> +	*end =3D ranges[nr_ranges - 1].end;
> +	err =3D damon_set_regions(t, ranges, nr_ranges, min_region_sz);

[Severity: High]
Could this fail with -EINVAL during initialization on systems with sub-page
memory gaps?

If the system has System RAM fragmented by small non-RAM holes (like sub-pa=
ge
BIOS or EFI reserved regions), damon_system_ram_walk_fn() will create separ=
ate
discrete regions.

When these regions are passed to damon_set_regions(), it aligns the boundar=
ies
to min_region_sz (typically PAGE_SIZE):

mm/damon/core.c:damon_set_regions() {
	for (i =3D 0; i < nr_ranges; i++) {
		...
		start =3D ALIGN_DOWN(ranges[i].start, min_region_sz);
		end =3D ALIGN(ranges[i].end, min_region_sz);
		if (start >=3D end)
			return -EINVAL;
		if (i > 0 && last_end > start)
			return -EINVAL;
		last_end =3D end;
	}
	...
}

If the gap between two RAM areas is smaller than PAGE_SIZE, the ALIGN of the
first region's end will evaluate to a higher address than the ALIGN_DOWN of
the second region's start. Does this cause the strictly-ascending overlap
check (last_end > start) to trigger and reject valid configurations?

> +	kvfree(ranges);
> +	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095429.1435=
27-1-jiayuan.chen@linux.dev?part=3D1
