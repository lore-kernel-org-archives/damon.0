Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDD30F80C
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347522; cv=none; b=KpLHj4iONteSkLjECC/xF9wDSP5v3986yQvM1VoTyrn8Tpi0tWoSfvnZw3i1SPlgOu73f74Z7r5bLps+kyCAmaHCkzDUCmhjQ+AZM9GsrXhAO33on2vjqUTUqDiMr0fY8ERd5nYxQL8KZrqtIcwnJ3sUZNkaYgnSvyqbGygX3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347522; c=relaxed/simple;
	bh=xZRWyxUYoyVcQ+K5RE5wqSVo1eXkApxF0KXsq4Jrmqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXCb/Mi1M9QWbXAYybIxod+4lt04BaC7sih+RLfd1iAQMa5Ffk5bn4xI0kxvKyInfp0kjj/eLdV+cKihMvqIL2gnZPOqMwODHnpFjp5TaUNMSKSFHS9/wmWticvko5Fw4ZircF9EbmMlNbvhrGSFQb0dlxYyj81Wnn7YydnQfFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6etuKND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6etuKND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95B2C2BCAF;
	Tue, 28 Apr 2026 03:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777347521;
	bh=xZRWyxUYoyVcQ+K5RE5wqSVo1eXkApxF0KXsq4Jrmqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6etuKND8ROFT8yNeJGxg6Wkhx5xLa7pOfs36k7ITWKpgVUHEDExQMyi21LZRL6eU
	 aZBvwXLAnjVuRtSivIXeK1buvhW7zWyCCVssDZkh/eDUKBdojqa17oDPSaSliBc4Mk
	 NfEmR04djeVE8wkW6KPoMKhs1mkdFUX4FJaBlmGDca50VqzxjheeRnrAw5K77q053y
	 yjXLjT5Ec+XHYMxiJNS6Y/PUvcnphQHIU0fU4SK1UQj4uxYBSvng0xyJv2svBpFSHa
	 25+C2GaxtjMEo9Qe4+HXLj5GTuxJHhVl3gHJFigM8ZCl1lbl7jqn3dWy2ieIPkrqho
	 2ZTVrLnCucW5w==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Mon, 27 Apr 2026 20:38:32 -0700
Message-ID: <20260428033833.115866-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428030059.18A2EC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 03:00:58 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 2 potential issue(s):
> - [High] Pathological region fragmentation causing catastrophic CPU overhead when actions fail.
> - [Medium] Silent 32-bit integer overflow in `mult_frac()` for unbounded charge ratio parameters.

No blocker in my opinion.  Please read below for details.

> --
> 
> commit 4805d0ecef06fc0ab3681758cf2d692b37ed9b70
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> This commit introduces a mechanism to charge action-failed memory at a
> different ratio than action-successful memory. It allows API callers to
> specify the ratio flexibly by setting a numerator and denominator for the
> failed region charge rate.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 19ec9919b5ca..87cd4f0d14f3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2046,6 +2048,23 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
> >  	mutex_unlock(&ctx->walk_control_lock);
> >  }
> >  
> > +static void damos_charge_quota(struct damos_quota *quota,
> > +		unsigned long sz_region, unsigned long sz_applied)
> > +{
> > +	/*
> > +	 * sz_applied could be bigger than sz_region, depending on ops
> > +	 * implementation of the action, e.g., damos_pa_pageout().  Charge only
> > +	 * the region size in the case.
> > +	 */
> > +	if (!quota->fail_charge_denom || sz_applied > sz_region)
> > +		quota->charged_sz += sz_region;
> > +	else
> > +		quota->charged_sz += sz_applied + mult_frac(
> > +				(sz_region - sz_applied),
> > +				quota->fail_charge_num,
> > +				quota->fail_charge_denom);
> 
> Can this silently overflow on 32-bit architectures?
> 
> The mult_frac(x, n, d) macro evaluates (x / d) * n + (x % d) * n / d. Since
> sz_region is unsigned long, on 32-bit systems the intermediate remainder
> (x % d) is a 32-bit integer. The variables fail_charge_num and
> fail_charge_denom are declared as unsigned int and could be set to
> arbitrarily large values (up to UINT_MAX) without bounds checking. 
> 
> If large inputs are provided, does the (x % d) * n multiplication silently
> wrap around before division, causing an incorrectly small charged amount
> and undermining the quota enforcement?

Yes, the overflow could happen, but the user impact should be negligible.  The
user could also set addr_unit accordingly.  Let's keep this as is for now.  We
can revisit if this becomes a real issue.

> 
> > +}
> > +
> 
> [ ... ]
> 
> > @@ -2116,7 +2135,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		ktime_get_coarse_ts64(&end);
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> > -		quota->charged_sz += sz;
> > +		damos_charge_quota(quota, sz, sz_applied);
> 
> Could this cause pathological region fragmentation and massive CPU overhead
> if the action fails?
> 
> Earlier in damos_apply_scheme(), if the remaining quota is small, the
> region is split to fit:
> 
> 	if (damos_quota_is_set(quota) &&
> 			quota->charged_sz + sz > quota->esz) {
> 		sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
> 				c->min_region_sz);
> 		if (!sz)
> 			goto update_stat;
> 		damon_split_region_at(t, r, sz);
> 	}
> 
> If the action then fails, sz_applied could be 0. When damos_charge_quota()
> is called, if fail_charge_num is also small or 0, charged_sz doesn't
> increase by sz. This leaves the remaining quota unchanged. 
> 
> In the next iteration, the remainder of the previously split region is
> processed. Since the remaining quota is exactly the same, it calculates the
> same sz and splits the region again. This process repeats, dividing the
> entire remaining address space into tiny min_region_sz chunks, potentially
> triggering millions of loops and pegging the kdamond thread at 100% CPU.

Sashiko's analysis is correct.  But the user impact is expected to be minimal.
That's because the region split is not expensive.  It is anyway supposed to be
much smaller than the successful DAMOS action.  Also the second patch of this
series prevented unconditionally increasing the number of regions in this
scenario.

And after all, the user should set the ratio based on the recommendation
(1/PAGE_SIZE), or after testing.  I think the user impact of this scenario
under the recommended configuration should be reasonable.


Thanks,
SJ

[...]
