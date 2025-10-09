Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6B78F59;
	Thu,  9 Oct 2025 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759970254; cv=none; b=SMWF7Gg6vn12ACQ4KmK3tPvNePZuyqBSvjOMRCcowlDcSoytFcatLT0v3QoP8RRdwl9sUHdY5ZuZR04in3VVh8DNsqyk29oB+ckzAJsotKic8+7YKFjNHEFgc2wppdwxGXKWg5uIVq0oNB7P/7GPlcq7hWhxTkOPyAKr006IJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759970254; c=relaxed/simple;
	bh=nFcAr73rD+SuRsT7M4DFUoPCwzGKkb7ROVMuAUGKA6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKwUKSn+zqtdiQGzK93n4y739lTxH4Bm4J2Jtk4jJg8udtWXan22F2luWNhosztrUmSMwUTfQKVjuomx3LOQZWJzs2WJ1RLEliVR4uUJOFQMEDX4NnbbXiebNiQu05Qi4jI0jIIyz53TM/ERV6vZ1Lm4rxXH7f6ylwwLeJc5sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU8Vc//i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU8Vc//i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9590C4CEE7;
	Thu,  9 Oct 2025 00:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759970253;
	bh=nFcAr73rD+SuRsT7M4DFUoPCwzGKkb7ROVMuAUGKA6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lU8Vc//iypA7RNySYz3PTvHx5w9B82WDq/loSga5PhvX66TLaTlDAvmlWqnlHhqE9
	 pD/curjEAsHaBxGAwKNQXoUlLvXEoTPP5iUBvrcO/pxTz1Kq10Jo19FiT/XNcPeCld
	 YKH77j5UkWkKz0oyrnq7LzPskzT8+l+D4w7E+ElzYIZy/C/+0/MM84sw0h7yljKItu
	 b5dkLLjko6d7/aLTXbTRDRdUDr90YVN5hCjL8O4gJCCAyqRiFH82f2+NuXjOx8Fmfu
	 Cl2GgcXGqkEIwEF+MXGMtW5K7NQGpiFfWLCfts6PjXrB6uRMN0CCJiAtJkOgvJ5/nR
	 +6qrO3pQgpCvA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/11] mm/damon: add a new DAMOS quota goal metric for cgroup on node memory usage
Date: Wed,  8 Oct 2025 17:37:29 -0700
Message-Id: <20251009003729.14889-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 15:00:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> Define a new DAMOS quota auto-tuning target metrics for per-cgroup
> per-node memory usage.  Also extend damos_quota_goal struct to have a
> field for specifying the cgroup of the interest.
> 
> Note that this commit is only for DAMON kernel API extension.  Real
> behavior of the new metric will be implemented by a following commit.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 39b835dd3c4d..43aef959d357 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -175,6 +175,7 @@ enum damos_action {
>   * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
>   * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
>   * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
> + * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
>   * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to inactive memory ratio.
>   * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
>   *
> @@ -185,6 +186,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_SOME_MEM_PSI_US,
>  	DAMOS_QUOTA_NODE_MEM_USED_BP,
>  	DAMOS_QUOTA_NODE_MEM_FREE_BP,
> +	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };
> @@ -196,6 +198,7 @@ enum damos_quota_goal_metric {
>   * @current_value:	Current value of @metric.
>   * @last_psi_total:	Last measured total PSI
>   * @nid:		Node id.
> + * @memcg:		Memcg id.

The name of the field is not memcg but memcg_id.  I will fix this in the next
version.

>   * @list:		List head for siblings.
>   *
>   * Data structure for getting the current score of the quota tuning goal.  The
> @@ -209,6 +212,9 @@ enum damos_quota_goal_metric {
>   *
>   * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
>   * id of the target node to account the used/free memory.
> + *
> + * If @metric is DAMOS_QUOTA_NODE_MEMCG_USED_BP, @nid and @memcg_id represents
> + * the node id and the cgroup to account the used memory for.
>   */
>  struct damos_quota_goal {
>  	enum damos_quota_goal_metric metric;
> @@ -217,7 +223,10 @@ struct damos_quota_goal {
>  	/* metric-dependent fields */
>  	union {
>  		u64 last_psi_total;
> -		int nid;
> +		struct {
> +			int nid;
> +			unsigned short memcg_id;
> +		};
>  	};
>  	struct list_head list;
>  };
> -- 
> 2.39.5
> 


Thanks,
SJ
