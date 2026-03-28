Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264E2F4A18;
	Sat, 28 Mar 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705377; cv=none; b=ncPxxMK3wmy4wZE/8b7EMRrF+vZPq539uKUv+tGkbamcid+FGqwelGK+run970sYNMMvYTZ/nIraNXm3UI27pT+AS7uM/1+LfpDTB/ikfRiIk0b2od/y4DUjb/vRdR7hXi98IQGZ+IhJ7DaKGJjKFa3n+bLDPWtj53grY2mAp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705377; c=relaxed/simple;
	bh=Zo0xwBlS33TnuFJgADBysYFie+bkoCRf9H3CXGjWLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al8PR3NyzSf+2Vv8jxw0MKbeq8/5qiSmyeR9HXPB7FjXm9UzNiG+ZpG+WweljeQjYWN/nLnE00rgNXFMckaiQMT6AOhcpO5e4PNDzOswoyKD3StXKpnaYIw27oBrUEFo2rG4ksL6ORS6N9wZQ77y+7BrdKZfBv1m5ZvfxYmdQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu56AoyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu56AoyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B8FC4CEF7;
	Sat, 28 Mar 2026 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774705377;
	bh=Zo0xwBlS33TnuFJgADBysYFie+bkoCRf9H3CXGjWLKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu56AoyUrs0g1RWp65nRpAVjFwcSwH649dYJA4JKVdNyldJkRP7P9ZPOZXs1O9Yat
	 rNQ/TDkHGI1Ts9t3nW9tlhLlAFsnnzjFXsYMzXHiUfpbec+mn6PbCFjaRWwXvRZn+P
	 3XrIPDhDIbRkeGPoJgAimGrZ39in7mXCp07X/2hPr7MqT3r5kx5YC63ThL7mhoGAxp
	 /KF436VCamFOd8N8t1M7OXNZW/EAcAbJypBaxrvUqU0nUelUhPenDU8vwRwmCCRJcp
	 ggXEqXpq2BwQEJIS+DNK9bUkIBs8ZS26EjzHcgCIbeaAZ3R5kIRswiXEakZ1EM/QOb
	 7vmamGwjOjLmA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
Date: Sat, 28 Mar 2026 06:42:55 -0700
Message-ID: <20260328134255.9884-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328023020.8525-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 19:30:20 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260328005412.7606-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit d10719045bbbd92307cf40ef0886ce0e81cb9caa
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
> 
> This commit adds validation for the damos_quota_goal->nid when calculating
> node memory cgroup usage ratios. If an invalid node ID is provided, it
> returns 0% for used memory and 100% for free memory to prevent out-of-bounds
> memory access during NODE_DATA() lookups.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2273,6 +2273,13 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	unsigned long used_pages, numerator;
> >  	struct sysinfo i;
> >  
> > +	if (invalid_mem_node(goal->nid)) {
> > +		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> > +			return 0;
> > +		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> 
> This isn't a bug, but there is a typo in the comment here. It says
> DAMOS_QUOTA_NODE_MEM_FREE_BP instead of DAMOS_QUOTA_NODE_MEMCG_FREE_BP.

Good catch, I will fix this in the next spin.

> 
> > +			return 10000;
> > +	}
> > +
> 
> [ ... ]
> 
> >  	si_meminfo_node(&i, goal->nid);
> >  	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> >  		numerator = used_pages;
> >  	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> >  		numerator = i.totalram - used_pages;
> >  	return mult_frac(numerator, 10000, i.totalram);
> >  }
> 
> Does this code safely handle nodes with zero managed pages?
> 
> While the new invalid_mem_node() check ensures the node has N_MEMORY set, a
> node could still have zero managed pages if all its memory is reserved, or
> if a concurrent hot-remove event drops the pages to zero just before
> si_meminfo_node() runs. If i.totalram evaluates to 0, mult_frac() will
> cause a divide-by-zero kernel panic.
> 
> Can this calculation also silently overflow on 32-bit architectures?
> 
> Both used_pages and i.totalram are unsigned long. Since numerator <=
> i.totalram, mult_frac() bypasses the initial integer division and computes
> numerator * 10000 directly.

To my understanding, mult_frac() doesn't do such bypass.  Correct me if I'm
wrong.

> If the memory cgroup uses more than ~1.7GB
> (about 429,496 4KB pages), numerator * 10000 will exceed the maximum
> 32-bit unsigned long value, resulting in an incorrect ratio.

So this concern from sashiko is wrong.


Thanks,
SJ

[...]
