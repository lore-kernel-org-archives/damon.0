Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341330C602;
	Sat, 21 Mar 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112269; cv=none; b=u7xwfThb3MQaolDQx2jdlwZK+FHcnNyoEpmsrBnDqR+AocKo3m76njzQLUavmxqch0eBzn1eUAIB//bZnsUzsxIOYWQHINtylt5pT7YFHaIfTPXTUDXjigMSiMVrMB+eMo3hxupCwjwIOSSERfeMtCfELvZKGVcvEjdA5S3Tmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112269; c=relaxed/simple;
	bh=4so0ChGaWqOM6KdH3LDG9GhHIY2dSUYkn8Ys1l42Dds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t826FM0RJDAqY1t50jEe8rqw3bkdiFcxo3nkBhV4M5q4wgKU1aJfLBNatFPHCDX+klEpoNUUf4Rh6l4SVucqtTiZ7uh03YfLLpo2c7B09MucOsshbNzpT26sEglX4U4hvPFSmgybORCjTGrqabZ5Fadlv0GCcu/VkBJBmg+kwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeSB1fvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeSB1fvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF18C19421;
	Sat, 21 Mar 2026 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774112268;
	bh=4so0ChGaWqOM6KdH3LDG9GhHIY2dSUYkn8Ys1l42Dds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OeSB1fvrhp6SsMGhqRMJAOMTLzXJNLGYF+bx1OoCEcnLdzJeC66W3PkeVARDsWD/M
	 2aqK3Ky8L7PEyHM8VSKUs6ACAta6xjkC3eg0pQk4r7EY6TTEoNAwAdV3Gi8HDxOrA7
	 P9vjq3wtbf1Yr5og79mfjFtLylGXe/J+G4s3lebNimpid9CEtjq2toF1nNLkNyIBlK
	 OwqtCg8Tq+/onv+8vEzwfRqirA8wAqvkGeLFZJ2bYksBtRay1Bk8JVqROuzLmfTBg3
	 xvsPCwO3SpR24yMQxhLR2GUtPAXbsFJsirm1xMI0lnw+svYVG/uKS2ZuVDyqfEJYJ6
	 MNIL99OPYGVSw==
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
Subject: Re: [RFC PATCH v4 0/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Sat, 21 Mar 2026 09:57:45 -0700
Message-ID: <20260321165746.84394-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320190453.1430-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Ravi,


Thank you for this patch!  TL; DR: Other than trivial things I commented below
and to the patch, I believe it is time to drop the RFC tag, and work on merging
this.

On Fri, 20 Mar 2026 12:04:52 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> This patch introduces two new DAMON quota goal metrics for controlling

s/DAMON/DAMOS/ ?

> memory distribution in heterogeneous memory systems (e.g., DRAM and CXL
> memory tiering) using physical address (PA) mode monitoring.
> 
> v3: https://lore.kernel.org/linux-mm/20260223123232.12851-1-ravis.opensrc@gmail.com/

The above link would better to be put on 'Chage since v3' section below.

> 
> Changes since v3:
> =================
> 
> - The first two patches from v3 (goal_tuner initialization fix and
>   esz=0 quota bypass fix) are now in damon/next. This submission

It is not also in mm-unstable :)

>   contains only the core metrics patch, rebased on top of those fixes.
> 
> - Simplified implementation: removed per-node eligible_bytes array, now
>   iterates scheme-eligible regions directly for each goal evaluation.
> 
> - Handle regions crossing node boundaries: uses damon_get_folio() to
>   determine actual NUMA node placement of each folio rather than
>   assuming uniform node placement within a region.
> 
> - Pass scheme pointer directly to metric calculation functions, avoiding
>   container_of() derivation from quota pointer.
> 
> - Fixed 80-column wrapping issues.

Thank you for addressing all my comments!

> 
> Background and Motivation
> =========================
> 
> In heterogeneous memory systems, controlling memory distribution across
> NUMA nodes is essential for performance optimization. This patch enables
> system-wide page distribution with target-state goals like "maintain 30%
> of scheme-eligible memory on CXL" using PA-mode DAMON schemes.
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
> The metrics are complementary: eligible_bp + ineligible_bp = 10000 bp.
> 
> Two-Scheme Setup for Hot Page Distribution
> ==========================================
> 
> For maintaining 30% of hot memory on CXL (node 1):

I think it could help easy reading if the above sentence also explains
node 0 is DRAM.  For example,

For maintaining hot memory on DRAM (node 0) and CXL (node 1) in 7:3 ratio:

> 
>     PUSH scheme: migrate_hot from node 0 -> node 1
>       goal: node_ineligible_mem_bp, nid=0, target=3000
>       "Push hot pages out until 30% of hot memory is NOT on DRAM"

Seems the sentence assumes the actor is in DRAM.  It was not very clear to me.
How about making it clear?  E.g.,

"Move hot pages from DRAM to CXL, if more than 70% of hot data is in DRAM"

> 
>     PULL scheme: migrate_hot from node 1 -> node 0
>       goal: node_eligible_mem_bp, nid=0, target=7000
>       "Pull hot pages back until 70% of hot memory IS on DRAM"

If the above example is good for you, to be consistent with it, how about
rewording like below?

"Move hot pages from CXL to DRAM, if less than 70% of hot data is in DRAM"

> 
> The complementary goals create a feedback loop that converges to the
> target distribution.
> 
> Dependencies
> ============
> 
> This patch is based on SJ's damon/next branch which includes the
> TEMPORAL goal tuner required for these metrics.

Your test might be depend on the feature.  But this patch series itself is not,
as users could also use it with CONSIST tuner?

Also, as I mentioned above, the feature is now also in mm-unstable tree.

> 
> Testing Results
> ===============
> 
> Functionally tested on a two-node heterogeneous memory system with DRAM
> (node 0) and CXL memory (node 1). Used PUSH+PULL scheme configuration
> with migrate_hot action to maintain a target hot memory ratio between
> the two tiers.
> 
> With the TEMPORAL goal tuner, the system converges quickly to the target
> distribution. The tuner drives esz to maximum when under goal and to
> zero once the goal is met, forming a simple on/off feedback loop that
> stabilizes at the desired ratio.
> 
> With the CONSIST tuner, the scheme still converges but more slowly, as
> it migrates and then throttles itself based on quota feedback. The time
> to reach the goal varies depending on workload intensity.

Sounds reasonable!

Do you plan to further evaluate some performance metrics?  I'd not strongly
request that, but it would be very nice if we can have that.

Regardless of your answer to the above question, I think the current code and
the test is good enough to consider merging this.  I suggest dropping the RFC
tag from the next spin.

Thank you for doing this, Ravi!


Thanks,
SJ

[...]
