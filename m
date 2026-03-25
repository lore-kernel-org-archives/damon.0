Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D521D3D6;
	Wed, 25 Mar 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450669; cv=none; b=ekAaGWKhnJh6T27roxjSxqrQTqvLXMUT0dXg30s+8jPPksNAhopxOlDOEXG1iWEs8uFhpSejL2Y/4ScxpFFC2ILB15Exz9lX2XuYhjY3fiskkHtAh6OCdiKIfJ5njAYAgcMjb6K7M6YXjMnUg6kzDK67VXychBw26tvKbumLfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450669; c=relaxed/simple;
	bh=4GSx9AFpoG65jD6G5Qw9iA42wbY1V+x5tjlC4TYn/Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8q/eUrK5eRLmPltEkdfyXaTpvhcyQAeHCGS3CRPgU+Akgeiaqt+Ab/oC9apTTwHAUkBuBQicKHkeMZsJxYfh+ybD6VHLlMeptdAEiQSNSHfzN1UmFGlXjTF5F8qJcDxcXGviAYgO9sXhlKDrRvMvIAQOr+bmFG8F2u/W8EXKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEOslwJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEOslwJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BEEC4CEF7;
	Wed, 25 Mar 2026 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450669;
	bh=4GSx9AFpoG65jD6G5Qw9iA42wbY1V+x5tjlC4TYn/Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEOslwJi/G72R/9cw2jvefeEooIwtA/tWDtu94soIPyrp6E4GtJSyOMD5vo434/sl
	 GAuipYBrAJNnlziQrYKt56w1kyGFaVSEbp266M5ujvSGmBqoMp9cqN17EAWB0T9T74
	 zuyNP82UYB7syRO78z1WbrF65un0PRV7mdXC5ICsZWOXtFKafTzBIclqx3B3oU47s9
	 aNw+3EXcSeag0D+xIRs+Kl2vFl063Lo7uMntSbwq5SZwDQRtGFYyDcSAc8Djv33VA6
	 jsABWtSQB9+C09XVxTfIACinDKoDhdKNxYDnHnTI7/Rm00CUkwh0HC7tC7buunMfQ7
	 1DnR9TdoKXJsw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Josh Law <objecting@objecting.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Wed, 25 Mar 2026 07:57:47 -0700
Message-ID: <20260325145747.88132-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325011653.85502-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 18:16:52 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260324154005.83651-1-objecting@objecting.org
> # start of sashiko.dev inline review
> commit ff5e227a18cd69435749b0aae0dc2c762c4f0a47
> Author: Josh Law <objecting@objecting.org>
> 
> mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
>     
> Hardware integer division is slow. The function damon_max_nr_accesses(),
> which is called very frequently, performs an integer division.
> However, the struct damon_attrs already caches this exact ratio in the
> internal field aggr_samples. We can eliminate the hardware division in
> the hot path by simply returning aggr_samples.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index d9a3babbafc1..04c8a052fcfb 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -978,8 +978,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> >  {
> >  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> > -	return min(attrs->aggr_interval / attrs->sample_interval,
> > -			(unsigned long)UINT_MAX);
> > +	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
> >  }
> 
> If an administrator dynamically updates aggr_interval via sysfs and commits
> the inputs, will attrs->aggr_samples be correctly recalculated?
> 
> If aggr_samples becomes stale, kdamond_fn() will compute the real aggregation
> loop count and allow r->nr_accesses to increment up to the new bounds (for
> example, 80 loops). Meanwhile, damon_max_nr_accesses() will return the
> stale aggr_samples cache (for example, 20).
> 
> When evaluating schemes, damon_hot_score() normalizes r->nr_accesses against
> this stale maximum, producing a freq_subscore that severely exceeds
> DAMON_MAX_SUBSCORE. This causes the calculated hotness to exceed
> DAMOS_MAX_SCORE.
> 
> For DAMOS_PAGEOUT actions used by damon_reclaim, damon_cold_score() returns
> DAMOS_MAX_SCORE - hotness, yielding a highly negative score.
> 
> Could this negative score cause an out-of-bounds write on the
> kernel heap when used as an array index?
> 
> mm/damon/core.c:damos_walk() {
>     ...
>     c->regions_score_histogram[score] += damon_sz_region(r);
>     ...
> }

I didn't take deep look here, but sounds like true.  I also had similar
concern.

But this takes too much time for the small optimization, so I suggested another
direction.  So I will not take more time on this sashiko comment.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..afb058f7da5c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -587,6 +587,7 @@ struct damon_ctx *damon_new_ctx(void)
> >  	ctx->attrs.sample_interval = 5 * 1000;
> >  	ctx->attrs.aggr_interval = 100 * 1000;
> >  	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
> > +	ctx->attrs.aggr_samples = 20;
> 
> Since this value is cached here, but not updated when intervals change, does
> it remain permanently stale during dynamic updates?

Ditto.


Thanks,
SJ

[...]
