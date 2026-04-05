Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB2C14A;
	Sun,  5 Apr 2026 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429156; cv=none; b=Q9k/iVP4fkBLXzA4VzoBo+QGrjo6CBNNgSbc6eGLBIwet2iNj2HrZC1sxFmIVuGbxSc1osXXB6tPp8fFF/BxfGkl2mQvGgY4EpmVi5LzrcyqRMzFJAb5ly55RlVabIqH9qP0IyPvmL8M9vbTh1BetX1wZNLq82aid7Wzt2JrxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429156; c=relaxed/simple;
	bh=XxJGbynt6Kw4uHZTfIMV+Njj+5Q3VK3ljHd+gNKJnwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTGwHPrxamBfEdvHSHQb2r5spYMY6o7/RjiKk2Kifh1M06gVdJVau6X4Ux2p4xXuyQMiS1TIhOpkVYktPiiG9KrmoTQjLgdO1e7BIIgq/gNHCnWNBlLLspyaLXnfK9AbhNYXlP3rJP8fgoMf35faBZ61PDNLFbgCfo+K9b6AuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndOVHOh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndOVHOh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E18EC116C6;
	Sun,  5 Apr 2026 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775429155;
	bh=XxJGbynt6Kw4uHZTfIMV+Njj+5Q3VK3ljHd+gNKJnwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndOVHOh1ksuOCP5L8Wom95mQQaFUhWMwsL+zRzfR9mj2rsbiP/QUqTpQ/IAbfxTyY
	 6VYibvBj6T1VNok5hOWGs9qwGdQkRxGJ1DJNXiUBrwrqsbg8YrHi/3muEYza7YZ9Sn
	 NZVwQE61v/i6jBgsCSTjvsamAFpcWk27hDD9lk5R0JZ6UD3FozPhehKuCp0XJHb68V
	 85xzVzNji8XGFwu8pT3SLeJAxAh39nogKtZP2XrLKfFJBtetaDzLJHQoc2yqIZMavb
	 RuybkY8Rkx4ehZPaAPCK3t6UbGZ1NNJcpQi0FJ8UXknYTNuMgaUxXXib8YGoCAHFva
	 RbJdHYTuptrdA==
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
Subject: Re: (sashiko review) [PATCH v6 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Sun,  5 Apr 2026 15:45:50 -0700
Message-ID: <20260405224550.76218-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405184247.2690-2-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Ravi, thank you for reposting this patch after the rebase.  This time sashiko
was able to review this, and found good points including things that deserve
another revision of this patch.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails.  Ravi,
could you please reply?

> # review url: https://sashiko.dev/#/patchset/20260405184247.2690-2-ravis.opensrc@gmail.com
> # start of sashiko.dev inline review
> commit 5f6ea8da06d136b84d97827777acf2b07047d42c
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
> 
> This commit adds quota goal metrics for tracking scheme-eligible and
> ineligible memory distribution across NUMA nodes. It iterates over
> scheme-eligible regions and uses damon_get_folio() to determine placement.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > +static unsigned long damos_calc_eligible_bytes(struct damon_ctx *c,
> > +		struct damos *s, int nid, unsigned long *total)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +	unsigned long total_eligible = 0;
> > +	unsigned long node_eligible = 0;
> 
> Can total_eligible and node_eligible overflow on 32-bit architectures? 
> Since these accumulators track raw physical bytes, regions spanning multiple
> gigabytes might wrap around the 32-bit unsigned long limit. Would it be
> safer to use u64 or track the counts in pages instead?

Makes sense.  Ravi, could we update these to use phys_addr_t?

> 
> > +
> > +	damon_for_each_target(t, c) {
> > +		damon_for_each_region(r, t) {
> > +			phys_addr_t addr, end_addr;
> > +
> > +			if (!__damos_valid_target(r, s))
> > +				continue;
> 
> Should this loop also check damos_core_filter_out()? By only checking
> __damos_valid_target(), it seems memory explicitly excluded by user-defined
> region filters (like target ID or memcg limits) is still counted as
> eligible, which might inflate the total and affect the quota tuning loop.

No, we intentionally defined "eligible" based on only the access pattern.  We
may be able to extend this to apply filters in future, if we find a use case.
But, for now, I'd suggest keeping this as is for now.

> 
> > +
> > +			/* Convert from core address units to physical bytes */
> > +			addr = r->ar.start * c->addr_unit;
> > +			end_addr = r->ar.end * c->addr_unit;
> > +			while (addr < end_addr) {
> 
> Could this unbounded loop cause CPU soft lockups? Since DAMON regions can
> span hundreds of gigabytes, executing millions of folio lookups sequentially
> without a cond_resched() could monopolize the CPU.

Good point.  Most DAMOS action implementations are also doing cond_resched()
per region.  Ravi, could we add cond_resched() per region to this function,
too?

> 
> > +				struct folio *folio;
> > +				unsigned long folio_sz, counted;
> > +
> > +				folio = damon_get_folio(PHYS_PFN(addr));
> 
> What happens if this metric is assigned to a DAMON context configured for
> virtual address space monitoring? If the context uses DAMON_OPS_VADDR,
> passing a user-space virtual address to PHYS_PFN() might cause invalid
> memory accesses or out-of-bounds page struct reads. Should this code
> explicitly verify the operations type first?

Good finding.  We intend to support only paddr ops.  But there is no guard for
using this on vaddr ops configuration.  Ravi, could we add underlying ops
check?  I think damon_commit_ctx() is a good place to add that.  The check
could be something like below?

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1515,10 +1515,23 @@ static int damon_commit_sample_control(
 int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
        int err;
+       struct damos *scheme;
+       struct damos_quota_goal *goal;

        dst->maybe_corrupted = true;
        if (!is_power_of_2(src->min_region_sz))
                return -EINVAL;
+       if (src->ops.id != DAMON_OPS_PADDR) {
+               damon_for_each_scheme(scheme, src) {
+                       damos_for_each_quota_goal(goal, &scheme->quota) {
+                               switch (goal->metric) {
+                               case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+                               case DAMOS_QUOTA_NODE_INELIGIBLE_MEMPBP:
+                                       return -EINVAL;
+                               }
+                       }
+               }
+       }

        err = damon_commit_schemes(dst, src);
        if (err)
'''

> 
> > +				if (!folio) {
> > +					addr += PAGE_SIZE;
> > +					continue;
> > +				}
> > +
> > +				folio_sz = folio_size(folio);
> > +				/*
> > +				 * Clip to region boundaries to avoid counting
> > +				 * bytes outside the region when folio spans
> > +				 * region boundaries.
> > +				 */
> > +				counted = min(folio_sz, (unsigned long)(end_addr - addr));
> 
> Does this accurately calculate the remaining bytes if the region starts at an
> unaligned offset within a large folio? folio_size() returns the full size
> of the folio, so this calculation might overestimate the eligible bytes by
> not accounting for the initial offset within the folio.
> 
> > +				total_eligible += counted;
> > +				if (folio_nid(folio) == nid)
> > +					node_eligible += counted;
> > +
> > +				addr += folio_sz;
> 
> Can this pointer advancement overshoot the end of the current folio? If
> addr was unaligned, adding the full folio_sz will skip past the beginning
> of the next contiguous physical memory folio.

Above two points make sense to me.  Ravi, could we fix these?

> 
> > +				folio_put(folio);
> > +			}
> > +		}
> > +	}
> > +
> > +	*total = total_eligible;
> > +	return node_eligible;
> > +}
> 
> [ ... ]
> 
> > +static unsigned long damos_get_node_ineligible_mem_bp(struct damon_ctx *c,
> > +		struct damos *s, int nid)
> > +{
> > +	unsigned long total_eligible = 0;
> > +	unsigned long node_eligible;
> > +
> > +	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
> > +		return 0;
> > +
> > +	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
> > +
> > +	/* No eligible memory anywhere - ratio is undefined, return 0 */
> > +	if (!total_eligible)
> > +		return 0;
> > +
> > +	/* Compute ineligible ratio directly: 10000 - eligible_bp */
> > +	return 10000 - mult_frac(node_eligible, 10000, total_eligible);
> > +}
> 
> Does this return value match the documented metric? The formula computes the
> percentage of the system's eligible memory located on other NUMA nodes,
> rather than the amount of actual ineligible (filtered out) memory residing
> on the target node. Could this semantic mismatch cause confusion when
> configuring quota policies?

Nice catch.  The name and the documentation are confusing.  We actually
confused a few times in previous revisions, and I'm again confused now.  IIUC,
the current implementation is the intended and right one for the given use
case, though.  If my understanding is correct, how about renaming
DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP to
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP_COMPLEMENT, and updating the documentation
together?  Ravi, what do you think?

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260405184247.2690-2-ravis.opensrc@gmail.com


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260405184247.2690-2-ravis.opensrc@gmail.com
#
