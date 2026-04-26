Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724926B764;
	Sun, 26 Apr 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777223991; cv=none; b=oh9hDHBcZxCEYDdsKDgdYU0xPZVN5e/gtU/1dMWq6JnOOEpCSQc0hqZvYK6IqPkv4t6jAynPRQFXuZWaasXGe7Xe/3cnb5a1chugVYH/yExpoPeD/71RNHSUDUpEojKzEy8Fy5tcUcYtq6d5Qt48wUQPsmIyGJ8O0JVVY7/IILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777223991; c=relaxed/simple;
	bh=lG1Berrhw8hjbikGqYFQyztxo7nbWehNH0Od6lNtYYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr+OUQEgexKtGfUZ+pn9dktvTChS//RmQuXbhrEEQKE9wE92Fd7EEiFQpqbjdq62q0QJUnC7T60RLh5q3RcUxcJf3GLoejr/GOA7f9KcplfrtML3ENcsoy0eihiewSAL1blHTH/wDT0RtiDYT5Att0GXfYDxiNah85WG08Qi/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFoY0CZr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFoY0CZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D22C2BCAF;
	Sun, 26 Apr 2026 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777223990;
	bh=lG1Berrhw8hjbikGqYFQyztxo7nbWehNH0Od6lNtYYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFoY0CZr8kKoqAnhi+7eySYA2quK4t4kPOsEwhfU6iP+W8C5Pn6/xu+vVDwI8ldkX
	 9aa/g64vL/kSvXd5zqupofYMCl9Cq+jX4eIiZ2mKTEupYa/U5ir5mdvqX2IcNa6rsv
	 4Ht9AxiGHQKUlFHjrdPXvZOPE8z2W5E3bIXtw77zZ1g5cW1pXpbUeA+NBcd2kjM+R7
	 Q54O2vdV2XVc41XZfIk8GfGT1RPnZNsgdShFPsddRkTlInvCp1MbWU2D6/DP6vI4HY
	 54KGfsA5wrgRYXdSvSILQw33qE1QsbQ20RBVuUpp3gCFrbshhDHc/U8kii6m7DWJEx
	 +x6OILNks7EQg==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH v8] mm/damon: add node_eligible_mem_bp goal metric
Date: Sun, 26 Apr 2026 10:19:40 -0700
Message-ID: <20260426171941.86007-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426003245.2687-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 25 Apr 2026 17:32:45 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Background and Motivation
> =========================
> 
> In heterogeneous memory systems, controlling memory distribution across
> NUMA nodes is essential for performance optimization. This patch enables
> system-wide page distribution with target-state goals such as "maintain
> 60% of scheme-eligible memory on DRAM" using PA-mode DAMON schemes.
> 
> Rather than using absolute thresholds, this metric tracks the ratio of
> memory that matches each scheme's access pattern filters on a target
> node, enabling the quota system to automatically adjust migration
> aggressiveness to maintain the desired distribution.
> 
> What This Metric Measures
> =========================
> 
> node_eligible_mem_bp:
>     scheme_eligible_bytes_on_node / total_scheme_eligible_bytes * 10000
> 
> Two-Scheme Setup for Hot Page Distribution
> ==========================================
> 
> For maintaining 60% of hot memory on DRAM (node 0) and 40% on CXL
> (node 1):
> 
>     PULL scheme: migrate_hot to node 0
>       goal: node_eligible_mem_bp, nid=0, target=6000
>       addr filter: node 1 address range (only migrate FROM CXL)
>       "Move hot pages to DRAM if less than 60% of hot data is in DRAM"
> 
>     PUSH scheme: migrate_hot to node 1
>       goal: node_eligible_mem_bp, nid=1, target=4000
>       addr filter: node 0 address range (only migrate FROM DRAM)
>       "Move hot pages to CXL if less than 40% of hot data is in CXL"
> 
> Each scheme independently measures its own eligible memory and adjusts
> its quota to achieve its target ratio. The schemes work in concert
> through DAMON's unified monitoring context, with the quota autotuner
> balancing their relative aggressiveness.
> 
> Implementation Details
> ======================
> 
> The implementation adds a new quota goal metric type
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP to the existing DAMOS quota goal
> framework. When this metric is configured for a scheme:
> 
> 1. During each quota adjustment cycle, damos_get_node_eligible_mem_bp()
>    is called to calculate the current memory distribution.
> 
> 2. The function iterates through all regions that match the scheme's
>    access pattern (via __damos_valid_target()) and calculates:
>    - Total eligible bytes across all nodes
>    - Eligible bytes specifically on the target node (goal->nid)
> 
> 3. For each eligible region, damos_calc_eligible_bytes() walks through
>    the physical address range, using damon_get_folio() to look up
>    each folio and determine its NUMA node via folio_nid().
> 
> 4. Large folios are handled by calculating the exact overlap between
>    the region boundaries and folio boundaries, ensuring accurate
>    byte counts even when regions partially span folios.
> 
> 5. The ratio (node_eligible / total_eligible * 10000) is returned
>    as basis points, which the quota autotuner uses to adjust the
>    scheme's effective quota size (esz).
> 
> The implementation requires CONFIG_DAMON_PADDR since damon_get_folio()
> is only available for physical address space monitoring.
> 
> Testing Results
> ===============
> 
> Functionally tested on a two-node heterogeneous memory system with DRAM
> (node 0) and CXL memory (node 1). A PUSH+PULL scheme configuration using
> migrate_hot actions was used to reach a target hot memory ratio between
> the two tiers.
> 
> With the TEMPORAL tuner, the system converges quickly to the target
> distribution. The tuner drives esz to maximum when under goal and to
> zero once the goal is met, forming a simple on/off feedback loop that
> stabilizes at the desired ratio.
> 
> With the CONSIST tuner, the scheme still converges but more slowly, as
> it migrates and then throttles itself based on quota feedback. The time
> to reach the goal varies depending on workload intensity.
> 
> Note: This metric works with both TEMPORAL and CONSIST goal tuners.
> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Assuming below two minor things are addressed,

Reviewed-by: SeongJae Park <sj@kernel.org>

[...]
> +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
> +		struct damos *s, int nid)
> +{
> +	phys_addr_t total_eligible = 0;
> +	phys_addr_t node_eligible;
> +
> +	if (c->ops.id != DAMON_OPS_PADDR)
> +		return 0;
> +
> +	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
> +		return 0;
> +
> +	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
> +
> +	if (!total_eligible)
> +		return 0;
> +
> +	return mult_frac((unsigned long)node_eligible, 10000,
> +			(unsigned long)total_eligible);

Sashiko found [1] total_eligible after the casting could be zero on 32bit
system, resulting in divide-by-zero.  As I also replied to Sashiko review,
could you please fix this?  It seems we can simply remove the castings.

[...]
> @@ -2389,9 +2528,9 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
>  /*
>   * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
>   */
> -static void damos_set_effective_quota(struct damos_quota *quota,
> -		struct damon_ctx *ctx)
> +static void damos_set_effective_quota(struct damon_ctx *c, struct damos *s)

Sorry for finding this late.  Could we keep the dmon_ctx parameter name?
Otherwise, we introduce unnecessary change below.

If the mult_frac() divide-by-zero is not a real issue, I wouldn't insist this
change.  But, if we will make a new version, let's do this together.

>  {
> +	struct damos_quota *quota = &s->quota;
>  	unsigned long throughput;
>  	unsigned long esz = ULONG_MAX;
>  
> @@ -2402,9 +2541,9 @@ static void damos_set_effective_quota(struct damos_quota *quota,
>  
>  	if (!list_empty(&quota->goals)) {
>  		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
> -			damos_goal_tune_esz_bp_consist(quota);
> +			damos_goal_tune_esz_bp_consist(c, s);
>  		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
> -			damos_goal_tune_esz_bp_temporal(quota);
> +			damos_goal_tune_esz_bp_temporal(c, s);
>  		esz = quota->esz_bp / 10000;
>  	}
>  
> @@ -2415,7 +2554,7 @@ static void damos_set_effective_quota(struct damos_quota *quota,
>  		else
>  			throughput = PAGE_SIZE * 1024;
>  		esz = min(throughput * quota->ms, esz);
> -		esz = max(ctx->min_region_sz, esz);
> +		esz = max(c->min_region_sz, esz);

Above change is unnecessarily introduced.  Could we keep the old damon_ctx
parameter name?

[1] https://lore.kernel.org/20260426005341.B393EC2BCB0@smtp.kernel.org


Thanks,
SJ

[...]
