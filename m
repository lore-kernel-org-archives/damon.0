Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CF2C9D
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285909; cv=none; b=qS4uyz6u63wm8IA3esX/w3Cx5PQ5tr0kOV4PQCv5C+74Ee+EzYDjGhXEgM6bcKu51g3YlXNm6CZi53y0pXtytLepmw9YzOcCKpGHjl+v5pIcJXDex/yjRzfYGwMskcTmvjo06TrfPdkB38E/tai8tnk0VWHQlPfBFOmi35ZD/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285909; c=relaxed/simple;
	bh=Fr9s2KYPl2q0Um+WJyCxZWJF+plZN/QQ9+tUsK3CyZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CjAGYzZPn7DiS+SlLuVaqPl4iFy4C5Qu9c5LTIcyssMF8IJOVrkPqnncandwMDVsCaeSjxOgSCtaVRlRpKZ7TEVZJVdLN1Z0LwAJ08VskhyuAuArNiYA1rLO4AXa0q9FB8Xbt5MZmRNP74dAXRCjX6A2AwySO8YNF35OpdS2+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz02AwAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz02AwAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE11F000E9;
	Sun,  5 Jul 2026 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285908;
	bh=EdOD05kvQG3dFbMWW9MkEE8SbiyCADpJvlS5ljsVTR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cz02AwAyzuvZPlRlzJxrffAbl457+RfLlQO8CC7nm8OMb9F6JT1CkqOmnqU0lyg+L
	 lBwT/TBdFDPd+A4BMnb9j74HtP+k/1lUZN1Ivdmns8OEfnoHGkMLj29UdFRTm8O6g9
	 rPNOlYMp6ELJdawE/n65TCeO/omCJ7rWRsiS9R33dWC1vHN9EJ1S5/woHAyvTXggHi
	 ayfKooXSesscBS8dIUzCesG8scdn/cso7MZKvf/9YAcSaUd2M4+EEtsppufF1se2xi
	 r0Q5Li/dEcwtOTkoOydXZIAL9TZK17BXNgFNmKVikdl2+RPisJvUzVY0Xl3XOQEL5L
	 FeU70Oy81qvtg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/16] mm/damon/paddr: set samples in apply_probes()
 if requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-4-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:11:47 +0000
Message-Id: <20260705211147.EFEE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `probe_hits` counter in `struct damon_region` is an 8-bit inte=
ger (`unsigned char`), which overflows if the ratio of aggregation interval=
 to sampling interval exceeds 255. When this wrapped value is used by `damo=
n_merge_score()` (introduced in this series via `damon_probe_hits_wsum()`),=
 DAMON incorrectly merges regions, breaking its core tracking logic.
--

commit 26a2b31429c08214403a84c01f1b8d381e461d92
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: set samples in apply_probes() if requested

The apply_probe() callback implementation in DAMON_PADDR ignores the
set_samples parameter. This commit updates it to respect the parameter by
setting the sampling address if requested.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index b13bf7c6eade3..ff4fcca949660 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -178,6 +178,10 @@ static void damon_pa_apply_probes(struct damon_ctx *=
ctx, bool set_samples)
>  			phys_addr_t pa;
>  			struct folio *folio;
> =20
> +			if (set_samples)
> +				r->sampling_addr =3D damon_rand(ctx, r->ar.start,
> +						r->ar.end);
> +
>  			pa =3D damon_pa_phys_addr(r->sampling_addr,
>  					ctx->addr_unit);
>  			folio =3D damon_get_folio(PHYS_PFN(pa));

[Severity: High]
This is a pre-existing issue, but does this code overflow probe_hits[]?

Looking at include/linux/damon.h, probe_hits is defined as an 8-bit integer:

struct damon_region {
    ...
    unsigned char probe_hits[DAMON_MAX_PROBES];

Shortly after the sampling address is set in damon_pa_apply_probes(), this
counter is incremented:

    damon_for_each_probe(p, ctx) {
        if (damon_pa_filter_pass(pa, folio, p))
            r->probe_hits[i]++;

If a user configures DAMON such that the ratio of aggregation interval to
sampling interval exceeds 255, this counter will overflow and wrap around to
zero.

Since this patch series modifies damon_merge_score() in mm/damon/core.c to
rely on this counter:

    if (use_probe_hits)
        return damon_probe_hits_wsum(r, last, ctx);

Could this overflow cause highly-accessed regions to be treated as having f=
ew
matches, leading to incorrect region merging and breaking DAMON's core trac=
king
logic for filters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D3
