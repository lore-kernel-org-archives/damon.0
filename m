Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B71199D8
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606864; cv=none; b=sbC0/MhsxY2OZu/6wpjkVC5JQW9ypI1T8VbAjcPGCYe/eorIgCUVL0UBwL73Ayy0Rlq4BhErho89bJn386axCZcIUIAbEdkIqszvnnaYbhntKSz7y0iN9dEtWMarRoBJ/6oAYMVgvTAnomwqOhy6PVDWd3rDkpNo6B+5LynGKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606864; c=relaxed/simple;
	bh=0ADEoOKvN8h0jstAQrAgHdnP1FE5vsv4Dp3Ju8JwK6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dABNizGbAVff/vFiQNXibcqLBS/AFWQ+Ua5JFVQJI/c2LbRXpf0e5KhJIAaQmNd4MDKIibpUr1jVNbcEVzN5xrAsw7F5Be8sSslFn4jwDhOQUSE7fs7wv49xAWkJ6XTzE291iNDECXQHkuli5ZF/tXZAcdp75W/mGQI/PFXpDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbOsO5sW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbOsO5sW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E231F000E9;
	Thu,  9 Jul 2026 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606863;
	bh=cL/5dtcVAa2HRat8AHshcK80qFq9eoBCjUwa7YxIee4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbOsO5sW96D2YCvqJNR+UyM9542PbqPBTFja4l6JL5C1TaMToMhRTsfZDb6K61+kU
	 93LCNmtLJBK263TpKezmATF0P3UNn52G1l6EkFF7U6Z+xfyROz4E9UBN4tvIFUsJbh
	 T9cDGOT5w4iPEzhyZgp2rMYKHr9MtXYWffV6MRAEEAZD3jUMi8iBKxPZtu191yrHmb
	 rp9NrwO+2XhV0iCdPWI1no2UjvwvUUwp3H5oQeajf5MhFXBgSRDFhEqfxDh100CTjG
	 RmaF5Uy6RMdVxtmd/dD2bP3Ub6JyXq/EoyI9d0EqF5idt6hq+cB3M+xOJkNpjZ53pY
	 ivueEf6WagMjg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 03/19] mm/damon/paddr: set samples in
 apply_probes() if requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-4-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:21:02 +0000
Message-Id: <20260709142103.36E231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in `r->probe_hits[]` counter when `aggr_samples` =
exceeds 255.
--

--- Patch [3]: [RFC PATCH v1.2 03/19] mm/damon/paddr: set samples in apply_=
probes() if requested ---
commit 81ba2fab5bb28d260739f7b8c81129066d602897
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: set samples in apply_probes() if requested

This commit updates the apply_probe() callback implementation in DAMON_PADDR
so that it respects the set_samples parameter.

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

Looking at include/linux/damon.h, probe_hits is defined as an unsigned char
array:

struct damon_region {
	...
	unsigned char probe_hits[DAMON_MAX_PROBES];
	...
};

Immediately following the code in this diff, damon_pa_apply_probes()
unconditionally increments the counter:

			folio =3D damon_get_folio(PHYS_PFN(pa));
			damon_for_each_probe(p, ctx) {
				if (damon_pa_filter_pass(pa, folio, p))
					r->probe_hits[i]++;
				i++;
			}

If a user configures DAMON via sysfs with an aggr_interval and sample_inter=
val
ratio that yields more than 255 samples per aggregation interval (for examp=
le,
aggr_interval=3D100000us and sample_interval=3D100us), this counter will si=
lently
wrap around.

Could this cause heavily accessed regions to wrap to a small number and app=
ear
cold, potentially leading DAMOS to make incorrect memory eviction or migrat=
ion
decisions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D3
