Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267C4EE84F
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060608; cv=none; b=g+pRSC0RkGV38L2ir4vMIitmg+5BuP2KZ3+wVkCc4PM1/P8ZK/jnk2GLYrXlwQS/KVRqlZqVVeSIXWDZR8/4GV1eTAI9NNt1Fy4WcZYMWOfDU/CdSuFFdCatpfG3eM/MFGeh6sMt5mgSgWlQjpK/6C9je0exQpIfjl6anBVnpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060608; c=relaxed/simple;
	bh=mP0ZMDH+IQi6Bl+eymFBOQjEqyio0BazLJvqqYA/ato=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hk0kmFl4uNvO4ZvLjKVNGNuxdkq75qfi+0175ElSYT0bQWBq+WyXxut9SsLoA6hmNxfhf78+nEOmS+bebf2/CdnPrRGenSc7BAXOf1vXHzK3MlL43HEgIkR5iE+wzYKrK7xEYdyPrmrEj4fbJ38+kRqkG7rR9cOO12WpMrVX6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4E7dgcH; arc=none smtp.client-ip=74.125.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4E7dgcH"
Received: by mail-yx2-f4.google.com with SMTP id 00721157ae682-86f73e4cfcbso15457157b3.0
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060589; x=1789665389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZFo6loCSbYpy8qelkbAHjDjCPXMds8CC2/U524kG4U=;
        b=U4E7dgcHBhFaItA8T+vRLIk+1e1lCacaW+yv4bNtAqIL9Fm82f6kRs9hj/VdOlGyr0
         qD4PCufBQ+CCdl+ZVW6g7F+ks6iQP07B9jWOO7n+96cJgNL5jpuSBjlz2DYOuIBo1XQq
         9Y9z+0kdYb1DQE8dtA/AFMZG5jT9GCIXCsSjqCe1hceMEjD85XyX4XNQkPEoGRI8wHGg
         WEpnw7EzRdyQ6sa2RMSjXEnyexGNIrwZyIYbhk/Sr5G4tbOOchzlXTk++0ZBdEJ2eMcW
         rHA7lsPHuYyFGjxzfwaZaUM5oJYS2RYnZ7TVWC0uTT/DbE2H5JixrNIa+Rdkm68cMeu9
         3npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060589; x=1789665389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZFo6loCSbYpy8qelkbAHjDjCPXMds8CC2/U524kG4U=;
        b=ZMGefBXGVgnN/VmbHEg33hBVGZompLkY3nLNKW4ZtLL/nBZcPY79NsEbMgPeD97jbx
         7e/66leTFNp0MGclzgDOxxFM5yln1wiSnuOdtc2yIZpMtiN4o9LtdLQL+6bT+Qs19FLn
         IGwaLu1zG/+1pdmAjy9VmRp52CuDwQEzu8ILA/5Y51Qf0BxNMyVMWxa3w50Dhu1p4M0J
         i0ny/lo9dl2SnokSleKeZaXkjIGvkrwx9vyYPxXbw53pZ/DYP3Na6hxBQIsZrd669sRZ
         MorPNVUweIDq7JOzvgDgtLGIRVaAN1IRQDoiByB9zyCzPJvoVlMYjY1MaLnkRUp9yJ83
         h6PA==
X-Forwarded-Encrypted: i=1; AKwUvBzvU22tuTxiqVYNZA6mBYUiLP+6f6nCLtbO/pg2ND3fv/99EQglVNjClEoLfoDTZJWP5plDXw==@lists.linux.dev
X-Gm-Message-State: AFuF++mrXxfYeh2kJn/axG0ZNEApbdYaRSTEKJBGZ9/3amOfjrz6vUNw
	VQHW6oMm6W6ksHGug1duVsTI5RNd+KXzJkJTvPAztQfYV5mMQRHvOx0=
X-Gm-Gg: AYBFou3XQMGoyH+eNb4H7GfEx/P9xti2hJQcQwG3zff1rudnS9094Zyp3NSmW2njd3U
	Ik5l+vaomg8jjZJV9UR0nfofgLcsx7x0ow66ltXXW851QG5yM+AR7ZH0ZMwOjv0kp6s+op3Byt/
	zFK7TUCuGqgcpHNs49yzIl2bgAxa5JVEdz3J5fOAO5yya6PHkMJMvrI0rt5F8ROp4QsXNjnzmZi
	4t3HdT0jxY9CYqANdUeRIZJkn07pxLto8TuHVnpUE/PyItEqimomhMNr1v2Wezx2qweNxPlotzI
	p8XVOY08sBDaRWz6NSUa+SVleVBBSR/i3NZ01tsn5clHDAqsBj2K3wOxb9OQW6WYUe9IzB5q3Ry
	j/oNU9CTe0zuwZFWZk5nAZC2oK1lm4fH7WrVHVbhZBY+CoAvsxdxverEEhi0OBJmuMiub/VFouH
	RY90c4cxaUEGXvawn4fn9rxIke4dj/Sy2Js8DHtCXaMaTPeilot51QAKfYnMFpcZjtom0Lcbw6m
	E6NaKbDNdlbi/3W7BwKLW/kHfy6ZBDYniBJivB670GyNZq55A==
X-Received: by 2002:a05:690c:a1d5:b0:85e:27b2:8f46 with SMTP id 00721157ae682-884aec8f7fdmr1640917b3.19.1789060588129;
        Thu, 10 Sep 2026 10:16:28 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488190880sm2253967b3.35.2026.09.10.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:27 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports
Date: Thu, 10 Sep 2026 10:16:14 -0700
Message-ID: <20260910171623.6638-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets DAMON take its access information from a hardware sampler
instead of from a page-table scan, and lets a scheme's score be weighted by what
that sampler reported.

The change from v1 [1] is that it is now built on the data attribute probe
infrastructure that has since landed in mm-new: a PMU is expressed as one more
probe on a context, with its own weight and probe hits, rather than as a
mechanism of its own beside the ops set.  The rest of this posting is the same
substrate reworked onto that, plus two consumers.

This is not a merge request.  The series is based on damon/next at the
base-commit below, which moves, so the tree it was built and tested from is also
on

  https://github.com/ravis-opensrc/linux/tree/damon/perf-rfc-v2-09-06-26

It is posted for design feedback, on the substrate and on where it belongs in
the roadmap for extending DAMON beyond the pte-accessed bit [2].  That roadmap's
second milestone, now open, is a first data attribute monitored through
`damon_report_access()`, and that is what a sampling PMU is here.  So this
series keeps that function and its callers and replaces its body: the reporting
path a hardware sampler needs cannot take a mutex, and the drain has to reach a
virtual-address context as well as a physical one.  The shape of the ring, the
drain and the sysfs surface are what is most useful to review.

## Why a unified perf-event substrate

DAMON derives its access information from the PTE Accessed bit.  A sampling PMU
carries what that bit cannot: which addresses the hardware went to, and how
often it went there.  Many machines already have such a unit, and more than one
kind of it, so what this series is after is letting DAMON's regions be tuned
from whichever perf-based hardware source a machine offers rather than from the
Accessed bit alone.  A sampler does not arrive on a kdamond's terms, though: it
delivers an address when the hardware decides to, in NMI context, with no
relation to the sampling interval and no mm to walk.

The alternative is a backend per PMU vendor, each owning its own configuration,
sysfs knobs and lifecycle.  The perf-event direction [3] avoids that: let DAMON
register kernel-counter perf events and consume samples from any sampling PMU the
perf core already knows about.  This series follows it, adding one substrate below
the ops sets rather than an ops set per PMU -- a report ring that any in-kernel
access source can push into, and a drain that folds those reports into region
probe hits on the aggregation boundary the kdamond already has.  What running it
across vendors needed on top of that direction is:

  - per-CPU lockless rings between the NMI sample handler and the kdamond drain,
  - a ring partitioned by probe class, so the page-fault primitive and a PMU can
    populate one context without either seeing the other's reports,
  - per-CPU events that follow CPU hotplug, armed when the kdamond starts and
    disarmed and drained when it stops,
  - a per-PMU owner, so two contexts cannot claim the same PMU type,
  - whichever address a PMU does report carried on the report and matched
    against the context's own address space, so one source serves a paddr or a
    vaddr context without a backend per address space.

This is tested with PEBS on Intel and IBS on AMD, both configured as `perf_event`
attributes on a probe and using the perf core's event plumbing rather than
per-vendor MSR code.  A third source has already been written against the same
ring: Kunwu Chan's ARM SPE backend [5], which reaches it through an AUX buffer
drained in process context instead of an overflow callback, and which the
roadmap [2] places in its third milestone.

The partitioning is what lets promotion and demotion run in one context.  A
sampler says which regions are hot; it says nothing about which are cold, because
a sampler that reports nothing about a page cannot distinguish untouched from
unsampled.  Region age is what a demotion scheme matches on, and age comes from
the page-fault primitive.  With the ring partitioned by class both are live at
once: the probe supplies hotness, the primitive supplies age, and two schemes
over the same regions can move memory in both directions under one kdamond.

The two classes are not symmetric, and the asymmetry is in where a report comes
from rather than in what it carries.  A page fault has no monitoring context at
report time, so a per-context ring is not expressible for it: those reports go to
one global set of per-CPU rings, drained by the single context whose page-fault
primitive is enabled.  A PMU overflow handler does carry the context that armed
the event, so those reports go to that context's own per-CPU rings and each
context drains only what it owns.  Both classes share the ring layout and the
producer side, so the barrier pairing cannot drift between them.

```
  page-fault report                    PMU sample, NMI context
  no ctx at report time                handler carries the owning ctx
          |                                     |
          v                                     v
  +----------------------------+       +----------------------------+
  | one global per-CPU ring    |       | per-CPU rings per context  |
  | set, shared by every ctx   |       | that armed a perf event    |
  +----------------------------+       +----------------------------+
  | drained by the one ctx     |       | each ctx drains only the   |
  | with the pf primitive on   |       | rings it owns              |
  +----------------------------+       +----------------------------+
          |                                     |
          +------------------+------------------+
                             |
                 drain on the aggregation boundary,
                 each report matched to a region
                             |
             +---------------+---------------+
             |                               |
        region age                    region probe hits
        demotion scheme               promotion scheme
```

That is the property this series exists to enable, and three things follow from
it:

  - One measurement drives both directions, at whichever scope the mode gives.
    Bandwidth comes from resctrl MBM, which is where the discussion on a
    platform-independent bandwidth signal for tiering has pointed [6]: a
    virtual-address context reads a monitoring group created for the processes
    it monitors, and a physical-address context reads the root monitoring
    group, so the same controller is scoped to a set of processes or to the
    whole machine without changing what it does.  Reading it there also means a
    bandwidth allocation reserved for an application bounds what the controller
    optimises within.  It spreads the hot set across nodes in the ratio that
    maximises achieved bandwidth when bandwidth is what the workload is short of,
    and it demotes cold pages off the near node in the same context at the same
    time -- either proactively under a fixed quota or only once DRAM is under
    memory pressure.  Neither direction is configured as a target ratio; the
    proportion or weight the controller writes bounds how much memory moves while
    the score decides which pages move, and a hardware sample makes that score
    proportional to the traffic a region generates rather than one bit per page
    per scan.  Earlier work on bandwidth-driven interleaving [4] measured the same
    effect from userspace.

  - Bandwidth and capacity are expanded at once rather than one being chosen.
    Static weighted interleaving expands bandwidth, but it is a placement rule
    rather than a decision about any particular page, so cold pages keep their
    share of DRAM.  NUMA balancing expands usable DRAM by promoting whatever is
    hot, but it does so without reference to what the far node can deliver, so it
    keeps promoting after the near node has stopped being the better place to
    read from.  Here the hot set's distribution comes from a bandwidth
    measurement and the cold set is demoted on region age, in one context, so the
    far node's bandwidth is used and DRAM is not held by memory nothing is
    touching.  The decision itself is a quota goal the kernel already carries:
    `node_eligible_mem_bp` [8] bounds how much of a node a scheme may fill, so
    what the controller supplies is the bandwidth measurement, not the
    placement.

  - When bandwidth is not the constraint it reverts to latency-first tiering on
    its own.  The search starts with everything on the near node and moves memory
    outward only when the measurement improves, so on a workload that does not
    saturate that node no step outward improves anything: the hot set stays in
    DRAM for the lower access latency and cold pages keep being demoted.  The
    same configuration covers both cases, with nothing to switch on and no ratio
    to revise.

## What the series adds

  1. `mm/damon/vaddr: support page fault access check primitive` -- implements
     the page-fault primitive for a virtual address space context; it was
     available for physical addresses only.  The marker whose fault reports the
     access is installed through the target mm and the vma of the sampling
     address directly, and prepare_access_checks() dispatches on the enabled
     primitive as the physical address space one does.

  2. `mm/damon/core: read the CPU number with preemption disabled` -- the report
     path runs in fault context, which is preemptible.  Read the CPU number with
     preemption disabled and keep it disabled across the report, so the recorded
     CPU stays consistent with the per-CPU ring the report is queued to.

  3. `mm/damon/paddr: lock the folio for the page fault primitive rmap walk` --
     take the folio lock unconditionally around the walk, as the other reverse
     mapping walks in DAMON do, so every mapping type reaches it locked, and
     release the reference the lookup took on each exit path.

  4. `mm/damon: add damos_node_eligible_mem_bp tracepoint` -- a per-tick
     tracepoint over the node-eligible-memory quota goal evaluation, exposing
     the goal's target and current values, so the loop a bandwidth-driven
     controller steers is visible to a tracer.

  5. `mm/damon/core: add per-probe-class report rings and unified drain` -- the
     substrate.  Per-CPU SPSC rings an NMI-context source can publish into,
     partitioned by probe index into a global page-fault ring and a per-context
     perf ring, plus the kdamond-side drain that matches each report to a region
     by binary search over a per-target snapshot and credits it to that region's
     probe hits on the aggregation boundary.  The address space of the target
     selects which address of a report is matched, and pid targets are filtered
     by thread group id.

  6. `mm/damon: add perf-event overflow handler feeding the report ring` -- an
     ops-agnostic perf-event source whose overflow handler turns a PMU sample
     into a report, setting each address field the PMU reported as valid.  A PMU
     that reports a virtual address only can therefore drive a virtual-address
     context, one that reports a physical address a physical-address context, and
     the same source serves either without a backend per address space.  Per-CPU
     events are armed and released through cpuhp callbacks, and a per-PMU owner
     keeps two contexts from claiming the same PMU type.

  7. `mm/damon/ops-common: use probe-weighted score when probe weights are set`
     -- lets a scheme's frequency subscore come from the probe hits, weighted per
     probe class, so what the sampler reported reaches the tiering decision.
     With no weights set the subscore comes from the access rate as before.

  8. `mm/damon: add perf_event prep for PMU-driven hotness probes` -- the sysfs
     surface and the event lifecycle: a perf_event prep action carrying the PMU
     type, the event config and the sample attributes per probe, with per-CPU or
     single-instance arming depending on how many counters the PMU needs.
     Arming is deferred on a context built for a commit, so a weight-only commit
     leaves the running event untouched.

  9. `mm/damon/tests/drain-kunit: kunit for report rings and unified drain` --
     unit tests for the rings and the drain: inject and drain, overflow on wrap,
     producer routing by probe index, ring partitioning, pf-ring ownership,
     thread-group filtering, the address space match, and both primitives live
     on one context.

Patches 1-4 apply standalone on damon/next and are useful without the rest;
5-8 are the substrate and its first two consumers, and 9 covers them.  If the
first four read right, they need not wait on the rest of this series -- happy
to repost them on their own for damon/next if that is easier to take.  Two of
them, 2 and 3, correct code that is already in mm-new rather than adding
anything new, so they could instead go as a small fixes series carrying
Fixes: tags; guidance on which of the two routes is preferred is welcome.

## Userspace setup model

The runs were driven by an `auto_tier` subcommand added to damo on the branch
below, which reads achieved bandwidth from resctrl MBM and searches for the hot
set's distribution that maximises it, while the demotion scheme runs alongside
it in the same context.  That tooling is not part of this posting; it is on

  https://github.com/ravis-opensrc/damo/tree/damo/auto-tier-bw-2026-09-08

  - `--bw_source resctrl` is the option this adds: the controller reads achieved
    bandwidth from an MBM monitoring group and searches, rather than being given
    a distribution to install.
  - Everything else -- intervals, schemes, filters, the probe's `perf_event`
    attributes -- is what the generator writes from the command line shown: 5 ms
    sampling, 100 ms aggregation, a 1 s ops update.
  - Both configurations select proactive demotion, so they demote continuously
    rather than waiting for pressure, and both were left closed loop throughout.
  - The search is the algorithm described in [4].

### Configuration A: AMD IBS Op, paddr ops, system-wide

```
$ sudo mount -t resctrl resctrl /sys/fs/resctrl
$ sudo python3 tools/damon_tier_gen.py --hotness ibs \
        --near_node 0 --far_node 4 \
        --cold_demote --cold_demote_mode proactive \
        -o tier.yaml
$ sudo damo auto_tier tier.yaml --bw_source resctrl --verbose
```

  - Scope is the machine, not a process set.  The distribution is steered
    through `node_eligible_mem_bp` quota goals over each node's own physical
    ranges, which the generator reads from `/proc/iomem`.
  - AMD Turin, DRAM on node 0 and a CXL node.  IBS Op at a `sample_period` of
    262144 with `sample_phys_addr` set, which is what a physical-address context
    needs from the sample.
  - Workload is a hot-and-cold mix so both schemes have something to act on:
    `multiload` drives the bandwidth-hungry hot set, and a second process
    allocates on the near node, touches it once and goes idle, leaving pages
    that age out for the demotion scheme to find.

### Configuration B: Intel PEBS L3-miss, vaddr ops, per-PID

```
$ sudo mount -t resctrl resctrl /sys/fs/resctrl
$ sudo python3 tools/damon_tier_gen.py --hotness pebs \
        --pid $HOT_PID --pid $COLD_PID \
        --near_node 0 --far_node 1 \
        --cold_demote --cold_demote_mode proactive \
        --min_nr_regions 1000 --max_nr_regions 20000 \
        -o tier.yaml
$ sudo damo auto_tier tier.yaml --bw_source resctrl --verbose
```

  - Scope is the processes the monitoring group names and nothing else.  The
    distribution is steered through the hot scheme's `DamosDest` weights [9].
  - Intel Granite Rapids, DRAM on node 0 and CXL on node 1.  PEBS L3-miss at
    `sample_freq` 5003 with `precise_ip` 2.
  - Same workload shape.

## What the runs show

Per-node reference, each figure measured by binding the same workload to one
node:

```
  Granite Rapids, 64 threads x 8 GiB
    node 0   1.0 TB DRAM      DRAM only   269,885 MB/s
    node 1   2.0 TB CXL       CXL only    249,903 MB/s

  Turin, 32 threads x 4 GiB
    node 0   386 GB DRAM      DRAM only   113,596 MB/s
    node 4   1.0 TB CXL       CXL only     33,253 MB/s
```

  - The two machines differ in the way that matters: on the Turin the far node
    is 3.4x slower than the near one, on the Granite Rapids the two are within
    8%.
  - Each configuration gets one graph, the climb: the run itself, one mark per
    decision taken from the bandwidth just measured, with the share it moved to
    under each mark.  The settled line below it is the median over the samples
    the run went on to hold at that share.

### Configuration B, virtual-address mode

```
   MB/s                                                       climb
   460k |                                                          *
   440k |                                                      *
   420k |                                                  *
   400k |
   380k |                                             *
   360k |                                       *
   340k |                             *    *
   320k |                        *
   300k |              *    *
   280k |          *
   260k | *   *
         --------+------------+--------------+---------------+------------+--
                 1            4              7              10           13
                 92           80             68              56           44
                     decision index, near-node share (%)

   settled        share 44, 430,547 MB/s held
```

  - Thirteen decisions to settle at 44%, no target given: about 60% more than
    the better of the two nodes on its own, and the share does not change again
    over the 81 samples that follow.
  - Cold demotion runs over the same interval, in the same context, actuated by
    the same kdamond: 34 regions totalling 15.4 GiB applied, and the idle
    process ends with 4,099,980 pages -- 15.6 GiB -- on the CXL node having
    started on DRAM.
  - The promotion scheme's applied byte count is flat across the demotion ramp,
    291.1 GiB before against 291.3 GiB after, so the recovered capacity is the
    demotion scheme's.

### Configuration A, physical-address mode

```
   MB/s                                                   climb
   136k |
   134k |                                        *     *
   132k |                            *     *
   130k |                      *
   128k |
   126k |                *
   124k |
   122k |          *
   120k |
   118k |    *
        +----+-----+-----+-----+-----+-----+-----+-----+--
             1     2     3     4     5     6     7     8
             92    88    84    80    76    78    80    78
          decision index, near-node share (%)

   settled        share 78, 134,107 MB/s held
```

  - Eight decisions to settle at 78, from a start with almost everything on the
    near node: the same algorithm reaches the optimum share on its own from the
    bandwidth reading alone, and cold pages are demoted to the far node while it
    does so.
  - A distribution beats either end because both nodes supply at once: at the
    settled share the near node is supplying 104,618 MB/s against the 113,596 it
    reaches with the whole working set bound to it, so the further 37,669 MB/s
    arriving over CXL is bandwidth it could not have supplied at any share.
  - The idle process ends with 2,863,156 pages -- 10.9 GiB -- on the CXL node,
    out of the 32 GiB it allocated on DRAM and stopped touching.  Residency is
    the attributable figure in this mode rather than a per-scheme applied count,
    because the schemes share physical ranges.

### What the runs are meant to establish

Not the settled share and not the absolute bandwidth; those are properties of
these machines and these workloads.  What reproduces is:

  - A controller reading achieved bandwidth converges unattended, from a
    configuration naming no target, to a distribution that beats either node on
    its own, and holds it once found.
  - A demotion scheme recovers near-node capacity in the same context while that
    happens.
  - One code path does both, steering `node_eligible_mem_bp` over physical
    ranges system-wide on one machine and `DamosDest` weights over a named
    process group on the other.

## Beyond a CPU PMU

Nothing above is specific to PEBS or IBS.  A source qualifies if it can report
an accessed address to the ring, which is the only thing the substrate asks of
it.  A CXL device's Hotness Monitoring Unit, whose r3.2 perf driver has been
posted [7] exposing its hotlist through an AUX buffer, or a custom monitoring
unit on an accelerator or a memory expander, reports exactly that, and a
backend delivering those reports through a perf event reaches the same drain,
the same probe hits and the same schemes already in the tree.  Such a unit sees
the traffic that reaches its own device rather than a system-wide view, so what
it contributes is the hot set resident on that device: the tiering logic can
promote those pages to DRAM without the host having to detect that hotness
itself, and without depending on what produced the reports.  That posting names
driving tiering from such a unit as the intent and the in-kernel step as future
work, and consuming it as a DAMON access-check primitive was raised there as
one way to get it; a backend on this substrate is that path.

[1] v1 of this series
    https://lore.kernel.org/damon/20260529165640.820-1-ravis.opensrc@gmail.com/
[2] Roadmap for extending DAMON beyond pte-accessed bit
    https://lore.kernel.org/damon/20260525225208.1179-1-sj@kernel.org/
[3] mm/damon: introduce perf event based access check
    https://lore.kernel.org/damon/20260423004211.7037-1-akinobu.mita@gmail.com/
[4] B. Tabatabai, R. Jonnalagadda et al., "Bandwidth Speaks, We Listen:
    Dynamic Interleaving for Tiered Memory", ISMM 2026.
    https://dl.acm.org/doi/10.1145/3814942.3816137
[5] mm/damon/perf: add ARM SPE AUX backend
    https://lore.kernel.org/damon/20260816142222.689624-1-kunwu.chan@linux.dev/
[6] A platform-independent subsystem for bandwidth information, and resctrl
    as that source
    https://lore.kernel.org/linux-mm/d952a84f-332e-8f7a-4816-2c1cbd8f5b00@google.com/
[7] CXL Hotness Monitoring Unit perf driver
    https://lore.kernel.org/linux-mm/20241121101845.1815660-1-Jonathan.Cameron@huawei.com/
[8] mm/damon: add node_eligible_mem_bp goal metric, merged for v7.2
    https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
[9] mm/damon/vaddr: allow interleaving in migrate_{hot,cold} actions, merged
    for v6.17
    https://lore.kernel.org/linux-mm/20250709005952.17776-1-bijan311@gmail.com/

Ravi Jonnalagadda (9):
  mm/damon/vaddr: support page fault access check primitive
  mm/damon/core: read the CPU number with preemption disabled
  mm/damon/paddr: lock the folio for the page fault primitive rmap walk
  mm/damon: add damos_node_eligible_mem_bp tracepoint
  mm/damon/core: add per-probe-class report rings and unified drain
  mm/damon: add perf-event overflow handler feeding the report ring
  mm/damon/ops-common: use probe-weighted score when probe weights are
    set
  mm/damon: add perf_event prep for PMU-driven hotness probes
  mm/damon/tests/drain-kunit: kunit for report rings and unified drain

 include/linux/damon.h        |  136 ++++-
 include/trace/events/damon.h |   32 +
 mm/damon/Kconfig             |   18 +
 mm/damon/Makefile            |    1 +
 mm/damon/core.c              |  995 +++++++++++++++++++++++++++----
 mm/damon/ops-common.c        |   21 +-
 mm/damon/paddr.c             |   37 +-
 mm/damon/perf_source.c       |  489 +++++++++++++++
 mm/damon/perf_source.h       |   54 ++
 mm/damon/sysfs.c             |  266 ++++++++-
 mm/damon/tests/.kunitconfig  |    4 +
 mm/damon/tests/core-kunit.h  |    2 +-
 mm/damon/tests/drain-kunit.h | 1091 ++++++++++++++++++++++++++++++++++
 mm/damon/tests/perf-kunit.h  |  133 +++++
 mm/damon/vaddr.c             |   83 ++-
 15 files changed, 3220 insertions(+), 142 deletions(-)
 create mode 100644 mm/damon/perf_source.c
 create mode 100644 mm/damon/perf_source.h
 create mode 100644 mm/damon/tests/drain-kunit.h
 create mode 100644 mm/damon/tests/perf-kunit.h


base-commit: e1f34dce183a96fc93bf9a42dcdc0ec0bf82a3d2
-- 
2.43.0

