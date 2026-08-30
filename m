Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1A29B78D
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066851; cv=none; b=HpGJJEe2csUZrRI7QVLEWg/1w0jBKF9em0E1/CNM+LGGwQEgVff4YqzbQQcYgdht8lWSlhwE0VInihObQZ+/hToHVb0deKj5UNVjbA+HwiLzcCuD9gp8KN5pkcB+IrjN1NPYC510FU1iA/ZtLa6dr3PYd1FqtrmsTWH6NxgNGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066851; c=relaxed/simple;
	bh=YNpuLImCERzGNRsD2EeSDn0ZCfRe6qCilKGUFPh+X+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceJDHpEOT5BWR4Lk8pL2gvuMJAJQoAyusVkw1ROgFMa5xINn+0q7jeQ5uXdPvnKb+77LHLHuU7OHMN/5UWoGl78MU691AaLeFecZmvDwYOLQmrk+1dHaeCZX3CrrL26O+VeLFr8CpDUk/xyyixU6e7p44I5bPV+7lWTchMztxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=L3xUO2Xx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="L3xUO2Xx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso25817455ad.3
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066849; x=1788671649; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hnvYqsxNp8b49/rBowWqUXaz80+meTKicT7aB9r1cG0=;
        b=L3xUO2XxRzecm6Bn+A1EYQiCIs3S0sOSkXJayR2dghtpDkTalmHvURpKsirsfQm4GA
         v1oJ+8HiVpgm7+xEWWHMW88GlGwlHjQj3ABW9alpibC1WvLKxcPeZOtPgHH/TpmCq3b6
         WKydaSXLDyP2AsruflVCXaBkOwx6jm6R3uR6a2uwNq7ZJyf+L2U+skrmG62O+Q/MDYPQ
         2n9VoWCiTz9HqDgEVHIyDXi4fjMtk7GW1NGlXDrSrL52wBfoHxw0FwDgy0kPP7Gbj++g
         xn6/WTS05RJGZcv+DpWDr47qyvfguUEiHDHoVf/jU3UoyHCGjUC5ASO6LZuiQPNRKeRy
         unAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066849; x=1788671649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hnvYqsxNp8b49/rBowWqUXaz80+meTKicT7aB9r1cG0=;
        b=IJ4zxmlygMZNwJhfACyvHqlx3wmoA5YNMhEJsO6XFzgIJEhOJEtnCWML93g0+B2Bpm
         fepnfHeAsZyQGfSbWP3rOkisCp7y3+vnptJU8shJOduIiEjhEmYmgamwPO5ZRvJNvwEh
         BX75uGbDJGoYTyQbWU/J1EQYfqDnlaLmqSxVEeEoAC9EgeaEVmAIBjTUzW+1I/sozwE+
         tyMSAFqfOTf20DfjK8rN4Hme4Jxeqpc1HMcC4b3f97igdGFllajzuLnXNSURHR5XaDrH
         eK2Q9Vf6j/G2i6Q5axgXWGAWENl/9NUO2GC05iq2ouhv3h9xwaPRdEK7AXTsPNyFitN+
         gxig==
X-Forwarded-Encrypted: i=1; AKwUvBzSGh0JTnmqLrCzg9QkWw4mNzCRUwN1a3w81Uyxynh85yY/eMQta6/zp6xNj+i+ad72QeIDKA==@lists.linux.dev
X-Gm-Message-State: AFuF++lgm8HTj8/JPidhSasE5U7NecOHLr7faGNYXwwgC3faRxvei5XX
	pLu6BvbFzv6EaYtlynkGC0B3ALMYT14o2HnzmNouecB6hm201IcGZe18debHW+/IAoE=
X-Gm-Gg: AR+sD11B644AvpOWF8kXWVdUrGF/A9fjfd9KIfhP29Ea3g5QMrhE6Iu6ESbCmjUi16+
	KOYs+fLeRksphtescZVNSPliIb2vhhYpxfr2b9z7JaAARGeIXY2/sl0G31P4bDSyr+Eqr8eYwJ9
	KC2cNR6ERjgHM4yU18eCxYgUS5UF1pGW8tH9eLZudSHge1M+3dHjV6dB470DAJY1EhGM1N/NUCw
	9N0TGxBk+zbNl96TuD6SbIiENqYw//vYtVescIHzhSUIXIy1IXfGQ2o/c206euU8AtsrPMxAoGh
	fYzDiwfhLXr7SsUdEl0ZZ71muN9kP11jf/YxULiTrs+7OFa0ifpXa5XgcoU7M79xUC2XdGaDads
	8VW2RZrb2aE9RxXCo9k7dx76t9IGzMXZi4K3qi1PdOEgII65ZPmMMAmVcS4XwpbHmA0SdrAemmu
	/6s8fC4+lBqE2G1VdwYv01EDOuDjf7IclEaiPAfj9cyjtJqChrWfMxKWnwpnRNcVNJ7RjSNzyYF
	m0ol7Z6DEhdIXvvVOIqWv8r04tlNbP6y/U=
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2d74dca2281mr279592645ad.2.1788066849370;
        Sat, 29 Aug 2026 22:14:09 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:09 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 0/6] mm/damon: support access monitoring of hugetlb-backed memory
Date: Sat, 29 Aug 2026 22:14:01 -0700
Message-ID: <20260830051407.50008-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On virtualization hosts, most system memory is often backed by
hugetlbfs.  On our production hosts, for example, ~95% of RAM is 1 GiB
hugetlb pages backing guest memory.  DAMON's physical address space
monitoring cannot produce a useful access signal for such memory, for
two layered reasons.

First, it is blind to hugetlb folios.  Every access check starts at
damon_get_folio(), which rejects folios that are not on the LRU lists,
and hugetlb folios are managed outside of the LRU by design.  As a
result, all hugetlb-backed memory is silently reported as never
accessed.

Second, even once hugetlb folios are visible, access-bit-based sampling
under-reports hot memory.  DAMON deliberately clears accessed bits
without TLB flushes to keep the overhead low, so accesses served from
cached translations do not walk the page tables and never re-set the
bit.  With 1 GiB mappings, translations effectively never leave the
TLBs, pinning the observed access rate to the TLB-refill rate: a
saturating guest is indistinguishable from a nearly idle one.

Patches 1-3 address the visibility problem.  The first patch moves
damon_hugetlb_mkold() from vaddr to ops-common as a preparation.  The
second patch teaches the folio mkold/young rmap walkers to handle
hugetlb folios, aging the huge PTE and notifying secondary MMUs across
the whole huge page size; the secondary MMU notification is what
surfaces guest-side (e.g., KVM/EPT) accessed bits.  The third patch
adds damon_get_folio_incl_hugetlb() and uses it from the paddr
monitoring primitives only.  DAMOS action appliers such as
DAMON_RECLAIM and DAMON_LRU_SORT keep the LRU-only lookup and are
behaviorally unchanged.

Patches 4-6 address the intensity problem with a new default-off
monitoring context option, 'aging_flush'.  When set, access bit
clearing for monitoring uses the flushing primitives
(mmu_notifier_clear_flush_young() and TLB-flushing PTE/PMD/hugetlb
aging) so that the next access is guaranteed to re-set the accessed
bit.  The option is exposed via the DAMON sysfs interface (patch 5) and
as a DAMON_STAT module parameter (patch 6).  With the option unset, the
behavior is identical to before this series.

Evaluation on an Intel EPT host running a 944 GiB guest with an 842 GiB
in-guest memory workload (masim):

  configuration          estimated access rate    idle -> load
                         idle -> load (GB/s)      separation
  stock                  0.08 -> 0.21             none (guest memory
                                                  invisible)
  patches 1-3            1.70 -> 1.96             1.2x
  full series, flush on  1.21 -> 5.34             4.4x

With aging_flush set, the estimated hot footprint covers ~82% of the
actual working set size, compared to ~40% without flushing, where the
signal mostly reflects the ambient TLB-refill rate rather than guest
accesses.  kdamond CPU consumption stays approximately 0%, and the
worst-case flush overhead measured is below 0.1%, which is acceptable
for hosts that opt in.

Per Documentation/process/generated-content.rst, this series was
developed with the assistance of an AI coding assistant (Anthropic
Claude, via Claude Code).  The assistant helped draft the code and
changelogs, and performed the rebase of the series from its original
6.17-based development tree onto mm-new, including merge conflict
resolution against recent DAMON changes.  All changes were reviewed by
the human submitter, who takes full responsibility for the
contribution.

The series as posted here was regression-tested on its base commit
with a full x86_64 kernel build (no new W=1 warnings in mm/damon), the
DAMON kunit suite (41/41 passing) and the DAMON selftests (15/15
passing) on a kernel booted with virtme-ng.  Functional validation
(the evaluation above, ftrace verification that the flag switches the
notifier variants, and enable/disable stress testing) was performed by
the submitter on production-like hosts running the 6.17-based backport
of this series.

Krishna Iyer (6):
  mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
  mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap
    walkers
  mm/damon/paddr: support hugetlb folios in access monitoring
  mm/damon: support flush-assisted access bit clearing for monitoring
  mm/damon/sysfs: support aging_flush
  mm/damon/stat: support aging_flush

 include/linux/damon.h |   2 +
 mm/damon/core.c       |   2 +
 mm/damon/ops-common.c | 154 ++++++++++++++++++++++++++++++++++++------
 mm/damon/ops-common.h |  18 ++++-
 mm/damon/paddr.c      |  11 +--
 mm/damon/stat.c       |   6 ++
 mm/damon/sysfs.c      |  29 ++++++++
 mm/damon/vaddr.c      |  46 +++----------
 8 files changed, 203 insertions(+), 65 deletions(-)


base-commit: d2aad7fdcda7ae8a726926f2d6de7fe9e8ee7563
-- 
2.54.0

