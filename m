Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CBB3BB672
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464957; cv=none; b=K7z6riQ6y9cLoXc5TRzvcHOyZKxdPKC9sKMFNfmBcX1oYla4ksv1IE6+y5fPWUs6kvj3XYl3pk8nEXXVE6JNk1NujiEi3fIZMh2dm/to0aI7Jb973jSBuLviCI5UuHBok2p4AcCnT1zJkLYdEsUTGbxvSF/D5LgbIE68Zzsi/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464957; c=relaxed/simple;
	bh=S2PnCNL9vQgmi3o6qpzayML45uo99Sjkjf9pPTQxjWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F3zUqB7FmvPjvrDgoDnqV9dSKWhee2OBr0kM5oUVr9WOg70locj7ww+tToSz+/RXEwZNxTQBmlbHMQtXaJzhkrlPjhBaTXE5IkdW3FCaXwomi6VLCnmx4psKCRRs1fPxJOFOsLIU/kW6yEzmnQEjph54zFcnvz4WDxSxLC6xVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOen4+DM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOen4+DM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D161F000E9;
	Fri, 26 Jun 2026 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782464955;
	bh=nvcTtyTJIMY4MHK/T0tmh+Q/ugW2ljdGpWoYd1S9gWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOen4+DMVZ0Yh1RRyus41acmTmCUjoidK1s8eWV1qgOmgAQFO1PQvJirrVian1QBV
	 PZjr+HQDhq4fzgf820/pcJzovc34fB2HvG6UJnW5ahKO0KyQ27djAgePOroPtWmtuS
	 O/G2bm4staJGJPdCuHgnyrlQAvqldmikuv/7jvqnoTdIxmUC0AcDxeorjadFa9h0cx
	 LIN7+PBLczZDi9CMZalv6Bwa3DPaShg5uFnxsfxl1FWKlZuA07evseOUcuLsSn4518
	 gDyWRXIO93fFay9b1gkXNuW1mtfmQMy392VrZMDWic59HN0cccswm1LLxaQywtaQsl
	 Ducxc1HGt16ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: split a fraction of regions when
 nr_regions exceeds max/2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260626085851.70754-2-jiayuan.chen@linux.dev>
References: <20260626085851.70754-1-jiayuan.chen@linux.dev>
 <20260626085851.70754-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:09:15 +0000
Message-Id: <20260626090915.73D161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race on the globally shared static variable `rotation` caus=
es undefined behavior and inter-context interference.
--

commit 2895b546218b4ccc570b82e50e62f788bac4157b
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon/core: split a fraction of regions when nr_regions exceeds max/2

This commit modifies kdamond_split_regions() to split only a fraction of
regions rather than returning early when nr_regions is above max_nr_regions=
 / 2.
It uses a rotating offset to ensure different regions are picked for splitt=
ing
over time as the region count smoothly approaches max_nr_regions.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

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
Will this cause a data race if multiple DAMON contexts are running concurre=
ntly?

Since rotation is declared static and locklessly incremented, independent
kdamond worker threads could read and mutate it simultaneously.

This unsynchronized read-modify-write on shared state might trigger automat=
ed
data race reports. Additionally, does this mean different contexts will step
on each other's rotation offsets, breaking the intended round-robin behavior
for each individual context?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626085851.7075=
4-1-jiayuan.chen@linux.dev?part=3D1
