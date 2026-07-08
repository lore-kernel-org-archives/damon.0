Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7142F49FD
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519689; cv=none; b=bniZQhqfJChfIcrsIBNax5yK2w3QRXm2Tg45R3Aj/hwDtoe2PQcpEXnv3jETHToRjhelbAu3l01OocRu56pbc/p3lAB687vu4sBkWOLAqwQVdDfIwZwXhs+MWo0p7lPtLH8HMDhtf8pRBbuOonHF5dUdRF6NdMPKke0kAlJcGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519689; c=relaxed/simple;
	bh=YtsebpvInPtXNSzJhzmHnBGltSRfniaL9hDXw0vi3ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jdde4PYMp8cbnEmmO5B9Uj4bll2pUft24AEqLn/oLOyNEFF1zLhcbjavq3de0pfcqZJbKB9kGirWu47kpMs3Rywbf1H+Q/KEmkurjli/ZXDezjKd203TGi+a/RcqgdUGLJ7kCCEkdue16Imfzp9Rbkeg9TztV1/eOUL1Ov7QFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMNNoxfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMNNoxfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21141F000E9;
	Wed,  8 Jul 2026 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519688;
	bh=a4gD6c6bX5EDnRmx9EGcznFczFnKasExTfeep5m8x2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMNNoxfEWdT1mqwPceYO+yUzUaYqRojNyVkGM2sMbl205sSeubFYemm/3bnVIUbpn
	 DLcoDyC9GjB7R+dDf1QB3ERd/YYXOTxXUNLkiSht8IVtDj6zibEY8CITTODA7twHEr
	 UtbNl+4iY7O/ySCTpzft8HglTwd2yWQ4B1R3JZ2BO+sHQqoqah1yoqbVGYHtBTE/9B
	 xNqlZvmZDg1HZu6peUk9Sz0IC5hcse1NZok9a6PAev8s+LbF8FrwbXhLlCWXgulaPn
	 1Ti/IKUio4piAAW1N/nuFddPrcqRonrg2kb434JbcfM6OdNTXLtmlQQCe4t2Q5ZQAU
	 9VySXu0bWkKfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] mm/damon/core: update probe hits for new parameter
 commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708135359.122587-7-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
 <20260708135359.122587-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:08:07 +0000
Message-Id: <20260708140807.F21141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Scaling of `probe_hits` during parameter update produces mathemati=
cally incorrect results and silent integer truncation due to `unsigned char=
` type constraints.
--

--- Patch [6]: [PATCH 6/7] mm/damon/core: update probe hits for new paramet=
er commit ---
commit 6ec1cede99a50d44fcfc3e2fc6a1b5334600120f
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: update probe hits for new parameter commit

Users can dynamically update subsystem parameters at runtime. This patch ad=
ds
logic to appropriately scale probe_hits and last_probe_hits based on the
updated aggregation and sample intervals to maintain accurate monitoring
snapshots.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 800ff6b6d2473..15d31285515d6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
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

[Severity: High]
Does this code silently truncate the scaled results?

damon_nr_samples_for_new_attrs() returns an unsigned int, but both
last_probe_hits[] and probe_hits[] in struct damon_region are unsigned char
arrays. If the user updates the parameters such that the new ratio of
aggr_interval to sample_interval scales the sample count above 255, the
assignment to unsigned char will silently wrap.

For example, if a hit count is scaled up to 300, the stored value would
become 44. Could this produce mathematically invalid scaling and corrupt the
relative hit proportions that the monitoring results rely on?

> +		else
> +			r->probe_hits[i] =3D 0;
> +		i++;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708135359.1225=
87-1-sj@kernel.org?part=3D6
