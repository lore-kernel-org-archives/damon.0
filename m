Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE6175A7E
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475263; cv=none; b=h1oWsk1dE8JS7t5iIVIeufhkXTdLIV5Kh847IGh52OuwyhwHRW2erNgX9cH5QgSsluG0LiJKWy+QdbwNsIQuKyoKQDqLi5IZw9Rs76/iFJUFMHXzvr2jUyH4nLaeYMa3BcNjYzRRSsEDNSWTdSaqwZJtGWYkxCfsQ+c5xJkAEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475263; c=relaxed/simple;
	bh=8RHIX8mDutvzA5Sq6zTydTiElNpjEyzGNhgtn0eO5hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U4mL/PvKy+rkKOTkezJ+5MGjt/H//zvF0x/GJjcLfjVZh86dzKMojB68V4nK7dQajQUOgUTTMMY3oZd8kVA7rboVKgzlT8jZXaTsA6HmIp27GYwhaMKDnKlm5HYbFlNwXK7PA2HreZxKd0lslA/PAFm41iiwUzV2mJt8ThBks0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTiVWc2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTiVWc2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB81F000E9;
	Wed,  8 Jul 2026 01:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783475261;
	bh=69pNqRgrgzLQ9LS1hDDDRm43qknD5vYvO+vc06CQqC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTiVWc2SdkjVLxLAQkwp4QMabHqpF6S+Z2h6M2OS4b6fqp9leZyDA6UW+Y4XQk3PX
	 cLPTfC3feUC7urtLBAOMWuF4BtWLUeItgRy965fRC0SZOKtKIyn5CnFuVyZLKhHh+m
	 QvzLIWTGYIEG4q8bCJ9JE6Hpup4UnXMreRgCf7IHZ+8MZ+sQwP7J3B3o0EihPKFhOY
	 6cWKzzzEPz0nZKBvhEEuUvx6YG7kBCAcbqzcIqGZx/4Kivdnmd9N65QmzyxB/OS9HQ
	 bQpM/aNPl5IvSVdetQHvugcxK1n5GfKp0kPei7q8j9NRC8NcSuIuM+Y4U5Bc837CyZ
	 7cjtjP2zI6Zyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 6/7] mm/damon/core: update probe hits for new
 parameter commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708013252.95888-7-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
 <20260708013252.95888-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:47:40 +0000
Message-Id: <20260708014741.1EEB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent integer truncation causes scaled `probe_hits` to wrap aro=
und, corrupting monitoring data when updating DAMON attributes.
--

--- Patch [6]: [RFC PATCH v1.2 6/7] mm/damon/core: update probe hits for ne=
w parameter commit ---
commit 3c348527fa362f1ef3768392d433781b92010ba7
Author: SJ Park <sj@kernel.org>

mm/damon/core: update probe hits for new parameter commit

This commit ensures that DAMON probe hits are appropriately scaled when a u=
ser
dynamically updates the sampling or aggregation intervals at runtime. It
applies the existing scaling logic used for other metrics to both probe_hits
and last_probe_hits.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 800ff6b6d2473..15d31285515d6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -897,10 +897,32 @@ static unsigned int damon_nr_samples_for_new_attrs(=
unsigned int nr,
>  			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
>  }
> =20
> +static void damon_update_probe_hits(struct damon_region *r,
> +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> +		bool aggregating, struct damon_ctx *ctx)
> +{
> +	struct damon_probe *p;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(p, ctx) {
> +		r->last_probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +				r->last_probe_hits[i], old_attrs, new_attrs);
> +		if (!aggregating)
> +			r->probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +					r->probe_hits[i], old_attrs,
> +					new_attrs);

[Severity: Medium]
Will this silently truncate the scaled probe hits if they exceed 255?

The function damon_nr_samples_for_new_attrs() returns an unsigned int, but
both last_probe_hits and probe_hits are defined as unsigned char arrays in
struct damon_region.=20

If a user dynamically updates intervals via sysfs such that the new
aggr_samples is significantly larger than the old one, the scaled value cou=
ld
exceed the 8-bit maximum and wrap around modulo 256 instead of saturating.

Should these values be clamped to the maximum value of an unsigned char to
prevent monitoring data corruption when the scaled count overflows?

> +		else
> +			r->probe_hits[i] =3D 0;
> +		i++;
> +	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708013252.9588=
8-1-sj@kernel.org?part=3D6
