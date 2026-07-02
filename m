Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10845431E64
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951046; cv=none; b=i5RAMz0EgJDDjBKJN5bNvKe6fbUN1fEu82l1rTZzGz0rua2v0nCE+XNw1fyicqP6nbWl4LbeVx7HKv+ehWldtSkjWVEgoqgOVd53+T57sxJ2Af9ZIb2RSKHueFSGolX4sLte6T06uUrKO1IgydrVutmmjsvALJPjZGkHEDNUYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951046; c=relaxed/simple;
	bh=yjNxC+fYfnJmhUBUXXqLCEtSG+cFN2n00rQboa+QlKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im1ZuCb9gkqNNQ0wWy+RO2N7m2s80hSvHAzFY77VycTtlJJDSn52u/6yZKKNIz0h655gV671a7Dle66+kRtx/RS0AioTHu6rHnpyByTSWRY+uCOkaIO4RY+ApaxbyfWvsvhrx0p45a+atJrZm9e2O3L7kIe97bqG/8V48IS2J0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5CtJTOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5CtJTOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8764A1F000E9;
	Thu,  2 Jul 2026 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951044;
	bh=zBlET8slUm0HAPSzV7BzUtW+/oWEvqlbQHv6NgPcplA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O5CtJTOK6zgv9UZRuXgoU5RAvdkCAB/j9EhiOOA/BEOXLLdG4kGdEMmHd0ed8+cXl
	 iCtthe7+Ab36JvCEzRKWHynFUZXRw+VstPMlN4gzhQa257m6IMGkO+u1xBY55z4VjB
	 fYQw/QNpL1kmJwWgSiB2r2Adwj2tUBQhxd90dKIXUBgs+Nb2hyuc2prAMssdNO3kAz
	 QuGaTDK8Dnh19mZWIUnEfkN0+25TiUciG/x+gGVkJVlkkjx7/GkI1egX2vJdYWzzWi
	 Mr3MK8T5LulmJ2FfEOrmrngWgNHRU7FzrdvEWhGnOR9m0QvyHIQd+8uaV9E2Zi7Nlm
	 Syqm0hIHeXgeQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/8] mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
Date: Wed,  1 Jul 2026 17:10:35 -0700
Message-ID: <20260702001036.86567-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701154258.191FD1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 15:42:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the early `is_power_of_2()` check allows invalid `min_region_sz` inputs to reach `damon_commit_ctx()`, which exposes a bug introduced earlier in this series that corrupts the live context and silently terminates the DAMON background thread.
> --
> 
> commit f5d47eadcc06079427c142dd59c5a8aa8721caec
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
> 
> DAMON_RECLAIM validates the user input for min_region_sz.  The same
> validation is done inside damon_start() and damon_commit_ctx().  Remove
> the duplicate.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 11b70d0a9a6f0..6469b25cc34f9 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> 
> [Severity: High]
> Does removing this early check expose a bug introduced earlier in this series?
> 
> If the user provides an invalid addr_unit (e.g., 3), min_region_sz will not be
> a power of 2. By removing the check here, this invalid parameter is passed
> to damon_commit_ctx().
> 
> Due to an issue in damon_commit_ctx() (from "mm/damon/core: safely validate
> src on damon_commit_ctx()"), the dry-run validates dst instead of src:
> 
> mm/damon/core.c:damon_commit_ctx() {
> 	...
> 	err = __damon_commit_ctx(test_ctx, dst);
> 	if (err)
> 		goto out;
> 	err = __damon_commit_ctx(dst, src);
> 	...
> }
> 
> When __damon_commit_ctx() is called with the live dst and invalid src, it
> sets dst->maybe_corrupted before returning -EINVAL:
> 
> mm/damon/core.c:__damon_commit_ctx() {
> 	...
> 	dst->maybe_corrupted = true;
> 	if (!is_power_of_2(src->min_region_sz))
> 		return -EINVAL;
> 	...
> }
> 
> Could this cause the background kdamond thread to see maybe_corrupted as true
> on its next iteration and permanently terminate, silently turning a simple
> configuration error into a denial of service for the subsystem?

Yes, I will fix damon_commit_ctx() in the next revision.


Thanks,
SJ

[...]
