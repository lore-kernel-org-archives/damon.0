Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166AC1E3780;
	Mon,  6 Jan 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192065; cv=none; b=jnE/pcUQGDZBCoSlRMquXoNA8KfShVdELtZWzqUiVPvjZaD/g9guERDBsgkc0Hc9IqiLiibwovoJB4KNGfTSzgtOYVaA6/F5E38HQHMfPFHgBSRL0sVf5lOT2XxKM7TImo5drIHLoVHbbBPQg+l6XSdisIPSvM1df2tYZoJozXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192065; c=relaxed/simple;
	bh=+UnPb4bwnUVNPuDwxrpYf9x2zFG7e9vQ76jJhD49ioc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=My0i6Av/PMKOoHimEpVbAWwpgfUHW9CKmefON/+u38KrjMqF4WI5VOpspygCLhnXwl+EakA9mzbNa6suhzuaG5Vx1E8hHYgAyq0nPcrFgr+xDH0zotoLpJimTZRQQRCKDRIs8jnUWeWHukkSkFvdpooBRwv+r5Fvd0rwl2Td2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC/FZfn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC/FZfn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC58C4CEDF;
	Mon,  6 Jan 2025 19:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192064;
	bh=+UnPb4bwnUVNPuDwxrpYf9x2zFG7e9vQ76jJhD49ioc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC/FZfn4gnh9kGmSK6sjIH4jQ+kDiy0+R/V2rDZn+xwanzRwkdrnAeucKOZd1ufy+
	 h5+EjyLMVEdHz9KxNqreWlOB+2Zqiu53nN+pdSRacNHAZWZ+WdJYsWY7/3VP6A4NLe
	 ooiY/3Qdfqc7Os+3HMWzWcXi4pADb61s/DN1tU7Ks0DJ5DcJs+I4LwdNwP0ZP7tPqB
	 4QdMm2jrGAkD9GFSNYWhwKZjaEmi0FpUpbJRDwgsbLtLpygprb5+iJL2+baV3JmqgX
	 q/jIRQ0hwKVsuAwvI/Lhm6cJDVqESD1ra/fE6jBaolwGzQrhMjHm2ZjVwq7mv7tDCQ
	 YIHG1bbNWD1UA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/16] mm/damon/sysfs-schemes: expose per-region filter-passed bytes
Date: Mon,  6 Jan 2025 11:33:58 -0800
Message-Id: <20250106193401.109161-14-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per-region operations set-handled DAMOS filters passed memory size
information is provided to only DAMON core API users.  Further expose it
to the user space by adding a new DAMON sysfs interface file under each
scheme tried region directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 +-
 mm/damon/sysfs-schemes.c | 19 ++++++++++++++++++-
 mm/damon/sysfs.c         |  3 ++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index b3f63bc658b7..70d84bdc9f5f 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -48,7 +48,7 @@ void damon_sysfs_schemes_update_stats(
 void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s,
-		bool total_bytes_only);
+		bool total_bytes_only, unsigned long sz_filter_passed);
 
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b447c412b02c..deeaf23c1fcf 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -19,6 +19,7 @@ struct damon_sysfs_scheme_region {
 	struct damon_addr_range ar;
 	unsigned int nr_accesses;
 	unsigned int age;
+	unsigned long sz_filter_passed;
 	struct list_head list;
 };
 
@@ -74,6 +75,15 @@ static ssize_t age_show(struct kobject *kobj, struct kobj_attribute *attr,
 	return sysfs_emit(buf, "%u\n", region->age);
 }
 
+static ssize_t sz_filter_passed_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+
+	return sysfs_emit(buf, "%lu\n", region->sz_filter_passed);
+}
+
 static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 {
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
@@ -95,11 +105,15 @@ static struct kobj_attribute damon_sysfs_scheme_region_nr_accesses_attr =
 static struct kobj_attribute damon_sysfs_scheme_region_age_attr =
 		__ATTR_RO_MODE(age, 0400);
 
+static struct kobj_attribute damon_sysfs_scheme_region_sz_filter_passed_attr =
+		__ATTR_RO_MODE(sz_filter_passed, 0400);
+
 static struct attribute *damon_sysfs_scheme_region_attrs[] = {
 	&damon_sysfs_scheme_region_start_attr.attr,
 	&damon_sysfs_scheme_region_end_attr.attr,
 	&damon_sysfs_scheme_region_nr_accesses_attr.attr,
 	&damon_sysfs_scheme_region_age_attr.attr,
+	&damon_sysfs_scheme_region_sz_filter_passed_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_region);
@@ -2105,12 +2119,14 @@ void damon_sysfs_schemes_update_stats(
  * @r:			DAMON region to populate the directory for.
  * @s:			Corresponding scheme.
  * @total_bytes_only:	Whether the request is for bytes update only.
+ * @sz_filter_passed:	Bytes of @r that passed filters of @s.
  *
  * Called from DAMOS walk callback while holding damon_sysfs_lock.
  */
 void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos *s, bool total_bytes_only)
+		struct damon_region *r, struct damos *s, bool total_bytes_only,
+		unsigned long sz_filter_passed)
 {
 	struct damos *scheme;
 	struct damon_sysfs_scheme_regions *sysfs_regions;
@@ -2135,6 +2151,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	region = damon_sysfs_scheme_region_alloc(r);
 	if (!region)
 		return;
+	region->sz_filter_passed = sz_filter_passed;
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 224873ca8aa6..deeab04d3b46 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1461,7 +1461,8 @@ static void damon_sysfs_schemes_tried_regions_upd_one(void *data, struct damon_c
 
 	damos_sysfs_populate_region_dir(
 			sysfs_kdamond->contexts->contexts_arr[0]->schemes,
-			ctx, t, r, s, walk_data->total_bytes_only);
+			ctx, t, r, s, walk_data->total_bytes_only,
+			sz_filter_passed);
 }
 
 static int damon_sysfs_update_schemes_tried_regions(
-- 
2.39.5
