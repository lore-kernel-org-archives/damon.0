Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918133F8B4
	for <damon@lists.linux.dev>; Thu, 21 May 2026 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343533; cv=none; b=TlUegSxKlPs5jUblVlabKKNHjOOj/onNzX5PRSMNFSuRGONYxllCv9PzOiSTPNfo9+9cCoXlA25A46AJomLVay27Lly9zqqftZM9YtTIvoO2y7fqVvcpOSahYGTMZseTocKey25hoaH5vV4y4cDnBj9x/yZ/XX2hpvklzR2m9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343533; c=relaxed/simple;
	bh=7vz3v9RFQrzzb9gzNWw/Rcv5M545TaEvWUqOhc7FXp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ5Ym5tZC+FyRWIxoDwbNsy4F38nUfmqU8PTi9BPMo9pfnMvDdOfE/F9zQkfpHrbA8rfc1yLbuHqEui8BjxQsQIDeAOyg+YyASMeSZaDoqKvBsJcntdsBTLrFXu7QBWY0zeBKVsP3p6oXoPLJKul2JHz4cBD9R7H9zpvR7uXD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVYnUnzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVYnUnzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF171F000E9;
	Thu, 21 May 2026 06:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779343532;
	bh=bfv+DA4vVDs7J9DExHAvaspwDkyuX+VZLHU7ekqZ1Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVYnUnzjxlrrXkCOcL9lKZ70fl/SEGrTqeBZBNhLYKGx+3CQDUuY9T/3w2gYvYXS8
	 FN4TjumJSYZeztDcnmfe8Z0neNLQm1oDvO03F1hih8qDBJ5fg3qe6izmbT5GKBje+k
	 W5p9hgJtoxK7Q2lTlM+kdDkH1zNCMPRsQrex4zMuy/wfsvvocRUhQiatf1RzgKjKKj
	 pjQpw1iZw5V2CZLxusiv17Ef5NqF4a6vuHGFPHsTtklxSFZ4TX40uSSZFk587WBFgp
	 Do2QZXmSUCk3Xz+zMdjAT2Zxgfqwe3e4ykca5C1oXaQQPa05oQaNvyo+3O5Y1QJOzC
	 k3qscoY2tzEiQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 02/14] mm/damon/core: do not use region out of a loop in damon_set_regions()
Date: Wed, 20 May 2026 23:05:22 -0700
Message-ID: <20260521060523.80684-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521041949.9E5AF1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 04:19:49 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in ALIGN() can result in region with ar.end = 0
> --
> 
> commit d65dcd33c6063ed27bd90da3803c482628ebbc88
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do not use region out of a loop in damon_set_regions()
> 
> This commit cleans up damon_set_regions() to explicitly track if a region
> should be inserted before another, avoiding reliance on undocumented
> iterator behavior. No behavioral changes are intended.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index d0bdf6e01dff8..669fd13776ea2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -394,7 +397,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  					ALIGN(range->end, min_region_sz));
> 
> [Severity: High]
> This is a pre-existing issue,

So, no blocker of this series.

> but can this ALIGN() macro overflow if
> userspace provides ULONG_MAX as the region end via the sysfs interface?

It is technically possible.  But what sane user would use such input?

> 
> If range->end is ULONG_MAX and min_region_sz is 4096, the ALIGN() macro
> would evaluate to 0, resulting in a region where ar.end is 0.

And it will trigger WARN_ONCE() on multiple verification points in
CONFIG_DAMON_DEBUG_SANITY enabled kernels.

> 
> When damon_sz_region() subsequently calculates the size using
> r->ar.end - r->ar.start, the unsigned arithmetic would underflow to a
> massive size.
> 
> This could cause the while (damon_sz_region(r) > max_region_sz) loop in
> damon_apply_min_nr_regions() to iterate nearly endlessly, allocating new
> regions until memory is exhausted.

If there is a region having end address equal to or smaller than the start
address, I think not only damon_apply_min_nr_regions() but multiple logics in
DAMON will behave crazily.  But, as I mentioned at the beginning, it is unclear
if it is a sane user input that deserve to be supported.  Of course I might
missing something, but I will revisit this if the first question is answered by
someone.


Thanks,
SJ

[...]
