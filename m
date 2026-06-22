Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CB3B6340
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138271; cv=none; b=pDMM2AJpotVS5QS9+ebItFV4eaKEXGK1CNQGj+8xW977o+O4i8f9pCGfWRax3WaEsMGh6oNySNuF6TaQMF2kQpqQE63i0WxLHQAwcqTHbxE8MnkiEYF/vypcia9kceQ2AJ68uWAEAM2vDej+WiSUtPNak174ZBJ3XhVDQD5cpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138271; c=relaxed/simple;
	bh=eZad8GH2yOoqNVYb+NQI5zQYSZ5Hy4beohQokiz3Ot0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDUeIss3TngEE99SMOFOO0qGhPXPdohEbHjjmRIYPENeoFEFq7QHShtQEdG3AQRYzxODoUPD90BQayIh1zWPD4iZxqIBXa+Gw1fcW7kAcTAMox345y5CPE/Jt6Bma0ueJ1PdyolgbEsFGU9rMOBIsy5HMoVaoebHPAOZQK4ZMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDXWsXqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDXWsXqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157D61F000E9;
	Mon, 22 Jun 2026 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138268;
	bh=5j1r4QBGKTGNVEWHxtE+kidnYMHJKiOgWJq1i3nNMzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDXWsXqf8Pc700Pst0YKpIszDMehbv9Lpb8yPgxSh0gg2h4fV6OcxzSAkLH1zvMPq
	 Da6NcsiYObJM7L8/bbpLKpe2qiGI0JFkkgEPZ5EuB+xrzN4OGptUq1/3FTwLT1lGmJ
	 nsY57r2f4rbuxdEojDVAX+l+cXRlRXKL6QWStVF+yoWboRPpTyaezLPsfXJ/Hxgs1M
	 COiNvD/7TpcuhqZAvkuKYCRgCNLqVrsO38kjqqPFNpWVPGh+SMdTeKikMhLIRguIUr
	 1f9xE39eDXMNA7YNDkjbMujT98OZH0N/sgu11mLAvDgQx6oOHDl5pV/Bjbe5T+UVNg
	 vrSMNh3QATo4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 2/2] mm/damon/ops-common: prevent
 >DAMON_MAX_SUBSCORE freq_subscore
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622141027.29145-3-sj@kernel.org>
References: <20260622141027.29145-1-sj@kernel.org>
 <20260622141027.29145-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:24:27 +0000
Message-Id: <20260622142428.157D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to fix an out-of-bounds array access by cap=
ping `freq_subscore`, but fails to account for integer overflow, leaving th=
e vulnerability fully exploitable.
- [Critical] The `hotness` weighted average calculation is vulnerable to in=
teger overflows via unchecked user-provided weights, leading to an arbitrar=
y out-of-bounds array write.
--

commit 0014f07b693432d299630c4586e19c0cad5fbec9
Author: SeongJae Park <sj@kernel.org>

mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore

When a zero sampling interval and a zero aggregation interval are
online-committed, some regions could have nr_acceses values that are
larger than damon_max_nr_accesses() for the remaining aggregation window.
This commit attempts to fix out-of-bounds array accesses by applying an
upper bound of DAMON_MAX_SUBSCORE to the freq_subscore.

Link: https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 5c93ef2bb8a97..8d516851a69e4 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -115,6 +115,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon=
_region *r,
> =20
>  	freq_subscore =3D r->nr_accesses * DAMON_MAX_SUBSCORE /
>  		damon_max_nr_accesses(&c->attrs);
> +	/* TODO: update monitoring results always to avoid this. */
> +	if (freq_subscore > DAMON_MAX_SUBSCORE)
> +		freq_subscore =3D DAMON_MAX_SUBSCORE;

[Severity: Critical]
This is a pre-existing issue, but does the new bounds check fully prevent t=
he
out-of-bounds access if freq_subscore overflows and becomes negative?

Since r->nr_accesses is an unsigned int and DAMON_MAX_SUBSCORE is 100,
r->nr_accesses * DAMON_MAX_SUBSCORE is evaluated as an unsigned int.

If a user previously configured a large aggregation interval, r->nr_accesses
can grow up to ~22,000,000. If intervals are then online-committed to 0,
damon_update_monitoring_results() skips scaling, leaving nr_accesses at
its large value, while damon_max_nr_accesses() returns 1.

When r->nr_accesses * 100 exceeds 2^31 - 1, the division result assigned
to the signed int freq_subscore overflows and becomes a large negative valu=
e.

The newly added check if (freq_subscore > DAMON_MAX_SUBSCORE) uses signed
comparison, evaluates to false for negative values, and entirely bypasses
the clamp.

This negative value propagates to the hotness score. Finally,
damos_adjust_quota() implicitly casts this negative score to an unsigned int
array index, resulting in a huge offset causing an arbitrary out-of-bounds
memory write on c->regions_score_histogram.

[Severity: Critical]
This is a pre-existing issue, but can the hotness weighted average calculat=
ion
overflow and bypass the DAMOS_MAX_SCORE bounds?

The user-configurable weights freq_weight (s->quota.weight_nr_accesses) and
age_weight (s->quota.weight_age) are set via sysfs without upper bounds,
allowing them to be arbitrarily large.

In damon_hot_score(), the hotness is computed in 32-bit unsigned arithmetic:

mm/damon/ops-common.c:damon_hot_score() {
	...
	hotness =3D (freq_weight * freq_subscore + age_weight * age_subscore);
	if (freq_weight + age_weight)
		hotness /=3D freq_weight + age_weight;
	...
}

If the weights are chosen such that freq_weight + age_weight wraps around
UINT_MAX to a small value (e.g., 2), the numerator also wraps.

When the wrapped numerator is cast to the signed int hotness and divided by
the small unsigned sum, C's usual arithmetic conversions promote the negati=
ve
int hotness to a huge unsigned int before division.

The final scaled result entirely evades the intended DAMOS_MAX_SCORE bound,
returning an arbitrary out-of-bounds index that damos_adjust_quota() uses
for an unsafe write on c->regions_score_histogram.

> =20
>  	age_in_sec =3D (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
>  	if (age_in_sec)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622141027.2914=
5-1-sj@kernel.org?part=3D2
