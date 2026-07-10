Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6E29D260
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694644; cv=none; b=arNaazsLh6f78IM5gWxMeYG9VEbeRfEYqTzS5ORq6XfRfH43LE8ZB2XkUelm7YxOoeu6KZ6E67WGvmsvd7chfj90o3IbLtQAiawDiSnSCZSLXF7ZW9lCbGndR2C+mU7MTiWHJnDUDxq4ow7mQr1d9bj9FmYKkUVyO7Ly8K7qYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694644; c=relaxed/simple;
	bh=hgoNi3t48Mms1/2xZHUFxM6pYA1lkH7QiDwXAFdlPiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua1a9Cj8GdSv8BU6oQGGR5bd1uFPl1mGD/N8GgUKsRRDJ9DZ1TVHTWVBe8/taZxW0ye7EA7IX95jEbCCpXyP4WHbnmF4B0XBvhEcfXdATSVRTlBqzBipR/A3CDhx6FozzEZHA93GO/Wph9oehrIeqOn5flO0DIBfW2YP74xJLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMVip17Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMVip17Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB2E1F000E9;
	Fri, 10 Jul 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694643;
	bh=o4iGwzOKN9P4H4y7luBGp4DmcfWA2eNg81bjN1hj1Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMVip17YZ/hHrrOCvCdzoR9B2mtJf1AdIAW6Z/c/RrvRTl66k08ORGZQj3Jb0BP43
	 Zt02BiYVR5S9VfTqeQEApsSAln6Cuq8ngVv5pix06UOXQio58KubIBL6qzbQLmP/dC
	 yvC9t9psYrXsfrs9xwh1CSzC9jU3IOgy4Sntqzb0g4QFx7W3GD3IrhFxG7wjH85u6E
	 4+BNfjdvk+IAxsEqUezGefZFmrHK4dkSo7uJCS70CKLZH03kQdJ6U30G00gUxlFu1M
	 9dVezkoVLahKpjwHU38TP0q2rLY1qjOi7ZJgaOeJjUf9Mm+arBcAqrrvwxGFoSnbCv
	 6zfz334mJS4KA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 07/19] mm/damon/core: use abs_diff() instead of abs()
Date: Fri, 10 Jul 2026 07:43:53 -0700
Message-ID: <20260710144355.26811-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710141055.0B90E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:10:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Unchecked memory allocation failure in `damon_apply_min_nr_regions()` leads to heap corruption and infinite loops
> --
> 
> --- Patch [7]: [PATCH 07/19] mm/damon/core: use abs_diff() instead of abs() ---
> commit 168e2738a1f4077551ffee47ed4ecb0a582831f3
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: use abs_diff() instead of abs()
> 
> Replaces abs() with abs_diff() in damon_merge_regions_of() to prevent
> silent integer overflow when casting unsigned int to signed int.
> 
> Link: https://lore.kernel.org/20260705213817.100841-1-sj@kernel.org/
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index fea97399b5754..4c7e8a12a9b67 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3269,7 +3269,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> >  			r->age++;
> >  
> >  		if (prev && prev->ar.end == r->ar.start &&
> > -		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
> > +		    abs_diff(prev->nr_accesses, r->nr_accesses) <= thres &&
> >  		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
> >  			damon_merge_two_regions(t, prev, r);
> >  		else
> 
> [Severity: Critical]
> This is a pre-existing issue and was not introduced by the patch under review,
> but I noticed a potential memory corruption issue in
> damon_apply_min_nr_regions() when a memory allocation fails.
> 
> If damon_split_region_at() fails to allocate memory, it aborts silently and
> leaves r->ar.end unchanged.
> 
> The loop then unconditionally advances r:
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
> 	damon_for_each_target(t, ctx) {
> 		damon_for_each_region_safe(r, next, t) {
> 			while (damon_sz_region(r) > max_region_sz) {
> 				damon_split_region_at(t, r, max_region_sz);
> 				r = damon_next_region(r);
> 			}
> 		}
> 	}
> }
> 
> Can this corrupt memory or cause infinite loops if the allocation fails on
> the last region in the list?
> 
> If this occurs on the last region in the target's list,
> r = damon_next_region(r) resolves to the list head (&t->regions_list).
> 
> Because the list head is embedded inside struct damon_target, container_of()
> returns a bogus struct damon_region pointer pointing before the damon_target
> object.
> 
> The next iteration of the while loop would read r->ar.start and r->ar.end
> from this invalid memory. If the computed difference exceeds max_region_sz,
> it enters the loop again. A successful damon_split_region_at() could then
> write the new region's start address to r->ar.end, corrupting memory before
> the damon_target structure.

Good finding.  Not a blocker of this patch, though.  I will separately work on
this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=7


Thanks,
SJ
