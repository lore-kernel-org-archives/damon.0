Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775D1AA791;
	Thu, 19 Dec 2024 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581036; cv=none; b=C8seL6wQyX/o6y1wly/CCf6QRTtYtY2N2pRUixTC1firXPn7CX81jQNXV3nJenHHDX+reKHm+tyZEY6WUJHyXlVFm6qdRtHe63HNDHO2XwOUqbMzABXwLW4j9ASd7lyvwyPs/u1dyIPamOo1NVGkJfVSjzfEy8zDgq1RavrVS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581036; c=relaxed/simple;
	bh=xGeZNDXz9ovPiTqa907jHI/cUugPY9TuP39+tm2J3DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNkgR8X+h/yM/moGOhg1dJ9y1RlK/cYmwwABsQ7x54ydnkOvC2gsMk2CdvOkgj3mDw5fMdAqzTFM5an9s8g9qSqU2JR7dzAp7IkUBlQndKzQDROypD5ubrrLjekTNAxAEIyMG5JTQSDHK4hrDnvAM1JnIXuY+nZDCWp3psAUT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaWwkoMs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaWwkoMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18E7C4CED4;
	Thu, 19 Dec 2024 04:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581036;
	bh=xGeZNDXz9ovPiTqa907jHI/cUugPY9TuP39+tm2J3DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaWwkoMsUq3M/9y90r30+fdbMg5W+Jtn+IphmKPouGNrvQno6svhKYfNY3O1U7Ziq
	 mNLcPEeBaJaRmMhQ7P0n3pYFyDzFAB73gPOufPWOX9UDzeyWcKaICVL7iUmEWSATe7
	 u4uhvb0Xa28UgL/G5fN94kmI5VZiaUP5dwaljPbJA2IDw9maXLrBc9vYve1lraJTFe
	 hXVB4X8EYz3EhThDwTJKR+DnvOfYdl9IRscCLTVQTEJp4AXzQ5bfEuYAZhu7TNbotZ
	 BXfCCDArHgTD+uNgbG4FaASYkOCjh5j3mXe0ia+BNc8RxmM4OHlZ4jaEgLN5l2S3S0
	 G9yqOBRNkt8Vw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/18] mm/damon/sysfs-schemes: expose per-region filter-passed bytes
Date: Wed, 18 Dec 2024 20:03:24 -0800
Message-Id: <20241219040327.61902-16-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
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
 mm/damon/sysfs-schemes.c | 18 +++++++++++++++++-
 mm/damon/sysfs.c         |  3 ++-
 3 files changed, 20 insertions(+), 3 deletions(-)

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
index b447c412b02c..1da0594dde55 100644
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
@@ -2110,7 +2124,8 @@ void damon_sysfs_schemes_update_stats(
  */
 void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos *s, bool total_bytes_only)
+		struct damon_region *r, struct damos *s, bool total_bytes_only,
+		unsigned long sz_filter_passed)
 {
 	struct damos *scheme;
 	struct damon_sysfs_scheme_regions *sysfs_regions;
@@ -2135,6 +2150,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
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

