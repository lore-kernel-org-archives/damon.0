Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82C41A767
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349743; cv=none; b=CiCQzQqhzXvsSke4Fnop5xb5W5SJF/mlZne1UHIj2Q+95wtzQ6/TNBEZaNWs3lKbJ4HD33h4P6PG/viwnbej+vCNQ8BTzTL/G/eDYMfAuDBUv17EiWj/5o7GVd5wBcqkauoCIDpIauhioc2BWV0MuQpov5lSuODzQOpnaNcDUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349743; c=relaxed/simple;
	bh=Ljpp+/EsFr9WZMygxyRpi4r1r4oV6llGh7S1doVvPcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P+TwuOSr0+soeD+H7pvJFQlZjMGbmNqx8JNzr1guMHV4VLAw7ysamgms2bZ2inbP+3uxGs7f1dfgDg42MYIUNI+qVC7ki8LWofogX+E53xflIAvO9RF0EMbQdnHe+RYynHxpzx6PfrI0V+8TeNxhQh6w+p4ks4TZ5DxJ4bb0r2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCdr0Cg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCdr0Cg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9291F000E9;
	Mon,  6 Jul 2026 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783349739;
	bh=Fa9P8s0dnsaJYtK9vleOS5+IQHJndyhZwBuyFuWmza4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCdr0Cg+nZsUC2BndkZxFPrs2SfWZoAwxW03GWyOxO/A+KDht60Ja4IoGlCYjEPQB
	 jdOvuRcfdrd6efF1/FL9TiH9sm9NaYKsWjovYXMapyrb7IrI0S+DVruhChCkvvnwa0
	 KrbASZ+XnD4czgW8ds5FyAlfYalDBNmsQV0RusldULogXI6MZC5cDYvmn+wqMqaM+s
	 pxHODPDyQzF6wkLitL/qOjir1tuEr4az+aUggynGdQSxy2Mxm2auUFr2SCye4RgWki
	 pAIdNODfq/3YED1f7tiNsUxP81nR0ApMBnBw5JCiIl8DGmX4haVxBj0NNveQY9LVBP
	 QmrBgXW6dn1oQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 07/16] mm/damon/core: extend merge function to
 work with probe hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706141912.88445-8-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
 <20260706141912.88445-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:55:38 +0000
Message-Id: <20260706145538.DF9291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] API Misuse / Silent Overflow: Using `abs()` on the difference of t=
wo large unsigned integers causes incorrect results.
- [High] Integer Overflow: `damon_probe_hits_wsum()` wraps around the 32-bi=
t boundary when large weights are used.
--

commit b2b82783307a6d10c78010502dd30f5168036627
Author: SJ Park <sj@kernel.org>

mm/damon/core: extend merge function to work with probe hits

When probe weights are set, this commit extends damon_merge_regions_of() to
work with the weighted sum of probe hits. It also introduces a placeholder
detection function to allow safe incremental changes.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 42f27849af722..7aff741d43bd4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3230,6 +3235,16 @@ static void damon_merge_two_regions(struct damon_t=
arget *t,
>  	damon_destroy_region(r, t);
>  }
> =20
> +static unsigned int damon_merge_score(struct damon_region *r, bool last,
> +		struct damon_ctx *ctx, bool use_probe_hits)
> +{
> +	if (use_probe_hits)
> +		return damon_probe_hits_wsum(r, last, ctx);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code wrap around the 32-bit boundary when large weights are used?

Looking at damon_probe_hits_wsum(), it accumulates probe_hits[i] * probe->w=
eight
into a 32-bit unsigned int sum:

mm/damon/core.c:damon_probe_hits_wsum() {
    ...
    unsigned int sum =3D 0;
    ...
        if (last)
            sum +=3D r->last_probe_hits[i++] * probe->weight;
        else
            sum +=3D r->probe_hits[i++] * probe->weight;
    ...
    return sum;
}

If a user configures a large weight (e.g., > 16,843,000) for a probe via
sysfs, this could wrap around (e.g., 255 hits * 40,000,000 weight =3D 10.2
billion, which wraps to ~1.6 billion).

Could this break the scoring mechanism, causing damon_merge_regions_of() to
merge active and inactive regions incorrectly?

> +	if (last)
> +		return r->last_nr_accesses;
> +	return r->nr_accesses;
> +}
> +

[ ... ]

> @@ -3238,24 +3253,37 @@ static void damon_merge_regions_of(struct damon_t=
arget *t, unsigned int thres,
> -				   unsigned long sz_limit)
> +		unsigned long sz_limit, struct damon_ctx *ctx)
>  {
>  	struct damon_region *r, *prev =3D NULL, *next;
> +	bool use_probe_hits =3D damon_has_probe_weights(ctx);
> =20
>  	damon_for_each_region_safe(r, next, t) {
> -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> +		unsigned int score, last_score;
> +
> +		score =3D damon_merge_score(r, false, ctx, use_probe_hits);
> +		last_score =3D damon_merge_score(r, true, ctx, use_probe_hits);
> +
> +		if (abs(score - last_score) > thres)
                   ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Can this call to abs() cause incorrect results due to silent overflow?

Since score and last_score are unsigned integers, abs(score - last_score)
casts the unsigned difference to a signed int.

If the actual difference exceeds the maximum signed integer value, it wraps
to a negative value, which abs() then negates into a smaller positive value.

Could this falsely small difference cause the threshold check > thres to fa=
il
incorrectly, allowing vastly different regions to be merged and affecting t=
he
accuracy of the monitor?

>  			r->age =3D 0;
> -		else if ((r->nr_accesses =3D=3D 0) !=3D (r->last_nr_accesses =3D=3D 0))
> +		else if ((score =3D=3D 0) !=3D (last_score =3D=3D 0))
>  			r->age =3D 0;
>  		else
>  			r->age++;
> =20
> -		if (prev && prev->ar.end =3D=3D r->ar.start &&
> -		    abs(prev->nr_accesses - r->nr_accesses) <=3D thres &&
> -		    damon_sz_region(prev) + damon_sz_region(r) <=3D sz_limit)
> -			damon_merge_two_regions(t, prev, r);
> -		else
> -			prev =3D r;
> +		if (!prev)
> +			goto set_prev_continue;
> +		if (prev->ar.end !=3D r->ar.start)
> +			goto set_prev_continue;
> +		if (abs(damon_merge_score(prev, false, ctx, use_probe_hits) -
> +					score) > thres)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^

[Severity: High]
Does this second use of abs() on the unsigned difference of the merge scores
suffer from the exact same signed-integer overflow vulnerability?

> +			goto set_prev_continue;
> +		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
> +			goto set_prev_continue;
> +		damon_merge_two_regions(t, prev, r);
> +		continue;
> +set_prev_continue:
> +		prev =3D r;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706141912.8844=
5-1-sj@kernel.org?part=3D7
