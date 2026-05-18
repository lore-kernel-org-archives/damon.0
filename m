Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49234BA5A;
	Mon, 18 May 2026 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147689; cv=none; b=irdy2z6nxPyaHctoIGrwlvkJS1t9+e3qwvOpLNxnrWYOImwK63E/5TgkSXHQG7v6ws76HyboB9I2S4v3M+CFjeTYwxfplWFmCnp/k9/036ZVAmBd8StxduqpcRGhfgHlyKck1M9SMkBs4oWseUTTDHjOvJ0Kdp3OXkrh+ekcTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147689; c=relaxed/simple;
	bh=n2uNzQcVMV3fWGsTPMWuHPA3jhhhlDZQTIQ6T7mMfXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLkjiCzr2qfsD6Crz6E3BQI66SZY9KBYk7zHChR+5axT6WrE0fpgLyiSRQQH80jUAi2/njCfg8m9jm/keAJB/8UtQo7jdj5l8Longs9fL01OW9KQmjhNINfKTluwqCGrL1z6sO0/eUTzbpdrBextnX02+RUUXWkJk2Up7uBnzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjR/lpox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjR/lpox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68752C2BCB7;
	Mon, 18 May 2026 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147689;
	bh=n2uNzQcVMV3fWGsTPMWuHPA3jhhhlDZQTIQ6T7mMfXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjR/lpoxix/85FF+0PAloLY57l8+Q19co9p89ktpyNPf+wpZhbsqlUmDHamtH1aMN
	 kzcpPe+2Sfwk+ryGfm8N0axxC37D3K6DL/G3uEUeg0aXI6NwcKRlWxUYq1QiEyZu0M
	 wzScwkrVtYfpmlPcjQG5U39FoWMWjDB9dMY7cG427SnloDZvTemSJyY9TP+0aFDKeM
	 Cg2X7bqWqUMU7bdoIompn3sOdM0GDgUmCNBSQsVtv53htkHeScZjOme9DlYC5F3kZh
	 eXz/+HYqVbQSEbvpQvi0W1nee0dH8/zbRHE5apH1dfj9nhqpjvfVoYxRRPIIDE65TK
	 suRhmy7cERGIQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 17/28] mm/damon/sysfs-schemes: implement probe/hits file
Date: Mon, 18 May 2026 16:41:05 -0700
Message-ID: <20260518234119.97569-18-sj@kernel.org>
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

Implement sysfs file for showing the per-region per-probe hits count.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7e21e78d77512..e25f4824b72fd 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -16,11 +16,27 @@
 
 struct damos_sysfs_probe {
 	struct kobject kobj;
+	unsigned char hits;
 };
 
-static struct damos_sysfs_probe *damos_sysfs_probe_alloc(void)
+static struct damos_sysfs_probe *damos_sysfs_probe_alloc(unsigned char hits)
 {
-	return kzalloc_obj(struct damos_sysfs_probe);
+	struct damos_sysfs_probe *probe;
+
+	probe = kzalloc_obj(*probe);
+	if (!probe)
+		return NULL;
+	probe->hits = hits;
+	return probe;
+}
+
+static ssize_t hits_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damos_sysfs_probe *probe = container_of(kobj,
+			struct damos_sysfs_probe, kobj);
+
+	return sysfs_emit(buf, "%hhu\n", probe->hits);
 }
 
 static void damos_sysfs_probe_release(struct kobject *kobj)
@@ -31,9 +47,19 @@ static void damos_sysfs_probe_release(struct kobject *kobj)
 	kfree(probe);
 }
 
+static struct kobj_attribute damos_sysfs_probe_hits_attr =
+		__ATTR_RO_MODE(hits, 0400);
+
+static struct attribute *damos_sysfs_probe_attrs[] = {
+	&damos_sysfs_probe_hits_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_probe);
+
 static const struct kobj_type damos_sysfs_probe_ktype = {
 	.release = damos_sysfs_probe_release,
 	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_probe_groups,
 };
 
 /*
@@ -64,7 +90,7 @@ static void damos_sysfs_probes_rm_dirs(struct damos_sysfs_probes *probes)
 }
 
 static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
-		struct damon_ctx *ctx)
+		struct damon_ctx *ctx, struct damon_region *region)
 {
 	struct damon_probe *probe;
 	struct damos_sysfs_probe **probes_arr;
@@ -86,7 +112,7 @@ static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
 		struct damos_sysfs_probe *sys_probe;
 		int err;
 
-		sys_probe = damos_sysfs_probe_alloc();
+		sys_probe = damos_sysfs_probe_alloc(region->probe_hits[i]);
 		if (!sys_probe) {
 			damos_sysfs_probes_rm_dirs(probes);
 			return -ENOMEM;
@@ -150,7 +176,8 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 
 static int damos_sysfs_region_add_dirs(
 		struct damon_sysfs_scheme_region *region,
-		struct damon_ctx *ctx)
+		struct damon_ctx *ctx,
+		struct damon_region *dregion)
 {
 	struct damos_sysfs_probes *probes = damos_sysfs_probes_alloc();
 	int err;
@@ -161,7 +188,7 @@ static int damos_sysfs_region_add_dirs(
 			&region->kobj, "probes");
 	if (err)
 		goto fail;
-	err = damos_sysfs_probes_add_dirs(probes, ctx);
+	err = damos_sysfs_probes_add_dirs(probes, ctx, dregion);
 	if (err)
 		goto fail;
 
@@ -3140,7 +3167,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions))
 		goto out;
-	if (damos_sysfs_region_add_dirs(region, ctx))
+	if (damos_sysfs_region_add_dirs(region, ctx, r))
 		goto out;
 
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
-- 
2.47.3
