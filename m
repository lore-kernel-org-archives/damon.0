Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109E257844
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970886; cv=none; b=JisD70Y6WkhucgHx4e26fM4ZEoQeq4v30jT37ClkDIb/07SsPgDuMfD7BJQmU9bJ0ELodCs3y9a3R0ylGddfDAo0I7V17eV15wxx9eCgjNMKOispjKsh8eGMuloEEiJzU7t9+EAIBew5RzdQHngwyAKPktnE/Vzblp54vZt6rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970886; c=relaxed/simple;
	bh=j6sR3p7YY7K9BGesnf/tn3Ehdt+jJ6/E2l1J1L+gNrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeV/m12k+9YKkNWzpl/csPlmdn1nsQ4EfxM5uzeYTfozs+xxpBQL8ZH7lrPjWzkvegWPRljeCsgYr9rla7o3Slx/O2vLkBkHRKvcn2VMS38j1we3CUkRtaFx7JffjKoIgPJ67N6Wd0IcyJIjQ7ln7qXW6VYZd7/oQKZPxJUux/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUySVydY; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUySVydY"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bf0b47d2f1so5142107b3.3
        for <damon@lists.linux.dev>; Sat, 16 May 2026 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970884; x=1779575684; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoDTElId9snFmrZZxli5uToWxxMW032UXdLJQhd0rGU=;
        b=VUySVydYjqzH/zQqbUju8R/APrWKUUBdpx9LltqvRvAeLj9MTalHz4GdCvemfw7n6K
         oPzDdBnbN9rLYeCBKwkeulZNKT0+EDXzNygLuuBQJWAxH+CAN8PiryBpxW1nl/XVwZU0
         Ldy1xKEA0C43sXi5dAepirfApFxyvDmCwcWJecWBLeaG0lYjlWx68VK/55BUfWEoiuFl
         cAaH7Z9KlHcVGbIeWoRElrVprc+MYt7FoJBrO/LBpcVHH9PRytkD62vLN+n23Fvxh6a4
         UDpn01fZmHDaRLToFuoVvCSfcnvgSlJsvRHy/TseCp6vjfQcQ8YJw1JkPOdj9Nq8FK1K
         9hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970884; x=1779575684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoDTElId9snFmrZZxli5uToWxxMW032UXdLJQhd0rGU=;
        b=qrIL0CFvobSQ688mXIsWWLJ6/o7GUMn/KJMRU1lMAv9YNp6ePmszEV497PvPtIXe13
         82C92uO20J1Uvp1zWGBnX55F0JQ1jGPINGTb8NhEut+k+pxTcmWt2MB/yZjkYsPcozxY
         NwJY/ID7F9W10Uj/jWEO3ZxwuSTJfXbpKE7FdaJksLwf5rfV8hpzh7tmORgEns6D/78R
         9TC3EfiFJoTSlzXuo/a+mHE6JSZ6oyoeVOvBRmt0Mg4HJSPffiM/nbu3rGcN3cKsTAzn
         kKWt2gSm7pwiwLbYD1fIrnN8nu1gSXgoIbtN8Vi3ASVkt9vWD/ObrRm1erIZ2A+rjQRf
         KZyA==
X-Forwarded-Encrypted: i=1; AFNElJ+Rv+r1OO3+fOVJdjwmiTnW4FMjx37svs/WjxXipWnRi1o+KlIOjoeuQ/k2sZsyce6ETJYDug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhLP4ThQP8DFH29mS1U5PEdnFOa+2MM0iTl3s7Tzis2d70YVBJ
	tKmrYhcz3UWEbZJlMdxOmbDzThdrkmR73Np720UORxb2n8Om0edjM0A=
X-Gm-Gg: Acq92OEMWfKwr9WS+3MoQsX5RPuuZo4mnzYm0Sa/s1eykz8A9kCNXiWPT+9t5MdM3eT
	eZhISWL2942DsSxMw/XUwfaQitRV1WZ1dd4dkaSmqLagVREwS4KsXD05FEumg7UajV7zoknWzFm
	JwuSVFK+Kq7c+OfXnj6Ph8Wof3ZHBUKIuiDeQJaXpRh5RbSoN9BVJw9h8mLs7lP2Z0qvx0VjgM+
	tQFJ7O23SQv1E+Tq888TlKUf6WHgvp6bztgLt67inX0wXoh8QWaWC8nHqgIkjduPLncVKlEDBkB
	FPNz6ZyCkEk1pR4BCqwlG659L7M0K8gEFSOx2tcBrRaReuwp7cz4+5hh0xHPcqFvyaD2l7/878r
	hClQgp4QJOeeSN0vtn75dY9tSoilyDmqksa6Y3LnMfnrHyzb8+DvzX1ar9BQRfxlqDqe9ZgWEqT
	WMztHyxjr6fcxH2WGO3wDeFOySAgiZ9Hiaz3m3pA7pSYQeyaYYjFPwRTzXhmBgjeoZuinZACBO5
	Y/Qfi+2Jj5h
X-Received: by 2002:a05:690c:10d:b0:7b2:513b:34d7 with SMTP id 00721157ae682-7c95b828730mr106431887b3.29.1778970883609;
        Sat, 16 May 2026 15:34:43 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18b056sm637927b3.46.2026.05.16.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:34:43 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
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
	bharata@amd.com
Subject: [RFC PATCH 0/7] mm/damon: hardware-sampled access reports + AMD IBS Op example
Date: Sat, 16 May 2026 15:34:25 -0700
Message-ID: <20260516223439.4033-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is an RFC, not for merge.  The series exercises and validates
damon_report_access() -- the consumer API SeongJae introduced in [1]
-- as a substrate for ingesting access reports from hardware-sampling
sources.  The series includes one worked-example backend, an AMD IBS
Op module (damon_ibs.ko), that runs on Zen 3+ silicon via the
existing perf event subsystem.

Combined with node_eligible_mem_bp [2], the recently-merged DAMOS goal
metric, the same DAMON interface composes naturally for two
operational regimes from one set of primitives:

  1. Traditional tiering -- promote hot pages to DRAM up to a target
     cap.
  2. System-wide bandwidth interleaving -- split hot pages between
     DRAM and CXL at an operator-chosen ratio, for workloads where
     placing some hot pages on CXL improves aggregate throughput.

Either regime composes with a separately-configured migrate_cold
scheme to pair bandwidth shaping with capacity expansion: the
hot-page schemes drive placement to meet the bandwidth target while
migrate_cold reclaims DRAM by demoting cold pages.

The demonstration in this RFC exercises different
target ratios of the same PULL+PUSH setup.


Why a hardware-source primitive complements existing primitives
===============================================================

DAMON's existing access-check primitives observe access through
software paths:

  - PTE-Accessed bit scanning samples Accessed bits and clears them
    periodically.  The hardware sets PTE-A on TLB miss, so already-
    resident TLB entries do not re-set the bit until they're evicted.
    For pages whose translations stay TLB-resident across DAMON's
    aggregation interval, nr_accesses reflects fewer accesses than
    the page actually serviced.  This is correct behaviour for the
    primitive -- it observes what the TLB-miss path observes.

  - Page-fault sampling (NUMA hint faults) requires unmapping pages
    to provoke the fault, then samples access on the fault path.
    For closed-loop schemes that drive migrate_hot from the same
    observations, the unmap and the migrate action interact.

Both primitives produce a view of hotness that converges to the
true distribution over the aggregation interval.  For systems where
the address space is small relative to the aggregation rate, this is
the right tool.  On large heterogeneous-memory systems with goal-
driven schemes asking the closed-loop tuner to converge on a target
distribution, a complementary lower-latency view of accesses can
tighten the loop -- reducing the time DAMON's nr_accesses takes to
reflect the workload's actual access distribution, which in turn
reduces ramp duration and oscillation amplitude during convergence
of goal-driven schemes.

A hardware-sampling primitive provides this complementary view:
hardware retirement records each access at its natural event rate,
with a physical address per sample, independent of TLB state and
independent of the unmap/fault path.

This RFC adds the substrate (damon_report_access) so any hardware
sampler -- IBS, PEBS, future CXL hotness monitoring units --
can feed access reports into the kdamond drain path and existing
DAMOS schemes.  The substrate is the contribution; the IBS backend
is one worked example proving it on broadly-available silicon today.


Demonstration
=============

The two-scheme PULL+PUSH setup from the node_eligible_mem_bp
introduction holds a target hot-memory ratio across DRAM and CXL.
With damon_ibs.ko feeding damon_report_access, we observe two
operational regimes:

Cold-start convergence -- workload starts at an even DRAM/CXL
distribution (numactl --interleave=DRAM,CXL), DAMON context starts
with the target ratio set at kdamond launch, schemes converge from
the initial distribution to the target distribution.

  +-----------+--------+----------+---------+
  | Target    | Mean   | Offset   | Stddev  |
  +-----------+--------+----------+---------+
  | 70% DRAM  | 69.73% |  -0.27pp |  0.70pp |
  | 30% DRAM  | 31.00% |  +1.00pp |  1.28pp |
  +-----------+--------+----------+---------+

Live target changes from a converged state -- kdamond context runs
continuously, target ratio updated via DAMOS commit_schemes_quota_goals
without kdamond teardown.

  +-----------+--------+----------+---------+
  | Target    | Mean   | Offset   | Stddev  |
  +-----------+--------+----------+---------+
  | 90% DRAM  | 89.74% |  -0.26pp |  0.64pp |
  | 85% DRAM  | 84.61% |  -0.39pp |  0.60pp |
  +-----------+--------+----------+---------+

In both regimes, convergence to target is quick, and the workload's
measured DRAM share then holds within 1.3 percentage points of
target with standard deviation under 1.3 percentage points, sustained
over runs of 15-30 minutes per target.

Hardware envelope: AMD EPYC dual-socket, CXL.mem on a separate NUMA
node, 32GB hot working set, two migrate_hot schemes with complementary
address filters, temporal quota tuner, 256-entry per-CPU report ring,
512 MiB per-scheme quota, 1s reset interval.


What's in this series
=====================

  Patch 1.  mm/damon/core: refcount ops owner module to prevent
            rmmod UAF
  Patch 2.  mm/damon/paddr: export damon_pa_* ops for IBS module
  Patch 3.  mm/damon/core: replace mutex-protected report buffer
            with per-CPU lockless ring
  Patch 4.  mm/damon/core: flat-array snapshot + bsearch in ring-
            drain loop
  Patch 5.  mm/damon: add sysfs binding and dispatch hookup for
            paddr_ibs operations
  Patch 6.  mm/damon/core: accept paddr_ibs in node_eligible_mem_bp
            ops check
  Patch 7.  mm/damon/damon_ibs: add AMD IBS-based access sampling
            backend

Patches 1, 3, and 4 are general infrastructure that benefits any
consumer of damon_report_access().  Patches 2, 5, 6, and 7 are the
worked-example backend (paddr_ibs ops, sysfs binding, IBS module).


Patches worth folding into damon/next
=====================================

Patches 1, 3, and 4 are not specific to IBS or to this RFC's
backend.  Each is preparatory infrastructure that any consumer of
damon_report_access() will need:

  - Patch 1 (refcount ops owner) -- any modular ops set, including
    out-of-tree backends, needs clean module unload to avoid UAF
    on damon_unregister_ops.
  - Patch 3 (per-CPU lockless ring) -- damon_report_access() cannot
    be called from NMI context with the current mutex-protected
    buffer.  Hardware samplers all need NMI-safe submission.
  - Patch 4 (flat-array snapshot + bsearch drain) -- the linear-
    scan drain is O(reports x regions) and exceeds the sample
    interval at high-CPU x large-region products.  Bsearch brings
    it to O(reports x log regions).

If these belong directly on damon/next as preparatory patches for
damon_report_access() rather than living inside an IBS-specific
track, we are happy to rebase and resend them that way.


Relation to prior and ongoing work
==================================

The IBS sampling pattern in patch 7 -- attr.config=0 to use IBS Op
default config, dc_phy_addr_valid filter, NMI-safe sample submission
-- is derived from concepts in Bharata B Rao's pghot RFC v5 [3].
The attribution header is in mm/damon/damon_ibs.c and the patch
carries a Suggested-by: trailer.

Bharata's pghot v7 [4] introduces a different IBS driver targeting
the new IBS Memory Profiler (IBS-MProf) facility, which Bharata
describes as a facility "that will be present in future AMD
processors" -- a separate IBS instance from the one this RFC's
backend uses. This version of driver based out of v5 [3] is an
example of how DAMON can be benefited from AMD IBS Hardware
source and validates importance of IBS information indepedently.
It is not meant to be merged in the current form.
@Bharata if you see a path where IBS samples can be consumed
by DAMON at some point, will be happy to collaborate.
 
Akinobu Mita's perf-event-based access-check RFC [5] explores a
configurable perf-event-driven access source for DAMON.  IBS has
vendor-specific MSR setup beyond what perf_event_attr alone
expresses (e.g. dc_phy_addr_valid filtering on the produced sample,
not on the perf attr), so the IBS path here appears complementary
to [5] -- operators choose based on whether their hardware sampler
fits stock perf or needs additional kernel-side setup.


Specific asks
=============

To SeongJae:

  1. Patches 1, 3, and 4 are infrastructure that benefits any consumer
     of damon_report_access(), not just the IBS backend in this RFC.
     Would these belong directly on damon/next as preparatory patches
     for damon_report_access(), rather than living inside an
     IBS-specific track?  Happy to rebase and resend them that way if
     you'd prefer that shape.  Tested-by: tags can come along.


Future work
===========

  - Longer-duration stability and broader workload coverage.


Test branch
===========

A single fetch reproduces the cover-letter measurements on top of
both this RFC and the companion DAMOS quota controller and paddr
migration walk fixes posted separately at [6]:

    git fetch https://github.com/ravis-opensrc/linux.git \
        damon/hw-hotness-rfc-v1-testing

The companion fixes are not required for this RFC to function, but
the closed-loop measurements above were collected on the testing
branch which has both applied.  The standalone series-only branches
are also available:

    git fetch https://github.com/ravis-opensrc/linux.git \
        damon/hw-hotness-rfc-v1
    git fetch https://github.com/ravis-opensrc/linux.git \
        damon/closed-loop-fixes-v1


Links
=====

  [1] [RFC PATCH v3 00/37] mm/damon: introduce per-CPUs/threads/
      write/read monitoring (SeongJae Park)
      https://lore.kernel.org/linux-mm/20251208062943.68824-1-sj@kernel.org/
      Patch 01 introduces damon_report_access(), the consumer API
      this RFC builds on.
  [2] mm/damon: add node_eligible_mem_bp goal metric
      https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
  [3] [RFC PATCH v5 00/10] mm: Hot page tracking and promotion
      infrastructure (Bharata B Rao)
      https://lore.kernel.org/linux-mm/20260129144043.231636-1-bharata@amd.com/
  [4] [PATCH v7 0/7] mm: Hot page tracking and promotion
      infrastructure (Bharata B Rao)
      https://lore.kernel.org/linux-mm/20260504060924.344313-1-bharata@amd.com/
  [5] [RFC PATCH v3 0/4] mm/damon: introduce perf event based access
      check (Akinobu Mita)
      https://lore.kernel.org/linux-mm/20260423004211.7037-1-akinobu.mita@gmail.com/
  [6] [PATCH 0/5] mm/damon: DAMOS quota controller and paddr
      migration walk fixes (Ravi Jonnalagadda)
      https://lore.kernel.org/linux-mm/20260516210357.2247-1-ravis.opensrc@gmail.com/

Ravi Jonnalagadda (7):
  mm/damon/core: refcount ops owner module to prevent rmmod UAF
  mm/damon/paddr: export damon_pa_* ops for IBS module
  mm/damon/core: replace mutex-protected report buffer with per-CPU
    lockless ring
  mm/damon/core: flat-array snapshot + bsearch in ring-drain loop
  mm/damon: add sysfs binding and dispatch hookup for paddr_ibs
    operations
  mm/damon/core: accept paddr_ibs in node_eligible_mem_bp ops check
  mm/damon/damon_ibs: add AMD IBS-based access sampling backend

 include/linux/damon.h       |  13 ++
 mm/damon/Kconfig            |  10 +
 mm/damon/Makefile           |   1 +
 mm/damon/core.c             | 341 +++++++++++++++++++++++++++------
 mm/damon/damon_ibs.c        | 369 ++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h       |  13 ++
 mm/damon/paddr.c            |  15 +-
 mm/damon/sysfs.c            |  12 +-
 mm/damon/tests/core-kunit.h |   2 +-
 9 files changed, 707 insertions(+), 69 deletions(-)
 create mode 100644 mm/damon/damon_ibs.c


base-commit: 606bfbf72120df4f406ef46971d48053706f6f75
-- 
2.43.0

