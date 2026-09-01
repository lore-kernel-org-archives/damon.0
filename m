Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B736212D
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223028; cv=none; b=ERjcGs4IlopixkA27iMFT8uOqEXJ7Arjp0E0pCAw3l66/sKDpg0A1hVpO4GuS43+GGHW4EdIZWmgEyOc3nGkVPah0kgtDfK0eT3Tu876PXnxZGzV9WuK6s0wWyr2U10+PmwBTKov22f/AnQSvnkW3aE74uMzt0NMXs2MA3ff5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223028; c=relaxed/simple;
	bh=N3n36qvQJHar4XuFtLOBNv9noQ9LLLFwOM1yNcYPoLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1kQhhZvizq03kbI6D823dWWtEwSjTX7UnvRyTP63elu8E6PBwz19cGgw9q4ZfYN1w2MHgpCqDItdGT/PJ1keleuRYYGnM7Gf+oQlv/4YkKPgBVY3VmZzspiBDOZpjd12ZTntwLJgT6bVYcimmhd++T5k3+FLyOOgjn/cE7puoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZHxz2fk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZHxz2fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E931F000E9;
	Tue,  1 Sep 2026 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223024;
	bh=RwTbzm3moHBQigZWqwJmwTQu7rTM5rBbLVNz/7yZYZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZHxz2fkuOHujkOiHNF7QFr/Avy2FOba6q+YMV1ozW+ee12S7dikNzPFJtY+e6p/5
	 p4c4NsB7k9hekIuBFTjYkV4ZbL1z+Kvu/4TBg5Za21+bhn+v+oZFDOk6RUwltYJMBs
	 hOmoVJNXv1COItS1E4s2mIufGSp2TF8k26Ee6sM6p9U/xvofHeesxiHHv9VBSKglnN
	 GIR1hI6Z7GvdxxLoK+VbxHr/PppkoFPxQsvNjuogBIGDrNiApIZ0pZvo3+HuhMvOjZ
	 fyhDbRN4hquQxfJT+GoyHLFVvyBekM6JbQU2aRbgBMGjShlpzrW42MEftRUQlxScmZ
	 AAqky6s31cPAg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 7/8] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Mon, 31 Aug 2026 17:36:50 -0700
Message-ID: <20260901003652.88823-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831184153.330251F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 18:41:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect fallback values in `damos_get_node_mem_bp` when `i.freeram` exceeds `i.totalram`.
> --
> 
> commit a048cc23be81d8e450e9ee2ce22eb0a86b0cb1ba
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
> 
> This commit handles extreme corner cases where total memory is zero or
> reported used memory exceeds total memory. It updates
> damos_get_node_memcg_used_bp() to prevent division by zero or underflows by
> clamping the results to 100% or 0% appropriately.
> 
> Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 75d71ac09515e..3779a04753061 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2863,6 +2863,12 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	mem_cgroup_put(memcg);
> >  
> >  	si_meminfo_node(&i, goal->nid);
> > +	if (!i.totalram || i.totalram < used_pages) {
> > +		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> > +			return 10000;
> > +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +			return 0;
> > +	}
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a similar block of code just
> above this in damos_get_node_mem_bp() that appears to handle the fallback
> logic incorrectly:
> 
> mm/damon/core.c:damos_get_node_mem_bp() {
>     ...
>     si_meminfo_node(&i, goal->nid);
>     if (!i.totalram || i.totalram < i.freeram) {
>         if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
>             return 10000;
>         else    /* DAMOS_QUOTA_NODE_MEM_FREE_BP */
>             return 0;
>     }
>     ...
> }
> 
> When i.freeram exceeds i.totalram (which can happen due to per-CPU stat drift
> during large frees or memory hot-remove), this logic returns 10000 (100%) for
> DAMOS_QUOTA_NODE_MEM_USED_BP and 0 for DAMOS_QUOTA_NODE_MEM_FREE_BP.
> 
> Since the node is effectively completely free, shouldn't it return 0 for used
> and 10000 for free?

There could be different perspective, but I think that's fine.

> 
> Could this cause DAMON memory reclaim schemes to trigger aggressively on
> nodes that are actually completely free, potentially causing performance
> regressions?

Anyway it is a corner case.  And even in this case, quota will be changed only
up to 2x.  So no real problem in my opinion.  We can revisit if we find a real
issue from this in real usage.

> 
> >  	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> >  		numerator = used_pages;
> >  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831140254.72004-1-sj@kernel.org?part=7


Thanks,
SJ
