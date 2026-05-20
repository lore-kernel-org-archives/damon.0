Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F933DD518
	for <damon@lists.linux.dev>; Wed, 20 May 2026 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285569; cv=none; b=U+qtSNEA2Gykf28ZVAdXZwJoTIQyP8sL+7+W15ZF77QrAD3k8D+jJjinIHDXxtVW4CU4GlUWuuWgdN6Va6fsaL5BmI/OWsV77fo08tRyvWk9drUdzpotxk84iVY6mLtr62BoWEUOXlpZoFschY8vUgxfgUCk0R/jVnnMCc1DHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285569; c=relaxed/simple;
	bh=N3ctNneRlMheeWS382ye+y4Z2LWD5sZgMxvF/0QVlJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUJ2Dfmpxj554x02Lo0Rxb7L3c/BkXNq7Ey0EbcR0weMBBu29Y/3hsZ1vqo2sPt+ZxO5grYtOQm3Z6Wvr3l8V2YoXyQu/MPecHcODz59vuUfBgVWoASUKNRN7/rxCM+T3EJfruYVjcOFbHa6aKFulY5xgZzvtE/1Mwg4K1MR2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PivYSqqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PivYSqqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C6C1F000E9;
	Wed, 20 May 2026 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779285568;
	bh=J/MX4U1SUawlR8ob/zt7SgP27ZqoRqS/XnjDXi0IjVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PivYSqqAVI2YXCN69XFi3TAehYIk+QxX5VG0TvBZaeza7cnUH5FpU9+cgIdkg6Cqk
	 Rtyq6B+OFa4LArOSI+gTjoZ8CXc4duWa4H+iE1Pqhz65zU+JHekQcBH7DfblPucj+6
	 F5Age2KW2O4FE8d2Eu1JWfoH+TRmA7dtjNIQBn+B8dhjlF4iTdOuX7z792NTAxslTs
	 5tFClpP0gIlfs+vfr+To1lD7CkYIUcme3j2rLLWx8aWdfsCdDiC6HXnNVAGzEcsqap
	 jSQaSNRNIa0XPRmAKEcsB7e9+dDKFvFDZsW8VuCDEV2AzF+I9zdBustjQEI73UaA1F
	 GNtwkePsLSW5A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 08/14] mm/damon/core: add kdamond_call() debug_sanity check
Date: Wed, 20 May 2026 06:58:59 -0700
Message-ID: <20260520135902.169663-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520065300.A51591F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 06:52:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The sanity check for region bounds in `damon_verify_ctx` uses an inverted condition, causing it to falsely trigger a kernel warning on all valid regions and fail to catch invalid ones.
> --
> 
> commit 7d803208aef5bc4f95dd9c37657de5b62618e8e6
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: add kdamond_call() debug_sanity check
> 
> This commit introduces a debug sanity check for the DAMON context state
> before handling damon_call_control objects in kdamond_call(). The check
> verifies region boundaries, overlaps, and the total region count under
> CONFIG_DAMON_DEBUG_SANITY.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3326,6 +3326,37 @@ static void kdamond_usleep(unsigned long usecs)
> >  		usleep_range_idle(usecs, usecs + 1);
> >  }
> >  
> > +#ifdef CONFIG_DAMON_DEBUG_SANITY
> > +static void damon_verify_ctx(struct damon_ctx *c)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +
> > +	damon_for_each_target(t, c) {
> > +		struct damon_region *prev_r = NULL;
> > +		unsigned int nr_regions = 0;
> > +
> > +		damon_for_each_region(r, t) {
> > +			WARN_ONCE(r->ar.start <= r->ar.end,
> > +					"region start (%lu) <= end (%lu)\n",
> > +					r->ar.start, r->ar.end);
> 
> [Severity: High]
> Should this condition be inverted? WARN_ONCE triggers when the condition
> evaluates to true. Since a valid memory region typically has a start address
> strictly less than its end address, this evaluates to true for normal
> regions.
> 
> Could this trigger a spurious warning on the very first valid region
> encountered, and because it uses WARN_ONCE, prevent any actual regressions
> where start > end from being reported?

Nice catch.  start == end is also invalid because we disallow empty regions.  I
will update it to start >= end in the next version.

> 
> > +			WARN_ONCE(prev_r && prev_r->ar.end > r->ar.start,
> > +					"region overlap (%lu > %lu)\n",
> > +					prev_r->ar.end, r->ar.start);
> > +			prev_r = r;
> > +			nr_regions++;
> > +		}
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520062858.167011-1-sj@kernel.org?part=8


Thanks,
SJ
