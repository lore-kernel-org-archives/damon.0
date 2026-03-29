Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B918262A6;
	Sun, 29 Mar 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799295; cv=none; b=FosOTRZXWYzsUwX6X4DKJn++1BIjD6VeIPAqnULn8ikO1Gn1ClE/h3nlsECXU/aV1ogAWQDI+n6rP0+Ie6gWIRI12H2MVxWfiXMrrPofDbMIQa+T0feS/OveHPUqFvvS20xZNZBpsoA94mIkhJvGbXLWNCuYejRi+jEiwc6PEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799295; c=relaxed/simple;
	bh=55VTZBw7H4SGXn+vmc4Bbc36KWSHYKT83EK8dDSS/qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrHs35X6gFj7OqHgNTQMiwVa1WbP87xduVZ4jOlHsXhrEdZYWIvjeMI0wYWWl4+7iFtTOWYTtj327Ma13F7heyIpY7GdBp86HuGr87VdcH2/oQu58ZdnFQLqesaGyYZJw7Bap0Mezg/IqJr25iHJqvVWk9IlZ4hQ4OJ6jDeJsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC2hb9ZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC2hb9ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1914AC116C6;
	Sun, 29 Mar 2026 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774799295;
	bh=55VTZBw7H4SGXn+vmc4Bbc36KWSHYKT83EK8dDSS/qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MC2hb9ZNhG0CXroRC0oawyiUw/ltfcRn1Bq9ZZFlErZLMIE9WDaJ3BrEAo0EdNsS3
	 8OjI5gEQy+v8UadyoS+gdANYvFuMWIkP+IBcEakK0ieDNXD+/wXkgUxA/IPg0ZiNJC
	 etx5oIGzqtEj3Cwp1hFEeOloG9sgYr97CuIc/i/FXJ3KHbmLQpNXvmmSrpMphy8up6
	 SUfAA8pSXub0AczqA/bj2cwABS8uv80/QhSIHFm2nxnvyNYJW0qQ4XWuvnJGaR2iBC
	 rAnv5nXh/096KLNfOIGUUey0CTEo6PMRxU6EbIpyCmlrzCo3IWR+8zN0MgfOmW0UIC
	 QvDLpxZ3MAX2A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
Date: Sun, 29 Mar 2026 08:48:13 -0700
Message-ID: <20260329154813.47382-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153425.47097-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko findings are good points but not directly related to this
patch.  I will separately work on sashiko's findings.

On Sun, 29 Mar 2026 08:34:24 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260329043902.46163-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit 1ede2d837f5cbf8e8d96fe4c6eab34aeaa071d56
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
> 
> This commit adds validation for the node id in damos_get_node_memcg_used_bp()
> to prevent out-of-bounds memory access. If an invalid node id is provided, it
> now safely returns 0% for used memory and 100% for free memory.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 26bdeb658799..c45c62f8449d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2273,6 +2273,13 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	unsigned long used_pages, numerator;
> >  	struct sysinfo i;
> >  
> > +	if (invalid_mem_node(goal->nid)) {
> > +		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> > +			return 0;
> > +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> > +			return 10000;
> > +	}
> > +
> >  	memcg = mem_cgroup_get_from_id(goal->memcg_id);
> >  	if (!memcg) {
> >  		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> 
> This isn't a bug introduced by this patch, but can the subtraction later in
> this function underflow?
> 
> damos_get_node_memcg_used_bp() {
>     ...
>     else    /* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
>         numerator = i.totalram - used_pages;
>     ...
> }
> 
> Since used_pages is fetched locklessly and i.totalram is the global managed
> pages count, could asynchronous rstat accounting lag or concurrent memory
> hot-remove operations cause used_pages to transiently exceed i.totalram?

As sashiko also mentions, this is not related to this patch.  I will separately
work on this.

> 
> Also regarding the end of this function, is it possible for i.totalram to
> evaluate to 0 here?
> 
> damos_get_node_memcg_used_bp() {
>     ...
>     return mult_frac(numerator, 10000, i.totalram);
> }
> 
> If a node's memory is entirely reserved or concurrently offlined,
> si_meminfo_node() might set i.totalram to 0. If that happens, does
> mult_frac() execute an unchecked division by zero internally?

Again, not related to this patch.  I will separately work on this.

> 
> Finally, does the mult_frac() macro overflow unsigned long on 32-bit
> architectures?
> 
> The macro evaluates to q * n_ + r * n_ / d_, where r is
> numerator % i.totalram. On 32-bit systems, r is a 32-bit unsigned long.
> 
> For nodes with more than ~1.7GB of RAM (where i.totalram exceeds ~429,496
> pages), could r * 10000 silently overflow the 32-bit boundary and return a
> severely truncated value?

Good catch, but again, not related to this patch.  I will separtely work on
this.


Thanks,
SJ

[...]
