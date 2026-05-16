Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4060379EF7
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965444; cv=none; b=IKrHljiyClxJQKBBxJyNtnVkQDHYrDG0xFSNNpIU1BGvYxLE2Yn/mtEjcurpLfO2ud7NRBmBOCu0Lcq324BOmVxOH99132XegF79dNRM5l+wjw1L+I+XW43eIHdoWBdnPxV7luugkmvyjZ80MbkEsAZCzrlRMgDw/jcE3pd07hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965444; c=relaxed/simple;
	bh=JnBv0xQzTOMlPkAuQK4QJmqgQKl7ST4anVP64Y/xlXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGZdbHfLnQ66dsf/UPhc+bN3WVPcgubtHtnqVGe5DBzqUawzdo8UznAyehDUympbZHU+e+1iXb+zb2WVcX5HWezhdn3M5qD+IN2AZbjaKbS8IL2ioPAD00q6rwN+dXGMsmqHXYvVdabTUi2pAJqk7HaJ6K+nCMbb+ID/eqQOJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByuxPf3o; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByuxPf3o"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7bf0b1a47b1so5240797b3.0
        for <damon@lists.linux.dev>; Sat, 16 May 2026 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778965442; x=1779570242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yKlsY6+9+MZ7mU7SmEl9YWbtOg8xFpSDNXLhXZWgGQ=;
        b=ByuxPf3oUvxLHDH857+V3N5mUXZt9LLBv1GikuhomxsFdk70USYRtieo3QUNMOKxe+
         xHQFQYjpAIV0nQEFppVHrAfxUsdWUnwnr/cE/XiYr/lnH800IQr55N54icWqIhiSCaaR
         +65V5aVkh7e4T0k3BV7VEBMGYg6yNhSQIhicqoBCqWUdRokQbv7wbcGX1hziAqD1Wbj5
         dUt9bmoRPOPp0jOu8Lv5JwKYgWrU44rkvaH9quHW5V1m7DPPR0gGy1g00TtVDVhX6Jx6
         y1E8/pBmfJeHanWQJn6jCBtEURHp4KQhHPlL0dPS9kU+5A/KChOJfHhZP3njCjICqQZS
         DJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778965442; x=1779570242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yKlsY6+9+MZ7mU7SmEl9YWbtOg8xFpSDNXLhXZWgGQ=;
        b=V57PKVdIWFqAYFdJ62yJCK7a10VGQrSoTVYgBp6f7XObYLMVIa+BKg051KrhzEjzzA
         D3qTr/8SsHS5nSD6K3WeKJ1upY1pGU6DKBNZ5tsjsQBJ4LlkqH7q0AYiP5RuOtXM59lr
         Mw5mrmOeL35SUNY2bad8pIzo3TZgTBcTy/UwEq/QkY+yILbn6GtGfa9xc9aSMcihE7o8
         xIpfJHW67gBeCkunq1Z1azHQlouUWXByjtX3Dyy03ebGwy5BVzRAS3UooSbT9nv1ibbM
         bByjbyTIDTE6hYteP3DW94bIzYSF5rYHPn8z4H8S+8Rn0t83jU7FDXef58AgSWn+lDrD
         lP5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/n7MpgIiRuRv3/ywc/osqK1iir9YYENJhUo9t5rDiRr0YDvxjkRZzmNV97tRiUC36TSJ9i1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHu7z2ywMS82IbFWodZ6NuiAfF5sYO7+G2Dfky0pb2InUsvbXR
	OIs14TU8RZ3Ti3BxkYC3JUOf9xF4XS1oQrZrGw+ZEzvCsE2JYC8PlKU=
X-Gm-Gg: Acq92OGSgcgumyXpDktsez4zH4FNkU5fxwo9d5mKzpdBDLTShWEdV0ZifHJ1cXskIDv
	jDuLjhEysQm3hnyJrQo+IbqNi5Y8aicIvD55ibMuOELPcT3Qn3L90y8/MDiGB4MfArAAI3NNS8i
	/zBJzRbYhb5ZXqOA6SsDUVYMnrQdwRKFHwCZkV6ub/l5mnwkEIrpMUEwGdxhlDHA/oR6UVbkUsz
	AwAD7LEafiAoKvmDdNkQ+09DCr4h64V/9viWDlBdeJQXjXz7cTLiTvmrFbs5o7AuUxAjAp3hwCD
	vrQL4YyCGUx7lqVLnnQ3AZGT6T9s+/MGLaobc2G1NC5ZrPCCYaIjHkEOoJNe5mgHWSYkjybWS0G
	gEIdMgMLMbyQeK7mFDAU1BKS8R6oNrUaM/abkvy6GeBD6MKASiivelsWcCazQP6rLIML3kBjsOg
	YD4IeDZHQ38BUPfKqWkeri1F2MTqfJnwTGMG43nYn9fD2wqWb2VvjsI+D19L9pI3xnYEVQ94lSM
	jjlAknu5iZ7
X-Received: by 2002:a05:690c:6d84:b0:7bd:7b55:ebe1 with SMTP id 00721157ae682-7c959f80c19mr97174407b3.1.1778965441933;
        Sat, 16 May 2026 14:04:01 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f5e89bd4sm48605287b3.49.2026.05.16.14.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:04:01 -0700 (PDT)
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
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 0/5] mm/damon: DAMOS quota controller and paddr migration walk fixes
Date: Sat, 16 May 2026 14:03:52 -0700
Message-ID: <20260516210357.2247-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series carries five fixes for the DAMOS quota controller and the
paddr migration walk.  All five were surfaced during closed-loop tiering
testing on a heterogeneous-memory system (DRAM + CXL on a separate
NUMA node), but each fix is in code paths that benefit any caller --
not scoped to closed-loop tiering or to any specific goal metric.

Test envelope: AMD EPYC dual-socket host with CXL.mem on a separate
NUMA node, two-scheme migrate_hot PULL+PUSH setup driven by
node_eligible_mem_bp (now in linux-next)[1].

What each patch does
====================

Patch 1 - mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum

  damon_moving_sum() can underflow when a region's access rate drops
  to zero faster than the moving-sum window length.  The internal
  accumulator subtracts an outgoing sample without a lower bound,
  producing a sentinel-large nr_accesses_bp that mis-classifies a
  cold region as hot.  Affects every DAMOS scheme, since
  nr_accesses_bp is used on every access-rate update for every
  region regardless of which scheme or goal metric is active.

Patch 2 - mm/damon/core: cap effective quota size to total monitored memory

  The DAMOS quota tuner can compute an effective size (esz) larger
  than the total monitored memory, because the tuner integrates over
  cumulative deltas without bounding by the actual workload size.
  Once esz exceeds total monitored memory the per-tick "remaining
  quota" arithmetic stops being meaningful: any scheme can apply to
  the entire monitored space and "remaining" stays positive
  indefinitely.  Cap esz at total monitored memory so the controller
  remains within physically realisable bounds.  Tuner-shape and
  goal-metric agnostic.

Patch 3 - mm/damon/core: floor effective quota size at minimum region size

  Symmetric to patch 2: the tuner can also compute esz < min_region_sz,
  causing schemes to attempt zero-byte migrations for many ticks before
  the tuner ramps esz back up.  Observed under the CONSIST tuner with
  a node_eligible_mem_bp goal: ftrace traced esz stuck at 1 byte for
  96 seconds before the first region was tried; the first acted-on
  region appeared at t=113s when esz crossed the min_region_sz
  threshold.  Floor esz at min_region_sz so schemes always have at
  least one region's worth of quota when the tuner asks them to act.

Patch 4 - mm/damon/paddr: skip free pageblocks in migration walk

  damon_pa_migrate() walks every 4KB PFN in a region.  On
  sparsely-populated lower-tier extents (e.g., a 549GB CXL region
  with only ~8GB populated), this is ~144M PFN iterations per scheme
  tick at ~40ns each = ~5.6 seconds of walk per tick.  Use
  pageblock-level free-page detection to skip unpopulated runs of
  pages: only enter the per-page loop for pageblocks that contain at
  least one allocated page.  This brings the walk to
  O(region_size / pageblock_size) skip-check cost plus
  O(populated_pages) per-page work.  On x86 pageblocks are 2MB, so
  the same 549GB/8GB example becomes ~281K pageblock skip-checks
  (microseconds total) plus ~2M per-page visits for the populated
  pages -- ~80ms expected.  Helps any migrate_hot/migrate_cold scheme
  on paddr ops, regardless of what drives them.

Patch 5 - mm/damon/paddr: add time budget to migration page walk

  Densely populated regions (e.g., a busy DRAM range where most
  pageblocks contain at least one allocated page) can still consume
  full ticks even with patch 4 applied.  Add a 100ms wall-clock
  budget with a ktime_get() check every 4096 pages walked
  (~16MB worth).  When the budget expires before reaching the end of
  a region, kdamond returns control; subsequent ticks re-walk the
  region from the start.  Folios already on the target node are
  dropped at migration time, so re-walks only re-do collection work,
  not the migrate itself.  Together with the per-scheme quota cap,
  per-tick work is bounded and the workload converges over multiple
  ticks for dense regions.

  Worst-case migration walk contribution to a tick is bounded at
  100ms per scheme regardless of region size or population density,
  preserving kdamond's ability to service other DAMOS schemes and
  user-space sysfs operations during heavy migration phases.


Testing context
===============

  Hardware:  AMD EPYC dual-socket, CXL.mem on a separate NUMA node.
  Workload: 32GB hot working set across DRAM and CXL nodes.
  DAMON config: paddr ops, two migrate_hot schemes (PULL CXL->DRAM,
                PUSH DRAM->CXL) with complementary address filters,
                node_eligible_mem_bp goal per scheme, temporal
                quota tuner, 1s reset interval.

Each fix in this series was reproduced under the above setup, then
verified via ftrace and per-scheme stats after the fix landed.

References
==========

[1] mm/damon: add node_eligible_mem_bp goal metric
https://lore.kernel.org/damon/20260428030520.701-1-ravis.opensrc@gmail.com/

Ravi Jonnalagadda (5):
  mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum
  mm/damon/core: cap effective quota size to total monitored memory
  mm/damon/core: floor effective quota size at minimum region size
  mm/damon/paddr: skip free pageblocks in migration walk
  mm/damon/paddr: add time budget to migration page walk

 mm/damon/core.c  | 29 ++++++++++++++++++++++++++++-
 mm/damon/paddr.c | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 4 deletions(-)


base-commit: 0cec77cfd5314c0b3b03530abe1a4b32e991f639
-- 
2.43.0

