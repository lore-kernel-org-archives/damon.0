Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7D357CFB
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745693; cv=none; b=TMBNAPEVDqVPP9ISAIKuoA0o24/tYP4W9D83TcQP6rUL2fOBw8th0xEXKs02Nb+FzOym9TA6x3zlSQYg/DrD6dT3NsI8bkN6xLzQcWimdiz2RJDetENNlJj87020EATovMsIW0fZ7seX8ukmVsQT9uTOZttpT47EM2WMy8KMpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745693; c=relaxed/simple;
	bh=qKACmosgnbRDNfHvTLBFOmo+n/y2QkDGEmy+1r/q2ak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0stVamA8cPRaVS6DIxLCGEYOVqxF6Kh+nxAhHp4/zDmBOe6DV3/AORLHDHCUiBfOM1w2IF+MMGykDCBJbVzsuzrKgacJJS8mUY5FdA6OFdD0OC4+o3uInpgWGhKK+7g9Kkjac+IWHd9bDK7ocV/z5i37Yk/CXuMh8lWtA6gBk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwFpd97M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwFpd97M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065511F000E9;
	Mon, 29 Jun 2026 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745692;
	bh=Q/y9xFlfOwal2mT+Cxq8FNH1/KvTstXQYCwZCXOv/uM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwFpd97MUJWMT67Wm8o1lOkSGYWyv9jS3bSQeb+XRRTbieigbCekZukGh3PHoT7l5
	 jGZip+ImruDx4GVr7878P+IESQbvZP2TuXw/uWO0PdPe2CqHShkN7PbIfy2pKjOW1B
	 UEXR5YDMxsjUDGBChSFIWg+CZ0Wg5RLWCo3uiqEU8gCmGXO8LaLPVsGhymdWtO4gv4
	 2s/+8mizP79YIBgWk4MQ4ueyBIa1zUmRD0+pscj2z16jtxrSAOdSSk+nfuChc2cvka
	 BJfs4dXn4k/nXPEpHC3GJwx4MxqZm58gxn/hLp9atjiGaxPX817wztsrcOo1g/nyI5
	 hVT4xcbT9caUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/core: split a fraction of regions when
 nr_regions exceeds max/2
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260629145630.134891-2-sj@kernel.org>
References: <20260629145630.134891-1-sj@kernel.org>
 <20260629145630.134891-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:08:10 +0000
Message-Id: <20260629150812.065511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Cross-context state corruption and data races due to the use of =
a static local variable `rotation`.
--

commit 696204689b6ff0a9b6ca3153698c49bfe10cff24
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon/core: split a fraction of regions when nr_regions exceeds max/2

This commit modifies the kdamond_split_regions logic to split only a fracti=
on
of regions when the region count exceeds half the maximum, rather than
returning early. It uses a rotating offset to select which regions to split,
refining the count smoothly as it approaches the maximum.

Link: https://lore.kernel.org/20260626085851.70754-2-jiayuan.chen@linux.dev

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 027250e43c66f..9bbc60a2a8c05 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3234,6 +3234,37 @@ static void damon_split_regions_of(struct damon_ct=
x *ctx,
>  	}
>  }
> =20
> +/* Split one in every @split_step regions into two, from a rotating offs=
et */
> +static void damon_split_some_regions(struct damon_ctx *ctx,
> +				     unsigned long split_step)
> +{
> +	static unsigned long rotation;
> +	struct damon_target *t;
> +	struct damon_region *r, *next;
> +	unsigned long offset =3D rotation++ % split_step;

[Severity: Medium]
Will this shared static variable cause data races and logic flaws if
multiple DAMON contexts are active?

Since rotation is declared statically, multiple kdamond threads could
concurrently increment it without synchronization. This might lead to
data races and cause different contexts to overwrite each other's
rotation offsets, breaking the isolation of the splitting algorithm and
resulting in uneven or skipped splits in some contexts.

Should this state be kept per-context instead of using a static local
variable?
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629145630.1348=
91-1-sj@kernel.org?part=3D1
