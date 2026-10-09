Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A33BBFDD
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554881; cv=none; b=qT6Kk22WRZ/IRoDbZvrQO0j8bTjaVPbRmIl0kChw6oCTq/MT10Pav7u/cAyMfdECrtZMiNcKaiZyribOASgn9rSiZhSEF4Nf/p3RtakgE7dgQK5P3o4hVN5pzqKCQ8oiSCEuU9w+xe574Z0s1fA4h2YQDOUiYXMlABvcti625HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554881; c=relaxed/simple;
	bh=yALqf5qqpIAr4winweuXaw+lBehbGHgxh/N+SWxFCnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=carMm2o7RNojkWDS/1hWPv0UHy1N6bCdNwY+o/SFVRaBD+shL/fsdmRwFhAtLgLAFKJSuXckSFWJ0DQJcsqImWpASaAP51gRtC+DG9zcNdHRoky/splSQPYF/opodapS0hjc1lskMWaX+EAIdWehVa3ATO6YejWZXN7o+HTkWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BybQiHmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BybQiHmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D021F000FF;
	Fri,  9 Oct 2026 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554874;
	bh=FPb+S6GYnzdKz29pi1TysnCaP81JH54CGWItwD+NmvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BybQiHmUjjSH13492uunKgskqjCWchf4dEDlWS+AsI12pWQsrU0rGhDXavb5lp+qK
	 ilQcUdV8GDLrNPsfkYwIVu9hUla4A090plUXn1CzQZwdam39TbZ7QOh9D4PV0UPilb
	 crUCuRE8+cSPbVlxMbwdfEonbVok7Nrnsvo6+tATyBGl5TZB27da1CBC6ZcrUXCN0e
	 7YUJfOM/5tNzMt/72XMZaTi2znlyPL5UzBG8aojvGK/CSSEBm5zLf3GIj5ZwoSAIsT
	 blqwyqKJMcfVFGFR80u1U/cdcTVIsPEPjrJ2ErUk9NX4iqaXI9evqt7ACALykLwWzk
	 qwK4rU/kwkrAQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y v3 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Fri,  9 Oct 2026 07:07:49 -0700
Message-ID: <20261009140750.11948-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-165685@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 14:02:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm: damon: double processing of split regions by earlier schemes
> --
> 
> commit de615e5101d6a41f308fef487cc464f7d25abb6e
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
> 
> This commit replaces the safe region iterator with damon_for_each_region()
> in kdamond_apply_schemes() to ensure newly split regions are not ignored
> during iteration. It also simplifies damos_skip_charged_region() by
> removing a workaround that updated the region pointer directly.
> 
> Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index fe91b296f4c66..c86cac855b9b0 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1134,7 +1134,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  static void kdamond_apply_schemes(struct damon_ctx *c)
> >  {
> >  	struct damon_target *t;
> > -	struct damon_region *r, *next_r;
> > +	struct damon_region *r;
> >  	struct damos *s;
> >  	unsigned long sample_interval = c->attrs.sample_interval ?
> >  		c->attrs.sample_interval : 1;
> > @@ -1156,7 +1156,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  		return;
> >  
> >  	damon_for_each_target(t, c) {
> > -		damon_for_each_region_safe(r, next_r, t)
> > +		damon_for_each_region(r, t)
> >  			damon_do_apply_schemes(c, t, r);
> 
> [Severity: Medium]
> Will this change cause earlier schemes to re-process newly split regions?
> 
> When damon_do_apply_schemes() evaluates a region, it sequentially iterates
> through all schemes. If an earlier scheme processes the region, it applies
> its action and updates its quota.
> 
> If a later scheme then hits an address filter or quota while evaluating the
> same region, it splits the region, shrinking it and inserting a new remainder
> region immediately after it in the target list.
> 
> Because the outer loop now dynamically fetches the next region via
> damon_for_each_region(), this newly inserted remainder region is evaluated
> in the very next iteration.
> 
> When damon_do_apply_schemes() processes this remainder region, it starts over
> from the first scheme. Won't this cause the earlier scheme to re-evaluate
> and apply its action a second time, potentially artificially double-charging
> its quota and redundantly applying physical memory operations?

Minor impact issue that also exist in the mainline.  Hence no blocker of this
series in my opinion.  I will separately work on the issue.

> 
> >  	}
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009134949.11507-1-sj@kernel.org?part=1
> 


Thanks,
SJ
