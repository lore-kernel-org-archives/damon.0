Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EF36921B
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608511; cv=none; b=WxvpG7tamN4pJ3kK8HWZQnNBp+quTWvy5ipNq+CBOX/XbIPM2RCuFm2Uaz6JncmWsZS5qDMTWL2IwEL3KdiZIe4vmHHhIHDq/tThPW9+ZhoeBcu6C1/7Dwm2yyznESaxy9ThgZhXPGxsbi0gHJv0AE++gF6jqC3Tae1zaf7qM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608511; c=relaxed/simple;
	bh=UJDf8MvOXKD/cRvvMs+Y3601NVIec3kQA0bGaUmmGbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUBkMHctWmzwGi2Aidl5bmkd3SluAT7yP+WvGeQ0C1g1YHVl8xeBv3lL8OUoZ7YVU6TVIGZOPeDhEhzWw4ZaiZCZxBX8YrsxcUzrTbg15QdwIDbn/XJkwWBEdXgEaBUyxUdGIyJ8kw+wT0mmB7Yu+5BKsPT6tb6fAuhFfy5FsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh9LESRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh9LESRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EE51F00A3A;
	Thu,  9 Jul 2026 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608509;
	bh=G6laBL9MA0fwfw81Ho5Zv8nG/DOO/+OSNR0pbc8I8hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zh9LESRup1akByFVQb6GUsTrIdUZ7swX+PK5oHkQ3SDV2tZaekeUltj7ZMoHNlxGE
	 p58WSWVUqlX5mQ/gGX1Qy2Rbf2gon3IcKRSbmBunMaSmpimLk5mRrjJ8x6fieFbWB+
	 yjwraXsT/4fvKQ9ywBVQZJnBScuxONaScSFftl7YQ7T5lHdH+gh+nxGUwJ0YzYpd2B
	 O15qbTdYXiY+Mr3oeKD0Qt32LRxEaZUVtglH8QFf0SyX8aVoYqGjccd8ogX0LHx6HV
	 VGYRxrM6tKRTE5YIbPnSRepkCFM1n1Q5fEFtpV4+af/B0VJpr8IQvSLVDIehqgTiyS
	 KbyrbYM670NyQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 03/19] mm/damon/paddr: set samples in apply_probes() if requested
Date: Thu,  9 Jul 2026 07:48:19 -0700
Message-ID: <20260709144821.95966-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709142103.36E231F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:21:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in `r->probe_hits[]` counter when `aggr_samples` exceeds 255.
> --
> 
> --- Patch [3]: [RFC PATCH v1.2 03/19] mm/damon/paddr: set samples in apply_probes() if requested ---
> commit 81ba2fab5bb28d260739f7b8c81129066d602897
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: set samples in apply_probes() if requested
> 
> This commit updates the apply_probe() callback implementation in DAMON_PADDR
> so that it respects the set_samples parameter.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index b13bf7c6eade3..ff4fcca949660 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -178,6 +178,10 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> >  			phys_addr_t pa;
> >  			struct folio *folio;
> >  
> > +			if (set_samples)
> > +				r->sampling_addr = damon_rand(ctx, r->ar.start,
> > +						r->ar.end);
> > +
> >  			pa = damon_pa_phys_addr(r->sampling_addr,
> >  					ctx->addr_unit);
> >  			folio = damon_get_folio(PHYS_PFN(pa));
> 
> [Severity: High]
> This is a pre-existing issue, but does this code overflow probe_hits[]?
> 
> Looking at include/linux/damon.h, probe_hits is defined as an unsigned char
> array:
> 
> struct damon_region {
> 	...
> 	unsigned char probe_hits[DAMON_MAX_PROBES];
> 	...
> };
> 
> Immediately following the code in this diff, damon_pa_apply_probes()
> unconditionally increments the counter:
> 
> 			folio = damon_get_folio(PHYS_PFN(pa));
> 			damon_for_each_probe(p, ctx) {
> 				if (damon_pa_filter_pass(pa, folio, p))
> 					r->probe_hits[i]++;
> 				i++;
> 			}
> 
> If a user configures DAMON via sysfs with an aggr_interval and sample_interval
> ratio that yields more than 255 samples per aggregation interval (for example,
> aggr_interval=100000us and sample_interval=100us), this counter will silently
> wrap around.
> 
> Could this cause heavily accessed regions to wrap to a small number and appear
> cold, potentially leading DAMOS to make incorrect memory eviction or migration
> decisions?

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=3


Thanks,
SJ
