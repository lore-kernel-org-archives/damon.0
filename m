Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F792C2EA
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645298; cv=none; b=Ee78FvRf39HGpaZ56ElfGt3a2KtoTr0X/TgnTSsRtvwwirths2pSjbA83kbvyDGVOWm9jOHz0aPXMkC0arnhFaDKypy8tvNxCONjKQ+4knKdpEtx9JasbyepOnIAiVUOvranr2hQid6lQJi3mOTRK2CjGZB1vqd1rI0N64d6xqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645298; c=relaxed/simple;
	bh=aRWQNRCzrbuvnrZB+pbBRqeE0Du67jgbbvxR/5jvaRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrpnrXLIB/XPx4t5jge+Jg13fskjPvB2BgE2kj/0NLJoB8aFnJiX3QIoO3xvdU2MY4OzwMBXQM5KZ/oriHQKEa/MDYQADk9mj4pecM8PXFALmW9+12nDkgaKe0qPMfoQi0/c80jr5ps3BgxxKdCVnhGhO8w+0TLczUP9KXgd1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr+H7wkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr+H7wkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06DD1F000E9;
	Fri, 10 Jul 2026 01:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783645297;
	bh=kMBywnre75w713QUtP90+zygurw0d2d7jl2XzuKs2rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kr+H7wkXG1OCWDPaHA/yfNxtP2r4pxdIZSpP6V245u2fAqC4M8Sp/W6PiyEFT2Ysw
	 fm1b5tHW6/PcMlnuloESunVPpVV58W3k9S6EbaGI77LJmZxoQV/Y5BtLwyMf8du1/C
	 bOquG2+5PfFydehdA/nDHbkTco8maWjycSQecfIBJQkflqFrp6yT9uXisKKGfsnLjF
	 Vz9BYolvj6hpqwk8qwv+RCvk6e8KwqhZfpT20NGkffNq8F9Vk5aUZQcw4WfDXaRyYE
	 HWej6abug+zu3qb+GKjTKIWbs4vQ3cjFJPHhz71Sd8Yonapo91yIkzqB4N6EgsWd3Q
	 BNIpgUlhOo16Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Thu,  9 Jul 2026 18:01:28 -0700
Message-ID: <20260710010129.112598-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710003328.23B831F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 00:33:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `set_samples` parameter in `damon_pa_apply_probes()` is ignored, failing to set `r->sampling_addr` when requested.
> --
> 
> --- Patch [2]: [RFC PATCH v1.3 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address ---
> commit 5855b0123b327412c4065a90363e8586c4bafda9
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probes() ops callback to set sampling address
> 
> This commit updates the protocol for the DAMON apply_probes callback to
> accept a boolean set_samples argument. It updates the callback signatures
> so it can handle sampling address setup in the future to minimize region
> iteration.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index d8251c83e6e55..aee28b05acc6c 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -647,7 +647,8 @@ enum damon_ops_id {
> >   * It should also return max number of observed accesses that made as a result
> >   * of its update.  The value will be used for regions adjustment threshold.
> >   * @apply_probes should apply the data attribute probes to each region and
> > - * accordingly update the probe hits counter of the region.
> > + * accordingly update the probe hits counter of the region.  It should also
> > + * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
> >   * @get_scheme_score should return the priority score of a region for a scheme
> 
> [ ... ]
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 6172464981730..b13bf7c6eade3 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
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
> Does this implementation actually use the new set_samples parameter?
> 
> The updated documentation in include/linux/damon.h states that apply_probes
> should set the region's sampling_addr when set_samples is true, but it
> appears this parameter is ignored in damon_pa_apply_probes() in
> mm/damon/paddr.c.
> 
> While it is currently called with false from kdamond_fn(), if future code
> passes true as the docstring suggests is possible, could this result in
> using a stale or uninitialized address because the API contract is not
> fulfilled here?

Intentional.  The later patch of this series implement that.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710002349.111414-1-sj@kernel.org?part=2


Thanks,
SJ
