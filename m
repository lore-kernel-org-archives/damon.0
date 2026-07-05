Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7DC36923B
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285930; cv=none; b=doTjnnpCULlwTk0mC4gKwRZ6n0M6SEuHMN8IMjW4rlu8ES2qB3O/6K6ErWQAF4AD0qIDk4dDjn3OUHk193bj6Tz66WeCfsiWqqhu+4a+CQpu9wOni5iX72kF40OTl0Fj6HjWJUqx+oZWeP3n+e/XznTjssDNQrU8POyDbimZaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285930; c=relaxed/simple;
	bh=f/2opiqzzWIs13J9f9P3/L/NjD6vIldNT5i2hujJNZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EX6oAMQBG+2JbDbbOUB97ZRrNoUAnY53kZ9hHNvuuBq+3wGU97EHEYBL56+W338jFr6liXELeNRHCL2FT0sob3T67MgSh1gPJy3eiyaKTAScIk5LKBADTd00nQv3gM0NW3R3DeRp7DDzdjgGa4mId6pdnpSQ8Jrt0gcNq7ju1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVRVaToG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVRVaToG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006A71F000E9;
	Sun,  5 Jul 2026 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285929;
	bh=pllZ0aiJ3QftVXpdgkIKKU2XflzBWbhHsv1uAwdwIEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVRVaToGqI/Fl7D7UGMEs99koTD46YIP2wvCoeKvDncuYtp8QoDjuz3I66NL8vBah
	 2BJ0+b6R959G1a5w9y7TPe6RuOVkhXAXC6PluDtnQ9hlWn8kN69QdNSdnldxFC/irv
	 lXB/nDirxV5Cy4TxrIYxcVNQlfcFUq6vxOnFdatgjvstkgBWFqI1WXEndrGNI1Kry5
	 LpU/MZrLDKPTnBUrtl8mg5E+RmK960XNDzcqYlv7QM8Rsh1oRKd669SlAbL+V70I7I
	 j69RdyxlyJCrpdgjyK/TkjLc6fiZ9odG7NDFdYHj5CWhXS71hy1mpDPacMlBMf3F5M
	 +i9xUpYKKaf8w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/16] mm/damon/core: get merge threshold from probe
 hits when weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-12-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:12:08 +0000
Message-Id: <20260705211209.006A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The merge threshold limit (`max_thres`) in `kdamond_merge_regions`=
 is not scaled for probe weights, causing premature termination of the regi=
on merging loop and failing to enforce the user-defined `max_nr_regions` li=
mit.

Pre-existing issues:
- [High] When probe weights are configured for operations that do not imple=
ment `apply_probes` (e.g., `vaddr`), the merge threshold becomes 0 and regi=
ons are improperly and aggressively merged.
--

commit 23bf451408faae1b0a1f1eb841dc6f4b60077861
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: get merge threshold from probe hits when weights ar=
e set

When probe weights are set, DAMON merges regions based on their probe hits
weighted sum, but the merge threshold is calculated based on access frequen=
cy.
Update it to retrieve the maximum probe hits weighted sum in the snapshot f=
rom
the apply_probes() ops callback, and generate the threshold based on it.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bd6d836f1db5e..7a070cfb7cd1b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3683,9 +3684,18 @@ static int kdamond_fn(void *data)
> =20
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_merge_score =3D ctx->ops.check_accesses(ctx);
> -		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, access_check_disabled,
> -					false);
> +		if (ctx->ops.apply_probes) {
> +			if (time_after_eq(ctx->passed_sample_intervals,
> +						next_aggregation_sis) &&
> +					access_check_disabled)
> +				get_max_wsum =3D true;
> +			else
> +				get_max_wsum =3D false;
> +			max_wsum =3D ctx->ops.apply_probes(ctx,
> +					access_check_disabled, get_max_wsum);
> +			if (get_max_wsum)
> +				max_merge_score =3D max_wsum;
> +		}

[Severity: High]
This is a pre-existing issue, but what happens if a user configures probe
weights for operations that do not implement apply_probes (like vaddr)?

When damon_has_probe_weights() returns true, access checks are disabled. If
the operations lack an apply_probes callback, max_merge_score will remain 0.

Will this cause all regions to be improperly and unconditionally merged into
maximum-sized chunks, resulting in a loss of monitoring resolution?

[Severity: High]
Does kdamond_merge_regions() properly handle this new weight-based score li=
mit?

Just after this block, max_merge_score is passed into kdamond_merge_regions=
():

mm/damon/core.c:kdamond_fn() {
    ...
		if (time_after_eq(ctx->passed_sample_intervals,
					next_aggregation_sis)) {
			kdamond_merge_regions(ctx,
					max_merge_score / 10,
					sz_limit);
    ...
}

Because max_thres inside kdamond_merge_regions() is hardcoded to the maximum
possible frequency of unweighted accesses, rather than dynamically accounti=
ng
for probe weights, the scaling loop termination condition:

mm/damon/core.c:kdamond_merge_regions() {
	...
	} while (nr_regions > c->attrs.max_nr_regions &&
			threshold / 2 < max_thres);
	...
}

appears to instantly fail when the initial threshold is already large due to
probe weights.

Will this cause an early abort of the fallback loop, leaving regions unmerg=
ed
and failing to enforce the max_nr_regions limit?

> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D11
