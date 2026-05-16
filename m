Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B941F30A4
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968024; cv=none; b=hKISLLttqqt4wDXhiTT2+9CKLrC/nQG7tr/oo4RrwBry0ScQpuXlath/DGUYvgTnMeXu6UkLd+PMB6Xnfs0npWYjIbsQP4dUkXm5PzDtuPrMFYjoFLGXtz+NmLKFsHMKCGvJTgR4ksrK4WvCTwwYuECQmbWTrBLzNHi9+2vHqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968024; c=relaxed/simple;
	bh=6bxbA0df3MkrYVobA03478kxkDZHetZ+INLZ0WHV/OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBKLDRSM8zuTGr8tPFmrql5lAj+3L3p8tDOW+ENoAJ2VRYPFVVDRzy3+juGVLsdyYdL8KZY0yHYiLnGbFxXJSzqamWk9KgG4uIkRL+8s3CEknJJ4qudgEdhYqZZpass8XrWWlFr+hb0iONYhO1MN+PEIUCsEPAFj7tqaH+Mga4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRjR7+e9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRjR7+e9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D37CC19425;
	Sat, 16 May 2026 21:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778968024;
	bh=6bxbA0df3MkrYVobA03478kxkDZHetZ+INLZ0WHV/OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRjR7+e9wuK5q/ucHygr8cr+pAfSj+IfaCitPtgc2pbc3TXdPcoZ9+rnFLk6bt1rO
	 OS90wVfW8ddlIaxfaAvJc4mpZooxjR4kBLgFdS5qyqA/zWSOChEcKhtVtOPcvt56CR
	 tr1+gQ7iLGJIYxfJCILZE1EySdmafz9kPm17zfaSLc41MJ3+qlLp5C8jYiXPC/oSi5
	 rzwUBm7gHdynnsfs3GnlM0naS3i7OaJ19vTQc7z1LpfIbtNtRuN09ng3wlbZ9/YHhn
	 oC2tsnwmrqZfXHzin42/jRVCurbEPPy6ORbDUPXJVHXPYh5wQe+bjbdIwETCK4VZ83
	 N3eDqLzZcgxwQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 08/28] mm/damon/paddr: support data attributes monitoring
Date: Sat, 16 May 2026 14:46:21 -0700
Message-ID: <20260516214622.3227-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516190531.F268CC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 19:05:31 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Brittle filter evaluation logic in `damon_pa_filter_pass()` causes unpredictable default fallback behavior.
> - [High] Silent integer overflow of `r->probe_hits[i]` due to an 8-bit limit.
> - [High] Costly page lookups and folio refcount operations are unconditionally performed even when no probes are configured.
> --
> 
> commit 3ac6d88b44843f7304cd50448ef416c14428371c
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/paddr: support data attributes monitoring
> 
> This commit implements the apply_probes() callback for physical address
> space monitoring in DAMON. It introduces filter evaluation and applies
> probe hits to region statistics.
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> 
> [ ... ]
> 
> > +static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
> > +		struct damon_probe *p)
> > +{
> > +	struct damon_filter *f;
> > +	bool pass = true;
> > +
> > +	damon_for_each_filter(f, p) {
> > +		if (damon_pa_filter_match(f, folio)) {
> > +			pass = f->allow;
> > +			break;
> > +		}
> > +		pass = !f->allow;
> > +	}
> > +	return pass;
> > +}
> 
> If a folio does not match any of the filters, the loop continues and pass
> is repeatedly updated to the inverted allow flag of each evaluated filter.
> 
> When the loop finishes, the final returned result is purely the inverted
> allow flag of the last filter in the list.
> 
> Is this arbitrary fallback logic intentional?

Yes, intentional [1].

> 
> [ ... ]
> 
> > +static void damon_pa_apply_probes(struct damon_ctx *ctx)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_target(t, ctx) {
> > +		damon_for_each_region(r, t) {
> > +			int i = 0;
> > +			phys_addr_t pa;
> > +			struct folio *folio;
> > +
> > +			pa = damon_pa_phys_addr(r->sampling_addr,
> > +					ctx->addr_unit);
> > +			folio = damon_get_folio(PHYS_PFN(pa));
> 
> Because damon_pa_apply_probes() executes unconditionally on every sampling
> interval, damon_get_folio() and folio_put() will be called globally across
> all regions even if the user has not configured any probes.
> 
> Could we add an early return or check if ctx->probes is empty before
> performing these expensive atomic refcount operations on the hot path?

The user can set the maximum number of regions, and this is arguably not a hot
path.  So no blocker.

> 
> > +			damon_for_each_probe(p, ctx) {
> > +				if (damon_pa_filter_pass(pa, folio, p))
> > +					r->probe_hits[i]++;
> 
> The r->probe_hits[i] counter is declared as an unsigned char in
> struct damon_region, which has a maximum value of 255.
> 
> Since the number of samples per DAMON aggregation interval is configurable
> and can easily exceed 255 in standard use cases, won't this counter
> silently wrap around to 0 and corrupt the monitoring statistics?

No blocker [2].

> 
> > +				i++;
> > +			}
> > +			if (folio)
> > +				folio_put(folio);
> > +		}
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516183712.81393-1-sj@kernel.org?part=8

[1] https://lore.kernel.org/20260516005632.144711-1-sj@kernel.org
[2] https://lore.kernel.org/20260516003559.141476-1-sj@kernel.org


Thanks,
SJ
