Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C603BCD21
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762471; cv=none; b=F4VGawsPP0BT0qNzaEND20sHYDHoxUstFQHCNAntpGnNRQ9bfwI/aLq7vH3dHM8osWAYM7pZDbUDxiD0Dvt9xKDsoMMIV31OwKIigF9c+SvbB6oW+TzSv14V4EL2qGdfmI5ZxGRuAelslieOEh/P/kMfNC0QZqmvP/835xdtLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762471; c=relaxed/simple;
	bh=lgaI7tctE69zJtR4kQYqoBAMZNstwjBldCVKZ0Us0BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFzf+Nakma5h4r7DwIvBr9iR8MCblYeXF/AumE2CU/GICvtCrOmxsH5tLLpXJY/C/v6Vqzxx5ZAuaahcLKj1yJA12qrNfNEz0UkcaX8VveYuSIGKZyKIEqFwWTAGdd9KaP/f+MoXoO2sYbPS6E5t69c8k9mBD6q2kLIsGwf1rpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwNFc+Sr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwNFc+Sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983F41F000FF;
	Wed, 30 Sep 2026 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762469;
	bh=uVD4bUCX2g0KyP+tth/EvlM6CAqdsSR4Eh1TJZPhu8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwNFc+Sr9Y+IydpfmTY4y/qz0IWtq7mMs680vW5jHj1jCM+pxjXk6ZEpbmnG3DLct
	 6UalAYgWcVv8UZTJ0PjL62hc++NY2ubGMwDGr4bOS3B1pAQXvuKWNPuSVqjlVtxyQ0
	 sWVbkZaiLPf3bHQ5qzQkFCtMHreu1GpF0cfKdryWcb4Z/AJZwKgl9x44zjt0tbmvxC
	 NeruJ5X/qLko6XtLq/JpGr/8+Y+3XI3scuxOVq0bbal44YfojGuFD9nrWUb0GPVWU0
	 oAr99qYFudtN1sajXaIRP7F8gT6VZoVSsKHOPzihee6A9wq/OJpb9ME90ubEOtQ4RV
	 ef2GwCJVhW19A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:01:05 -0700
Message-ID: <20260930100106.52943-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930095335.05B6A1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 09:53:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] damon: OOB write and list corruption when damon_split_region_at() fails
> - [High] damon: permanent skipping of targets due to charge_target_from state leak
> --
> 
> commit 035ce5241b6b256409f7ad3d4de6c01dbe7e8563
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> mm/damon/core: fix unconditionally skip last region
> 
> This patch modifies the skip logic in DAMON to only reset the
> charge_target_from state when the last region is reached. It also updates
> the function to skip the region only if it is applied or cannot be split,
> rather than unconditionally skipping the last region.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 32737cc5f877b..802005d9186e8 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1348,11 +1346,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  			damon_split_region_at(t, r, sz_to_skip);
> >  			r = damon_next_region(r);
> >  			*rp = r;
> 
> [Severity: Critical]
> Could this lead to out-of-bounds writes and list corruption if
> damon_split_region_at() fails?
> 
> This patch removes the early exit condition for the last region, exposing it
> to damon_split_region_at(). If memory allocation fails, the split function
> returns silently without modifying the list:
> 
> mm/damon/core.c:damon_split_region_at() {
> 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
> 	if (!new)
> 		return;
> ...
> }
> 
> The pointer is then unconditionally advanced with r = damon_next_region(r).
> If r was the last region, damon_next_region() wraps around to the list
> head (&t->regions_list), generating an invalid struct damon_region pointer
> pointing outside valid regions. Subsequent writes to this pointer will
> corrupt the target sibling list integrity.

This is a pre-existing issue.  I will separately work on the fix.

> 
> > +			skip = false;
> >  		}
> > +	}
> > +out:
> > +	if (r = damon_last_region(t)) {
> 
> [Severity: High]
> Does the early return inside the region size check bypass this cleanup logic?
> 
> If sz_to_skip evaluates to 0 and the region size is <= DAMON_MIN_REGION,
> the code hits an early return:
> 
> mm/damon/core.c:damos_skip_charged_region() {
> ...
> 		sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> 				r->ar.start, DAMON_MIN_REGION);
> 		if (!sz_to_skip) {
> 			if (damon_sz_region(r) <= DAMON_MIN_REGION)
> 				return true;
> ...
> }
> 
> Because this early return bypasses the new out label,
> quota->charge_target_from remains populated if this occurs on the last
> region. For all subsequent targets, the check
> if (t != quota->charge_target_from) evaluates to true and indefinitely skips
> those regions, causing targets to be starved.

Good catch.  This is a mistake in my backporting.  I will send v2.

> 
> >  		quota->charge_target_from = NULL;
> >  		quota->charge_addr_from = 0;
> >  	}
> > -	return false;
> > +	return skip;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930092829.45885-1-sj@kernel.org?part=1
> 


Thanks,
SJ
