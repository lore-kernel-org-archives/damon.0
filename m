Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63FD4964F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898549; cv=none; b=DXmDdDOL8jiLxVoiypA0fU7Z54gdn1migONOA9QoDtDKFdCn+TSkN0HrY0fTtnslR0fIaar1HoWAJ3ioQaHkZw4lFI0InLaVHYPuT5DdrQSjKdByCPStlkBQTXg71ZzVgvJVs1QCi4R7afYHQ6wZFt7MFQNYiOu/CRomEZqJlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898549; c=relaxed/simple;
	bh=wxQb9gLbBMEOTvMBq9cNHJCfNK/ibmbGVXoyU14QAcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJ9FgVxrMaDGz0iE9dZ9R6K4F7Wuld+pbLuZJKw8+IeTBfqbMXxnYBqNhKZbDkf0hH48XDTUNM0vRfKpdeCp7T0rD0/C72dRHjeTX2wYTUh7L5+eoEnE7/52kOt574ESjzZ0W0+ZKMf2jtU7WlAFbt6IfhKffDNBxMT8jmJMjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPMD2TXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPMD2TXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7911F000E9;
	Fri, 19 Jun 2026 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898548;
	bh=UpYy0/6AHkBct/bv/V1ra8406nOdH5Rl2Z3jtd1PYmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPMD2TXImXIkkfq5fuVaF2IZeOJgUmUsnxzcmi42s+a302JA8MAmlLqQ3hUxxIyFD
	 w/1gEUo499e4SAZmT5HkLIcrVfWs7i4i7+rj62s5sl/P3/+WiAroE6EbjRBCnrIhf9
	 mY05M3qYt9hpmKqnUOhFD5IhY7JC/6H4gJ/inhX/Cr9QNe6+cO9qVLmVVudsvrdPQJ
	 eHXpyeIZx1WJk1SqkO4wkESpPUDUe1TANnNN1ksMiGweSsvU4Pr+amoW7bHv6o2Lme
	 IL/94/vc1CAovff6IciSfGGOtpR/pcKP3QRPOLwHMn7ojYG2goCMkm++BLxnvKNaS2
	 3uXueTxRMX2vA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/13] mm/damon/core: use damon_nr_accesses_mvsum()
 in __damos_valid_target()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-4-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:49:07 +0000
Message-Id: <20260619194908.4A7911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Divide-by-zero kernel panic in damon_nr_accesses_mvsum() when aggr=
_interval is configured to 0.
--

commit 9675c26c9e91a5b3df67520a05b7e2a8a6a589a7
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()

This commit modifies __damos_valid_target() to use the helper function
damon_nr_accesses_mvsum() instead of directly reading the nr_accesses_bp
field.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bc8b102d700a7..f45f030a72d82 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2118,10 +2118,11 @@ static void kdamond_tune_intervals(struct damon_c=
tx *c)
>  	damon_set_attrs(c, &new_attrs);
>  }
> =20
> -static bool __damos_valid_target(struct damon_region *r, struct damos *s)
> +static bool __damos_valid_target(struct damon_region *r, struct damos *s,
> +		struct damon_ctx *c)
>  {
>  	unsigned long sz;
> -	unsigned int nr_accesses =3D r->nr_accesses_bp / 10000;
> +	unsigned int nr_accesses =3D damon_nr_accesses_mvsum(r, c);

[Severity: High]
Does this introduce a divide-by-zero risk if aggr_interval is configured to=
 0?

If an administrator writes 0 to both sample_us and aggr_us via the
DAMON sysfs interface, damon_set_attrs() allows it because the
validation check (attrs->sample_interval > attrs->aggr_interval)
evaluates to false (0 > 0).

When __damos_valid_target() evaluates active schemes, it now executes
damon_nr_accesses_mvsum(). Inside that function, window_len is calculated
like this:

damon_nr_accesses_mvsum() {
	...
	sample_interval =3D ctx->attrs.sample_interval ? : 1;
	window_len =3D ctx->attrs.aggr_interval / sample_interval;
	left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_intervals;
	left_window_bp =3D mult_frac(left_window, 10000, window_len);
	...
}

If aggr_interval is 0, window_len evaluates to 0. It is then passed
as the denominator to mult_frac().

Could this result in an exact integer division by zero panic, and should
the zero-values be protected against here or in the configuration interface=
s?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D3
