Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF9489FC0;
	Thu, 10 Sep 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049942; cv=none; b=CFELbFxNq8rj3wb+sksJB/uFb3B5RrhpPrnFOrTY/3ys/EGQR/HNe2l3vv4LI7VHTwpKraJ9PBAdjxy3pSwNLXPSGdNIvzivK9adY0q8ARQA5KMf3d5fX0jzm9CQERoee07erPEpoyQFE64keXTPdQSrJNeC+EEXCPiLvjMB66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049942; c=relaxed/simple;
	bh=fgvSLC/gXautyKR9CQkvAKHXgVlLvuXKciF4/d8Tuao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpKV6rSNp3Wn5lLhDmv5v8tPAWEAQ+tLRYWLcfm9w9ylCc4mp5jdL7P4TPCNiy+OnRxsW6P09ZMV8G1qOmDcnF+ICGvX/5VYtnou3W5ZfseROm0AbCDA7BGGYG9mH2QlB3CO8MlMgOsBMhfA7N0aJdC350ouI5umdiq4qfKyEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZmGB171; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZmGB171"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9501F00899;
	Thu, 10 Sep 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049941;
	bh=ILNnV2GNeZ514oIRb82a8/magMxY2v4d8tE00F50zJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZmGB171Z8YtFpiMyv6D5GxB4EDZwCezzp+D6uct9Plsd8XSd0XAavCRhmEPsIQLn
	 FSrnIvak9wyOjMLczs70ISJMJ2ZgJ4/nya0ShwsKxx5TdvWFabSEPgUDI4BuNMirx5
	 klfl9h607/UrENPnEa8y4ft+oQ3FUHtB6Y7unzxNOZvqvhAIxO58wphDL3+suC9S37
	 OwRbNvWBRWcid7PK/Xh/xutRV6bjNycuyFeHBWU+bjRIDuLyEjXFcmpwfcfiEenEN/
	 1W/qJK1uBX3BIexhGr6xI3LwY0ULqB37eZJT1b7qJLGrN/KEM6Crcw00lOixOlsDVq
	 glMPiN9V0ehNw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon/sysfs-schemes: rename sysfs_filter->sz_range to range_{min,max}
Date: Thu, 10 Sep 2026 07:18:44 -0700
Message-ID: <20260910141849.170896-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface provides 'min' and 'max' files under the DAMOS
filter directory.  The purpose is setting the general range arguments
for hugepage_size like filters that require range arguments.  So far,
hugepage_size was the only filter using it.  Hence sz_range field of
damon_sysfs_scheme_filter struct was connected to the files.

In future, we could add a new filter that can reuse the 'min' and 'max'
files.  And the filter might use a range of a type that is not size. For
example, probe_hits weighted sum.  In this case, simply reusing the
sz_range field would make it a little confusing.  Rename sz_range to
range_{min,max} to avoid such confusion.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d9b81d7b5910e..4d9147d2a269e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -534,7 +534,8 @@ struct damon_sysfs_scheme_filter {
 	bool allow;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
-	struct damon_size_range sz_range;
+	unsigned long range_min;
+	unsigned long range_max;
 	int target_idx;
 };
 
@@ -588,6 +589,7 @@ damos_sysfs_filter_type_names[] = {
 		.type = DAMOS_FILTER_TYPE_TARGET,
 		.name = "target",
 	},
+
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -778,7 +780,7 @@ static ssize_t min_show(struct kobject *kobj,
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
 
-	return sysfs_emit(buf, "%lu\n", filter->sz_range.min);
+	return sysfs_emit(buf, "%lu\n", filter->range_min);
 }
 
 static ssize_t min_store(struct kobject *kobj,
@@ -786,7 +788,7 @@ static ssize_t min_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	int err = kstrtoul(buf, 0, &filter->sz_range.min);
+	int err = kstrtoul(buf, 0, &filter->range_min);
 
 	return err ? err : count;
 }
@@ -797,7 +799,7 @@ static ssize_t max_show(struct kobject *kobj,
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
 
-	return sysfs_emit(buf, "%lu\n", filter->sz_range.max);
+	return sysfs_emit(buf, "%lu\n", filter->range_max);
 }
 
 static ssize_t max_store(struct kobject *kobj,
@@ -805,7 +807,7 @@ static ssize_t max_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	int err = kstrtoul(buf, 0, &filter->sz_range.max);
+	int err = kstrtoul(buf, 0, &filter->range_max);
 
 	return err ? err : count;
 }
@@ -2835,12 +2837,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-			if (sysfs_filter->sz_range.min >
-					sysfs_filter->sz_range.max) {
+			if (sysfs_filter->range_min >
+					sysfs_filter->range_max) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->sz_range = sysfs_filter->sz_range;
+			filter->sz_range.min = sysfs_filter->range_min;
+			filter->sz_range.max = sysfs_filter->range_max;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
