Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B4299A82
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976994; cv=none; b=EsKxjrfmoxxUNqBrk44mhLlmept3SbUm8UnhrIU5VFlpoiAzXbpcrrhePku/Td61RJ4bpv1mrIWq1mjxvALKG+Q+tvk4KsyAbgrzxWSDhR4+63ywHmNdcr4FDnyGek+oN9aGLVc0OZFqTAwah0ZoUe520xKXMT2/qu1PiVdp4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976994; c=relaxed/simple;
	bh=Q4OmOkm8J/RywPjBSPWZKlYnMOUNq+iIquhzTkohDVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQTQols+I34F7pUG+jEmweySdwVA+33RtbUnmJa7iJf2pguttFV20ykdOQpb1U86GZJ5V/DJbm92pqH+B2NAIJcFT6rzB4mx2ps9vnHP8Rp44OWQCuc+bJ881ZoQT2nYgFrHsW5GKajl3PRqW1Ywc413gcNBbbV6G/yt16ocEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MumWDOPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MumWDOPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56031F000E9;
	Sat, 20 Jun 2026 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976993;
	bh=4fGSn/eZ47X4atYG+Fere2MZHZQc/bNALx19/aP06jI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MumWDOPOu4oSwdgByDZIQ6sqnA+2IR4ntbCBxyiBMmTJo8bz/1uyriK8dMaUFS9K7
	 hZ0NJ8Nfqe7EHM3WgWJi10ZgHRG/2hMjGQbcP9XdHe83g14YGxUgAIKhde5LE2wHbf
	 H1jgZlqtuI3+In2egpvq+5l16yC82sufvI9ChTIuNqdx6sQ8sM4wpY55GP9vJDNsL2
	 tnVo1U+NDAdPrYfHrkCfHGBlFLIpTW/maDOrd3sjtlf/gYWN8G+shKXlESx+LplXhP
	 DIdhliYl7ddGl6actHaboUYQcdjuN94r5kBt5uS3I4ZI2Q/XrLYuhzZRYX8J5/KbhO
	 dj6+jnV6VzrRA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 01/13] mm/damon: introduce
 damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620172244.90953-2-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
 <20260620172244.90953-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:36:32 +0000
Message-Id: <20260620173632.E56031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer overflow in `mult_frac` within `damon_nr_accesses_mvsum()`=
 corrupts DAMON moving sum access score on 32-bit architectures.
--

commit 33b6652e4ab7390d9a1e1c6a292edc9a0fec212a
Author: SeongJae Park <sj@kernel.org>

mm/damon: introduce damon_nr_accesses_mvsum()

This commit introduces damon_nr_accesses_mvsum() which returns a pseudo
moving sum of a given region's nr_accesses for the last aggregation interva=
l.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..af95783d3402a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -210,6 +210,63 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
>  	return NULL;
>  }
> =20
> +/*
> + * damon_mvsum() - Returns pseudo moving sum value for a time window.
> + * @current_nr:		The value of the current aggregation window.

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
> +	left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_interval=
s;
> +	left_window_bp =3D mult_frac(left_window, 10000, window_len);

[Severity: High]
Can the intermediate multiplication inside mult_frac() overflow on 32-bit
architectures?

The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Since
left_window is generally less than window_len, the remainder (x % d) evalua=
tes
directly to left_window.

On 32-bit architectures, both left_window and the resulting product are 32-=
bit
unsigned long values. If window_len exceeds 429,496 (for example, a 5ms
sample_interval coupled with a ~36 minute aggr_interval), the intermediate
calculation of left_window * 10000 can exceed ULONG_MAX (4,294,967,295) and
silently wrap around.

This wrap around would cause left_window_bp to calculate as a truncated,
artificially low value, leading to an incorrect access frequency score that
might affect memory reclaim or protection decisions.

> +
> +	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
> +			left_window_bp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620172244.9095=
3-1-sj@kernel.org?part=3D1
