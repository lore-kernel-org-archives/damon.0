Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352633436A;
	Fri, 17 Oct 2025 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725397; cv=none; b=iiY99TvNtpqe6wzqYB/WukskJpk1nzF6ntnGXbogWtl6J2mZbkp2qDTaGAp0FMuHCuVqsCoAXEJJyU68nwfkzw/0Q4YQKMONW/kJh70rs3loXYrY1tfLgx4neWWKaXKivF+llY7U9YxtF6554XEViOKMHrv1FX1/Xyi5ucaxTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725397; c=relaxed/simple;
	bh=S46XaZclhcxXbcJdWjNUfPnuzr9HjUARlDUOAUroKTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNaZyqweRDGr9fyhweg6o14NgcOcAsAG3JiW4bIn7hQflYuK9UKqiICHsRRDDGhABic/+gEwwIzHbHP6mKhy05QnKcr1NSkCTIZNZmTYW5Zh8wfWbXStGEOJHSbm2ulnglyhpocJb81RXP6wji8PI0bW/W/vge+pYOUrsqUbHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiTtH/NM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiTtH/NM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FBDC4CEE7;
	Fri, 17 Oct 2025 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760725396;
	bh=S46XaZclhcxXbcJdWjNUfPnuzr9HjUARlDUOAUroKTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NiTtH/NMd7b5WSERP3F1DvIifA1SxqgGtCVD+HzfAC9rq4Rm5cC39HEnAXS+Ww8eu
	 HwLZXyqELYPbcHPeo069rgenaWcq7nb/gIX3Jm3WlykVSBoP9Kp59sj/8ujAgK5RjK
	 +zXfqO227jnawL/KiWdFb5iKmuoTUh8hmkKgpcXV78AjV2LJhHL6dHRkKOimKOA5/s
	 bFfHkzIo9M+3laZugBJL4y4Zs0c/1hwLN4xZatUaG+uRlch8GIQilb2tiu3FgEGB9s
	 M3IP9eti2nxCT1+Cg2VT17/9Ylsspp7LUJRRUPturDrOl7MKVWhWGBF+Kk3PjEPsH5
	 6OwDNW9Oq7RNg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 06/10] mm/damon/core: add DAMOS quota gaol metric for per-memcg per-numa free memory
Date: Fri, 17 Oct 2025 11:23:08 -0700
Message-ID: <20251017182309.124449-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009212042.60084-7-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  9 Oct 2025 14:20:38 -0700 SeongJae Park <sj@kernel.org> wrote:

> Add a variant of DAMOS_QUOTA_NODE_MEMCG_USED_BP, for the free memory
> portion.  The value of the metric is implemented as the entire memory of
> the given NUMA node subtracted by the given cgroup's usage.  So from a
> perspective, "unused" could be a better term than "free".  But arguably
> it is not very clear what is better, so use the term "free".
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 6 ++++--
>  mm/damon/core.c       | 9 +++++++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
[...]
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2039,7 +2039,7 @@ static unsigned long damos_get_node_memcg_used_bp(
>  {
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
> -	unsigned long used_pages;
> +	unsigned long used_pages, numerator;
>  	struct sysinfo i;
>  
>  	rcu_read_lock();
> @@ -2059,7 +2059,11 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
>  
>  	si_meminfo_node(&i, goal->nid);
> -	return used_pages * 10000 / i.totalram;
> +	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +		numerator = used_pages;
> +	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +		numerator = i.totalram - used_pages;
> +	return numerator * 10000 / i.totalram;
>  }
>  #else
>  static __kernel_ulong_t damos_get_node_mem_bp(
> @@ -2094,6 +2098,7 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
>  		goal->current_value = damos_get_node_mem_bp(goal);
>  		break;
>  	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
> +	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
>  		goal->current_value = damos_get_node_memcg_used_bp(goal);
>  		break;
>  	default:
> -- 
> 2.39.5

Like the DAMOS_QUOTA_NODE_MEMCG_USED_BP case, this patch should also update
damos_commit_quota_goal_union(), like below.  I will add that on the next spin.

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -826,6 +826,7 @@ static void damos_commit_quota_goal_union(
                dst->nid = src->nid;
                break;
        case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+       case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
                dst->nid = src->nid;
                dst->memcg_id = src->memcg_id;
                break;


Thanks,
SJ
