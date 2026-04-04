Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E22236F7
	for <damon@lists.linux.dev>; Sat,  4 Apr 2026 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265743; cv=none; b=sisS05HNRGo3QncjK9by/OflVhi9BT8qu80pOFi/dnwptaUVOWOjX5sgJqXCZ0culyrTFa+vJrCyiZQN5NaN21Wivp7AO07UKSjzwculs/lJs6g+lZ7973vtPL0J3imvzOXDlV7/a3hFB1fF/drWOjyKS/c4pvkZQC718nNIzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265743; c=relaxed/simple;
	bh=EL1Cvs/C4hlC49ffFecfKC9loTfQoPdIpNRLNU/vPFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sL/0G6lVWXcw0MuNIFIQsSV48OkotHSSCnQx2StFDXJDz6QuvgSM131hFbD0jJDir4UI+X6d+EFzuWQyI0VvLVVdZl3HbpoyplgZZvLRUQJ/+PaaKzGVsOrjnX7UT4Jo2UXKwSJAAC5kQCKUx+rPh8tDLeo9jX4ZMwxULe0c36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Idpw+n+r; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idpw+n+r"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-4042fe53946so943030fac.3
        for <damon@lists.linux.dev>; Fri, 03 Apr 2026 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775265741; x=1775870541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcK6sHgPs6gP5Y6uAT692eRrV9NjZEVTLIRYHBLXl5s=;
        b=Idpw+n+rbiMPaRvzfAqEf/SXRlsrXmOpLLNqdXyHPNDppaM0Z7Ke0x72WxLJ5iOeIO
         Ewo7/jFGAImI73B9VK3g8JIfAl+1nfAgaipS67S52jjPWmC3LoJ+OjGcDG1bTw8l0jGo
         GVivJWdbYan8nEzLmf4eM6NUP6v3z4ZRhtx3V65/d0qPcar6hiY4IFiHxhGsakLFsq0o
         3Dny1s8QKrFrqPda5ft3o1xGTPd4RbcO+8jWx1wYH4eLlrZWZMCJt7XaRpkWCYKqp/IM
         weBvrnM8Rb/5kzBx0d+Ai/oOIjf7laK4eFL7+NHd+OrOoV+aYM58q3NXKDGwAyqwYRlY
         SMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775265741; x=1775870541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcK6sHgPs6gP5Y6uAT692eRrV9NjZEVTLIRYHBLXl5s=;
        b=cGKN27gyjWSDpijRX0leJr85R/lbwOKiP6fi28m13mTyEGK15LDBN2coDgGbNGO1Q/
         8IGP8D6E4rU3yoz3vy9vDOXGpB7tBOf3sQ0KX0k8a/KthJCxLqhcXobw0hxQQ4JNBvRG
         6C6pYST2GGTTque/JMLHaZvub/tFmfizJjcPqJ9LZVRNKrP0VohYbZMOuhn2zB+x6Ptd
         rh7mLKVZZ9HXVUAUCC0x890rYrZ2bah+4WZg1y6exVAZT/0DJVUE8/CEXk9YY14hGTPQ
         U9i5RTHu3clomMPf/6N+iU8Dl571VnlIVbydbkUoQO1GRNe9X8AgY+78BHx+MDahn1kd
         0iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl2ecbhLRGtT3LKwtCT2Wyo9hNDcfFxByn6SVzli/vrmUy1pKSsmnZEm+EmYNh9572bnS78g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5I4I5x81NQl8b+qWIBrasTC28D4ZtxnQx+sC6gOi6BhZ6Bcbx
	R4aPRg+tHe9LES8ZY1moozQT5a2pVvqx7Pgoxkmjv/qy5NRSOMjLLDI=
X-Gm-Gg: AeBDies1Q5eG/Seuc/lWPZkOeq2m3il8F9gU0TQax3Yal0mskBP/o5HojamGb6Z8HO+
	SX293V40dkvKw9swacuLYfFiJww0JtKRx8CDRy9ads7MDgtBdBP9rEo6asfYqThTYal3l0COh3l
	A7KzSHdtGdnLgCWswmaIskG2pw1bzgwXFNotekszwtNxV9LnLeAeeygGw0ZhbYYter6/2z86YSo
	bI0MqxcstiebuduGA7A6jzrmTN8CvVdWQmztP94pswOrPbgIqlf+JW0Br687BB3VTuP/vGFUwz1
	TIWdBHGCNVnRUvXtcZIbcptGC+rDzzYeh1OC19+ycnMGt3J9YCDjI02yaZKev/1lwXsrD0Gn8uo
	cCuIr4oOIVG5rtldD9taqwhhORqDnw28rseOZoAFx9E7sTWl2r2jT/mSx5DLBs1BzjjDJ0jgD7c
	PTN7EhKV+EHfFlPFFgZJlflw==
X-Received: by 2002:a05:6870:1718:b0:41c:b780:93c with SMTP id 586e51a60fabf-4230fbedf40mr2606467fac.8.1775265741311;
        Fri, 03 Apr 2026 18:22:21 -0700 (PDT)
Received: from localhost ([108.147.99.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c8282sm6117376fac.13.2026.04.03.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 18:22:20 -0700 (PDT)
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
Subject: [PATCH v5 0/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Fri,  3 Apr 2026 18:22:14 -0700
Message-ID: <20260404012215.1539-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces two new DAMOS quota goal metrics for controlling
memory distribution in heterogeneous memory systems (e.g., DRAM and CXL
memory tiering) using physical address (PA) mode monitoring.

Changes since v4:
=================
https://lore.kernel.org/linux-mm/20260320190453.1430-1-ravis.opensrc@gmail.com/

- Fixed commit message description for DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP
  per review feedback
- Added clarifying comment for ops-common.h include (for damon_get_folio())
- Fixed build error when CONFIG_DAMON_PADDR is disabled by adding
  #ifdef CONFIG_DAMON_PADDR guards around functions using damon_get_folio()
- Dropped RFC tag per maintainer feedback

This patch is based on top of damon/next.

Background and Motivation
=========================

In heterogeneous memory systems, controlling memory distribution across
NUMA nodes is essential for performance optimization. This patch enables
system-wide page distribution with target-state goals such as "maintain
30% of scheme-eligible memory on CXL" using PA-mode DAMON schemes.

What These Metrics Measure
==========================

node_eligible_mem_bp:
    scheme_eligible_bytes_on_node / total_scheme_eligible_bytes * 10000

node_ineligible_mem_bp:
    (total - scheme_eligible_bytes_on_node) / total * 10000

These metrics are complementary: eligible_bp + ineligible_bp = 10000 bp.

Two-Scheme Setup for Hot Page Distribution
==========================================

For maintaining hot memory on DRAM (node 0) and CXL (node 1) in a 7:3
ratio:

    PUSH scheme: migrate_hot from node 0 -> node 1
      goal: node_ineligible_mem_bp, nid=0, target=3000
      "Move hot pages from DRAM to CXL if more than 70% of hot data is
       in DRAM"

    PULL scheme: migrate_hot from node 1 -> node 0
      goal: node_eligible_mem_bp, nid=0, target=7000
      "Move hot pages from CXL to DRAM if less than 70% of hot data is
       in DRAM"

The complementary goals create a feedback loop that converges to the
target distribution.

Testing Results
===============

Functionally tested on a two-node heterogeneous memory system with DRAM
(node 0) and CXL memory (node 1). A PUSH+PULL scheme configuration using
migrate_hot actions was used to reach a target hot memory ratio between
the two tiers. Testing used the TEMPORAL goal tuner available in
damon/next and mm-unstable.

With the TEMPORAL tuner, the system converges quickly to the target
distribution. The tuner drives esz to maximum when under goal and to
zero once the goal is met, forming a simple on/off feedback loop that
stabilizes at the desired ratio.

With the CONSIST tuner, the scheme still converges but more slowly, as
it migrates and then throttles itself based on quota feedback. The time
to reach the goal varies depending on workload intensity.

Note: These metrics work with both TEMPORAL and CONSIST goal tuners.

Ravi Jonnalagadda (1):
  mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal
    metrics

 include/linux/damon.h    |   6 ++
 mm/damon/core.c          | 186 ++++++++++++++++++++++++++++++++++++---
 mm/damon/sysfs-schemes.c |  12 +++
 3 files changed, 190 insertions(+), 14 deletions(-)


base-commit: 97eefd14af390e1921f1fc5507140025095634e0
-- 
2.43.0

