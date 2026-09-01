Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDD3AEF4E
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272989; cv=none; b=IBYJ7ncpyiyUKY3sLYt98z5NSYufkVxa7UaQc6vlfMDSkl8S5nEQZ4cdwnW+EgAq3Ge+ZdnrrLX8pKwjwPl3V6N9j0okgkmhDlswtwH5PCTKGACFerdG4Uo1KiEJ86PK8IkanT/c52xUX8zF7TjIyrxCWbQMOEqYetObiTWeFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272989; c=relaxed/simple;
	bh=GXbwG0gLIRDubyNBp4D4V580q1ALcz6tEZ4QKFBFuF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N09yS15KpacckfChazQQPpHZBKlIAR7r/DK1uzzDMYyM1xM+YLLss+y2LFg8igXb8QGLoBe1ZeGSYq44LIMDmcIVR/VtjnatLGgPDvCF/COcNr5Yz7NX8gVHlYYqs6dVCa7kF0IuvUMWdEMxiWuvyFrQbkEEVEXojrfTra8S2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtDXqjzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtDXqjzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5081F00A3E;
	Tue,  1 Sep 2026 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272987;
	bh=ssLephBzWB0NlAuEIlaYVIub1X41zCtupevTd0CHArU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VtDXqjzIBkUukot4PAF7o26BPxwboWuETx3oXQC+AyjEvWVk9tZwsUAxrHsHkGPE4
	 bCuQgo221VUHsUzbAk9y26U14C0jWmJKILizcyhG2X6KOSRaog47BLkE/+QNnAkFL0
	 8ugFl6wricxByp8pckXJhZS4ddejfEHBu0qX0EJ9Zh30IX9evwvL00qD18pHhM0Gxk
	 0ypsde9vNtKv0uK4g0QO0bfQYikTQGYo/iuAKtnf//KfpScd57UgZFzPtxgyU6RjcU
	 vJonNSqtXzX2XROWP5xcPJET4YWyGeby1vjOjgQn1okpIB5MDtrV8eNK5PEYDX4QUR
	 KEmELtcYi8PrQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 7/8] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Tue,  1 Sep 2026 07:29:39 -0700
Message-ID: <20260901142940.100915-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901134108.9356D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 13:41:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in basis point calculation on 32-bit systems for large memory sizes.
> - [High] Incorrect saturation logic for negative global memory utilization triggers false maximum reclaim.
> --
> 
> commit 23b94672ac5d1c09d669ade5732261e82d129c96
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
> 
> This commit handles corner cases where total memory is zero or
> lruvec_page_state returns more used memory than total memory. It returns
> 100% or 0% for used and free memory queries respectively in these scenarios.
> 
> Link: https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ad3657d356fbc..3060edf5e4fa6 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2854,6 +2854,12 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	mem_cgroup_put(memcg);
> >  
> >  	si_meminfo_node(&i, goal->nid);
> > +	if (!i.totalram || i.totalram < used_pages) {
> > +		if (goal->metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> > +			return 10000;
> > +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +			return 0;
> > +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at similar logic in
> damos_get_node_mem_bp():
> 
>     if (!i.totalram || i.totalram < i.freeram) {
>         if (goal->metric = DAMOS_QUOTA_NODE_MEM_USED_BP)
>             return 10000;
>         else    /* DAMOS_QUOTA_NODE_MEM_FREE_BP */
>             return 0;
>     }
> 
> Can this regression trigger unwarranted memory reclaim pressure? If transient
> per-CPU stats drift causes i.freeram to slightly exceed i.totalram, this
> condition evaluates to true.
> 
> If free memory exceeds total memory, it implies used memory is less than 0.
> Should the correct saturation be 0% used and 100% free instead? Returning
> 10000 (100%) for used memory tells DAMON that the empty node is completely
> full, which might cause aggressive reclaim behavior on mostly empty nodes.

No issue.  It is a different perspective.  And DAMOS auto-tuning logic limits
increasing quota arbitrarily.  Increasing quota is capped to only 2x of the
current effective quota.

> 
> >  	if (goal->metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> >  		numerator = used_pages;
> >  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but does this basis point calculation overflow
> on 32-bit systems for large memory sizes?
> 
> A little further down in damos_get_node_memcg_used_bp() (and similarly in
> damos_get_node_mem_bp()):
> 
>     return mult_frac(numerator, 10000, i.totalram);
> 
> The mult_frac macro evaluates its internal remainder multiplication using
> the type of the numerator. On 32-bit systems, the numerator is a 32-bit
> unsigned long.
> 
> If the numerator is greater than 429,496 (which corresponds to 1.75 GB of
> RAM with 4K pages), the multiplication by 10000 wraps around ULONG_MAX. For
> instance, 429,497 * 10000 modulo 2^32 evaluates to 2704, which then divided
> by total RAM evaluates to near 0%.
> 
> Could this regression lead to incorrect memory quota enforcement for memcgs
> or nodes exceeding this threshold?

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901131850.98037-1-sj@kernel.org?part=7
> 


Thanks,
SJ
