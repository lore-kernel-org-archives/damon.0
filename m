Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F1208D0
	for <damon@lists.linux.dev>; Sat, 25 Apr 2026 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077942; cv=none; b=JI/ZXUyIClsoY7oYR5/aa528asFoRvsV7NiWPfc9zaC8bcUPKYNLiXrjAkxS79SdlYtFHJNaBA+3oET/y9Srd53OhYzhbj7PZvBpQ0yO15+2tqG9B9t2DyD9Jyix3S4UBbyraPgoQALjZGrp0UDF3X2/tPgQ6y9sFoabxRSKAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077942; c=relaxed/simple;
	bh=tZQhIfUl8XCGhS1FrdczdDkLm8ia3G0qbumr0/l1sig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/ZSw9/5ELX9A7z1MDsgSGn3H9x01fPSpVJbpI3oPNnXzMtz6tNQW3HzKeJD1XhKaRhsHTQ+XTm35Wi4VgUwmlHrVQgwSEBC4wTlRA4yUv7KXCNAq8S9kovDIjrHLev2dzQmecoMGyKZms3THU/2uM0esoqM8dHaEKyY6eG+E3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d22jWo9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d22jWo9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3224FC19425;
	Sat, 25 Apr 2026 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777077942;
	bh=tZQhIfUl8XCGhS1FrdczdDkLm8ia3G0qbumr0/l1sig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d22jWo9DBp02JGOzrcCA+nW/fZG7iIHhvqa4LrOImCsLLvqOvfCYTa2Cn9hjM0dIY
	 IoOrM/EAF8D3SH8qhBnS1adDp0p98FgkQQpNsgZAMcRSg2mkaKAmUKUHXFSA5Keq+K
	 El5cQV7mr7cd+XLANNV+j+1Bf2B60Sm5qHH5dHhyDei/zlfnQ1Uqbl5vgyU/5bydr/
	 WEECEEdi/SIbU3r81tW2PmebR5DC1u8N3o7hQzPfZ7gNIvnfQ1zxTQNzjWhqebNFb3
	 TH8TUCJQOUJ4osfQZRAY01qFuSB5hN4dO2rJPh+uaKlhBZqh4UQg0MFV14vSGJQPkd
	 Tvf8SYYL+nH2g==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v7] mm/damon: add node_eligible_mem_bp goal metric
Date: Fri, 24 Apr 2026 17:45:31 -0700
Message-ID: <20260425004534.85531-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424205908.CF949C2BCB8@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 20:59:07 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 4 potential issue(s):
> - [High] Integer Truncation and Arithmetic Overflow on 32-bit Architectures

No real problem.

> - [High] CPU Soft Lockups due to Unbounded Physical Address Iteration

Unlikely.

> - [Medium] Missing Core Filters Evaluation Causes Eligible Memory Over-counting

This is intentional.

> - [Medium] Unaligned Address Advancement Truncates Exact Overlap Calculation

I agree to Sashiko.

> --
> 
> commit d92efd581a7b3318becfa32765dc87547acb91c6
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> Subject: mm/damon: add node_eligible_mem_bp goal metric
> 
> This commit introduces a new metric node_eligible_mem_bp for DAMON schemes
> to control memory distribution across NUMA nodes based on the ratio of
> scheme-eligible memory. It calculates physical bytes per node using PADDR
> ops and integrates with the DAMOS quota goal system.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3dbbbfdeff719f..4ac8052052613d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2287,7 +2305,112 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  		numerator = i.totalram - used_pages;
> >  	return mult_frac(numerator, 10000, i.totalram);
> >  }
> > -#else
> > +
> > +#ifdef CONFIG_DAMON_PADDR
> > +/*
> > + * damos_calc_eligible_bytes() - Calculate raw eligible bytes per node.
> > + * @c:		The DAMON context.
> > + * @s:		The scheme.
> > + * @nid:	The target NUMA node id.
> > + * @total:	Output for total eligible bytes across all nodes.
> > + *
> > + * Iterates through each folio in eligible regions to accurately determine
> > + * which node the memory resides on. Returns eligible bytes on the specified
> > + * node and sets *total to the sum across all nodes.
> > + *
> > + * Note: This function requires damon_get_folio() from ops-common.c, which is
> > + * only available when CONFIG_DAMON_PADDR is enabled. It also requires the
> > + * context to be using PADDR operations for meaningful results.
> > + */
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
> Does this overcount eligible memory by skipping core filters?
> 
> The quota adjustment logic uses damos_core_filter_out() to exclude explicitly
> filtered regions, but it appears this calculation only checks
> __damos_valid_target(). Should damos_core_filter_out() be evaluated here as 
> well?

This is an intentional behavior as we discussed [1] on the previous version.

> 
> > +
> > +			/* Convert from core address units to physical bytes */
> > +			addr = (phys_addr_t)r->ar.start * c->addr_unit;
> > +			end_addr = (phys_addr_t)r->ar.end * c->addr_unit;
> > +			while (addr < end_addr) {
> > +				struct folio *folio;
> > +				phys_addr_t folio_start, folio_end;
> > +				phys_addr_t overlap_start, overlap_end;
> > +				phys_addr_t counted;
> > +
> > +				folio = damon_get_folio(PHYS_PFN(addr));
> > +				if (!folio) {
> > +					addr += PAGE_SIZE;
> > +					continue;
> > +				}
> 
> If addr is unaligned, does adding PAGE_SIZE preserve the unaligned offset and
> cause under-counting on the next valid folio?
> 
> If an unaligned fallback happens, the address might skip past a valid page
> boundary instead of aligning to it. When advancing the address without a
> valid folio, would it be better to align it to the next page boundary?

Makes sense.  I suggested to use PAGE_ALING_DOWN() on the reply to the patch.

> 
> > +
> > +				/*
> > +				 * Calculate exact overlap between the region
> > +				 * [addr, end_addr) and the folio range.
> > +				 * The folio may start before addr if addr is
> > +				 * in the middle of a large folio.
> > +				 */
> 
> [ ... ]
> 
> > +				if (overlap_end > overlap_start) {
> > +					counted = overlap_end - overlap_start;
> > +					total_eligible += counted;
> > +					if (folio_nid(folio) = nid)
> > +						node_eligible += counted;
> > +				}
> > +
> > +				/* Advance past the entire folio */
> > +				addr = folio_end;
> > +				folio_put(folio);
> > +			}
> > +			cond_resched();
> > +		}
> > +	}
> 
> Could this cause CPU soft lockups for very large regions?
> 
> Since the while loop can iterate millions of times for large memory regions,
> should cond_resched() be placed inside the while loop instead of outside it?

Not likely.  Users could set min_nr_regions to control the maximum size of each
region.  We might be able to make this more robust, but seems not a blocker of
this patch in my opinion.

> 
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
> > +}
> 
> Can this cast cause truncation and overflow on 32-bit architectures? 
> 
> Both node_eligible and total_eligible are phys_addr_t, which are 64-bit on
> PAE systems, but unsigned long is 32-bit.
> 
> If total_eligible is an exact multiple of 4GB, it would cast to 0 and trigger
> a divide-by-zero panic in mult_frac(). Additionally, mult_frac() multiplies
> by 10000 using 32-bit math, which might overflow for values larger than
> roughly 429 KB.
> 
> Should this use 64-bit division or shift the byte sizes down to page counts
> before calculating the fraction?

Too much overflow concern in my opinion.  The overflow makes no real critical
problem.  Let's keep this as is for now.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260424203448.5040-1-ravis.opensrc@gmail.com?part=1
> 

[1] https://lore.kernel.org/20260405224550.76218-1-sj@kernel.org


Thanks,
SJ
