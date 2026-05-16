Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6835AC09
	for <damon@lists.linux.dev>; Sat, 16 May 2026 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958333; cv=none; b=RfMBdsVE0JgDa35X+xf9UDToxP5xpTb6StvwszvzWWtWpZ4k0+MVwh2SNlzbMGviQ+h0CQbfrxL6RuwnrK0/CqitPW5RtKAHbBqvR5pOyu/ad8AWjg2cdtjf2H80hkCtGB3FcqTh98i2r3KoMHD6j30ltr65pk/lvQJWb24SukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958333; c=relaxed/simple;
	bh=p2MO8uIN7O4mOVMt26HbDISW1k6emmMxFkKX8WKtvd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lBYtH+8fyFT7CbNio2z8c5E+1yOYuJjL3v4GXwqByLHwJnbFfv6CMMif5PYMIkMmzI9vxCO+kHHgkgNgYcG11CK7deK1AEV1IHFAFuaYriAsp3g+vdW5X+fhMNgzbL7sfUgWrSDLUibsby0Xq1Rp0LiLZv3APk6GQ4eLD8mWgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+/8tBh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+/8tBh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F268CC19425;
	Sat, 16 May 2026 19:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958332;
	bh=p2MO8uIN7O4mOVMt26HbDISW1k6emmMxFkKX8WKtvd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k+/8tBh90yVM8v05CRIyLsJgkDH7ryWR/juTDWy3/xp1ml8GrZ8n039WTkfFSXDei
	 i4B8j/VXB5/fUe3BdRYLsqVR2aT/dLoY0TEpF7LZfVlDDT9UfWi9WXqrSkN6MCAM45
	 XYtoQJYGettacg3yLRClZmjpaiJ/MAmlGUX71gkX3ClOTrE/h8xZpjClQ0opNkD4a0
	 WSzzuHoDabS9w9R/hu1F9NJPReFWOYVWg7th9e0a5xKmxWR4w4uc947RtfEiHIFe8N
	 GrfyowXgOPoOcE0fwHX1I9FBUkkgOMjI1TmXqlNy+LA9HxDioehDVkvuipzQF2OjFI
	 DQP8uKHHsmv9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 08/28] mm/damon/paddr: support data attributes
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516183712.81393-9-sj@kernel.org>
References: <20260516183712.81393-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 19:05:31 +0000
Message-Id: <20260516190531.F268CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Brittle filter evaluation logic in `damon_pa_filter_pass()` causes=
 unpredictable default fallback behavior.
- [High] Silent integer overflow of `r->probe_hits[i]` due to an 8-bit limi=
t.
- [High] Costly page lookups and folio refcount operations are unconditiona=
lly performed even when no probes are configured.
--

commit 3ac6d88b44843f7304cd50448ef416c14428371c
Author: SeongJae Park <sj@kernel.org>

mm/damon/paddr: support data attributes monitoring

This commit implements the apply_probes() callback for physical address
space monitoring in DAMON. It introduces filter evaluation and applies
probe hits to region statistics.

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c

[ ... ]

> +static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
> +		struct damon_probe *p)
> +{
> +	struct damon_filter *f;
> +	bool pass =3D true;
> +
> +	damon_for_each_filter(f, p) {
> +		if (damon_pa_filter_match(f, folio)) {
> +			pass =3D f->allow;
> +			break;
> +		}
> +		pass =3D !f->allow;
> +	}
> +	return pass;
> +}

If a folio does not match any of the filters, the loop continues and pass
is repeatedly updated to the inverted allow flag of each evaluated filter.

When the loop finishes, the final returned result is purely the inverted
allow flag of the last filter in the list.

Is this arbitrary fallback logic intentional?

[ ... ]

> +static void damon_pa_apply_probes(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	struct damon_probe *p;
> +
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region(r, t) {
> +			int i =3D 0;
> +			phys_addr_t pa;
> +			struct folio *folio;
> +
> +			pa =3D damon_pa_phys_addr(r->sampling_addr,
> +					ctx->addr_unit);
> +			folio =3D damon_get_folio(PHYS_PFN(pa));

Because damon_pa_apply_probes() executes unconditionally on every sampling
interval, damon_get_folio() and folio_put() will be called globally across
all regions even if the user has not configured any probes.

Could we add an early return or check if ctx->probes is empty before
performing these expensive atomic refcount operations on the hot path?

> +			damon_for_each_probe(p, ctx) {
> +				if (damon_pa_filter_pass(pa, folio, p))
> +					r->probe_hits[i]++;

The r->probe_hits[i] counter is declared as an unsigned char in
struct damon_region, which has a maximum value of 255.

Since the number of samples per DAMON aggregation interval is configurable
and can easily exceed 255 in standard use cases, won't this counter
silently wrap around to 0 and corrupt the monitoring statistics?

> +				i++;
> +			}
> +			if (folio)
> +				folio_put(folio);
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516183712.8139=
3-1-sj@kernel.org?part=3D8
