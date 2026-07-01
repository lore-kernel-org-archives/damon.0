Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A573330D34
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906446; cv=none; b=s/WrOV50Tz4PoIV0YRp0g5zLTSDPCM1twsezYIicDC9ekNp9g+5BG+SPAnoLGhgIbeZMxvhsZptp2YfP0B+XCdiCIl9lWnmXqWx48tUSUA0ZFPsK5co577HaFguaNEItshCVlloro1vHtEe60qRNS4sbhmnA+3vccnrAr5AzJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906446; c=relaxed/simple;
	bh=3z4rekmB/4GpNO3f8meBp2YCXnkPr3lYM0+cTijoYr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/ayCvgGf8fDU5KT9bCTm/6PTNxTiVBcPdhwJd301oIHY7mOCkXL+RfU5ItN4AlXfPL6S7cUIKzKajybnS1e8t0SEcO8FVw8dqT1Zy+r7fk1dr5zvX4XUbUwfKvnadORmAKDBXXozM2BcNQ6CpyXRa0cbzb2BPM2CnctPioJG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXPtWqSG; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXPtWqSG"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30edfd9cff9so632603eec.1
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906445; x=1783511245; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIUByjOvpuMIXwE7ycHcWkFtOVzaObJYqxXVUpWPPy0=;
        b=nXPtWqSGW+3vcTlc/IYk513x8oWFdtV0mLz7FihR9BtdxwCiEyTVrKt2ucLSrkwJqA
         xWyTtis68+V2LO2VG488nEiFkNyLL0avGYtMThzA1XTiV2uI9Rw43fzagwYCPV1qj6lL
         0zfriE9ws8BZKHk1JrOvx17egke1gtaDbvTdjELW19KM1W8BxZ4pLm/zOSVdw3wCCGti
         GRmqt2J4NY0pyJovQpIzw91dg4gi/rGaoQndB8Ee+uuO6x5a0WgkAWkeszQMDHAUfopf
         Y/csU3m+oQ6anvwLofgztyJz66DUj9A5QhDh1TijbwTgMeh247eV9iPg+rK1paSSpFil
         X5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906445; x=1783511245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIUByjOvpuMIXwE7ycHcWkFtOVzaObJYqxXVUpWPPy0=;
        b=YvxUYzF1jT1+lZRbmf+3jg4wtLUsplC5uuMhhSZVTQeRa5HNnYXMCczuTeNbhXeAjL
         EXjytPQhq3FvPLmMUGmXKncXauqI47PRAlpH9Ms82ZO0WNaZekNa5Dj10VSRfPHZgtD/
         xX5B2FC4kGZmnH5Zw50Pa9ZpnYRtcsarDAZCJkTCAd+OBYVe1sW4TraA+SA/sA82W5Ng
         Hf3HRYBTn5UXbQPgg1WmGBqQQpCWMrFxpo/PHe8D5Cew/xYDp+c4WAZi6rLGjKDJTQTo
         kQE/SX4Fr3yyabeXdB/x1Vp238WBp5m2yrQpcbggFtbqUvHr/lZI80MDf5bGiBlHcJ7g
         Wq/g==
X-Gm-Message-State: AOJu0Yy81rktPaFM2RJrZZIOVAjIUTUCUQtlYovFKEqJvw98DPXocY1q
	WC3ybjKKI9xh5Uo1dwCyWDX1IzJEIPnFMu8VfI5iBhCMcgA7/XRKiVSNOS5caf00
X-Gm-Gg: AfdE7cmEqk1b7Rq/OO/br6NzQjh0G9q/LBO+fhaKfJvKahO7mE4VMa8t2EphViFFoWe
	RZAkjZ/O2zThzoeV+fPVoDGF0OkxiQyu11PieuqvSZKTGN7a5JuGbGR9u2flWcs/Jiv0d2qTqvP
	DkG+Jof+kbeshh5UfVtGVdoAsf5hx1AxCupJowxrJFYMSRJ2UDfiyg8JpGzvq++XASOXo4ReCQH
	dPDr2YA8Ht0DJpBla4UGScGGkGotwM1KY5R2IOviKzAtxU3AJpJidAWsmrOxWhyjKkdxnGk3VW3
	GxS0PKglWyIec/v7IWBeyNtPXjcnMGfMcEefJ3V6tsm4wTkvdN4LK8jwrKUdtxFxdMYPrSeyOT9
	nhaOBluLUfDMFlX/RPWkqFkJf20mwFePdTE3uJEtuFD/vE8elZ5dFfAxt8I3iYZ8H6GvXOyFmk2
	Uow+JjNFvG2z3V
X-Received: by 2002:a05:7301:3d1b:b0:30c:ab4f:9ba4 with SMTP id 5a478bee46e88-30f0548b54bmr417068eec.44.1782906444364;
        Wed, 01 Jul 2026 04:47:24 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm22518169eec.31.2026.07.01.04.47.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:47:23 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Wed,  1 Jul 2026 19:47:11 +0800
Message-ID: <20260701114716.56503-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Lian <lianux.mm@gmail.com>

This series gives DAMOS two order-aware folio actions so that an
access-aware policy can manage memory at mTHP granularity: a
target_order field for the existing DAMOS_COLLAPSE, and a new
DAMOS_SPLIT action.  The kernel provides the mechanism; deciding
which specific address ranges to act on is left to user space and
expressed through the existing DAMOS address filter.

v1: https://lore.kernel.org/linux-mm/20260618094838.32805-1-lianux.mm@gmail.com/

Changes since v1

 - Rename DAMOS_MTHP_SPLIT -> DAMOS_SPLIT for naming consistency with
   the existing actions (per SJ's review).
 - Drop the per-scheme hot_threshold field.  Hotness policy does not
   belong in the kernel; target selection now lives in user space and
   is expressed to DAMOS via the address filter (per SJ's review).
 - Drop the v1 SPE debugfs patch entirely.  debugfs is not the right
   interface for a feature, and the SPE profiler belongs in user space
   (see "User-space target selection" below).  v2 is kernel mechanism
   only: 5 patches.
 - Decouple T1 (a lab observation) from T2 (the production issue), and
   correct the architecture claim: ptep_test_and_clear_young() skips
   the TLB flush on both x86_64 and arm64, so the blind spot is
   architecture-independent rather than arm64-only.
 - Terminology: avoid "stale TLB".  A valid TLB entry is doing its
   job; the point is only that it lets the CPU satisfy a translation
   without a page-table walk, so the Accessed bit cleared by DAMON is
   not re-set.

Background

Two effects degrade DAMON's PTE-Accessed-bit (AF) signal once THP is
in play.  Both are described here as motivation only; this series does
not change the AF monitoring path.

T2 -- PMD-granularity inflation (production issue)

A 2MB THP is tracked by a single PMD-level Accessed bit.  One access
to any 4KB sub-page sets the AF for the whole 2MB, so DAMON reports
the entire THP as hot and cannot distinguish a genuinely hot 2MB
region from a 2MB region with a single hot 4KB page.  Cold memory
hides inside "hot" THPs, and access-driven pageout/migration becomes
coarse.

This is the workload that drove the work: Sangfor's Kunpeng 920 KVM
hosts running Oracle.  ARM SPE sampling of that workload shows 94.6%
of THPs have fewer than 10% of their sub-pages actually accessed.

T1 -- TLB-reach blind spot (lab observation)

When the working set fits within L2 TLB reach (Kunpeng 920: 2048
entries x 2MB = 4GB), the CPU keeps hitting the TLB and never walks
the page table.  Because ptep_test_and_clear_young() does not flush
the TLB, valid TLB entries continue to satisfy translations and the
AF that DAMON cleared is never re-set, so DAMON sees nr_accesses=0 for
memory that is in fact hot, and no scheme triggers.  This reproduces
in the lab with small workloads; it is not something we have seen
reported from production, where working sets exceed TLB reach.

What this series adds

Rather than change AF monitoring, this series adds two order-aware
DAMOS actions so a policy layer can act at mTHP granularity:

 - DAMOS_COLLAPSE + target_order (patches 1-3): collapse small folios
   up to a chosen mTHP order.  Patch 1 adds the target_order field and
   its sysfs file; patch 2 exports a khugepaged helper
   (damon_collapse_folio_range()); patch 3 wires the vaddr handler.

 - DAMOS_SPLIT + target_order (patches 4-5): split large folios down
   to a chosen mTHP order via split_folio_to_order(), for both
   anonymous and file-backed (tmpfs/shmem) folios.

The two are complementary, not competing:

   THP=never  + DAMOS_COLLAPSE: start at 4KB, grow hot regions up.
   THP=always + DAMOS_SPLIT:    start at 2MB, shrink cold regions down.

This dual-path design aligns with ideas discussed with Asier
Gutierrez; we plan to unify our mTHP automation and evaluation
roadmaps under this standard DAMOS_SPLIT action.

A deployment can pick either baseline, or run both, and let DAMOS
manage the placement.  THP is still wanted for the hot working set
(fewer TLB misses, shallower walks); the goal is not "no THP" but
"THP where it is hot, small pages where it is cold."

User-space target selection

The decision of *which* regions to collapse or split is left to user
space and fed to DAMOS through the existing DAMOS address filter
(DAMOS_FILTER_TYPE_ADDR) -- the interface suggested during v1 review.
The kernel provides the mechanism; user space provides the policy,
consistent with the perf/BPF "kernel samples, user space decides"
model and with the DAMON-X direction.

Because the AF signal is unreliable at PMD granularity (T1/T2), the
scheme is run with min_nr_accesses=0 so it does not gate on access
count, and the address filter selects targets.  min_nr_accesses=0 is
also what unblocks the T1 case, where nr_accesses is pinned at 0.

Why not just turn khugepaged off?  You can, but khugepaged is global
and usually left enabled because other workloads rely on it; it cannot
be disabled per region.  DAMOS_COLLAPSE gives per-region,
access-pattern-driven collapse -- a more precise, targeted complement
to khugepaged's global scan, not a replacement for it.  To handle the
runtime race where khugepaged might aggressively re-collapse what
DAMOS_SPLIT just split, we are evaluating a precise VMA-level handshake
or back-off mechanism to prevent ping-pong effects in mixed
environments.

Two user-space data sources produce the candidate address ranges:

 1. ARM SPE (ARMv8.2+): perf record (SPE) -> per-2MB hot-fraction
    histogram -> PA->VA via /proc/<pid>/pagemap -> sparse-THP VA
    ranges.  SPE reads physical addresses from the CPU pipeline,
    bypassing the TLB and page tables, so it is immune to T1 and T2.

 2. smaps fallback (no SPE): scan /proc/<pid>/smaps for THP-backed
    VMAs and treat the 2MB-aligned ranges as split candidates.

The SPE profiler stays in user space deliberately: the SPE PMU is a
single-consumer resource, so a kernel consumer would lock out
user-space perf and tooling (x86 PEBS / AMD IBS have the same
property).  Keeping it in user space avoids that and keeps the metric
source pluggable, in line with DAMON-X.  This is why v2 drops the v1
SPE debugfs patch.

Testing

Tested on aarch64 with this series applied to 7.1.0-rc5, THP=always,
using a DAMOS_SPLIT scheme (target_order=2, min_nr_accesses=0) and a
single DAMOS address filter selecting one 2MB-aligned range:

 - Anonymous THP: the filter splits exactly that one THP --
   sz_applied=2MB and AnonHugePages drops by 2MB, the rest of the
   256MB mapping untouched.
 - File-backed THP (tmpfs/shmem mounted huge=always): the same setup
   splits exactly one 2MB shmem THP -- sz_applied=2MB and
   ShmemPmdMapped drops by 2MB.  This confirms split_folio_to_order()
   works for shmem folios (the KVM-guest-on-THP-tmpfs case).
 - The address filter is what bounds the action: sz_tried covers the
   whole ~2GB monitored region while sz_applied is exactly the 2MB the
   filter selected.
 - A smaps-based path (for hosts without SPE) enumerates THP-backed
   ranges and splits all THP in the target workload.
 - checkpatch clean on all 5 patches.

Wang Lian (5):
  mm/damon: add target_order field for DAMOS_COLLAPSE
  mm/khugepaged: add damon_collapse_folio_range() for external callers
  mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
  mm/damon: introduce DAMOS_SPLIT action
  mm/damon/vaddr: implement DAMOS_SPLIT handler

 include/linux/damon.h      |  10 ++++
 include/linux/khugepaged.h |   3 ++
 mm/damon/sysfs-schemes.c   |  57 ++++++++++++++++++++
 mm/damon/vaddr.c           | 106 +++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c            |  39 ++++++++++++++
 5 files changed, 215 insertions(+)


base-commit: 01a87376d94249407343653a63e8ecfbe4c79cda
--
2.50.1 (Apple Git-155)

