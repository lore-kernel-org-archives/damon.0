Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDD40D565
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782058240; cv=none; b=iPsubhUoChTZAO8dFlxgXDsUPTdCa4QNimWiPWcO2toIIayqV1c74bT+wOEQskU/VaFL5R5V8chDuWBgFC9wjKl1GhGQ0e1upAW7FCKQrcJPkWp8ibANixRN6RQr+4MaNvrQ0H/qfb1IQnuhQUyA6muNonqTA1y/W0Et9sns/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782058240; c=relaxed/simple;
	bh=70Se9veSZ8B7MgDKIfvwSLH/Fl4tgVueNepQetb1ygU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7x9Uwp0KgFCzUuEdF54puHlrdTCb+Z3dnSDoOP3rlfdaUtY06fqXJ2y3+4bUJ42Lpds7WGMq7NqqWnYKE/NgUZDzgkAxDSxCu0V3xZkjb77vqEcJu4S0S0ZP9lwoxjdjTk334TyCmJO3MFNOEJnlUg5lFgidJuihBHhKb2MNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2xu9fW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2xu9fW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9411F000E9;
	Sun, 21 Jun 2026 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782058238;
	bh=gC1opeF6hjmNvPYKowuCUr1CUMb0G7NlL+thW5d6Hno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2xu9fW9x2k2SYWUI+C5CmX78UtH1HpqWyJWNdXnX+Pvf1yFaYLsS8Np5pZ7tiL4j
	 S9wAPwNghQMi4Ra+RrOqJ9QEYr+frmqOA/z/OhLqBPpqnRRbImXbkAyQnJ5y4ureTm
	 z8FkOZWawStCwDLpVeQOgeGm62tFWxeL/wxUhoS7U8wCbuhhToKjBItwCsreic6WOd
	 e2AYIS99v6UZS22DtnXCa2O9KayRVne50SLZesLCmJfS2VU4k7P5tbZEERTCobLlPV
	 lUvJyrvojVYND133LWBAk0aYr0U+ITD6v9A+TQXqw1TFpjifgM5/FMz7tVbT0eXVLo
	 GLFLZMjsEXwyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 01/17] mm/damon: introduce
 damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621155715.87932-2-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
 <20260621155715.87932-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 16:10:38 +0000
Message-Id: <20260621161038.AE9411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Integer overflow in left_window_bp calculation on 32-bit archite=
ctures
--

commit c5893684a7c356bd0f4693c2ef6895c46e83d332
Author: SeongJae Park <sj@kernel.org>

mm/damon: introduce damon_nr_accesses_mvsum()

Introduce a new DAMON core function, damon_nr_accesses_mvsum(), to return a
pseudo moving sum value of a given region's nr_accesses for the last
aggregation interval. This value acts as a relative access frequency score
that is updated only when requested.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> +		struct damon_ctx *ctx)
> +{
> +	unsigned long sample_interval, aggr_interval;
> +	unsigned long window_len, left_window, left_window_bp;
> +
> +	sample_interval =3D ctx->attrs.sample_interval ? : 1;
> +	aggr_interval =3D ctx->attrs.aggr_interval ? : 1;
> +	window_len =3D aggr_interval / sample_interval;
> +	if (time_after_eq(ctx->passed_sample_intervals,
> +				ctx->next_aggregation_sis))
> +		left_window =3D 0;
> +	else
> +		left_window =3D ctx->next_aggregation_sis -
> +			ctx->passed_sample_intervals;
> +	left_window_bp =3D mult_frac(left_window, 10000, window_len);

[Severity: Medium]
Can this cause an integer overflow on 32-bit architectures?

Looking at the mult_frac macro, the remainder is multiplied by the numerato=
r:
r * n_ / d_

If user-configurable parameters result in a large ratio, such as a 10
microsecond sample interval and a 5 second aggregation interval, window_len
becomes 500,000.

If left_window is near that maximum, for example 499,999, the intermediate
multiplication inside the macro would be 499,999 * 10000. This evaluates to
4,999,990,000, which exceeds the 32-bit unsigned long maximum of
4,294,967,295.

Could this wrap around and result in an incorrectly small remainder,
producing an inaccurate left_window_bp percentage? Passing 10000ULL might
enforce 64-bit math to avoid this.

> +
> +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> +			left_window_bp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621155715.8793=
2-1-sj@kernel.org?part=3D1
