Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949E371CE6
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783287033; cv=none; b=YQHVamTS4T8/tDdBGmNrt7wTjul1XUiXV7JX6sOdFi60sejwMkpTCau5tkH/qHMBAVpvplh1OYRiTniMw4IlQmJur/mXYRQ9W2+H2nceBqeeGWAvateS78YXm5HhxE92lOwpcvX/+alVXYwJ3nL0COtlFzXigqOBsIh/RPUkh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783287033; c=relaxed/simple;
	bh=cWbM68VGfGeMWJz7sJyxnkhG+gFxXkfbagAlCV+pspo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJZNqH43zoSvhW+h7mQXMVWq8iYlKPGWBxjNr6p2QRkSXb13HqnnmbYt/b6sfiBLDvMRkBrFc36KKNDz/punVpsiSB1f7FC3B4+Kl7xKk4FREaQB9UIRljkALLMyvCfoLmr1tXBjciZ4xFO9bF33iw1lqMOksfDemrgr9t+5D+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeO5D5Ec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeO5D5Ec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEF21F000E9;
	Sun,  5 Jul 2026 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783287031;
	bh=2mWsMzjwM2lMVBD7EtPMhwW2jsTKYgvTeaX29ZXwWi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeO5D5EcTjfguxsC0wjEPc9dYxmQM0wpCx+rP0Wvxv4vnRNtvaPCmUtIES+xZDMBx
	 /VJzB2uWjbbQFx+iLsKlnjZNuXNY0rXD2LfCkNUw/z3rUmd/LqJtK9Zst8ejg6XDdz
	 hJJ30PVik+Ajwlad6hW1vn7lk2N6Gf1RKqddfKWW19aKUTM8PJUz0D3bdgts3iTIt7
	 xFKXbio/8Mkv1YaILSBXe/KXfbY0IVV+vt2duBS5fmD9+N/QkjvN+eLA6aTNoJiLP6
	 uPnj+P7u7TcNveQprWKPqBLoJqeP6CoIJtkqMQN5VV5EW2xgoacQv+/seI1nPoBnjZ
	 1mWHSh7Ov5OqQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 05/16] mm/damon/core: implement damon_probe_hits_wsum()
Date: Sun,  5 Jul 2026 14:30:22 -0700
Message-ID: <20260705213022.100681-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705211351.3FD861F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:13:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The calculation of the weighted sum in `damon_probe_hits_wsum()` can overflow the 32-bit `unsigned int` datatype.
> --
> 
> commit fa25d0914791f2e39d32d91b9baaf69eaeb0a208
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_probe_hits_wsum()
> 
> This commit introduces a new function damon_probe_hits_wsum() to calculate
> the weighted sum of probe hits for a given region. This weighted sum is
> intended to be used by both users and internal DAMON logic like region
> merging.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ec6b099bd8790..c370eaff5795d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -390,6 +390,30 @@ static bool damon_is_last_region(struct damon_region *r,
> >  	return list_is_last(&r->list, &t->regions_list);
> >  }
> >  
> > +/**
> > + * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
> > + * @r:		region to get the weigted sum of.
> > + * @last:	if the request is for last-window agggregated probe hits.
> > + * @ctx:	context of &r.
> > + *
> > + * Return: the weighted sum of probe hits of the region.
> > + */
> > +unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
> > +		struct damon_ctx *ctx)
> > +{
> > +	struct damon_probe *probe;
> > +	unsigned int sum = 0;
> > +	int i = 0;
> > +
> > +	damon_for_each_probe(probe, ctx) {
> > +		if (last)
> > +			sum += r->last_probe_hits[i++] * probe->weight;
> > +		else
> > +			sum += r->probe_hits[i++] * probe->weight;
> 
> [Severity: Medium]
> Can this calculation overflow the 32-bit unsigned integer?
> 
> Since sum and probe->weight are both typed as unsigned int, if a
> sufficiently large probe weight (for example, larger than 16,843,000) is
> configured via sysfs, this multiplication and accumulation might wrap around.
> 
> If the score wraps around to an artificially low value, would this cause
> DAMON's region merging logic to behave incorrectly due to unexpected
> thresholds?

It can overflow.  It doesn't make any critical cosnequences like kernel crash,
though.  Known low priority issue.

I'm considering avoiding this by adding the validation in the core layer
parameters validation, which is merged into mm-new today.


Thanks,
SJ

[...]
