Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D144192D8A
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808574; cv=none; b=Elsx1Ev/sD1ngkClc6h2ai+ofnb3FSduhoSsJeZMXOD0nGHS4liYC5isL/ayZNXHR4T253iVbKAmPzpj5Pu3/XgqumM4cQhZSg1/6bD5+9nPCitA/OPLdh3NmGvCio+E1fXAidLKhPqaKZBdVhkIZob6nxIpj462yUSBsSYp6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808574; c=relaxed/simple;
	bh=HFfM7sTUQy8WdnLIu5A/48CxncL7LJQxGb8RNXakIcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JVR7mYakT1IENr35+CFMdDdsySgZw1fZgVvRpJhWRQWyfV7+LM6FosgyZfBpxfZRYwqfm1pxklJlNXpuH5bDT9+f8zKZ+BG2dRNKg6HLJEFxVumH7AiHB3fPBXz0pZRP1TSRSdXlzVB3S8JidGYC1xdY24/P4+I0Abod1JUz7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3MIEFBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3MIEFBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEECC2BCB3;
	Fri, 15 May 2026 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808574;
	bh=HFfM7sTUQy8WdnLIu5A/48CxncL7LJQxGb8RNXakIcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=A3MIEFBLb0XgOHRdX2du5bNhK2oUBPI+minjier2Xyjs3zyGgucchh9Gne4nt/m7u
	 RFFWdV6g4/VZAIie0Fr+fs4WVr2Av41gdp37sni1pgN6TghUMVlMjYqvFBttNVySPv
	 NUQa+uWOgdGfz11OLCYf5MQOIexdjVgUGOv7/X5BJ9SbSjPr2WIbj3HLVqno3KBApo
	 IgGbkh2AZpahSab2yhyGN6EWWYft6twRr7XWMfzFHL9FbcggXrDZwY7JLtVqqD6IAL
	 Z0jJyA7M836pXc/Ya8MdL8EWc3kqs3V7tJJKE6o7sYxw0o/7yGJtSLOOJaJpWLORA4
	 Je4V4VFvM1srQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 08/28] mm/damon/paddr: support data attributes
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-9-sj@kernel.org>
References: <20260515004433.128933-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:29:33 +0000
Message-Id: <20260515012933.EAEECC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Flawed and order-dependent filter fallback logic in damon_pa_filte=
r_pass().
- [Medium] The probe_hits counters can silently overflow and wrap around.
- [Medium] Redundant folio lookups and reference count operations for each =
probe.
--

commit dd2c6385be410e674ab72a5dd4ff210f2f41dd48
Author: SeongJae Park <sj@kernel.org>

mm/damon/paddr: support data attributes monitoring

This commit implements and registers the apply_probes callback to
support data attributes monitoring in the paddr operations.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5cdcc5037cbc1..493bcca8ff104 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -120,6 +120,67 @@ static unsigned int damon_pa_check_accesses(struct d=
amon_ctx *ctx)
>  	return max_nr_accesses;
>  }
> =20
[ ... ]
> +static bool damon_pa_filter_pass(phys_addr_t pa, struct damon_probe *p)
> +{
> +	struct damon_filter *f;
> +	struct folio *folio;
> +	bool pass =3D true;
> +
> +	folio =3D damon_get_folio(PHYS_PFN(pa));
> +	damon_for_each_filter(f, p) {
> +		if (damon_pa_filter_match(f, folio)) {
> +			pass =3D f->allow;
> +			break;
> +		}
> +		pass =3D !f->allow;

If no filters match the folio, does this logic make the final fallback
decision entirely dependent on the allow boolean of the last filter in the
list?

Reordering the filters could silently invert the fallback behavior for
non-matching folios.

> +	}
> +	if (folio)
> +		folio_put(folio);
> +	return pass;
> +}
> +
> +static void damon_pa_apply_probes(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	struct damon_probe *p;
> +
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region(r, t) {
> +			int i =3D 0;
> +
> +			damon_for_each_probe(p, ctx) {
> +				phys_addr_t pa;
> +
> +				pa =3D damon_pa_phys_addr(r->sampling_addr,
> +						ctx->addr_unit);
> +				if (damon_pa_filter_pass(pa, p))

Does this redundantly repeat expensive folio lookups and reference count
operations for each probe?

The physical address calculation and folio lookup in damon_pa_filter_pass()
are executed inside the probe loop, meaning they will be repeated for the
exact same physical address if multiple probes exist.

Could the folio lookup be hoisted outside the probe loop to avoid unnecessa=
ry
overhead?

> +					r->probe_hits[i]++;

Could this counter silently overflow and wrap around?

r->probe_hits[i] is defined as an unsigned char in struct damon_region.
If the aggregation interval is configured to be thousands of times larger t=
han
the sample interval, this 8-bit counter might easily overflow.

> +				i++;
> +			}
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D8
