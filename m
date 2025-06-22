Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44B21B9F6;
	Sun, 22 Jun 2025 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628284; cv=none; b=Rd0BIlvLTAmbjNs8xDutGY5sYO7+V929O0mwEYYDMbWH7n2Zk+U9w/3qVKShpbJ7jGWalH6Vm3Psb89770EyC3LXBb9giNVNEEgZmB8vwPWqwuySLaUhTI+osz52K8QvJ8n/+8opPZntRDntObVUDWTd8DFLPW59u79lxJjrmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628284; c=relaxed/simple;
	bh=2SWkXiGlsBU3I4JCOOhREoA9TlYEWmDdkhbiiUqC9nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjYhrbDpbuMwQzie+Qeej3e79jFl+9FcWw1OT/lK5LSAUW0En6H16wGuleursNPhvY714usOxep7MhP9BXipGJ3+wcfdfS4CfdBMf7eCQwKyrkjtN1u+PLF5cp1TVyGcwt387d2VTT/KrU4w9uU/j0WLjWu89xU4HcOmBczpXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsZUw/9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsZUw/9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5599C4CEE3;
	Sun, 22 Jun 2025 21:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750628283;
	bh=2SWkXiGlsBU3I4JCOOhREoA9TlYEWmDdkhbiiUqC9nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsZUw/9bBTCVa2s3TVispyvjrN+m4SvDz1lbWHqX3NzU23mT4TTCgBq0XRrU49nCa
	 iRcmujoy9e8MDup4bavcUXMzJJ2m34elfk/E2d+07u+tqTvs+2ZHdKRBgTJfl2RpNn
	 IN88njUNn9hul1QkjkrZsVeCHOAANpM55q1OirWIbaD4qdMZenO452gdUeaInKbHEM
	 CWOj84wh8s1ExDb0GDZbRmtrpeuyyCa//i09XZatWuhxPngoo5/M3ZvLZ/V9+tthwX
	 L9cZALwqgsJEOvjDlYIKBJZ/y7WsDllfNle6ONUoOzprtQF3KOU3Zya56fqVUCyvJm
	 7TrP0vj//bDHQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] mm/damon/sysfs-schemes: decouple from damos_quota_goal_metric
Date: Sun, 22 Jun 2025 14:37:55 -0700
Message-Id: <20250622213759.50930-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622213759.50930-1-sj@kernel.org>
References: <20250622213759.50930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decouple DAMOS sysfs interface from damos_quota_goal_metric.  For this,
define and use new sysfs-schemes internal data structure that maps the
user-space keywords and damos_quota_goal_metric, instead of having
the implicit and unflexible array index rule.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 55 ++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 30ae7518ffbf..3747dc6678f2 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -941,27 +941,51 @@ struct damos_sysfs_quota_goal {
 	int nid;
 };
 
-/* This should match with enum damos_quota_goal_metric */
-static const char * const damos_sysfs_quota_goal_metric_strs[] = {
-	"user_input",
-	"some_mem_psi_us",
-	"node_mem_used_bp",
-	"node_mem_free_bp",
-};
-
 static struct damos_sysfs_quota_goal *damos_sysfs_quota_goal_alloc(void)
 {
 	return kzalloc(sizeof(struct damos_sysfs_quota_goal), GFP_KERNEL);
 }
 
+struct damos_sysfs_qgoal_metric_name {
+	enum damos_quota_goal_metric metric;
+	char *name;
+};
+
+static
+struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
+	{
+		.metric = DAMOS_QUOTA_USER_INPUT,
+		.name = "user_input",
+	},
+	{
+		.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+		.name = "some_mem_psi_us",
+	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEM_USED_BP,
+		.name = "node_mem_used_bp",
+	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEM_FREE_BP,
+		.name = "node_mem_free_bp",
+	},
+};
+
 static ssize_t target_metric_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
+	int i;
 
-	return sysfs_emit(buf, "%s\n",
-			damos_sysfs_quota_goal_metric_strs[goal->metric]);
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_qgoal_metric_names); i++) {
+		struct damos_sysfs_qgoal_metric_name *metric_name;
+
+		metric_name = &damos_sysfs_qgoal_metric_names[i];
+		if (metric_name->metric == goal->metric)
+			return sysfs_emit(buf, "%s\n", metric_name->name);
+	}
+	return -EINVAL;
 }
 
 static ssize_t target_metric_store(struct kobject *kobj,
@@ -969,11 +993,14 @@ static ssize_t target_metric_store(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
-	enum damos_quota_goal_metric m;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_qgoal_metric_names); i++) {
+		struct damos_sysfs_qgoal_metric_name *metric_name;
 
-	for (m = 0; m < NR_DAMOS_QUOTA_GOAL_METRICS; m++) {
-		if (sysfs_streq(buf, damos_sysfs_quota_goal_metric_strs[m])) {
-			goal->metric = m;
+		metric_name = &damos_sysfs_qgoal_metric_names[i];
+		if (sysfs_streq(buf, metric_name->name)) {
+			goal->metric = metric_name->metric;
 			return count;
 		}
 	}
-- 
2.39.5
