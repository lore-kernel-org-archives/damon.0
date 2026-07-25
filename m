Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AA2E7BD6
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016467; cv=none; b=Bw8KpcghpNrqaURac3DuEi2/+rjRn+bqFwAG+CrZiLwgP1m/oCq/vI9npVB/BfTanQ7BWpm1+FiWZYvdcnu4B6xW7KFTzD1Eu3sLOd1qoqiTSue/OWciZVBs174mbXW8Y4ySNVpGO2DLxx2c/9pL7U3CjQ6nEj885WRI59QPHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016467; c=relaxed/simple;
	bh=yq3F94TyljL3s2J2VX0PSsGMz5+ItrK3b7MZXOYPigo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDkVVCgBM5BGL5yasuSJ4zRkct9OfqWbgVT6s04E2p/5eLmU+FGsV/rfs8sJz9DZWqkpq1Ofncr4tytl5oZlNJst0qp+YzAUhgMpeqnEjyF/gQO6gJ3xNk5Tn/AiNoPIkCVuY/qwqv7H6R622WKZW6X9EKufJtTXmvp+QbNFWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX9Z8Fre; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX9Z8Fre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061EF1F000E9;
	Sat, 25 Jul 2026 21:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016466;
	bh=kQmKAeBcUjJxM8XUmKvA93sPzbr93Y4srsD6fPpbYLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gX9Z8FreJ3mih6QF9DOd1XCbZMK+HWAln1HQvMcsMWD6kwBQ4WAAVLHxE+sbcet9e
	 gY9OXFxBTt314npN4BRp4yv+ZyCZMBrnPaRqNECE8GgKezaXT8r/syCVkJijrWxdYx
	 6DvMM0yV9n5qYRLSMnsA4m1YwJEXS+3RXGBmtKNG3xsW54DmHiIm2wahVz+HzX7qk+
	 +nQwVKaSWwF8+lVR8hP44+i/nSaZ+MH6mY7Pa8iKV9CHHPIq/5qQ1UW13VNJpQr9B7
	 0lO8VsHIMQy7vtCgWdWwqJJVOyM0Wp43eQvocKF7VyVnDsJOgDzE5MiKdr6uAiJ2ih
	 fPEx1XLEGIpBw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 08/17] mm/damon/paddr: support damon_prep
Date: Sat, 25 Jul 2026 14:54:12 -0700
Message-ID: <20260725215413.131818-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211530.8164A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:15:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Double randomization of `r->sampling_addr` silently overwrites the prepared address when access checks are enabled, leading to an orphaned prepared page and evaluation of an unprepared page.
> - [Medium] Redundant application of `DAMON_PREP_SET_PGIDLE` causes duplicate expensive rmap walks for the same folio when multiple probes exist.
> --
> 
> --- Patch [8]: [RFC PATCH 08/17] mm/damon/paddr: support damon_prep ---
> commit 4bd5ea4d30cf668863712fb6c9fd487551e2b59c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support damon_prep
> 
> This commit implements the prep_probes() callback for physical address 
> operations. It supports the DAMON_PREP_SET_PGIDLE action by unsetting page 
> table accessed bits and setting the PG_Idle flag.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 199de1463fa06..8d8fcd1369e56 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> 
> [ ... ]
> 
> > +static void damon_pa_prep_probes_region(struct damon_region *r,
> > +		struct damon_probe *probe, struct damon_ctx *ctx)
> > +{
> > +	struct damon_prep *p;
> > +
> > +	damon_for_each_prep(p, probe) {
> > +		switch (p->action) {
> > +		case DAMON_PREP_SET_PGIDLE:
> > +			damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr,
> > +						ctx->addr_unit));
> > +			break;
> 
> [Severity: Medium]
> Will this result in redundant expensive rmap walks if multiple probes share
> the same prep action?
> 
> When iterating over all probes in damon_pa_prep_probes(), this is called for
> each probe. If a user configures multiple probes with the pgidle_unset
> filter in a single context, it looks like damon_pa_mkold() will be invoked
> multiple times for the same sampling_addr, causing duplicate folio rmap
> traversals.

Yes.  But wise users wouldn't set preps in such ways.  No issue.

> 
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_target(t, ctx) {
> > +		damon_for_each_region(r, t) {
> > +			if (set_samples)
> > +				r->sampling_addr = damon_rand(ctx, r->ar.start,
> > +						r->ar.end);
> 
> [Severity: High]
> Does this conditionally overwrite the sampling address that was already set
> and prepared?
> 
> In mm/damon/core.c:kdamond_fn(), prepare_access_checks() and prep_probes()
> can both be called in sequence:
> 
>     if (!access_check_disabled && ctx->ops.prepare_access_checks)
>         ctx->ops.prepare_access_checks(ctx);
>     if (ctx->ops.prep_probes)
>         ctx->ops.prep_probes(ctx, has_prep);
> 
> If a user configures a probe with weight=0 and a prep action,
> access_check_disabled is false and has_prep is true. Since has_prep is
> passed as set_samples, damon_pa_prep_probes() will overwrite the
> r->sampling_addr that was just prepared by prepare_access_checks(). This
> would leave the originally prepared page orphaned and cause an unprepared
> page to be evaluated.

I told I will fix patch 7.

> 
> > +			damon_for_each_probe(p, ctx)
> > +				damon_pa_prep_probes_region(r, p, ctx);
> > +		}
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=8


Thanks,
SJ
