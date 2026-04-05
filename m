Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126F3148A8;
	Sun,  5 Apr 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429472; cv=none; b=cCRJh2pvzZt/FH5bQIYTvss0p8wVkAO97YEvWe4FYC572VoRcRisaqB5FOpnDebsqDMhJl9ElRObRVNXDJMNMYTBco492hRA77xmwVDjZHCRFi+fgPM50r7E9AefmISHUXTRMmzTsgqmLlYWXMlMRRf3KbQmqb+3Od9CzLqyjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429472; c=relaxed/simple;
	bh=icJXO+dguzj3tCxQ2UENNDdkRp09jjDpXJo1shy09+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4o3jQspfkA6b49yQCaq/qvg0q09eD0NUSyKSvREmh2e/EBednJ6WkwSkXqiymLJ9SJu538iNosGZ/z2sOCDAWucH8MmmdgT9REUuZGfOUAffTyQEJ3oZr/Z62q4noKOAnMyeGR3uB1I0Mjq6yWMIu3sV3DH+A0P788X+l3lSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMifXabe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMifXabe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DE5C116C6;
	Sun,  5 Apr 2026 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775429472;
	bh=icJXO+dguzj3tCxQ2UENNDdkRp09jjDpXJo1shy09+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMifXabezcDMLwlpRLIpwF7kD3ghLvBeRwLysSukzn3w8Spq7tYh9KsnafrMuoco3
	 Zg0EOqnG1ezOGuRQfMm1BGHQsMswc5/G0ToV35eDla+yV8cEbAxpjG200nJv5MVE41
	 lfMy8iZmq8GVPws+H/ltiNGg3IrJRx1otbOtyfzydaYPd8SqCqQUkbaa6ncA8p7aDu
	 5bD4gXcfeQvjtr1PiuTtFddG5aUyWvy88C1bvtqIVy6rNNGa8w26JAI44e3gA1iQA+
	 XcYbD9goI0DPTGt9hFJCkK42ZTzquF32DTAuz2mhyK9bKSuiz7IzaFVtSueY0tbSSJ
	 DzDSlhYJKuzhA==
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
Subject: Re: [PATCH v6 0/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Sun,  5 Apr 2026 15:51:04 -0700
Message-ID: <20260405225104.76350-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405184247.2690-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Ravi,

On Sun,  5 Apr 2026 11:42:46 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Changes since v5:
> =================
> https://lore.kernel.org/linux-mm/20260404012215.1539-1-ravis.opensrc@gmail.com/
> 
> - Rebased onto mm-new instead of damon/next for sashiko review

Thank you for doing this.  sashiko was able to review and find some good
points.  I shared the full review with my opinions as a reply to the patch 1.
Please check and reply.

> - Removed Reported-by/Closes tags per maintainer feedback (not needed
>   for bugs found before merge)
> 
> Changes since v4:
> =================
> https://lore.kernel.org/linux-mm/20260320190453.1430-1-ravis.opensrc@gmail.com/
> 
> - Fixed commit message description for DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP
>   per review feedback
> - Added clarifying comment for ops-common.h include (for damon_get_folio())
> - Fixed build error when CONFIG_DAMON_PADDR is disabled by adding
>   #ifdef CONFIG_DAMON_PADDR guards around functions using damon_get_folio()
> - Dropped RFC tag per maintainer feedback
> 
> This patch is based on top of mm-new.
> 
> Background and Motivation
> =========================
> 
> In heterogeneous memory systems, controlling memory distribution across
> NUMA nodes is essential for performance optimization. This patch enables
> system-wide page distribution with target-state goals such as "maintain
> 30% of scheme-eligible memory on CXL" using PA-mode DAMON schemes.
> 
> What These Metrics Measure
> ==========================
> 
> node_eligible_mem_bp:
>     scheme_eligible_bytes_on_node / total_scheme_eligible_bytes * 10000
> 
> node_ineligible_mem_bp:
>     (total - scheme_eligible_bytes_on_node) / total * 10000
> 
> These metrics are complementary: eligible_bp + ineligible_bp = 10000 bp.

As I mentioned on sashiko review, I now think node_ineligible_mem_bp is a
confusing name, and thinking a new name, maybe node_eligible_mem_bp_complement
is better.  Let's further discuss on sashiko review reply thread.

> 
> Two-Scheme Setup for Hot Page Distribution
> ==========================================
> 
> For maintaining hot memory on DRAM (node 0) and CXL (node 1) in a 7:3
> ratio:
> 
>     PUSH scheme: migrate_hot from node 0 -> node 1
>       goal: node_ineligible_mem_bp, nid=0, target=3000
>       "Move hot pages from DRAM to CXL if more than 70% of hot data is
>        in DRAM"
> 
>     PULL scheme: migrate_hot from node 1 -> node 0
>       goal: node_eligible_mem_bp, nid=0, target=7000
>       "Move hot pages from CXL to DRAM if less than 70% of hot data is
>        in DRAM"
> 
> The complementary goals create a feedback loop that converges to the
> target distribution.
> 
> Testing Results
> ===============
> 
> Functionally tested on a two-node heterogeneous memory system with DRAM
> (node 0) and CXL memory (node 1). A PUSH+PULL scheme configuration using
> migrate_hot actions was used to reach a target hot memory ratio between
> the two tiers. Testing used the TEMPORAL goal tuner available in
> damon/next and mm-unstable.
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
> Note: These metrics work with both TEMPORAL and CONSIST goal tuners.
> 
> Ravi Jonnalagadda (1):
>   mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal
>     metrics
> 
>  include/linux/damon.h    |   6 ++
>  mm/damon/core.c          | 188 ++++++++++++++++++++++++++++++++++++---
>  mm/damon/sysfs-schemes.c |  12 +++
>  3 files changed, 192 insertions(+), 14 deletions(-)

Btw, having a cover letter for single patch looks odd.  Why don't you add this
cover letter to the patch's commit message?


Thanks,
SJ

[...]
