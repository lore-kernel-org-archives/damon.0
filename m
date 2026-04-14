Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9C2609EE;
	Tue, 14 Apr 2026 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776144545; cv=none; b=kTlpVoi2yjq6uf26eNHpBEu5iNGMY1tlktaCHaxMQ9EhANbn0YRMDQDV30bNsRFjFgU5gB5ULIT5hLsfxpRy+oRnyYPPsvsT3kKL7HoS6EYplxz3OYQFGf+ZWkUaOevojJAWhHFaW+fvF7eZuk808eonyHwrdvrVPh/YH1vbtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776144545; c=relaxed/simple;
	bh=fYQyd2tPH0/IQiAZSr2cOX1SyNm+C7ey9+gqAGkZppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+QQsptTf4+3oPqIfrocKWYqaMKJnXuhEudR+/w0wgEZzViqTPkeigd7dRcyAd9H3ADPYIt+7rsYFJPVZGkFlO/7PCNApjgqOzy8cBVjiDrCxbAuQYRdXXjJh9oGfa8lRAWFlJ+MqnTTZl46hpvLnOiyiZxbp2T3YfMMZAR9O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPLzKPR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPLzKPR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C477C19425;
	Tue, 14 Apr 2026 05:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776144545;
	bh=fYQyd2tPH0/IQiAZSr2cOX1SyNm+C7ey9+gqAGkZppQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPLzKPR3YXny9DBobkzoOscb/OyNgAsL+SXhLBLOxtrAdxfxMzXxgQVZ1u0WrimyR
	 xUDVCTWus0gUZNKPmo+RKGbRt1KyRRjiy95Sk3U+MkS4bj14YnzowDMTZ1s/0Nna7U
	 NskjCK0CfWxoo50yhfdbUEMswBUNGHezsXTlt2X3vHQl8b4PjcpLvquhuCed+8S+tO
	 t+q+GzMP6jMpgUvikS0rY2OhiJoL5kB0QWKzTcVDw1bJfcOUkV9lmoNmk5EYxI8Fye
	 pr/m4VFG2y/KH56S8FCy2V6r+BbEtyPFx/cvJcE7ctlFyVJzkQkW30v3UzZWL09QlS
	 bxiJVVnGxFVpg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 1/2] mm/damon/reclaim: add autotune_monitoring_intervals parameter
Date: Mon, 13 Apr 2026 22:28:55 -0700
Message-ID: <20260414052855.90123-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414045253.88529-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Sashiko found not clearly documented behaviors.  I will make those
clearly documented in the commit message in the next revision.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260414045253.88529-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 7929f87e52de2f1dff34abf2ede4e58298280466
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: add autotune_monitoring_intervals parameter
> 
> This commit adds a new module parameter, autotune_monitoring_intervals, to
> DAMON_RECLAIM. It enables the auto-tuning feature for sampling and
> aggregation intervals with suggested default values.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..bcba2f719898d 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -160,7 +174,7 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
> >  static struct damon_ctx *ctx;
> >  static struct damon_target *target;
> >  
> > -static struct damos *damon_reclaim_new_scheme(void)
> > +static struct damos *damon_reclaim_new_scheme(unsigned long aggr_interval)
> >  {
> >  	struct damos_access_pattern pattern = {
> >  		/* Find regions having PAGE_SIZE or larger size */
> > @@ -170,8 +184,7 @@ static struct damos *damon_reclaim_new_scheme(void)
> >  		.min_nr_accesses = 0,
> >  		.max_nr_accesses = 0,
> >  		/* for min_age or more micro-seconds */
> > -		.min_age_region = min_age /
> > -			damon_reclaim_mon_attrs.aggr_interval,
> > +		.min_age_region = min_age / aggr_interval,
> 
> How does time-based page reclaim behave when the aggregation interval changes
> dynamically?
> 
> The min_age_region value is calculated statically once at scheme creation. If
> autotune_monitoring_intervals is enabled, the DAMON core dynamically modifies
> ctx->attrs.aggr_interval at runtime.
> 
> While the core scales existing regions' age counters via
> damon_age_for_new_attrs() so absolute time is preserved in the new units,
> the scheme's min_age_region threshold remains static and is not updated.
> 
> If the auto-tuner increases aggr_interval, the age counter grows slower,
> but it still needs to reach the exact same static min_age_region value.
> Does this cause the effective absolute time required for a page to be
> reclaimed to become much longer than the user originally configured?

Yes, and this is the intended behavior.  Modern users are expected to be less
depend on the static age threshold and use the aim-oriented quota tuning using
quota_mem_pressure_us like parameter.

Nonetheless, I think this is better to be more clearly documented.  I will
clarify this in the commit message in the next revision.

> 
> >  		.max_age_region = UINT_MAX,
> >  	};
> 
> [ ... ]
> 
> > @@ -209,12 +223,21 @@ static int damon_reclaim_apply_parameters(void)
> >  		goto out;
> >  	}
> >  
> > -	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
> > +	attrs = damon_reclaim_mon_attrs;
> > +	if (autotune_monitoring_intervals) {
> > +		attrs.sample_interval = 5000;
> > +		attrs.aggr_interval = 100000;
> 
> Does this silently discard user-configured module parameters?
> 
> If an administrator explicitly tuned sample_interval or aggr_interval via
> module parameters or sysfs prior to enabling the autotune feature, it
> appears their configured values are overwritten here without warning.

Yes, and this is an intended behavior.

Nonetheless, I think this is better to be more clearly documented.  I will
clarify this in the commit message in the next revision.

> 
> > +		attrs.intervals_goal.access_bp = 40;
> > +		attrs.intervals_goal.aggrs = 3;
> > +		attrs.intervals_goal.min_sample_us = 5000;
> > +		attrs.intervals_goal.max_sample_us = 10 * 1000 * 1000;
> > +	}
> > +	err = damon_set_attrs(param_ctx, &attrs);
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260414045253.88529-2-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260414045253.88529-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
