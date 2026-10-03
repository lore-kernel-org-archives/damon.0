Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA53A4520
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061705; cv=none; b=n+tOFldJLFX2kK6pPB6ApxxA9IMo811hCjKBgINnQK1afRgYn3xtrGrWUSrWtrQuDk+sbFb2p0dmfdU7NtC8AgeqrdQuLwhJSYJsZfYOyqeZyj/XQInc9IPOZRE/Sbs4T4k0EhQih4XPnu7M1EOtEk7p7EJ5I0xYtwpKW8EmBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061705; c=relaxed/simple;
	bh=NRGrE5BQkrBF+Gl0garMkFyPdiM6XXGzbnIx4FY2ThE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mZmQWyjlOcSe6z624XJjtqFTO+DBDhhmj8nr68qhUPg4HBz2oXeL4HT61kW7JlSIAiWW6y/0T+X4tZN66N+nbCEpWuxmMMF2GY60Fl9I4NRslBQol+wCU/p3d3SJjZ0+w2JN8ARrOZMq5uN5sRy1uw996MorOwD7E7k1ASILwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV7qjCDa; arc=none smtp.client-ip=74.125.224.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV7qjCDa"
Received: by mail-yx2-f2.google.com with SMTP id 00721157ae682-8ab43af4c66so1399287b3.1
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061700; x=1791666500; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Yljy3xlleGUFXf6hA1NBpXi2tLXrrz5BAwY8xsFGAg=;
        b=DV7qjCDaSVFVKwddSA42hFNujM/NR0l0UD8Yv3z7HX9yEQAbMNp4FQDpPMhl7JtGIs
         8oFVwb8rL+2EfQKrmy51uMaU5h9Pi6WA08KQCA9MuBzWoU3KVYETfMWQW1xGJmyDEGs3
         RU4CORoFA6V0JMXj+xrQMQnUFBCkAMOamNAd47bzAYuwX5zIYJiB6Z4qZgQOftqExjfz
         u5lcxwnDcKPUJpKCXl/k+NaPAH+ITPdbfXhdHEvlKz2VDNWTRzp8Hh2DFMW94dwnbQc0
         c1uSXG5+4a34qhieWJHjFTYHVwZaz9KI6ttKAN63LxDA57+OcbOH2kPnli/ahVl0Cg5v
         3WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061700; x=1791666500;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Yljy3xlleGUFXf6hA1NBpXi2tLXrrz5BAwY8xsFGAg=;
        b=jmuWPeYR+bGc9s5EocjSTwuvdymrSyfDnd1ZG1kIalG/ILh+R7gOw6q1fzEhgGVmKq
         +5Rwb4OHtzfwr7TbLWhMBtgZLQ/ICnREJBr1qfv5V0L6cUVzRoRp1osmUuiSs+vEcUzZ
         M4Yvzu3UN82KcvP4GK4lI6ZBeo11kpngXf8g45d7mrl8diLpsF5v3jbWA34Pa7rzOnBt
         Xvxf5qoEmdVAYJ9oQg+grN/M9YTfvB1OLqlP2WpYTvJcx0Vi+KH7l0DzNCtdvgOBVRSa
         TkmyU7TPrV88x6gjitWnMSMcovi6hRKiD06cbHa9doTAsRdNqXZOELYSwH4zy9ZQ4D2S
         yX5g==
X-Gm-Message-State: AFq9FYLvtdqlo2a0vqq3cfbRGaaa0glUuGBdgx6fqAJ0GcF0rnIcPM1a
	D4Y9GMd+JA9B41+wEJ9OhRiFsqvZr9Fpw0j9KJBSRZS6A0svt8ej6yo=
X-Gm-Gg: AYBFou0B/M2qS2rkYb0plRzHGEDTJ6U9TQ530BAzdbogliQnsS94mlUiZ/hfpMF+DqC
	g70UtpRcglmLnlMQHWhY/i9w7kiVpAzRk3PlBPaqTjcTjXM+s5fMRuc0Pkd9mFZW0U+ukfXh7GK
	ZtLhTu88lsRREdZSfC0y6JmrkDCtIaKWlpVUWSOr7sGq9O1jNdgdD2NOe5AKxAyLqkUhAtuD7Cs
	MZLGYNKj2tTMxIUX37m31/m2FH+dLQBPfU1Mzn7YCwNzIyrXmC09nSTDbECXwmXv2WKULOqWk93
	HhYkwYJwdhd1FIomyDQA/MbD/5bqdxFDqn7uUNjyCpOmTQhmFFO2zXNb1J8CYAq59mnvdNa5M2N
	lYJoOzfiyS52+psDB9AScszHVXj4nV9gvfixiNmD7aHi3ChI8YC+m+nVyNtMsk5kQiVR+/Kd7Lw
	eRip4WCaK11xxRp5REgfpDl4X5emZg/9Xa28UwdP0ZJ+vszrs5sAIRppvXcPDSjCReaknWvWnvC
	7Pb8NnlBP0hn+pwQGPmJh15Rtbirz5wDqov+HgI6oBbM7Wq7IRR5qCrRuLDebntP87gaxn5xiTb
	wREWIm7mVIRlrfi2coMCwqeIhRKl3Moxtg==
X-Received: by 2002:a05:690c:6612:b0:8ab:3d74:dfd5 with SMTP id 00721157ae682-8ae392af16fmr27406827b3.12.1791061700271;
        Sat, 03 Oct 2026 14:08:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:19 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH v3 0/9] mm/damon: hardware-sampled access reports
Date: Sat, 03 Oct 2026 14:07:53 -0700
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNTQvCMBBE/0rZswtpU4R4k4J4FPEmHvKx0RWal
 kSLUPrfm9TjmxnmzZAoMiU4VDNEmjjxEDLIXQX2pcOTkF1maESzr4WQ6HQ/BBwpeoze4iQxUXB
 YeqwF5oVRrXa+VWSUgPwzRvL82xx3uJ66kl2Ot+4Mj3+bvuZN9lM0sCwrAmOfHZMAAAA=
X-Change-ID: 20261003-damon-perf-rfc-v3-send-2026-10-03-b94adf49eb90
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

This series lets DAMON take its access information from a hardware
sampler instead of from a page-table scan, and lets a scheme's score be
weighted by what that sampler reported.  Patches 3, 5, and 6 are
co-developed with Akinobu Mita, building on his earlier perf-event
proposal [3].

The scope has been narrowed from v2 [1] based on SJ's feedback; the
changes are described in the "Changes from v2" section below.  What
remains is the perf-event probe substrate and its consumers.

The sysfs surface has been reshaped against the milestone-1 probes/preps
interface [2] as committed in the v2 cover letter.  A perf-event probe
is configured through the probe's preps/N/ directory using the
perf_event prep action.  This is the first concrete implementation of a
hardware access source on the milestone-2 path SJ described in [2].

The series is based on damon/next at the base-commit below, which moves,
so the tree it was built and tested from is also on

  https://github.com/ravis-opensrc/linux/tree/damon/perf-rfc-v3-send-2026-10-03

It is posted as an RFC for design feedback on the substrate and on where
it belongs in the roadmap for extending DAMON beyond the pte-accessed
bit [2].  That roadmap's second milestone, now open, is a first data
attribute monitored through damon_report_access(), and that is what a
sampling PMU is here.  So this series keeps that function and its
callers and replaces its body: the reporting path a hardware sampler
needs cannot take a mutex, and the drain has to reach a virtual-address
context as well as a physical one.  The shape of the ring, the drain
and the sysfs surface are what is most useful to review.

The series is fully functional, builds cleanly, and passes all KUnit
tests and checkpatch.  If the approach and substrate read well, it could
be considered for merging into damon/next, either as a whole or starting
with independent patches (such as 1 and 8).

Why a unified perf-event substrate
==================================

DAMON derives its access information from the PTE Accessed bit.  A
sampling PMU carries what that bit cannot: which addresses the hardware
went to, and how often it went there.  Many machines already have such a
unit, and more than one kind of it, so what this series is after is
letting DAMON's regions be tuned from whichever perf-based hardware
source a machine offers rather than from the Accessed bit alone.  A
sampler does not arrive on a kdamond's terms, though: it delivers an
address when the hardware decides to, in NMI context, with no relation
to the sampling interval and no mm to walk.

The alternative is a backend per PMU vendor, each owning its own
configuration, sysfs knobs and lifecycle.  The perf-event direction [3]
avoids that: let DAMON register kernel-counter perf events and consume
samples from any sampling PMU the perf core already knows about.  This
series follows it, adding one substrate below the ops sets rather than
an ops set per PMU -- a report ring that any in-kernel access source can
push into, and a drain that folds those reports into region probe hits on
the aggregation boundary the kdamond already has.  What running it
across vendors needed on top of that direction is:

  - per-CPU lockless rings between the NMI sample handler and the
    kdamond drain, one set per context, so each context drains only the
    reports of the events it armed,
  - per-CPU events that follow CPU hotplug, armed when the kdamond
    starts and disarmed and drained when it stops,
  - a per-PMU owner, so two contexts cannot claim the same PMU type,
  - whichever address a PMU does report carried on the report and
    matched against the context's own address space, so one source
    serves a paddr or a vaddr context without a backend per address
    space.

This is tested with PEBS on Intel and IBS on AMD, both configured as
perf_event attributes on a probe and using the perf core's event
plumbing rather than per-vendor MSR code.  A third source has already
been written against the same ring: Kunwu Chan's ARM SPE backend [5],
which reaches it through an AUX buffer drained in process context
instead of an overflow callback, and which the roadmap [2] places in
its third milestone.

Scope of this series versus v2
==============================

v2 included two vaddr page-fault patches (patch 1 "vaddr: support page
fault access check primitive" and the vaddr half of the global ring)
which introduced the ability to run promotion and demotion in one
context using the fault primitive for cold-region aging alongside the
PMU for hot-region scoring.  This version removes that: the global
page-fault ring and the vaddr page-fault producer are gone, and what
remains is the PMU path alone.

The paddr page-fault producer was already present in the base tree
before v2 and is not in this series' scope.  It is removed in patch 1
because it is the only producer into the mutex-protected report buffer
that patch 2 replaces; shipping a producer whose buffer has been removed
would silently drop every report it sends.

The vaddr.c changes in v3 are limited to skipping the software prep and
apply paths for event-driven probes, which have no software preparation
action and receive their hits asynchronously through the ring drain.

What the series adds
====================

  1. mm/damon/paddr: remove page_fault access check primitive --
     removes damon_pa_prepare_access_checks_faults() and its helpers,
     and damon_report_page_fault() and its caller do_damon_page() in
     mm/memory.c.  Both predate this series; removed here because they
     are the only producer into the report buffer that patch 2 replaces.

  2. mm/damon/core: replace the access report buffer with per-context
     rings -- the substrate.  Per-CPU SPSC rings, one set per context,
     that an NMI-context source can publish into, replacing the global
     mutex-protected buffer, plus the kdamond-side drain that matches
     each report to a region by binary search over a per-target snapshot
     and credits it to that region's probe hits on the aggregation
     boundary.  The address space of the target selects which address of
     a report is matched, and pid targets are filtered by thread group
     id.

  3. mm/damon: add perf-event overflow handler feeding the report ring
     -- an ops-agnostic perf-event source whose overflow handler turns a
     PMU sample into a page-aligned report routed to the ring of the
     context that armed the event.  It sets each address field the PMU
     reported as valid, so a PMU that reports a virtual address only can
     drive a virtual-address context, one that reports a physical
     address a physical-address context, and the same source serves
     either without a backend per address space.  Per-CPU events are
     armed and released through cpuhp callbacks, and a per-PMU owner
     keeps two contexts from claiming the same PMU type.

  4. mm/damon/ops-common: use probe-weighted score when probe weights
     are set -- lets a scheme's frequency subscore come from the probe
     hits, weighted per probe, so what the sampler reported reaches the
     tiering decision.  With no weights set the subscore comes from
     the access rate as before.

  5. mm/damon: add perf_event prep type, core lifecycle, and PMU
     arm/disarm -- the sysfs surface and the event lifecycle: a
     perf_event prep action carrying the PMU type, the event config and
     the sample attributes per probe, with per-CPU or single-instance
     arming depending on how many counters the PMU needs.  Arming is
     deferred on a context built for a commit, so a weight-only commit
     leaves the running event untouched.

  6. mm/damon/sysfs: expose perf_event prep attributes -- wires the
     perf_event prep attributes through the DAMON sysfs interface,
     exposing type, config, config1, config2, sample_period, sample_freq,
     wakeup_events, precise_ip, sample_phys_addr, sample_weight_struct,
     exclude_kernel, and exclude_hv under the probe's preps/N/ directory.

  7. mm/damon/tests/drain-kunit: kunit for report rings and ring drain
     -- unit tests for the rings and the drain: inject and drain,
     overflow on wrap, a report without an owning context dropped,
     per-context isolation, probe-index crediting, thread-group
     filtering, the address-space match, and ring-full accounting.

  8. mm/damon/core: cap the region merge threshold per target -- on the
     regular merge pass, caps each target's threshold by its own maximum
     merge score rather than the context-wide one, so a high-traffic
     target cannot merge away the hot/cold boundary of a low-traffic
     target in the same context.  The passes that bring the region count
     under max_nr_regions keep the escalated threshold.

  9. mm/damon/core: allow both primitives disabled when a perf probe is
     present -- relaxes the validation that requires exactly one software
     primitive, so a context whose access information comes entirely
     from a perf-event probe can run with both page_table and page_fault
     disabled.

Patches 2-5 are the substrate; 6 is its sysfs surface; 7 covers them;
9 depends on the event-driven probes they add.  Patches 1 and 8 apply on
damon/next independently.  If patch 1 reads right and the approach of
removing the paddr producer is acceptable, it could be taken separately
for damon/next, and patch 8 could go on its own as well.

Changes from v2
===============

Following SJ's feedback on v2 [1]:

  - The page-fault primitive is out of scope.  The vaddr page-fault
    primitive, the global page-fault report ring and the partitioning of
    reports into probe classes are dropped; there is a single class of
    report ring, per context, fed only by perf-event probes.
  - The CPU-number and folio-lock fixes (v2 patches 2 and 3) are dropped
    with the page-fault path they belonged to.
  - The damos_node_eligible_mem_bp tracepoint (v2 patch 4) has been
    decoupled from this series and sent separately against mm-new:
      Message-ID: <20261003202727.3673-1-ravis.opensrc@gmail.com>
      Link: https://lore.kernel.org/all/20261003202727.3673-1-ravis.opensrc@gmail.com/
  - Per-CPU rings are kept, since the producer runs in NMI context.

One point differs from what was discussed for v3.  The v2 thread scoped
milestone 2 to physical addresses only, with the virtual-address parts
deferred to phase 3.  This version keeps virtual-address support, for
the following reason: the concern that made the page-fault path a poor
fit for milestone 2 is that it reaches into other mm code (the fault
handler and mprotect).  The virtual-address support here does not.  It
is confined to the DAMON report path: the overflow handler records the
virtual address the PMU reports, and the drain matches it against the
regions of the target whose thread group reported it.  Nothing outside
mm/damon/ changes for it.  It is also what makes a PMU that reports only
virtual addresses, such as Intel PEBS, usable at all, and what lets a
context scope tiering to a set of processes.  If milestone 2 should stay
physical-address only regardless, the vaddr handling can be taken out
without affecting the physical-address path, and I am happy to do that
in the next revision.

Patch 1 removes the paddr page-fault producer that is in damon/next.  It
is the only producer into the mutex-protected report buffer that patch 2
replaces, so leaving it would make it report into nothing.

Patches 8 and 9 are new.  Patch 8 fixes region merging when one context
monitors targets with very different traffic, which the combined
hot-and-cold runs below depend on.  Patch 9 lets a perf-event-only
context run with no software primitive enabled.

Build qualification
===================

Tested configuration enables CONFIG_DAMON_PERF_SOURCE and KUNIT;
excludes CONFIG_ACMA.  The pre-existing ACMA stubs in paddr.c compile
only under CONFIG_ACMA which is not required for the perf-event probe
feature.

MM_CP_DAMON flag (include/linux/mm.h) is now unused after this series;
consumers removed here.  Can be cleaned up separately or at maintainer
discretion.

Userspace setup model
=====================

The runs were driven by an auto_tier subcommand added to damo on the
branch below, which reads achieved bandwidth from resctrl MBM.  That
tooling is not part of this posting; it is on

  https://github.com/ravis-opensrc/damo/tree/damo/auto-tier-bw-2026-09-17

Configuration A: AMD IBS Op, paddr ops, system-wide
---------------------------------------------------

```
$ sudo mount -t resctrl resctrl /sys/fs/resctrl
$ sudo python3 tools/damon_tier_gen.py --hotness ibs \
        --near_node 0 --far_node 4 \
        --cold_demote --cold_demote_mode proactive \
        -o tier.yaml
$ sudo damo auto_tier tier.yaml --bw_source resctrl --verbose
```

  - Scope is the machine, not a process set.  The distribution is
    steered through node_eligible_mem_bp quota goals over each node's
    own physical ranges, which the generator reads from /proc/iomem.
  - AMD Turin, DRAM on node 0 and a CXL node.  IBS Op at a
    sample_period of 262144 with sample_phys_addr set.
  - damo detects convergence of each step in this mode from the
    damos_node_eligible_mem_bp tracepoint, which has been sent
    separately against mm-new (<20261003202727.3673-1-ravis.opensrc@gmail.com>)
    and is not part of this series.  The runs below were taken with it
    applied.  Without it damo falls back to a coarser check and still
    converges, but samples bandwidth less reliably.
  - Workload: multiload drives the hot set; a second process allocates
    on the near node, touches it once and goes idle, leaving pages that
    age out for the demotion scheme to find.

Configuration B: Intel PEBS L3-miss, vaddr ops, per-PID
-------------------------------------------------------

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

  - Scope is the named processes.  Distribution steered through the
    hot scheme's DamosDest weights [9].
  - Intel Granite Rapids, DRAM on node 0 and CXL on node 1.  PEBS
    L3-miss at sample_freq 5003 with precise_ip 2.
  - Same workload shape.

In v3 both configurations run without the page-fault primitive.
Cold demotion relies on probe-based aging: regions that receive no
perf-event samples across aggregation intervals accumulate zero probe
hits, and their nr_accesses decays to zero, making them eligible for the
demotion scheme on age.

  - `--bw_source resctrl` reads achieved bandwidth from an MBM
    monitoring group; `--verbose` logs each step.
  - Everything else -- intervals, schemes, filters, the probe's
    perf_event attributes -- is written by the generator from the
    command line shown: 5 ms sampling, 100 ms aggregation, 1 s ops
    update.
  - Both configurations select proactive demotion.
  - The search is the algorithm described in [4].

What the runs show
==================

Per-node reference, each figure measured by binding the same workload to
one node:

```
  Granite Rapids, 64 threads x 8 GiB
    node 0   1.0 TB DRAM      DRAM only   269,885 MB/s
    node 1   2.0 TB CXL       CXL only    249,903 MB/s

  Turin, 32 threads x 4 GiB
    node 0   386 GB DRAM      DRAM only   113,596 MB/s
    node 4   1.0 TB CXL       CXL only     33,253 MB/s
```

Configuration B, virtual-address mode (PEBS, hot spread only):
--------------------------------------------------------------

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
         --------+------------+--------------+---------------+----
                 1            4              7              10
                 92           80             68              56
                     decision index, near-node share (%)

   settled        share 46, ~455,000 MB/s held
```

  - Converges unattended from no given target to a distribution that
    beats either node on its own.

Configuration B, virtual-address mode (PEBS, cold demotion):
------------------------------------------------------------

  - Cold demotion from PEBS aging alone (no page-fault primitive):
    14,970 MB of the idle process's 32 GiB moved to the far node in
    600 s.  Regions that receive no samples across an aggregation
    interval accumulate zero probe hits, nr_accesses decays to zero, and
    the age-gated demotion scheme moves them.

Configuration A, physical-address mode (IBS, hot spread):
---------------------------------------------------------

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

  - Eight decisions to settle at 78%, from a start with almost
    everything on the near node.

Configuration A, physical-address mode (IBS, cold demotion):
------------------------------------------------------------

  - Cold demotion from IBS aging alone: with the idle process as the
    only workload, the demotion scheme moved 92% of its 32 GiB to the
    CXL node, almost all of it within the first minute.

What the runs establish
=======================

  - A controller reading achieved bandwidth converges unattended, from
    a configuration naming no target, to a distribution that beats
    either node on its own, and holds it once found.
  - Sampling-based aging (probe hits decaying to zero on unaccessed
    regions) identifies cold pages and a demotion scheme moves them,
    with PEBS and with IBS, without the page-fault primitive.
  - One code path does both, steering node_eligible_mem_bp over physical
    ranges system-wide on one machine and DamosDest weights over a named
    process group on the other.

Beyond a CPU PMU
================

Nothing above is specific to PEBS or IBS.  A source qualifies if it can
report an accessed address to the ring.  A CXL device's Hotness
Monitoring Unit [7] or a custom monitoring unit on an accelerator
reports exactly that, and a backend delivering those reports through a
perf event reaches the same drain, the same probe hits and the same
schemes already in the tree.

References
==========

[1] v2 of this series
    https://lore.kernel.org/linux-mm/20260910171623.6638-1-ravis.opensrc@gmail.com/
[2] Roadmap for extending DAMON beyond pte-accessed bit
    https://lore.kernel.org/damon/20260525225208.1179-1-sj@kernel.org/
[3] mm/damon: introduce perf event based access check
    https://lore.kernel.org/damon/20260423004211.7037-1-akinobu.mita@gmail.com/
[4] B. Tabatabai, R. Jonnalagadda et al., "Bandwidth Speaks, We Listen:
    Dynamic Interleaving for Tiered Memory", ISMM 2026.
    https://dl.acm.org/doi/10.1145/3814942.3816137
[5] mm/damon/perf: add ARM SPE AUX backend
    https://lore.kernel.org/damon/20260816142222.689624-1-kunwu.chan@linux.dev/
[6] A platform-independent subsystem for bandwidth information, and
    resctrl as that source
    https://lore.kernel.org/linux-mm/d952a84f-332e-8f7a-4816-2c1cbd8f5b00@google.com/
[7] CXL Hotness Monitoring Unit perf driver
    https://lore.kernel.org/linux-mm/20241121101845.1815660-1-Jonathan.Cameron@huawei.com/
[8] mm/damon: add node_eligible_mem_bp goal metric, merged for v7.2
    https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
[9] mm/damon/vaddr: allow interleaving in migrate_{hot,cold} actions,
    merged for v6.17
    https://lore.kernel.org/linux-mm/20250709005952.17776-1-bijan311@gmail.com/

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
Ravi Jonnalagadda (9):
      mm/damon/paddr: remove page_fault access check primitive
      mm/damon/core: replace the access report buffer with per-context rings
      mm/damon: add perf-event overflow handler feeding the report ring
      mm/damon/ops-common: use probe-weighted score when probe weights are set
      mm/damon: add perf_event prep type, core lifecycle, and PMU arm/disarm
      mm/damon/sysfs: expose perf_event prep attributes
      mm/damon/tests/drain-kunit: kunit for report rings and ring drain
      mm/damon/core: cap the region merge threshold per target
      mm/damon/core: allow both primitives disabled when a perf probe is present

 include/linux/damon.h        | 150 +++++++-
 mm/damon/Kconfig             |  19 +
 mm/damon/Makefile            |   1 +
 mm/damon/core.c              | 840 +++++++++++++++++++++++++++++++++++++------
 mm/damon/ops-common.c        |  21 +-
 mm/damon/paddr.c             |  76 +---
 mm/damon/perf_source.c       | 470 ++++++++++++++++++++++++
 mm/damon/perf_source.h       |  53 +++
 mm/damon/sysfs.c             | 283 ++++++++++++++-
 mm/damon/tests/.kunitconfig  |   4 +
 mm/damon/tests/core-kunit.h  |   2 +-
 mm/damon/tests/drain-kunit.h | 784 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/tests/perf-kunit.h  | 133 +++++++
 mm/damon/vaddr.c             |  18 +-
 mm/memory.c                  |  53 ---
 15 files changed, 2642 insertions(+), 265 deletions(-)
---
base-commit: 9f1c290342ea4f24dc1be639ff3055716f829376
change-id: 20261003-damon-perf-rfc-v3-send-2026-10-03-b94adf49eb90

Best regards,
--  
Ravi Jonnalagadda <ravis.opensrc@gmail.com>

