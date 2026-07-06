Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F63BFAD1
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381340; cv=none; b=LMCNolX0woMqdlQ+bsrDD3uT9BDejK4pfKuxQvT2By5sTmHqcb6RzWWtbUVXk1/02as1esli2Be0pa4oO6D9WfZh8esLup0Y83W2RFQhWzsyfl5njERmPxFI5jaDn+cQpLAVLco42kigmkoR/LEg7ONdVGkQpMYSunj2ZONvlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381340; c=relaxed/simple;
	bh=RbTWjrWu24CswOltPzfjqYFw4OVxWqnvDPvY0koi6/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOV0ea+ZrL9xoPpX7FX0yL5CmVTMAkeFhvL6WgepKRWbFGksfbwknM7qcecTp/wlTzhVQG6LeCKUu2hjUpyRyxsYVl9F0gHqvCvh7jq+IT8xH6rbRyN/bwsi97PNYz3MVEv4arQGMcrMbWyD46yOSFmBQwPH1psWdLAIwnb6UxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQI23Rrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQI23Rrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E428C1F000E9;
	Mon,  6 Jul 2026 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381339;
	bh=wywkB2pqP8goibsoiLFWGGGg+i8rbQEmwy0La2YgeKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQI23RrcbdSyLPjYgg/zCUMavx+uigcxk2O2BrquiTVmaAhmIDfECKDgBQerGHIig
	 dMElKrg3YLdQef8G43WT8pbxgu/LzsB3Uv/29fIMq8fEuzSy+Cr/q+pxzSOwDdmwVa
	 kxq8GUbspFbcIuOtVpYQdHyxk+1WJKuWeh676twjqXohOG2tPEn9eyT7DPTFC3P4tC
	 PDlfD336QYDHUtE1ZHZOdIdGJEiJKoSCJgIdtLIV26XZpJ5V5wiJtSP1Q2BJ9+m+LB
	 PpQejjsm3CYj2r8xMQBTAlj5SIrsnbbh3bqJDgKgpErBk8c7/46kqlP7TeR8O/yC5e
	 T5Alo+Xtu8m0g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 04/16] mm/damon/core: ask apply_probe() to return max probe hits weighted sum
Date: Mon,  6 Jul 2026 16:42:10 -0700
Message-ID: <20260706234211.96517-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706143938.310BA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 14:39:37 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Advancing physical addresses using `addr += folio_size(folio)` in large folio iteration paths skips memory when `addr` is not aligned to the start of the folio.
> - [High] Static local variables used for caching are shared across concurrent kernel threads without synchronization.
> --
> 
> commit 1ecdc723ec9bfdc97493a942107d11622114a694
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probe() to return max probe hits weighted sum
> 
> check_accesses() DAMON ops callback returns the maximum nr_accesses of
> regions.  DAMON core uses it to calculate a reasonable region merge
> threshold.  The core will need to adjust regions for not nr_accesses but
> probe hits weighted sum in future.  For that, the core needs to know the
> maximum weighted sum of the regions.  Update the protocol for the task.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index ff4fcca949660..3eba3564a31fc 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -166,7 +166,8 @@ static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
> >  	return pass;
> >  }
> >  
> > -static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> > +static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
> > +		bool set_samples, bool return_max_wsum)
> >  {
> >  	struct damon_target *t;
> >  	struct damon_region *r;
> > @@ -194,6 +195,7 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> >  				folio_put(folio);
> >  		}
> >  	}
> > +	return 0;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the changes in
> mm/damon/paddr.c, I noticed that __damon_pa_check_access() declares static
> local variables for caching:
> 
> mm/damon/paddr.c:__damon_pa_check_access() {
> 	static phys_addr_t last_addr;
> 	static unsigned long last_folio_sz = PAGE_SIZE;
> 	static bool last_accessed;
> 	...
> }
> 
> Because DAMON allows multiple contexts to be created and run concurrently,
> each in its own kdamond thread, could these static variables be modified
> concurrently without locking? Does this data race risk corrupting the cache
> state and misapplying access results between different monitoring contexts?

Correct.  I'm separately working [1] on this.

> 
> [Severity: High]
> This is a pre-existing issue, but I also noticed a potential overshooting bug
> in multiple physical address iteration paths in mm/damon/paddr.c, such as in
> damon_pa_pageout():
> 
> mm/damon/paddr.c:damon_pa_pageout() {
> 	...
> 	addr += folio_size(folio);
> 	...
> }
> 
> If a region start address is not aligned to the size of the folio (for
> instance, starting in the middle of a 2MB THP), advancing the unaligned addr
> by the full folio size will overshoot the folio boundary. Could this silently
> skip valid physical memory that falls in the gap?
> 
> The same pattern appears to be used in damon_pa_de_activate(),
> damon_pa_migrate(), and damon_pa_stat().

correct.  I'm separately working [2] on this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=4

[1] https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org
[2] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org

Thanks,
SJ
