Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FF35DA46;
	Sat, 16 May 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956652; cv=none; b=T9T9SVyozooOTSEBsH48lHn+7MEBbLzrMXC7MDSWXlBr/tyWHQS2CdQy6KHcTGamVNZka8qnvQz+2C7MwatoCIiek9C3yP27Nos9MmF+L+Pac6jaPm0Ne6+umlGDsSf4YQCazzU7VUfQzIpAecK3fYy1+kymQ3YxypILZrFAE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956652; c=relaxed/simple;
	bh=Q1zGK+j0zRxUsiCpVVG1d65SmG54MWL9Bnun2Pc3YCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olmsRtg9QT1CmzojHY6x2JGyG/CwaHYkpDkvOorYPzIFwiXdk9C3APRD4I2EPW9/ZElg9/g49UXV44qYWZBGgU3XjojYnH8RGuemV8zk0fuLr702qyvggC6IdzsN3DSAKyQ+x0B+VSi8AvsxJ0VUscRPcrWzngIgEAeWQLqi6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgk4pAO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgk4pAO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24A1C2BCC9;
	Sat, 16 May 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956650;
	bh=Q1zGK+j0zRxUsiCpVVG1d65SmG54MWL9Bnun2Pc3YCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgk4pAO0Tio/zVHiiJjeEDVPmohekNsu4jCaZFUkcKxwAiGeUCS1LpoSmZ4K20a6A
	 vpmNETg0uEdXEsXiYlnkL+rrO6MuwEEZEG4jxUJgynoP1fuPD4ECVSuLHD47nKUg/i
	 4r7I8zlWfuN+xrAOVIFRsQcAVIabQ+5JNmdR8lNdtbj9nmj9dyy9o4hnPMa1T0Z7wP
	 p9BAHwg8XMp2Q+P76ecbC8o6P4ozTkETV3F8vOF8PeWPCJaqCROYFU2Hkz+sRP8jQ+
	 sFEE8JOlEp7M2bVfgGzRI2KV9wHL/Q4mVsmINqp9bD+8ztFv+SnoLd9vpHnXUmhdPb
	 jhkec0cKpP9yw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 16/28] mm/damon/sysfs-schemes: implement probe dir
Date: Sat, 16 May 2026 11:36:57 -0700
Message-ID: <20260516183712.81393-17-sj@kernel.org>
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

Implement sysfs directory for showing per-probe hits count of each
region.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 101 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8998df5bdc5c8..c8123c62bbd48 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -10,12 +10,40 @@
 
 #include "sysfs-common.h"
 
+/*
+ * probe directory
+ */
+
+struct damos_sysfs_probe {
+	struct kobject kobj;
+};
+
+static struct damos_sysfs_probe *damos_sysfs_probe_alloc(void)
+{
+	return kzalloc_obj(struct damos_sysfs_probe);
+}
+
+static void damos_sysfs_probe_release(struct kobject *kobj)
+{
+	struct damos_sysfs_probe *probe = container_of(kobj,
+			struct damos_sysfs_probe, kobj);
+
+	kfree(probe);
+}
+
+static const struct kobj_type damos_sysfs_probe_ktype = {
+	.release = damos_sysfs_probe_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
 /*
  * probes directory
  */
 
 struct damos_sysfs_probes {
 	struct kobject kobj;
+	struct damos_sysfs_probe **probes_arr;
+	int nr;
 };
 
 static struct damos_sysfs_probes *damos_sysfs_probes_alloc(void)
@@ -23,6 +51,60 @@ static struct damos_sysfs_probes *damos_sysfs_probes_alloc(void)
 	return kzalloc_obj(struct damos_sysfs_probes);
 }
 
+static void damos_sysfs_probes_rm_dirs(struct damos_sysfs_probes *probes)
+{
+	struct damos_sysfs_probe **probes_arr = probes->probes_arr;
+	int i;
+
+	for (i = 0; i < probes->nr; i++)
+		kobject_put(&probes_arr[i]->kobj);
+	probes->nr = 0;
+	kfree(probes_arr);
+	probes->probes_arr = NULL;
+}
+
+static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
+		struct damon_ctx *ctx)
+{
+	struct damon_probe *probe;
+	struct damos_sysfs_probe **probes_arr;
+	int i = 0;
+
+	damon_for_each_probe(probe, ctx)
+		i++;
+
+	if (!i)
+		return 0;
+
+	probes_arr = kmalloc_objs(*probes_arr, i);
+	if (!probes_arr)
+		return -ENOMEM;
+	probes->probes_arr = probes_arr;
+
+	i = 0;
+	damon_for_each_probe(probe, ctx) {
+		struct damos_sysfs_probe *sys_probe;
+		int err;
+
+		sys_probe = damos_sysfs_probe_alloc();
+		if (!sys_probe) {
+			damos_sysfs_probes_rm_dirs(probes);
+			return -ENOMEM;
+		}
+		err = kobject_init_and_add(&sys_probe->kobj,
+				&damos_sysfs_probe_ktype, &probes->kobj, "%d",
+				i);
+		if (err) {
+			kobject_put(&sys_probe->kobj);
+			damos_sysfs_probes_rm_dirs(probes);
+			return err;
+		}
+		probes_arr[i++] = sys_probe;
+		probes->nr++;
+	}
+	return 0;
+}
+
 static void damos_sysfs_probes_release(struct kobject *kobj)
 {
 	struct damos_sysfs_probes *probes = container_of(kobj,
@@ -67,7 +149,8 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 }
 
 static int damos_sysfs_region_add_dirs(
-		struct damon_sysfs_scheme_region *region)
+		struct damon_sysfs_scheme_region *region,
+		struct damon_ctx *ctx)
 {
 	struct damos_sysfs_probes *probes = damos_sysfs_probes_alloc();
 	int err;
@@ -76,18 +159,24 @@ static int damos_sysfs_region_add_dirs(
 		return -ENOMEM;
 	err = kobject_init_and_add(&probes->kobj, &damos_sysfs_probes_ktype,
 			&region->kobj, "probes");
-	if (err) {
-		kobject_put(&probes->kobj);
-		return err;
-	}
+	if (err)
+		goto fail;
+	err = damos_sysfs_probes_add_dirs(probes, ctx);
+	if (err)
+		goto fail;
 
 	region->probes = probes;
 	return 0;
+
+fail:
+	kobject_put(&probes->kobj);
+	return err;
 }
 
 static void damos_sysfs_region_rm_dirs(
 		struct damon_sysfs_scheme_region *region)
 {
+	damos_sysfs_probes_rm_dirs(region->probes);
 	kobject_put(&region->probes->kobj);
 }
 
@@ -2986,7 +3075,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions++))
 		goto out;
-	if (damos_sysfs_region_add_dirs(region))
+	if (damos_sysfs_region_add_dirs(region, ctx))
 		goto out;
 
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
-- 
2.47.3
