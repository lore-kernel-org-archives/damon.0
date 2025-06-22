Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A747221578;
	Sun, 22 Jun 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628286; cv=none; b=lwHzCMMa97egBZU6A8mibruqyArFFFrQ3qGvnBPpBxc1fvJqcEl5PPrwBeGK6KpWk5psRUBxblhyXSuZPGh2BqmuAd2cUhdXYN5mfmLBgAqk3lXixUCSlGU6Amev7E4IFg6pTKzHgVE0TmWVvjlDInZKk2WEMQ20cIM7jexIdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628286; c=relaxed/simple;
	bh=9OzPivFmaJWkkCm6QPhirCH8VNjpNc3g3HIvaejTiTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZ2/Li15wfOSZCkx6VGw3DJvU5wYoHupZEdfxcdTtj5DhKMw/PJZM5HpN7TU9KNbV22Z9eklUS8s8x5uJO/MhYKqXcy4CTrz/EFrvug1YAmgTgh3wgIqmFQJaHUXfCLYW0kWcyNSYk3knavsNcyNwJ31wZT4F0P65L4m826mU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjQLvGNb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjQLvGNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C7C4CEF6;
	Sun, 22 Jun 2025 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750628286;
	bh=9OzPivFmaJWkkCm6QPhirCH8VNjpNc3g3HIvaejTiTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjQLvGNbe332yCCNHs8+KaS/WCmJkhE+IWTVPYvqRTGB2bji6mGZvrbdaYjcXMxg3
	 5sqDgiUba/usNxk+EiVMik9AfWP1B72k9NGXEha76+YsOAmUwCDot79XMKoqzzM1jz
	 vgiMM3g13W7ZczlDZrfSdReJKOXq78RBxgHJKUuK9/fZbJ3Nqh1rPx4ELhS5rv+1UY
	 ZbpeZbKPuuA582CZr/eppnlT0YD2VEm8+MFBETMhP+QyktJaJjmVmehCp0UgS5l6rP
	 sNPKMjTR4YNShSgP9YZkOMN5CA/xV0o38bFX0jvHZLV8F77bwh+BGOetbtn4lqKxH4
	 XyHGxwZCnjI9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] mm/damon/sysfs-schemes: decouple from damos_wmark_metric
Date: Sun, 22 Jun 2025 14:37:57 -0700
Message-Id: <20250622213759.50930-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622213759.50930-1-sj@kernel.org>
References: <20250622213759.50930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decouple DAMOS sysfs interface from damos_wmark_metric.  For this,
define and use new sysfs-schemes internal data structure that maps the
user-space keywords and damos_wmark_metric, instead of having the
implicit and unflexible array index rule.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 41 ++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 117d27544173..3d42d24bb33a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -785,10 +785,21 @@ static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
 	return watermarks;
 }
 
-/* Should match with enum damos_wmark_metric */
-static const char * const damon_sysfs_wmark_metric_strs[] = {
-	"none",
-	"free_mem_rate",
+struct damos_sysfs_wmark_metric_name {
+	enum damos_wmark_metric metric;
+	char *name;
+};
+
+static const struct damos_sysfs_wmark_metric_name
+damos_sysfs_wmark_metric_names[] = {
+	{
+		.metric = DAMOS_WMARK_NONE,
+		.name = "none",
+	},
+	{
+		.metric = DAMOS_WMARK_FREE_MEM_RATE,
+		.name = "free_mem_rate",
+	},
 };
 
 static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -796,9 +807,16 @@ static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
 			struct damon_sysfs_watermarks, kobj);
+	int i;
 
-	return sysfs_emit(buf, "%s\n",
-			damon_sysfs_wmark_metric_strs[watermarks->metric]);
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_wmark_metric_names); i++) {
+		const struct damos_sysfs_wmark_metric_name *metric_name;
+
+		metric_name = &damos_sysfs_wmark_metric_names[i];
+		if (metric_name->metric == watermarks->metric)
+			return sysfs_emit(buf, "%s\n", metric_name->name);
+	}
+	return -EINVAL;
 }
 
 static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -806,11 +824,14 @@ static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
 			struct damon_sysfs_watermarks, kobj);
-	enum damos_wmark_metric metric;
+	int i;
 
-	for (metric = 0; metric < NR_DAMOS_WMARK_METRICS; metric++) {
-		if (sysfs_streq(buf, damon_sysfs_wmark_metric_strs[metric])) {
-			watermarks->metric = metric;
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_wmark_metric_names); i++) {
+		const struct damos_sysfs_wmark_metric_name *metric_name;
+
+		metric_name = &damos_sysfs_wmark_metric_names[i];
+		if (sysfs_streq(buf, metric_name->name)) {
+			watermarks->metric = metric_name->metric;
 			return count;
 		}
 	}
-- 
2.39.5
