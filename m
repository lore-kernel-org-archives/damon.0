Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD0342538
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979570; cv=none; b=m1a7M6hyeuPUYHzR6Lo+PuiLT4WoOSu0xGAuOV5w0eKhf6zCKQ1EUK8aoP5zkH9IFzSLa05vC1ykInK81HMcrKPH0JcoMb/lsN8Oq1sRn/t1qTzy1wABY+XjL2mqWzxUHTkL1Ct+zKac7QpgL2AwKsdqSZ/JY/x/+zdvF2Ww+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979570; c=relaxed/simple;
	bh=+AcGD1UTx35X3koRvDPlEROsbO+oaLazbNLdW7XJQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzWBiW+48C/gpEqy8+xZamV67Ud0ME3Qn5qeI63BZnyeO+J/NUtcVOQT2ak5OAZ8+CmdMEK5GeAbpzyvjEWTLYU+JP5PVTYiVl1ytuDKIJ50ffDye5xT/Xve6K28vBV8u6XyoUDQX2IaLnOMzGCkRDv3nGYvF1HSdt++ojt1Woo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCNoEZ2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCNoEZ2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C41F000E9;
	Sat, 20 Jun 2026 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781979569;
	bh=akeADLAm9VQ+W+I72eH7rKsEj5+PnVuEYSTzXNR8CBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCNoEZ2MpY8M0zFrjOs3FwmhSBQcg9vqcgpLJs4JhweV3gIOU53x9SSVkaHDnTGxK
	 WvNao6FWoNbWEaJlrU0ue/ym2IhhzqM3hN8bNH+uSwDwXbH7uzrf6jgAGeSckMSyxd
	 cGwvCriu7KLtf/+goIF6/DeEpmishzjbdasyroy/szkvjJJVswN1uCdXSbmOYAWEvj
	 RTDgbCDouw2dGeQdSMIkmr1t7lCAW+EBlRBrJcy3C970oDWKmhZ9TFjEsZnXass5Pa
	 XNt1Y1EEpf7vFeS6w+ahXhykFw38EqAlIq8kpcVpkP4xOvPCYKVzPK7L/cXQaFBho6
	 EM5G1OLT4frkg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 05/13] mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
Date: Sat, 20 Jun 2026 11:19:23 -0700
Message-ID: <20260620181925.93600-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620173749.28BE01F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 17:37:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] If a user configures `sample_interval=0` and `aggr_interval=0`, the time difference calculation inside `damon_nr_accesses_mvsum()` underflows, resulting in a huge garbage value for `nr_accesses`. This corrupts sysfs outputs and erratically influences DAMOS operations.
> --
> 
> commit 2a77ab9c787a549b18af4699f5ffa8d3e4d60ca2
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
> 
> This commit modifies the DAMON sysfs interface to calculate region
> accesses using damon_nr_accesses_mvsum() rather than a simple division.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 329cfd0bbe9f3..e648b0f809332 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -159,7 +159,7 @@ struct damon_sysfs_scheme_region {
> >  };
> >  
> >  static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
> > -		struct damon_region *region)
> > +		struct damon_region *region, struct damon_ctx *ctx)
> >  {
> >  	struct damon_sysfs_scheme_region *sysfs_region = kmalloc_obj(*sysfs_region);
> >  
> > @@ -167,7 +167,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
> >  		return NULL;
> >  	sysfs_region->kobj = (struct kobject){};
> >  	sysfs_region->ar = region->ar;
> > -	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
> > +	sysfs_region->nr_accesses = damon_nr_accesses_mvsum(region, ctx);
> 
> [Severity: High]
> Could this lead to an unsigned integer underflow if a user configures
> both sample_us and aggr_us to 0 via sysfs?
> 
> If a user configures sample_interval=0 and aggr_interval=0, the
> intervals bypass the validation in damon_set_attrs(). Inside kdamond_fn(),
> ctx->next_aggregation_sis is updated by adding 0 and never advances,
> but ctx->passed_sample_intervals continues to increment on every loop
> iteration.
> 
> When damon_nr_accesses_mvsum() is called, it calculates the difference:
> 
> mm/damon/core.c:damon_nr_accesses_mvsum() {
>         ...
>         left_window = ctx->next_aggregation_sis - ctx->passed_sample_intervals;
>         ...
> }
> 
> Because ctx->passed_sample_intervals quickly exceeds
> ctx->next_aggregation_sis, does this subtraction result in an unsigned
> integer underflow?
> 
> If left_window becomes a massive value, it appears it would propagate
> through mult_frac() and damon_mvsum() to yield a garbage value for
> nr_accesses. Since __damos_valid_target() evaluates scheme criteria
> using this value, could this cause DAMON to act on wildly inaccurate
> access scores and disrupt system stability?

Good finding.  I will fix this by making damon_nr_accesses_mvsum() aware of
this case.


Thanks,
SJ

[...]
