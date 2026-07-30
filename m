Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335A312825
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374156; cv=none; b=sknenwwzDIJYAcKIQKv2Ip6S96IAyhKJDqby1qk0z5cgPXZHtlYgJ5r4p6UkwnEMZyuV2VT+2V2UMKgDjIGUqhzlnizMfpwa6A2JiXYZ00hwr5pzSESfwJ2gu8fDPhtcvw3T2sHUndqT8mEfKpnIB/5s8xFPQo06Wxs7LcmF1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374156; c=relaxed/simple;
	bh=TePSwM2PQqqLPNdgGf1q+waVTN8GGs5vA5PKDbBKYGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YU7DHP6CatpqAaR2GfrN8RRGoP4u6Sai49sxZXz7SWgCM81iWdLUMPxJCG03VjJ9zR4weqWASmy9zPM5EUmcUTRFrahoogDtHrmCSMX1Y+sy9Uy5efe1ztGQ9RVQsKD1rN+okAbFKuo918mbzaK5H4rRc8Za+3su//vwBSypGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzdYMHFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzdYMHFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972251F000E9;
	Thu, 30 Jul 2026 01:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374154;
	bh=Y0cdE7EWSSoRDbAJ3umaZDetYoT9gIjy7C9dAV41CFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzdYMHFPPGStjc1TacvSwph5Oq2aBdZdfqFmtHoqfUtLhJkpCzI2RgajNRkt3nu+l
	 EnaN52egtx0L8c7iZNYIKQjcX7V+EgE5riH6pU0ZyXF2f+MvPFAoGSYk/foEcSGRZZ
	 CM0Pu6qE2lxgsp/A4Ft7YGSa7wW2RbdkCjH9CAYRim3J4mEtaEehkuv/dc0Tv+BZ4G
	 fskj/E2a6oiehiI6YPIXQ41ldsLjN/qmQkWpWz8hFVRC3URXc6roMfr6pQ5kHjkwzI
	 eeg5vcrx+AO3eIm1t1+YjSjYGqAMxOWyQQsYpcnw8HdQPgktG189mkazlB7RLGfloX
	 UePiy7lfGi7xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: validate ranges in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260730005639.108842-1-sj@kernel.org>
References: <2026072900-emit-mortified-8331@gregkh>
 <20260730005639.108842-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:15:54 +0000
Message-Id: <20260730011554.972251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added validation check incorrectly uses alignment macros=
, allowing unaligned zero-length or inverted regions to silently bypass val=
idation.
- [Medium] The validation check unconditionally rejects valid monitoring ra=
nges ending near the top of the address space due to an integer overflow in=
 the ALIGN macro.

Pre-existing issues:
- [High] Alignment rounding combined with a flawed iteration loop creates o=
verlapping monitoring regions from valid, non-overlapping user inputs.
--

--- Patch [1]: [PATCH 6.12.y] mm/damon/core: validate ranges in damon_set_r=
egions() ---
commit b519271ef73c8bbed5092bcf809ea6bc504693b6
Author: SJ Park <sj@kernel.org>
Date:   Thu Jul 30 00:56:39 2026 +0000

mm/damon/core: validate ranges in damon_set_regions()
   =20
This commit attempts to validate regions in damon_set_regions() to reject=20
zero length monitoring target regions, which could previously trigger a=20
divide-by-zero or WARN_ONCE.

Link: https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7911599c37f22..7217bb2ef51ec 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -214,6 +214,12 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
> =20
> +	for (i =3D 0; i < nr_ranges; i++) {
> +		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=3D
> +				ALIGN(ranges[i].end, DAMON_MIN_REGION))
> +			return -EINVAL;
> +	}
> +

[Severity: High]
Does this validation logic allow unaligned zero-length or inverted regions
to bypass the check?

If a user configures an unaligned empty region (e.g., start =3D 4097,=20
end =3D 4097) via sysfs, ALIGN_DOWN evaluates to 4096 and ALIGN evaluates to
8192. The condition 4096 >=3D 8192 evaluates to false, which completely=20
bypasses the rejection of the invalid region.

[Severity: Medium]
Will this check unconditionally reject valid monitoring ranges ending near =
the
top of the address space?

If a caller specifies a monitoring region ending near ULONG_MAX, the
ALIGN(ranges[i].end, DAMON_MIN_REGION) operation could wrap around to 0.
This would cause the unsigned comparison ALIGN_DOWN(start) >=3D 0 to always
evaluate to true, resulting in a false positive -EINVAL rejection.

[Severity: High]
This is a pre-existing issue, but does alignment rounding combined with the
iteration loop create overlapping monitoring regions from valid,
non-overlapping user inputs?

mm/damon/core.c:damon_set_regions() {
    ...
    if (!first) {
        /* no region intersects with this range */
        newr =3D damon_new_region(
                ALIGN_DOWN(range->start,
                    DAMON_MIN_REGION),
                ALIGN(range->end, DAMON_MIN_REGION));
        if (!newr)
            return -ENOMEM;
        damon_insert_region(newr, damon_prev_region(r), r, t);
    } else {
    ...
}

If a user configures adjacent, non-overlapping unaligned ranges (e.g.,=20
start =3D 0, end =3D 4097 and start =3D 4098, end =3D 8192), ALIGN_DOWN and=
 ALIGN=20
expand these to [0, 8192] and [4096, 8192], which overlap.

Furthermore, because the loop cursor is not reset, intersection checks are=
=20
skipped for subsequent ranges once the list end is reached. Could this caus=
e=20
these overlapping regions to be blindly inserted, potentially corrupting=20
core data structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730005639.1088=
42-1-sj@kernel.org?part=3D1
