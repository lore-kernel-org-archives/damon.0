Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD59221F17;
	Sun, 22 Jun 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628287; cv=none; b=QxTyuSTl/OaqcWhm3OPvqss6IP30LHeHHql7aaXEuvdaTu6PaxWNJHprbYIiiqZ5P18Rtqsb2kYGjUF+pxFCBwW4eNGwgUPq4iFG98eEjHQyGeucS8R3Pc11CnI3j0p/W9NLmZiDkiSkMFnPDjRZQrqknaSjq0IL3MDaxCS5HOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628287; c=relaxed/simple;
	bh=hoaJf6LTS/M19C68gmFwoJKbJwBssOw4AFc9E/nGoAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUu0yOYr/GYDBDgKIcemK6AUC6xWEGC8BD2o3WfnX7Hrm0FBGIo6DQrx90Oz0Bi0MlfinHUIOrlHGP31hJeq7MHEh075ZKU2CDGx5UJrQ75yRAsn45uSDErFgNsOk/QNvtVs4TH+dT0/EYBt0wHp0o2rWaZE5ZlmFn4zeoj3L2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kek/JUaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kek/JUaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8AEC4CEF1;
	Sun, 22 Jun 2025 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750628287;
	bh=hoaJf6LTS/M19C68gmFwoJKbJwBssOw4AFc9E/nGoAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kek/JUaHvhnRV+TgYEcPUyum/L0sgKl2hAG2236Vda5DzmDVB57UTVZfFdJ7a9aYK
	 u9nZkEzJMsEtEq2yJZP4IekQ+68tHVj1/cHjocA3MMmsZUaSMsaCttdvRXm7aQuehh
	 Sn3nzQVPBhHysMdTQCGTvXvJFznPe4MZ7X3fYHtdYwYZYp/QCrYVWkhMFKVA3saDkD
	 CKHcBwaPPusaE8yunMo91b6Gu6WKqW3AUBHV25HnNzWBuT/GUONTRaAxoXqHyFlZ66
	 QQGtNsw4+Fg2RwdUCdIe6ZC/FQ5MIDqmcBQhTPgvVCAYDftIv0o+VDVrbb0MvOwm1J
	 j1N8hoQt4tzZg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] mm/damon/sysfs-schemes: decouple from damos_filter_type
Date: Sun, 22 Jun 2025 14:37:58 -0700
Message-Id: <20250622213759.50930-5-sj@kernel.org>
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

Decouple DAMOS sysfs interface from damos_filter_type.  For this, define
and use new sysfs-schemes internal data structure that maps the
user-space keywords and damos_filter_type, instead of having the
implicit and unflexible array index rule.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 75 ++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3d42d24bb33a..5243b94cec24 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -341,16 +341,45 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(
 	return filter;
 }
 
-/* Should match with enum damos_filter_type */
-static const char * const damon_sysfs_scheme_filter_type_strs[] = {
-	"anon",
-	"active",
-	"memcg",
-	"young",
-	"hugepage_size",
-	"unmapped",
-	"addr",
-	"target",
+struct damos_sysfs_filter_type_name {
+	enum damos_filter_type type;
+	char *name;
+};
+
+static const struct damos_sysfs_filter_type_name
+damos_sysfs_filter_type_names[] = {
+	{
+		.type = DAMOS_FILTER_TYPE_ANON,
+		.name = "anon",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_ACTIVE,
+		.name = "active",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_MEMCG,
+		.name = "memcg",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_YOUNG,
+		.name = "young",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
+		.name = "hugepage_size",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_UNMAPPED,
+		.name = "unmapped",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_ADDR,
+		.name = "addr",
+	},
+	{
+		.type = DAMOS_FILTER_TYPE_TARGET,
+		.name = "target",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -358,9 +387,16 @@ static ssize_t type_show(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
+	int i;
 
-	return sysfs_emit(buf, "%s\n",
-			damon_sysfs_scheme_filter_type_strs[filter->type]);
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_filter_type_names); i++) {
+		const struct damos_sysfs_filter_type_name *type_name;
+
+		type_name = &damos_sysfs_filter_type_names[i];
+		if (type_name->type == filter->type)
+			return sysfs_emit(buf, "%s\n", type_name->name);
+	}
+	return -EINVAL;
 }
 
 static bool damos_sysfs_scheme_filter_valid_type(
@@ -385,16 +421,19 @@ static ssize_t type_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	enum damos_filter_type type;
 	ssize_t ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_filter_type_names); i++) {
+		const struct damos_sysfs_filter_type_name *type_name;
 
-	for (type = 0; type < NR_DAMOS_FILTER_TYPES; type++) {
-		if (sysfs_streq(buf, damon_sysfs_scheme_filter_type_strs[
-					type])) {
+		type_name = &damos_sysfs_filter_type_names[i];
+		if (sysfs_streq(buf, type_name->name)) {
 			if (!damos_sysfs_scheme_filter_valid_type(
-						filter->handle_layer, type))
+						filter->handle_layer,
+						type_name->type))
 				break;
-			filter->type = type;
+			filter->type = type_name->type;
 			ret = count;
 			break;
 		}
-- 
2.39.5
