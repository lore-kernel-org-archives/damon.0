Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9422E14430D
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284695; cv=none; b=Q+adkcos1jGHgBsn/ILcnfB3qteBoDSPzxUU0xAysiPUanQ+3Cii/vXgFooZy4HEK9b1CQD9ZrCBPUSDH5IWU5zzyvtp9ePRPb3Kni7P4YWNfXxPfiJCeSbvJqADc3UDIlzAENfj1pHunm4C8TKgKdpQBnH+EnizKSVuXCGFpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284695; c=relaxed/simple;
	bh=PBLigDFeoVj/3sesODDma7eu2K0yE9gUuHQjzZnRg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRBFErKrj6P4WpSCt83ALJFFMYboTOr5OCg887qYsnsz50m8+h1jx4L8biUns4MnEBYz5cVkppudhIAizK6lofDLVCHJeg7y0F8/SHHWMIqqP+oxymuleAVuB1NoQq44PF2rtHoJtizknTPdV6BBhuSs5tnvVWBTUHeZ3Z/+jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-34-666af18e204d
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
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 3/8] mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
Date: Thu, 13 Jun 2024 22:17:34 +0900
Message-ID: <20240613131741.513-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613131741.513-1-honggyu.kim@sk.com>
References: <20240613131741.513-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnkW7fx6w0g49rJS0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M4+vbWAouW1U82vGIsYFxo0EXIyeHhICJxI8n+1hg7Juf5jOD2GwCahJXXk5i
	6mLk4BARsJKYtiO2i5GLg1ngGrPE7u6TYDXCAj4S969MZgOpYRFQlWi5GgFi8gqYSmyZngAx
	UVPi8faf7CA2p4CZxLpv9xlBbCGgko7/z8Cm8AoISpyc+QTsAmYBeYnmrbOZQVZJCLxnk9g4
	fQHUaZISB1fcYJnAyD8LSc8sJD0LGJlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgRGwLLaP9E7
	GD9dCD7EKMDBqMTD6/EsK02INbGsuDL3EKMEB7OSCO+shUAh3pTEyqrUovz4otKc1OJDjNIc
	LErivEbfylOEBNITS1KzU1MLUotgskwcnFINjHxMrMyrBbO3m5w9P6/qcM1bS/6lb+Kez7Xh
	Dnrx63et6Mlvjs4HOFet8ovykyqY/7WxOlO9pkMtYs+O3Nmlix/t7/M3Z1iQ0nD5kvOqKZb6
	2/y1r58I0t32+vn/V3HnJ1xze35keZyP/r/6VUpFYp6saafCe3dULQ/lZZwg9Pahy+W/Mmym
	l5VYijMSDbWYi4oTAWOkM+d8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXCNUNLT7fvY1aaQfciLouJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtmi88l3RovDc0+yWlzeNYfN4t6a/6wWR9afZbHYfPYMs8Xi
	5WoW+zoeMFkc/vqGyYHfY+npN2weO2fdZfdo2XeL3WPTqk42j02fJrF7nJjxm8XjxeaZjB4b
	P/5n9/h228Nj8YsPTB6fN8kFcEdx2aSk5mSWpRbp2yVwZRxf38ZScNmq4tGOR4wNjBsNuhg5
	OSQETCRufprPDGKzCahJXHk5iamLkYNDRMBKYtqO2C5GLg5mgWvMEru7T4LVCAv4SNy/MpkN
	pIZFQFWi5WoEiMkrYCqxZXoCxERNicfbf7KD2JwCZhLrvt1nBLGFgEo6/j8Dm8IrIChxcuYT
	FhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjqy2r/
	TNzB+OWy+yFGAQ5GJR5ej2dZaUKsiWXFlbmHGCU4mJVEeGctBArxpiRWVqUW5ccXleakFh9i
	lOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwLimsDXa7s64sdW/LCov9ydvW7Wl9qcpe
	9IQjqrwuvCTpd/mv1wlLttmVKNpv6yyWV766MmN91u8zG0xL5L9ecZ/1X/CB5xyZ9hjlf/8m
	9PnecXI/k8mx7NiFDUHHHbcH77EqvXzgbIuvxjxu05xHnmEzgnR9bNJ3mYWsDQ6+KtVq6Gqx
	Rn2ZEktxRqKhFnNRcSIA/VO9TnECAAA=
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch adds target_nid under
  /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/

The 'target_nid' can be used as the destination node for DAMOS actions
such as DAMOS_MIGRATE_{HOT,COLD} in the follow up patches.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 11 ++++++++++-
 mm/damon/core.c          |  5 ++++-
 mm/damon/dbgfs.c         |  2 +-
 mm/damon/lru_sort.c      |  3 ++-
 mm/damon/reclaim.c       |  3 ++-
 mm/damon/sysfs-schemes.c | 33 ++++++++++++++++++++++++++++++++-
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f7da65e1ac04..21d6b69a015c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -374,6 +374,7 @@ struct damos_access_pattern {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
@@ -389,6 +390,10 @@ struct damos_access_pattern {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @target_nid is used to set the migration target node for migrate_hot or
+ * migrate_cold actions, which means it's only meaningful when @action is either
+ * "migrate_hot" or "migrate_cold".
+ *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
  * &filters
@@ -410,6 +415,9 @@ struct damos {
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
+	union {
+		int target_nid;
+	};
 	struct list_head filters;
 	struct damos_stat stat;
 	struct list_head list;
@@ -726,7 +734,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks);
+			struct damos_watermarks *wmarks,
+			int target_nid);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6392f1cc97a3..c0ec5be4f56e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -354,7 +354,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks)
+			struct damos_watermarks *wmarks,
+			int target_nid)
 {
 	struct damos *scheme;
 
@@ -381,6 +382,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->target_nid = target_nid;
+
 	return scheme;
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 2461cfe2e968..51a6f1cac385 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -281,7 +281,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(&pattern, action, 0, &quota,
-				&wmarks);
+				&wmarks, NUMA_NO_NODE);
 		if (!scheme)
 			goto fail;
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a65c3..3775f0f2743d 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -163,7 +163,8 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+			&damon_lru_sort_wmarks,
+			NUMA_NO_NODE);
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9bd341d62b4c..a05ccb41749b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -177,7 +177,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 			/* under the quota. */
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
-			&damon_reclaim_wmarks);
+			&damon_reclaim_wmarks,
+			NUMA_NO_NODE);
 }
 
 static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bea5bc52846a..0632d28b67f8 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/numa.h>
 
 #include "sysfs-common.h"
 
@@ -1445,6 +1446,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_scheme_filters *filters;
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
+	int target_nid;
 };
 
 /* This should match with enum damos_action */
@@ -1470,6 +1472,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->kobj = (struct kobject){};
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
+	scheme->target_nid = NUMA_NO_NODE;
 	return scheme;
 }
 
@@ -1692,6 +1695,28 @@ static ssize_t apply_interval_us_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t target_nid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%d\n", scheme->target_nid);
+}
+
+static ssize_t target_nid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int err = 0;
+
+	/* TODO: error handling for target_nid range. */
+	err = kstrtoint(buf, 0, &scheme->target_nid);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -1703,9 +1728,13 @@ static struct kobj_attribute damon_sysfs_scheme_action_attr =
 static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 		__ATTR_RW_MODE(apply_interval_us, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
+		__ATTR_RW_MODE(target_nid, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
+	&damon_sysfs_scheme_target_nid_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -2031,7 +2060,8 @@ static struct damos *damon_sysfs_mk_scheme(
 	};
 
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
-			sysfs_scheme->apply_interval_us, &quota, &wmarks);
+			sysfs_scheme->apply_interval_us, &quota, &wmarks,
+			sysfs_scheme->target_nid);
 	if (!scheme)
 		return NULL;
 
@@ -2068,6 +2098,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 
 	scheme->action = sysfs_scheme->action;
 	scheme->apply_interval_us = sysfs_scheme->apply_interval_us;
+	scheme->target_nid = sysfs_scheme->target_nid;
 
 	scheme->quota.ms = sysfs_quotas->ms;
 	scheme->quota.sz = sysfs_quotas->sz;
-- 
2.34.1

