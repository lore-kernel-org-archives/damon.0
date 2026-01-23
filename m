Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E0392B69
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144269; cv=none; b=iiaZIt62hiu90nebYgKcii45y8KyrZIMSJdFphAYOFQdcBwN3phpaADZEG8drTEPKBq7sYebwV4u1xwjcrJOOTbWCHDTa9CJsPHhp2Nhjy27Z/taaKap1TRivPPkWNQPcX6akzzL/owp7IWoRDFpM+DvWmNbAG21vb2U8cbVSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144269; c=relaxed/simple;
	bh=ZcUmMHoebdbK/BuUi4NdTdmGsnkYnj/TqGmD1517cxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hy1L7msgxSPa39JetrQ9BKphC+zHd3whfFQrzNf1Dl2vNvMT8mOuM33cjwG1WOwaivdwAKX/M+iDRg4wghl7f9GiXuZwIIPpIebA1fRqlSAezuwlFia04BP9aoLCTavUJpXg2FS6dUdL0fRL9/Bwmjk2GQTZvL5I0k60WbUfvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRLVaVQT; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRLVaVQT"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79430ef54c3so13881897b3.2
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 20:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769144261; x=1769749061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJkgvPZFHCE7A0AwblR4LoBvEnU1RF29gonEpvLNZc8=;
        b=XRLVaVQTWFHajNywTSIpNV57bnCC+tWjFdrbNXXDV1K9XLLaMiVvo0EsqfBf9P39PS
         Jndt9HrQ5I3MO4wvSClyEZCSkr5W6nxAs6JU/iCsLzk3xilsJEXk+w6HWv9RfZzvLgLR
         DE3hmqzu6EgHGZXkQccC0X53PySdNIR2Ev1qGZMmY6cShJvGru/+6AWLrVef1Xnhd09t
         eXj53IfY7hQR9sZzkew1Gs/LOtfaboJSL/LwAQekR+acXO6JyRTvEaThjbhu1R16zEW+
         elQc2ycML5IyHCL4Jr83Vu0LLDi193n0hV9n3ds+J63I6XdwVo2qTiMF1i0bKixvQcKh
         RhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144261; x=1769749061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJkgvPZFHCE7A0AwblR4LoBvEnU1RF29gonEpvLNZc8=;
        b=n4k4Q/qU0m5geXsdPZUe0weQIHo0ZFJtyg7t+x+UkxJIUei4w25c8B3BaDNRMRqRxU
         VWeGd2GQ8mdJL/OYZW7eNTRrDxXAoguJSx6kkDmsZ3419FXAGIlxN7XcyOMDdzzzfeq7
         RzANJ0gNZwVWQpuPK6IJsGi1xAF4CsP3Y37uFaSuAWJBF4l7sUbsnowgd7DfTCI2OcF2
         ipAA98QjMDfQeDxJmmyd59jNtJ/2qK8Z+nD64wccyYjf0yNDhOENYCVbfMej6XPFuXZ/
         g4uLsVHmVBmFyNEJL4p8iKm5wOYZuPU47HoxEvuqslFBFLIGUf+dczSfBVFwKrn+ARpr
         NcAQ==
X-Gm-Message-State: AOJu0YxTNLxPXwjpEa0rvte5MrNOMOW89XvZ4BJWToMzxk+wbw/7M0PT
	PJvVeSDJzgY2/l7sZJFT710hIYCkn5v+c+rbbAS1guTTSYgs4lWw8IJVK5NZQO8=
X-Gm-Gg: AZuq6aIxnW9q79HuLDTTRuEZVTmbExFXWkKu0j5sdsXiX0qK48VuiViR4ggDgPEMvbX
	le3aTuzwANqoYPUgphp3A2YOzh3VSuEh0wixlxW1scl0jsP+vg/80KGoTjnedDxKQDK4jdT3VKx
	bYVz8PZwDgN/JkMNX7pxMo4r7d4HjXmvRMNKC4Se8DBVSOUNlMrwIrMqYeZ56hDIslEkTZNnyU4
	agxBeT8NT1ktkTqthPZvNECCvcNPa1LUIx8E+hAOHtTGwVenq38+sginPJ+E9SN11fYWGnbsp3O
	b4LO0NFNBYeH0QmTGScT2iJgm6DL2olq6F7qHBfFmIMhlelyCg3dWxt+ET2FEOWvqdqCVqbeEO3
	+WF5nbb4iIQ6BtT12ze/OH7uLE+kq08cjYR5hj4gRqf2/CR+GHUHkg51kfb+26mfeOBYrLK4CPs
	CFHxzCkSyozcOHK5xDhPLi+Jf1H+hwIEuWzIAjwS1t1p9D4ezrWCJuX+sKjsrPWA==
X-Received: by 2002:a05:690c:4444:b0:794:93e:d0f8 with SMTP id 00721157ae682-794398be450mr16665047b3.7.1769144260705;
        Thu, 22 Jan 2026 20:57:40 -0800 (PST)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af13d6dsm6408937b3.9.2026.01.22.20.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:57:40 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH 0/5] mm/damon: Add node_sys_bp quota goal metric for PA-based migration control
Date: Thu, 22 Jan 2026 20:57:23 -0800
Message-ID: <20260123045733.6954-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces a new DAMON quota goal metric, `node_sys_bp`, designed
for controlling memory migration in heterogeneous memory systems (e.g.,
DRAM↔CXL tiering). These patches are provided as an initial RFC and have
not been tested on actual hardware.

Background and Motivation
=========================

A previous patch series [1] by Bijan Tabatabai and myself added weighted
interleave support for DAMON migrate_{hot,cold} actions. That series
implemented the feature for vaddr (virtual address) schemes because the
weight-based approach requires VMA offset information to determine target
nodes:

    target_node = (vma_offset % total_weight) → node_from_weights

For paddr (physical address) schemes, obtaining VMA offset requires costly
rmap (reverse mapping) walks. As noted in that series:

    "However, finding out how a folio is mapped inside of a VMA requires
     a costly rmap walk when using a paddr scheme. As such, we have
     decided that this functionality makes more sense as a vaddr scheme."

This new series takes a different approach that enables PA-based migration
WITHOUT requiring rmap walks, by using basis points (bp) target-state goals
instead of weight-based action rates.

The rmap Cost vs Oscillation Trade-off
======================================

For PA-based migration with weights, there are two possibilities:

  1. Weight-based with rmap:
     - Use rmap to find VMA offset for each physical page
     - Apply weights based on VMA offset (same algorithm as VA)
     - Works correctly: VMA offset provides stable identity
     - Problem: rmap walks are expensive for every migration candidate

  2. Weight-based without rmap:
     - Attempt to apply weights using only physical address information
     - No stable identity across migrations
     - Results in page oscillation (see below)
     - Not viable

The Oscillation Problem (Weights Without rmap)
==============================================

Weight-based migration relies on a stable identifier to determine which node
a page "belongs to". For VA, this is the VMA offset - it remains constant
regardless of which physical node backs the page. For PA without rmap, no
such stable identifier exists.

Consider a two-node system with weights {Node 0: 40, Node 1: 60}:

  Initial state:
    Hot pages on Node 0: PFN 0x1000, 0x1001, 0x1002, 0x1003, 0x1004
    Node 1: empty

  Iteration 1 - Weight-based selection (no rmap):
    System tries to achieve 40/60 distribution
    Selects pages at PFN 0x1002, 0x1003, 0x1004 (60%) for Node 1
    After migration, these pages get NEW PFNs on Node 1:
      PFN 0x1002 → PFN 0x5000 (Node 1)
      PFN 0x1003 → PFN 0x5001 (Node 1)
      PFN 0x1004 → PFN 0x5002 (Node 1)

  State after Iteration 1:
    Node 0: PFN 0x1000, 0x1001 (40%)
    Node 1: PFN 0x5000, 0x5001, 0x5002 (60%)

  Iteration 2 - Weight-based selection runs again:
    System sees pages at PFN 0x5000, 0x5001, 0x5002 on Node 1
    These are "new" pages from the system's perspective
    NO MEMORY that these were just migrated FROM Node 0
    Weight-based logic may select some for migration back to Node 0

  Iteration 3, 4, 5...:
    Same pages continue bouncing between nodes
    Each migration changes the PFN, erasing any "history"
    System never converges to stable state

The fundamental issue: weights define an ACTION RATE ("migrate X% of
candidate pages to each node") rather than a TARGET STATE. Without stable
page identity (which rmap provides via VMA offset), the system cannot
determine which pages have already been "handled" and continues to
reprocess the same logical pages indefinitely.

With rmap, the VMA offset provides stable identity - a page at file offset
0x1000 always hashes to the same target node regardless of its current PFN.
Without rmap, we have no such anchor, and weights become meaningless.

Solution: bp-Based Target State Goals
=====================================

Instead of specifying action rates, `node_sys_bp` specifies a TARGET STATE:

    "Node N should contain X basis points (X/10000) of system memory"

The migration control loop:

  1. Calculate current_bp: sum bytes per node across monitored regions
  2. Compare: if current_bp >= target_bp, STOP (goal satisfied)
  3. Otherwise: continue migrating toward target

  Example with target: "Node 0 should have 4000 bp (40%)"

    Iteration 1:
      current_bp = 10000 (100% on Node 0)
      target_bp  = 4000 (40%)
      current > target → migrate cold pages away from Node 0

    After Iteration 1:
      current_bp = 4000 (40% on Node 0)

    Iteration 2:
      current_bp = 4000
      target_bp  = 4000
      current >= target → STOP, goal satisfied

    No oscillation - migration stops when target state is reached.

No page identity tracking needed because we measure the END STATE, not
which specific pages were moved. The early-exit prevents oscillation by
stopping when the goal is met.

Why get_goal_metric() Ops Callback
==================================

The bp calculation requires iterating over monitored PA regions:

    for (pfn = start_pfn; pfn < end_pfn; pfn++) {
        if (page_to_nid(pfn_to_page(pfn)) == nid)
            node_bytes += PAGE_SIZE;
    }
    bp = node_bytes * 10000 / system_total;

This requires address-space knowledge that only the ops provider has.
Existing goal metrics (PSI, node_mem_*, node_memcg_*) are computed in
core using system-wide data that doesn't require iterating monitored
regions.

The new `get_goal_metric()` callback in `damon_operations` allows:

  1. Core to remain generic - handles all common metrics
  2. Ops providers to implement metrics requiring region iteration
  3. Clean separation - PA implements node_sys_bp, VA could add
     different metrics in future
  4. Optional implementation - ops return 0 if metric unsupported

This design ensures node_sys_bp is only computed when using PA contexts
where it makes sense, while keeping the core quota goal infrastructure
unchanged for other metrics and ops providers.

The callback pattern allows each ops provider to implement metrics
specific to its address space model without burdening the core with
ops-specific knowledge.

Advantages of PA-Based Migration
================================

PA-based migration with DAMON enables integration of multiple hotness
sources for migration decisions:

  1. DAMON's native access pattern monitoring
  2. Fault-based information (similar to NUMA Balancing)
  3. Future: Hardware monitoring units (e.g., CXL CHMU)
  4. Future: Instruction-Based Sampling (AMD IBS, Intel PEBS)

Unlike VA-based approaches tied to individual process address spaces, PA
monitoring can aggregate hotness information from multiple sources to make
system-wide migration decisions across the entire physical memory space.

Complementary to Existing vaddr Migration
=========================================

This series complements rather than replaces the vaddr weighted interleave
migration merged in 6.18:

  vaddr migration (weight-based):
    - Per-process control
    - Fine-grained interleave patterns via VMA offset
    - Deterministic placement based on weights

  paddr migration (bp-based, this series):
    - System-wide control
    - Target-state goals for node capacity management
    - No rmap overhead
    - Aggregates multiple hotness sources

Capacity Clamping
=================

The series also implements capacity clamping for `node_sys_bp` goals. In a
system where Node 0 has 40% of total RAM, setting a target of 50% is
impossible. The implementation clamps:

    effective_target = min(user_target, node_capacity_bp)

This prevents the quota auto-tuning from chasing impossible targets and
avoids thrashing in two-context DRAM↔CXL setups.

Patches
=======

  1/5: mm/damon/core: add DAMOS_QUOTA_NODE_SYS_BP metric
       Adds the enum value and documentation.

  2/5: mm/damon: add get_goal_metric() op and PA provider
       Introduces the ops callback and PA implementation that iterates
       monitored regions to calculate node_sys_bp without rmap.

  3/5: mm/damon/core: add new ops-specific goal metric
       Wires the new metric into core's quota goal evaluation, delegating
       to ops.get_goal_metric() for DAMOS_QUOTA_NODE_SYS_BP.

  4/5: mm/damon/paddr: capacity clamp and directional early-exit
       Adds capacity clamping and early-exit logic to prevent migration
       when goal is already satisfied.

  5/5: mm/damon/sysfs-schemes: accept "node_sys_bp" in goal's target_metric
       Exposes the new metric to userspace via sysfs.

Status
======

This is an early RFC for design review. The patches:
  - Compile successfully with no errors or warnings
  - Have NOT been tested on actual hardware

Feedback on the overall approach and design is appreciated.

References
==========

[1] mm/damon/vaddr: Allow interleaving in migrate_{hot,cold} actions (v4)
    https://lore.kernel.org/linux-mm/20250709005952.17776-1-bijan311@gmail.com/
    Merged in Linux 6.18


Ravi Jonnalagadda (5):
  mm/damon/core: add DAMOS_QUOTA_NODE_SYS_BP metric
  mm/damon: add get_goal_metric() op and PA provider
  mm/damon/core: add new ops-specific goal metric
  mm/damon/paddr: capacity clamp and directional early-exit for
    node_sys_bp
  mm/damon/sysfs-schemes: accept "node_sys_bp" in goal's target_metric

 include/linux/damon.h    |   5 ++
 mm/damon/core.c          |  34 ++++++++++---
 mm/damon/paddr.c         | 102 +++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |   7 +++
 4 files changed, 141 insertions(+), 7 deletions(-)

-- 
2.43.0

