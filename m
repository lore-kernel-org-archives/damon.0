Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D334C815
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693948; cv=none; b=EJ7tED7Xj5xDbrxyYM5RKxRiKgfSVCMJHTulva+x8d46OjYpg3/JUdkawk/L9wH7HI0dhTBTQnT6uUxLIPJFCd4o6gyrF2LhNViwkIcjCm31+qznZWEz6YkgTKH2hIA+t/Y7/ZZyu3utIP4FdRuRkokPRGwFUSWu1LyXnmaWeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693948; c=relaxed/simple;
	bh=QNufQwu49qUDbaZU8zOeuTyYC//8hzwWikdFq7YDBb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiQtIG5pRoWAUdgyRztLyvjROvwnLCpUXEsVMHb8akGlYWlMe/l1h2Yqtvpy2AkoBgyfLX+E5PUJPME5jGPRdc53ahLCdhW4kHVIZcAM3tmsERz0K9zDJPvplgmpD0EIaUoLWkNM5fuFNJS+88QtbBH//YN+s5MLE3tovs+dxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwr1tvJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwr1tvJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EA41F000E9;
	Fri, 10 Jul 2026 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693947;
	bh=gc5ZxilRCi+b43osMX1gwcF6WFNJgRdNElAs0UE8HcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwr1tvJl19SCtmMW6b8HwEc2t1k5WAePSyIovzO7EycstwIuocsRQleQcTv0Lezoc
	 +6Gb0EFoL26Abm2dMreFoAwffZ0+4AO4J2+h49XwWXzdmlCoDvb4OXCz+MJh7IS2qS
	 +KrOln64t/yCrgVRG/5QAqSHenAWPtb1Ev9QFjAUUaRzCn89HOfLa4u0btb8SduBhx
	 WZRjAs55negJVqLz78sX6MSyGsoI2ryERVqjZA0AY8xGrAfcfJ9q0Fh+cFzO7edmg9
	 jZqnQ7C81O7A2jveoGxraR4xuLW1OzvJLi6BUgrlHHoTslMS+ziGFyua1YAXTA1Kl6
	 b6lCwi0yLl6Xw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Fri, 10 Jul 2026 07:32:17 -0700
Message-ID: <20260710143218.26373-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710135608.D627A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 13:56:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `damon_pa_apply_probes` callback fails to implement the newly added `set_samples` parameter, violating the updated API operations contract.
> --
> 
> --- Patch [2]: [PATCH 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address ---
> commit 2da9028945951622496aef07a601ae5bfba7972a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probes() ops callback to set sampling address
> 
> This commit updates the DAMON ops callback apply_probes() to accept a
> set_samples boolean parameter. The parameter allows the callback to setup
> the sampling address per region to minimize unnecessary regions iteration.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index d8251c83e6e55..aee28b05acc6c 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -647,7 +647,8 @@ enum damon_ops_id {
> >   * It should also return max number of observed accesses that made as a result
> >   * of its update.  The value will be used for regions adjustment threshold.
> >   * @apply_probes should apply the data attribute probes to each region and
> > - * accordingly update the probe hits counter of the region.
> > + * accordingly update the probe hits counter of the region.  It should also
> > + * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
> >   * @get_scheme_score should return the priority score of a region for a scheme
> >   * as an integer in [0, &DAMOS_MAX_SCORE].
> >   * @apply_scheme is called from @kdamond when a region for user provided
> 
> [ ... ]
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 6172464981730..b13bf7c6eade3 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> [ ... ]
> > @@ -166,7 +166,7 @@ static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
> >  	return pass;
> >  }
> >  
> > -static void damon_pa_apply_probes(struct damon_ctx *ctx)
> > +static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> >  {
> >  	struct damon_target *t;
> >  	struct damon_region *r;
> 
> [Severity: Medium]
> Will callers passing set_samples=true end up using stale sampling addresses?
> 
> The documentation in include/linux/damon.h states that apply_probes should
> set &damon_region->sampling_addr if set_samples is true.
> 
> However, the updated damon_pa_apply_probes() does not seem to handle the
> new parameter:
> 
> mm/damon/paddr.c:damon_pa_apply_probes() {
>     ...
> 		damon_for_each_region(r, t) {
> 			int i = 0;
> 			phys_addr_t pa;
> 			struct folio *folio;
> 
> 			pa = damon_pa_phys_addr(r->sampling_addr,
> 					ctx->addr_unit);
>     ...
> }
> 
> It reads the existing r->sampling_addr without generating a new random address
> when set_samples is true.

No issue since no caller sets set_samples true.

And a later patch in this series will respect the argument before a caller sets
it true.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=2


Thanks,
SJ
