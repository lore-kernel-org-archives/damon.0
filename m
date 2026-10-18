Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E109411FBB
	for <damon@lists.linux.dev>; Sun, 18 Oct 2026 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361621; cv=none; b=jaAyf4vbiAnRxWhus3YH6m7P10IVPRgs+u77oM+y5yROyltVfpR9w5WhyrOy4SBUiitm1tSkh1TfMoyPP6X0LhDjYNLld3GvePZ1DhjPjQKeIn+hWoS1D6FbJSKshyCQ+IFgMzYJV4+utS9FXkX05N/CYCXqC5lcMahBS/KNmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361621; c=relaxed/simple;
	bh=rENQA/onE+2G6MHB966q0pG3pqHdsR2kTS5AWxLHXUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1dZIwPX8BKJYgl2we4XsG7pmmEaMJNVWn9kZWQytSdKJRU3cF7rY+A1XB2Wv+AUes48BrveaMQWugOT1YzwAllx4aHajekqqP+n4f5yIxUzOVoUwpVASNhmLiU4w4a1n6jYxwvcArxOCLrQEg2Pj6SHcd1sANIsrY6HACOMKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuASiBCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuASiBCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962B51F000C4;
	Sun, 18 Oct 2026 22:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792361619;
	bh=g1ox3F3vY0udjg1jNOYHLcMDmNuqPu327im69Kd+WlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HuASiBCMB0bQyh2+ueLSuaAWt4A9220/zXe5IvoBS28/Um4p6RspWEEGZpYxWlmFt
	 sOYWpsVy8xFQJBLtNCcT30hy0XUR9Vhsglho5WLN2WZJ5t4q6suaE9qX0rdh9hT6a7
	 +pk3zMBr2mHYlZ9qUePVgmsC9PKDXQuF4aG5t0xMtBsSlPB8hJGFPTuMkQK3tb2vQo
	 n0r6k+bLe1r4w6wwb+GqirnMOs3nefIbvDIta+LMTsURKA+nPGNhdxFIpcFL9oLnx8
	 XclIush3QgtCvi16GI1IEcHyoky0lRZ46P+h4VAotzFIcxfXldZ/Fc/lFVSvmD5C4b
	 32+YB4CZpLTLA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/core: filter out damos address filter-split failed region
Date: Sun, 18 Oct 2026 15:13:31 -0700
Message-ID: <20261018221332.158824-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-176425@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 18 Oct 2026 22:11:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon: unchecked damon_split_region_at() error in damos_filter_match()
> --
> 
> commit 881e287348e01011e3ec5442e7deb6f9c112db9c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: filter out damos address filter-split failed region
> 
> This commit updates damos_filter_match() and damos_core_filter_out() to
> propagate errors from damon_split_region_at() and filter out the region if
> splitting fails during DAMOS_FILTER_TYPE_ADDR evaluation.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b63e60ef89901..4d34587387456 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2551,13 +2551,14 @@ static void damos_update_stat(struct damos *s,
> >  
> >  static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  		struct damon_region *r, struct damos_filter *filter,
> > -		unsigned long min_region_sz)
> > +		unsigned long min_region_sz, int *err)
> >  {
> >  	bool matched = false;
> >  	struct damon_target *ti;
> >  	int target_idx = 0;
> >  	unsigned long start, end, wsum;
> >  
> > +	*err = 0;
> >  	switch (filter->type) {
> >  	case DAMOS_FILTER_TYPE_TARGET:
> >  		damon_for_each_target(ti, ctx) {
> > @@ -2588,7 +2589,9 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  			break;
> >  		}
> >  		/* start inside the range */
> > -		damon_split_region_at(t, r, end - r->ar.start);
> > +		*err = damon_split_region_at(t, r, end - r->ar.start);
> > +		if (*err)
> > +			return false;
> >  		matched = true;
> >  		break;
> 
> [Severity: Medium]
> Should the earlier damon_split_region_at() call in damos_filter_match()
> when r->ar.start < start also propagate its return value via *err?
> 
> mm/damon/core.c:damos_filter_match() {
> 	case DAMOS_FILTER_TYPE_ADDR:
> 		...
> 		/* start before the range and overlap */
> 		if (r->ar.start < start) {
> 			damon_split_region_at(t, r, start - r->ar.start);
> 			matched = false;
> 			break;
> 		}
> }
> 
> When a region starts before the filter range and overlaps it (r->ar.start <
> start and r->ar.end > start), if damon_split_region_at(t, r, start -
> r->ar.start) fails with -ENOMEM, r remains unsplit across [r->ar.start,
> r->ar.end) while matched is set to false and *err remains 0.
> 
> If the filter is configured to exclude [start, end) (for example,
> filter->matching == true and filter->allow == false with
> s->core_filters_default_reject == false, or filter->matching == false and
> filter->allow == true), kdamond_apply_schemes() -> damos_apply_scheme() ->
> damos_core_filter_out() sees err == 0, does not reject r, and proceeds to
> call c->ops.apply_scheme() on the entire unsplit region including the
> excluded address range.

Good catch.  I will fix this in the next revision.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261018220253.158238-1-sj@kernel.org?part=1


Thanks,
SJ
