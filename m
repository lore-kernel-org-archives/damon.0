Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5EA345CA3;
	Mon, 18 May 2026 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147689; cv=none; b=LC6jL3gNUYEm0GhA0vd1PlmKH2N7m61yhhtlfam5tcJ8DgBWFq6q4WeNTGQdhT38033G4yWP3j7t40miawa5rKfK/ALAxmhSQqyW13M2oAOMAckJ70g5x7OmJu+T1VnVN3ytBabplgyFrChTzkQTDxgsH69cWPdaXkpxNuCfFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147689; c=relaxed/simple;
	bh=KKZL2OHisyq4/jWatQDQLTgpqORuvrm8mIvvroFoPfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teb9STJbDHeeZrGErPv7RK+CZezbc7hxgPrxSk29C7E5iUBD3ByIYy8fBCU3KXiuZdvbmkRPr/MAA8u6aXzY/4yqx3jB3ca7eecI0yM/N0NuEeY953V1D/ocLlllsDydkcrbVuS5VdsCXUX89TSqtVtMRImaaLAjhO6sbZKeRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRj3FgSG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRj3FgSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5D7C2BD01;
	Mon, 18 May 2026 23:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147688;
	bh=KKZL2OHisyq4/jWatQDQLTgpqORuvrm8mIvvroFoPfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRj3FgSGn0QTuJ4QtADEn6UIsfBkFbNKw1QGeKV170zq2UZZUtpuMFxtI7Bu6gB+j
	 duhpkUPWlGHjjibjtIaZqpwvh8i8J0TGl0mcFno0V1HQNdTxh2xCGvPAAtGj1wl05Y
	 pwYj14brGvx13Fikk2FvZ4uj2nw8lTXWm8+FukXlrqsKTvS7psYO1OY8gHvCebp0F9
	 um0MZTICJlSEovyZJ+0LicqDLejx0BGzLZjh0XXXEaFClDBSYFXD8BDA8WeZA0XnE3
	 fr9DNSYyITyMGpUIHh9LmyGnLnBIUkfOy1f99wZrsR12Eqr/qVpk2Sdej8Tb+EVvw8
	 EUbVDg4/KY1ww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/28] mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/
Date: Mon, 18 May 2026 16:41:03 -0700
Message-ID: <20260518234119.97569-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
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
 mm/damon/sysfs-schemes.c | 67 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0d3021db0b99b..3b66c3a757b2a 100644
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
@@ -163,6 +216,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	struct damon_sysfs_scheme_region *r, *next;
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
+		damos_sysfs_region_rm_dirs(r);
 		list_del(&r->list);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
@@ -2995,12 +3049,17 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
-				sysfs_regions->nr_regions)) {
-		kobject_put(&region->kobj);
-		return;
-	}
+				sysfs_regions->nr_regions))
+		goto out;
+	if (damos_sysfs_region_add_dirs(region))
+		goto out;
+
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
+	return;
+
+out:
+	kobject_put(&region->kobj);
 }
 
 int damon_sysfs_schemes_clear_regions(
-- 
2.47.3
