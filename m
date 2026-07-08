Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D20399019
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482975; cv=none; b=BPlZJchVfoBZhVw8URiECimvkIf20zXf6gSa7RSsyM5jiT3LWRTeGvT4xSTrxFHhTxbdH74D+PHL8dXTLtgZlTw+czBiYg7xFcQO8AtIFgmcAc22RHTKNPvuHqnlkAQyoCcKpwtM57s87ilb2ecs59j050c8hD8Dhdwl0vkFdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482975; c=relaxed/simple;
	bh=N3xa5f32jW/7LzDCDWwstgzdDZoZ9uMb2aG5govPVwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJD1tC/FT7zBwV/Nz3gKQMAsKAejgUQUQlM7b8XyiU6BFWXC2OaNF21PMQD9ihKDdxCOYwnCCZA+D4VQ8hWIIuFXZG4U15PgHT1ICs/idgufbOop3N3XOiL2scezvih9WsBU2MW5fK7seyY0CdDm1Vhf8HGnDIdzhyEK6g8tAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVr9x+Qc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVr9x+Qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59AB1F000E9;
	Wed,  8 Jul 2026 03:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482974;
	bh=GDvPzWDMbPBKZem0lhDVwT1Cvuy9mh6R4ZIOf6xferY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVr9x+QcP9v1jGsz6r/uQNclqUISTk234iBDPBtIhmFynlCxTrTfGsWHtv3oTQPg/
	 eixtlHydXPpg6hy6gniEQGvew19EKJrWE34f4ShiAgk6tGOwrdzBg6+VpyeTBEEHPG
	 9oo/eftH8qTOe5gD/UO9LRrAA7Ivv+PoT6RO0FCRgqd9KW+Sg2vc/jHgr7JnvZDEra
	 fS9QtigjC9W5CuUJ35htCoRYmUS2DqHGQ6lkZJYl9jzzaM3Tnn6s1x4EC3OaUetoNE
	 qKHXHJWSevU+yuTnywHUPGTdzF5/ZcquCYX2JXOLBGtiapZ4Yo2ywHxCU+9rS2FDQT
	 CV3vwpQ+xVy2A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 6/7] mm/damon/core: update probe hits for new parameter commit
Date: Tue,  7 Jul 2026 20:56:04 -0700
Message-ID: <20260708035606.118344-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708030544.6EBC61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 03:05:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unbounded iteration over `ctx->probes` list writing to the statically sized `probe_hits` array can lead to buffer overflow.
> - [Medium] Scaling `probe_hits` and `last_probe_hits` using `damon_nr_samples_for_new_attrs()` assigns an `unsigned int` to an `unsigned char`, causing silent truncation and data corruption when the scaled count exceeds 255.
> --
> 
> --- Patch [6]: [RFC PATCH v1.3 6/7] mm/damon/core: update probe hits for new parameter commit ---
> commit 5d7c7277de18e07d88cf49d1f16d870a9dfc0f23
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: update probe hits for new parameter commit
> 
> Users can update DAMON parameters at runtime.  If the samples and/or
> aggregation intervals are updated in this way, monitoring results
> depending on the intervals should also be updated for a more accurate
> snapshot.  The age and nr_accesses are properly updated, while
> probe_hits are not updated in the way.  Do the update.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 800ff6b6d2473..15d31285515d6 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -897,10 +897,32 @@ static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
> >  			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
> >  }
> >  
> > +static void damon_update_probe_hits(struct damon_region *r,
> > +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> > +		bool aggregating, struct damon_ctx *ctx)
> > +{
> > +	struct damon_probe *p;
> > +	int i = 0;
> > +
> > +	damon_for_each_probe(p, ctx) {
> 
> [Severity: High]
> Does this loop overflow the r->last_probe_hits[] and r->probe_hits[] arrays?
> 
> The probe_hits and last_probe_hits members are defined as fixed-size arrays of
> size DAMON_MAX_PROBES. Since there is no bounds checking on i, if there are
> more than DAMON_MAX_PROBES in the ctx->probes list, this will write past the
> end of the arrays and corrupt adjacent fields in struct damon_region.

That cannot happen since DAMON_SYSFS is not accepting that input.   Read
nr_probes_store() for more details.

> 
> > +		r->last_probe_hits[i] = damon_nr_samples_for_new_attrs(
> > +				r->last_probe_hits[i], old_attrs, new_attrs);
> 
> [Severity: Medium]
> Will this assignment cause silent truncation and data corruption?
> 
> The last_probe_hits and probe_hits arrays are declared as unsigned char
> (8-bit) in struct damon_region, but damon_nr_samples_for_new_attrs() returns an
> unsigned int (32-bit).
> 
> If the scaled count exceeds 255, assigning it directly will truncate the value
> to a meaningless modulo-256 wrapped value rather than clamping it at a maximum.

Known low priority issue.

> 
> > +		if (!aggregating)
> > +			r->probe_hits[i] = damon_nr_samples_for_new_attrs(
> > +					r->probe_hits[i], old_attrs,
> > +					new_attrs);
> > +		else
> > +			r->probe_hits[i] = 0;
> > +		i++;
> > +	}
> > +}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708024855.116614-1-sj@kernel.org?part=6


Thanks,
SJ
