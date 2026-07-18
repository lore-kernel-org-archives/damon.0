Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6D3D5221
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394930; cv=none; b=YAGIlobcMQDiUFwvBbda67tt9kNIRoRpLhuDDozASBKijH4qBx0kzZz9K8RlLH+opgEo1oJ+VJQy6JL/EKlLPIp5ImcSrrpiLcnLeZnlsKi/T2Cldedq/MHbpF6OGr63B6P54J9I9GvK81HN6tkpj0f3V5G0Ath/Q33QijZdwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394930; c=relaxed/simple;
	bh=7qKkZUpzK5Z17vc2xWgf9UBAFwZdrz8iD8ETBsAxrj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6WVI2W61jtLbK90o5wGlURn1YbA9U9FowE2lcjCthOokGXKVlFpD42sCr6EzDl49Mmbpw0B9JloxPPt8iH9TRUcDfa+VWwkCb9LKklKKLZ/O4La8DJv+OCL7Taf+5+9iyOu1FpJtxK9l/FEoQpQj3s+zLhv3pxpf9XX3bdMH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRVcimv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRVcimv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9591F000E9;
	Sat, 18 Jul 2026 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784394929;
	bh=7Dov8cYchOJ2vpcxiDhZSqVa2TTsqQDY/WWJEP3CD1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRVcimv9SILbZLiZmYoKkAMXrKg4SAvg4kvIfFNM4CgUTBLAxYwA4FPKAXfGKde5a
	 ciaFBP/Tjantbs5FEn+uI2HyA3GzjLGAtkd2gMNnlEm1fvd89whyIqJ4CsSsVz+RrZ
	 nAil740R1zt7AIwwwDyLFLvTyY0vYIp4OWrVBL/rX6uSSb6RXVZwOGHWqIzKFKrLYL
	 NojWMrSkQM49MNcZ176FBzaRhH63dsfMhyrsR89kZjNMKIOh0ZgyXFo1WjqOAIBnAt
	 Rj/sXarAxSS2l/PsLKceHAm9eL0chXjkOXpmYCetPNApe9q1CKYKYF1gb2HoPG6ExN
	 E3Rxpvtm4UivA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Sat, 18 Jul 2026 10:15:21 -0700
Message-ID: <20260718171523.87547-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718170058.66B1A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 17:00:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete bug fix in damon_apply_min_nr_regions() leads to O(N^2) allocator thrashing on allocation failure.
> - [High] Silent failure of damon_split_region_at() bypasses DAMON quotas and bounds checks.
> --
> 
> --- Patch [1]: [PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions() ---
> commit 51e7e9012c52dde83bac4be44f0bbfbdbe01572d
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: handle region split failure in apply_min_nr_regions()
> 
> damon_apply_min_nr_regions() repeatedly split each region until its size
> becomes small enough to meet the user-defined low limit of the number of
> regions. The loop assumes the split operation (damon_split_region_at())
> will always succeed and create the new region.
> 
> Link: https://lore.kernel.org/20260717011834.120715-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 20d267c615faf..3d829e0ad63b5 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1913,6 +1913,9 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
> >  		damon_for_each_region_safe(r, next, t) {
> >  			while (damon_sz_region(r) > max_region_sz) {
> >  				damon_split_region_at(t, r, max_region_sz);
> > +				/* split might failed */
> > +				if (r == damon_last_region(t))
> > +					break;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this fix leave an
> O(N^2) allocator thrashing loop when an allocation fails on a non-last
> region?
> 
> If a region fails to split due to memory pressure and is not the last
> region, the inner loop unconditionally advances r = damon_next_region(r).
> This moves to the next pre-existing region instead of a newly created
> one, and the inner loop will attempt to split this next region, continuing
> to the end of the list.
> 
> Then, the outer damon_for_each_region_safe() loop advances to its
> pre-saved next pointer and repeats the entire process.
> 
> Could this severely thrash the page allocator with redundant
> kmem_cache_alloc() calls and cause RCU stalls or lockups during an
> OOM condition?

The allocation is arguably too small to fail.  And the while loop is supposed
to run only occasionally.  Most regions in most case would not exceed
max_region_sz.  But good call.  I will separately work on making this more
safe.

> 
> [Severity: High]
> This is also a pre-existing issue and was not introduced by this patch, but
> since we are handling split failures here, could the silent failure of
> damon_split_region_at() bypass DAMON quotas in other callers?
> 
> Because damon_split_region_at() returns void, callers like
> damos_apply_scheme() cannot detect if the split failed:
> 
> mm/damon/core.c:damos_apply_scheme() {
> ...
> 			damon_split_region_at(t, r, sz);
> 		}
> 		if (damos_core_filter_out(c, t, r, s))
> 			return;
> ...
> 		sz_applied = c->ops.apply_scheme(c, t, r, s,
> 				&sz_ops_filter_passed);
> ...
> 		damos_charge_quota(quota, sz, sz_applied);
> }
> 
> If the split fails, the region remains oversized and the scheme is
> erroneously applied to the entire original region.
> 
> The quota charging logic then only charges the intended small size (sz),
> which permanently hides the limit bypass.
> 
> Could this cause DAMON schemes to violate their strict resource quota
> limits and apply actions to much larger memory areas than permitted?

Good finding.  Seems not urgent and not related to this patch.  I will
separately work on this.

> 
> >  				r = damon_next_region(r);
> >  			}
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260718163708.84113-1-sj@kernel.org?part=1


Thanks,
SJ
