Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194C1C5F1B
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729475; cv=none; b=Hr8ByeAnVBrClZH1J70xnPoGOaS1h7OD+VHHpkz/eWBHHsaU5ocOlI9VvXnwb7XtlDouyqjyFxCMW9ahKMg6+wVRRgvon9Eso1PJnalcu2G2W0mxamj83a/NCLO943WJkOxV2TiaHfzmlSY9U0TglxyqnrA8tIBS0nFzzRZl5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729475; c=relaxed/simple;
	bh=Q7vINoIc5K+WYXh0rAWrqSNoAo2LuiHmeVSNZY59u6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqA+GgckMXRhj9b2jeNQ5SRXEkKiT3rRLiuoe4UkLn1q+AQ0Pb9t9ieZ2LwV3TUh+6VMtVO3lvlXAprhnmV8rOG3ZsoG6hZFVlITDGmpPIGVVqXNR7l9VVEvO14U5FkuiZbO50GyyFTlN9Bf355jK7yfZjr3xvSJUJIzSuNF7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q50viW2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q50viW2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8911F00A3A;
	Sun,  6 Sep 2026 21:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729474;
	bh=Tf4nTIycDkdJv4fGiz+WQLgYB7nCT467EkNze5++aKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q50viW2mtPL5u+bGcwtUrgL9bSQCf6wfNGd+Ff3Cm4bEEkFYsh2Ked3tSee72oL4M
	 ALSi4iPxaHhIy3WsKX5BoCRKmmx1kYxcnp5v41BHoc+KcowDwvL4bb+WiILUazUqS6
	 4v4Rjvk+fHu6jeQUyhxzQNuQONsAprdHtU/olLQpL68GLXunM3ERL1bAe7TgAg44MA
	 xAAH90GgSaO49Heb6NBe3ZxUuOhWKAVlkkpxHpm2p2XwVyMm2Qb3JqXqqdO2AOSzFD
	 BP/KmnmOEawVVjb33Z/HHhm6r2nuRk6XeEqfmBjGU6G4S1bVf6WwPlSEQ3Z12G/L/9
	 rljP6DYx/KDJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] mm/damon/core: support probe_hits_wsum damos
 core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906210513.106895-3-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
 <20260906210513.106895-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 21:17:53 +0000
Message-Id: <20260906211753.CD8911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] DAMOS_FILTER_TYPE_PROBE_HITS_WSUM uses raw, unscaled probe hits =
instead of a moving sum, leading to inaccurate filter evaluation when apply=
_interval is smaller than aggr_interval.
--

commit 75c1f2781e8de8f015329fce3e8a8d40e521f7de
Author: SJ Park <sj@kernel.org>

mm/damon/core: support probe_hits_wsum damos core filter

This commit implements the probe_hits_wsum DAMOS core filter support. It
updates damos_filter_for_ops, handles the range parameters during filter
commits, and calculates the weighted sum of probe hits for filter matching.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106ed..ec1a1666aa9cc 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2538,6 +2543,11 @@ static bool damos_filter_match(struct damon_ctx *c=
tx, struct damon_target *t,
>  		damon_split_region_at(t, r, end - r->ar.start);
>  		matched =3D true;
>  		break;
> +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> +		wsum =3D damon_probe_hits_wsum(r, false, ctx);
> +		matched =3D filter->range_min <=3D wsum &&
> +			wsum <=3D filter->range_max;

[Severity: Medium]
When a scheme's apply_interval_us is smaller than its aggr_interval_us, does
this evaluate incomplete probe hits?

Because the probe_hits array accumulates from zero over the aggregation
interval, evaluating the raw probe hits mid-interval yields artificially low
values. This differs from access pattern evaluations, which scale the count
based on the elapsed fraction of the aggregation interval (for example, usi=
ng
damon_nr_accesses_mvsum()).

Could this cause regions to incorrectly fail or falsely match the filter
depending on when the scheme is evaluated within the aggregation interval?

> +		break;
>  	default:
>  		return false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906210513.1068=
95-1-sj@kernel.org?part=3D2
