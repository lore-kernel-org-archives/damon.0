Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4846285C91
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287930; cv=none; b=HiMYLBWvctvLfL5mO4fyZu7KcDCagHinDO/J5ZCaJI4ZTz4tRZUxhzA3k8Yv1jZAHFNQDVr7eg0DKFWkLrvsk/BluZij70IpIIPZP000RmMcCK10j5NzEU+y5ljPWNp9DwpOhShjFf4cHEEaUVjckvbajGR2fTD+/9miHl9c62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287930; c=relaxed/simple;
	bh=iVAfYzTzI80DyoJDSkmxhO9/3+oRlUi/4W82oOMJmi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7a/WURdMWBTmsmOaGKY8Lz5W1wve3FW3c+c++n86MynZmnO+shOEYe1l6HC5VCXK4uZuKqevwXCS5yi6S7XK8zFz65IoawU830bhhxwROgcOBJo3HTZ9xuOeoIUoxZOWo0QEbR8E1aTP+C7wmUy++/5CJ//GaLJZhwi6E9hQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcUwd4tV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcUwd4tV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E21F000E9;
	Sun,  5 Jul 2026 21:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783287928;
	bh=t9o9kZIqM+CROoXlxs0SS2NXFj0TLqxYpWhKrMyFbMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcUwd4tVVyCxvd7jTAmWjsMGDsUVSBEoA0EBCPsKCgsS39ydLV2XYC+3b5TXOQ5xG
	 gbhYeZI48980nznk0pgBS1tbGxvxv18kJh+AgTH50mk/PwUkz8MmTc2issP8J6CAob
	 SmN6WRgMalQehDDNZe2JyunBkuvj6JQnWVBJnCaKxAlqrD3mmz/Uj/uWbITI/+O1YE
	 2cxgwV+qswq8LFUluecSvKTLBLBIOLKULBmAWdz5tdcOD7t55Or5w71upagOpxm6Gy
	 oBGe4HUiP3xp6ZJe3eiwp/Mf/3DrC4WJcwr1ahIz8PVROFXmKoIHuoRC13DUhpN7Kc
	 64SjjU7nj1eOg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 12/16] mm/damon/core: implement damon_has_probe_weight()
Date: Sun,  5 Jul 2026 14:45:16 -0700
Message-ID: <20260705214519.101117-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705211553.25F701F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:15:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] `damon_has_probe_weights()` returns `true` even for DAMON contexts that do not implement the `apply_probes` operation callback (e.g., `vaddr` and `fvaddr`), causing DAMON to silently bypass access checks and completely stop monitoring memory.
> 
> Pre-existing issues:
> - [High] Integer overflow in `abs()` macro usage with large unsigned probe scores breaks DAMON region merging.
> - [High] Multiplication overflow in `damon_merge_two_regions` when calculating merged probe hits and access counts on 32-bit systems.
> --
> 
> commit 4b421534e3283ef89ac2afef3f02956b0510da1e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_has_probe_weight()
>     
> DAMON monitors only data attributes when probe weights are set. However,
> the function for detecting it is intentionally returning false always.
> Now all the building blocks are made. Complete the mode detection function
> so that the mode can really start working.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7a070cfb7cd1b..c7de55865b9c9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> >  
> >  static bool damon_has_probe_weights(struct damon_ctx *c)
> >  {
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_probe(p, c) {
> > +		if (p->weight)
> > +			return true;
> > +	}
> 
> [Severity: High]
> Does this code need to check if the underlying ops struct supports probes?
> 
> If a context like vaddr or fvaddr has a probe weight configured via sysfs,
> this will return true. This causes access_check_disabled to be set to true in
> kdamond_fn(), which skips check_accesses():
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
>     bool access_check_disabled = damon_has_probe_weights(ctx);
>     ...
> }
> 
> Because ctx->ops.apply_probes is NULL for vaddr, the apply block is then
> skipped and max_merge_score remains 0, which causes kdamond_merge_regions()
> to aggressively merge everything with a threshold of 0.

Yes, and no problem.  Users wrongly configure DAMON will get poor quality of
outputs.  No real bad consequences like kernel crash or memory leak happen.

> 
> >  	return false;
> >  }
> 
> I also noticed a couple of pre-existing issues in this file:
> 
> [Severity: High]
> This is a pre-existing issue, but does this code overflow the 32-bit
> boundary on 32-bit systems?
> 
> mm/damon/core.c:damon_merge_two_regions() {
> [ ... ]
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
> [ ... ]
> 	for (i = 0; i < DAMON_MAX_PROBES; i++)
> 		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
> 				* sz_r) / (sz_l + sz_r);
> [ ... ]
> }
> 
> If a region size reaches around 42MB on a 32-bit architecture and
> nr_accesses is around 100, the multiplication nr_accesses * sz_l could
> exceed 4.2 billion and silently overflow the 32-bit unsigned long,
> corrupting the memory access statistics for merged regions.

Known low priority issue.  On 32-bit architectures users could use the
addr_unit parameter to avoid this.

> 
> [Severity: High]
> This is a pre-existing issue, but can the absolute difference of two large
> unsigned integers be evaluated incorrectly here?
> 
> mm/damon/core.c:damon_merge_regions_of() {
> [ ... ]
> 		score = damon_merge_score(r, false, ctx, use_probe_hits);
> 		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
> 
> 		if (abs(score - last_score) > thres)
> 			r->age = 0;
> [ ... ]
> }
> 
> If a user configures a large probe weight via sysfs such that the weighted
> sum exceeds INT_MAX, score - last_score produces a large unsigned int. The
> abs() macro explicitly casts unsigned types to signed types, which would
> wrap into a negative signed integer and then be negated into a much smaller
> positive value. This could bypass the greater than threshold check and
> prevent regions from resetting their age.

Pre-existing issue.  I will separately work on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=12


Thanks,
SJ
