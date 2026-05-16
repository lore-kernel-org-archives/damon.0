Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E025B0A7
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778966841; cv=none; b=fqEHd3HbtF/Rl3TKMaYKbJwsjPr7XDboGKh/GTVwWWfoDdbxxBv3KAubEslbyY8oMiUiriWkikILbzsq1ZDjk9yR0xyjHLs0usZulyfcmJDRfDqvp+z3Q8G5XzOl/Hit8UfNIZ0GP5fu6hSMqoAGwik+t462Wsetpj2JRD3XGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778966841; c=relaxed/simple;
	bh=6m/Ag61uLduK+g5aAUT+xR3avsPOTtmhD8K1PtKyJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBfmBPrO9Fp5smxmUqLvpySSwnydSKRjTGL2PeRElgl/ll+tCg0AQm1IMaLGEU6eCE9e0kout2CdqWuY5x1tMObKR92QeBsI5Pgc0Yb3qNjOYGUXy4qRJtzKb9IdHEHhrgYdil/BrKciYUqIgG4io0W7SWweFGqbZN53BkI2pfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFXS7Lfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFXS7Lfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31D2C19425;
	Sat, 16 May 2026 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778966841;
	bh=6m/Ag61uLduK+g5aAUT+xR3avsPOTtmhD8K1PtKyJlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFXS7LfjcPyQLKHfAjZ/2ASCLAwHyxRXb9zYezJX34t/sx7Jb0XEdGKT/Fdj2pHKt
	 DqhkOrGynkmZMT6Wq//krzVVhelZH8SASOZtAsykRyioAYxEMuJ5oAL/9ZiN065Zy6
	 DzluP9sTQHoXReINlZ2TxK3I7uqqTD4K3MSPWOo+cr4sSj5VqrWAE8r9uMzTO6HL2z
	 viiXRZw08sOmMqjrgUFeMQ2EvWlQvDIVCBFYoySqGtI0mf2TQ/PC0VS1sejZADPjrj
	 uKhvJF3mKiAk1829R0zADta+DCAQxH81VhDQksEkxlcYa3TAgAiSGuVMfBVYnFi1Ez
	 pYzew4hNpyVtw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Sat, 16 May 2026 14:26:34 -0700
Message-ID: <20260516212634.2945-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516185436.1ECEFC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 18:54:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Data type overflow of `probe_hits` array due to 8-bit `unsigned char` limit.
> - [High] Integer overflow in `probe_hits` weighted average calculation on 32-bit systems.
> --
> 
> commit b34f3f1254d83e9491235fb4e8e097729be04e60
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_region->probe_hits
> 
> This commit adds a probe_hits array to the damon_region structure to track
> the number of positive samples per region for each probe. It limits the
> number of probes to a fixed maximum for a simpler implementation.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 32005b8b1f8cd..9e70239e5305f 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -80,6 +83,7 @@ struct damon_region {
> >  	unsigned long sampling_addr;
> >  	unsigned int nr_accesses;
> >  	unsigned int nr_accesses_bp;
> > +	unsigned char probe_hits[DAMON_MAX_PROBES];
> 
> Does probe_hits need a wider type to prevent wrapping around?
> 
> Since the number of samples in an aggregation interval is determined by
> aggr_interval / sample_interval, user-configurable values could cause the
> sample count to exceed the 8-bit limit of unsigned char (255). This might
> lead to silently wrapped monitoring statistics.

Yes, but such configurations may be rare, so no blocker.
For more details, please read my previous reply [1] for same question.

> 
> >  	struct list_head list;
> >  
> >  	unsigned int age;
> [ ... ]
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 15f2795a1156f..e5667660b4cd9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2754,12 +2757,17 @@ static void damon_merge_two_regions(struct damon_target *t,
> >  		struct damon_region *l, struct damon_region *r)
> >  {
> >  	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
> > +	int i;
> >  
> >  	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> >  			(sz_l + sz_r);
> >  	l->nr_accesses_bp = l->nr_accesses * 10000;
> >  	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
> >  	l->ar.end = r->ar.end;
> > +	/* todo: do this for only installed probes */
> > +	for (i = 0; i < DAMON_MAX_PROBES; i++)
> > +		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
> > +				* sz_r) / (sz_l + sz_r);
> 
> Could this weighted average calculation overflow on 32-bit architectures?
> 
> Both sz_l and sz_r are unsigned long, which is 32 bits on 32-bit systems.
> If a region size is large (e.g., > 16.8MB) and probe_hits is up to 255,
> multiplying them can exceed the 32-bit limit and wrap around, corrupting
> the monitoring statistics.
> 
> It appears the nr_accesses calculation just above this has the exact same
> flaw, and this patch propagates it to the new probe_hits array.

On 32bit systems, users could use the addr_unit to avoid this kind of issues.
So no blocker.

[1] https://lore.kernel.org/20260516003559.141476-1-sj@kernel.org


Thanks,
SJ

[...]
