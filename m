Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76817993
	for <damon@lists.linux.dev>; Sat, 16 May 2026 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891767; cv=none; b=hJvc4qfxA+DC67nRaEq1iloEAgWIRkz00y0tLid6V4SU5f/lAxBpzaw9MFZ9Gw0mk6daN4PUjweF1zEwgo9QQKk3rj7594jkgXJDMJvXhbtyOREBZjiBico8VasxqFPAYfI5hK0kM6cg/uuvFxYoXRAJRqWbzH5VLGKeH0HufKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891767; c=relaxed/simple;
	bh=amN+VEiBS4EqVJFJNgV7Ap7WRGsGJBtd/oIT+2DG6TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xq0S0KvjCF19UFkLqho1Ll8+OrqjQd5pDxDUbxwdgMXj/QgRLRqjh0iXS+up+z0ULH03CYxeFy9tudo7cgCD2lzbJfAIqMVKKbK1Gd8wuU3J1YYxAtFUq131QJ2JAExRNaIFsXGil4i1rAnBQkKl8ff30bZ8mxllHCiqYqAIBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXrvhzJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXrvhzJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748FEC2BCB0;
	Sat, 16 May 2026 00:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891766;
	bh=amN+VEiBS4EqVJFJNgV7Ap7WRGsGJBtd/oIT+2DG6TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXrvhzJTe/NdoXoO5X6Y9JPO+26hSe0xQ8AJaSBhmi12ktqOT6EyXEI8VZJXjGgZ2
	 ex/oQHFjbOUtNo855w5fq0ay8uMrJaGrudt85fgLIr/wGXa15PhOKTktVvcvF0kYCU
	 st9s6+pi9slsLcaQyMGlBkgmVQaI3LjqB0P3LJDxwrsTTZPJZk5qpYozE2PxJNeJK8
	 34ymqZfX57PTtIvP6ZqfReWyzuLx5Rzgjx4ldHVEKPOH6dZ8THt2E+UlTf8ZYp5/WA
	 8FH8GTLpTOF/qRVmxmceyDQ2kR2UvtyGeP5m5eL/OiexHzKWfrqTmwRFgYXvEY5oU8
	 i1MjcuMuVpo9w==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Fri, 15 May 2026 17:35:58 -0700
Message-ID: <20260516003559.141476-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515005446.EEF89C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 00:54:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] The `probe_hits` array is not propagated to the new sub-region during a region split.
> - [High] The `probe_hits` array is not recalculated during a region merge.
> - [High] The `probe_hits` counters are susceptible to integer overflow.
> - [Medium] The `probe_hits` array is not scaled when monitoring attributes change dynamically.
> --
> 
> commit 5ada6fcb6176988079396fb12d1bf709aa9d2522
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_region->probe_hits
>     
> Add an array for the per-region per-probe positive samples count.  For
> simple and efficient implementation, add a limit to the number of data
> probes and set the array to support only the limited number of counters.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 9c2576f103767..bf78ad849a9be 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -80,6 +83,7 @@ struct damon_region {
> >  	unsigned long sampling_addr;
> >  	unsigned int nr_accesses;
> >  	unsigned int nr_accesses_bp;
> > +	unsigned char probe_hits[DAMON_MAX_PROBES];
> >  	struct list_head list;
> 
> Can this overflow?
> 
> Since it is an 8-bit unsigned char, it can hold a maximum of 255.
> The number of samples per aggregation interval is aggr_interval /
> sample_interval. Both are user-configurable via damon_set_attrs(), so
> configurations that yield more than 255 samples per interval could
> overflow this counter and corrupt the exposed data.

Yes, but such configurations may be rare.  The default and recommended
configuration is to have 20 as the max number.  And users who runs proper
testing before deploying changes to the production may find the issue.

But better to avoid that if possible.  I will consider returning error when
such configuration is committed.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 15f2795a1156f..f6b4beb4b8ecd 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -235,6 +236,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
> >  	region->ar.end = end;
> >  	region->nr_accesses = 0;
> >  	region->nr_accesses_bp = 0;
> > +	for (i = 0; i < DAMON_MAX_PROBES; i++)
> > +		region->probe_hits[i] = 0;
> >  	INIT_LIST_HEAD(&region->list);
> >  
> >  	region->age = 0;
> 
> Are we missing a copy of probe_hits in damon_split_region_at()?
> 
> When a region is split, the new right-hand sub-region gets zeroed
> counters from damon_new_region(), losing its historical positive sample
> counts for the current aggregation interval:
> 
> mm/damon/core.c:damon_split_region_at() {
> 	...
> 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
> 	if (!new)
> 		return;
> 
> 	r->ar.end = new->ar.start;
> 
> 	new->age = r->age;
> 	new->last_nr_accesses = r->last_nr_accesses;
> 	new->nr_accesses_bp = r->nr_accesses_bp;
> 	new->nr_accesses = r->nr_accesses;
> 	...
> }

Nice catch!  I will do that in the next revision.

> 
> Should probe_hits also be merged in damon_merge_two_regions()?
> 
> When adjacent regions are merged, l->nr_accesses and l->age are
> recalibrated using a size-weighted average. However, the probe_hits
> array of l is left untouched, and the probe_hits data from r is entirely
> discarded:
> 
> mm/damon/core.c:damon_merge_two_regions() {
> 	...
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
> 	l->nr_accesses_bp = l->nr_accesses * 10000;
> 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
> 	l->ar.end = r->ar.end;
> 	...
> 	damon_destroy_region(r, t);
> }
> 
> Does probe_hits need to be scaled in damon_update_monitoring_result()
> when monitoring attributes change dynamically?
> 
> Since it tracks positive samples over the aggregation interval just like
> nr_accesses, leaving it unscaled might result in stale values that
> misalign with the new interval constraints.

Good finding!  I will do that in the next revision.


Thanks,
SJ

[...]
