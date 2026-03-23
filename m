Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42957394461
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277899; cv=none; b=h0bxAaNdt/JKNTMc/MmHdLwGABWlRhZU+a8hSbS2KALkx8LwROlu639icumutP3KzGV21TqJfg5MAKHj0lv6MWl+es1YafSjrjoX2Ng28WVy3XYFSIur435cJG2l68caAxX/YklPZ2FF0CMP/k00C4czkLZ0XRWaCajod4KE6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277899; c=relaxed/simple;
	bh=BKAEJtKN/Id5nY0MZfsNn65CxbC71xBciM9Djd3mE2g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1xRqLY6HPQBo6w/X0sjhLIIA1ppDfXd46oLo5me2ZBIz+QnU14NqrWzohMuibAebvtlxJU7ucuETE2yauonf9Gov8wQlnYPzOODoFoGdssha5+KZ9KAbc6eTgtSG1TY0zohjdaDCI8STu51u4RcIRB8UUF5LZNcwkOmOk/1+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffbrZ6H1QzJ46Dc;
	Mon, 23 Mar 2026 22:58:06 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 4479340572;
	Mon, 23 Mar 2026 22:58:12 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Mar 2026 17:58:11 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <ljs@kernel.org>,
	<Liam.Howlett@oracle.com>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/1] This patch set introces a new action: DAMOS_COLLAPSE.
Date: Mon, 23 Mar 2026 14:56:45 +0000
Message-ID: <20260323145646.4165053-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
working, since it relies on hugepage_madvise to add a new slot. This
slot should be picked up by khugepaged and eventually collapse (or
not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
enabled, khugepaged will not be working, and therefore no collapse
will happen.

DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
the address range synchronously.

This new action may be required to support autotuning with hugepage as
a goal[1].

[1]: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/

---------
Benchmarks:

T n: THP never
T m: THP madvise
D h: DAMON action hugepage
D c: DAMON action collapse

+------------------+----------+----------+----------+
|                  | T n, D h | T m, D h | T n, D c |
+------------------+----------+----------+----------+
| Total memory use | 2.07     | 2.09     | 2.07     |
| Huge pages       | 0        | 1.3      | 1.25     |
+------------------+----------+----------+----------+

Changes
---------
v1-v2:
Added benchmarks
Added damos_filter_type documentation for new action to fix kernel-doc

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 Documentation/mm/damon/design.rst      |  4 ++++
 include/linux/damon.h                  |  2 ++
 mm/damon/sysfs-schemes.c               |  4 ++++
 mm/damon/vaddr.c                       |  3 +++
 tools/testing/selftests/damon/sysfs.py | 11 ++++++-----
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 838b14d22519..405142641e55 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -467,6 +467,10 @@ that supports each action are as below.
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
index d9a3babbafc1..6941113968ec 100644
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
index 5186966dafb3..aa08a8f885fb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2041,6 +2041,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
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
index b069dbc7e3d2..dd5f2d7027ac 100644
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
index 3aa5c91548a5..c6476e63f4fb 100755
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
+            'collapse': 5
+            'lru_prio': 6,
+            'lru_deprio': 7,
+            'migrate_hot': 8,
+            'migrate_cold': 9,
+            'stat': 10,
             }
     assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
     assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
-- 
2.43.0

