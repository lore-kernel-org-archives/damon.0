Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933435A395
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898270; cv=none; b=nRZtQjluuEIGeuV8SnDJCIuYNKWbZ35KpdsqSvDD/sbs+5Sh7BBP96nfYyVOS5IwiMSG7S7TePkKBJiXLCj3CbVVd8jjLo7Q87gErf9VANVoVqh6+lwAB5L7h2+6Zaja/cUDpF2GNK7myfZzoe5tGW7P3uTvP1Jj4LwqiBOHXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898270; c=relaxed/simple;
	bh=jXQCnQqi2xqfYCXwSGpWBzG44V/vejLg6Y99bu6xvlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6qj502VNB0KSQ2TxthpSc/KaXqJD9Se+t2Jx9mhLH6HBU5PaEG+QAmtSASmN8H0rgaAMtJcFl+6x1F5lTh7S670reMBsXLW9OESRkOvG1m8xFXPdrQpMW8M41ijre4jqgH3vgNmqpVZYSX765otxfJ7c/uuVapDeyPqFJcNerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJVRpwwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJVRpwwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3BA1F000E9;
	Fri, 19 Jun 2026 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898268;
	bh=1Xi0F0uUIJ6cIreQEr8C8rSGlZgJ84IrSKaEzuovCqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJVRpwwA8JVtc/dbg4YkwInaURqJ6EaoORZmd8iYVknogBd4Jzp6PuxOMMuuh1KKv
	 FMKknZcqTRxsls77c8ds51DXjEmyRljeGdpW2Uj6heWFsCA/rrwPoTLPNHG248r6rS
	 slODbRArTgD5rJ6ovF0NoVWdzN+FK+2FosSkdHZP+FprKk9lif/Csswz3MBmlr9Jmm
	 EfbS+UOFfifHrDtvDJKVksvcmdC8QSyjtPcNU4fE4PAJZSzLZ/U8uSA6B23QGWiqR6
	 gXfXe6lwvCFQDwW4mwR3t0DCboumwHAsURqpZmvOIKODskipJ+ByqV1xrIXged5Irx
	 TxZNjNoqaKSwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/13] mm/damon: introduce damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-2-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:44:28 +0000
Message-Id: <20260619194428.7A3BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Kernel panic due to division by zero in `damon_nr_accesses_mvsum()=
` when `aggr_interval` is configured to 0.
- [Medium] Integer overflow in `mult_frac()` leading to severely incorrect =
access scoring on 32-bit systems when `window_len` is large.
--

commit 0c6de91631a66fe41c1e81f68011cf31d86b4825
Author: SeongJae Park <sj@kernel.org>

mm/damon: introduce damon_nr_accesses_mvsum()

This commit introduces damon_nr_accesses_mvsum() to calculate a pseudo
moving sum of a given region's nr_accesses for the last aggregation
interval. The function is designed to be executed on-demand rather than
at every sampling interval.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> +		struct damon_ctx *ctx)
> +{
> +	unsigned long sample_interval, window_len, left_window, left_window_bp;
> +
> +	sample_interval =3D ctx->attrs.sample_interval ? : 1;
> +	window_len =3D ctx->attrs.aggr_interval / sample_interval;
> +	left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_interval=
s;
> +	left_window_bp =3D mult_frac(left_window, 10000, window_len);

[Severity: High]
What happens here if aggr_interval is configured to 0?

If userspace configures both aggr_interval and sample_interval to 0
via sysfs, sample_interval evaluates to 1 through the fallback, but
window_len becomes 0.

When window_len is passed as the denominator to mult_frac(), does this
result in a divide-by-zero kernel panic?

[Severity: Medium]
Is there a risk of an integer overflow here on 32-bit systems?

The mult_frac(x, n, d) macro evaluates the fractional part using the type
of x, which is an unsigned long here. On 32-bit architectures, this has
a maximum value of ~4.29 billion.

If a 5-second aggregation interval and 1-microsecond sample interval are
configured, window_len and left_window could reach 5,000,000.

The intermediate multiplication in mult_frac():
(left_window % window_len) * 10000

could evaluate to around 50,000,000,000, which overflows a 32-bit
unsigned long. Could this lead to inaccurate access frequency calculations?

> +
> +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> +			left_window_bp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D1
