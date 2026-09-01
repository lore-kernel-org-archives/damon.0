Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609637A839
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239136; cv=none; b=jgcZtV4iHCDMQbeZVt0+Gak/nJ8T9Tj7afXbI/4+saPawEO8bvu3NfcjNhxbyTPMT8QsS2gU0Oo15sKNgcFSrDQ637yp9cSmBycUlEx3vh1i5vdtY5WYsIWSz7xKlmsO7VCk79fJrA1iQJVDdf0uVy7JijS7Gqb4b+P0pt0odOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239136; c=relaxed/simple;
	bh=rPNFEwG9KXkNSQf4kt6YnzhJZCFYBUYh47JMgK1tY2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7+U3Ii8Camo3Y08z/3ERLRPOQzP+XvTwzX/FBOYdYfOkrlPG8iT7qBj865IyoL+WExTBBWRtYJqRG1N1MZa//8fkSDEAQ/Icz+wf/beXPRpGOA2Q3ajai8XaeEiqmuX9q4cT8MqjGGJLznFn7Za2JpSz/Fh5TRgo+MbaL8RGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYckLJoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYckLJoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C01F000E9;
	Tue,  1 Sep 2026 05:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788239135;
	bh=eRllg9sl+PZoVy3fkKCwBWBEPwCAvQjCDjqybgffAb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYckLJojeG++FmJ2Hnv9L+XpGUCMu1zjkgS1Oq/WFqqdsdGTFYyITMlf9DqNnVJXs
	 ORr6Wuhzo0lKQVGxsP7fwImhDPeEXSqTAEcbSrPVBRJ5GPA9+aY1rWbBTlhnueHgcl
	 T/EKMkBMEny/wTAENOtnf7wFZ9EO0tjFUM9inxEOAiE4jESY0QJmfthUqBwCQOXhEf
	 P0nobn8Hf0UDDvpEEoxQrw9VnwdXjbETjGQMa7sklZXg29kcjDdF6TeaUZl1BFYfDi
	 yhm2XXEgmWgzjpoH4juvmqZCquAP9SPiz8MLuDwU4jJo+rnsI9L22cLOvlSS/V3bBz
	 vp/1mOoZdFspA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 08/17] mm/damon/paddr: support damon_prep
Date: Mon, 31 Aug 2026 22:05:26 -0700
Message-ID: <20260901050528.3815-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901044702.A19E71F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 04:47:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] `damon_pa_prep_probes` applies probe preparation actions without checking probe filters, causing unintended page state modifications and redundant folio lookups.
> --
> 
> commit 05f1236264960a0054ba7741a1b9b7ae78666ee1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support damon_prep
> 
> This commit implements the prep_probes() callback for damon_operations. It
> adds support for the DAMON_PREP_SET_PGIDLE preparation action by unsetting
> page table accessed bits and setting the PG_idle flag via damon_pa_mkold().
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5b307dcbb2a50..8fb71183b76c0 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> 
> [ ... ]
> 
> > @@ -105,6 +105,40 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
> >  	return max_nr_accesses;
> >  }
> >  
> > +static void damon_pa_prep_probes_region(struct damon_region *r,
> > +		struct damon_probe *probe, struct damon_ctx *ctx)
> > +{
> > +	struct damon_prep *p;
> > +
> > +	damon_for_each_prep(p, probe) {
> > +		switch (p->action) {
> > +		case DAMON_PREP_SET_PGIDLE:
> > +			damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr,
> > +						ctx->addr_unit));
> 
> [Severity: Medium]
> Will this unconditionally mutate the page state for every prep action,
> regardless of whether the page passes the probe's filters?
> 
> Because damon_pa_prep_probes_region() doesn't check the filters, it appears
> it will clear the accessed bit and set PG_idle on pages that are explicitly
> excluded (e.g., when a probe only targets a specific memcg).
> 
> Could this disrupt legitimate LRU tracking and reclaim for processes not
> targeted by the probe?

No.  damon_pa_mkold() will set page as referenced if it was referenced before,
to not disrupt LRU tracking and reclaim, same to the classical access
monitoring and idle page tracking.

> 
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_target(t, ctx) {
> > +		damon_for_each_region(r, t) {
> > +			if (set_samples)
> > +				r->sampling_addr = damon_rand(ctx, r->ar.start,
> > +						r->ar.end);
> > +			damon_for_each_probe(p, ctx)
> > +				damon_pa_prep_probes_region(r, p, ctx);
> 
> [Severity: Medium]
> Since damon_pa_prep_probes_region() is called in a nested loop for each probe,
> could this cause redundant work?
> 
> If multiple probes use DAMON_PREP_SET_PGIDLE, this will redundantly invoke
> damon_pa_mkold() multiple times on the exact same physical address, leading to
> unnecessary folio lookups and reference cycles per region.

No issue.  DAMON users would know what they are asking to do.

> 
> > +		}
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901043417.2165-1-sj@kernel.org?part=8


Thanks,
SJ
