Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E54145A19
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284877; cv=none; b=B18aMvSChXqnWyOhYdM/DV04Nm5Jst2tX2b9jgfVxEJ8i6LnHqvSm8bqqjoonnEDCYIpelmsu1XIWQln+8YLaxcVs5eR3ka+fr2se/Kx6pS7nCWmwnDu9htA7KAkIMpqwLZ1PGjBJqALAcUhnB/WEq5DSNrvQgvEisISyGqFgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284877; c=relaxed/simple;
	bh=PBLigDFeoVj/3sesODDma7eu2K0yE9gUuHQjzZnRg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqcqz08+ebsWmDw8zHHF5by7ipwgx6Y388StB2SiTCpyH/AIMq5YMQTXiAmF8y+nvclO2D1KsAkjAeV7rrozprRjZZzJF0fqnRQVthYgA7nA2xvocQXHAPp6HO2EkAifY5mCYJYSX4Sgju975mkCTdTwZVxmpsd2jQ89z7o+hoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-43-666af248739a
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
Subject: [PATCH v5 3/8] mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
Date: Thu, 13 Jun 2024 22:20:50 +0900
Message-ID: <20240613132056.608-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnoa7Hp6w0g1eblC0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M4+vbWAouW1U82vGIsYFxo0EXIyeHhICJRM/yw8ww9uXf81hBbDYBNYkrLycx
	dTFycIgIWElM2xHbxcjFwSxwjVlid/dJsHphAX+JvhV7GUFsFgFViWX9D8F6eQVMJa53LWeB
	mKkp8Xj7T3YQm1PATOLR3FdsILYQUM2MH1eZIeoFJU7OfAJWzywgL9G8dTYzyDIJgfdsEs9n
	NzJBDJKUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEzx0QvozIvs0IvOT93EyMwCpbV/one
	wfjpQvAhRgEORiUeXo9nWWlCrIllxZW5hxglOJiVRHhnLQQK8aYkVlalFuXHF5XmpBYfYpTm
	YFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYDS8s1214XCvZNJSldqZtrOcSr63TsyeyLDW
	fNfhDI0c2e01pfLik51+mQVtvO3rYnZdcmH/g1f7Vp0tWLbwwFbvO3eKbDkFslpnB0Y4riwO
	0FtQLaPilS2YKaEvX7nYt1s/zCRO+rTzNFcN2cWltYfXvJMO1CmpTuuazfnOq2ninOo2NfUI
	JZbijERDLeai4kQAHeyADX4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXCNUNLT9fjU1aaQfs+YYuJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtmi88l3RovDc0+yWlzeNYfN4t6a/6wWR9afZbHYfPYMs8Xi
	5WoW+zoeMFkc/vqGyYHfY+npN2weO2fdZfdo2XeL3WPTqk42j02fJrF7nJjxm8XjxeaZjB4b
	P/5n9/h228Nj8YsPTB6fN8kFcEdx2aSk5mSWpRbp2yVwZRxf38ZScNmq4tGOR4wNjBsNuhg5
	OSQETCQu/57HCmKzCahJXHk5iamLkYNDRMBKYtqO2C5GLg5mgWvMEru7TzKD1AgL+Ev0rdjL
	CGKzCKhKLOt/CNbLK2Aqcb1rOQvETE2Jx9t/soPYnAJmEo/mvmIDsYWAamb8uMoMUS8ocXLm
	E7B6ZgF5ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmC4L6v9
	M3EH45fL7ocYBTgYlXh4PZ5lpQmxJpYVV+YeYpTgYFYS4Z21ECjEm5JYWZValB9fVJqTWnyI
	UZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAqLJL46RP6xktefVvCTuZDNtVy1f+nOI5
	4e+sZzu2SyUnTlm3fu/TW+rb7mgIHOSUUbWY3FYk6T352ftmnQ1fSv7PkHSs3/HvJtsb0x8+
	E2+c+/wvWDf2h/iC5XHBfvwd8fzL6gUEmbV9rDWvtgccNn2XcuKc9u87WzYHvCw62bLH3lHC
	ZK/jHSWW4oxEQy3mouJEAInj7stzAgAA
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

