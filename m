Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2B3A3815
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214634; cv=none; b=aLjU9HJyPr+QZgS0tLqsu5mIRhRV7KkbVvuDyURbbMyGlR8VmezVxlitWA46YNHl8qXCqx2sIz3XRuWMhdoZZuhliRe5ISDSOpuWrGjdDR6p1ESOLu+Vx34qJMGu7/aKQfi6TeirCt1VxNHDa5rWufqoC9bs8GkJJa1jd1J1TOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214634; c=relaxed/simple;
	bh=8GlkwnQLXbaVWEOh5tXoRWSpQhWuW18sHaMniAGJV7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIJvpBcE/Up2IJRWmUrMWPBhI9tQ+7JqxW31eiAqtaD9Z2pbJJ39DoYjDnR5GauzBdv30V9mtVmrOuLFFWmE4e35kDaEnQaw7YuBRlYaE4UMa2b4sr2dXenGLY9wtRJT1m7GqR+VOm3C8aeTX1PsqNgVzyTaXPtPmSh/K6vgG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSJyh0JN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSJyh0JN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0D91F000E9;
	Tue, 28 Jul 2026 04:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785214632;
	bh=bk87TJYg/W7+I5qmYx+qdRFQMVvRhK4t0qrE9QaOxdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSJyh0JNEQG8q/d5F00uCF8HV+v+GCpV29j5IHlYW4iknx/tqxW3ZVL4cd8o9enQ9
	 bjwtA+H87qaQ6ZZt3g2LREgdr6/o+kOVFgA/ev6R1+xplP7f18B0hxJmKeYpuoPSOd
	 jat5knqD0dOG1dqjne72CZ4NVrpmtke0mlXO78pAgAl4oqX6107JYELCykwHxOlkgm
	 XzRxawrvCMkQqNWdfDgg9ITKXdevF3LEw1PyTxlQsX5mHCVU0K2rIceczwNYAtaOgQ
	 2xjpf3gdvP2/gThQ3Nm91xi+nQgHz3VUcxDYrmr/7vNPBwbJj/ksZeMRLTslQFaUIW
	 LgfIUri7d4QbQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 08/17] mm/damon/paddr: support damon_prep
Date: Mon, 27 Jul 2026 21:56:59 -0700
Message-ID: <20260728045700.189863-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728042457.48D531F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 04:24:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] damon_pa_prep_probes() executes prep actions redundantly and ignores probe filters, causing excessive rmap walks and global LRU degradation.
> --
> 
> --- Patch [8]: [RFC PATCH v2.2 08/17] mm/damon/paddr: support damon_prep ---
> commit 5d5b08fab7578294743c8bbbba6c3bfa16036115
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support damon_prep
> 
> This commit implements the damon_operations->prep_probes() callback to
> support the DAMON_PREP_SET_PGIDLE action. It unsets page table accessed
> bits and sets the PG_Idle flag, similar to what is done for access check
> preparation.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 199de1463fa06..8d8fcd1369e56 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> 
> [ ... ]
> 
> > @@ -105,6 +105,40 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
> >  	return max_nr_accesses;
> >  }
> >  
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
> > +			damon_for_each_probe(p, ctx)
> > +				damon_pa_prep_probes_region(r, p, ctx);
> 
> [Severity: High]
> Does this code redundantly execute damon_pa_mkold() and ignore probe filters?
> 
> In kdamond_fn(), if standard access checks are enabled, both
> prepare_access_checks() and prep_probes() can execute on the same tick:
> 
>     if (!access_check_disabled && ctx->ops.prepare_access_checks)
>         ctx->ops.prepare_access_checks(ctx);
>     if (do_prep)
>         ctx->ops.prep_probes(ctx, access_check_disabled);
> 
> Because prepare_access_checks() also calls damon_pa_mkold(), the subsequent
> iteration over all probes here unconditionally calls it again on the exact same
> sampling address for every probe configured with DAMON_PREP_SET_PGIDLE. Since
> damon_pa_mkold() performs a costly rmap_walk, this multiplies the overhead.

That's true, but no problem.  Sane users may not use the classic monitoring
with set_pgidle prep.

> 
> Additionally, this loop does not evaluate probe filters (such as MEMCG or
> ANON) before applying prep actions. Could this blindly clear the accessed bit
> for all sampled pages globally, artificially aging pages that the user
> explicitly excluded and degrading system-wide memory reclaim decisions?

Yes, and that's the intended behavior.  If user asks to set pgidle, DAMON sets
pgidle.

> 
> > +		}
> > +	}
> > +}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728041242.187380-1-sj@kernel.org?part=8


Thanks,
SJ
