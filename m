Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398B1DED55;
	Fri, 28 Feb 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780216; cv=none; b=lF9k9Xrh8o1BAQIql2JqI+7wh4H45I1qQ0S3jbjN2lAVNQz6vMfwHdEf5q3qLc1jhUGHEyUQkP+aKYRI7ywyUS8IcG4+wqu3SIxFG1Kjw4VI9+0+B9kEriAI5kTpHjb3c7I1WFjsw2xQ+VBlBr68KsEvjUfJkrqLMQPZJg9GvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780216; c=relaxed/simple;
	bh=oYTrlxmiR5BNoFrioFop/hpnftvDsKcm3PmL/H0/UqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EzAMPL5UoCk/8BhdRPm/b6oA/TV/QyhACGWiilKsEbINOLiK4j3cIKGW4tcrhOs7/kttA7ECc1e/uiY/ZrCue4JRJVWe6iI1yDdB8BbiqCqK+pD5ESI+7nkLBClcIiaVW+ajaRCRx2Nj2C0fl8wpkoWKQbbjCwi7o/YDLgm6yMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/FphRjd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/FphRjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96286C4AF09;
	Fri, 28 Feb 2025 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780214;
	bh=oYTrlxmiR5BNoFrioFop/hpnftvDsKcm3PmL/H0/UqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/FphRjdGqDtr0R0HIkMrG187LEe7z469tMGPI07zZ54hj1kb7AgXUVnoFoTGPK7I
	 tgnafQKOapIxO1YQszMqW1Y0QlZtSphOc/TYJdCb6hut5LvcL2v1DC/gASdD+9KVhv
	 9GWkNI9qH12ebwRByk2InerJEWBorZDbo0vHUnAO8X2kGYozCZZSPzyOMAiWHOfzCl
	 AMwVQEXD7G2+ui63OTvUeghCyhujwrf7KtfkPX5J3EDroNetug/pRduK9yNplTXyn6
	 gFAJRK3rsetI3uZ+h7WGbC/XtbLbIzmCcnrSbtSZFQodT+Xrc/zICc3Zuk5OdYlAmk
	 5Rd2++9FJieEA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/8] mm/damon/sysfs: implement intervals tuning goal directory
Date: Fri, 28 Feb 2025 14:03:23 -0800
Message-Id: <20250228220328.49438-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON sysfs interface directory and its files for setting
DAMON sampling and aggregation intervals auto-tuning goal.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index deeab04d3b46..a772060300b4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -408,6 +408,164 @@ static const struct kobj_type damon_sysfs_targets_ktype = {
 	.default_groups = damon_sysfs_targets_groups,
 };
 
+/*
+ * intervals goal directory
+ */
+
+struct damon_sysfs_intervals_goal {
+	struct kobject kobj;
+	unsigned long access_bp;
+	unsigned long aggrs;
+	unsigned long min_sample_us;
+	unsigned long max_sample_us;
+};
+
+static struct damon_sysfs_intervals_goal *damon_sysfs_intervals_goal_alloc(
+		unsigned long access_bp, unsigned long aggrs,
+		unsigned long min_sample_us, unsigned long max_sample_us)
+{
+	struct damon_sysfs_intervals_goal *goal = kmalloc(sizeof(*goal),
+			GFP_KERNEL);
+
+	if (!goal)
+		return NULL;
+
+	goal->kobj = (struct kobject){};
+	goal->access_bp = access_bp;
+	goal->aggrs = aggrs;
+	goal->min_sample_us = min_sample_us;
+	goal->max_sample_us = max_sample_us;
+	return goal;
+}
+
+static ssize_t access_bp_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->access_bp);
+}
+
+static ssize_t access_bp_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->access_bp = nr;
+	return count;
+}
+
+static ssize_t aggrs_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->aggrs);
+}
+
+static ssize_t aggrs_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->aggrs = nr;
+	return count;
+}
+
+static ssize_t min_sample_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->min_sample_us);
+}
+
+static ssize_t min_sample_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->min_sample_us = nr;
+	return count;
+}
+
+static ssize_t max_sample_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->max_sample_us);
+}
+
+static ssize_t max_sample_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->max_sample_us = nr;
+	return count;
+}
+
+static void damon_sysfs_intervals_goal_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_intervals_goal, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_intervals_goal_access_bp_attr =
+		__ATTR_RW_MODE(access_bp, 0600);
+
+static struct kobj_attribute damon_sysfs_intervals_goal_aggrs_attr =
+		__ATTR_RW_MODE(aggrs, 0600);
+
+static struct kobj_attribute damon_sysfs_intervals_goal_min_sample_us_attr =
+		__ATTR_RW_MODE(min_sample_us, 0600);
+
+static struct kobj_attribute damon_sysfs_intervals_goal_max_sample_us_attr =
+		__ATTR_RW_MODE(max_sample_us, 0600);
+
+static struct attribute *damon_sysfs_intervals_goal_attrs[] = {
+	&damon_sysfs_intervals_goal_access_bp_attr.attr,
+	&damon_sysfs_intervals_goal_aggrs_attr.attr,
+	&damon_sysfs_intervals_goal_min_sample_us_attr.attr,
+	&damon_sysfs_intervals_goal_max_sample_us_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_intervals_goal);
+
+static const struct kobj_type damon_sysfs_intervals_goal_ktype = {
+	.release = damon_sysfs_intervals_goal_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_intervals_goal_groups,
+};
+
 /*
  * intervals directory
  */
@@ -417,6 +575,7 @@ struct damon_sysfs_intervals {
 	unsigned long sample_us;
 	unsigned long aggr_us;
 	unsigned long update_us;
+	struct damon_sysfs_intervals_goal *intervals_goal;
 };
 
 static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
@@ -436,6 +595,32 @@ static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
 	return intervals;
 }
 
+static int damon_sysfs_intervals_add_dirs(struct damon_sysfs_intervals *intervals)
+{
+	struct damon_sysfs_intervals_goal *goal;
+	int err;
+
+	goal = damon_sysfs_intervals_goal_alloc(0, 0, 0, 0);
+	if (!goal)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&goal->kobj,
+			&damon_sysfs_intervals_goal_ktype, &intervals->kobj,
+			"intervals_goal");
+	if (err) {
+		kobject_put(&goal->kobj);
+		intervals->intervals_goal = NULL;
+		return err;
+	}
+	intervals->intervals_goal = goal;
+	return 0;
+}
+
+static void damon_sysfs_intervals_rm_dirs(struct damon_sysfs_intervals *intervals)
+{
+	kobject_put(&intervals->intervals_goal->kobj);
+}
+
 static ssize_t sample_us_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -569,6 +754,9 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	err = kobject_init_and_add(&intervals->kobj,
 			&damon_sysfs_intervals_ktype, &attrs->kobj,
 			"intervals");
+	if (err)
+		goto put_intervals_out;
+	err = damon_sysfs_intervals_add_dirs(intervals);
 	if (err)
 		goto put_intervals_out;
 	attrs->intervals = intervals;
@@ -599,6 +787,7 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 {
 	kobject_put(&attrs->nr_regions_range->kobj);
+	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
 }
 
-- 
2.39.5
