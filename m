Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5701348463;
	Sat, 16 May 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956650; cv=none; b=uhIlcy2ePPabs6+eG5hfgh2PWJz2CupfhgvWMIIBCYCD4MdyUlniQAqh9EoXDl30zW7n0PvzSymygJjPdlUOHjzEzggI4knHHXQOf9jlnRrVbIt/vqQON9sTTFlVVXlIErqowTBCiIA4vBSXmkGYf8+pBYEw7gxozoo71KaWYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956650; c=relaxed/simple;
	bh=uBWhjIohq11XfMogSOrNzs3xASVaFicaEYRMR65bdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkY3wDkbed9/3xiDK+dOsYsPEo8Axw/ub62DRo5iOnMVwbsgl5l0KFLTdBG1EbmU82DsbPzHv6qiBVZs1DnpxChJyYCsqIvWtaqLZArX8ynH6KzWJ0x4PL0FvINk5PYag/TwuY7pRdOny2lYcswLtySyVBIl42LCLiA2Vtahclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc6CQKYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc6CQKYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D1C2BD04;
	Sat, 16 May 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956649;
	bh=uBWhjIohq11XfMogSOrNzs3xASVaFicaEYRMR65bdGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qc6CQKYdFQbvC3v2l7Z69OzjNq2n3nvs/9lwdPFXtPNbXoPox1kL1R67loOoA3lEN
	 aGICXkkdk/4hk9QmC6u7J3/Y4ckHNR6Yj/X411FGYphmw9oObyNJsji2YAzKV+u86g
	 wa+K/GfKwlZrI4SzdF1PDxMxY38uJbEBJHE2gkW5bAxyMAai43hmqXgEVKTCx4bmxE
	 EWkY83RopMO+aqT7qSLyWw626UunmvGaAetHm2Nlzxn/OaYHcbcVtSR8q6cNgDy0xX
	 mVkxG+LguCUZLb6b+R377HwluHwHRgviUFCvTnVU4FViCWlWMnAzeizDmpVrEcXu1O
	 6N2X0fmLhp62A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 15/28] mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/
Date: Sat, 16 May 2026 11:36:56 -0700
Message-ID: <20260516183712.81393-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
 mm/damon/sysfs-schemes.c | 70 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 245d63808411a..8998df5bdc5c8 100644
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
@@ -2927,14 +2981,20 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (!region)
 		return;
 	region->sz_filter_passed = sz_filter_passed;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
-				sysfs_regions->nr_regions++)) {
-		kobject_put(&region->kobj);
-	}
+				sysfs_regions->nr_regions++))
+		goto out;
+	if (damos_sysfs_region_add_dirs(region))
+		goto out;
+
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
+	return;
+
+out:
+	kobject_put(&region->kobj);
 }
 
 int damon_sysfs_schemes_clear_regions(
-- 
2.47.3
