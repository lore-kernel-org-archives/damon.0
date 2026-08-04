Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E74582E3
	for <damon@lists.linux.dev>; Tue,  4 Aug 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838994; cv=none; b=XidRjzCHF06kPO+Cr5R9dOc18TDTa3/4tQnHux2cwxfVDHGfQUoLoc4jt+Fp0bBhUM4nGyzi5gn39sDgpd3bYM84H9v16Hp0BTiT60VWFpQgeMm1fwUsYzdFnuWETPQmx33wFuB6NCBIogmqgWCCb1SuBTK2ms8iszgr0r6MuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838994; c=relaxed/simple;
	bh=QlbiH0IUMtUn4xX6JqYnQBqBRVNbkjQQUmStKDUE49s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nOJgUHQ8hHpU4Dcvp+sk5lHuQU00KKfsWhbBy5XY+10V15viuM4JT7D3TgKPFsGGCyBrZ2tB8tHm/beD7761TPizoI6kJdDSLWcG83MgbZ8v20yx5P/sK77+gqQB+zy5pOvzT04ZxN7ML8hybXJgaD/G0K2L576biDIVCCaMaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4fhkblR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4fhkblR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F8F1F000E9;
	Tue,  4 Aug 2026 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785838993;
	bh=fGsGAH1x5oKpiEfmZCgi/Ec438O2cDIvI4dQxf7VD9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4fhkblR5u4rE41YC5rcjiZ3S5w9bEu7LCVcl49iC8xRCjO1mCqIs1MoryONTOBQl
	 M0URRVN4sjVss3b6M2+YwXTPZW0gYIDNwLlI2RslFA2OuvccgMZ3co95cAUUhHSn4O
	 owZTxky9hAaDGdASv6WGTSz6LkhL0814dHlBnPqr1xKZTkkpxMCNrXgQRD/DxaZzPs
	 ZWlxeaOEQrgIU7VbRFgJjmsFisATosWExxZ+GHYebMR2prqO0BUeWSrlv0TAVAn081
	 F/qK6yawZyxNwcdAHGp1IdttAq32oYvKj3jJYVewrDOn3aJB9a3bdMojuObk7ubv/T
	 nxRtgGNwlqjbg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon: introduce damos_sort_type for re-ordering
 regions list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260804100719.116538-1-aethernet65535@gmail.com>
References: <20260804100719.116538-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:23:11 +0000
Message-Id: <20260804102312.E8F8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Broken `stat.nr_snapshots` tracking in `damos_apply_sorted_scheme(=
)` bypasses `max_nr_snapshots` limit enforcement.
- [High] Sorted schemes are evaluated out of order, violating DAMON's stric=
t scheme priority semantics.
- [Medium] Silent disabling of schemes when `get_scheme_score` is not suppo=
rted by the underlying operation set.
--

--- Patch [1]: [RFC PATCH] mm/damon: introduce damos_sort_type for re-order=
ing regions list ---
commit 2f127c3d13c04b9a2b95946211fee29deac96c0d
Author: Liew Rui Yan <aethernet65535@gmail.com>
Subject: mm/damon: introduce damos_sort_type for re-ordering regions list

This patch adds a per-scheme sysfs attribute schemes/<N>/sort_type to allow=
 a
scheme to apply actions to target regions in descending order of their
ops.get_scheme_score() values.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..b0c52c9eabe82 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2673,6 +2684,107 @@ static void damon_do_apply_schemes(struct damon_c=
tx *c,
>  	}
>  }
> =20
> +struct damos_sort_priv {
> +	struct damon_ctx *c;
> +	struct damos *s;
> +};
> +
> +static int damos_sort_score_desc_cmp(const void *a, const void *b,
> +		const void *priv)
> +{

[ ... ]

> +}
> +
> +static void damos_apply_sorted_scheme(struct damon_ctx *c,
> +		struct damon_target *t, struct damos *s)
> +{
> +	struct damon_region **arr;
> +	struct damon_region *r;
> +	struct damos_quota *quota =3D &s->quota;
> +	struct damos_sort_priv priv =3D { .c =3D c, .s =3D s };
> +	unsigned long nr =3D 0, i =3D 0;
> +
> +	if (!c->ops.get_scheme_score)
> +		return;

[Severity: Medium]
When the operations set does not implement get_scheme_score, does this early
return silently disable the scheme and prevent stat.nr_snapshots from ever
incrementing?

The unsorted path gracefully handles a missing score callback by falling ba=
ck
to basic filtering without the score.

> +	/* Avoid unnecessary kvmalloc_array() */
> +	if (damos_quota_is_full(quota, c->min_region_sz))
> +		return;
> +
> +	damon_for_each_region(r, t) {
> +		if (__damos_valid_target(r, s, c))
> +			nr++;
> +	}
> +	if (nr =3D=3D 0)
> +		return;

[Severity: High]
If there are no valid regions (nr =3D=3D 0), this returns early without
incrementing s->stat.nr_snapshots. Does this prevent the scheme from ever
reaching max_nr_snapshots and automatically deactivating?

> +	if (nr =3D=3D 1)
> +		goto single_valid_region;
> +
> +	arr =3D kvmalloc_array(nr, sizeof(*arr), GFP_KERNEL);
> +
> +	if (!arr)
> +		return;
> +
> +	damon_for_each_region(r, t) {
> +		if (__damos_valid_target(r, s, c))
> +			arr[i++] =3D r;
> +	}
> +
> +	sort_r_nonatomic(arr, nr, sizeof(*arr), damos_sort_score_desc_cmp, NULL=
, &priv);
> +
> +	for (i =3D 0; i < nr; i++) {
> +		r =3D arr[i];
> +
> +		/* Check the quota */
> +		if (damos_quota_is_full(quota, c->min_region_sz))
> +			break;
> +
> +		if (s->max_nr_snapshots &&
> +				s->max_nr_snapshots <=3D s->stat.nr_snapshots)
> +			continue;
> +
> +		if (damos_valid_target(c, r, s)) {
> +			damos_apply_scheme(c, t, r, s);
> +		} else {
> +			/*
> +			 * There is no need to continue because the score is
> +			 * already lower than quota.min_score.
> +			 */
> +			break;

[Severity: High]
If a region fails damos_valid_target() due to low quota scores, this breaks
out of the loop and skips the (i =3D=3D nr - 1) check below. Does this omit
tracking the snapshot and prevent the scheme from deactivating?

> +		}
> +
> +		if (i =3D=3D nr - 1)
> +			s->stat.nr_snapshots++;
> +	}
> +
> +	kvfree(arr);
> +	return;
> +
> +single_valid_region:
> +	damon_for_each_region(r, t) {
> +		if (__damos_valid_target(r, s, c))
> +			break;
> +	}
> +
> +	/* Check the quota */
> +	if (damos_quota_is_full(quota, c->min_region_sz))
> +		return;

[Severity: High]
If the quota is full in this single_valid_region fast-path, it returns earl=
y.
Does this also bypass incrementing s->stat.nr_snapshots?

> +
> +	if (s->max_nr_snapshots &&
> +			s->max_nr_snapshots <=3D s->stat.nr_snapshots)
> +		return;
> +
> +	if (damos_valid_target(c, r, s))
> +		damos_apply_scheme(c, t, r, s);
> +
> +	s->stat.nr_snapshots++;
> +}
> +
>  /*
>   * damos_apply_target() - Apply DAMOS schemes to a given target.
>   * @c:			monitoring context to apply its DAMOS schemes to..
> @@ -2695,6 +2807,17 @@ static void damos_apply_target(struct damon_ctx *c=
, struct damon_target *t,
>  		unsigned long max_region_sz)
>  {
>  	struct damon_region *r;
> +	struct damos *s;
> +
> +	damon_for_each_scheme(s, c) {
> +		if (s->sort_type =3D=3D DAMOS_SORT_NONE)
> +			continue;
> +		if (!s->wmarks.activated)
> +			continue;
> +		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
> +			continue;
> +		damos_apply_sorted_scheme(c, t, s);
> +	}
> =20
>  	damon_for_each_region(r, t) {
>  		struct damon_region *prev_r;
> =20
>  		damon_do_apply_schemes(c, t, r);

[Severity: High]
By iterating and applying all sorted schemes first, and then iterating to
apply unsorted schemes via damon_do_apply_schemes(), are we executing sorted
schemes out of order?

DAMON evaluates schemes in the order they are defined. If a user defines an
unsorted scheme before a sorted scheme, this two-pass execution will cause
the sorted scheme to evaluate the regions first, breaking the execution
order priority.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804100719.1165=
38-1-aethernet65535@gmail.com?part=3D1
