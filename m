Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6D168BD
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383082; cv=none; b=XqSYeqyAtGXZSFfQPUxIzkG84+hhRhBkKFg5+Q88GhQ94Q33c9MfdK+qGbHd8LEQh7FD51s3wbw71YrhTSu3+V0oURZHFrkD9t2C9fqnbFgQ0DQfaQkvxeLQpN2KTsJ+YfGxqk01HegpSeF4uUTV2P2/FyCUJIVpapS0mlp0YFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383082; c=relaxed/simple;
	bh=Thv2wlzx0hjRz8hu8ImYaIesx8UC1uNwjr3H/xx/Rfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROQc5baZb4dYvjD3apbdbT/DqekPflNytcWM+UKjo9mbkDMQM2aPKevXyNBkhpktk9d01TaiqR6ttR9cnC78d1obQqWG5Xd6rMjatYJowZFOKKO6nk1lO7QauStI7Y8ukRICUF88BOr2TTSgk3QT5TPdsN416lyI/tX6nW2zpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ7n/K/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ7n/K/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E811F000E9;
	Tue,  7 Jul 2026 00:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383081;
	bh=zYL6Vec9eVBK9IO7ThXsUazisMTX4cdSuxkcF6CzJ1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZ7n/K/z+j1+CgMehq7vWM91y3n4XMbZIOmDpfuYE29BqfJbjUHwpCUulBwwogpur
	 Z8K2uiyeu9Cpauwwo2blvJbS4Mjmn7O8R1DOVzP2I0Um8uKUji0jKZP7xrG4e84LRF
	 DTiaMq5mDkPkfbMK4oiNRldFJWUyAWVoUAmbhJPClMA1VbpA9pB+Vu4p2Ek4IDtZ9H
	 5Zh8yXj0G1hMsZT1n117O0Rag4E+c5l/PCOLnX+MLaGU84dNyqvw9zcnUMod3GAo5D
	 AnYFLSzkzn/i3Wcct7/pbSuQVRe57U1LtLYLLrFsh/H6U1VnqQCbeGGk3F6qgxEjq6
	 1rtNsHD4hV+Lg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 14/16] Docs/mm/damon/design: document attrs-only monitoring
Date: Mon,  6 Jul 2026 17:11:12 -0700
Message-ID: <20260707001113.97927-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706153457.B0ED51F00A3F@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 15:34:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Multiplication and accumulation in `damon_probe_hits_wsum()` can silently overflow a 32-bit `unsigned int`.
> - [High] Silently disables all monitoring if probe weights are configured for operations sets that lack probe support (e.g., `vaddr`).
> 
> Pre-existing issues:
> - [High] The `abs()` macro behaves incorrectly for large `unsigned int` differences, breaking region adjustment logic.
> - [High] The `probe_hits` array relies on 8-bit `unsigned char`, leading to silent wraparound during long aggregation intervals.
> --
> 
> commit 61ffda736cfeed6cc995344cdd1d753a189751a8
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: document attrs-only monitoring
> 
> This patch series introduces Attributes-only Monitoring for DAMON, adding
> probe weights to dictate memory management scoring. When weights are
> configured, data access monitoring is disabled and regions are evaluated
> based on weighted probe hits instead.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3c5a46e1c079a..6e5a029989a0c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -389,6 +401,30 @@ static bool damon_is_last_region(struct damon_region *r,
> >  	return list_is_last(&r->list, &t->regions_list);
> >  }
> >  
> > +/**
> > + * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
> > + * @r:		region to get the weigted sum of.
> > + * @last:	if the request is for last-window agggregated probe hits.
> > + * @ctx:	context of &r.
> > + *
> > + * Return: the weighted sum of probe hits of the region.
> > + */
> > +unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
> > +		struct damon_ctx *ctx)
> > +{
> > +	struct damon_probe *probe;
> > +	unsigned int sum = 0;
> > +	int i = 0;
> > +
> > +	damon_for_each_probe(probe, ctx) {
> > +		if (last)
> > +			sum += r->last_probe_hits[i++] * probe->weight;
> > +		else
> > +			sum += r->probe_hits[i++] * probe->weight;
> 
> [Severity: High]
> Does sum need protection against integer overflow here?
> 
> If a user configures a large priority weight for a probe via sysfs, this
> multiplication can silently overflow the 32-bit unsigned int sum (for
> example, 255 * 4294967295).
> 
> Could this integer overflow wrap around the score metric, making heavily
> weighted regions incorrectly appear as "cold" regions and corrupting the core
> memory management data?

Will fix in the next version of this series, or separately.

> 
> [Severity: High]
> This is a pre-existing issue, but since Attributes-only Monitoring makes
> probe hits the primary metric, could probe_hits overflow its 8-bit limit?
> 
> In include/linux/damon.h, the array is defined as an 8-bit value:
> 
> struct damon_region {
> 	...
> 	unsigned char probe_hits[DAMON_MAX_PROBES];
> 	...
> };
> 
> If a user configures an aggregation window that encompasses more than 255
> samples, the counter increment in damon_pa_apply_probes():
> 
> 	r->probe_hits[i]++;
> 
> will repeatedly wrap around, destroying the statistical data and corrupting
> the region scoring.

Known low priority issue.  No blocker.  But I will consider fixing this in the
next revision or seaprately.

> 
> > +	}
> > +	return sum;
> > +}
> 
> [ ... ]
> 
> > @@ -3211,24 +3259,37 @@ static void damon_merge_two_regions(struct damon_target *t,
> >   * sz_limit	size upper limit of each region
> >   */
> >  static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> > -				   unsigned long sz_limit)
> > +		unsigned long sz_limit, struct damon_ctx *ctx)
> >  {
> >  	struct damon_region *r, *prev = NULL, *next;
> > +	bool use_probe_hits = damon_has_probe_weights(ctx);
> >  
> >  	damon_for_each_region_safe(r, next, t) {
> > -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> > +		unsigned int score, last_score;
> > +
> > +		score = damon_merge_score(r, false, ctx, use_probe_hits);
> > +		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
> > +
> > +		if (abs(score - last_score) > thres)
> 
> [Severity: High]
> This is a pre-existing issue, but it seems exacerbated now that arbitrary
> weight multipliers are introduced. Does abs() behave correctly for large
> unsigned int differences?
> 
> The abs() macro implicitly casts its arguments to signed int. If the
> absolute difference between score and last_score exceeds INT_MAX, it
> will overflow and be evaluated incorrectly as a smaller positive number.
> 
> Because weights can now easily push scores past INT_MAX, will this cause
> damon_merge_regions_of() to improperly ignore large score differences?

Will fix in the next revision.

> 
> >  			r->age = 0;
> > -		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
> > +		else if ((score == 0) != (last_score == 0))
> >  			r->age = 0;
> 
> [ ... ]
> 
> > @@ -3658,25 +3718,38 @@ static int kdamond_fn(void *data)
> >  		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
> >  		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
> >  		unsigned long sample_interval = ctx->attrs.sample_interval;
> > +		bool access_check_disabled = damon_has_probe_weights(ctx);
> > +		unsigned int max_merge_score = 0, max_wsum;
> > +		bool get_max_wsum;
> >  
> >  		if (kdamond_wait_activation(ctx))
> >  			break;
> >  
> > -		if (ctx->ops.prepare_access_checks)
> > +		if (!access_check_disabled && ctx->ops.prepare_access_checks)
> >  			ctx->ops.prepare_access_checks(ctx);
> >  
> >  		kdamond_usleep(sample_interval);
> >  		ctx->passed_sample_intervals++;
> >  
> > -		if (ctx->ops.check_accesses)
> > -			max_nr_accesses = ctx->ops.check_accesses(ctx);
> > -		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx);
> > +		if (!access_check_disabled && ctx->ops.check_accesses)
> > +			max_merge_score = ctx->ops.check_accesses(ctx);
> > +		if (ctx->ops.apply_probes) {
> 
> [Severity: High]
> If a user configures probe weights via sysfs for an operations set that
> doesn't implement apply_probes (e.g., DAMON_OPS_VADDR), will this silently
> disable all monitoring?
> 
> Because access_check_disabled becomes true unconditionally when weights are
> present, default access checking is skipped. Without ctx->ops.apply_probes,
> no probes are applied either, effectively breaking the DAMON monitoring thread
> for that operations set.

I will fix this in the next revision, or separately.

> 
> > +			if (time_after_eq(ctx->passed_sample_intervals,
> > +						next_aggregation_sis) &&
> > +					access_check_disabled)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=14


Thanks,
SJ

[...]
