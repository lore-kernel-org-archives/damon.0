Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D51E49B
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284691; cv=none; b=WEPRhdzGSco6EtVPt26H3qt3wo0OM9cVqvwBPh54WG1YCsk0HoOdiCM440kNO6Ss5drQQuV+FVw1eZpHtnUFds/iF0IrwlKb295zJXn2z++ssiJqupYFjPOEhW71euIQ5bMQQ6JUtNFYaxPwzhPDQm3LTvUQC/OLMFX45+SCBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284691; c=relaxed/simple;
	bh=4Va/UHIqb06a4Q1i+zXF9Qp64VrtXgZrBj2YwS4hTwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAJIb6PZeCyUkB2Pwt228nZLbGzHbU6e9hBljPon9yPXr/dkXo7RS2o14I4UtbP5mFYXYFQToJ3u0CuaWliZ0jhoeI/no86TzFhnL+Ei6frJSvl1Cl6s6rz61jMNTnYNAnyGFmn89aBYCmaqwttlCNkEdeSBvHAy8tEsds3bk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-26-666af18b3643
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: [PATCH 0/8] DAMON based tiered memory management for CXL memory
Date: Thu, 13 Jun 2024 22:17:31 +0900
Message-ID: <20240613131741.513-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnkW73x6w0g1nblC0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6MnVPuMBVM72asuPdnJ3sD47PMLkZODgkBE4nvL3cwdTFygNn7f6aDhNkE1CSu
	vJwEFhYRsJKYtiO2i5GLg1lgDovExhcdjCA1wgIeEou+/WcCsVkEVCWefH/FDmLzCphK9M7f
	zgoxXlPi8fafUHFBiZMzn7CA2MwC8hLNW2czgwyVEHjNJvF1fSMLRIOkxMEVN1gmMPLOQtIz
	C0nPAkamVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiBQb2s9k/0DsZPF4IPMQpwMCrx8Ho8y0oT
	Yk0sK67MPcQowcGsJMI7ayFQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTU
	gtQimCwTB6dUA2Naie0JbcEirusb9+0KMV36feXT6wGH/s8L4zKN+HW7nMPm0IJKtsyudrHn
	oRPz/lpa+1zXL17+2m32feefIgq5BQskLly9tV10Hnf6++X6e87VL1t8j2+9f6Vh15OqG95/
	91vfeqUpNMeZfU/QiykpsrtTzDZdC1juZjA/+2Et80L5j/6RDMpKLMUZiYZazEXFiQDIXm+v
	ZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXCNUNLT7f7Y1aawaklwhYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbNF55PvjBaH555ktbi8aw6bxb01/1ktjqw/y2Kx+ewZZovF
	y9UsDl17zmqxr+MBk8Xhr2+YLH5vW8HmIOix9PQbNo+ds+6ye7Tsu8XusWlVJ5vHpk+T2D1O
	zPjN4vFi80xGj40f/7N7fLvt4bH4xQcmj8+b5AK4o7hsUlJzMstSi/TtErgydk65w1QwvZux
	4t6fnewNjM8yuxg5OCQETCT2/0zvYuTkYBNQk7jychITSFhEwEpi2o7YLkYuDmaBOSwSG190
	MILUCAt4SCz69p8JxGYRUJV48v0VO4jNK2Aq0Tt/OyuILSGgKfF4+0+ouKDEyZlPWEBsZgF5
	ieats5knMHLNQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmBIL6v9M3EH45fL
	7ocYBTgYlXh4PZ5lpQmxJpYVV+YeYpTgYFYS4Z21ECjEm5JYWZValB9fVJqTWnyIUZqDRUmc
	1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAWL3j7bqv/9+YF+5SkXE9KPbUXPFsKveW5X+UuDPW
	rdVsqHyRr79c5Z7r8T87hVfOF9236YH6rwlMyge+Mi//dtb04PJN0R0VeVIPedZPsc/dXqjF
	8PXwo6OvF8WwTODvnd7hKvx+14W5Vwzz169nVHzrv4Jn3uIJB/T33IhjXGQnY/fs2Nn6O1eV
	WIozEg21mIuKEwEdUBRoZQIAAA==
X-CFilter-Loop: Reflected

There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
posted at [1].

It says there is no implementation of the demote/promote DAMOS action
are made.  This patch series is about its implementation for physical
address space so that this scheme can be applied in system wide level.

Changes from RFC v4:
https://lore.kernel.org/20240512175447.75943-1-sj@kernel.org
  1. Add usage and design documents
  2. Rename alloc_demote_folio to alloc_migrate_folio
  3. Add evaluation results with "demotion_enabled" true
  4. Rebase based on v6.10-rc3

Changes from RFC v3:
https://lore.kernel.org/20240405060858.2818-1-honggyu.kim@sk.com
  0. updated from v3 and posted by SJ on behalf of Honggyu under his
     approval.
  1. Do not reuse damon_pa_pageout() and drop 'enum migration_mode'
  2. Drop vmstat change
  3. Drop unnecessary page reference check

Changes from RFC v2:
https://lore.kernel.org/20240226140555.1615-1-honggyu.kim@sk.com
  1. Rename DAMOS_{PROMOTE,DEMOTE} actions to DAMOS_MIGRATE_{HOT,COLD}.
  2. Create 'target_nid' to set the migration target node instead of
     depending on node distance based information.
  3. Instead of having page level access check in this patch series,
     delegate the job to a new DAMOS filter type YOUNG[2].
  4. Introduce vmstat counters "damon_migrate_{hot,cold}".
  5. Rebase from v6.7 to v6.8.

Changes from RFC:
https://lore.kernel.org/20240115045253.1775-1-honggyu.kim@sk.com
  1. Move most of implementation from mm/vmscan.c to mm/damon/paddr.c.
  2. Simplify some functions of vmscan.c and used in paddr.c, but need
     to be reviewed more in depth.
  3. Refactor most functions for common usage for both promote and
     demote actions and introduce an enum migration_mode for its control.
  4. Add "target_nid" sysfs knob for migration destination node for both
     promote and demote actions.
  5. Move DAMOS_PROMOTE before DAMOS_DEMOTE and move then even above
     DAMOS_STAT.

Introduction
============

With the advent of CXL/PCIe attached DRAM, which will be called simply
as CXL memory in this cover letter, some systems are becoming more
heterogeneous having memory systems with different latency and bandwidth
characteristics.  They are usually handled as different NUMA nodes in
separate memory tiers and CXL memory is used as slow tiers because of
its protocol overhead compared to local DRAM.

In this kind of systems, we need to be careful placing memory pages on
proper NUMA nodes based on the memory access frequency.  Otherwise, some
frequently accessed pages might reside on slow tiers and it makes
performance degradation unexpectedly.  Moreover, the memory access
patterns can be changed at runtime.

To handle this problem, we need a way to monitor the memory access
patterns and migrate pages based on their access temperature.  The
DAMON(Data Access MONitor) framework and its DAMOS(DAMON-based Operation
Schemes) can be useful features for monitoring and migrating pages.
DAMOS provides multiple actions based on DAMON monitoring results and it
can be used for proactive reclaim, which means swapping cold pages out
with DAMOS_PAGEOUT action, but it doesn't support migration actions such
as demotion and promotion between tiered memory nodes.

This series supports two new DAMOS actions; DAMOS_MIGRATE_HOT for
promotion from slow tiers and DAMOS_MIGRATE_COLD for demotion from fast
tiers.  This prevents hot pages from being stuck on slow tiers, which
makes performance degradation and cold pages can be proactively demoted
to slow tiers so that the system can increase the chance to allocate
more hot pages to fast tiers.

The DAMON provides various tuning knobs but we found that the proactive
demotion for cold pages is especially useful when the system is running
out of memory on its fast tier nodes.

Our evaluation result shows that it reduces the performance slowdown
compared to the default memory policy from 17~18% to 4~5% when the
system runs under high memory pressure on its fast tier DRAM nodes.

DAMON configuration
===================

The specific DAMON configuration doesn't have to be in the scope of this
patch series, but some rough idea is better to be shared to explain the
evaluation result.

The DAMON provides many knobs for fine tuning but its configuration file
is generated by HMSDK[3].  It includes gen_config.py script that
generates a json file with the full config of DAMON knobs and it creates
multiple kdamonds for each NUMA node when the DAMON is enabled so that
it can run hot/cold based migration for tiered memory.

Evaluation Workload
===================

The performance evaluation is done with redis[4], which is a widely used
in-memory database and the memory access patterns are generated via
YCSB[5].  We have measured two different workloads with zipfian and
latest distributions but their configs are slightly modified to make
memory usage higher and execution time longer for better evaluation.

The idea of evaluation using these migrate_{hot,cold} actions covers
system-wide memory management rather than partitioning hot/cold pages of
a single workload.  The default memory allocation policy creates pages
to the fast tier DRAM node first, then allocates newly created pages to
the slow tier CXL node when the DRAM node has insufficient free space.
Once the page allocation is done then those pages never move between
NUMA nodes.  It's not true when using numa balancing, but it is not the
scope of this DAMON based tiered memory management support.

If the working set of redis can be fit fully into the DRAM node, then
the redis will access the fast DRAM only.  Since the performance of DRAM
only is faster than partially accessing CXL memory in slow tiers, this
environment is not useful to evaluate this patch series.

To make pages of redis be distributed across fast DRAM node and slow
CXL node to evaluate our migrate_{hot,cold} actions, we pre-allocate
some cold memory externally using mmap and memset before launching
redis-server.  We assumed that there are enough amount of cold memory in
datacenters as TMO[6] and TPP[7] papers mentioned.

The evaluation sequence is as follows.

1. Turn on DAMON with DAMOS_MIGRATE_COLD action for DRAM node and
   DAMOS_MIGRATE_HOT action for CXL node.  It demotes cold pages on DRAM
   node and promotes hot pages on CXL node in a regular interval.
2. Allocate a huge block of cold memory by calling mmap and memset at
   the fast tier DRAM node, then make the process sleep to make the fast
   tier has insufficient space for redis-server.
3. Launch redis-server and load prebaked snapshot image, dump.rdb.  The
   redis-server consumes 52GB of anon pages and 33GB of file pages, but
   due to the cold memory allocated at 2, it fails allocating the entire
   memory of redis-server on the fast tier DRAM node so it partially
   allocates the remaining on the slow tier CXL node.  The ratio of
   DRAM:CXL depends on the size of the pre-allocated cold memory.
4. Run YCSB to make zipfian or latest distribution of memory accesses to
   redis-server, then measure its execution time when it's completed.
5. Repeat 4 over 50 times to measure the average execution time for each
   run.
6. Increase the cold memory size then repeat goes to 2.

For each test at 4 took about a minute so repeating it 50 times almost
took about 1 hour for each test with a specific cold memory from 440GB
to 500GB in 10GB increments for each evaluation.  So it took about more
than 10 hours for both zipfian and latest workloads to get the entire
evaluation results.  Repeating the same test set multiple times doesn't
show much difference so I think it might be enough to make the result
reliable.

Evaluation Results
==================

All the result values are normalized to DRAM-only execution time because
the workload cannot be faster than DRAM-only unless the workload hits
the peak bandwidth but our redis test doesn't go beyond the bandwidth
limit.

So the DRAM-only execution time is the ideal result without affected by
the gap between DRAM and CXL performance difference.  The NUMA node
environment is as follows.

  node0 - local DRAM, 512GB with a CPU socket (fast tier)
  node1 - disabled
  node2 - CXL DRAM, 96GB, no CPU attached (slow tier)

The following is the result of generating zipfian distribution to
redis-server and the numbers are averaged by 50 times of execution.

  1. YCSB zipfian distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  ====================+================================================+=========
                      |       cold memory occupied by mmap and memset  |
                      |   0G  440G  450G  460G  470G  480G  490G  500G |
  ====================+================================================+=========
  Execution time normalized to DRAM-only values                        | GEOMEAN
  --------------------+------------------------------------------------+---------
  DRAM-only           | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only            | 1.19     -     -     -     -     -     -     - | 1.19
  default             |    -  1.00  1.05  1.08  1.12  1.14  1.18  1.18 | 1.11
  DAMON tiered        |    -  1.03  1.03  1.03  1.03  1.03  1.07 *1.05 | 1.04
  DAMON lazy          |    -  1.04  1.03  1.04  1.05  1.06  1.06 *1.06 | 1.05
  ====================+================================================+=========
  CXL usage of redis-server in GB                                      | AVERAGE
  --------------------+------------------------------------------------+---------
  DRAM-only           |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only            | 51.4     -     -     -     -     -     -     - | 51.4
  default             |    -   0.6  10.6  20.5  30.5  40.5  47.6  50.4 | 28.7
  DAMON tiered        |    -   0.6   0.5   0.4   0.7   0.8   7.1   5.6 |  2.2
  DAMON lazy          |    -   0.5   3.0   4.5   5.4   6.4   9.4   9.1 |  5.5
  ====================+================================================+=========

Each test result is based on the exeuction environment as follows.

  DRAM-only:           redis-server uses only local DRAM memory.
  CXL-only:            redis-server uses only CXL memory.
  default:             default memory policy(MPOL_DEFAULT).
                       numa balancing disabled.
  DAMON tiered:        DAMON enabled with DAMOS_MIGRATE_COLD for DRAM
                       nodes and DAMOS_MIGRATE_HOT for CXL nodes.
  DAMON lazy:          same as DAMON tiered, but turn on DAMON just
                       before making memory access request via YCSB.
  DAMON tiered kswapd: same as DAMON tiered, but turn on
                       /sys/kernel/mm/numa/demotion_enabled to make
                       kswapd or direct reclaim does demotion.
  DAMON lazy kswapd:   same as DAMON lazy, but turn on
                       /sys/kernel/mm/numa/demotion_enabled to make
                       kswapd or direct reclaim does demotion.

The above result shows the "default" execution time goes up as the size
of cold memory is increased from 440G to 500G because the more cold
memory used, the more CXL memory is used for the target redis workload
and this makes the execution time increase.

However, "DAMON tiered" and other DAMON results show less slowdown
because the DAMOS_MIGRATE_COLD action at DRAM node proactively demotes
pre-allocated cold memory to CXL node and this free space at DRAM
increases more chance to allocate hot or warm pages of redis-server to
fast DRAM node.  Moreover, DAMOS_MIGRATE_HOT action at CXL node also
promotes hot pages of redis-server to DRAM node actively.

As a result, it makes more memory of redis-server stay in DRAM node
compared to "default" memory policy and this makes the performance
improvement.

Please note that the result numbers of "DAMON tiered" and "DAMON lazy"
at 500G are marked with * stars, which means their test results are
replaced with reproduced tests that didn't have OOM issue.

That was needed because sometimes the test processes get OOM when DRAM
has insufficient space.  The DAMOS_MIGRATE_HOT doesn't kick reclaim but
just gives up migration when there is not enough space at DRAM side.
The problem happens when there is competition between normal allocation
and migration and the migration is done before normal allocation, then
the completely unrelated normal allocation can trigger reclaim, which
incurs OOM.

Because of this issue, I have also tested more cases with
"demotion_enabled" flag enabled to make such reclaim doesn't trigger
OOM, but just demote reclaimed pages.  The following test results show
more tests with "kswapd" marked.

  2. YCSB zipfian distribution read only workload (with demotion_enabled true)
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  ====================+================================================+=========
                      |       cold memory occupied by mmap and memset  |
                      |   0G  440G  450G  460G  470G  480G  490G  500G |
  ====================+================================================+=========
  Execution time normalized to DRAM-only values                        | GEOMEAN
  --------------------+------------------------------------------------+---------
  DAMON tiered        |    -  1.03  1.03  1.03  1.03  1.03  1.07  1.05 | 1.04
  DAMON lazy          |    -  1.04  1.03  1.04  1.05  1.06  1.06  1.06 | 1.05
  DAMON tiered kswapd |    -  1.03  1.03  1.03  1.03  1.02  1.02  1.03 | 1.03
  DAMON lazy kswapd   |    -  1.04  1.04  1.04  1.03  1.05  1.04  1.05 | 1.04
  ====================+================================================+=========
  CXL usage of redis-server in GB                                      | AVERAGE
  --------------------+------------------------------------------------+---------
  DAMON tiered        |    -   0.6   0.5   0.4   0.7   0.8   7.1   5.6 |  2.2
  DAMON lazy          |    -   0.5   3.0   4.5   5.4   6.4   9.4   9.1 |  5.5
  DAMON tiered kswapd |    -   0.0   0.0   0.4   0.5   0.1   0.8   1.0 |  0.4
  DAMON lazy kswapd   |    -   4.2   4.6   5.3   1.7   6.8   8.1   5.8 |  5.2
  ====================+================================================+=========

Each test result is based on the exeuction environment as follows.

  DAMON tiered:        same as before
  DAMON lazy:          same as before
  DAMON tiered kswapd: same as DAMON tiered, but turn on
                       /sys/kernel/mm/numa/demotion_enabled to make
                       kswapd or direct reclaim does demotion.
  DAMON lazy kswapd:   same as DAMON lazy, but turn on
                       /sys/kernel/mm/numa/demotion_enabled to make
                       kswapd or direct reclaim does demotion.

The "DAMON tiered kswapd" and "DAMON lazy kswapd" didn't trigger OOM at
all unlike other tests because kswapd and direct reclaim from DRAM node
can demote reclaimed pages to CXL node independently from DAMON actions
and their results are slightly better than without having
"demotion_enabled".

In summary, the evaluation results show that DAMON memory management
with DAMOS_MIGRATE_{HOT,COLD} actions reduces the performance slowdown
compared to the "default" memory policy from 11% to 3~5% when the system
runs with high memory pressure on its fast tier DRAM nodes.

Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
tiered memory systems run more efficiently under high memory pressures.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org
[2] https://lore.kernel.org/damon/20240311204545.47097-1-sj@kernel.org
[3] https://github.com/skhynix/hmsdk
[4] https://github.com/redis/redis/tree/7.0.0
[5] https://github.com/brianfrankcooper/YCSB/tree/0.17.0
[6] https://dl.acm.org/doi/10.1145/3503222.3507731
[7] https://dl.acm.org/doi/10.1145/3582016.3582063

Honggyu Kim (6):
  mm: make alloc_demote_folio externally invokable for migration
  mm: rename alloc_demote_folio to alloc_migrate_folio
  mm/migrate: add MR_DAMON to migrate_reason
  mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
  Docs/admin-guide/mm/damon/usage: add missing actions
  Docs/.../mm/damon: add more damos actions

Hyeongtak Ji (2):
  mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
  mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion

 Documentation/admin-guide/mm/damon/usage.rst |  10 +-
 Documentation/mm/damon/design.rst            |   4 +
 include/linux/damon.h                        |  15 +-
 include/linux/migrate_mode.h                 |   1 +
 include/trace/events/migrate.h               |   3 +-
 mm/damon/core.c                              |   5 +-
 mm/damon/dbgfs.c                             |   2 +-
 mm/damon/lru_sort.c                          |   3 +-
 mm/damon/paddr.c                             | 157 +++++++++++++++++++
 mm/damon/reclaim.c                           |   3 +-
 mm/damon/sysfs-schemes.c                     |  35 ++++-
 mm/internal.h                                |   1 +
 mm/vmscan.c                                  |   5 +-
 13 files changed, 233 insertions(+), 11 deletions(-)


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.34.1

