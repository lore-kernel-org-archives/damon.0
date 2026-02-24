Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CD2773C6;
	Tue, 24 Feb 2026 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911396; cv=none; b=LNKXMyH/uqu4TADFVQWERePVP6/2sUCiivyfsj6fpAYue/LQesw9O8IA6JJwcUB+xPy8QE6ZMopmaywpoX0semXIzZ/+ly6XJl6K9jN9JJSBWgBtDS9T4ZoBXtQCqlZtDT7g51kWLHFFYhLhKf9db+tMk9E1jVsVO4c+jkzc510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911396; c=relaxed/simple;
	bh=bCkiAOs8zg+h4YWw2lU5IsN8hUlomxIStRc2ZuJPKjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnFhIBsZJ5RpHMADeQE/6M0W8kATSNRuFSE+VQSiIxAo3YbLR0Y6g7eJtLMwG5h5EGcxWdRF34iNPhDm0jf988pMqCgR3wE0PdsY+Z6V5e4JA4KnRTgKM+WkqwBOWuiE5mpTZ9a4vtzyiLGNdVGsHS/QgHsd0JuCBn2r52rA5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP0RhfiG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP0RhfiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A405DC116D0;
	Tue, 24 Feb 2026 05:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911396;
	bh=bCkiAOs8zg+h4YWw2lU5IsN8hUlomxIStRc2ZuJPKjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FP0RhfiG2oH64sS1x2NbtAk24gVTqWaDJR4xr+OZpTM4ggZWcj+AVWxZrIsEM9HpO
	 4cG+jYpP3yUkzSgP7C1C/lm96Vpr7c7DYA43EQHarkJDkhLwhbv7w7UZ1nL8293cXV
	 UkRqmD6PUK54Pqh17aROGLONBLzFS2LYfGVv0hcgyhELCWpWtBACBLJzNQ5Sg6Gwgb
	 cc5BTGJj+LI4wlKgqy4SV9kUcKL89d2YE+nkG65FjfTB/Kh8L2CQYW9naAQBCUNXcx
	 t8NrRoyV4NhG/1xZPC+xZ1SuElkj81faS+l9TT55Not5s31ZH37wpj+3jO/8HJP8gn
	 RISMGhTeKXiCw==
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
Subject: Re: [RFC PATCH v3 0/4] mm/damon: Introduce node_eligible_mem_bp and node_ineligible_mem_bp Quota Goal Metrics
Date: Mon, 23 Feb 2026 21:36:33 -0800
Message-ID: <20260224053633.58448-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223123232.12851-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Ravi,

On Mon, 23 Feb 2026 12:32:28 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This series introduces two new DAMON quota goal metrics for controlling
> memory migration in heterogeneous memory systems (e.g., DRAM and CXL
> memory tiering) using physical address (PA) mode monitoring.

Thank you for keep working on and sharing this :)

> 
> v2: https://lore.kernel.org/linux-mm/20260129215814.1618-1-ravis.opensrc@gmail.com/
> 
> Changes since v2:
> =================
> 
> - Split single metric into two complementary metrics:
>   * node_eligible_mem_bp: hot memory present ON the specified node
>   * node_ineligible_mem_bp: hot memory NOT on the specified node.
>   This enables both PUSH and PULL schemes to work together.

This perfectly aligns with the direction we agreed on the previous discussion.
Sounds good and reasonable to me.

> 
> - Added PA-mode detection lag compensation cache (see dedicated section
>   below for design details).

I'm not very sure if this is really needed, though.  I'll leave comment on the
dedicated section below.

> 
> - Added fix for esz=0 quota bypass that allowed unlimited migration when
>   goal was achieved.
> 
> - Added fix for goal_tuner sysfs setting being ignored due to
>   damon_new_scheme() always defaulting to CONSIST.

Thank you for finding and fixing these issues in my previously shared RFC patch
series!  I left a few comments to the patches.  In short, the second fix looks
good and I will add that to the next revision of my RFC patch series, if you
don't mind.  For the first fix, I'd like to take more time on thinking more
cleaner solution.

> 
> - Rebased on SJ's damon/next branch which includes the TEMPORAL goal
>   tuner required for these metrics.

Thank you for clarifying this!  This kind of context is very helpful at
revidewing patches.

> 
> Background and Motivation
> =========================
> 
> In heterogeneous memory systems, controlling hot memory distribution
> across NUMA nodes is essential for performance optimization. This series
> enables system wide hot page distribution with target-state goals like
> "maintain 30% of hot memory on CXL" using PA-mode DAMON schemes.
> 
> Two-Scheme Setup for Hot Page Distribution
> ==========================================
> 
> For maintaining 30% of hot memory on CXL (node 1):
> 
>     PUSH scheme (DRAM->CXL): migrate_hot from node 0 -> node 1
>       goal: node_eligible_mem_bp, nid=1, target=3000
>       Activates when node 1 has less than 30% hot memory
> 
>     PULL scheme (CXL->DRAM): migrate_hot from node 1 -> node 0
>       goal: node_ineligible_mem_bp, nid=1, target=7000
>       Activates when node 1 has more than 30% hot memory
> 
> Both schemes use the TEMPORAL goal tuner which sets esz to maximum when
> under goal and zero when achieved. Together they converge to equilibrium
> at the target distribution.

When this kind of complementary setup is being used, in my opinion, CONSIST
tuner might be better, especially when the access pattern is dynamic.  But it
is up to user's choice.

> 
> What These Metrics Do
> =====================
> 
> node_eligible_mem_bp measures:
>     effective_hot_bytes_on_node / total_hot_bytes * 10000
> 
> node_ineligible_mem_bp measures:
>     (total_hot_bytes - effective_hot_bytes_on_node) / total_hot_bytes * 10000
> 
> The metrics are complementary: eligible_bp + ineligible_bp = 10000 bp.

All make sense to me, so far.

> 
> PA-Mode Detection Lag and Cache Design
> ======================================
> 
> In PA-mode, when pages are migrated:
> 1. Source node detection drops immediately (pages are gone)
> 2. Target node detection increases slowly (new addresses need sampling)

I agree.  And this is not what I clearly expected during the previous
discussion.  Thank you for sharing this issue.

> 
> This asymmetry causes temporary underestimation of hot memory on the
> target node. Without compensation, the system keeps migrating even after
> reaching the goal.

But, is this really significant?  I believe people may use complementary
auto-tune setup especially when they expect dynamic access pattern.  In the
case, even if we can perfectly compensate this kind of gap, some of oscillation
will happen.  You also mentioned "eventual convergence" could be acceptable.

> 
> The cache addresses this by remembering how much was recently migrated.
> When calculating effective hot memory:
> - Source node: reduce detected amount by recent migrations out
> - Target node: boost detected amount by recent migrations in
> 
> The cache uses a rolling window to track migrations over time, and
> expires after a configurable timeout (default 10s) when no migration
> activity occurs. It also detects when its baseline becomes stale due
> to new hot memory appearing in the workload.

I will leave more comments to the patch implementing this.  But this seems too
much at the current stage, unless there are clear test results showing its
needs.  I'd recommend proceeding without this, and later revisit if the problem
becomes clearly significant.

> 
> Dependencies
> ============
> 
> This series is based on SJ's damon/next branch which includes:
> 
> - mm/damon/core: introduce damos_quota_goal_tuner [1]
> - mm/damon/core: set quota-score histogram with core filters [2]
> - mm/damon: always respect min_nr_regions from the beginning [3]
> - mm/damon/core: disallow non-power of two min_region_sz [4]
> 
> [1] https://lore.kernel.org/linux-mm/20260212062314.69961-1-sj@kernel.org/
> [2] https://lore.kernel.org/linux-mm/20260131194145.66286-1-sj@kernel.org/
> [3] https://lore.kernel.org/linux-mm/20260217000400.69056-1-sj@kernel.org/
> [4] https://lore.kernel.org/linux-mm/20260214214124.87689-1-sj@kernel.org/
> 
> Patch Organization
> ==================
> 
> 1. mm/damon/sysfs: set goal_tuner after scheme creation
>     - Fixes goal_tuner initialization order in sysfs scheme creation
> 
> 2. mm/damon: fix esz=0 quota bypass allowing unlimited migration
>     - Ensures esz=0 stops migration rather than bypassing quota entirely
> 
> 3. mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
>     - Adds the two complementary metrics for hot memory distribution control
> 
> 4. mm/damon: add PA-mode cache for eligible memory detection lag
>     - Implements rolling window cache to compensate for PA-mode detection lag
>     - Adds configurable cache timeout via sysfs
> 
> Testing Status
> ==============
> 
> Functionally tested on a two-node heterogeneous memory system (DRAM + CXL)
> with PUSH+PULL scheme configuration.

Glad to hear the functionality is tested.  Looking forward to the next results!

> 
> This is an RFC and feedback on the design is appreciated.

I'm yet to further reply to the fourth patch, but I hope my comments be worthy
:)


Thanks,
SJ

[...]
