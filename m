Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DC1E5B64
	for <damon@lists.linux.dev>; Sun, 12 Jul 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783876959; cv=none; b=r+CLFFgIMPrRZ9UYltyMzDVfwkAKukFDfFBKz9392gEs0R2OfyjcQR305JAldMykgbjNbNm21Z30UeNGua82RcAHxsqlbJZ+UqW6gaSeGf6TZHgjaviQbHVjYm83BO/jgsq9Ic+kJXBzbkY15KNPM7bq1TNI1s7qjFbHL3xA+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783876959; c=relaxed/simple;
	bh=Uns6Ji5qnm19o6coUYlLmBoG980uJJcg+FbsehV1iak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBANKs1KvVFZ7HGkkPdm3w6Z+HkQdP12ZKLm2NLupI7sseenmEJ5hLDdKhMOy740pDiXg7WkSQ4bL1ZUBu+4aQ9EBx8Bl4Xe6lP2jfK5Q60Z6uY4+F0pxHvGc1jie6pADx3hWxUq0aEbIphYjB4/NIV6RC2rERxt9fvbzDhFCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWTN0477; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWTN0477"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17521F000E9;
	Sun, 12 Jul 2026 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783876957;
	bh=JfUcHbvObrjwonBGf/mo/E52rfkB+yaCMMTRYgydFXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWTN0477RHlv72XYsvaC7EVIU3GeqXS+9QddFzvo+LCT/JmFcROrHEjL+7nZ2g6tS
	 YUjfOPlINVZzzMuUehTpuEg2tc6ba8Ch+vQLMyydjjVK7G7sht53/0rvkRzzHBWBgB
	 QcqDFyrO4ZKIeQChVVeAk7LQMqVU9sj+amKU7T/16XXOSCYkSjthVfAeGO8MRJXqMz
	 NvmfjLQtJIeGpu2ND/zcxpYTt37XG5g7uHX1XaCijzBMS7oGJMRs6V++AI6beXlHsz
	 R+YOk85wFEe+dXriyyhCLpkp+VBQT8clqUBuLZIu8uLvqaj7QwT4Q6ogHopuh+PpB/
	 z1jWjMzz886FA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: skip aging from repeated aggressive merging
Date: Sun, 12 Jul 2026 10:22:28 -0700
Message-ID: <20260712172230.92299-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712171021.D10321F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 12 Jul 2026 17:10:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `kdamond_merge_regions()` can fall into an infinite loop due to integer overflow of `threshold`.
> --
> 
> --- Patch [1]: [PATCH] mm/damon/core: skip aging from repeated aggressive merging ---
> commit 1fa7392cc3fc19083e90cfb01dcfa4f03ebbc373
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip aging from repeated aggressive merging
> 
> This commit modifies the DAMON core to skip aging when repeating region
> merges during corner cases where the number of regions exceeds the
> user-defined maximum limit. This prevents temporary degradation of
> monitoring quality caused by updating region ages multiple times during
> repeated merge operations.
> 
> Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org
> Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3366,15 +3368,18 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
> >  	struct damon_target *t;
> >  	unsigned int nr_regions;
> >  	unsigned int max_thres;
> > +	bool count_age = true;
> >  
> >  	max_thres = c->attrs.aggr_interval /
> >  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> >  	do {
> >  		nr_regions = 0;
> >  		damon_for_each_target(t, c) {
> > -			damon_merge_regions_of(t, threshold, sz_limit, c);
> > +			damon_merge_regions_of(t, threshold, sz_limit, c,
> > +					count_age);
> >  			nr_regions += damon_nr_regions(t);
> >  		}
> > +		count_age = false;
> >  		threshold = max(1, threshold * 2);
> >  	} while (nr_regions > c->attrs.max_nr_regions &&
> >  			threshold / 2 < max_thres);
> 
> [Severity: High]
> This is a pre-existing issue, but can kdamond_merge_regions() fall into an
> infinite loop under certain configurations?
> 
> If a user configures aggr_interval and sample_interval such that their
> quotient (max_thres) exceeds 0x40000000, threshold could overflow in the
> max() assignment above. 
> 
> Since threshold is an unsigned int, doubling it once it reaches 0x80000000
> causes an overflow to 0, which max(1, 0) clamps back to 1.
> 
> If regions cannot be merged further due to the sz_limit constraint,
> nr_regions > c->attrs.max_nr_regions remains true indefinitely.
> 
> Because threshold cycles and never exceeds 0xFFFFFFFF, threshold / 2 never
> reaches max_thres, causing this loop condition to evaluate to true endlessly.

Another patch [1] for the issue is under review.

[1] https://lore.kernel.org/20260712170328.91144-2-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260712165432.87609-1-sj@kernel.org?part=1


Thanks,
SJ
