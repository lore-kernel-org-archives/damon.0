Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B73845D0
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351014; cv=none; b=CZJt/nJYXuvongqR0lw6uKsz7eoTX/LoMmKKFDOlKmKhfqptK5C4eMjYHztjc7Q4cMipT45ZrzVRWKw+zGbAHBTxMSOUr38ndDHUx/tzeJdaI6AkQ3H4K4DlGZIe8bBU5QFBea+ljg19geFaM9Wab0bGGtPt5odvT7YR9PwZAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351014; c=relaxed/simple;
	bh=8jwYZHbjCslGWmUAh9CKO2cIqReQUJm00sHzB8C1a+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IMvnGA4wovG85SpxH3g84BBV5I5DYBwNADeiFqGt147kbuFPvUuTSRbpOde8TYc/wA9XXbBvBStjNx3qDQfXbK20pq9+ec+Mj+1ilnd1cZnDbriEmTMpEvIjbnpHwMm2cwa3lHfoP/zCcbVqnimaDMa4niCGoUpftYOFMslgT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlEOjTOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlEOjTOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B51F000E9;
	Mon,  6 Jul 2026 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783351012;
	bh=suBXxzHPSe7GgYIAKzDJBJXfdBgcHhlbaZTcvlmQ2Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WlEOjTODwKI8j33vp8clr2yNU8tjp5E2VolSj7xpzeqlUogd3ZK4CnPxXjE54codc
	 3hOA9rXgKm4v8g5JW7imzhgGeXVLYUulugf172+M6O42/9hakYWsf0ISG4HlRKfMte
	 zAl94MpK2/OSaG0tPQ+WvOo0JtG1wFQle74W2hh3AdidaUb1kmAbUa365qQtFP4/s4
	 JLUrQTpwjmXplz3KBczu4fZT9iXTiJDP5dVI9G1oGC2ALDrzvPoSUHyMfBKH4Pv52P
	 T5YPmiazrBEPxXBVFW5RXJeo99Zni8vk4c5L6pAPcAHAy+GtWEmesUMejAebZptg5p
	 Yqpk6CTZ+pEJw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 12/16] mm/damon/core: implement
 damon_has_probe_weight()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-13-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:16:52 +0000
Message-Id: <20260706151652.866B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Setting probe weights on a DAMON context whose operations do not s=
upport `apply_probes` (e.g., `vaddr`) silently disables all monitoring.

Pre-existing issues:
- [High] The `probe_hits` array in `struct damon_region` uses `unsigned cha=
r` counters which wrap around at 256, corrupting monitoring data when the n=
umber of samples per aggregation interval exceeds 255.
--

commit 3891f362834bef45987ebcee1cdb0abcd9df6ea2
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_has_probe_weight()

DAMON monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always.  The intention was to make changes for complete support of the
mode in a safe and incremental way.  Now all the building blocks are
made.  Complete the mode detection function so that the mode can really
start working.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fa78d8d592aa3..6e5a029989a0c 100644
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

[Severity: High]
Does returning true here silently disable monitoring if the context operati=
ons
do not support probes (e.g., vaddr)?

In kdamond_fn(), if this returns true, access_check_disabled bypasses stand=
ard
checks. However, if ctx->ops.apply_probes is NULL, the probes are skipped:

mm/damon/core.c:kdamond_fn() {
    ...
		bool access_check_disabled =3D damon_has_probe_weights(ctx);
    ...
		if (!access_check_disabled && ctx->ops.prepare_access_checks)
			ctx->ops.prepare_access_checks(ctx);
    ...
		if (ctx->ops.apply_probes) {
    ...
}

Would it be better to ensure ctx->ops.apply_probes is also implemented befo=
re
returning true?

[Severity: High]
This is a pre-existing issue, but since this patch enables probe weights,
can the 8-bit probe_hits counters overflow if the number of samples per
aggregation interval exceeds 255?

Looking at struct damon_region in include/linux/damon.h, probe_hits is
declared as an unsigned char array:

include/linux/damon.h:struct damon_region {
    ...
	unsigned char probe_hits[DAMON_MAX_PROBES];
    ...
}

In damon_pa_apply_probes(), it is incremented during every sample interval
without checking for overflow:

mm/damon/paddr.c:damon_pa_apply_probes() {
    ...
			damon_for_each_probe(p, ctx) {
				if (damon_pa_filter_pass(pa, folio, p))
					r->probe_hits[i]++;
    ...
}

If a user configures an aggregation interval that is > 255 times the sample
interval, could highly-hit regions wrap around to 0 and be falsely identifi=
ed
as cold memory?

> +	}
>  	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D12
