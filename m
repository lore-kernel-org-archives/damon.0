Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC83DD537;
	Wed, 25 Mar 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451059; cv=none; b=kYSjWshJWZG+lRlLtKkN7TshRJOTkoRYDKRc1pENeyYXR6dLbt4EkLIA3lpkrBvlyr0XW+e7G9pEiQvU6Bya3mBEHgh72Dm3Voj34GgBKeFDZuYLk0Jq/Ac4vrORQtxpN0PDe9MtAXgOOeotvryAWmVMjjyotkUG7DcMJIly+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451059; c=relaxed/simple;
	bh=UD3pMRTQnc7mmQ6/kqhD1kZgF1YPF0ihrkNbU0vkgqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyZ3HlxiJtXcK9hHCiT7WwnzprWUn95C/VZeodZeXP08jCLDTsXFhs2mAOdaP4fI+AjqGuA/HzhZ7u7/Az7DxlICR4WNDNqXOgCjhEET5GPDHwq4rvPM8IIeC/ItFpGdbXoJW+gJfIEvTqkLi3xTWx+ub/yDdblTbUHZeFuNvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCOnoye0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCOnoye0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD1DC4CEF7;
	Wed, 25 Mar 2026 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774451058;
	bh=UD3pMRTQnc7mmQ6/kqhD1kZgF1YPF0ihrkNbU0vkgqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCOnoye0iRgKQ2/Hkv1xCXmCs2iJwfAE1Iz4Pqv08JDL6zWTRDdATiNeJxSkbuLkm
	 W6VhgwYWT7ONxhf84Ljf0iLwP7DW1oQlpPb/jApYhZnkWrc5Fzbi/HNFm+nG6l94QS
	 whi9KTK2GaDC+9dWJbW8oAkDX0oKwUylyZ+4kAkhxhMbToBfPqBKqY2pfjzLTT9+lX
	 qLJnwF9xzMLjTvtYQQa6/bly0eDxYL4BN/oayNeNYxAUfjBwI/t3mnbEJ447sJAmig
	 2oTUoFUJtYXtcEEipxpCK8my4F2x5LBZpqF+aWz57JsAPhc2tP6+K77IJL+ceD2das
	 GqeDo9nQG9e5g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Josh Law <objecting@objecting.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 08:04:10 -0700
Message-ID: <20260325150411.88357-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325143740.87690-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 07:37:39 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260325073034.140353-1-objecting@objecting.org
> # start of sashiko.dev inline review
> commit 7e17cbe1dc95a0cd1a1410be38ab6964f78fb15c
> Author: Josh Law <objecting@objecting.org>
> 
> mm/damon/core: validate goal nid before accessing node data
> 
> This commit adds bounds checking and node_online() validation for the
> goal->nid in the DAMON quota metrics. It prevents out-of-bounds accesses
> to NODE_DATA() when an invalid or offline NUMA node is provided by userspace.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..81ce27baa1a1 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2245,6 +2245,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
> >  	struct sysinfo i;
> >  	__kernel_ulong_t numerator;
> >  
> > +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> > +	    !node_online(goal->nid))
> > +		return 0;
> > +
> >  	si_meminfo_node(&i, goal->nid);
> >  	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
> >  		numerator = i.totalram - i.freeram;
> >  	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> >  		numerator = i.freeram;
> >  	return mult_frac(numerator, 10000, i.totalram);
> 
> Could this cause a division by zero if the node is online but memoryless?
> 
> For CPU-only compute nodes or nodes where all memory has been hot-removed,
> node_online(goal->nid) will evaluate to true. When si_meminfo_node() is
> called for these memoryless nodes, it populates the sysinfo struct with
> i.totalram = 0.
> 
> The mult_frac() macro unconditionally performs integer division and modulo
> by the third argument, which could trigger a kernel panic when dividing by
> zero.
> 
> Would it be safer to check if i.totalram is zero before returning, or use
> node_state(goal->nid, N_MEMORY) instead of node_online()?
> 
> [ ... ]
> 
> > @@ -2261,6 +2265,10 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	unsigned long used_pages, numerator;
> >  	struct sysinfo i;
> >  
> > +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> > +	    !node_online(goal->nid))
> > +		return 0;
> > +
> >  	memcg = mem_cgroup_get_from_id(goal->memcg_id);
> 
> The same division by zero risk exists here when mult_frac() is called at the
> end of this function.

I think sashiko's comments make sense.  I also suggested using
node_state(N_MEMORY).  What do you think, Josh?


Thanks,
SJ

[...]
