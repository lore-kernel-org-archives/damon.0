Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294D42314A
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434071; cv=none; b=caVB0CYNqy/WnaW4inh6UlMZXxuJuDRcQWzhmweJHVOe+xB4ichLuwPBYXvsBViNl1fixVEI6hgbShjXslTvqfHyOcjMDeI4g2ZGK07wvrKO/+u88OQe2tRxTHE63cEr/ex2XkSJ56o4MvCjnZ/RSrPkPieFTNfnmpupgpn3otY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434071; c=relaxed/simple;
	bh=TqpcHvQUY6u7gHy2H1EE+km/0RWmRduG4V8PxkOP4V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW7gSxAOxrOX0kop+hF1k0bKM9LxnJUkhwztIZsVgr6KRWRA6yvzTuvfbYefI655MvixO/eOTX0jclTm/cQj1K3m8mVvCxRBj3SYznm0UHs+OkbC0/jaDTZpuqtxAtxsMvkbmP+CQAfevA4CeIXqHq+zB4mMZaT0+IqLXSKQQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5mUMh1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5mUMh1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D271F000E9;
	Tue,  7 Jul 2026 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434070;
	bh=i2euAQewQAth0BlBe1CMJDvZVmopOS9k1miD0h3BkV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5mUMh1UJXqNkLQ1ErYGIcr/KZGYDJ1E4oNrWRs6TMgyF9qushv47OsDJPP/dWVWs
	 rR1cwlQSBvUDZAltoMfF0AmOowDsyIkNf4so3C6kcmOlKaOWCN0vPfOesvnqR/ea0X
	 ClUllK5ZzUxgH6AWFHEzi6Pc9haIQRhi9aAegECAw8/+H0c9zPhaf5l7kt3kEZaf9Q
	 EmaULJi0Yn4h53pTLa100K5ZNfOswby7WVXXqGUkXouHaMbD3KO2izEGcOUE83UCVI
	 0d9NriRU0I9JW2D8d2wxFwydqtmO6EamrHwBgLjpV2v8XYiuwkHrA3bxMyPVkzy8Bv
	 0qeolOdRbFoqQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 2/7] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Date: Tue,  7 Jul 2026 07:21:04 -0700
Message-ID: <20260707142107.91438-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135822.A6C8A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 13:58:22 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Multiplications by 10000 in DAMON basis-point conversion functions overflow 32-bit unsigned integers when the number of samples per aggregation interval is large.
> --
> 
> --- Patch [2]: [RFC PATCH v1.1 2/7] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/ ---
> commit f63888911d3e9e966f4abf35c7d87cb96cc0e08b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
> 
> This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
> to better describe that it returns the number of samples DAMON checks for
> each region per aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index a15005db82899..177e5abc981ef 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -880,14 +880,14 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
> >  static unsigned int damon_accesses_bp_to_nr_accesses(
> >  		unsigned int accesses_bp, struct damon_attrs *attrs)
> >  {
> > -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> > +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does this calculation overflow 32-bit
> unsigned integers when the number of samples per aggregation interval is
> large?
> 
> In damon_accesses_bp_to_nr_accesses() in mm/damon/core.c, both accesses_bp
> and the return value of damon_nr_samples_per_aggr() are 32-bit unsigned
> integers. If an administrator configures DAMON with a large ratio between
> aggr_interval and sample_interval (e.g., > 429,496, achievable via sysfs
> with a 1us sample and 500ms aggregation), the multiplication will silently
> overflow UINT_MAX, yielding much smaller thresholds than intended.

Known low priority issue.

> 
> >  /* Convert nr_accesses to access ratio in bp (per 10,000) */
> >  static unsigned int damon_nr_accesses_to_accesses_bp(
> >  		unsigned int nr_accesses, struct damon_attrs *attrs)
> >  {
> > -	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> > +	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this macro expansion also
> suffer from a 32-bit overflow?
> 
> The mult_frac() macro adopts the type of its first argument, nr_accesses,
> which is an unsigned int. Its internal calculation of the remainder
> multiplied by the numerator (r * n_) evaluates as an unsigned int.
> 
> When the remainder r (which is bounded by samples_per_aggr) exceeds 429,496,
> this multiplication by 10000 will overflow 32-bit boundaries, leading to
> incorrect basis-point ratio calculations.

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707135038.90068-1-sj@kernel.org?part=2



Thanks,
SJ
