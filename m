Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA533A9DA
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607537; cv=none; b=Q/1WqEj/+IEs8ngKZgswwYik9sPpXyaKDQ9UpLmlFwIRWtCCiTZqe8KQ4p9kJGb1a4GSeLyOPqTqkS3XGATD0Ah75hgdcJlUT2LSD+V/JtaEs5BJv2+OnOoTE7VmKrt7GTzECHGObHzFDD+bgap9MnR2lOmW8EjNMPYA0cplLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607537; c=relaxed/simple;
	bh=ttOf38l381BqEYbYmoetoiq9QcxQYKozxSaU7fOoRQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tio00pk/EvFMyRzZctn8atAiwEfhVugpBxAdXAsuUNKjnTt7BBhj7th7HSzAySa7FFfQ5R76bgnkhS09YFeu2z4fAbTns/NLHmiSNMNpSc6OTL4IxSG6sCeiKynFpl8/jI9RcCYLD31bClMWxKng5W8jChwKD6ApdftwlMGg8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBVNt4QX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBVNt4QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF61F000E9;
	Thu,  9 Jul 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607536;
	bh=bvV69kJ6/MvZKjLMig0Z0UiRD7JmXn+pF1TRpr1LNEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBVNt4QXSOVMn1AiUbeybfErmVSI7kZ0tFhL5ZP+8m/thNQrBtTCbrFK9stfzj3Uy
	 q8kdufuZACkHjVfd+qMmC1NiaQMXIG53UVTSoq/hu1S7GqSjXAOa8v8hkrP9pdTFck
	 Hsirsh6Fzjcvg0uOjSGL5DPXLkwIq4/gk7vlKAx2rxnvQKzsBhqqNpo1PMYxWyUCBT
	 imUncpTGgakndbrVgHtjmpT8mc6PeFAckM2DzioygbLT/n5D1XAetwu9N57KHpgYUT
	 2yKl0YWzRpY1QZ//t0rL2RZfsmrlmxlkziQtQLERZmH355tvgYee+VCqQb7ptfLdAJ
	 LXzzD2X9F44xA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 08/19] mm/damon/core: extend merge function to
 work with probe hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-9-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:32:15 +0000
Message-Id: <20260709143216.39DF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Region `age` is incorrectly updated multiple times per aggregation=
 interval and evaluated against a stale `last_score` when the `kdamond_merg=
e_regions` retry loop is triggered.
--

--- Patch [8]: [RFC PATCH v1.2 08/19] mm/damon/core: extend merge function =
to work with probe hits ---
commit 938ea22fc6c1fec3c909339503398aa70ea047c8
Author: SJ Park <sj@kernel.org>

mm/damon/core: extend merge function to work with probe hits

When probe weights are set, users may want DAMON monitoring results to
be optimized for the weights.  For that, regions adjustment should work
for the weighted sum of probe hits.  Extend damon_merge_regions_of() to
detect if the weights are set, and work with probe hits in the case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3256,24 +3271,38 @@ static void damon_merge_regions_of(struct damon_t=
arget *t, unsigned int thres,
> -				   unsigned long sz_limit)
> +		unsigned long sz_limit, struct damon_ctx *ctx)
>  {
>  	struct damon_region *r, *prev =3D NULL, *next;
> +	bool use_probe_hits =3D damon_has_probe_weights(ctx);
> =20
>  	damon_for_each_region_safe(r, next, t) {
> -		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
> +		unsigned int score, last_score, diff;
> +
> +		score =3D damon_merge_score(r, false, ctx, use_probe_hits);
> +		last_score =3D damon_merge_score(r, true, ctx, use_probe_hits);
> +
> +		if (abs_diff(score, last_score) > thres)
>  			r->age =3D 0;
> -		else if ((r->nr_accesses =3D=3D 0) !=3D (r->last_nr_accesses =3D=3D 0))
> +		else if ((score =3D=3D 0) !=3D (last_score =3D=3D 0))
>  			r->age =3D 0;
>  		else
>  			r->age++;

[Severity: High]
This is a pre-existing issue, but does this logic in damon_merge_regions_of=
()
incorrectly increment or reset r->age multiple times per aggregation interv=
al?

When the number of regions exceeds max_nr_regions, kdamond_merge_regions()=
=20
repeatedly calls damon_merge_regions_of() with doubled thresholds. During=20
these retries, r->age is incremented multiple times within a single=20
aggregation interval.

Furthermore, because damon_merge_two_regions() updates the current=20
nr_accesses and probe_hits but fails to merge their historical counterparts=
=20
(last_nr_accesses and last_probe_hits), these values become stale.

On subsequent iterations of the retry loop, damon_merge_score() computes=20
last_score using these stale unmerged values. This can cause=20
abs_diff(score, last_score) to spuriously exceed the threshold, resetting=20
r->age to 0 inappropriately.

Could this cause DAMOS age-based schemes to trigger prematurely or fail to=
=20
trigger entirely?

> -		if (prev && prev->ar.end =3D=3D r->ar.start &&
> -		    abs_diff(prev->nr_accesses, r->nr_accesses) <=3D thres &&
> -		    damon_sz_region(prev) + damon_sz_region(r) <=3D sz_limit)
> -			damon_merge_two_regions(t, prev, r);
> -		else
> -			prev =3D r;
> +		if (!prev)
> +			goto set_prev_continue;
> +		if (prev->ar.end !=3D r->ar.start)
> +			goto set_prev_continue;
> +		diff =3D abs_diff(score, damon_merge_score(prev, false, ctx,
> +					use_probe_hits));
> +		if (diff > thres)
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D8
