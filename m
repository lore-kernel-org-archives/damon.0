Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD821B4F1F
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922942; cv=none; b=ourM/5k7Wo8CzKIIamueRKR38cjciLJKiIglOR0ztJHUVfRpWqJzhXnzoY7ct+DGQx8c7XUVOLdmylpZthDAqaa5LG3ioy41FnhKzW/JcZxoGB5pliODgyNL9rD++XmUjdeXcmCX2f+VyOBfEfTvO5awfKqF7+RzQdtpRERjtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922942; c=relaxed/simple;
	bh=p3q2wHA5Ha6oO9QPusIcVIkdaP4RUdM60l0j1pyjejE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hIIHXMFj4Ayh/mcpfzO37iuhJIX8Hfycbks7cVhIEoRDw8wPYTzRBFO0074wROcYq5+oiTJ0dzTdHGWcB6JpZ/NyTNqFfD2DHraREG+x2D5lQUJ1fZ20D7HZcZAV1496RmFh8TeJ1xjt7r/qjmpf/Xh1SU9dLgpTFymD37+LCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL3lCWKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL3lCWKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370651F000E9;
	Wed,  1 Jul 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922941;
	bh=NpV+qYrVX6WQJiHZbWV8rOmv1LQ0hPH7+29ByflHJgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cL3lCWKeAMz7rfKDPqPYYe9h/KB7+vJOCXPpAa+TTB4yhbjmvcbzW7iVUz0sZo4VV
	 ZDAVGGOA8AqrUXiRsGpD0hsQit3acmDVZd/DcXKnNwAol35rzP24wtOYhkf0HMT9KH
	 xuc/dvHPC7spzgczAv+qMhfqPs5Q0A6Ohr0/zBXxnl3KJR7lHcjHQimbtrfKl1oYSy
	 P/m1FbfiFsgFXwanfWKc6KzmWy0pgZc1oRNsSjo01+G9G8KI4bDz61h1ajqfWp5Jaf
	 96Hh2kDv/DkY5X6CmbBHSRxDeisJoRuPpUfcWhGsnVcov3EXjpH+2M3n937Dzo+416
	 5r5bEIWn+QjzA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] mm/damon/core: remove start, end check in
 damon_set_region_system_rams()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-8-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:22:20 +0000
Message-Id: <20260701162221.370651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of bounds validation permits inverted regions (start > end=
), leading to a massive integer underflow and guaranteed OOM kernel panic.
--

commit 03335779d391504c4265be49dedb155969cf1a7d
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove start, end check in damon_set_region_system_rams()

This commit removes the explicit start > end validation in
damon_set_region_system_rams_default(), stating that damon_set_regions()
already performs a complete check.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ace202f47dd7c..f491a76c98bfc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3794,9 +3794,6 @@ int damon_set_region_system_rams_default(struct dam=
on_target *t,
>  {
>  	struct damon_addr_range addr_range;
> =20
> -	if (*start > *end)
> -		return -EINVAL;
> -
[Severity: High]
The commit message states that the complete check is done inside
damon_set_regions(), but does damon_set_regions() actually validate that
start is less than or equal to end?

Looking at damon_set_regions(), it appears to blindly create the region
with underflowed sizes if start > end:

mm/damon/core.c:damon_set_regions() {
        ...
        r =3D damon_new_region(
                ALIGN_DOWN(ranges[i].start, min_region_sz),
                ALIGN(ranges[i].end, min_region_sz));
        ...
}

If an inverted region (e.g., [4096, 0)) is passed in, could this lead to a
massive integer underflow? The size of the region would underflow to roughly
ULONG_MAX.

Later in damon_apply_min_nr_regions(), this underflow seems to translate
into an effectively infinite loop:

mm/damon/core.c:damon_apply_min_nr_regions() {
        ...
        while (damon_sz_region(r) > max_region_sz) {
                damon_split_region_at(t, r, max_region_sz);
                r =3D damon_next_region(r);
        }
        ...
}

Could this loop exhaust system memory by attempting to allocate quadrillions
of regions and cause an OOM kernel panic?

>  	if (!*start && !*end &&
>  		!damon_find_system_rams_range(start, end, addr_unit))
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D7
