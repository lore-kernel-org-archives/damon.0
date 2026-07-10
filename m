Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14E2D738A
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692662; cv=none; b=Nmu0BviwmRF4hePsipYYj6vD/ilbSZ1Ml881UP52cVnJmfo4r6Mt87/WvDvL6EulRwZ1tBY42uT6r+ykoGVJ/dQ4Cacajy3yrojiwXOuRUIp7iomiTwUu2Zrsd67Q+Uf9VTU2rn9/W+jexv6NSLI0uTBDiT9AMtDAOTDR8AMggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692662; c=relaxed/simple;
	bh=WfWE9E11M53PeSpMtjISaaV16TpN68RG90Ry4CPKGv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tb4VXSNrQc9VUb/oAPJDBIG5Imo8gb9/9LbJqILjm5s/LFDIRswnw42BaNSgqDGQpV8ne0DpJasmIT9UVegEaspmfm0sSA6ZqFz06oIy3TSppatrQyIb123dxBUDfJ8hXDULpimHhEeZdreL7yA1VSJiTieqg5JBkER6HdZoVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmrDo2ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmrDo2ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADA91F000E9;
	Fri, 10 Jul 2026 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692660;
	bh=uLKa7UEecLAUt1XYO531YS4kSpdpW7JF1yzeiHakkSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmrDo2ND9OTIQsiM+h5TXDwQp49Hr7OGRxRarGtDW/3gT53hG+imeqJ7kL5mNTj1T
	 KPL4kgjdNTcEkMNGRkq8/erFORua7qLXx7qjkIyA3sCHQSKYnnfOXjE5K23ZtPy4IC
	 Zj8xExs8GLni02VBrQt6PRp7SIU+70SHN6BGpDAPnjck3/5Ep2asLEJHAAyZ7J5C9d
	 yhPhYmUOi8aKAZ8qCpPGoMov4B5to1aWXfeqazf0K7NYR4oWrCi459wtCtKHVsZShj
	 pJ5IaalpUfBp5tRAI09bjjsxnMj/Mr5iGkme03aFMCJd+andhPkF+gHnIYFqQx5K/n
	 XvAeauOtHvTWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/19] mm/damon/core: implement damon_has_probe_weight()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-16-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:11:00 +0000
Message-Id: <20260710141100.AADA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting probe weights unconditionally disables access checks witho=
ut validating if the active operation set supports data attribute probes (`=
apply_probes`), silently breaking monitoring.
--

--- Patch [15]: [PATCH 15/19] mm/damon/core: implement damon_has_probe_weig=
ht() ---
commit 7b3dfd9b2d27b35cdf18598b48bc4927675cb47a
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_has_probe_weight()

This commit updates damon_has_probe_weights() to properly iterate over the
probes and return true if any probe has a weight configured. This enables t=
he
data attribute monitoring mode that previously returned false intentionally
during incremental development.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 91964336ce31e..806a67d02a6e9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
> =20
>  static bool damon_has_probe_weights(struct damon_ctx *c)
>  {
> +	struct damon_probe *p;
> +
> +	damon_for_each_probe(p, c) {
> +		if (p->weight)
> +			return true;
> +	}

[Severity: High]
If a user configures a DAMON context with an operation set that does not
implement apply_probes (e.g. vaddr operations) and adds a probe with a
non-zero weight, will this silently break monitoring?

With this change, damon_has_probe_weights() returning true will skip
standard access monitoring in kdamond_fn():

mm/damon/core.c:kdamond_fn() {
...
	bool access_check_disabled =3D damon_has_probe_weights(ctx);
	unsigned int max_merge_score =3D 0;
...
	if (!access_check_disabled && ctx->ops.check_accesses)
		max_merge_score =3D ctx->ops.check_accesses(ctx);

	if (ctx->ops.apply_probes) {
		/* bypassed if apply_probes is not implemented */
		...
	}
...
	/* max_merge_score remains 0 */
	if (time_after_eq(ctx->passed_sample_intervals,
				next_aggregation_sis)) {
		kdamond_merge_regions(ctx, max_merge_score / 10, sz_limit);
...
}

Should damon_valid_probe_params() or damon_has_probe_weights() also verify
that ctx->ops.apply_probes is implemented before allowing this mode, to
prevent kdamond_merge_regions() from unconditionally merging regions with
a threshold of 0?

>  	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D15
