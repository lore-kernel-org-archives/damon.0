Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304F407582;
	Thu, 14 May 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767764; cv=none; b=k/1oEQuaY+Jc33X+BtNWDqQDmacy7QYBaPqGlOUUrAql7IBlabYVaYy9mOWLnjxF6rHSZF/+WXWfQEvTwSvXxll3Tum8C4+pcdLP2nKSAVthH81OOgHq3Omp3/ukN2vvOF7xqxHibDlVeiK90VSoht2rkTbwnJOtiAN7FhdnFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767764; c=relaxed/simple;
	bh=89p7VKEE57qMrXeaBH1JYG+SiM8t+cBg5/D++ThSauo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBaBnYsX9UlzZFCALMbjP5UrP1ssXTbOuvntrDypj/7LNfs40pV2m5+u7UP9Mlj9zs4ob5+YsEUjbRfDGD9zrJ2whwtKLMo9oHWB5e4cE9HPl67lD3+oLLthym4XivSRuF1ZTGafxxjyIFl4V5EI60Loy5VByCT8li2yFfLm57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjWa/rXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjWa/rXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3CAC2BCC9;
	Thu, 14 May 2026 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767763;
	bh=89p7VKEE57qMrXeaBH1JYG+SiM8t+cBg5/D++ThSauo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjWa/rXb1qoH8kypKKJ7p3MzG43B5n2MeSMwpEg9YCyPXz2pzJC6zrJOwaYU9QGwF
	 fgEnGaeQFHdopwLnGWEboGXYkbEWCcG9kRE3ju7mfvkDicroFQKFTffZPzZXbIev8r
	 3GjMRDLJZ95aI2kMmgRU9cmNw2RofGx/nnRgiZ/OPzA2i/70kgG8ULnOsphn73Odm1
	 6gEPS+w+plg/Yr8d5qnCTPotG+EGlasug8lABtwSSPEENNm1TULmcjqge2BRpLUV6g
	 0uXZSQacT1Jg06codaDwW284ruPk74U1uK02Hk8Rcxdpb4xkTFojVbqWD6EBEV0PjU
	 upgN5hz+0G79A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 17/28] mm/damon/sysfs-schemes: implement probe/hits file
Date: Thu, 14 May 2026 07:08:50 -0700
Message-ID: <20260514140904.119781-18-sj@kernel.org>
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

Implement sysfs file for showing the per-region per-probe hits count.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 91d6ddcf1b32d..43a8224d991e8 100644
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
 
@@ -3143,7 +3170,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions))
 		goto out;
-	if (damos_sysfs_region_add_dirs(region, ctx))
+	if (damos_sysfs_region_add_dirs(region, ctx, r))
 		goto out;
 	return;
 
-- 
2.47.3
