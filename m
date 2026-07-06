Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91687385D77
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348896; cv=none; b=baPOx5kEiky0x6PRd0QameuTLpiMtjOlTL+IJFJhcWAN/GRKtEIFmJ8M+Ea7K2Hcf2iHcxMjvVkKFkgsa7i6V+qEhQ6ZW/frtCLXwb14gHYXZXizKAH4NY0QUTnU5j4WypYzxCkTLXFAp1QPBOUplxT24f3Zq3vHXV2S/iXlHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348896; c=relaxed/simple;
	bh=gutL5w51J0QK0ha/XUG92Gvfx+Gwri7dHD6On3z0QrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=St9YukrfJsNMqtMGEdvx/5fOdhLsOZNopcn6YTInwV+WdNrayIX5zeRsRDYb3A/n8d/UsjAAVlkg91RqWMcEhn25zjlkt46sADhGBuF3xpBVSbC0JJ1351xZvUfBfy6swNt5uO5ySYI64MncWBMKc+s3bGYymTxvdQIDCtwxtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9ObXd8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9ObXd8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1573D1F000E9;
	Mon,  6 Jul 2026 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348895;
	bh=ejltgG+QqPUIpuOm1nqrY+vYlqQNxIExkYZujCfB8zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9ObXd8JCOm9lgEZSa4h0IBCgE/E8dxrOLRbFqRkVQ7XFkxYDUakAaCdpKN1J0+UN
	 AjOkIc/6XJYfWjcu/9IfLURoCLfTbmNmbtFXGwdjLw8xJ5tAyDnqHA3yZWLaAmSAa1
	 q1p1OHFG1jcOf+Y5voHKyAdMi9f+FyowOvuh9iCTzJMM2hDWWQ+7hjVNIdFV7Ld6YS
	 i2GKZSY7oBBhx4it5NVFCNue4RtpEznYhEb9BEicq+Pt2cPt0OV69k1YyrMwCzZO61
	 uZMKklfleHTTIGHVLmbA6beW5Ov9PXpkzdfEF6uBDK03ZZ/JY4NQIt5RvO1dhZ/bf8
	 zMP16zJtSuU9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 05/16] mm/damon/core: implement
 damon_probe_hits_wsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-6-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:41:34 +0000
Message-Id: <20260706144135.1573D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The calculation of the weighted sum in `damon_probe_hits_wsum()` i=
s vulnerable to integer overflow, resulting in a silent wrap-around.
- [Low] Misspelled words in the kernel-doc comment for `damon_probe_hits_ws=
um`.

Pre-existing issues:
- [High] `r->probe_hits[i]` is an 8-bit `unsigned char` but serves as a sam=
ple counter across an aggregation interval, making it highly susceptible to=
 wrap-around.
--

commit 627b12cd883dbd832e93cc6b4f4e3373c791b6d0
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_probe_hits_wsum()

This commit implements damon_probe_hits_wsum() to calculate the weighted
sum of probe hits for a DAMON region. This weighted sum is intended to be
used by users as well as DAMON internal logic like region merging.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index dbd1f86a0832f..42f27849af722 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -390,6 +390,30 @@ static bool damon_is_last_region(struct damon_region=
 *r,
>  	return list_is_last(&r->list, &t->regions_list);
>  }
> =20
> +/**
> + * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
> + * @r:		region to get the weigted sum of.
> + * @last:	if the request is for last-window agggregated probe hits.

[Severity: Low]
This isn't a bug, but there are spelling errors in this kernel-doc block.

"weigted" should be "weighted" and "agggregated" should be "aggregated".

> + * @ctx:	context of &r.
> + *
> + * Return: the weighted sum of probe hits of the region.
> + */
> +unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
> +		struct damon_ctx *ctx)
> +{
> +	struct damon_probe *probe;
> +	unsigned int sum =3D 0;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(probe, ctx) {
> +		if (last)
> +			sum +=3D r->last_probe_hits[i++] * probe->weight;
> +		else
> +			sum +=3D r->probe_hits[i++] * probe->weight;

[Severity: High]
Can the accumulation into sum silently overflow?

If a large probe weight is configured via sysfs (e.g., > 16,843,009), the
multiplication of this 32-bit unsigned int weight by r->probe_hits[i] could
wrap around when accumulated into sum.

This might corrupt the DAMON region merge and split logic that relies on th=
is
score.

[Severity: High]
This is a pre-existing issue, but can r->probe_hits[i] wrap around during l=
ong
aggregation intervals?

The probe_hits array is defined as an 8-bit unsigned char. If the user
configures aggr_interval and sample_interval such that their ratio exceeds =
255
(for example, 1s aggregation and 1ms sample), the counter will silently wrap
around to 0 without any bounds checking.

This could severely degrade the accuracy of DAMON's monitoring, and is
exacerbated here by relying on the potentially corrupted counter for the new
weighted sum logic.

> +	}
> +	return sum;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D5
