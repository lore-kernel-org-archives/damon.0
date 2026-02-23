Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6016F288
	for <damon@lists.linux.dev>; Mon, 23 Feb 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849971; cv=none; b=IlpIom4dkhhicYIsex9/u83oSJP2VgUboCdIRC4SmbVSqok4d5knH3UwM3tK4ozK8H0BVmjSwOVtR4ZtWRRzJHh4h+jlgiaan8Nl30i1t8pTgFGZiXC6cs6k3KIA0d/OzgrBTNJA7UsSe60SgzIvZgRvkGNcMWfALTldCQ02lpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849971; c=relaxed/simple;
	bh=/hjWTF7tNqiQ5Nwhak3xS55/6KhpCzuSKrhD8waOpgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0h+qJGRwqbh+yn+EiYMFe2sgL4OL80oM37yJ0RpYT0pYhgEAuO9FXf74WRG6nO7ORhRLcOvX1QJYRY8xArU9s8f2yKAVIKqTyGom00cYgzUw54QcC3+NJ+ueGkOCnEbspjIIyNrNKCdhtcGW8kCZdPcbbydlTSK+yuNiW8Ew8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDnxizBs; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDnxizBs"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-823210d1d8eso2331218b3a.1
        for <damon@lists.linux.dev>; Mon, 23 Feb 2026 04:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849968; x=1772454768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWeTUTocNncqBZlX9GEiXOVVLoIbjlo/yvE3a+/Ll3A=;
        b=aDnxizBsztYID3Iqf5wRrEFHi+dtwuXhv0GJnqEenQREVPK4MG+F0vznuIKIPC3QEo
         cKgXIXTnI6z8ZR6gwcbO9BEjR/SKcQHlZNdsgtqnfubn4x+VUWqy4CoafO1m+7n0/TIv
         HQTgf/2YC3d7oDTjZ4q2I+tzAk5NHFyS95Ed22Kmyf6qQoxO7afPOyD1DDQc64abWy9h
         dSPEwkAfh0Fl0VBAqHzj8m044rM5SXEQQ7gcgxJUF2YW89LoE0nMTk6w6v5hpYCw9/nM
         j6iu1ZmwuqiMxOtJA9TI+FMcl+zeKYgZI+Y5w++zgHFcAAW1s/kGsts7plivYJHAdUnN
         Xv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849968; x=1772454768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWeTUTocNncqBZlX9GEiXOVVLoIbjlo/yvE3a+/Ll3A=;
        b=eFhtD98otf4QKqwwXWKTVJAdPecN6nLVgLblmP5Y02nxqKChAckMlsYrOkN/QZ7d06
         /lrSeudGeUqulvDR2S8vvXewhMCSNwTASG5s2tGGqE4a8LPzo36UiG3iSVu1fl9f5mH5
         F9TEXQLeQ8wAxyf6K0kt+aqutG/Lmg1cNVa0xhyyHr+JuFlCkjtwcc/Vufbjg9wDrsKG
         W0dI7wOsOhUQ+K0BV/2itv+Ki3l72KHypHlJ7Mp/x2IxTLAm+aYxBYwOFTijg7KqyRm/
         G6kNoA83j80C6hGBwiYOZ8XAIG7yHtqKMpCYtcMxjuq/yjG3aBVpFbWb1r30y+9IYwcS
         Mepw==
X-Forwarded-Encrypted: i=1; AJvYcCXgNW5TG5m/OxuT4tksiFXCxhcCE6LYam2S19BZlklTSyQkcidba6PWeWiN/6ZeDWH9wYu+eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbK4T4XB2IAJmw4oF+wtbJLq9E/f6AwhZYtaKIRXadlkLIYh64
	2rvU3vyRe8giFaqqouSdn6+xgm0A/Triv1rm27mAsrM60EdcIzizjaA=
X-Gm-Gg: AZuq6aIjrX7/7Akx1iklg0H6n+KobwyXBd3aKtgcHtGLttgqX3op+gABsw2hpFz6JMu
	KSSKfNSDpcRKaQds+CIR2vs+6is0cg5ckwQWX2tIexfiFhNdMqf9qI4URn3emPg+/WzTa2oNM8s
	aPh9jxvAyCeA+L+xMfwMNyRl9D154ONGRh4mZyAGGNDy5GBze4llpKR01BrQXxfJrVKujm2A0Pq
	DMW3eIMie5z6tG0W5pgpYzLMAac26QkGxvbPnoEnNpeO/6y1+ns/gxSTLdlUjftldY42MJf1949
	kWqZFxZ1RzHRWHqo474wRM59/EPHwgFHVokdgdh+1iANJkh32HDcHZ1IVxUtY9zlK5DiRxlcTzc
	V2WfNushX5+PIYlOhBhb28Q+WzvCLzywTH/zTCIEVoT0q/lXXQg9axU25/NjEx0wkOcqJBKqoJ7
	u4h3VYMtwwfx2tugvvXlXsfLmRR3mX6k+Uxp1mrkWs1YUF3lAuOtjlIvI=
X-Received: by 2002:a05:6a21:6b12:b0:334:96ed:7a75 with SMTP id adf61e73a8af0-39545ed4a53mr7607282637.24.1771849968248;
        Mon, 23 Feb 2026 04:32:48 -0800 (PST)
Received: from LAPTOP-FDBL0TVI.localdomain ([49.37.157.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a73e1sm7454739a12.13.2026.02.23.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:32:47 -0800 (PST)
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
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH v3 0/4] mm/damon: Introduce node_eligible_mem_bp and node_ineligible_mem_bp Quota Goal Metrics
Date: Mon, 23 Feb 2026 12:32:28 +0000
Message-ID: <20260223123232.12851-1-ravis.opensrc@gmail.com>
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

This series introduces two new DAMON quota goal metrics for controlling
memory migration in heterogeneous memory systems (e.g., DRAM and CXL
memory tiering) using physical address (PA) mode monitoring.

v2: https://lore.kernel.org/linux-mm/20260129215814.1618-1-ravis.opensrc@gmail.com/

Changes since v2:
=================

- Split single metric into two complementary metrics:
  * node_eligible_mem_bp: hot memory present ON the specified node
  * node_ineligible_mem_bp: hot memory NOT on the specified node.
  This enables both PUSH and PULL schemes to work together.

- Added PA-mode detection lag compensation cache (see dedicated section
  below for design details).

- Added fix for esz=0 quota bypass that allowed unlimited migration when
  goal was achieved.

- Added fix for goal_tuner sysfs setting being ignored due to
  damon_new_scheme() always defaulting to CONSIST.

- Rebased on SJ's damon/next branch which includes the TEMPORAL goal
  tuner required for these metrics.

Background and Motivation
=========================

In heterogeneous memory systems, controlling hot memory distribution
across NUMA nodes is essential for performance optimization. This series
enables system wide hot page distribution with target-state goals like
"maintain 30% of hot memory on CXL" using PA-mode DAMON schemes.

Two-Scheme Setup for Hot Page Distribution
==========================================

For maintaining 30% of hot memory on CXL (node 1):

    PUSH scheme (DRAM->CXL): migrate_hot from node 0 -> node 1
      goal: node_eligible_mem_bp, nid=1, target=3000
      Activates when node 1 has less than 30% hot memory

    PULL scheme (CXL->DRAM): migrate_hot from node 1 -> node 0
      goal: node_ineligible_mem_bp, nid=1, target=7000
      Activates when node 1 has more than 30% hot memory

Both schemes use the TEMPORAL goal tuner which sets esz to maximum when
under goal and zero when achieved. Together they converge to equilibrium
at the target distribution.

What These Metrics Do
=====================

node_eligible_mem_bp measures:
    effective_hot_bytes_on_node / total_hot_bytes * 10000

node_ineligible_mem_bp measures:
    (total_hot_bytes - effective_hot_bytes_on_node) / total_hot_bytes * 10000

The metrics are complementary: eligible_bp + ineligible_bp = 10000 bp.

PA-Mode Detection Lag and Cache Design
======================================

In PA-mode, when pages are migrated:
1. Source node detection drops immediately (pages are gone)
2. Target node detection increases slowly (new addresses need sampling)

This asymmetry causes temporary underestimation of hot memory on the
target node. Without compensation, the system keeps migrating even after
reaching the goal.

The cache addresses this by remembering how much was recently migrated.
When calculating effective hot memory:
- Source node: reduce detected amount by recent migrations out
- Target node: boost detected amount by recent migrations in

The cache uses a rolling window to track migrations over time, and
expires after a configurable timeout (default 10s) when no migration
activity occurs. It also detects when its baseline becomes stale due
to new hot memory appearing in the workload.

Dependencies
============

This series is based on SJ's damon/next branch which includes:

- mm/damon/core: introduce damos_quota_goal_tuner [1]
- mm/damon/core: set quota-score histogram with core filters [2]
- mm/damon: always respect min_nr_regions from the beginning [3]
- mm/damon/core: disallow non-power of two min_region_sz [4]

[1] https://lore.kernel.org/linux-mm/20260212062314.69961-1-sj@kernel.org/
[2] https://lore.kernel.org/linux-mm/20260131194145.66286-1-sj@kernel.org/
[3] https://lore.kernel.org/linux-mm/20260217000400.69056-1-sj@kernel.org/
[4] https://lore.kernel.org/linux-mm/20260214214124.87689-1-sj@kernel.org/

Patch Organization
==================

1. mm/damon/sysfs: set goal_tuner after scheme creation
    - Fixes goal_tuner initialization order in sysfs scheme creation

2. mm/damon: fix esz=0 quota bypass allowing unlimited migration
    - Ensures esz=0 stops migration rather than bypassing quota entirely

3. mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
    - Adds the two complementary metrics for hot memory distribution control

4. mm/damon: add PA-mode cache for eligible memory detection lag
    - Implements rolling window cache to compensate for PA-mode detection lag
    - Adds configurable cache timeout via sysfs

Testing Status
==============

Functionally tested on a two-node heterogeneous memory system (DRAM + CXL)
with PUSH+PULL scheme configuration.

This is an RFC and feedback on the design is appreciated.

Ravi Jonnalagadda (4):
  mm/damon/sysfs: set goal_tuner after scheme creation
  mm/damon: fix esz=0 quota bypass allowing unlimited migration
  mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal
    metrics
  mm/damon: add PA-mode cache for eligible memory detection lag

 include/linux/damon.h    |  51 ++++
 mm/damon/core.c          | 496 +++++++++++++++++++++++++++++++++++++--
 mm/damon/sysfs-schemes.c |  43 ++++
 3 files changed, 576 insertions(+), 14 deletions(-)

-- 
2.43.0

