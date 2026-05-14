Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5C3624A3;
	Thu, 14 May 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767764; cv=none; b=u0jAChPMtBACDzOC//FWmbzlHYHc5UtK2gRzCVAwtup+vSvSK6Xux7mCD282v6KmscPLVXDrHDstx+/UD2jlKySc1OrgaXH0+l9vbfrBJzr41xVVY5oUWvoWFVJx0+m8NlUf41bXR3kLqH0G+mRtXRJo2QdSf/Sm+fDDz1UxfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767764; c=relaxed/simple;
	bh=9wtcGKd2TuBKZzqqapx90lRnyNtTZA2HcxLo0K3VUw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzqHzmAahOoSyeZRyW6q/Rth8M26jdYbqNZiMLIn5N6ZUrz7JIizdJrBD9KXbb545UQWF0b30aHe6+AXC5EawOJzScwOkiF+QJM6p9+19J6gBPZH7jCjZOG5ucsb0CmbOxrx6NNsqgWVPuYkp9cWdqTHFargwRO5h33YFpOr7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4RxI1Sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4RxI1Sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADCCC2BCB3;
	Thu, 14 May 2026 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767763;
	bh=9wtcGKd2TuBKZzqqapx90lRnyNtTZA2HcxLo0K3VUw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4RxI1Sr+Oi1uIxX486NzJf6dWhHzlpc28+YtDhju6ZSxfKzMGhdhjsFngntH5tbX
	 4CUowp6L33KlsDnUUu0KAWjSlPOcu3kVviKWH/kjUdbFnK4b0tsaF0i4VSJXIZyRTs
	 BbksGSFQ/0I1ywkl9Pya3g0hSMjzrrmnmgfIptdsZ2czrgK00IYcXBNozEHO/KVbUa
	 ZxzOyU00fLB8WxvhaCL+qUYfEh5z8gOqovcd+jWgr9xfwkxLN9qPbLo1Te3N+0s+7s
	 +YYKizlQ75adz31sANHe2gbVn0S0Iz4Ua6dxoCCvJhEu7y1BIrEdVjZgoM9G+MXPsZ
	 qq/FX5okWoFEw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 15/28] mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/
Date: Thu, 14 May 2026 07:08:48 -0700
Message-ID: <20260514140904.119781-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
