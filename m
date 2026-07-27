Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13641D137
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164553; cv=none; b=nK9vxHtlXYhDntGzIkiAZFsHVjKLUkZfrpqGLPebKHjj4+roCZSvYOuBiJaBr5TK/K1436vg1S2nG7FP/Pml7ppKzuTOz/hvheps2kLs/r9Txao849xv+YLNezHy0mby2mQWb8UdQjYs7zL1Q8lXLs3z2Sd62W5qhYFd/wCCwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164553; c=relaxed/simple;
	bh=V+sMEiKE7o8SAk2F4Q5Ir6dQKtN7MpPYQ+YtHWf8NuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdKBhxWkLXtcjntWO9UMgNkbZFbwsLr8LKEBSz2Kg/FXUBYMJCG07J3+KQM/X8uY4PlM9fDW97LttFbXyQhfjxNQdrPgLe7hAdNOYyrIFpYjD0OIVE/fuSjZiUnugsLOcGd/pdcZlYNuG6pYvBiORlo0D6S2j16JakmfQGlLf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR/4rC/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR/4rC/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8958C1F000E9;
	Mon, 27 Jul 2026 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164552;
	bh=RoxUQ+JQPDkfq2jc2PE9oz5ECYmcWwwLp/J/Ml6V02I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jR/4rC/SKHD22erP2kgzWWhICP3vN0We/61dzvlVFtXq/P5K9I9VSjgmCwed3GmYv
	 qVdTkijWaNN1S+Ol3wga2Cngp1KDIaqH3IffbAJl/wzdXmX/Kmnd8Ov14YTAYDyY4L
	 Uxik4tKGbe4kKg9kebxmtr5ICoX1ry2J+UQ3UZfZqoyPnDE06RKJD89PkmsJ5b+d11
	 16ZAOEpjODabFptQyyir/Ax3aivw0JDncxom4RHsiLVCAJxf/oFDTojhJ0RSKSVXnJ
	 2ZkqRtELykwqffkLwglHGTBg/i2ALnriSniNeOoQ8iRM2KWPT6PPruWr2pDJzTp97z
	 nzhvTwXinbPSQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 07/17] mm/damon/core: introduce damon_operations->prep_probes()
Date: Mon, 27 Jul 2026 08:02:28 -0700
Message-ID: <20260727150230.87410-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727144422.A29C71F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 14:44:21 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Suboptimal short-circuit order in `kdamond_fn` causes unnecessary list traversals when `prep_probes` is not implemented.
> --
> 
> --- Patch [7]: [RFC PATCH v2.1 07/17] mm/damon/core: introduce damon_operations->prep_probes() ---
> commit 6cf31e4df3b58637535e88cd2f6425680fdfa9e6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_operations->prep_probes()
> 
> This commit introduces a new prep_probes callback to the DAMON operations
> set to execute damon_prep actions during monitoring preparation time. It
> extends the core to check for and execute this callback if provided by the
> underlying operation set.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 127d3a7c27280..19ab80f50bc4b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3870,14 +3882,19 @@ static int kdamond_fn(void *data)
> >  		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
> >  		unsigned long sample_interval = ctx->attrs.sample_interval;
> >  		bool access_check_disabled = damon_has_probe_weights(ctx);
> > +		bool do_prep;
> >  		unsigned int max_merge_score = 0, max_wsum;
> >  		bool get_max_wsum;
> >  
> >  		if (kdamond_wait_activation(ctx))
> >  			break;
> >  
> > +		do_prep = damon_has_prep(ctx) && ctx->ops.prep_probes;
> 
> [Severity: Low]
> Could this short-circuit logic be reordered to check ctx->ops.prep_probes
> before damon_has_prep(ctx)?
> 
> If the underlying operation set does not implement the prep_probes callback,
> evaluating damon_has_prep() first will result in unnecessary list traversals
> during every sample interval in the kdamond hot loop.
> 
> While the probe lists are typically short, evaluating ctx->ops.prep_probes
> first would cleanly avoid this overhead when the callback is unused.

Good suggestion, I will do so.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260727143829.86236-1-sj@kernel.org?part=7


Thanks,
SJ
