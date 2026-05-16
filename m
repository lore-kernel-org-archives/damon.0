Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DF25228D
	for <damon@lists.linux.dev>; Sat, 16 May 2026 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892996; cv=none; b=DxXr/eWibpvb4djERuymWyH4LyEH/fIqdw/+njUninJDMYcCXgxCnno4S7m8XjTogTwy94pZSmv3pwMuzqzvwewq61j4XGxleoARCyih5AcYGZlu4zgGd2Yd3axRHBP4izmMAdYh94vBnxtE+5fcytsVCfMrGeizrkKfzzVKjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892996; c=relaxed/simple;
	bh=iqakh8RSQUVlg+Kgkw5sRN3uTwNqO6ayOGvv4xyMi3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoZjrYn7y5r2lLJoUcGVOMsXlgBrhq7nQUmBTLb9UbUEVFSCmktS+ucclYCaJ0alzrXmCH62BANvUItd2+qR809e/S+z+6tYdxsTz+nTfOzyFMzQet06FHqXSpelaYngwr0UJeb85d7kihNWX2F06RKMas+U8jtpRNNJ6gsnWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsyU0LfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsyU0LfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47E6C2BCB0;
	Sat, 16 May 2026 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778892996;
	bh=iqakh8RSQUVlg+Kgkw5sRN3uTwNqO6ayOGvv4xyMi3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsyU0LfCBCcm9PdEJFCj3wD/1w7aiVr8Dd8m7iOD8IaF3oYGMMbiG6+wcWuMKGWas
	 XEJ53WlpP5d7q9ckwx2i0pmOQs/6uVNJH/O6bxYPZY1AmwLX/NTK+S3htbmZi84Jpu
	 yAdU2vI98DLvFXqV+8lj91EK4B53e/6ZhS6XF4HQSykmhm0VCUXBgnT000HQqTC9SW
	 91xB5ZAx2YUi0MXeIqRw1snmImQdcnMn+XcwCU/jI7Q4l00HlKgZOqPyAfq2RZEBcm
	 KrclTjZ6yPrcA/OgQRLBhzdC83we2eCBhrVpeh0wYGCcDyjMziQvhKt9FCS0sKjLXO
	 g5y13wqQ5EXTg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 08/28] mm/damon/paddr: support data attributes monitoring
Date: Fri, 15 May 2026 17:56:32 -0700
Message-ID: <20260516005632.144711-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515012933.EAEECC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:29:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Flawed and order-dependent filter fallback logic in damon_pa_filter_pass().
> - [Medium] The probe_hits counters can silently overflow and wrap around.
> - [Medium] Redundant folio lookups and reference count operations for each probe.
> --
> 
> commit dd2c6385be410e674ab72a5dd4ff210f2f41dd48
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/paddr: support data attributes monitoring
> 
> This commit implements and registers the apply_probes callback to
> support data attributes monitoring in the paddr operations.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5cdcc5037cbc1..493bcca8ff104 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> [ ... ]
> > @@ -120,6 +120,67 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
> >  	return max_nr_accesses;
> >  }
> >  
> [ ... ]
> > +static bool damon_pa_filter_pass(phys_addr_t pa, struct damon_probe *p)
> > +{
> > +	struct damon_filter *f;
> > +	struct folio *folio;
> > +	bool pass = true;
> > +
> > +	folio = damon_get_folio(PHYS_PFN(pa));
> > +	damon_for_each_filter(f, p) {
> > +		if (damon_pa_filter_match(f, folio)) {
> > +			pass = f->allow;
> > +			break;
> > +		}
> > +		pass = !f->allow;
> 
> If no filters match the folio, does this logic make the final fallback
> decision entirely dependent on the allow boolean of the last filter in the
> list?

Yes, and that's the intended behavior that already well documented for DAMOS
filter.  DAMON filter documentation which will be added by a following patch in
this series will also refer to DAMOS filter documentation.

> 
> Reordering the filters could silently invert the fallback behavior for
> non-matching folios.

Yes, the API caller should know that impact.

> 
> > +	}
> > +	if (folio)
> > +		folio_put(folio);
> > +	return pass;
> > +}
> > +
> > +static void damon_pa_apply_probes(struct damon_ctx *ctx)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_target(t, ctx) {
> > +		damon_for_each_region(r, t) {
> > +			int i = 0;
> > +
> > +			damon_for_each_probe(p, ctx) {
> > +				phys_addr_t pa;
> > +
> > +				pa = damon_pa_phys_addr(r->sampling_addr,
> > +						ctx->addr_unit);
> > +				if (damon_pa_filter_pass(pa, p))
> 
> Does this redundantly repeat expensive folio lookups and reference count
> operations for each probe?
> 
> The physical address calculation and folio lookup in damon_pa_filter_pass()
> are executed inside the probe loop, meaning they will be repeated for the
> exact same physical address if multiple probes exist.
> 
> Could the folio lookup be hoisted outside the probe loop to avoid unnecessary
> overhead?

Good finding and suggestion.  I think the overhead should be negligible in
common cases, but also there is no reason to keep the definitely inefficient
code as is.  I will do the optimization in the next revision.

> 
> > +					r->probe_hits[i]++;
> 
> Could this counter silently overflow and wrap around?
> 
> r->probe_hits[i] is defined as an unsigned char in struct damon_region.
> If the aggregation interval is configured to be thousands of times larger than
> the sample interval, this 8-bit counter might easily overflow.

Yes, and I consider it as no problem, as I previously replied [1] to the same
question.

[1] https://lore.kernel.org/20260516003559.141476-1-sj@kernel.org


Thanks,
SJ

[...]
