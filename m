Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6473597B
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644157; cv=none; b=cOEj2Q/C20twD5Gnk2R9SJAFiakzt89LHgDpKtF1wrRELPzub/zF5JS59CJgty8PJcf6vIAmywJCcNmVVV8wJl9jgc3kA3WBowRtjS8xuv/L0aNabIebdBg/W4hZNyL+HuNTbm7Yu4NSbAh/V4UJWcbfnOGW/Q0LNQQk3lmpzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644157; c=relaxed/simple;
	bh=QFkdMFdpSeySIxN6DIS2cAPCY9cNktTdZh/WpsU8j00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dztwk/vEAm4xE9mGAPlZlz4Tll9DvXF4AtxpF0NL8UanbJUdw76V50SIqbaCSpqGRKedQadfvxXztTvcMEpDL5sBsaHKFSQD8usRglRtHBalF5bWCOJ7E1BfDpwR19DJ1VskIkpaqqwtkZPV+RtHJ6sFikFA48FUdf5tc7FjzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkwHbDda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkwHbDda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DC1F000E9;
	Fri, 10 Jul 2026 00:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644156;
	bh=oRpDw7/9dxh1WdnFEfBkq6kygfaeiVtqY89z9KUek+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkwHbDdaCGiiwqNlQh4QM+DtDwZXQxZTUr4Yecjp6cWz6nZER337/g49PxEHuiyPc
	 N9N8b8I8z4siAcSSfXchMXViMLxlWerYFZPRDxrmtzLLAKPWoa9QCyX1zRotnBxZAR
	 4IwbuIu3y+UGcqyUhMpoyoY6ae3S6HuKVV5Cpc/1ORYZ/XkyEvSxJxTG2S7omV20FE
	 eadpLc0f2jLIvgoodFoP5b3a4Jrhg4lGtzef6vmrHEPqkG2iixnjfBbuODMse1+g2k
	 3X5tIVCz+0Jssm3Yuwkd6yrhjom++70XP2dV3oDVmMhbqxVKUWt3z2QX09XGuOaQSs
	 vNOCde2yj+Jow==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 09/19] mm/damon/core: disallow probe_hits
 overflow on attrs only monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710002349.111414-10-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
 <20260710002349.111414-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:42:35 +0000
Message-Id: <20260710004235.D59DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing validation in `damon_valid_probe_params()` fails to prev=
ent a 32-bit integer overflow of the weighted sum of probe hits.
--

--- Patch [9]: [RFC PATCH v1.3 09/19] mm/damon/core: disallow probe_hits ov=
erflow on attrs only monitoring ---
commit c184df8a3c8632af7a06675128fa4e375050fa8c
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: disallow probe_hits overflow on attrs only monitori=
ng

This commit adds validation logic to prevent an 8-bit overflow of
probe_hits when the aggregation interval is much larger than the
sampling interval. It checks the parameters in a new function,
damon_valid_probe_params().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7d49420ea26c4..4f1425e56950b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1332,6 +1332,19 @@ static void damos_set_filters_default_reject(struc=
t damos *s)
>  		damos_filters_default_reject(&s->ops_filters);
>  }
> =20
> +static bool damon_valid_probe_params(struct damon_ctx *ctx)
> +{
> +	unsigned long sample_interval;
> +
> +	if (!damon_has_probe_weights(ctx))
> +		return true;
> +
> +	sample_interval =3D ctx->attrs.sample_interval ? : 1;
> +	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
> +		return false;
> +	return true;
> +}

[Severity: Medium]
Since we are adding validation for the 8-bit probe_hits overflow here,
should we also validate that the 32-bit weighted sum of probe hits doesn't
overflow?

If a DAMON context is configured with probes where probe->weight is large
enough, probe->weight * max_probe_hits (up to 255) could exceed UINT_MAX, or
their cumulative sum could overflow. This would result in an incorrect score
being returned by damon_probe_hits_wsum(), causing improper region merges in
damon_merge_regions_of() and degrading monitoring accuracy.

While damon_has_probe_weights() currently returns false making this path
unreachable, would it be safer to add the weighted sum overflow check now to
prevent issues when probe weights are fully implemented?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710002349.1114=
14-1-sj@kernel.org?part=3D9
