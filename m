Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37E35E1D5
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242458; cv=none; b=oub6yx+upzTvX6hAxnw8AckF4DjsB2VdbNFEBgn9jrzR9116UFu9Ufk8EJWzH/bEAB96rMu6AIeq3ZQUjQW2l/SNuCsIRdgUMADhVt6mGJbLTJAA0ZdJl+8VHfbiPpsnrbL/jD+91GYYhIPA+GURj8DrVp+xqgxMLZXaIeKkbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242458; c=relaxed/simple;
	bh=fghhG8RZtNS9uIIwKDfQKBAdoSid1z5Yp3iGWLVc+PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0SwYdNlk9EARP1djGEPLscBzI9G4dlEE4KUceWxlS8t4WpQEB7UJ6zAXHCvYb/IWbsVCJCWqmr2KW9BUAhmCPGUgqBViyNMWZ/B+X/QlytlWqHkzzzrQn4s+1jw6yK7Limu9zZENBllcjQ4AWu23lr7vtWErf/mwUAT7Bg44Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia0KC3PN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia0KC3PN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A341F00893;
	Sat, 12 Sep 2026 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789242457;
	bh=9KKQN4+WQllVGBBIvRIXjVYzsvgNavTCEe9DtOPGLj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ia0KC3PNuVjImF+1RjPwebfuG2mUYOo0hGOFmXLSIHG+r+UYpgh2GGXW5g3onqM84
	 Aw62fGoM+XRbGu7gi+6rCzx+/O4qfp5mTaJGSITZtLnN23CIXkV7G/VUgYN3G6Uapu
	 TmLEcLOG0MV6sfMKmCZfAD6KiByVRMgEXC4pIuy3t6u1pAadniBlb/MTXg1nRQ6mA8
	 Lt6IwgRXW/Qi3oeisIN1LRFauKEhra9njR0WYXGrnXl7KqeCdp/JcSb05Nx75TfsQp
	 8Tn48s7qoQnVs06H9VXoRO8jEd3XBkswfn6I6PKW0bv8j884BhdYoR9JYY9dxiOBtg
	 HQ9P2vI9O2sQg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Sat, 12 Sep 2026 12:47:28 -0700
Message-ID: <20260912194730.139780-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912193641.04AF61F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 19:36:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Missing error handling for damos_commit_filter_arg() and damos_commit_filter() leads to uninitialized memory use for DAMON filters.
> 
> Pre-existing issues:
> - [Critical] Memory allocation failure during damos_commit_dests() leaves the active scheme object partially torn down, leading to a deterministic NULL pointer dereference.
> --
> 
> commit 0ffd278b1f3947b2729c57dd026fc9283304d3af
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: test invalid damos filter commits
>     
> Add test cases for testing the validation of damos filter arguments in
> commit time.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 2b0931cf6fb32..527abc2570616 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit *test)
> >  			.allow = false,
> >  			.sz_range = {.min = 234, .max = 345},
> >  			}, false);
> > +	damos_test_commit_filter_for(test, &dst,
> > +			&(struct damos_filter){
> > +			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> > +			.matching = false,
> > +			.allow = false,
> > +			.sz_range = {.min = 456, .max = 123},
> > +			}, true);
> 
> [Severity: High]
> Does this patch series leave uninitialized memory in the payload of DAMON
> filters if an invalid range is provided?
> 
> While this patch adds tests for invalid filter ranges, it appears the error
> handling in earlier patches of the series might be incomplete. If a user
> provides an invalid range (e.g., max < min) via DAMON sysfs, the core
> validation returns -EINVAL, but this error is ignored when allocating a new
> core filter:
> 
> mm/damon/core.c:damos_commit_core_filters() {
>     ...
> 	damos_for_each_core_filter_safe(src_filter, next, src) {
> 		if (j++ < i)
> 			continue;
> 
> 		new_filter = damos_new_filter(
> 				src_filter->type, src_filter->matching,
> 				src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		damos_commit_filter_arg(new_filter, src_filter);
> 		damos_add_filter(dst, new_filter);
> 	}
>     ...
> }
> 
> Similarly, the return values of both damos_commit_filter() and
> damos_commit_filter_arg() are ignored when updating or allocating an ops
> filter:
> 
> mm/damon/core.c:damos_commit_ops_filters() {
>     ...
> 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> 		src_filter = damos_nth_ops_filter(i++, src);
> 		if (src_filter)
> 			damos_commit_filter(dst_filter, src_filter);
> 		else
> 			damos_destroy_filter(dst_filter);
> 	}
> 
> 	damos_for_each_ops_filter_safe(src_filter, next, src) {
> 		if (j++ < i)
> 			continue;
> 
> 		new_filter = damos_new_filter(
> 				src_filter->type, src_filter->matching,
> 				src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		damos_commit_filter_arg(new_filter, src_filter);
> 		damos_add_filter(dst, new_filter);
> 	}
>     ...
> }
> 
> Since damos_new_filter() allocates with kmalloc_obj() (which does not zero
> memory), ignoring the return value of damos_commit_filter_arg() could lead to
> the uninitialized heap data remaining in the filter's payload
> (e.g. sz_range or addr_range) when it is added to the active DAMON context.

Yes, I will fix in the next spin.

> 
> 
> [Severity: Critical]
> This is a pre-existing issue, but can memory allocation failure during
> damos_commit_dests() leave the active scheme partially torn down and lead to a
> NULL pointer dereference?
> 
> If memory allocation fails for dst->weight_arr, damos_commit_dests() leaves
> dst->nr_dests with its old non-zero value, but assigns NULL to the array:
> 
> mm/damon/core.c:damos_commit_dests() {
>     ...
> 		dst->weight_arr = kmalloc_array(src->nr_dests,
> 			sizeof(*dst->weight_arr), GFP_KERNEL);
> 		if (!dst->weight_arr) {
> 			/* ->node_id_arr will be freed by scheme destruction */
> 			return -ENOMEM;
> 		}
>     ...
> }
> 
> Because damon_commit_schemes() breaks its loop on -ENOMEM and returns, the
> partially modified scheme is left physically linked in the live context's
> scheme list:
> 
> mm/damon/core.c:damon_commit_schemes() {
>     ...
> 		src_scheme = damon_nth_scheme(i++, src);
> 		if (src_scheme) {
> 			err = damos_commit(dst_scheme, src_scheme);
> 			if (err)
> 				return err;
> 		}
>     ...
> }
> 
> When the kdamond worker thread later executes damos_va_migrate_dests_add() on
> this corrupted scheme, it appears it will iterate up to dests->nr_dests and
> dereference the NULL weight_arr pointer:
> 
> mm/damon/vaddr.c:damos_va_migrate_dests_add() {
>     ...
> 	for (i = 0; i < dests->nr_dests; i++)
> 		weight_total += dests->weight_arr[i];
>     ...
> }
> 
> Is there a mechanism preventing this kernel panic if memory allocation
> fails on the live destination context?

Yes, we have damon_ctx->maybe_corrupted to prevent this.  So, no issue.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912191807.138502-1-sj@kernel.org?part=8
> 


Thanks,
SJ
