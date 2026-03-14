Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8011CAF;
	Sat, 14 Mar 2026 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447543; cv=none; b=uCQn/QAMtY+72Vx25T/gUEHLPmsMlitewElOxFw2fwn9w8PjQW5pVINZ+hE4xOoU7OwgcYSRozJ3I15XdJMczJPA4dZEdTKLojyyCniVv3pPTbMwZIpHl7OQdYjq2B+wfNQARdl969GP7n1C9Ye++2yfbupXpP2MQDsrt9CAqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447543; c=relaxed/simple;
	bh=cNMOKPeKD570b1ZANTu6NCTIdwORzNvjJjCPyu9Q8JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6+GuVVsjkN0XOWNI+6fxDx8gaaluuLJdKkymeHRTWoKiXvw2d3X8v/5AUtFhJdb9p1N/m8te/rDGK9GRxbQjxocMb9NA4KV48LOjRf9Imna56o+ZB6wi+ME+7VwZNt0pTg9/vdmX8JPuPJ73f7AN1O5JcOjTWvalrnpKGYk+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAcuTyRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAcuTyRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA5C19421;
	Sat, 14 Mar 2026 00:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773447542;
	bh=cNMOKPeKD570b1ZANTu6NCTIdwORzNvjJjCPyu9Q8JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAcuTyRVPp3Q8d5Up+QhF843kVaGD93G7nBWuA9uhRbCrl/gMusIGrHZzzHijl44J
	 kLS3e68D9atZ+yE0g1uECwG1KNGojQPvU3hDfuKSiEr/G+2NRTn4Y8nDTYxste9tci
	 p7mKGqWP4HliHO6B44oFkcF4/1Unr5zHKGYfFoP0YrCcDoFFbURs1ARq4kDvsMF1eC
	 NLq5L5rt1R6Ivbt4NSuqdYEPrHge7NWvoL6RyfH7xafpenarWpmejyZuOTa4fg7NZl
	 aYmuDolG/hodQzD1NTan+Va/zTt2/eor1dy/ajehVulIK9+u0oC2IFKQ6v/LYuka5H
	 XO2Fl21RiT7TA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/damon/core: receive addr_unit on damon_set_region_biggest_system_ram_default()
Date: Fri, 13 Mar 2026 17:18:54 -0700
Message-ID: <20260314001854.79623-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311052927.93921-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Mar 2026 22:29:24 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_find_biggest_system_ram() was not supporting addr_unit in the
> past.  Hence, its caller, damon_set_region_biggest_system_ram_default(),
> was also not supporting addr_unit.  The previous commit has updated the
> inner function to support addr_unit.  There is no more reason to not
> support addr_unit on damon_set_region_biggest_system_ram_default().
> Rather, it makes unnecessary inconsistency on support of addr_unit.
> Update it to receive addr_unit and handle it inside.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/core.c       | 7 ++++---
>  mm/damon/lru_sort.c   | 1 +
>  mm/damon/reclaim.c    | 1 +
>  mm/damon/stat.c       | 2 +-
>  5 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 1130c2f9a92f4..3a441fbca170d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -988,6 +988,7 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
>  
>  int damon_set_region_biggest_system_ram_default(struct damon_target *t,
>  				unsigned long *start, unsigned long *end,
> +				unsigned long addr_unit,
>  				unsigned long min_region_sz);
>  
>  #endif	/* CONFIG_DAMON */
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index aee61bf991baa..d4f86c20b4f48 100644
[...]
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> @@ -3123,12 +3124,12 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
>  		return -EINVAL;
>  
>  	if (!*start && !*end &&
> -		!damon_find_biggest_system_ram(start, end, 1))
> +			!damon_find_biggest_system_ram(start, end, addr_unit))
>  		return -EINVAL;
>  
>  	addr_range.start = *start;
>  	addr_range.end = *end;
> -	return damon_set_regions(t, &addr_range, 1, min_region_sz);
> +	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);

The above line is unnecessarily and wrongly changing the third argument.  It is
the number of ranges that passed by the second argument, never meant to be the
addr_unit.

A similar bug [1] was found by an AI review, and I found this patch also has a
similar bug.

Andrew, could you please add below attaching fixup?

[1] https://lore.kernel.org/20260313234026.48872-1-sj@kernel.org


Thanks,
SJ

[...]
=== >8 ===
From 0d00bb5ca76502aef4a6a97b0855e33435147269 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 13 Mar 2026 16:49:08 -0700
Subject: [PATCH] mm/damon/core: fix wrong damon_set_regions() argument

The third argument is the length of the second parameter.  But addr_unit
is wrongly being passed.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d4f86c20b4f48..f9854aedc42d1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3129,7 +3129,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);
+	return damon_set_regions(t, &addr_range, 1, min_region_sz);
 }
 
 /*
-- 
2.47.3

