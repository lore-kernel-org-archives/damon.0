Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5C3AAF57
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014037; cv=none; b=Y49hB1V93pX0CFibn3R+kpOx2dCfZDSmRapV9h+fhYSrdHXok4/gjYboJS6vI63ED4CczQaXw2hSBLESrQjIZEmNgRBbYPuseztx6WaOj+IzV+0Y59rqzCFybfS0G10GK04WM+W/WRHdqln/J0VfC46gRrZ4B74pZZK71bzO4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014037; c=relaxed/simple;
	bh=9J7xauHQwp216JR2g6m7fFUvT+hsxjk09Vq7dk180Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFS5hGRNrjKTVEaxvomtRFHipVzNmERCd6U9ovkB1JnqgHliPxuGn9sLJ4J2xdctk4RMolkeP4S2ejCqwwog6ahV7FzwYk4/MY/FEdeNtGZUsTycpkPtCu581MMfLaeRW85YNL3ABH9EYkVYXkfce8mN5GZsLzlhHvM0YsQoLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxWo2Mb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxWo2Mb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8C91F00893;
	Thu, 10 Sep 2026 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014034;
	bh=g7ZXHPB85CmnlZlwfDdDww6WBHGErUhPXRl+KM8bG2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxWo2Mb/wsgGJCGjwR99QRJZOolnnz0f0OmOVcg7Ch9WH+TWzLSDMpW2BZqrqHMSB
	 hdSMYPXfjZFhteWM/IY59cuxCxCaCdtirYRffNCDK9r0R4Xds9nPEirQLZ32PpA3Jo
	 ezL2Npcu/RB2nx/ZG9Mr9mJu2TlAZg0vonLOW9jJFnWZ/lJs5q+/FBhBhDeI6aqgJE
	 zqG7qznAO1cz7W7IBt9aX/cDgJTtFtBjrSeOhVTNe4+WBM0xWuvOP6Wg44u/k1ZI3H
	 4GpucFnsYo8n2gPWFCn/8yzn6LVcVnWBy9Yi/Dkv7qX4bLwkTAJrwkBWUcjk7EQCnT
	 rovqatcqmEm/g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Wed,  9 Sep 2026 21:20:26 -0700
Message-ID: <20260910042027.149206-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910041647.9CE271F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 04:16:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Missing kunit test coverage for the newly added DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter.
> - [Low] The kerneldoc for `enum damos_filter_type` was not updated to reflect that `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` is a core layer filter.
> --
> 
> commit 3af974fc20158a639272fd766ad727c8d30c0f3e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: support probe_hits_wsum damos core filter
> 
> Implement probe_hits_wsum DAMOS core filter support in the core layer.
> Make three small changes for the support: update damos_filter_for_ops() to
> treat probe_hits_wsum filter as core filter, update destination
> damos_filter->range_{min,max} for probe_hits_wsum, and extend
> damos_filter_match() to handle the new filter type.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e9630f41e51fe..d9d56f4be1a97 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -658,6 +658,7 @@ bool damos_filter_for_ops(enum damos_filter_type type)
> >  	switch (type) {
> >  	case DAMOS_FILTER_TYPE_ADDR:
> >  	case DAMOS_FILTER_TYPE_TARGET:
> > +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> 
> [Severity: Low]
> Does the kerneldoc for enum damos_filter_type need to be updated to reflect
> that DAMOS_FILTER_TYPE_PROBE_HITS_WSUM is a core layer filter?
> 
> include/linux/damon.h:enum damos_filter_type {
>  * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
>  * are handled by the underlying &struct damon_operations as a part of scheme
>  * action trying, and therefore accounted as 'tried'.
> 
> The documentation here explicitly lists only ADDR and TARGET as exceptions,
> failing to update the list with the newly added PROBE_HITS_WSUM core filter.

Yes, I will update so in the next revision.

> 
> >  		return false;
> >  	default:
> >  		break;
> 
> [ ... ]
> 
> > @@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
> >  	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
> >  		dst->sz_range = src->sz_range;
> >  		break;
> > +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> > +		dst->range_min = src->range_min;
> > +		dst->range_max = src->range_max;
> > +		break;
> 
> [Severity: Low]
> Is there missing KUnit test coverage for the newly added
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter?
> 
> The copying logic for the new filter type's arguments (range_min, range_max)
> is left untested, which could hide future regressions.
> 
> In mm/damon/tests/core-kunit.h:damos_test_commit_filter_for(), the switch
> statement verifies filter argument copying but is missing the case for
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> 
> 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
> 		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
> 		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
> 		break;
> 	default:
> 		break;
> 	}
> 
> Additionally, in mm/damon/tests/core-kunit.h:damos_test_commit_filter(),
> the function enumerates all filter types for testing but fails to include
> instances of DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> 
> 	damos_test_commit_filter_for(test, &dst,
> 			&(struct damos_filter){
> 			.type = DAMOS_FILTER_TYPE_TARGET,
> 			.matching = true,
> 			.allow = true,
> 			.target_idx = 6,
> 			});

Good callout.  But definitely not a blocker of this series.  I will consider
adding such tests as a followup.

> 
> >  	default:
> >  		break;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040319.147037-1-sj@kernel.org?part=3
> 


Thanks,
SJ
