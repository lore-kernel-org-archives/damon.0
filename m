Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41C3EB0FE
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382095; cv=none; b=l9ciWX+90FeCCi1H6ZpjFwpgdVyuswy53fA8gcKqJ6x/JIzUwF+vbPBqz3M2I1h9Du1nkBX+byjb5k7GDS0ufAM33tgk+RGf9zliPJZGsXdxv9r2hyt/AJmR0rgC0MM3reLiv+QJ0Jpw2wMWcF+IDE5vhLXW61YVN8K+sjcNwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382095; c=relaxed/simple;
	bh=/upVbwYpk05kUYorwxnkUnCyd/LCwGDW1LqdbfxJ4u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6NsbmFtTzyGpTXrqk5ZGdYSM5PzJj/JV4Hc1KQxkxfyyp94Lq6E1j/fQLB6VwVcoppU+KtLj4kOj/Jo5Uq8mpwhx5a/tFXz4QOpn8ZQ899IfYAJr/TuIw1GO1C1f42n+07W/edZIkL3kAlaixVGjPd1DrQBiW4Tzh0N9KoPifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHqZrzQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHqZrzQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F5F1F000E9;
	Mon,  6 Jul 2026 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382093;
	bh=tn5Xh9AqZFILTx1sxQQky4KuUcVT6yLwuKLWvfQYCbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHqZrzQoVRRZV+Bpo9QTvt1MEH/nlHaL/lu6K1gyOOq1kU0s7KFbduEudlediyILR
	 PVJsrJZp/Soj1Gr0wU4TtWgLCDficNDE5C60NKII4She1re0S7LtDghzUEZPDkp37T
	 1/H8daqw61hjqjxeaPpAmrtSOXSWbbuXTSRgijmpOj/e1FCtYicbYkeUDu1eozlhzJ
	 /QZC6pjFPkjdFFI+1FZpqZ2Z0hNl7Aml26dz+7CTk/lfaA0i2qQ+0GQpr0kJwWGrgd
	 YlbWd+VRh3RhBkAlEmzrd0lABUtkgYkXyM/KWmPTMyNQCR0+No5VxOOcPZ0tamWSTT
	 E/bUY2q7eY2ww==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 08/16] mm/damon/core: disable access monitoring when probe weights are set
Date: Mon,  6 Jul 2026 16:54:42 -0700
Message-ID: <20260706235445.97231-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706150309.5272F1F00A3F@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 15:03:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The region merging loop termination condition is incompatible with weighted probe hits, leading to unbounded region growth.
> - [High] Unconditionally disabling access checks forces `nr_accesses` to 0, breaking access-based DAMOS schemes and interval auto-tuning.
> --
> 
> commit d9de5e6aadab2e17a0c4428844dec0cfc05d08ef
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: disable access monitoring when probe weights are set
> 
> When users set probe weights, they are interested in the data attributes
> rather than data access patterns. This commit disables data access
> monitoring when probe weights are set.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7aff741d43bd4..a2f768bd07223 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3713,17 +3713,18 @@ static int kdamond_fn(void *data)
> >  		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
> >  		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
> >  		unsigned long sample_interval = ctx->attrs.sample_interval;
> > +		bool access_check_disabled = damon_has_probe_weights(ctx);
> 
> [Severity: High]
> Can configuring probe weights lead to unbounded region growth during merging?
> 
> When damon_has_probe_weights(ctx) is true, the region merging loop in
> kdamond_merge_regions() compares a threshold scaled with weighted probe hits
> against max_thres:
> 
> mm/damon/core.c:kdamond_merge_regions() {
> 	...
> 	max_thres = c->attrs.aggr_interval /
> 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> 	do {
> 		...
> 	} while (nr_regions > c->attrs.max_nr_regions &&
> 			threshold / 2 < max_thres);
> }
> 
> Since max_thres is hardcoded to the maximum unscaled accesses
> (aggr_interval / sample_interval) and doesn't account for probe weights, the
> loop could terminate prematurely.
> 
> If weighted probe hits result in score differences exceeding this unscaled cap,
> wouldn't this prevent regions from merging back down below the user-configured
> max_nr_regions limit?

No such issue can happen because damon_has_probe_weights() always returns
false.

> 
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
> > +		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> 
> [Severity: High]
> Does disabling the access checks here break DAMOS schemes and interval
> auto-tuning?
> 
> By preventing ctx->ops.check_accesses from running when probe weights are
> configured, r->nr_accesses will remain 0.
> 
> Since damon_nr_accesses_mvsum() consumes these 0s, it seems this would cause
> interval auto-tuning to exponentially increase the sampling interval until it
> hits the maximum allowed value.
> 
> Additionally, wouldn't this force all regions to instantly match any DAMOS
> scheme configured to target low-access memory?

That's the intended behavior.  Users are informed that access monitoring is
disabled in the mode.

> 
> >  		if (ctx->ops.apply_probes)
> >  			ctx->ops.apply_probes(ctx, false, false);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=8


Thanks,
SJ

[...]
