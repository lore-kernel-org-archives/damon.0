Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92C524F
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015029; cv=none; b=huF8WTSV5hBoli5A1OCM4exnJJ0mGk14aolbKxx/8M+VawFi28zNJjkq1DYePrSI6Z9hmOXoIN8xNu8u23PGAFKIGgmPmF+Nm0DobRdRB8cejOVU7c5aL9SBs8IWh9atoZCXyqTi8zPK+o5s1M8gKZlZk9lO60wk6FT1f2mJT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015029; c=relaxed/simple;
	bh=Lpvaj92RwSuEPuVCmiR4fihHC3FA0jlDBPclBCTL7QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdQO4bIBXvkarHV0QN2LX1d9TDirY1fUOlmCSUb33+CIeIwa6vOFHhYsMpu3wtaa3/sIM9GxqeVLXzRPE09vgWJVP6NX7ofjUz/SZ2RKmDq3iARQqnVEd/3kn63BmLIbZne7Nh34q2ypZGCXFQ0NVtwmTBaQFg9DFlK7itVWza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRO0jIUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRO0jIUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205B41F000E9;
	Sat, 25 Jul 2026 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785015028;
	bh=QPxUSG3c03INJUGnKkqNKybpRmiiyqayxJhOqFIIEKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRO0jIUxD9emjvV6YBQSmwA8MiR/WB+Pq31X9XNvEwWCs8ZLJml1U5TUML/CMzMs7
	 poOw84I17bpJ7AqNktai37cAedqKYpPQ2lTLiJA+oaEECEOepWe75X6C6LxM/I4iRH
	 joUkscYIVFtLlMk/BYfRymTzBt9rTxkKZr5JafCW56gjWYDSkty3lgNW64BOSBNJkX
	 20YFwKwULlXNiQTdxXE6spcpb3PMP/5kZM/ERZCssuaDToxpRaXmAMEF6UBVrNzmSS
	 PuYLCXHto9ZRDPri0PwNcWm8Z3TUmSnS0oOuErMO+8qSYSOJ2ImBMFrca/IxvnyxuT
	 Ttqn275NBnuog==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Sat, 25 Jul 2026 14:30:19 -0700
Message-ID: <20260725213021.130983-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211706.5108E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:17:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The PGIDLE_UNSET probe filter lacks a mechanism to clear the page idle state and PTE young bits at the start of the sampling interval when used with weights, breaking access monitoring.
> 
> Pre-existing issues:
> - [High] PFN advancement after page-to-folio conversion using `folio_size()` causes subsequent folios to be skipped if the iteration does not start at the folio's base address.
> --
> 
> --- Patch [2]: [RFC PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type ---
> commit 97a45c1fa60aa6c710c0c0c9226adf390fa8207f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support PGIDLE_UNSET probe filter type
> 
> Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
> address space DAMON operations set. It reuses damon_folio_young(),
> which was being used for access monitoring.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5a6a78054784a..199de1463fa06 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
> >  			matched = filter->memcg_id == mem_cgroup_id(memcg);
> >  		rcu_read_unlock();
> >  		break;
> > +	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> > +		if (!folio)
> > +			matched = false;
> > +		else
> > +			matched = damon_folio_young(folio);
> 
> [Severity: High]
> Does this filter evaluate historical access state instead of interval-specific
> accesses when used with weights?
> 
> If a DAMON probe is configured with weights, it skips the
> prepare_access_checks() phase:
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
>     bool access_check_disabled = damon_has_probe_weights(ctx);
>     ...
>     if (!access_check_disabled && ctx->ops.prepare_access_checks)
>         ctx->ops.prepare_access_checks(ctx);
>     ...
> }
> 
> Because damon_pa_mkold() is never called on this address at the beginning
> of the interval, it seems damon_folio_young() will read stale access state
> and perpetually match once a page is accessed.

That will be implemented in a later patch of this series.

> 
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the address advancement
> in damon_pa_pageout() skip valid physical memory if the DAMON region
> boundary is not aligned to a large folio boundary?
> 
> mm/damon/paddr.c:damon_pa_pageout() {
>     ...
>     folio = damon_get_folio(...);
>     ...
>     addr += folio_size(folio);
>     ...
> }
> 
> When damon_get_folio() returns a large folio, unconditionally adding the full
> folio_size(folio) to an unaligned addr over-advances the address by
> addr % folio_size(folio). This could cause the loop to skip the beginning
> of the next folio.
> 
> The same unaligned address advancement also appears in damon_pa_de_activate(),
> damon_pa_migrate(), and damon_pa_stat().

Known issue, I'm working on it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=2


Thanks,
SJ
