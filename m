Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24C3C4B68;
	Tue, 12 May 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596624; cv=none; b=XQZ1IkrsaWVJzFFcla7PfGPfygkDuNqtxqvzHnR0m7Z3qbPwHlJomzI2AjnCA9utNlyUS0Uldecw+yXMjX/XO1PENxmjCj1h1BWqV4b3FuYDJfy3vpciW+hi5pJBwAdjcxo9WPDbbSTBZIgxxR0jZkgYv0WFXm3wUcFHrgBxpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596624; c=relaxed/simple;
	bh=89p7VKEE57qMrXeaBH1JYG+SiM8t+cBg5/D++ThSauo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aY1UmqYpb/mZHg5SsXsJ3Mwy0uGxZZjBTeonUdd9FP08oSt7UM5GVi4M/puqPANtbhVSmoa6xYNwiY8S7WVqeMvDD+CsS1hvrNEX1OWDL2Ds38QeHKhROf1TDHH4ZJVI/CZj0UJVIhYrPHouG8IRwJrYNlQHM2iJZ3bstK/QLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP1u2VxR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP1u2VxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D44C2BCFA;
	Tue, 12 May 2026 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596623;
	bh=89p7VKEE57qMrXeaBH1JYG+SiM8t+cBg5/D++ThSauo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP1u2VxRyoXl5WrUPagJC9d9rn8nyHY8H4jDSwk1qH+qEKcY/q4QSCXDTq7ct/VcV
	 APhVghtuetxSJFrgQiNkwJ4KqddJFjPwAcuziaE1BA7GVKTuROIqJ339i38H+hDZxr
	 Oz+t4IpQh6YpiTa5HHddBqV/N3y2IDNCJWUaCO9PBlvdRpe7bO8zAQQ5oyEyIfd5sf
	 DHn4iIq78MV3mwpepwc+QWt/yxclCYyn1rdeSArUdI4Dlzz0VmiWNtGdL/6Hllg6yp
	 MkYgU352Ae+bdWw5mYyHZoJYfGldeLVIpmLt7rU5IfF7+oU0G1JBlSjsa1MEOC39c5
	 ENh3RK6oPEzVg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 17/28] mm/damon/sysfs-schemes: implement probe/hits file
Date: Tue, 12 May 2026 07:36:32 -0700
Message-ID: <20260512143645.113201-18-sj@kernel.org>
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
