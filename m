Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3028CF75
	for <damon@lists.linux.dev>; Fri, 20 Jun 2025 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442769; cv=none; b=rXmumRyvSqXlj3dyOpq3r2YjBJt2luoWYoitfMsFywVp7ZbK1XihzGhQQVERX/5RanfyGhcURxFcfaSe1DJVeiI2f2f7UmdO7ojFTpjQ1v8PS5vspEGm7UAOeT4F5ycyqB2wXZ0f1eswveKKfkldMnxEJ8/Y7qIipIDIIEQl+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442769; c=relaxed/simple;
	bh=+wzHUMazOKnec+G9KyklcNWUhGvrOLpI/W4XEr61oKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUBO4dqCLC+Jnq14AbPcfj18gpmcm5rS+Y0Z24we41aaqqRwvPi8GCOWQ0sL/tLcXnVX5Sn5AiO4McWaKgnMAMYlur2hunPVqgoH/zu5rEz7R9CQ0sEArCbLq2kluZnNnCpY/X9LESr5G/bUUh0bRP+RmOAygZ+LmIitPo71Pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/NPwMyj; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/NPwMyj"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1831559276.0
        for <damon@lists.linux.dev>; Fri, 20 Jun 2025 11:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750442767; x=1751047567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThTQstncnZmUa26ZltlYLWyz+7Cb8KdI0EV0/HFtDbE=;
        b=A/NPwMyjHpsmvMIdq3B9fnk9zGHeZgR5eEVXhdXULIeXw6vdcP7GTPR6LU+fl+bMJZ
         0iRZufH4AZX509bx7bC5Qpn9xoUcFihdsV0TlZSvtk4fM9zV04HDihyXx+Rens0qljlV
         W8c2XWhWjT8QtdPqeLO0qNTqzBQA/rfHXodnVP1q5p8rlsX1i/2oQvOpayokGISMKmOv
         J4NkQo6Yn29FuJAyTpMicnPauH8+NGhhejZgdop68B2hS+dVB8BL5s5WMdXqE3YDzkwZ
         63dZDS3KBSbN3dpTB0F3qH/+k9l9gT9/BZDOnxsqlna4pwY/xaVsLDXYUJmlOOUmWUfT
         CGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442767; x=1751047567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThTQstncnZmUa26ZltlYLWyz+7Cb8KdI0EV0/HFtDbE=;
        b=EXuNxNrEK5a+KQN3SFwZnfIriCKaxsjgZhYMbObONfAQNdkHX7m2rHInMOOniN77Y6
         ZOqYAFryo84mJ22BrjGMktXSsu5/pxU9G1+DdDYikk2oQdnOUhjgXJVWGQkTkMOGqEFG
         zjhSwkwcZOxnWzYVnDof6b7j6hXuc6eeZB0k4uMmlQT7Mlx2CEon7tT1MMk8E1vXl3ie
         gm+6oohMMqhtw6l6C4749IvWt9f5b55SYW6Ifgpee9ptOXlw8EJshyjTigpW96Y6inHU
         qyKSzxetod7qZ1l/dW47HgCuxC9NJy2Ypj3q8cRc8ZPSNQ3L64dSwPGarDpa/SlhiTjK
         gEOw==
X-Gm-Message-State: AOJu0Yx3hQnDA3qTy+QzX7ewb6WsON8QFYlEMtgCYdNtXLoMfphnHszS
	SnrdiH3wXCuvf8TtqZ6V+QZRhv74P0Y+ExrPI0mnMam5qYLTl8tm4O/o2OTbDCOZj9c=
X-Gm-Gg: ASbGncsBXQonyBw/PxKP+wHnPeMfoC6z1aT+BLnZtGkLpGq0xkXRLBMoOIMFIx2sXMf
	8J/aVmlD1lLjmciagSZ60jhgFq8odTgCwKvLQPtypk2BXdmTSK6lDMq12Pe1g/Xd5/SOvmj68JP
	9En1z+QoyY4Sr4VOVddEF29icl2aX0TPiZRS6rWYHCcwPVxBF0uYYcVT8d93dAeScwFep0jINef
	m7jzQqXgNG2jkx+OUGawIqQa6aRgDo0wXcvYxWo7dA9JTeM6Bdq0uFCBmjPOOU/QHK0GXuCy1iw
	/VIqRAXB2YB2FAqxpv01Dk/cK9XBthMBojHTqOhGjzi66miy/sumY1ODPZgh/a5766kV5/iJWHe
	+kuOidg==
X-Google-Smtp-Source: AGHT+IGpzNTvUQe9mxEVIptHo4i/QXbhpfSOs71TRKNPlVJ7HkRTdPi5RFoc3K0VnlMA3ZySDgFsug==
X-Received: by 2002:a05:6902:1541:b0:e82:24b3:7ec3 with SMTP id 3f1490d57ef6-e842bcdf7fbmr4728707276.23.1750442766512;
        Fri, 20 Jun 2025 11:06:06 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:227e:8527:3def:3ad])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aaed6e4sm769304276.20.2025.06.20.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:06:06 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in migrate_{hot,cold} actions
Date: Fri, 20 Jun 2025 13:04:56 -0500
Message-ID: <20250620180458.5041-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

A recent patch set automatically sets the interleave weight for each node
according to the node's maximum bandwidth [1]. In another thread, the patch
set's author, Joshua Hahn, wondered if/how thes weights show be changed if
the bandwidth utilization of the system changes [2]

This patch set adds the mechanism for dynamically changing how application
data is interleaved across nodes while leaving the policy of what the
interleave weights should be to userspace. It does this by modifying the
migrate_{hot,cold} DAMOS actions to allow passing in a list of migration
targets to their target_nid parameter. When this is done, the
migrate_{hot,cold} actions will migrate pages between the specified nodes
using the global interleave weights found at
/sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionality
can be used to dynamically adjust how pages are interleaved by changing the
global weights. When only a single migration target is passed to
target_nid, the migrate_{hot,cold} actions will act the same as before.

There have been prior discussions about how changing the interleave weights
in response to the system's bandwidth utilization can be beneficial [2].
However, currently the interleave weights only are applied when data is
allocated. Migrating already allocated pages according to the dynamically
changing weights will better help balance the bandwidth utilization across
nodes.

As a toy example, imagine some application that uses 75% of the local
bandwidth. Assuming sufficient capacity, when running alone, we want to
keep that application's data in local memory. However, if a second
instance of that application begins, using the same amount of bandwidth,
it would be best to interleave the data of both processes to alleviate the
bandwidth pressure from the local node. Likewise, when one of the processes
ends, the data should be moves back to local memory.

We imagine there would be a userspace application that would monitor system
performance characteristics, such as bandwidth utilization or memory access
latency, and uses that information to tune the interleave weights. Others
seem to have come to a similar conclusion in previous discussions [3].
We are currently working on a userspace program that does this, but it is
not quite ready to be published yet.

We believe DAMON is the correct venue for the interleaving mechanism for a
few reasons. First, we noticed that we don't ahve to migrate all of the
application's pages to improve performance. we just need to migrate the
frequently accessed pages. DAMON's existing hotness traching is very useful
for this. Second, DAMON's quota system can be used to ensure we are not
using too much bandwidth for migrations. Finally, as Ying pointed out [4],
a complete solution must also handle when a memory node is at capacity. The
existing migrate_cold action can be used in conjunction with the
functionality added in this patch set to provide that complete solution.

Functionality Test
==================
Below is an example of this new functionality in use to confirm that these
patches behave as intended.
In this example, the user initially sets the interleave weights to
interleave the pages at a 1:1 ratio and start an application, alloc_data,
using those weights that allocates 1GB of data then sleeps. Afterwards, the
weights are changes to interleave pages at a 2:1 ratio. Using numastat, we
show that DAMON has migrated the application's data to match the new
interleave weights.
  $ # Show that the migrate_hot action is used with multiple targets
  $ cd /sys/kernel/mm/damon/admin/kdamonds/0
  $ sudo cat ./contexts/0/schemes/0/action
  migrate_hot
  $ sudo cat ./contexts/0/schemes/0/target_nid
  0-1
  $ # Initially interleave at a 1:1 ratio
  $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node0
  $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node1
  $ # Start alloc_data with the initial interleave ratio
  $ numactl -w 0,1 ~/alloc_data 1G &
  $ # Verify the initial allocation
  $ numastat -c -p alloc_data

  Per-node process memory usage (in MBs) for PID 12224 (alloc_data)
           Node 0 Node 1 Total
           ------ ------ -----
  Huge          0      0     0
  Heap          0      0     0
  Stack         0      0     0
  Private     514    514  1027
  -------  ------ ------ -----
  Total       514    514  1027
  $ # Start interleaving at a 2:1 ratio
  $ echo 2 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node0
  $ # Verify that DAMON has migrated data to match the new ratio
  $ numastat -c -p alloc_data

  Per-node process memory usage (in MBs) for PID 12224 (alloc_data)
           Node 0 Node 1 Total
           ------ ------ -----
  Huge          0      0     0
  Heap          0      0     0
  Stack         0      0     0
  Private     684    343  1027
  -------  ------ ------ -----
  Total       684    343  1027

Performance Test
================
Below is a simple example showing that interleaving application data using
these patches can improve application performance.
To do this, we run a bandwidth intensive embedding reduction application
[5]. This workload is useful for this test because it reports the time it
takes each iteration to run and reuses its buffers between allocation,
allowing us to clearly see the benefits of the migration.

We evaluate this a 128 core/256 thread AMD CPU, with 72 GB/s of local DDR
bandwidth and 26 GB/s of CXL memory.

Before we start the workload, the system bandwidth utilization is low, so
we start with interleave weights biased as much as possible to the local
node. When the workload begins, it saturates the local bandwidth, making
the page placement suboptimal. To alleviate this, we modify the interleave
weights, triggering DAMON to migrate the workload's data.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/0/
  $ sudo cat ./contexts/0/schemes/0/action
  migrate_hot
  $ sudo cat ./contexts/0/schemes/0/target_nid
  0-1
  $ echo 255 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node0
  $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node1
  $ <path>/eval_baseline -d amazon_All -c 255 -r 100
  <clip startup output>
  Eval Phase 3: Running Baseline...

  REPEAT # 0 Baseline Total time : 9043.24 ms
  REPEAT # 1 Baseline Total time : 7307.71 ms
  REPEAT # 2 Baseline Total time : 7301.4 ms
  REPEAT # 3 Baseline Total time : 7312.44 ms
  REPEAT # 4 Baseline Total time : 7282.43 ms
  # Interleave weights changed to 3:1
  REPEAT # 5 Baseline Total time : 6754.78 ms
  REPEAT # 6 Baseline Total time : 5322.38 ms
  REPEAT # 7 Baseline Total time : 5359.89 ms
  REPEAT # 8 Baseline Total time : 5346.14 ms
  REPEAT # 9 Baseline Total time : 5321.98 ms

Updating the interleave weights, and having DAMON migrate the workload
data according to the weights resulted in an approximately 25% speedup.

Questions for Reviewers
=======================
1. Are you happy with the changes to the DAMON sysfs interface?
2. Setting an interleave weight to 0 is currently not allowed. This makes
   sense when the weights are only used for allocation. Does it make sense
   to allow 0 weights now?

Patches Sequence
================
This first patch exposes get_il_weight() in ./mm/internal.h to let DAMON
access the interleave weights.
The second patch implements the interleaving mechanism in the
migrate_{hot/cold} actions.

Revision History
================
Changes from v1
(https://lore.kernel.org/linux-mm/20250612181330.31236-1-bijan311@gmail.com/)
- Reuse migrate_{hot,cold} actions instead of creating a new action
- Remove vaddr implementation
- Remove most of the use of mempolicy, instead duplicate the interleave
  logic and access interleave weights directly
- Write more about the use case in the cover letter
- Write about why DAMON was used for this in the cover letter
- Add correctness test to the cover letter
- Add performance test

[1] https://lore.kernel.org/linux-mm/20250520141236.2987309-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/
[3] https://lore.kernel.org/linux-mm/20250314151137.892379-1-joshua.hahnjy@gmail.com/
[4] https://lore.kernel.org/linux-mm/87frjfx6u4.fsf@DESKTOP-5N7EMDA/
[5] https://github.com/SNU-ARC/MERCI

Bijan Tabatabai (2):
  mm/mempolicy: Expose get_il_weight() to MM
  mm/damon/paddr: Allow multiple migrate targets

 include/linux/damon.h    |   8 +--
 mm/damon/core.c          |   9 ++--
 mm/damon/lru_sort.c      |   2 +-
 mm/damon/paddr.c         | 108 +++++++++++++++++++++++++++++++++++++--
 mm/damon/reclaim.c       |   2 +-
 mm/damon/sysfs-schemes.c |  14 +++--
 mm/internal.h            |   6 +++
 mm/mempolicy.c           |   2 +-
 samples/damon/mtier.c    |   6 ++-
 samples/damon/prcl.c     |   2 +-
 10 files changed, 138 insertions(+), 21 deletions(-)

-- 
2.43.5

