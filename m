Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3544A2613
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051849; cv=none; b=msiZIiv5aFqdtsj/GEIe+WK4XParfRcTCFSgjGDXtvpYhuBU16W8PAddFl5kJpIl4In4E0FeZ0+14LhbkKVaYJgcqw9x48ogxQaVt6UcQuVHvKtI3vYuGdg/0QLljfMvX485v3FydVCg90eYu17qSkEQcVvdQknJgVt6p3VP/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051849; c=relaxed/simple;
	bh=yGqM3rMZslxxsVYveGfLFYOLr+Bx8M5Qjl36Eblbt1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGuJBZr8qB5bQSWMn/FMfjMWIk93wGcIB5IFTuHZVQ/YOV1K0uvaqyO0joIiNEltTuFXcbLaP8CH8QKTAvyTFzj7Yj35IAOXpd+G3HrjYZRtEOIDV/GvOLpwSATLw9XRy456wPkfoPRH93qLQBr0LEwDcVCxxeNzSdFthjHhfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsZfqvBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsZfqvBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4311F00898;
	Thu, 10 Sep 2026 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051847;
	bh=nX17aZjZ7y/os8K8axX9zcT/mj2wob0cIc/Z4gxRLRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsZfqvBFxVU2HROjcqEPdKEYHfUJ4M4QFnkaMS19ikPXqhpcWJKtLLnxnbD6jyzHV
	 bIRE+ci3/DPT7bE3N8B/MLSNEO9SglhLlB8M9wpZCVb3npsKPkpJtP4Auhxu/S4HnM
	 ky0LsJ4WlncwHhoDGFtiv+xYgzOop39EsyDPnYkZmWRgsuewXvXm+3+qWiP+WADwLY
	 xLCxYuaZzyXz5gLGZeQjjpUhxCyh9aCDQ8VuTclN86cJzT4p4nWkfogr32K6a+jVDP
	 gjSSCUVvMOWb18q8/DvGSnX7czxdGR5M0eIaf4LCt8ScvjPrr4dV0cBXmarB3TAxbV
	 wLX7UjwxMGYiw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: reset invalid quota->charge_target_from
Date: Thu, 10 Sep 2026 07:50:39 -0700
Message-ID: <20260910145040.175176-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910144335.04D261F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 14:43:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] DAMOS scheme processing permanently stalls if a valid target has zero regions, reproducing the exact lockup the patch intended to fix.
> --
> 
> commit be23af6d135629bfa902e51163989385be75b34b
> Author: SJ Park <sj@kernel.org>
> One-line subject: mm/damon/core: reset invalid quota->charge_target_from
> 
> This commit fixes an issue where DAMOS can suddenly stop working if a target
> process that the quota is fully charged on is terminated. It handles this
> corner case by catching the invalid target and resetting the charge target
> pointer.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 645cb367019ae..06cf2ab7e97d7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3393,8 +3393,15 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  	max_region_sz = damon_region_sz_limit(c);
> >  	mutex_lock(&c->walk_control_lock);
> >  	damon_for_each_target(t, c) {
> > -		if (c->ops.target_valid && c->ops.target_valid(t) == false)
> > +		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
> > +			damon_for_each_scheme(s, c) {
> > +				if (s->quota.charge_target_from != t)
> > +					continue;
> > +				s->quota.charge_target_from = NULL;
> > +				s->quota.charge_addr_from = 0;
> > +			}
> >  			continue;
> > +		}
> >  		damos_apply_target(c, t, max_region_sz);
> 
> [Severity: High]
> This is a pre-existing issue, but does this incomplete fix leave DAMOS
> vulnerable to permanently stalling when a valid target has zero regions,
> or when using operations where target_valid() is not implemented?
> 
> If a DAMOS quota is exhausted while applying actions to a target, saving its
> pointer to s->quota.charge_target_from, and before the next apply interval
> all regions of that target are dynamically removed but the target itself is
> kept valid, kdamond_apply_schemes() will process the target here.
> 
> Because the target has zero regions, the loop inside damos_apply_target()
> is bypassed:
> 
> mm/damon/core.c:damos_apply_target() {
> 	...
> 	damon_for_each_region(r, t) {
> 		...
> 		damon_do_apply_schemes(c, t, r);
> 		...
> 	}
> }
> 
> Consequently, damos_skip_charged_region() is never executed to clear
> charge_target_from.
> 
> When evaluating all other targets, damos_skip_charged_region() will check
> the stale charge_target_from pointer and unconditionally return true,
> skipping all actions and permanently stalling scheme processing.
> 
> Could we ensure charge_target_from is cleared even if the target has no
> regions, or if the target_valid() operation is missing?

No, the issue cannot happen.

If the target has zero region, quota couldn't be fully charged on the target.
So charge_target_from couldn't point the empty region target.

For all operation set that could have invalid target, target_valid() operation
is set.

> 
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910142846.172957-1-sj@kernel.org?part=1


Thanks,
SJ
