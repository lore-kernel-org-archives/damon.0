Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A6C429009
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163468; cv=none; b=BXh41k1b7d33z2PcbB9QXmK6bTc9oFt5urEpTUPHPigVNW92iMig+cUtkHOjhGHZJSZOvUKTJr17Lfb5d4m55VHUugFJ9XUwhx2G2vX6A2cE931pi1gCHT74mROAWmc9WBXX+k0oodWObXy5IRFo72YI7wKDd46ON+uGmcn7Ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163468; c=relaxed/simple;
	bh=sGEbx3jKN9k/+8Qm1UyA3B2JFHMNLSeUihzCp5I/pDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hN7rxoAZi6q4JH2ROUM+gmc7MPVFOzw5cYqCgLErz4wv2o7GwQZBOkDn9bMcW7BVouCVaUnf2uA2sGQZ0/FOAzdpMBRNyth46AhugI1wDUxy+Um+J3CtLuC+2Vfg9vzFL5wkaycjsME3s5vTJUrIWJKJrMK1jWED7Fj3Q2fYlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt6ps8fS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt6ps8fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29C71F00A3D;
	Mon, 27 Jul 2026 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163463;
	bh=eo4qcZsAAjcfvWLctn3jEuf3Hc66jW5clgVn8JST+20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dt6ps8fSi4Svd9CW9ndPtcKkl737+KVIfqguC4NfCRiMJTRBwNTvE0jV2kZTsI8Am
	 BHr3SasD71Uahbg6CRMw1LmCKCI7yohUgcI0D1QTlWSwIagyDC3vbjhhekNih9iFQJ
	 E9YhFMn8t5c3dVzvj0xpwspDOHe3AxKJIS+9AcdX8cHdaCPLHPd9B2sGeDnLgJGAxQ
	 gkI1DUs/SJ41R24VoMArrvCpM0ZBv4gkxZyr99WwxNsGq0DnNPuutvuESuFWB/7jYh
	 G14lC1SEFMARwD9U8o/Yu7IRBieQPMYoGKcVxZWIkIURC0PhR0d1G+LlJ4W38Z3VX4
	 N6b7ZDdi0kzYw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 07/17] mm/damon/core: introduce
 damon_operations->prep_probes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260727143829.86236-8-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
 <20260727143829.86236-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:44:21 +0000
Message-Id: <20260727144422.A29C71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Suboptimal short-circuit order in `kdamond_fn` causes unnecessary l=
ist traversals when `prep_probes` is not implemented.
--

--- Patch [7]: [RFC PATCH v2.1 07/17] mm/damon/core: introduce damon_operat=
ions->prep_probes() ---
commit 6cf31e4df3b58637535e88cd2f6425680fdfa9e6
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_operations->prep_probes()

This commit introduces a new prep_probes callback to the DAMON operations
set to execute damon_prep actions during monitoring preparation time. It
extends the core to check for and execute this callback if provided by the
underlying operation set.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 127d3a7c27280..19ab80f50bc4b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3870,14 +3882,19 @@ static int kdamond_fn(void *data)
>  		unsigned long next_ops_update_sis =3D ctx->next_ops_update_sis;
>  		unsigned long sample_interval =3D ctx->attrs.sample_interval;
>  		bool access_check_disabled =3D damon_has_probe_weights(ctx);
> +		bool do_prep;
>  		unsigned int max_merge_score =3D 0, max_wsum;
>  		bool get_max_wsum;
> =20
>  		if (kdamond_wait_activation(ctx))
>  			break;
> =20
> +		do_prep =3D damon_has_prep(ctx) && ctx->ops.prep_probes;

[Severity: Low]
Could this short-circuit logic be reordered to check ctx->ops.prep_probes
before damon_has_prep(ctx)?

If the underlying operation set does not implement the prep_probes callback,
evaluating damon_has_prep() first will result in unnecessary list traversals
during every sample interval in the kdamond hot loop.

While the probe lists are typically short, evaluating ctx->ops.prep_probes
first would cleanly avoid this overhead when the callback is unused.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727143829.8623=
6-1-sj@kernel.org?part=3D7
