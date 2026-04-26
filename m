Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD2441A6
	for <damon@lists.linux.dev>; Sun, 26 Apr 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777223345; cv=none; b=RcSYkOZXkGKyfVLPxw3/+VfemLy47YnT8qEy5sFpIWpFWvlBs42eW4MiO4NvPdBxuMJOygbAR/3RdYk3pwjMcPLiAer48l8xIw4460u7sQF8u8XhrBgygGLnBZ+u0ZLqqHxu7OS2QHKjAgNFK4XA2l3hIn2ErVaxHeIq4YINDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777223345; c=relaxed/simple;
	bh=2ci3J7kWyvLKPO5+/5oqqswGoUeecWW/VVuBsG/iqEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ2xEUMwznxqZ90nNGepOFYhtxcYWJH1eZWY1FUti/vusZiBHwsjBwDZuN/Ll7sGxacSwRsu54SbBcVmA7FlUOzAo2nb+9x2EtufXetYvug6RqB4t7naWZLr5GmKuyZ+G1A0wleH/AzLNDeFXMkppJkjxKU6mV0oEzCqMPcHKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKegCJB5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKegCJB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DC5C2BCAF;
	Sun, 26 Apr 2026 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777223345;
	bh=2ci3J7kWyvLKPO5+/5oqqswGoUeecWW/VVuBsG/iqEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKegCJB5TT1jHpPynCwCKr1M23eOjOUeLW1ECVxkSQ1Pi/MwqXG+p6CybSzmBjitV
	 IgAbyOXF5IERXVrAPRXlSGCW11BXPDYJl0go02mYcI0FcuIStTIBexuca/vXwoF7sU
	 OpHuUEQwpubX/M2akqoSpKPkoy8hulfqRHcQtFogwZntqFqPvmiWDUDjYrHN2h1pxO
	 Bv/m5hv4pWLdeyIdm5Z/KbG+eCal1wheLVGio7KD+68OdYkSiYVAlTI+b93eaeZBeK
	 W1vgF/TIblq96bXn9pCNar50jIzE5innrDw8EcYhgHET/E2l0vjN2emz+5uauFXW6v
	 zJ03N3BITLndA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v8] mm/damon: add node_eligible_mem_bp goal metric
Date: Sun, 26 Apr 2026 10:08:56 -0700
Message-ID: <20260426170858.85836-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426005341.B393EC2BCB0@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 00:53:41 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 4 potential issue(s):
> - [High] Casting phys_addr_t to unsigned long causes truncation and potential divide-by-zero on 32-bit systems

This is a new and good finding.  Ravi, could we fix this?

> - [High] Missing cond_resched() inside the PFN-scanning loop leads to CPU soft lockups

Unlikely.

> - [High] Synchronous O(N) full-memory scanning defeats DAMON's bounded-overhead design

Intentded design.

> - [Medium] damos_calc_eligible_bytes() skips core filters, corrupting the metric calculation

Intended design.

> --
> 
> commit efcd6d55e5292f8b5cd0c6202c9d95000e99dc4c
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> 
> mm/damon: add node_eligible_mem_bp goal metric
> 
> This commit introduces a new quota goal metric, DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> to track the ratio of scheme-eligible memory on a specific NUMA node. It
> implements calculation functions that iterate over eligible regions and examine
> the NUMA node of each folio.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3dbbbfdeff71..a9303a8c4384 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2287,7 +2306,112 @@ static unsigned long damos_get_node_memcg_used_bp(
> [ ... ]
> > +static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
> > +		struct damos *s, int nid, phys_addr_t *total)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	phys_addr_t total_eligible = 0;
> > +	phys_addr_t node_eligible = 0;
> > +
> > +	damon_for_each_target(t, c) {
> > +		damon_for_each_region(r, t) {
> > +			phys_addr_t addr, end_addr;
> > +
> > +			if (!__damos_valid_target(r, s))
> > +				continue;
> 
> Does this also need to check damos_core_filter_out(c, t, r, s)? By skipping
> the core filters, the eligible bytes calculation might erroneously include
> memory that the scheme is explicitly configured to ignore.

As previously answered, this is an intended design.

> 
> > +
> > +			/* Convert from core address units to physical bytes */
> > +			addr = (phys_addr_t)r->ar.start * c->addr_unit;
> > +			end_addr = (phys_addr_t)r->ar.end * c->addr_unit;
> > +			while (addr < end_addr) {
> 
> Since DAMON is designed to provide low, constant-overhead memory monitoring via
> region-based tracking, does performing a synchronous PFN-to-folio lookup for
> every physical page across all eligible regions break this bounded-overhead
> contract?

The bounded onverhead is only for monitoring part.  It is not promised for
DAMOS.

> 
> Because this function is called on every quota reset interval, scanning
> potentially gigabytes of memory might introduce severe latency spikes and CPU
> overhead.

So no problem.

> 
> Additionally, since DAMON regions can cover extremely large areas of memory,
> should cond_resched() be called inside this inner while loop rather than
> outside it? Iterating through millions of pages without yielding might trigger
> RCU stalls and soft lockups.

Unlikely.  We could improve this when such issue really happens and is
reported.

> 
> > +				struct folio *folio;
> > +				phys_addr_t folio_start, folio_end;
> > +				phys_addr_t overlap_start, overlap_end;
> > +				phys_addr_t counted;
> > +
> > +				folio = damon_get_folio(PHYS_PFN(addr));
> [ ... ]
> > +
> > +				/* Advance past the entire folio */
> > +				addr = folio_end;
> > +				folio_put(folio);
> > +			}
> > +			cond_resched();
> > +		}
> > +	}
> > +
> > +	*total = total_eligible;
> > +	return node_eligible;
> > +}
> > +
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
> > +		struct damos *s, int nid)
> > +{
> > +	phys_addr_t total_eligible = 0;
> > +	phys_addr_t node_eligible;
> > +
> > +	if (c->ops.id != DAMON_OPS_PADDR)
> > +		return 0;
> > +
> > +	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
> > +		return 0;
> > +
> > +	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
> > +
> > +	if (!total_eligible)
> > +		return 0;
> > +
> > +	return mult_frac((unsigned long)node_eligible, 10000,
> > +			(unsigned long)total_eligible);
> 
> Can casting total_eligible from phys_addr_t to unsigned long cause a
> divide-by-zero on 32-bit systems?
> 
> On 32-bit architectures with PAE, phys_addr_t is 64-bit while unsigned long
> is only 32-bit. If the total eligible memory is exactly a multiple of 4GB,
> the 64-bit value passes the if (!total_eligible) check, but the truncated
> 32-bit value passed as the divisor to mult_frac() evaluates to 0, which
> would trigger a kernel panic.

Good finding.  Ravi, could we fix this?  Maybe we can simply remove the
casting?

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260426003245.2687-1-ravis.opensrc@gmail.com?part=1


Thanks,
SJ
