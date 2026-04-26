Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C820318EE7;
	Sun, 26 Apr 2026 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245391; cv=none; b=fFiAEYkkMbo/o0Ay+27j5UgoF6qktFgW1BCkrx7XF6TCqcyUGGGhOEhtj3O8zp3GLKnaT367uLyuok0Ega898gFqYPX884ARqLlDU5j3o+4Y2QQyyCy/9nIVRe+DwihUZhIolrRVUJGyE/UvqgZ0ntQAOT9iiFL0uZ7qLhfs8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245391; c=relaxed/simple;
	bh=9YE+I9oyMLDWrax5J73tcs4Z0G5Qgydawv3W19tJHVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPGruLfD+7GBno3MEOZVBBsmZESgb4FgelOocM4ShLQGyRU9Um3eK1EVAR1upHe+8Q+doEDCdtqqp9lTTI3fPiNDnIZMELCC5fp0mUfX5yewRQyKxQh1wHDRFVbE3UfAjbOKv9XQR0ZsWrfRvHR49n4jS5oFF31b0ht2si21tIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJkTEiD/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJkTEiD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCA3C2BCC4;
	Sun, 26 Apr 2026 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245391;
	bh=9YE+I9oyMLDWrax5J73tcs4Z0G5Qgydawv3W19tJHVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJkTEiD/MB1C5su+HVsYIpFroT51qwmn2v7M/Z9FUzT1hf6SaG5EXQtvx8A5bxZ+w
	 umc6cy9zI24KU3P3puw3N5yzNF8wRSTCHScWbK++HW6nj97+NY6VRpylIteWEGc9gY
	 NPbEPHZwKhd7C7kIHoiPnYcByKv/K1v1eetZmlc+o+hKACbVdikK/o3sH8B9XEsugC
	 NaeizqyLt18+2fruhFKreFRalXEVDPgj6vxNt+7gUEi/OuB1oeq1c5NJIhqk1E8hC8
	 tjaU9d7065VycLvnog/XZBdklfwiPly8kXpfFCy0u76eX5crJn6sKNHEhDJ/9n0X5z
	 9RfXBnjqhjwXA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/4] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Sun, 26 Apr 2026 16:16:17 -0700
Message-ID: <20260426231619.107231-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-1-sj@kernel.org>
References: <20260426231619.107231-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

This patch set introces a new action:  DAMOS_COLLAPSE.

For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
working, since it relies on hugepage_madvise to add a new slot. This
slot should be picked up by khugepaged and eventually collapse (or
not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
enabled, khugepaged will not be working, and therefore no collapse
will happen.

DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
the address range synchronously. In cases where there is a large VMA
(databases, for example), DAMOS_COLLAPSE allows us to collapse only
the hot region, and not the entire VMA.

This new action may be required to support autotuning with hugepage
as a goal[1].

=========
Benchmarks:
=========

MySQL
=====

Tests were performed in an ARM physical server with MariaDB 10.5 and
sysbench. Read only benchmark was perform with gaussian row hitting,
which follows a normal distribution.

T n, D h: THP set to never, DAMON action set to hugepage
T m, D h: THP set to madvise, DAMON action set to hugepage
T n, D c: THP set to never, DAMON action set to collapse

Memory consumption. Lower is better.

+------------------+----------+----------+----------+
|                  | T n, D h | T m, D h | T n, D c |
+------------------+----------+----------+----------+
| Total memory use | 2.13     | 2.20     | 2.20     |
| Huge pages       | 0        | 1.3      | 1.27     |
+------------------+----------+----------+----------+

Performance in TPS (Transactions Per Second). Higher is better.

T n, D h: 18225.58
T m, D h 18252.93
T n, D c: 18270.21

Performance counter

I got the number of L1 D/I TLB accesses and the number a D/I TLB
accesses that triggered a page walk. I divided the second by the
first to get the percentage of page walkes per TLB access. The
lower the better.

+---------------+--------------+--------------+--------------+
|               | T n, D h     | T m, D h     | T n, D c     |
+---------------+--------------+--------------+--------------+
| L1 DTLB       | 127248242753 | 125431020479 | 125327001821 |
| L1 ITLB       | 80332558619  | 79346759071  | 79298139590  |
| DTLB walk     | 75011087     | 52800418     | 55895794     |
| ITLB walk     | 71577076     | 71505137     | 67262140     |
| DTLB % misses | 0.058948623  | 0.042095183  | 0.044599961  |
| ITLB % misses | 0.089100954  | 0.090117275  | 0.084821839  |
+---------------+--------------+--------------+--------------+

Masim
=====

I used masim with the "demo" configuration, but changing the times
to 100 seconds for the initial phase and 50 seconds for the rest of
the phases.

Memory consumption:

+------------------+----------+----------+----------+
|                  | T n, D h | T m, D h | T n, D c |
+------------------+----------+----------+----------+
| Total memory use | 2.38 GB  | 2.36 GB  | 2.37 GB  |
| Huge pages       | 0        | 190 MB   | 188 MB   |
+------------------+----------+----------+----------+

Performance:

THP never, DAMOS_HUGEPAGE
initial phase:                40,491 accesses/msec, 100001 msecs run
low phase 0:                  39,658 accesses/msec, 50002 msecs run
high phase 0:                 41,678 accesses/msec, 50000 msecs run
low phase 1:                  39,625 accesses/msec, 50003 msecs run
high phase 1:                 41,658 accesses/msec, 50002 msecs run
low phase 2:                  39,642 accesses/msec, 50002 msecs run
high phase 2:                 41,640 accesses/msec, 50001 msecs run

THP madvise, DAMOS_HUGEPAGE
initial phase:                51,977 accesses/msec, 100000 msecs run
low phase 0:                  86,953 accesses/msec, 50000 msecs run
high phase 0:                 94,812 accesses/msec, 50000 msecs run
low phase 1:                 101,017 accesses/msec, 50000 msecs run
high phase 1:                 94,841 accesses/msec, 50000 msecs run
low phase 2:                 100,993 accesses/msec, 50000 msecs run
high phase 2:                 94,791 accesses/msec, 50001 msecs run

THP never, DAMOS_COLLAPSE
initial phase:                93,678 accesses/msec, 100001 msecs run
low phase 0:                 101,475 accesses/msec, 50000 msecs run
high phase 0:                 98,589 accesses/msec, 50000 msecs run
low phase 1:                 101,531 accesses/msec, 50001 msecs run
high phase 1:                 98,506 accesses/msec, 50001 msecs run
low phase 2:                 101,458 accesses/msec, 50001 msecs run
high phase 2:                 98,555 accesses/msec, 50000 msecs run

Memory consumption dynamic (how quickly collapses occur):

It shows in seconds how many huge pages are allocated.

+----+----------+----------+
|    | T m, D h | T n, D c |
+----+----------+----------+
| 5  | 32       | 188      |
| 10 | 48       | 188      |
| 15 | 64       | 188      |
| 20 | 96       | 188      |
| 30 | 112      | 188      |
| 35 | 144      | 188      |
| 40 | 160      | 188      |
| 45 | 190      | 188      |
| 50 | 190      | 188      |
| 55 | 190      | 188      |
| 60 | 190      | 188      |
+----+----------+----------+

=========

- We can see that DAMOS "hugepage" action works only when THP is set
  to madvise. "collapse" action works even when THP is set to never.
- Performance for "collapse" action is slightly lower than "hugepage"
  action and THP madvise. This is due to the fact that collapases
  occur synchronously. With "hugepage" they may occur during page
  faults.
- Memory consumption is slighly lower for "collapse" than "hugepage"
  with THP madvise. This is due to the khugepage collapses all VMAs,
  while "collapse" action only collapses the VMAs in the hot region.
- There is an improvement in TLB utilization when collapse through
  "hugepage" or "collapse" actions are triggered. The amount of
  TLB misses is lower.
- "collapse" action is performance synchronously, which means that
  page collapses happen earlier and more rapidly. This can be
  useful or not, depending on the scenario.
- "hugepage" action may trigger a VMA split in some scenarios, since
  it needs to change the flag of the VMA to THP enabled. This may
  lead to additional overhead.

Collapse action just adds a new option to chose the correct system
balance.

[1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2:
- v2: https://lore.kernel.org/20260409150128.1566835-1-gutierrez.asier@huawei-partners.com
- Add Reviewed-by: from SJ
- Wordsmith changelog
- Rebase to latest mm-new
Chagens from v1:
- v1: https://lore.kernel.org/20260330145758.2115502-1-gutierrez.asier@huawei-partners.com/
- Added masim benchmark
- Added performance benchmark for MariaDB
Changes from RFC v2:
- RFC v2: https://lore.kernel.org/20260323145646.4165053-1-gutierrez.asier@huawei-partners.com/
- Fixed a missing comma in the selftest python stript
- Added performance benchmarks
Changes from RFC:
- RFC: https://lore.kernel.org/20260316183805.2090297-1-gutierrez.asier@huawei-partners.com
- Added benchmarks
- Added damos_filter_type documentation for new action to fix kernel-doc

 Documentation/mm/damon/design.rst      |  4 ++++
 include/linux/damon.h                  |  2 ++
 mm/damon/sysfs-schemes.c               |  4 ++++
 mm/damon/vaddr.c                       |  3 +++
 tools/testing/selftests/damon/sysfs.py | 11 ++++++-----
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bda2f7..365e068a8dbe4 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -474,6 +474,10 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set. When
    TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
    fail.
+ - ``collapse``: Call ``madvise()`` for the region with ``MADV_COLLAPSE``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set. When
+   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
+   fail.
  - ``lru_prio``: Prioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6c..ac71b845bb6e8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -121,6 +121,7 @@ struct damon_target {
  * @DAMOS_PAGEOUT:	Reclaim the region.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
@@ -140,6 +141,7 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_COLLAPSE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 04746cbb33272..c14a564dd8218 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2061,6 +2061,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 		.action = DAMOS_NOHUGEPAGE,
 		.name = "nohugepage",
 	},
+	{
+		.action = DAMOS_COLLAPSE,
+		.name = "collapse",
+	},
 	{
 		.action = DAMOS_LRU_PRIO,
 		.name = "lru_prio",
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b069dbc7e3d25..dd5f2d7027ac4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -903,6 +903,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_COLLAPSE:
+		madv_action = MADV_COLLAPSE;
+		break;
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3aa5c91548a53..72f53180c6a88 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -123,11 +123,12 @@ def assert_scheme_committed(scheme, dump):
             'pageout': 2,
             'hugepage': 3,
             'nohugeapge': 4,
-            'lru_prio': 5,
-            'lru_deprio': 6,
-            'migrate_hot': 7,
-            'migrate_cold': 8,
-            'stat': 9,
+            'collapse': 5,
+            'lru_prio': 6,
+            'lru_deprio': 7,
+            'migrate_hot': 8,
+            'migrate_cold': 9,
+            'stat': 10,
             }
     assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
     assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
-- 
2.47.3
