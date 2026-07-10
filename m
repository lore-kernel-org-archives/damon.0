Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131403DEAD1
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694009; cv=none; b=ooEhaPcRwvr5kNmlMRPJus+NXFORZ1HqmHVf3yDgrpJh9CaTA9iBKQxrJQDho7p9vA7vFFFq1wMm13RNJqGA3425HCaV4cUJI8l9D6Q4ZB0vSeGVdj42SwX7NIu3sZbtmD2YtKX02gE/Sp+dvMKN9erAncqn/oKZVKKm2I+k9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694009; c=relaxed/simple;
	bh=3lZz7BxPBKQK+twnaLrZ3kjEd1qZWbHfY257GIKguMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA1XSUxGhDUDn93wDKcGJmg0T0biEgr7rSsE8dYxjxv+WRrGwzDj/xZk9Qk5ZiQlC+4BvbjN9SxxwiYfsp3z1ccBr+GsHNzkhkgmHu1SHLeRY58sXPeBYKokvfWCyFQYJxfIGArwICkN+hOgl7hnzoy6cHQljOIKO5U25CpNr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM6y2U1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM6y2U1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C9D1F000E9;
	Fri, 10 Jul 2026 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694007;
	bh=GCE0yGF0TcPlW0aiQ/SWgaimNFya1lR4TeSZbz39rPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AM6y2U1A2JypgLoEtctjuCVmbX6kxMvVAnN7scNCMtE+mgivnQy2uc+LNf2bfMmjF
	 RH4bQ2xk5ZIaFDctvihfEwDgmfJZfWRgtBgdGAWGaUFSjEJGuCFLpEdJ2IEM5bsIZ7
	 IDw88IBcKN6DfmjLHAz3DCbqXOOKP+ajwVkNOjuWTDB77o5Io1KXHYaDTPYudFLj7o
	 B0Xre06rD62hfiptr7q4r2d0JbZjSWbA6Gb5BQqyLZ/1BYb45/78TOIwWV4GXkzDpl
	 PXLezuoSPBfgpcnzWIcwZrih7pMF4Dkcd1n697PWhnfQQSzigWDgTj1FY+seZB1l8E
	 jLcYzOu+Fs7RQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 03/19] mm/damon/paddr: set samples in apply_probes() if requested
Date: Fri, 10 Jul 2026 07:33:18 -0700
Message-ID: <20260710143320.26501-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710140156.3A3931F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:01:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Address advancement using `folio_size()` from an unaligned address within a large folio overshoots the next folio.
> --
> 
> --- Patch [3]: [PATCH 03/19] mm/damon/paddr: set samples in apply_probes() if requested ---
> commit 60a9acbe070a2be34c313d6be62fe7e4acb7ec54
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: set samples in apply_probes() if requested
> 
> This commit updates damon_pa_apply_probes() to respect the set_samples
> parameter. It adds logic to randomize the sampling address within the
> region boundaries using damon_rand() when requested.
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
> This is a pre-existing issue in this file, but can the address advancement
> logic skip over pages during region iteration?
> 
> Looking at iteration functions like damon_pa_pageout(), 
> damon_pa_de_activate(), damon_pa_migrate(), and damon_pa_stat() in 
> mm/damon/paddr.c, they all use a pattern for advancing the address
> similar to this:
> 
> mm/damon/paddr.c:damon_pa_pageout() {
>     ...
>     folio = damon_get_folio(PHYS_PFN(addr));
>     if (!folio) {
>         addr += PAGE_SIZE;
>         continue;
>     }
>     ...
>     addr += folio_size(folio);
>     ...
> }
> 
> If the initial iteration address is not aligned to the folio boundary (for
> example, after a region split or hole), wouldn't adding the full folio size
> to this unaligned address cause it to overshoot the end of the current folio?
> 
> This seems like it would skip over the beginning of the next physical folio,
> causing those pages to incorrectly escape reclaim, migration, or statistics
> gathering.

Known issue.  I'm working on it.  No blocker of this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=3


Thanks,
SJ
