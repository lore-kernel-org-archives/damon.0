Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D010785
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287698; cv=none; b=UvnPUZqkyKiNelRMDcobhu3uXfMHG4bjQvv3TYvl8u0EWN12HHc3lgLcUeM7u1OkhetyMolGOvNJax8SJPckDf+5LJd9nHE5mgPO+9F8Wcc4JpNSnRa0p+PdNWw/zJujfrOybmGpy4eAQvfaURulwrRYORAeRWYWjIeF31ohONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287698; c=relaxed/simple;
	bh=hsCeua9muYuqEo5o+fU9vKW2/8qIGfqmqOzIhULBGB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaegCpQ4j/qc9812Dc2mYJwaM620b/4qEMd3qBGG37Kwx9/whqA4+UzsUhYW3JK4Ba5i88Om4qfkOxLbK1q5YehZXnXozSPZEpwI6UYSsbPVI0ezR41+5bp9XA4eM5TGI9QadwREHIUMT8YM0Dt0b15epPaW+AAZX2ek7hXJ070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBOhOkZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBOhOkZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ED11F000E9;
	Sun,  5 Jul 2026 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783287697;
	bh=oAZioff60Wmyk2Sh+9DJNh61SY1UxO7PWwr3phn7YyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZBOhOkZP8LyqET1VWqMPhqvvhSVRAyPkCiYS0UpZ6EBpJuSxZrbw0k9zzYWh+4xqb
	 j3tFYGBaiM3BeHLte77H0BYp8PfSV2Oyxfgp9DCM1y6phOvSo5gdIdJb0gCuHGxIgj
	 god3NBS+5X4H1oZ0+UlvWG6W6gHPFiqFFJPnIN/DcoEi8/w9zD7sUxFoFrwsDLrmvE
	 OSG82tVteLCo3WOaAt1hTarK1fnWZJHzY+/BD4AIbtdjv582AZpEZorUUczveiz0bI
	 CnWvNAiJnUCDCZr0r9NJC6tDZUy8Aw4E0Anu5fJ5UNUSIfLSpfshJLCOAms0Q0fnf0
	 uQ8N7HhRC97jw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 11/16] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Sun,  5 Jul 2026 14:41:33 -0700
Message-ID: <20260705214134.100986-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705211209.006A71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:12:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The merge threshold limit (`max_thres`) in `kdamond_merge_regions` is not scaled for probe weights, causing premature termination of the region merging loop and failing to enforce the user-defined `max_nr_regions` limit.
> 
> Pre-existing issues:
> - [High] When probe weights are configured for operations that do not implement `apply_probes` (e.g., `vaddr`), the merge threshold becomes 0 and regions are improperly and aggressively merged.
> --
> 
> commit 23bf451408faae1b0a1f1eb841dc6f4b60077861
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: get merge threshold from probe hits when weights are set
> 
> When probe weights are set, DAMON merges regions based on their probe hits
> weighted sum, but the merge threshold is calculated based on access frequency.
> Update it to retrieve the maximum probe hits weighted sum in the snapshot from
> the apply_probes() ops callback, and generate the threshold based on it.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index bd6d836f1db5e..7a070cfb7cd1b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3683,9 +3684,18 @@ static int kdamond_fn(void *data)
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
> > +		}
> 
> [Severity: High]
> This is a pre-existing issue, but what happens if a user configures probe
> weights for operations that do not implement apply_probes (like vaddr)?
> 
> When damon_has_probe_weights() returns true, access checks are disabled. If
> the operations lack an apply_probes callback, max_merge_score will remain 0.
> 
> Will this cause all regions to be improperly and unconditionally merged into
> maximum-sized chunks, resulting in a loss of monitoring resolution?

Correct, and that's no problem.  Users who wrongly configured DAMON get poor
output.  As long as no critical consequences like kernel crash or memory leaks
happen, I believe this is fine.

> 
> [Severity: High]
> Does kdamond_merge_regions() properly handle this new weight-based score limit?
> 
> Just after this block, max_merge_score is passed into kdamond_merge_regions():
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
> 		if (time_after_eq(ctx->passed_sample_intervals,
> 					next_aggregation_sis)) {
> 			kdamond_merge_regions(ctx,
> 					max_merge_score / 10,
> 					sz_limit);
>     ...
> }
> 
> Because max_thres inside kdamond_merge_regions() is hardcoded to the maximum
> possible frequency of unweighted accesses, rather than dynamically accounting
> for probe weights, the scaling loop termination condition:
> 
> mm/damon/core.c:kdamond_merge_regions() {
> 	...
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> 	...
> }
> 
> appears to instantly fail when the initial threshold is already large due to
> probe weights.
> 
> Will this cause an early abort of the fallback loop, leaving regions unmerged
> and failing to enforce the max_nr_regions limit?

Yes, and the later patch in this series will fix it.  Also, to make it no real
issue even before the later patch, we set thee mode detection to say no.  So
the issue cannot happen in the real world.

> 
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=11


Thanks,
SJ
