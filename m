Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD441DA23
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516628; cv=none; b=KTqDQgGWgh+6kV5lwGLEkKwR8R+b0xt2kDmOZKnx0CiU15UDepel3pnWDXD7MFNH8gYDdnQF/GCCtBvlfBBY1bOD6AGBE7TgyLFNWxa/56ixcmLwnsOx2jgUgtd9WvXKtKuP39srQFQDe8+ezOhkBfx5TT9ra+1IjDQf55vwFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516628; c=relaxed/simple;
	bh=DUin7ncN2wE53OSsMptOjCA0tzO+DsIg+Rek0OLve6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeFrdi3Jj9eL22Pw833Bos7c6RU6+YTEbOMXPaSUZ1KfxQfpuwM2LsWCgWChcejMu4cvBcny3Lwi+HGD60cTFxuh8r7RyKbcUsHzElD+faMATZLYpWoKVXDbHG2D+nl7eTRjD1acgi7WaqAOh6p1oyJsH//Kyj/FCTGnovCuSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI02Re2x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI02Re2x"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cea3004256so111242165ad.0
        for <damon@lists.linux.dev>; Sun, 19 Jul 2026 20:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516626; x=1785121426; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69Ct5gp9rT21SAwaHS4XMcVk/1fLHoPDTQLb0SWSnDU=;
        b=lI02Re2xoC1QxGd1j0PttOHGYtXd8a3jE6iQjuXtOLXg3mh6AcUP3z2FQH4qVHzKSe
         XK5XQV+LcE+Uz8ilGDFZzqajKx51q6E3Y+fo0cirzSAWfjpE08JmdJYktdMnkm7qXF1K
         su0Hlvbylw7xBm8aQjGCA7BCnkLH3uq88lNCHYKr7hV+LCSXp0EU04kqxozKxN9MpEqj
         89Q4PWO45Sq+z7NkpDkN+8QkkCtt+goSkPRQXm2WnxHbbAvfLc5bRdhdE7yryY6c5H1J
         /efOpgyNMU6SrFf49qkKkvTN0viJ8DxmKmGlpZan4M0rjOVyGKvdSSnuHYsMWh3hF6ko
         G5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516626; x=1785121426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=69Ct5gp9rT21SAwaHS4XMcVk/1fLHoPDTQLb0SWSnDU=;
        b=bF7g4ZjDis9Ka3jhczFYRDxbgXzpvmsEwJGtf2BKSBRPjP/81DLy6GuEa7tMZb+SzO
         Y5vzZPp8XkY+aqtcYjooi6B649cZRqjcZsv6abt8eOtVIwtUVaqOdwQ/Bf2FS1o7njXA
         i+3h4+pS6n4q0vjTgKCCu4DZdNxgyoB6gKJzZR2peQwuMva6cYIq1y4n8WmooWrW09Hg
         sSO61SbOGSz8TX4eqKDtlttxnv/queaj0Z2VmGvr7gMrED44bQbOjeWah6qZNxGKi0RX
         C50bEZfzD0ZM1WSk/OOB/QQBry056CxnEdAFIQtYbVIis6AgKnb4bnKarfu40Db2CQSh
         HApg==
X-Gm-Message-State: AOJu0YzLqb0Oic//DIyz+eGa/y7dLdrROeUFUjgio7KRyOr93Hv9mWx4
	8aOC/j3kK6EdaBVwAQEaNk1QQ01EPhe6r0GVM2AhZAJIEoGEg6GrNhTMNNKDaZVy
X-Gm-Gg: AfdE7clywDUca6HABJYfFC6a1b6+YtQMf3LOCsE0e6+RmUqkkatTi679NMvYFux9kIg
	LK49wXsnNlB7JXmrWfAq1EhhE3NyqF57Kr2CczAF6zVKwt6Oh25ZipHW8V26Ep+u9V95eJSro3z
	QmTtGuHhZsHMKaFOOnHXKoorABQYGJIBVxNaC3/1g3yxxm12GhERO1yc2QqhL89l4tT0bUpUpLB
	FXLr6v8FTL2ctD4ukr+2asuhYd1SiqK77/iPD7Uh7yVk2Kp6B4veYZfbl60GV8Qzlr6MZpeu5kp
	vP99FZa3mDWTjYrSxaRs5lD9O2/b00k+We+r7ynid72Fo3TQWS549bxs0fD6wldGiTYk9WL7MSM
	jbfUe4l9ahFM7BzfCb6Y1l5UNZs4iRRK19MQqszt6l03DM3Fm9pjtwsFsTdrYR+R3WIkYKBaA5a
	j0MiRsu4tcxINCanJIlf1kkryxim0=
X-Received: by 2002:a17:902:fc85:b0:2c9:bd37:ae76 with SMTP id d9443c01a7336-2cf34a3ef59mr139624465ad.47.1784516626163;
        Sun, 19 Jul 2026 20:03:46 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344d80e6sm47783065ad.29.2026.07.19.20.03.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 20:03:45 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: [RFC PATCH v3 1/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 11:03:25 +0800
Message-ID: <20260720030327.80153-2-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720030327.80153-1-lianux.mm@gmail.com>
References: <20260720030327.80153-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new DAMOS action, DAMOS_SPLIT, that splits large folios in the
target region down to a smaller order.  A new per-scheme field and sysfs
file, target_order, selects the split target: 0 for order-0 base pages,
or 2..HPAGE_PMD_ORDER-1 for a smaller mTHP order (order-1 is rejected at
store time since anonymous THPs cannot be split to order-1).

Unlike DAMOS_COLLAPSE which builds large folios, splitting only dismantles
them; it allocates nothing, copies nothing, and no THP admission policy
applies.  khugepaged deliberately refuses to collapse a folio to a
smaller order, leaving the shrink direction to callers like this one.

This patch adds the DAMOS_SPLIT action, the ``order`` field (placed in
the existing union alongside target_nid and migrate_dests), its sysfs
interface, and documentation.  The vaddr operations set handler is added
in the next patch.

Link: https://lore.kernel.org/20260605161422.213817-9-npache@redhat.com/
 ("mm/khugepaged: skip collapsing mTHP to smaller orders")



Co-developed-by: Kunwu Chan <kunwu.chan@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@linux.dev>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
 Documentation/mm/damon/design.rst             |  5 ++
 include/linux/damon.h                         | 15 ++++--
 mm/damon/core.c                               |  2 +
 mm/damon/sysfs-schemes.c                      | 48 +++++++++++++++++++
 tools/testing/selftests/damon/sysfs.py        | 11 +++--
 6 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 907a504fb64c..ee8e260a631c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -265,6 +265,13 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Action's target NUMA node id.  Supported by only relevant
 		actions.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/target_order
+Date:		Jul 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Target folio order for the ``split`` action.  Large folios in
+		the target region are split down to this order.  Valid values
+		are 0 (order-0 base pages) and 2..HPAGE_PMD_ORDER-1.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/apply_interval_us
 Date:		Sep 2023
 Contact:	SJ Park <sj@kernel.org>
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf483..87a801954b1b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -549,6 +549,11 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set. When
    TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
    fail.
+ - ``split``: Split each large folio in the region down to the order specified
+   by the scheme's ``target_order`` (``0`` for order-0 base pages, or
+   ``2..HPAGE_PMD_ORDER-1``).  Supported by ``vaddr`` and ``fvaddr`` operations
+   set. When TRANSPARENT_HUGEPAGE is disabled, the application of the action
+   will just fail.
  - ``lru_prio``: Prioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
diff --git a/include/linux/damon.h b/include/linux/damon.h
index f69442a9d431..88b61b900a36 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -110,6 +110,7 @@ struct damon_target {
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
+ * @DAMOS_SPLIT:	Split each large folio in the region to a smaller order.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
@@ -130,6 +131,7 @@ enum damos_action {
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
 	DAMOS_COLLAPSE,
+	DAMOS_SPLIT,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
@@ -582,10 +584,15 @@ struct damos {
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	union {
-		struct {
-			int target_nid;
-			struct damos_migrate_dests migrate_dests;
-		};
+		int target_nid;
+		struct damos_migrate_dests migrate_dests;
+		/*
+		 * @order: target folio order for DAMOS_SPLIT.
+		 * Split large folios down to this order.  0 for
+		 * order-0 base pages, 2..HPAGE_PMD_ORDER-1 for
+		 * smaller mTHP.  Order-1 is rejected.
+		 */
+		unsigned int order;
 	};
 	struct list_head core_filters;
 	struct list_head ops_filters;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 806a67d02a6e..394c62455ad5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -693,6 +693,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 		return NULL;
 	scheme->pattern = *pattern;
 	scheme->action = action;
+	scheme->order = 0;
 	scheme->apply_interval_us = apply_interval_us;
 	/*
 	 * next_apply_sis will be set when kdamond starts.  While kdamond is
@@ -1446,6 +1447,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
 
 	dst->pattern = src->pattern;
 	dst->action = src->action;
+	dst->order = src->order;
 	dst->apply_interval_us = src->apply_interval_us;
 
 	err = damos_commit_quota(&dst->quota, &src->quota);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 32f495a96b17..725ed81ccf6c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -4,7 +4,9 @@
  */
 
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/numa.h>
+#include <linux/huge_mm.h>
 
 #include "sysfs-common.h"
 
@@ -2260,6 +2262,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
 	int target_nid;
+	unsigned int target_order;
 	struct damos_sysfs_dests *dests;
 };
 
@@ -2293,6 +2296,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 		.action = DAMOS_COLLAPSE,
 		.name = "collapse",
 	},
+	{
+		.action = DAMOS_SPLIT,
+		.name = "split",
+	},
 	{
 		.action = DAMOS_LRU_PRIO,
 		.name = "lru_prio",
@@ -2326,6 +2333,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
 	scheme->target_nid = NUMA_NO_NODE;
+	scheme->target_order = 0;
 	return scheme;
 }
 
@@ -2645,6 +2653,40 @@ static ssize_t target_nid_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t target_order_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%u\n", scheme->target_order);
+}
+
+static ssize_t target_order_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 0, &val);
+	if (err)
+		return err;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/* Valid split targets: 0 (order-0 base pages) or 2..HPAGE_PMD_ORDER-1. */
+	if (val != 0 && (val < 2 || val >= HPAGE_PMD_ORDER))
+		return -EINVAL;
+#else
+	if (val != 0)
+		return -EINVAL;
+#endif
+
+	scheme->target_order = val;
+	return count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -2659,10 +2701,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
 		__ATTR_RW_MODE(target_nid, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_target_order_attr =
+		__ATTR_RW_MODE(target_order, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
 	&damon_sysfs_scheme_target_nid_attr.attr,
+	&damon_sysfs_scheme_target_order_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -3011,6 +3057,8 @@ static struct damos *damon_sysfs_mk_scheme(
 	if (!scheme)
 		return NULL;
 
+	scheme->order = sysfs_scheme->target_order;
+
 	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
 	if (err) {
 		damon_destroy_scheme(scheme);
diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3ffa054b6386..49d3c319dfd8 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -131,11 +131,12 @@ def assert_scheme_committed(scheme, dump):
             'hugepage': 3,
             'nohugepage': 4,
             'collapse': 5,
-            'lru_prio': 6,
-            'lru_deprio': 7,
-            'migrate_hot': 8,
-            'migrate_cold': 9,
-            'stat': 10,
+            'split': 6,
+            'lru_prio': 7,
+            'lru_deprio': 8,
+            'migrate_hot': 9,
+            'migrate_cold': 10,
+            'stat': 11,
             }
     assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
     assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
