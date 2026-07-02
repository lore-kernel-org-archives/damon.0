Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBC3C5522
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985958; cv=none; b=IVjuVWgE1QzDEiHg19dVJapn8rRTaMVQ04IKUfxwvg93KEXLZOk7LGM076sxcCfFF9YVrx/ljVLjP2LU23Ryw9sMgiJZzs5EBMGpoNhtgvlyh2WtNCQFEKKVskt967U9K9L8pLwZER9MugJKKjL8l7LGSn22LEOmRhtqG8OZtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985958; c=relaxed/simple;
	bh=MbvBf88g8BO2k9Ds85PsaQ+Vbj4Bn1GBSeFE+tRT3f4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBqI9GqGY7U74UxZ1h4VCMDpEeE56oVVkZd3Vx9Qs0r64ASxoPTpJlm7S3gslzEgcL5tP5A/YtPXpqrRmtTpWd3SyEiktJU3/plbQ/WclDY/14HqdAVjjma/YjBXjhziVZjwxk8+we6TFY7Fh3AovXmOK9mrR9ucrw3c920HpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1JHV9n0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1JHV9n0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9cb97e178so20521395ad.3
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985956; x=1783590756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOCV2PLDeQJYp2duRX7Uctst3enScKkQZb2Ju0zKuMY=;
        b=X1JHV9n0GkLAdqH9GziL2FhdI/nl/XhA70uIG5WJMjUoPbMGh/CE8HAsRN3t8c/GIa
         w6dHIzVXkfmPaqRq6kcH7hO46glH/Ki8IIJIENnFjmsR3ZC9ePDubRt8GcJyxIaIY+r0
         8+Nm+Vxm9Oj2lqdsd30ldU1/VYho7o0nkuUAJs1fs/E2fLa3OHu7gfxnLvFJhhI0Ue9f
         A5rTi4TV/aannaTFFX1qORWJus0Ostnq3eB2rTSD0LtvteEQkBgw365b0JN1BaOYLWuf
         h4Ecae6Dxl6ruqFoBUe/rPycnnyFdfPedmHvg9o6e91UUxY118I1Q/n6tmxxw7tLQEm2
         n4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985956; x=1783590756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOCV2PLDeQJYp2duRX7Uctst3enScKkQZb2Ju0zKuMY=;
        b=I9IeYfu4uIQ9Divo7E3HSZ9P+KrJhPARGEBzWhtse6y23FNnlqaeEAI1lvvQjucvv+
         WZmF3BxO/TdAvdNECzqgz3OjVUnlW5yohIAMmfCAdNZaBRAQ8C2DWI2MddBaMSijyTau
         c5VnbbjPM/fEvZMTr+JMkUDoaEAUD9/HfIIKAxKQF+1LgL1UZGbIfqg6NzReHBQh7HgH
         pPZD3U7zYJZmaZgvvRnNL2FiwcVNsgQvMYvcmbzXgMcuylmxJz1bNo5T3uLd2Dzj9V1t
         9YiCz5kCeQMO4EiZDRw3VHibGINcZ1ZMxvsFfCsZDKXNeKRiTT8qYw1XyQtWwPko3FM7
         E2AQ==
X-Gm-Message-State: AOJu0Yy7q19mpK/oHtR2WWr/w+zJwQBtIZOVMFX4P8GlQu0R7KMEqF6d
	Wz4bsaYFXuiPVX833BiWJociI6Pg+EsHUbBPT6P2wEVCMlt+vzx6SgASoSggvU/8BAg=
X-Gm-Gg: AfdE7cktdF+ROU/1wG642N4dP5NFRR+i6Sd1+G2ACHIxx8HxRQ5aKu4+YSvK2c2UD1U
	tAWLO2JZaikZuEY6pwRbNBNiVs1T59O5sJRE8OYNbEHaWrjFNBbl1HygEyHgt4Y0aZrAG/3lTm2
	JU0rQ76p9G7liTLAs7G55pk4xySar8gh1K32xCqpM5IqYfICjhxsPCqYuzlJqdlqKLU2YRUoEgX
	MCsoSsUO7kaK/jaKgMXGdTL7+2obIem33F8gxdYvkCB07GnQX7C0MujVHyl0dwojy9btl9LJ/G7
	L8bvotAt9RosdkOSV4E3SRfNlmKzwXMhRN//IU7Owuh6sxZi5SUdxANexIUVTqTZnac599DYnMF
	FNn6kVhatN8IDayCr/yxaZg+Q0veJ4vYob8s/k+4z1Pr6gIL5fvbyQ7GYF0HTPMvsfd1IG3Nban
	aw7g==
X-Received: by 2002:a05:6300:6690:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3bff40c7ca8mr5567827637.23.1782985956042;
        Thu, 02 Jul 2026 02:52:36 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm8348869eec.13.2026.07.02.02.52.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:52:35 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Thu,  2 Jul 2026 17:52:22 +0800
Message-ID: <20260702095227.75866-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend of v2 with the RFC tag restored (v1 was RFC PATCH, so v2 should
be RFC PATCH v2).

This resend also includes fixes for issues identified during review of
the earlier mis-sent PATCH v2 thread: uninitialized memory, TOCTOU
races, BUILD_BUG guards, missing sysfs action name registration, and
stack allocation overflow.  The series has been re-tested on aarch64
(anonymous and file-backed THP split) and is checkpatch clean.

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

When the working set fits within L2 TLB reach (measured at 2048
entries x 2MB = 4GB on Kunpeng 920; no public data available), the
CPU satisfies translations entirely from the TLB,
preventing translation table walks.  Because
ptep_test_and_clear_young() does not flush
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

Test scripts and SPE-to-DAMON pipeline tools:
https://github.com/lianux-mm/damon_spe/tree/v2

Lian Wang (5):
  mm/damon: add target_order field for DAMOS_COLLAPSE
  mm/khugepaged: add damon_collapse_folio_range() for external callers
  mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
  mm/damon: introduce DAMOS_SPLIT action
  mm/damon/vaddr: implement DAMOS_SPLIT handler

 include/linux/damon.h      |  10 +++
 include/linux/khugepaged.h |   9 +++
 mm/damon/core.c            |   2 +
 mm/damon/sysfs-schemes.c   |  77 ++++++++++++++++++++++
 mm/damon/vaddr.c           | 128 +++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c            |  46 +++++++++++++
 6 files changed, 272 insertions(+)

--
2.50.1 (Apple Git-155)
