Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6536728B
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608543; cv=none; b=jb5oPx5EE/RFdzmrirmDhbRmyQQ0H85i4NFc5yVrT94N2rEodGxjhcvGOntV7HUBwCYRkmuOBjGNviHnSrTSArBQHba9+De6IEj/qDNwmz1nAna6nx2QhrtHNNnwMl7v6vi42PZzGupq76UZUVRSQIe+FH+z5lmDGQF+rlYWIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608543; c=relaxed/simple;
	bh=7eONmCpE7lFkjkoyp306Nu7CNx3GLGOPjnxM/xNo0D4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hs+yhnTDOsb84fQ+/yhTXvhi766XtTmrJPLUszPjhjX/lRwEMTlYah7hfxbIAd6MYewrTFeAjUkWmawktFZvXC5eyGsFOvjBTznI6vJNQ/Bc6FctOWVoLeAyxYTVObyDUnPW8HuLBfKTrwATzJJRFJ3yP5SpSTMCuWLd1i/VsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Sh7m4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Sh7m4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D8C1F000E9;
	Thu,  9 Jul 2026 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608541;
	bh=+AN3cqKbjruJQS+5elg6JndY98pBFILfniergtKwFkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9Sh7m4eoeSz05A5H2OzyskITGttazowMR6HG65LYoQKUhAtHg/9iEV4FNMVG1ztG
	 wAAD7oV2WG3Tb+63Imxv15aCQJtrTvvri7V+5nMW+gEwjdR6s9qQ3suh51mg0GXedJ
	 RAdzpJWQtxcqIPStvdGJ4C6ac7ejjFoUPeYlBsJHbkB9+amVXZhsauFuR4AFFHwAQY
	 CRBbGlYK3jV4FE3DideO16WCZpDH5FP9P3k1Xy99cp5aIDjt8gLzrqunvqS/mbTwAD
	 peLMDHPJp48VxgQB2mNqjbPhaqjLejlYE7WuK1OcA6/pcdnSWOuzaF8sQNRgCmhDmA
	 mynj5PIrnXMCQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 14/19] mm/damon/core: get merge threshold from
 probe hits when weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-15-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:49:01 +0000
Message-Id: <20260709144901.96D8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing validation for `apply_probes` callback when probe weights =
are configured leads to complete DAMON region collapse.
--

--- Patch [14]: [RFC PATCH v1.2 14/19] mm/damon/core: get merge threshold f=
rom probe hits when weights are set ---
commit a4d0e22d5d4d741ec6086d8f49fefbab2c3b57bd
Author: SJ Park <sj@kernel.org>

mm/damon/core: get merge threshold from probe hits when weights are set

When probe weights are set, DAMON merges regions based on their probe
hits weighted sum.  But the merge threshold is calculated based on the
access frequency.  Update it to retrieve the maximum probe hits weighted
sum in the snapshot from apply_probes() ops callback, and generate the
threshold based on it.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8837b2129baa6..12c66edecd783 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_merge_score =3D ctx->ops.check_accesses(ctx);
> -		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, access_check_disabled,
> -					false);
> +		if (ctx->ops.apply_probes) {
> +			if (time_after_eq(ctx->passed_sample_intervals,
> +						next_aggregation_sis) &&
> +					access_check_disabled)
> +				get_max_wsum =3D true;
> +			else
> +				get_max_wsum =3D false;
> +			max_wsum =3D ctx->ops.apply_probes(ctx,
> +					access_check_disabled, get_max_wsum);
> +			if (get_max_wsum)
> +				max_merge_score =3D max_wsum;
> +		}

[Severity: High]
If a configuration has probe weights enabled (so access_check_disabled is
true) but the active operations do not implement the apply_probes callback
(like vaddr or fvaddr), does max_merge_score remain 0 here?

It appears that skipping both check_accesses() and apply_probes() leaves
max_merge_score at 0. Later, when kdamond_merge_regions() is called with a
threshold of 0, and all regions have 0 probe hits, damon_merge_regions_of()
would see a difference of 0 between adjacent regions.

Could this lead to aggressive merging of all regions up to sz_limit,
effectively collapsing the fine-grained region layout?

Should there be a validation check in damon_valid_probe_params() to reject
configurations where probe weights are set but ctx->ops.apply_probes is
missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D14
