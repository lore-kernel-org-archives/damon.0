Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F25223328
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645854; cv=none; b=IZllV3JvZa+5H27L/CIjLesSeZZb7/kHQDJ4EB8cQYEhMat2EEs6cxk2V4gNq1znVHqGmC/pwpFKtzswoHFSBcTXKJ2wJVvzofNIpPnJlLmXQy+0h39+7C8Y3ayETz6iTay5aYSL7itndjj5MxIddjQ+MMt9AdyVT+WiSNTbOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645854; c=relaxed/simple;
	bh=yi+aoMuPLMVBdmndZT1zZI1NwpsSPdAcYjm7aUOHTMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npVPnqUrbcCrPm/lyAb8sChvdcGOwljJFo6c5UXuuRbeUd2HdawgD6wGV/I7M4EX0yzCTDFbS9VXajuhFiooBzUIao7xacM8OBFF1pNF0mUkk9vXwiY2XnUOLz7mHw7vhv184dQhmbYPzYlmhXG4pA9z7WS1AKKjsJg7SeDbrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvG16zD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvG16zD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0631F000E9;
	Fri, 10 Jul 2026 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783645852;
	bh=308eRtx+fCgMcJGUoGoEvd8mLWkHacBAcD1Idda3YjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvG16zD5Qog9oVtqYbOyIfyAi2OQU6f8u0RqtZjiAyT75YFYjCxnoMgn1apHxdqLM
	 Z8ypIlMdtnUGYgY/pc8pPEa4WofUYoYLHJgKWDdoMFjWTePnn/rwv583NQQVqNjQon
	 BlUc/hFSEMJML4WH0h+Kp1K+nehSnNId1RiLCmFxx2fHv6JdbsfVD+HUYp6CXSU6j2
	 6mJNidfqq5VvfS6369eLF0MEZHJulRjP/Sjavhgi4ipDwYA3UwxtPSvFnSYk2A6JKi
	 eSn5GpPuFm39sGliZSbhqQoSY+h1M2NLGcHGt6fOa7UR7cqD2xZjdxjIxzlzQqcoZl
	 ODS9xL/VcknYQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 14/19] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Thu,  9 Jul 2026 18:10:44 -0700
Message-ID: <20260710011045.113001-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710003840.32C011F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 00:38:39 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Premature termination of regions merging when using probe weights, breaking `max_nr_regions` enforcement.
> --
> 
> --- Patch [14]: [RFC PATCH v1.3 14/19] mm/damon/core: get merge threshold from probe hits when weights are set ---
> commit c2e77863ffba068b4f2b7db5f45690d846ec2ad7
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: get merge threshold from probe hits when weights are set
> 
> This commit updates DAMON to calculate the merge threshold based on the
> maximum probe hits weighted sum when probe weights are used. It updates
> kdamond_fn() to retrieve this max sum via the apply_probes() callback.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f7782c69037da..91964336ce31e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
> >  
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_merge_score = ctx->ops.check_accesses(ctx);
> > -		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx, access_check_disabled,
> > -					false);
> > +		if (ctx->ops.apply_probes) {
> > +			if (time_after_eq(ctx->passed_sample_intervals,
> > +						next_aggregation_sis) &&
> > +					access_check_disabled)
> > +				get_max_wsum = true;
> > +			else
> > +				get_max_wsum = false;
> > +			max_wsum = ctx->ops.apply_probes(ctx,
> > +					access_check_disabled, get_max_wsum);
> > +			if (get_max_wsum)
> > +				max_merge_score = max_wsum;
> 
> [Severity: High]
> Does this regression break the max_nr_regions enforcement in
> kdamond_merge_regions()?
> 
> When probe weights are set, max_merge_score is derived from the user-provided
> probe weights and passed as the initial threshold to kdamond_merge_regions():
> 
> mm/damon/core.c:kdamond_merge_regions() {
>     ...
>     max_thres = c->attrs.aggr_interval /
>         (c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
>     do {
>         ...
>         threshold = max(1, threshold * 2);
>     } while (nr_regions > c->attrs.max_nr_regions &&
>             threshold / 2 < max_thres);
>     ...
> }
> 
> However, max_thres is hardcoded to the maximum unweighted access frequency.
> 
> If the dynamically weighted max_wsum is large enough, the initial threshold
> passed to kdamond_merge_regions() could exceed max_thres * 2.
> 
> If that happens, wouldn't the loop terminate prematurely on the first pass
> even when nr_regions > max_nr_regions, allowing the number of regions to
> grow unboundedly?

No issue.  The later patch of this series will set max_thres with weighted sum.

> 
> > +		}
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710002349.111414-1-sj@kernel.org?part=14


Thanks,
SJ
