Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA73A8739
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794379; cv=none; b=R6+tyN+1SReTEOON4ghXfH+r85uxZXM5yuX4iRK8ktOrvmN0SbFoHgRiQislGjVKllzDsQ6jchgV5QyhRwfsAC5hNe0sXa1NEjf0q3X43LR5l+rvtz81MntOcGb+NpaIblRVurg8xMFiHlMxWDeqUppwadoNuO8sCScUCR+DSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794379; c=relaxed/simple;
	bh=IikN+t4rhV9FW49ntsCNWepQ/TBrz/yjfOGamClal/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ5Hxe8kJFrMTFxMTwwYdSkD+NQZmR3u71PzTvZ0vhoLQpTrWX3pPehkaeb6KhqYU2YXaZG2ZHv/uiVcOMdHymDitKH2TaRBs5XGzF0AknYfixO3+3tQaB9AE2YlQAp0ftsPSa2sKhsWi5pIGNYluoMFDmGtoNB2PjwB5g/trG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQnluxYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQnluxYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266891F000E9;
	Tue, 30 Jun 2026 04:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782794378;
	bh=gO8O1rp20/ZlrzfB2DqIID9ZNGhaAi/anm3vJ2dlSXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQnluxYAecRGSHmgtyfRjO1WPoCZFVQfxAI8Inl96FLfN4Kt72BtRC8IaA97AQo27
	 heFkdBA+IsiJ5OAXaW3XV0UTbQ2HHThnLlLTmemtF+cQKVntepPohfViayn0Ldh028
	 bQp6nTebW0S37uRS6osyYNr7/gcfP/EzYB1lvrm0M5JhLhGQaCwU0/3O8c9MXvPR6Z
	 2CccY4ES6r8dwIBsfVqVmU6kB0/AAmMS/rhXAXKr7heIUlQ1NHgYUg9nukOOnvDwoc
	 SamR3yWZhsSTyZApOidWwaFfh3MHC+Ah0wEazMjDDLt6DdP5p9hFpwQ1K74XkJscar
	 DbEf1EveE4Y3g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 14/18] mm/damon/core: remove attrs param from damon_update_region_access_rate()
Date: Mon, 29 Jun 2026 21:39:29 -0700
Message-ID: <20260630043929.152043-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630041923.94D851F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:19:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Typo in the commit message referencing the wrong function name.
> 
> Pre-existing issues:
> - [High] Static local variables used for caching access checks cause data races and cross-context contamination between concurrent DAMON threads.
> --
> 
> commit 75de4af226707e222be94ee075dde34562b3817d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove attrs param from damon_update_region_access_rate()
> 
> The damon_update_region_access_rate() function does not use the attrs
> parameter. This commit removes the unused parameter to clean up the code.
> 
> > damon_region_access_rate() is not using attrs parameter.  Remove it.
> 
> [Severity: Low]
> This isn't a bug, but there's a typo in the commit message referencing
> damon_region_access_rate() instead of damon_update_region_access_rate().

Good finding.  I will ask Andrew to fix up when he picks this, unless I end up
posting a new revision.

> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5c2da45f988cf..8530213086691 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -91,12 +91,12 @@ static void __damon_pa_check_access(struct damon_region *r,
> >  	/* If the region is in the last checked page, reuse the result */
> >  	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
> >  				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
> > -		damon_update_region_access_rate(r, last_accessed, attrs);
> > +		damon_update_region_access_rate(r, last_accessed);
> 
> [Severity: High]
> This is a pre-existing issue, but does using function-scoped static variables
> for last_addr, last_folio_sz, and last_accessed here in 
> __damon_pa_check_access() cause data races when multiple DAMON threads run 
> concurrently?
> 
> Since these variables are shared globally across all DAMON physical address 
> monitoring threads without synchronization, it seems an interleaved execution
> could overwrite the cached access state. Could this result in cross-context
> contamination where one thread erroneously reuses last_accessed for a 
> completely different memory region?

The same issue was found by Sashiko before, and I'm separately working on it.
Not a blocker of this issue, anyway.

> 
> >  		return;
> >  	}
> >  
> >  	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
> > -	damon_update_region_access_rate(r, last_accessed, attrs);
> > +	damon_update_region_access_rate(r, last_accessed);
> >  
> >  	last_addr = sampling_addr;
> >  }
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index e73ec1ce016e5..2eaced0765e26 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> [ ... ]
> > @@ -501,19 +501,19 @@ static void __damon_va_check_access(struct mm_struct *mm,
> >  	static bool last_accessed;
> >  
> >  	if (!mm) {
> > -		damon_update_region_access_rate(r, false, attrs);
> > +		damon_update_region_access_rate(r, false);
> >  		return;
> >  	}
> >  
> >  	/* If the region is in the last checked page, reuse the result */
> >  	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
> >  				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
> > -		damon_update_region_access_rate(r, last_accessed, attrs);
> > +		damon_update_region_access_rate(r, last_accessed);
> 
> [Severity: High]
> This is also a pre-existing issue, but do the static local variables in
> __damon_va_check_access() present the same data race risk?
> 
> When multiple concurrent kdamond threads check virtual memory accesses, they
> share these unprotected variables. If identical virtual addresses exist in
> different monitored processes, could one context reuse the last_accessed result
> from another process due to interleaved thread execution?

Ditto.


Thanks,
SJ

[...]
