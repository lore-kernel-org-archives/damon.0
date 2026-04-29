Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFC240611
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442774; cv=none; b=jbXubhO1vnzGP2sp/A7AJfng2QLmvwNWojMaByyrz+oebblI9bjHhLTVnNU5nR2Pu79CEmPp0wjdFZiIbt44CV6bixxHOAPTbYAUUZHIEl4oIrM8tv/KovI5jqtbAg74CF7SSL98CofSRw4BLOSCJQJiAebp1PYNqCZc7/YJ76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442774; c=relaxed/simple;
	bh=SGN8VMFqZsTQaBftQ8gPXNHVnMp2aNTdp7MHtvfZ2aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgWGUTK8Yvbbz03ZJVTccNE++5S9OGGLiBkGs6+MaOURes22A1pOhgZs552kI4hUet/6TxmT7xOeytQQ9PjGeCvhPte9jnmVIWUnFKDnBBm0xd5BRZvO1wiEYsLitRe7sbzMf/B7VDaS9waW5OURVZ+uaWYI3HoMMUGp5uTnXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV5G4Nn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV5G4Nn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BF2C19425;
	Wed, 29 Apr 2026 06:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777442774;
	bh=SGN8VMFqZsTQaBftQ8gPXNHVnMp2aNTdp7MHtvfZ2aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VV5G4Nn7VsIJBIVeGCI5jeJmzPDI8ep2vNJIASTVF3taxssaFvBQohH8o/NyQpZVL
	 YbTYB21TIy/9HuB0kWXjsFgYDn/BPWHpFOswyuXsNg/+57vbhLEAqHeE539fowE215
	 ohRJAOy4VUNO1ofgBkhQLGR9pJ+32zcVthQPvBiVTKq0XfKXfaBZ7dYjhzjJil+Nd5
	 BuTrGm5tFzWGRDd/NnEMkVY7Iumohdk8RcR2ASiWlxhSGmU03DOewSDbvgdzIhAwXE
	 dwrU/tOsSN4+nMrMLwJGbFNxgOG3LeZAK89GaeLV0waFyO+JCpJP3vtGvrIF8bL5pC
	 xW0mQ2FUc4szw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 3/7] mm/damon/lru_sort: cover all system rams
Date: Tue, 28 Apr 2026 23:06:10 -0700
Message-ID: <20260429060610.91915-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429060314.49EE6C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 06:03:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Single bounding box for sparse memory layouts causes soft lockups and algorithmic failure

Not a real issue in my opinion.  Please read below for more details.

> --
> 
> commit 692650636f4214ec9c2fa1c5d7fd43fe3bf049fe
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/lru_sort: cover all system rams
> 
> This commit changes the default monitoring region from the biggest System RAM
> resource to a single region that spans all system RAMs. This is intended to
> cover the entire physical memory instead of just the largest block.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 7569e471160a..2eb559d913b6 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> > @@ -326,7 +328,7 @@ static int damon_lru_sort_apply_parameters(void)
> >  	if (err)
> >  		goto out;
> >  
> > -	err = damon_set_region_biggest_system_ram_default(param_target,
> > +	err = damon_set_region_system_rams_default(param_target,
> >  					&monitor_region_start,
> >  					&monitor_region_end,
> >  					param_ctx->addr_unit,
> 
> Could this lead to a regression on systems with sparse memory layouts?
> 
> When creating a single bounding box from the first to the last physical
> address, systems with sparse memory like CXL or distant NUMA nodes could end
> up with a region containing terabytes of unpopulated physical address space.
> 
> Will this cause soft lockups during DAMOS operations?
> 
> If a scheme like PAGEOUT iterates linearly over this massive region in
> PAGE_SIZE increments, iterating over these large memory holes might stall the
> CPU and trigger the watchdog, since cond_resched() is typically placed after
> the loop.
> 
> Does this also cause an algorithmic regression with the sampling probability?
> 
> DAMON's adaptive logic merges adjacent regions with identical access
> frequencies. Since memory holes report 0 accesses, they might be aggressively
> merged with interspersed RAM into maximum-sized regions. Because sampling
> selects a single random address per region, the probability of actually
> sampling the populated RAM might drop to near zero.

Exactly same question to the one for the second patch of this series.  My
answer to it is also samely applied here.  Not a real issue.


Thanks,
SJ

[...]
