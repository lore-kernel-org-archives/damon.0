Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0C382F0C
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608437; cv=none; b=oYAAbfPIfX2H88MeH8b1YWctvo/ljuPo2XRIjixG9GPAjS/6PDD8AfNQEK/jNRZa3x8UQOSioEPve/l/ju7NQ73Nv8CTNGdHjgkYZgL1iDfIkXB92mC9i4gA59swEsPHZGHOsb+Z1r7YqUA8YeTXGgcFKzpeojbHR5DZZI/ptBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608437; c=relaxed/simple;
	bh=bq0MMDEUxGobjnIZbPkFST4d+4RTedu4/yg3xfl9x0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJVJ4EemltYErriqb7g5uvVwRmT5myzBpiBDP+feXuZwe4WLmstfpv+a6a4BkOulSEJZDvi0pqmJCvT7u8ErAdnYv/swqIIx1GGAdl3BCllRDE/yYq4zCGtpqn96Luo/0gF1ByDnctE+NKQR9ZnBxW24bXiWhr5ySHLkONrq0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAmbTYsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAmbTYsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF431F000E9;
	Thu,  9 Jul 2026 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608434;
	bh=NE6KBTqmMtl9qc0RU6Zwid+RgBFQyTvPRy3tn234hZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MAmbTYscVzR7WEk8rUuhKpTktjCKE3UE8e0z0bXP1GH2ORxhwgQ91hLzZuXXcuDYK
	 7y+j8j8ulLeuxoz878rBGcof4x+N4VInG34D00iLvYvTyLkCvT+ahzPn3Zd6ZBjTWd
	 acoSQiRO6FYF6tLcUIA7jQKKvakFaz85KXhERvHvwPtN8RwUEAWsgGlo1D/Y7mJLFF
	 jjO/vsDa9zAvhpAdW/QYcljUEyk/geWkEUp3icIYKXb83gnw95rvRJFOSRUA4Btaq1
	 B6KTceNBDnXov9BOE1CJp2AFEr4eN0DSfHEc8B+PfQRsnTJNve4WatpaqUK9t8epvZ
	 NU0vJ77J7XE7A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address
Date: Thu,  9 Jul 2026 07:47:05 -0700
Message-ID: <20260709144707.95726-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709141646.725B41F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:16:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `damon_pa_apply_probes()` callback ignores the newly added `set_samples` parameter, violating the updated API contract documented in the header.
> - [Low] The use of `&set` in the kernel-doc comment will generate a warning during the documentation build.
> --
> 
> --- Patch [2]: [RFC PATCH v1.2 02/19] mm/damon/core: ask apply_probes() ops callback to set sampling address ---
> commit d206ad52f1017ca79add3bb060530dc8e4e317fd
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probes() ops callback to set sampling address
> 
> This patch updates the apply_probes() DAMON ops callback by adding a
> set_samples boolean argument. This allows the callback to optionally handle
> sampling address setup to minimize unnecessary region iteration.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index d8251c83e6e55..3c2a4d673bf62 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -647,7 +647,8 @@ enum damon_ops_id {
> >   * It should also return max number of observed accesses that made as a result
> >   * of its update.  The value will be used for regions adjustment threshold.
> >   * @apply_probes should apply the data attribute probes to each region and
> > - * accordingly update the probe hits counter of the region.
> > + * accordingly update the probe hits counter of the region.  It should also
> > + * &set sampling_addr of each region if ``set_samples`` is true.
> 
> [Severity: Low]
> This isn't a bug, but will this use of '&set' in include/linux/damon.h
> generate a kernel-doc build warning? 
> 
> The '&' prefix in kernel-doc is strictly reserved for referencing structures,
> enumerations, typedefs, or unions. Using it to emphasize the verb 'set' is
> invalid syntax.

Good finding.  It is a typo.  I will fix in the next revision.
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
> Does damon_pa_apply_probes() in mm/damon/paddr.c need to use the new
> set_samples parameter?
> 
> According to the updated API documentation, this callback should conditionally
> set r->sampling_addr if set_samples is true. However, the parameter appears to
> be ignored in the function body in this commit, which could lead to incorrect
> or stale sampling if a future caller passes true.

Yes, the later patch in this series will do that.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=2


Thanks,
SJ
