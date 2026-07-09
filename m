Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4173BB69E
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608581; cv=none; b=lqoE740KlgLWF3dchY3NZzOkzAep4RpQk+5dmLb26U94wwM9wnCvyKP5OhxZirsxX5XZhPta2B+JO9hEsEuPry4hxDI3krbN2aUZGMsHpwM9ltW+Tea8S4udWgEhVXG8Ye5DEiN3FvIq4sWs7MyDWkiHpM6cEMZIz6lO2t09gtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608581; c=relaxed/simple;
	bh=KyBHoDWdIc28yKUrLsKZyA5DyAZhpf36ZFOmwazourc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQAunABEsSgokZZshINPBOF9ASBUZowvwwyjMimKOKT7JtR19hvuNc6Ky3Bf1WKohXiBLFtGJIQ9ASxVQsj3IyGaIv/SHWZGT+dL1l094jl+UGXf31AagC5UB8y9sOhpq+ERZVrTawwXqBIEFT/jtht8eIVa8M0CKmcGarETLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfA8b51w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfA8b51w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A126B1F000E9;
	Thu,  9 Jul 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608578;
	bh=WoTCgVVFsteX7iwXgjpLV1m2nlYC/bt/WBgH4ndm/c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfA8b51wvUpeEkkNKmR6CYZ1R/G2skn09OTVIXU0xHo0KWoM7/p8crNhXKlbZRiOb
	 Q202aXYzPB9RIDMYBulesFNfLCab4IIyWEduZyIsOEz8z4OyV116A/6kwdsrOSBG8i
	 Spz1S5znQmooe7Arba7eUqYTkAzv3qypTZ+CU5rGMoK3ElrzKd8mV7/zBllcdL8PJK
	 EtWvyzDCbSh6QNSLBK/rbJGoYG8Zt/bIrIPoqgIut2HycPU8/1tMQDwU4WZvJxdwF5
	 Me77XZDB4qpGQCivzcj+XFM6Q80NCSsN+zCT3aWdE6RLyPXRktsgmrjxNVfkLaKI9K
	 03xWxGdIQcKfg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 04/19] mm/damon/core: ask apply_probe() to return max probe hits weighted sum
Date: Thu,  9 Jul 2026 07:49:28 -0700
Message-ID: <20260709144931.96091-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709141640.249B71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:16:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `damon_pa_apply_probes` callback unconditionally returns 0 instead of computing and returning the maximum probe hits weighted sum when `return_max_wsum` is true, violating the updated API contract.
> --
> 
> --- Patch [4]: [RFC PATCH v1.2 04/19] mm/damon/core: ask apply_probe() to return max probe hits weighted sum ---
> commit ed82d24ec75fdb639533062e293614cb1cebe866
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probe() to return max probe hits weighted sum
> 
> This commit updates the apply_probes() callback protocol in the DAMON
> operations to optionally return the maximum probe hits weighted sum. This
> value is intended to help the core layer adjust regions in the future.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 3c2a4d673bf62..4e1845ce83870 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -648,7 +648,9 @@ enum damon_ops_id {
> >   * of its update.  The value will be used for regions adjustment threshold.
> >   * @apply_probes should apply the data attribute probes to each region and
> >   * accordingly update the probe hits counter of the region.  It should also
> > - * &set sampling_addr of each region if ``set_samples`` is true.
> > + * &set sampling_addr of each region if ``set_samples`` is true.  It should
> > + * also return maximum probe hits weighted sum of regions if
> > + * ``return_max_wsum`` is true.
> >   * @get_scheme_score should return the priority score of a region for a scheme
> >   * as an integer in [0, &DAMOS_MAX_SCORE].
> >   * @apply_scheme is called from @kdamond when a region for user provided
> 
> [ ... ]
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
> 
> [Severity: Medium]
> The kernel-doc for apply_probes states it should return the maximum probe hits
> weighted sum if return_max_wsum is true.
> 
> However, damon_pa_apply_probes() unconditionally returns 0 here without
> computing the weighted sum.
> 
> Will this cause the core layer to receive an incorrect threshold of 0 when it
> starts passing return_max_wsum = true in the future?

This is intentional.  The later patch in this series will implement it.

> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=4


Thanks,
SJ
