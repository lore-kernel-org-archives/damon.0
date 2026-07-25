Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504518A93F
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014132; cv=none; b=B2PA2i2vaJjgt+GFtF7VweDOoaIvrKmYAt+pCpoKmIGcHllOtos/4dSdNAiGzeDuDKuAqI30YSc4MIK8/XDkDMWgYP4z/dHuqxQu4xUQT8jv0ZY88aHh8vtpcJu0A352R2A7lny/oqHl1s7sGsQNaqgwTzeLy8ICH7ySvAQfw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014132; c=relaxed/simple;
	bh=Nb+XCJgwloBZDTLQwmzyDGjZGWoW1Fj0YLpiQO+g2uk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjENXIWnNdXIpoOLYtbEt0uW4Afhu3CDFYdt0HJ5K+OJ7KRB+hya7m/ZQqyO6tgDUc1jVGpSOnxPpucx6T3nBvvClSbP86Dk5XYV8xPwlEkRopMPXUuamDCtmyoCJmjgAW+my6IjgOPhBfMecI/EHFYhnTgmzJ3OydCvjyvKdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnzIPeFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnzIPeFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8164A1F000E9;
	Sat, 25 Jul 2026 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014130;
	bh=f2xqTDtd2bcj+/84FiCZ/dk593AOFIIsQlbBkqYrKuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnzIPeFtsekD54cIt/v6ikdXxboRPIPv1lScgcIVkGbttLV6Vl2g0XS4N9FBg24+r
	 W05x2yArzVkw7minSJ2fpGKEnoa36RthzM4qrtb/uemn25vOzcWblxCtc8SFEw12sp
	 ssChTNflRqFIT5GB2b7IhfKqEcevmIFe8BmoN0ZyA/49m1KmrGSEPGRffTx0+i/ZHN
	 uW4R/5D6JlTThzHZsmCBB6A4mvIhQdx4Naw0jot2njXCwf3ARm7KddJ4kj2vdQ1bIA
	 98bCeYhWVsCnhs0yCcYQdbcuUa9U/JylYfOBnSbG2fzd9UE/HiEC1CJ6kKW6KMC/1G
	 nmCEQzhbKEf8g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/17] mm/damon/paddr: support damon_prep
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-9-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:15:30 +0000
Message-Id: <20260725211530.8164A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double randomization of `r->sampling_addr` silently overwrites the=
 prepared address when access checks are enabled, leading to an orphaned pr=
epared page and evaluation of an unprepared page.
- [Medium] Redundant application of `DAMON_PREP_SET_PGIDLE` causes duplicat=
e expensive rmap walks for the same folio when multiple probes exist.
--

--- Patch [8]: [RFC PATCH 08/17] mm/damon/paddr: support damon_prep ---
commit 4bd5ea4d30cf668863712fb6c9fd487551e2b59c
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support damon_prep

This commit implements the prep_probes() callback for physical address=20
operations. It supports the DAMON_PREP_SET_PGIDLE action by unsetting page=
=20
table accessed bits and setting the PG_Idle flag.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 199de1463fa06..8d8fcd1369e56 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c

[ ... ]

> +static void damon_pa_prep_probes_region(struct damon_region *r,
> +		struct damon_probe *probe, struct damon_ctx *ctx)
> +{
> +	struct damon_prep *p;
> +
> +	damon_for_each_prep(p, probe) {
> +		switch (p->action) {
> +		case DAMON_PREP_SET_PGIDLE:
> +			damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr,
> +						ctx->addr_unit));
> +			break;

[Severity: Medium]
Will this result in redundant expensive rmap walks if multiple probes share
the same prep action?

When iterating over all probes in damon_pa_prep_probes(), this is called for
each probe. If a user configures multiple probes with the pgidle_unset
filter in a single context, it looks like damon_pa_mkold() will be invoked
multiple times for the same sampling_addr, causing duplicate folio rmap
traversals.

> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	struct damon_probe *p;
> +
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region(r, t) {
> +			if (set_samples)
> +				r->sampling_addr =3D damon_rand(ctx, r->ar.start,
> +						r->ar.end);

[Severity: High]
Does this conditionally overwrite the sampling address that was already set
and prepared?

In mm/damon/core.c:kdamond_fn(), prepare_access_checks() and prep_probes()
can both be called in sequence:

    if (!access_check_disabled && ctx->ops.prepare_access_checks)
        ctx->ops.prepare_access_checks(ctx);
    if (ctx->ops.prep_probes)
        ctx->ops.prep_probes(ctx, has_prep);

If a user configures a probe with weight=3D0 and a prep action,
access_check_disabled is false and has_prep is true. Since has_prep is
passed as set_samples, damon_pa_prep_probes() will overwrite the
r->sampling_addr that was just prepared by prepare_access_checks(). This
would leave the originally prepared page orphaned and cause an unprepared
page to be evaluated.

> +			damon_for_each_probe(p, ctx)
> +				damon_pa_prep_probes_region(r, p, ctx);
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D8
