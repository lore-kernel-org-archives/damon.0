Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9040DFC5
	for <damon@lists.linux.dev>; Fri,  1 May 2026 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600216; cv=none; b=pLUwlv5EfCQGvcZG4yfip+g1YjDJa3mx+KrUuy0xtMyWpUTp51qKXC6OHF+6Gm6lXIOpmF1WcWOK3CoVEE8U4fhzTrTfN+4SjjaZXNsxCm8aurfDnFhq2Qy46WApycSrgPMJPamkQV8UDyMn4FWh0C16KG8Zhze7YAvcEqua6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600216; c=relaxed/simple;
	bh=ItFxB/JshjMWy8jSpcV12KG+66or8idz9o4RrYbmT64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2uApCDrEj9yHnybjgR7UY2zpY6StrM4oOmAuloNGsxyg9f5s90IWQI2ccl0wqcVHMtR7fninZ6LR4ANwfL/rajWpgMnUVDa5A+7h9HCVTIj/wkFtgCKNNsv/fC1inXJJ3aPGX3CZHckAN17+MzvWb/K9rDsox6XeuWKkt2mhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXlnMuOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXlnMuOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B5BC2BCB3;
	Fri,  1 May 2026 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777600215;
	bh=ItFxB/JshjMWy8jSpcV12KG+66or8idz9o4RrYbmT64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXlnMuOEuuexgok2rd+HZk/PYyk/3R3c0tk1rzhoIVvTboarJoLT8NwuxZ5pOGtko
	 lDOp7KbCjNRfaKLZiMUSRTWtVJf86PxebC0X8OZglAfXhvTivQ63P00mkIeX7gsTk6
	 NSFhlkwaCAsxfPfvJAsApfCLSXc/aKVlQeRD0bxyv+DYguoOPoZn36GPf4txLLczGF
	 qaePsw03cn6pYVvlwsSZ8R6Z/gBzHTVjxvsGeND9pZKfJwsxHt/xE6jY7FlK+kX93i
	 dYJdFSHMkwHdK5uGxIj4k6mT5B7nD+XIIpAE/iB7OnHmehTjzm5se0bxgQwOTlzyeg
	 f6ugj8rYfMb+Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/damon/reclaim: add autotune_monitoring_intervals parameter
Date: Thu, 30 Apr 2026 18:50:07 -0700
Message-ID: <20260501015008.82886-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501013044.7DC96C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 01 May 2026 01:30:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Validation check on `damon_reclaim_mon_attrs.aggr_interval` prematurely rejects configurations when autotuning is enabled, and exposes a TOCTOU divide-by-zero panic.

No blocker for this patch is found.  Plese read below for more details.

> --
> 
> commit 34f815f9177f234892c1b9608e13d2fc0957697e
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: add autotune_monitoring_intervals parameter
> 
> This commit adds a module parameter for utilizing DAMON's auto-tuning
> feature with suggested default setups. When enabled, this feature
> overrides manually entered monitoring intervals to capture a meaningful
> amount of access events per snapshot.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index a60ee800d63e9..7126d47fb8b2f 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -201,12 +215,21 @@ static int damon_reclaim_apply_parameters(void)
> >  		goto out;
> >  	}
> >  
> > -	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
> > +	attrs = damon_reclaim_mon_attrs;
> > +	if (autotune_monitoring_intervals) {
> > +		attrs.sample_interval = 5000;
> > +		attrs.aggr_interval = 100000;
> > +		attrs.intervals_goal.access_bp = 40;
> > +		attrs.intervals_goal.aggrs = 3;
> > +		attrs.intervals_goal.min_sample_us = 5000;
> > +		attrs.intervals_goal.max_sample_us = 10 * 1000 * 1000;
> > +	}
> 
> In the existing code just above this diff, there is a validation check:
> 
>     if (!damon_reclaim_mon_attrs.aggr_interval) {
>         err = -EINVAL;
>         goto out;
>     }
> 
> If autotune_monitoring_intervals is enabled, could this check prematurely
> reject the configuration if damon_reclaim_mon_attrs.aggr_interval is 0?
> The auto-tuning override happens right below the check.

Yes, and this is a behavior that consistent to that of DAMON_LRU_SORT.  I
didn't really intentionally designed this behavior but I find no problem at
this.  Zero aggregation interval is invalid.  Just keeping it as invalid even
if autotune is enabled sounds natural to me.

> 
> Additionally, because this check evaluates the global module parameter
> directly instead of a local copy, could a concurrent sysfs write cause a
> divide-by-zero panic? 
> 
> If a user sets the global interval to 0 right after this check passes:
> 
>     if (!damon_reclaim_mon_attrs.aggr_interval) {
>         // passes
>     }
>     
>     // concurrent sysfs write sets damon_reclaim_mon_attrs.aggr_interval = 0
>     
>     attrs = damon_reclaim_mon_attrs;
> 
> If autotune_monitoring_intervals is false, attrs.aggr_interval becomes 0
> and is passed to damon_reclaim_new_scheme(), which performs:
> 
>     .min_age_region = min_age / aggr_interval,
> 
> Would moving this check to evaluate the local attrs.aggr_interval after
> the auto-tuning block prevent both of these scenarios?

No.

First of all, this patch is doing nothing for the code.

And damon_reclaim_apply_parameters() does not race against itself, since it
works synchronous to the parameters update, and the parameter updates are
protected by kernel_param_lock.


Thanks,
SJ

[...]
