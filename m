Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E1145A03;
	Thu, 13 Feb 2025 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411096; cv=none; b=oA3gp6iU9fhfaXv5iRq4yyVGsUGH7bzrWc8ve+D3cuvyFocI2p2mPYWqv7mNo/Oho7PYK0D/0tYfuLYlAdSDRuwWzW6Mb0R6h1ylglKcZlT8wJA8YHrhWlh+SmxgQvxat8h+7Mjc6TtqYVIVuBzr+XCDsT8YWysp5aNF42+LJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411096; c=relaxed/simple;
	bh=MVqyX49p8y3GlcogxKD7CIx6rSRSsVTH0dE/ZziaIYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2glgdeh6VkcZA/FEsmGWaoEpNCI7hs1mYWjOeyfgyU/VNJ9HyiRzFvVBQJCoplvTxSoLMyEhvY1wr8ySQm0fVapsgxAzUiVdVtXt9lkgH7bIX5ccVCquK/j2Oiu4Tdhdz+4b5hXBwlNtNiWOIALNgFhwfI0Wz7EnyVdgV9yfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0zx/kTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0zx/kTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA836C4AF09;
	Thu, 13 Feb 2025 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411096;
	bh=MVqyX49p8y3GlcogxKD7CIx6rSRSsVTH0dE/ZziaIYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0zx/kTIiC+vKHSnUdUAWWceChod/BOyQP/fsFYtN3UZVwjdEfKMwtMEtY8/+bqhA
	 hUI5afRogWIuMib6k0KuzfoFI2gdcT8sbFTTgxIOaLhy/PoOXSOP4E8edZs5TSJrtX
	 kR8vOYZHHcbIUpF475k1BM28SGZqylduU6kma3vAO+WLWIgC70PSit+vBvhsgb640/
	 jEKqaPnURFh67ucsczUBXUfHNU6Da+wAeukmMmWngkN91zIUt+AESfngjN6j31HBHt
	 8Dy4/89i61sCZUNeaFk/f6/X95Wk1VRfhz+YFqX3Yz8cN/WFl47n5BSDba4PW+23+T
	 8MWhy0WzbF2hQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/8] mm/damon/sysfs: implement intervals tuning goal directory
Date: Wed, 12 Feb 2025 17:44:33 -0800
Message-Id: <20250213014438.145611-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON sysfs interface directory and its files for setting
DAMON sampling and aggregation intervals auto-tuning goal.  Nearly all
kernel API data structures that newly introduced for this new feature
are directly exposed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index deeab04d3b46..ff774cc19d1f 100644
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
+	unsigned long samples_bp;
+	unsigned long aggrs;
+	unsigned long min_sample_us;
+	unsigned long max_sample_us;
+};
+
+static struct damon_sysfs_intervals_goal *damon_sysfs_intervals_goal_alloc(
+		unsigned long samples_bp, unsigned long aggrs,
+		unsigned long min_sample_us, unsigned long max_sample_us)
+{
+	struct damon_sysfs_intervals_goal *goal = kmalloc(sizeof(*goal),
+			GFP_KERNEL);
+
+	if (!goal)
+		return NULL;
+
+	goal->kobj = (struct kobject){};
+	goal->samples_bp = samples_bp;
+	goal->aggrs = aggrs;
+	goal->min_sample_us = min_sample_us;
+	goal->max_sample_us = max_sample_us;
+	return goal;
+}
+
+static ssize_t samples_bp_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->samples_bp);
+}
+
+static ssize_t samples_bp_store(struct kobject *kobj,
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
+	goal->samples_bp = nr;
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
+static struct kobj_attribute damon_sysfs_intervals_goal_samples_bp_attr =
+		__ATTR_RW_MODE(samples_bp, 0600);
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
+	&damon_sysfs_intervals_goal_samples_bp_attr.attr,
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
