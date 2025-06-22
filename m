Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546A1422AB
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608296; cv=none; b=pdA4v4IdefslwZny4ZRJ3TH3d0Y2MJNZ4/5J+DBgrv4NFfsluENnGfwuMx+TMKnQpgKYpZ4v3UlO0UUhnKWcu6eGaDJdK69BTFuOl8gQjW3nichVLjTaonYb0G/OiacW29RC9dp8JoxIw9TnoCWXR5fgl98LA9xtkdjoQEC+qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608296; c=relaxed/simple;
	bh=GwerDBqWOjiSScKzaXyqY2GyXlariUNJbjLoOZJdSiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRGXtoWjPg6LmaV7x73arsZZ6mOK+78CpwSvOROYCl1bIWiYiUk5lnkN5wVuTV0lPbY4VkAl41d7s0wc/OmQAkjrsA65DmE7tbZo2IhUN2VFHLdgF/dsCE8O1LDVaUNHck4KhMDfqTOY0mrFwMQCx0MvwJ9eEB3zR48t2Gl5bDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFsz/XzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFsz/XzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075A8C4CEE3;
	Sun, 22 Jun 2025 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750608296;
	bh=GwerDBqWOjiSScKzaXyqY2GyXlariUNJbjLoOZJdSiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFsz/XzAtqVvI344+B8Hl5ee7p4MwnG2OvMjZusp1xiq2U4nKH7HUerXjJIJ49nTH
	 UBD44jOyppgmpYaAZJSDXUs36NVRlS1rFddNBJ3r6cJE8gQ50D4xG6gz0ShaTJOfs2
	 +TFuFuZuLK/6/C7J3nvmaX/Ki5/gqzrCBwOcb20IUooMhYMHjlKwQia+f3CvdcScaV
	 6x7aIvGeZn0Es2k91Kv+YmiiXZN8BKC3RLs0/ad3PlEH9F/nwsNu6bcgw18WSHkk9b
	 y7u1Y3XUcM/wop9TDgqrwr0RBJYbtN8iInVdwRoFLBjQQRc1TdsFiOkhKp0wRPmlXS
	 ZiDqAzTs1BJmA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 1/3] mm/damon: do not allow creating zero size region
Date: Sun, 22 Jun 2025 09:04:53 -0700
Message-Id: <20250622160453.47161-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622120926.1712-2-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Jun 2025 21:09:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Creating zero size region leads a divide by zero error inside
> damon_get_intervals_score() as follows.
> 
>   static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>   {
>       struct damon_target *t;
>       struct damon_region *r;
>       unsigned long sz_region, max_access_events = 0, access_events = 0;
>       unsigned long target_access_events;
>       unsigned long goal_bp = c->attrs.intervals_goal.access_bp;
> 
>       damon_for_each_target(t, c) {
>           damon_for_each_region(r, t) {
>               sz_region = damon_sz_region(r);
>               max_access_events += sz_region * c->attrs.aggr_samples;
>               access_events += sz_region * r->nr_accesses;
>           }
>       }
>       target_access_events = max_access_events * goal_bp / 10000;
>       return access_events * 10000 / target_access_events;  /* divide by zero! */
>   }

Thank you for finding this issue!  Coudl you please further share how zero size
region can be made, and if user-space can make the situation?

> 
> This patch makes a NULL return for such cases when creating a region
> inside damon_new_region().

I agree zero size region could look silly.  But I don't really think it should
be prohibited.  What about modifying damon_get_intervals_score() instead?
Maybe we can set target_access_events as 1 in this case.

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> ---
>  mm/damon/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b217e0120e09..44740da337fd 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -126,8 +126,11 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>  	if (!region)
>  		return NULL;
>  
> +	if (start == end)
> +		return NULL;
>  	region->ar.start = start;
>  	region->ar.end = end;
> +

Above new line is unnecessary in my opinion.

>  	region->nr_accesses = 0;
>  	region->nr_accesses_bp = 0;
>  	INIT_LIST_HEAD(&region->list);
> -- 
> 2.34.1


Thanks,
SJ
