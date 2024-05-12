Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EC4F205;
	Sun, 12 May 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536496; cv=none; b=YIalF5Ef2j7+ajaVHSWpNXrwiGT/9USiYc/6PxtgqK/rleJpwAv+fY0snALAJ4jshBUGcrPQRpA6jgIyN/HlzaRs+vghpqmpPaayonjERKLUhscYxbk0hEQschw5Nntw29AuC1douXUOkpB8gum4NMam6hixI1ISv4lg0cUaYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536496; c=relaxed/simple;
	bh=vBax8IQjCZahbUBgsA8N3gO+pf43TzfEVXtgesAQ6bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDuUHui7sxa+9NjiuxNPZ6NluyEejx2HEth7kUn8Fm3zNxfruKGeCW3Fs6xTBHWE2DQQ/SghvWw03aG9I/AH5HCf9+DPkN2EzVlJMUVLL4mWdd76lZ4be6E7EcXm1E6FWxJdZ907Q1tZZTUMJYpmikktqgxBPmsLWlr8h50y6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyBAV9AV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyBAV9AV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABCC116B1;
	Sun, 12 May 2024 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536495;
	bh=vBax8IQjCZahbUBgsA8N3gO+pf43TzfEVXtgesAQ6bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyBAV9AVGCq6yXdy/aW3PmZ8JWsV8XngJMaFr7osxhdC0ekeLwPTvVw6Wiyg+PCPu
	 eRdHFPEp6poLsUEDvio7nw1h6oX84fhBy8yyV3VTGioQRBvofhvpNZ/cr+QUwZt4Rm
	 pUvI4R9YYYfVpasOVMitrr2pQ84mVKGNXWtcqGNsBlyTzKdaXWqP9V/AytmDCZhrSY
	 XlD98FWNAgZwMEllxKOh3k50efUoMsnKpn/bHWSM/1hMMb78X7ec/04u6ZTypiJYrd
	 J3r0o3mEJc4aPWXNhaE0GUdgdX6YF5L7DmnS1X8HpAe3KmPcqsp01gq1vNl4lYLwCA
	 EOT9JC90/lCDw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Hyeongtak Ji <hyeongtak.ji@sk.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH v4 2/5] mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
Date: Sun, 12 May 2024 10:54:44 -0700
Message-Id: <20240512175447.75943-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512175447.75943-1-sj@kernel.org>
References: <20240512175447.75943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index e1a0c2a11007..32c261aeff88 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -364,7 +364,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks)
+			struct damos_watermarks *wmarks,
+			int target_nid)
 {
 	struct damos *scheme;
 
@@ -391,6 +392,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
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
2.39.2

