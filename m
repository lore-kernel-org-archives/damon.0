Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16A214812
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695272; cv=none; b=XAGK9dkI85ihA3SVgMPueOSYLNd9d3hIWlj1PxlhpGGOyJpBCXJMhsj05P7tuUv8ooyFyPkv0kUTcFRPV8+xO4O/3egfwTYiVc3BGF1pCxXatxf7AspR+SDuMczMxlkUMcTEvlGm5vF9qVCkK/WaEyHFft68y5Nfe4DU9BGRxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695272; c=relaxed/simple;
	bh=FZFxUGlHMSogKwgqFAbCRC1ao+vhE7DnEPAJl/NqmfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNZmniA+CgnBe8y3TKGMui1ZQzL6wrBucWg4A0ao0nYgs5KmAixqHFyB69w+sD7ads40NTHTjsJSYJXDL2T3wAIRaPqNIAvuvSxk1a5xPK8VOKqosg+IHLVuTaH7l7RJQY9fmnUgsPqnMUvKnK2clMchJ+g4Tdw5a2lW7y/Ev3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MotiWNZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MotiWNZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179001F000E9;
	Fri, 10 Jul 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695271;
	bh=DyIa52n1ErzNsZNaXiX/yTcEC5bE8XCwtelht1VZ93A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MotiWNZ/pl6dQqXP7ZQCAGoZK+fjVG/5THZ+DDC2D74p1bKVqyVhp1j5XZ8VyEgWH
	 /QtEFYspYSIhB2JRONNVS0kwl6D/91VQjt0sxbcDCECqsosOc65ir3uysiAaOUQimN
	 tKmbGWKhPgbQQq6k4/spk+HlpR1QerwPOvoQSOe/zbn7fttLE9kjF44m8C+t4b+5BZ
	 Aw1xkIYWlkgJNz6gp+BE2QE7zmfsvDyT/CPIR2V6Ew6fpJGmdTj0pP+AkkQly02eUD
	 +ZrHe7QIZNX6E/Ue4a26ZX6cJZ/ogs/PxdeAVbNkenJNdrIviXcyyZEwoezFKtL7vF
	 52GU/Wxmgu5Vg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 14/19] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Fri, 10 Jul 2026 07:54:23 -0700
Message-ID: <20260710145424.27394-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710140511.666D91F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:05:10 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Silent monitoring failure when probe weights are set on operations lacking apply_probes.
> - [Medium] kdamond_merge_regions loop termination condition still uses unweighted access frequency as max_thres.
> --
> 
> --- Patch [14]: [PATCH 14/19] mm/damon/core: get merge threshold from probe hits when weights are set ---
> commit 0b09a73e4b353610f5bc3d4f305131a2f9d7fea8
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: get merge threshold from probe hits when weights are set
>     
> When probe weights are set, DAMON merges regions based on their probe
> hits weighted sum.  But the merge threshold is calculated based on the
> access frequency.  Update it to retrieve the maximum probe hits weighted
> sum in the snapshot from apply_probes() ops callback, and generate the
> threshold based on it.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f7782c69037da..91964336ce31e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3776,9 +3777,18 @@ static int kdamond_fn(void *data)
> >  
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_merge_score = ctx->ops.check_accesses(ctx);
> > -		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx, access_check_disabled,
> > -					false);
> > +		if (ctx->ops.apply_probes) {
> 
> [Severity: Medium]
> If a user configures a DAMON context with ops that lack apply_probes
> (such as vaddr), adds a probe with a weight, and starts monitoring,
> could this result in a silent monitoring failure?
> 
> Since damon_valid_probe_params() allows this configuration:
> 
> mm/damon/core.c:damon_valid_probe_params() {
> ...
> 	return true;
> }
> 
> access_check_disabled will be true, causing check_accesses() to be
> skipped. With ctx->ops.apply_probes being NULL, no monitoring data
> would be collected and max_merge_score would remain 0.

Intentional behavior.  No issue.

> 
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
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> [Severity: Medium]
> When kdamond_merge_regions() is called with this new max_merge_score based
> on weighted probe hits, could the fallback loop terminate prematurely?
> 
> mm/damon/core.c:kdamond_fn() {
> ...
> 			kdamond_merge_regions(ctx,
> 					max_merge_score / 10,
> 					sz_limit);
> ...
> }
> 
> Looking at kdamond_merge_regions(), max_thres is hardcoded to the
> unweighted maximum access frequency:
> 
> mm/damon/core.c:kdamond_merge_regions() {
> 	max_thres = c->attrs.aggr_interval /
> 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> 	do {
> ...
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> }
> 
> If a user sets a probe weight such that max_merge_score / 10 > max_thres * 2,
> the loop condition threshold / 2 < max_thres will evaluate to false immediately,
> failing to enforce the max_nr_regions limit during region merging.

Known issue.  I'm separately working on it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=14


Thanks,
SJ
