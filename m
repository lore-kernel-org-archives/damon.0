Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061B1A9F97
	for <damon@lists.linux.dev>; Thu, 21 May 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340929; cv=none; b=p+ByRwruLq/fK60RhhjDGCj6spLiWkZqz4lzvLzwHlStVc/m0gY0JyNb6ZgqQK5CXqCYZSIvXocXl7FCRAamSVBQclXkk3TsyfAZJpdAEC/IO7CT8AXwuno7gL8e3NtNNAJvfzXDFHOA3ORUIxg2NbTO9UYaULou72cEWskAOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340929; c=relaxed/simple;
	bh=Q8A6DEym6jzHW3uiPYvj1nm/tA+AmJjvAC58qijQs24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVTLvtHq+IZUVB3JxxnbMZXprhA13q0oD2hYFOGkIkML0ZBMRCjNRSNpfXtry2uJoPjudYpKkT7HC1J54T0Tad1GTBOZ1nR4A7VCRnYv7UdSMbVUqJwgsrq3YKSR4PkRv7cdYdwZXHqwl+rVdiFfzgseXrtBPH+OgyLusZYfPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYOLzqVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYOLzqVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01821F000E9;
	Thu, 21 May 2026 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779340928;
	bh=cnDwjD01p2IeVkdMKpZBCrtrApkSpjLTMc+k2nDeTc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYOLzqVNGoniiQm+RsPC/N9LRmPB5pOs3NMses97xN2G2FEmE0Hu2ZQfqheSJj8S+
	 X2+o0dPXyBWgAYT07Kqc+PcRRKTYIx8+yEru+stN735BZBxdLJh4GjaYQ4NEoNVIcJ
	 UyU0RW7Crr5ag+Ml9JOuRiCXE+FGL3Q8vbluRSVMzPpRFVRt6e1c/AxGi/OxRU5s90
	 oqNDwKa4DovIC6o5MTwpHhAyfztN85VUi2hz2YwBrrOEMOPUPuchGxqRTTKCmT9GOY
	 MFfpwmM5NBBo84AsOdnnRaQFywL+VAgIN6PAdZl9ENlOFc2KbrsrS7eVhBKG8izxBD
	 tABDgiEkhrG4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: split age==0 regions when nr_regions
 exceeds max/2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260521045236.115749-2-jiayuan.chen@linux.dev>
References: <20260521045236.115749-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 05:22:07 +0000
Message-Id: <20260521052207.F01821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `damon_split_zero_age_regions` function processes targets an=
d regions sequentially, potentially starving later targets if the budget is=
 exhausted early.
- [Medium] The calculation of `sz_sub` can overflow on 32-bit architectures=
 for large regions, resulting in incorrect sub-region sizes or failing to s=
plit.
--

commit 8c8f86e64dc7143fb89435db427efa2adca6f33c
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon/core: split age=3D=3D0 regions when nr_regions exceeds max/2

This commit modifies the region splitting logic to handle scenarios where
the region count exceeds half the maximum limit. Instead of returning early,
it now splits regions whose access pattern has just changed (age =3D=3D 0) =
up
to the remaining budget, which helps discover internal access variations in
large regions.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> +static void damon_split_zero_age_regions(struct damon_ctx *ctx,
> +					 unsigned long budget)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r, *next;
> +
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region_safe(r, next, t) {
> +			unsigned long sz_region, sz_sub;
> +
> +			if (!budget)
> +				return;

[Severity: Medium]
Will this sequential processing potentially starve later targets if the
budget is exhausted early?

Since budget is a context-wide limit shared across all targets, a highly
active first target with many zero-age regions could consume the entire
available split budget.=20

This might permanently prevent subsequent targets in the same context from
refining their monitoring resolution under dynamically changing access
patterns. Could a round-robin or proportionate distribution be used here
instead to ensure uniform monitoring fidelity?

> +			if (r->age !=3D 0)
> +				continue;
> +			sz_region =3D damon_sz_region(r);
> +			if (sz_region < 2 * ctx->min_region_sz)
> +				continue;
> +
> +			sz_sub =3D ALIGN_DOWN(damon_rand(ctx, 1, 10) *
> +					sz_region / 10, ctx->min_region_sz);

[Severity: Medium]
Can the calculation for sz_sub overflow on 32-bit architectures for large
regions?

Since unsigned long is 32 bits on those architectures, if sz_region is
large (e.g., > 477 MB), multiplying it by a random value up to 9 could
wrap around ULONG_MAX.=20

This overflow would result in drastically smaller sub-region sizes. If the
wrapped product divided by 10 is smaller than min_region_sz, ALIGN_DOWN
evaluates to 0. This would trigger the blank region check below and skip
the split entirely.=20

Should the division occur before the multiplication to prevent this?

> +			/* Do not allow blank region */
> +			if (sz_sub =3D=3D 0 || sz_sub >=3D sz_region)
> +				continue;
> +
> +			damon_split_region_at(t, r, sz_sub);
> +			budget--;
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521045236.1157=
49-1-jiayuan.chen@linux.dev?part=3D1
