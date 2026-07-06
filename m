Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056D3B19D0
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382217; cv=none; b=Eqz2HGiOeibXJBCQjha58WU8jJsKSPro9dlntDJEhuk4XCxXlbFKHSMTo88e5yoTTFD6sCZ/vZwnWbeN8IDT9rEdijlgrEJaP3m1c9oBiqqJsc+fPPt9ZKJYNZcb4bmEaMTFHaSiD/kuE7t5bxC9PjWoczgNZdfO4nmeI9pmUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382217; c=relaxed/simple;
	bh=hBVI986umXVf4pB4gpC4Hy3YMEdtbdV+QwKsMQx0ZvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZuWDtWmUj6L1Ju4+Z3vPn8non0E7jQJRDTVnAYa1fiANgHA2Wf/b0t6/wZgQz3+WJnZFJ4+hiDpsutCxLw8O4FHswTwewmv0Y75g0FcqXM6bk+h9YfbQw6hxppCCbYgQRFLw5qO+JdkfqHh/a8UYx6cyoDkI4uWFSk7LZLbKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqp+9wup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqp+9wup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF671F000E9;
	Mon,  6 Jul 2026 23:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382215;
	bh=eHGF395ZttK7teYQ926cTBwjRVpHT/4+ONSAweUb6rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jqp+9wuph7HN7hOspRuYG/GEQmIynoeauoPzjWzBTiW/1V0nEEU7TFAunPY2d1WOe
	 PKo4BJKZWMbn+F+LzZ4hysrkZhhcSGzueVSq7ZGDekG1kivHDyjMDvUVY1hF7Ek8pD
	 KnoT2J7kwL960Q7u8iVTCWjHyo9mvk5H2cNV0qkkpInmsxDugxHdXirOwkjAkIwbEt
	 FXQ1AE4aR49QSXSghlvhVSdofeQISkvSvV5zRjvPWNTEdwVSh9Z+SZvEtpG2nQAsyl
	 cmFITVPI6myNexDPVqjodSCQSt43VIr76MrrknHo6GjRIGjbChHFcbbeksL6wyOKRc
	 KcuZZ4GUJG/Ww==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 09/16] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Mon,  6 Jul 2026 16:56:45 -0700
Message-ID: <20260706235647.97357-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706150205.D07DC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 15:02:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Region merging loop bound `max_thres` is incorrectly scaled when probe weights are used, causing premature loop termination and permanent violation of `max_nr_regions` limits.
> --
> 
> commit cc6e72a3b37a62b24190b0e42f141fba6caab8fc
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: set samples in apply_probes() if probe weights are set
> 
> When probe weights are set, the prepare_access_checks() ops callback is
> not invoked, so sampling addresses of regions are unset.  Ask
> apply_probes() to set those together in the case.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index a2f768bd07223..5311aa689c8e7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3727,7 +3727,8 @@ static int kdamond_fn(void *data)
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> >  		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx, false, false);
> > +			ctx->ops.apply_probes(ctx, access_check_disabled,
> > +					false);
> 
> [Severity: High]
> Does enabling probe weights here introduce a regression with the region
> merging loop bound in kdamond_merge_regions()?
> 
> Later in the series, a commit ("mm/damon/core: get merge threshold from
> probe hits when weights are set") derives the merge threshold from weighted
> sums when probe weights are used. However, the loop bound max_thres in
> kdamond_merge_regions() remains tied to the raw access frequency:
> 
> mm/damon/core.c:kdamond_merge_regions() {
> 	...
> 	max_thres = c->attrs.aggr_interval /
> 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> 	do {
> 		nr_regions = 0;
> 		damon_for_each_target(t, c) {
> 			damon_merge_regions_of(t, threshold, sz_limit, c);
> 			nr_regions += damon_nr_regions(t);
> 		}
> 		threshold = max(1, threshold * 2);
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> }
> 
> If a large weighted sum is used as the initial threshold, it seems the loop
> will exit immediately on the first iteration without merging enough regions
> because threshold / 2 will already exceed the raw max_thres.
> 
> Can this permanently violate the max_nr_regions limits?

No.  damon_has_probe_weights() always returns false at this moment, so no
issue.

> 
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=9


Thanks,
SJ

[...]
