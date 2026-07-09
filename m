Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826336AB53
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607813; cv=none; b=oUBjdhgziSmXPkbjpZv97mxIIsktfakxV1k/Vl/PW5F6tIBiNSxQIigOQVY96Zb9T+zvWqSu/eZ8Nt4SOyvoKdKNFvSZC4lIKPdFXUlaXNfVw991Qlnix/84D2AqMPvxWEJFzV2J6rDqOZGPrRFfnc1f6+SFi5yIrPpRV97xHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607813; c=relaxed/simple;
	bh=I2L87LtKBCV9Cs9t8QCaWB9nvzcwsH0ARu57bykfBps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lG5HLURcCzZy80inH8ruHeQ07qstQ5U2wetqCR2bOBZxUOlRRMRDhU0GKINgme7mpjHiEGxS62iKjdhMUlWB5JaQ/l0feXn1cpkOpCpx0gOOZ2t7F3Xy4374r5wCH1wItOfcQeFvTX982oBfMxdK98FuSrBt9+QHX83WzJ7LaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luJzDDIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luJzDDIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8E61F00A3A;
	Thu,  9 Jul 2026 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607812;
	bh=c5y5smXTlh7uS+Ox6T4ERI4eek1d9/DNT5CLdyt3ahE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luJzDDIwdKMXJ26hiubgxHX9KMmoU1LhvdtFnteKY4u9IgvcKDvHVYvlidNsdB/bp
	 4cKkGskblL6dQFhPD89Z0be8HMwSwdPXPXrMJqxhGzBHcwkvjybZCQlzh6WNSTJvUL
	 M2lwHU3VnYxv91wMI9kxyLoD8aYfnC/QYPRtN9PQU5CecE1coJXFAgScuSE4ef/oqu
	 VYmybTlqcLRe05KJiHCDsWyhc5Rwv4tmLnZ2Gv7D4icLpTpNC5Lu2ZAaqeeC6H87Cj
	 94U5PkJ6nKAgmfcij1MrchSxUk4O0GToHnETOTkK9TKXZ08++ZXXUQlruZBOuO/TuD
	 ubxhWJ4u6A2qQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 10/19] mm/damon/core: validate params for probe
 hits weighted sum overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-11-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:36:51 +0000
Message-Id: <20260709143652.6A8E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Spelling mistake in comment.
--

--- Patch [10]: [RFC PATCH v1.2 10/19] mm/damon/core: validate params for p=
robe hits weighted sum overflow ---
commit 3e76c3dde55500288f3eccb730acd26964bfdad2
Author: SJ Park <sj@kernel.org>

mm/damon/core: validate params for probe hits weighted sum overflow

This commit adds parameter validation to prevent probe hits weighted sum
overflow. It ensures that the combination of probe weights and aggregation
intervals does not exceed the maximum allowed values.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4f1425e56950b..b585e4bf035f1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1342,6 +1345,18 @@ static bool damon_valid_probe_params(struct damon_=
ctx *ctx)
>  	sample_interval =3D ctx->attrs.sample_interval ? : 1;
>  	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
>  		return false;
> +
> +	/* invlaid if probe hits weighted sum can overflow */

[Severity: Low]
This isn't a bug, but there is a typo in this comment ("invlaid" instead of
"invalid").

> +	max_probe_hits =3D damon_nr_samples_per_aggr(&ctx->attrs);
> +	wsum =3D 0;
> +	damon_for_each_probe(probe, ctx) {
> +		if (probe->weight > UINT_MAX / max_probe_hits)
> +			return false;
> +		wsum_to_add =3D probe->weight * max_probe_hits;
> +		if (UINT_MAX - wsum < wsum_to_add)
> +			return false;
> +		wsum +=3D wsum_to_add;
> +	}
>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D10
