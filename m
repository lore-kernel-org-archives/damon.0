Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC82C9D
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285863; cv=none; b=Ts8mivODccqxc+NdKmseCRH6v0nzNfktm+7gXlqbNbmepiL4lpCoXUbxwaRdJclrpqCrEQL4tZarPav+ba/3gFq/i1FWTSEc0mrePyvQZuZngMddFUvT8oGsNUI1yS0zM1TW3KcJTiqUFYEWgUwGeYYnJxQf08WV6YXnYQR8BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285863; c=relaxed/simple;
	bh=PjMrbxd8RO6Jzb7ddSJfJYSDpV7Lfv/VDXQaHNu9VMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuyIZ5E+scFR8f6nwnVNR1YbuWmlIepQbW0Wx03zB/cjYadw0L5zqf3GtT+xvYcmj10BPpKucyq0gJLe3PqLS21w7Pm4SbM+VgbspuePuolxNIS7QqftWVz40EA/NaOS6Ry8Kv9dtINq/nG8/UyllTHWGwSRdvk1DNQvDvOnywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjo6lsa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjo6lsa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F061F000E9;
	Sun,  5 Jul 2026 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285862;
	bh=4eEfryR31RkDgiF8fzKXv8ff0CSKi4XaF9ryPG88y+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wjo6lsa1z8b2gKTP7gwBkNmqsdUsV/mA0PWpvT7FKHk5DBoG+PaS3wqeDdxefikLH
	 89LcnyfoEk9FhNxs6ZMrtQup4GwXWI7uH3C+wdpifP4vYye1tgX5/yJKqdh5gmHoW8
	 cuzsKkeZKMbgixm0rFPXqGnZ8+FOfGLVcdD1rSWiNBgc2Al2tyee7N62sEgqUuU8uI
	 iwJq+hvJVffw9u1Nr4rJE+HqYYHlxYKQu10JLhNNHtY6PDzXnEqm6QMgkEE9n4gWCF
	 OVrJFeP9bTl3i9tlrqBxDyM+nzFm/vKBMRD4HX8cCiqEGsj/kS6sQsFF1hflXKUPul
	 PfVUmgmLX0FCA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/16] mm/damon/core: extend merge function to work
 with probe hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-8-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:11:01 +0000
Message-Id: <20260705211101.F2F061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Incompatible scale and domain mismatch between weighted scores and=
 unweighted merge thresholds.
- [High] Unsafe use of `abs()` macro on large unsigned integer score differ=
ences causes silent signed integer overflow.
- [Medium] Calculating the weighted sum of probe hits in `damon_probe_hits_=
wsum` can easily overflow a 32-bit `unsigned int`.

Pre-existing issues:
- [High] Weighted average calculations in `damon_merge_two_regions` silentl=
y overflow 32-bit `unsigned long` on 32-bit architectures.
--

commit 54d6e0bb9900e63a1a016ffee9632b6aa602175b
Author: SJ Park <sj@kernel.org>

mm/damon/core: extend merge function to work with probe hits

This commit extends damon_merge_regions_of() to consider the weighted sum
of probe hits when calculating regions to merge, introducing
damon_has_probe_weights() and modifying the scoring logic to use these weig=
hts.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c370eaff5795d..f6e03746b170e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3187,6 +3192,16 @@ static void damon_merge_two_regions(struct damon_t=
arget *t,
>  	damon_destroy_region(r, t);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can the weighted average
calculations in damon_merge_two_regions() silently overflow a 32-bit
unsigned long on 32-bit architectures?

On 32-bit architectures, sz_l is a 32-bit unsigned long.

If the region size is large (e.g., hundreds of megabytes), multiplying sz_l
by nr_accesses or probe_hits could exceed the 4.29B maximum of a 32-bit
integer, corrupting the merged region's statistics.

mm/damon/core.c:damon_merge_two_regions() {
...
	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
...
	for (i =3D 0; i < DAMON_MAX_PROBES; i++)
		l->probe_hits[i] =3D (l->probe_hits[i] * sz_l + r->probe_hits[i]
				* sz_r) / (sz_l + sz_r);
...
}

> +static unsigned int damon_merge_score(struct damon_region *r, bool last,
> +		struct damon_ctx *ctx, bool use_probe_hits)
> +{
> +	if (use_probe_hits)
> +		return damon_probe_hits_wsum(r, last, ctx);

[Severity: Medium]
Can the multiplication in damon_probe_hits_wsum() overflow a 32-bit
unsigned int?

probe->weight is an unsigned int.

If users supply a large weight, multiplying it by r->probe_hits[i] (which c=
an
be up to 255) might exceed UINT_MAX, causing the sum to wrap around and yie=
ld
artificially small scores for highly active regions.

mm/damon/core.c:damon_probe_hits_wsum() {
...
		if (last)
			sum +=3D r->last_probe_hits[i++] * probe->weight;
		else
			sum +=3D r->probe_hits[i++] * probe->weight;
...
}

> +	if (last)
> +		return r->last_nr_accesses;
> +	return r->nr_accesses;
> +}
> +
>  /*
>   * Merge adjacent regions having similar access frequencies
>   *
> @@ -3195,24 +3210,37 @@ static void damon_merge_two_regions(struct damon_=
target *t,
>   * sz_limit	size upper limit of each region
>   */
>  static void damon_merge_regions_of(struct damon_target *t, unsigned int =
thres,
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

[Severity: High]
Does the use of abs() here cause a silent signed integer overflow for large
unsigned differences?

The macro abs() implicitly casts an unsigned int to a signed int.

If the mathematical difference between score and last_score exceeds INT_MAX
(which might happen with large user-defined probe weights), the cast wraps =
to
a negative number.

The abs() macro then negates it into an artificially small positive integer,
which could cause the code to incorrectly bypass the > thres check and merge
regions with vastly different access profiles.

[Severity: High]
Is there a domain mismatch between the weighted score differences and the
unweighted thres parameter?

When use_probe_hits is true, the score is a weighted sum derived from probe
hits and user-defined weights. However, thres operates in the unweighted ac=
cess
frequency domain.

This mismatch appears to carry over to kdamond_merge_regions(), where max_t=
hres
is also scaled in the unweighted domain (aggr_interval / sample_interval).

Because weighted scores operate in a different numerical domain, could they
easily exceed max_thres, forcing the merge loop in kdamond_merge_regions() =
to
terminate prematurely?

mm/damon/core.c:kdamond_merge_regions() {
...
	max_thres =3D c->attrs.aggr_interval /
		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
	do {
...
		threshold =3D max(1, threshold * 2);
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
...
}

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

[Severity: High]
Does this abs() usage also suffer from the same silent signed integer overf=
low
as mentioned above when comparing large unsigned score differences?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D7
