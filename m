Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5F3C37A4;
	Tue, 12 May 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596623; cv=none; b=AScfOyAzB0HImec9TOOUc4n4wfKOQq3DQWtWR7P3fyl0gxhkjLZD6leseM6d1nLOAsy0w7lUJl8JuAfz7/4VAYjJAoHJqapnDCeU6ggckACUfx8l+4o1wCmWrxBOw+C+QcBGzv3+MqOPFLGFlS+lP0qU0+GxBFVSmmLE5IYgQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596623; c=relaxed/simple;
	bh=9wtcGKd2TuBKZzqqapx90lRnyNtTZA2HcxLo0K3VUw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcUSKngwKHwvaX29roN5Tvp7cjM6eQ8dpZI5ck9Yr4hVuBz3t/0DpHv+JApxKIgP1+TPSoVskJW9ggjzzdzvoo5m2a3pDteV+8Su1PvZaepa1lhVyILuxJcY+BlQ/jibpTt5YIjmGc/3q6WQF4Sl5BgD94xIiYBYmE0YPHLgLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2Y4UCes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Y4UCes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7049C2BCFA;
	Tue, 12 May 2026 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596623;
	bh=9wtcGKd2TuBKZzqqapx90lRnyNtTZA2HcxLo0K3VUw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2Y4UCesOy+wGS0CfoGDjUOwM9unW/5gtT+8MjUcQMjvBOCdeXJijU4KYWHX3fjRL
	 8ldeztL79sTfhJjpR9WET45TZhiY1XDl5YIx+1GXRP2hhjkt7YTGnjZv/7+U4yjM7T
	 6VudPGcxRF7Wy+2eM0/t+v0a9AU7PFD9PWKD+UzhpeEvU9JMyqgKYY+TZ8NRBzhPyD
	 k+qxrPis8998X5cl4z6ZfX10p7/NlZS6Gona85BoJWHQZ/9LyIomYG95WwlJoVItnc
	 7Mh5WSkZWdyo6EU1xthtq+oRpb9MT0BABr7WHaXFvUs5pfrGh4Gm/ao9ollbCm8eDb
	 tEYbOq7lYhYhg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 15/28] mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/
Date: Tue, 12 May 2026 07:36:30 -0700
Message-ID: <20260512143645.113201-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a sysfs directory for showing the per-region probe hit counts.
It is named 'probes/' and located under the DAMOS tried region
directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 65 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5d966ac864193..b2dcbdf1840e4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -10,6 +10,32 @@
 
 #include "sysfs-common.h"
 
+/*
+ * probes directory
+ */
+
+struct damos_sysfs_probes {
+	struct kobject kobj;
+};
+
+static struct damos_sysfs_probes *damos_sysfs_probes_alloc(void)
+{
+	return kzalloc_obj(struct damos_sysfs_probes);
+}
+
+static void damos_sysfs_probes_release(struct kobject *kobj)
+{
+	struct damos_sysfs_probes *probes = container_of(kobj,
+			struct damos_sysfs_probes, kobj);
+
+	kfree(probes);
+}
+
+static const struct kobj_type damos_sysfs_probes_ktype = {
+	.release = damos_sysfs_probes_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
 /*
  * scheme region directory
  */
@@ -20,6 +46,7 @@ struct damon_sysfs_scheme_region {
 	unsigned int nr_accesses;
 	unsigned int age;
 	unsigned long sz_filter_passed;
+	struct damos_sysfs_probes *probes;
 	struct list_head list;
 };
 
@@ -34,10 +61,36 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 	sysfs_region->ar = region->ar;
 	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
 	sysfs_region->age = region->age;
+	sysfs_region->probes = NULL;
 	INIT_LIST_HEAD(&sysfs_region->list);
 	return sysfs_region;
 }
 
+static int damos_sysfs_region_add_dirs(
+		struct damon_sysfs_scheme_region *region)
+{
+	struct damos_sysfs_probes *probes = damos_sysfs_probes_alloc();
+	int err;
+
+	if (!probes)
+		return -ENOMEM;
+	err = kobject_init_and_add(&probes->kobj, &damos_sysfs_probes_ktype,
+			&region->kobj, "probes");
+	if (err) {
+		kobject_put(&probes->kobj);
+		return err;
+	}
+
+	region->probes = probes;
+	return 0;
+}
+
+static void damos_sysfs_region_rm_dirs(
+		struct damon_sysfs_scheme_region *region)
+{
+	kobject_put(&region->probes->kobj);
+}
+
 static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
@@ -165,6 +218,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
 		/* release function deletes it from the list */
+		damos_sysfs_region_rm_dirs(r);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
@@ -2998,9 +3052,14 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
-				sysfs_regions->nr_regions)) {
-		kobject_put(&region->kobj);
-	}
+				sysfs_regions->nr_regions))
+		goto out;
+	if (damos_sysfs_region_add_dirs(region))
+		goto out;
+	return;
+
+out:
+	kobject_put(&region->kobj);
 }
 
 int damon_sysfs_schemes_clear_regions(
-- 
2.47.3
