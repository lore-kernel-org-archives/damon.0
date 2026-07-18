Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57667083C
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394059; cv=none; b=ruGrEKIyFRsiiGR53rhC+f8tWJpGunaCcXs6fBdjiOqBJVVGl2aoeBFjFuFywW9Aw73xFlZQkncJwEs9bm+oAs5G8UX17xY75Um9XfPiTBJYP6pmLNkcg+hmXO415MHq407UA/BYPLNDkFzyz+xP/UuXdJTBwkOb8tsTU3mtcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394059; c=relaxed/simple;
	bh=7DJ66MxMoACpFJIm+bIaUHbFk8Ax4y6PqJDhFXvhEWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mb071wJT9qembWClB72BYR/9XMIW+s90uXsmYTBUA3+s7spevl+vQeroAMv80vrhVU+TaAUXQZcjZj88moorb2O2LWXeMGY32lHS2Vdsufr90Q3Ssp5z8W2HjGEPQKi5ogXVFcRIl5VijpvgI3M96JwGGipXh7NGuH3j3rrajQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaPDj4DO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaPDj4DO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B1A1F000E9;
	Sat, 18 Jul 2026 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784394058;
	bh=RyckOdfLEo1TMP/sXO3YMuL4axfjyDagAnckSjHZb+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oaPDj4DOWq2w12YexlEbZChf9YraKb0i4BZmd+C7BCUiFIV0p9enF7FIUKSBqhc/F
	 PgyZZqbK6sQbxd8DvC4gaOFPOytfPtXwwnzIaMH8bmWdaJkWzCfjjfHjSEtSZm9xSz
	 0riEwTockyby4N8zAme6HygP2jOid7cCXgCThy1IABTjpVicZoj8rRTsuPWDGZylC+
	 lZsPTy+JdzkUNxBBT50xeKCOBwzZHx7kAWOiBV+cvf+acAsTpztI1Df+OSEJ2nmcOU
	 MS3eYT3LDXSOgBhfNpT1a+TgMAiRXyJkFTiHbpwQAhIu5jux4wyqvlVacZ8CNrNZjs
	 n0GQhaDVmyCCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: handle region split failure in
 apply_min_nr_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260718163708.84113-1-sj@kernel.org>
References: <20260718163708.84113-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 17:00:57 +0000
Message-Id: <20260718170058.66B1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete bug fix in damon_apply_min_nr_regions() leads to O(N^2)=
 allocator thrashing on allocation failure.
- [High] Silent failure of damon_split_region_at() bypasses DAMON quotas an=
d bounds checks.
--

--- Patch [1]: [PATCH] mm/damon/core: handle region split failure in apply_=
min_nr_regions() ---
commit 51e7e9012c52dde83bac4be44f0bbfbdbe01572d
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: handle region split failure in apply_min_nr_regions=
()

damon_apply_min_nr_regions() repeatedly split each region until its size
becomes small enough to meet the user-defined low limit of the number of
regions. The loop assumes the split operation (damon_split_region_at())
will always succeed and create the new region.

Link: https://lore.kernel.org/20260717011834.120715-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 20d267c615faf..3d829e0ad63b5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1913,6 +1913,9 @@ static unsigned long damon_apply_min_nr_regions(str=
uct damon_ctx *ctx)
>  		damon_for_each_region_safe(r, next, t) {
>  			while (damon_sz_region(r) > max_region_sz) {
>  				damon_split_region_at(t, r, max_region_sz);
> +				/* split might failed */
> +				if (r =3D=3D damon_last_region(t))
> +					break;

[Severity: High]
This isn't a bug introduced by this patch, but does this fix leave an
O(N^2) allocator thrashing loop when an allocation fails on a non-last
region?

If a region fails to split due to memory pressure and is not the last
region, the inner loop unconditionally advances r =3D damon_next_region(r).
This moves to the next pre-existing region instead of a newly created
one, and the inner loop will attempt to split this next region, continuing
to the end of the list.

Then, the outer damon_for_each_region_safe() loop advances to its
pre-saved next pointer and repeats the entire process.

Could this severely thrash the page allocator with redundant
kmem_cache_alloc() calls and cause RCU stalls or lockups during an
OOM condition?

[Severity: High]
This is also a pre-existing issue and was not introduced by this patch, but
since we are handling split failures here, could the silent failure of
damon_split_region_at() bypass DAMON quotas in other callers?

Because damon_split_region_at() returns void, callers like
damos_apply_scheme() cannot detect if the split failed:

mm/damon/core.c:damos_apply_scheme() {
...
			damon_split_region_at(t, r, sz);
		}
		if (damos_core_filter_out(c, t, r, s))
			return;
...
		sz_applied =3D c->ops.apply_scheme(c, t, r, s,
				&sz_ops_filter_passed);
...
		damos_charge_quota(quota, sz, sz_applied);
}

If the split fails, the region remains oversized and the scheme is
erroneously applied to the entire original region.

The quota charging logic then only charges the intended small size (sz),
which permanently hides the limit bypass.

Could this cause DAMON schemes to violate their strict resource quota
limits and apply actions to much larger memory areas than permitted?

>  				r =3D damon_next_region(r);
>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718163708.8411=
3-1-sj@kernel.org?part=3D1
