Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FA3AFD16
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138993; cv=none; b=ojJVpFEJ5WUo8V2U3LAm/g1C9VlSX21l5OYLSaCwD7fX9kroOd2V8hQtMLrFHvR7wxzlI2akPFn+G7xnnKI1UooC9nLIRZ4WohrfyNfAGXdP1Go1e95Tap3N7FANznJB1UiWcBA24+rxEs/jm4XF9e4b87NZrVQpJ4tk/2XNErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138993; c=relaxed/simple;
	bh=E4CVNJgR+fyj2E8guXpaTDMjtHTHFmmIQYy2rNnFCn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElWec/den8KWtWRGVKCTxNbHATOVXRidkPYgjFqDExNi1e5d0h7+OpOnpBvlQ+rk0Ia2TpacbsVI5FRIklidunXx74Fu2+tc6FiEnbmRq3vj0iwRh/C6BkKRrJ9CZM1GbEoVCP7b8jTtgQ4dGRPs9S70GnEpfd4uwf2LwY1yfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Af05s+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Af05s+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720B11F00A3A;
	Mon, 22 Jun 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138989;
	bh=RKYrTAa4N/zOMu+hefHNx5XOKzA4BHOjePSUrhQBLbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3Af05s+9Gsn24/hltYrDT9Yk7gtbrT+0PhZ6pDtvozQj3FreVAWm1HsDP8JqhaO+
	 tZk7bsRKczFJrtXUpIdlZRf9r29lMHxtPHORgYiT/yHkeLg9FJdNme1CQeyrEvjp4R
	 jf9KpVMYTuPiac7gOliQdu7heAYrAqq40C0L1bs65O/oMcmA/bA6oHaKVq0mpg48D6
	 Ui/mguiEiBr/J+PC/NpCnZ8lO0txYtZEO3fJXYrPmM4vfAMJ/ISI8pc8FxPyu29pH8
	 +fPO4etoyt6vZw0Nbo++bUs5ndNlHPi+GBCZ2Rk9JTEBmV2NOQaXMVpPDQL8tGzED1
	 AwyKuuyiFDa4A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 1/2] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Mon, 22 Jun 2026 07:36:23 -0700
Message-ID: <20260622143624.31574-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142937.579571F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:29:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer underflow and state corruption in `nr_accesses_bp` calculation when `sample_interval == 0`.
> - [High] 32-bit integer overflow in access rate scaling and hotness scoring silently breaks region statistics for long aggregation intervals.
> --
> 
> commit 4e734fc35404d39d1209a202d1c72aa4e9ef543f
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle zero intervals in damon_max_nr_accesses()
> 
> This commit addresses a divide-by-zero error in damon_max_nr_accesses()
> by forcing a denominator of 1 when the sampling interval is zero. It also
> ensures the function always returns at least 1.
> 
> Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 6f7edb3590ef9..888570f55b416 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  
> >  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> >  {
> > -	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> > -	return min(attrs->aggr_interval / attrs->sample_interval,
> > +	unsigned long sample_interval;
> > +	unsigned long max_nr_accesses;
> > +
> > +	sample_interval = attrs->sample_interval ? : 1;
> > +	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
> >  			(unsigned long)UINT_MAX);
> > +	return max_nr_accesses ? : 1;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while this commit fixes the
> zero interval handling inside damon_max_nr_accesses(), there is a bypass in
> mm/damon/core.c that still relies on sample_interval:
> 
> mm/damon/core.c:damon_update_region_access_rate()
> 	if (attrs->sample_interval)
> 		len_window = damon_max_nr_accesses(attrs);
> 
> When sample_interval is 0, this bypass circumvents the properly fixed
> damon_max_nr_accesses() function, locking len_window at 1. During the
> next aggregation window, damon_moving_sum() recalculates the moving
> average. Because len_window is stuck at 1, the entire nomvsum is
> subtracted from a smaller mvsum.
> 
> Will this cause nr_accesses_bp to massively underflow its unsigned int
> type and wrap around, corrupting the region's access metrics?

Good finding.  Not a blocker of this patch, though.  I will separately work on
this.

> 
> [Severity: High]
> This is also a pre-existing issue, but does damon_update_monitoring_result()
> suffer from a 32-bit integer overflow for long aggregation intervals?
> 
> When a long aggregation interval and short sample interval are configured,
> the accesses can be quite large:
> 
> mm/damon/core.c:damon_update_monitoring_result()
> 	r->nr_accesses_bp = r->nr_accesses * 10000;
> 
> If nr_accesses is very high, does this 32-bit unsigned int arithmetic
> silently wrap around, heavily corrupting nr_accesses_bp?
> 
> A similar overflow appears in damon_hot_score():
> 
> mm/damon/ops-common.c:damon_hot_score()
> 	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
> 			damon_max_nr_accesses(&c->attrs);
> 
> Does the numerator multiplication overflow the 32-bit bounds before
> the division, resulting in an artificially skewed, low hotness score?

Known low priority issue.  No blocker of this patch.


Thanks,
SJ

[...]
