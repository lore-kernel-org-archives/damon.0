Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AB21FF3F;
	Sun, 22 Jun 2025 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628285; cv=none; b=BGA14fLLXWY4ynOIznUfg9H7tIjIzCGqDMg5LmxzBzOT0zpHrcq0A7+Vb5shPEjc3dbfEWoUOnJcvXJepTBQ85bDxtu6G2/41K2csqXhpsfvhAJpGdF/uBrMoPMORyuFYxZaqHIg1Fy+SRTp9oGFmEidMlNwDIyaMsP+OP6qMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628285; c=relaxed/simple;
	bh=ZYMeQoFGvpOlMGZ1tBRgXborsAE0j4pUGN4+GxrhYyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjO7q8dYaSYWQpqgHqz7szeZFiMVgeEA5s5T3TuuFeFSldCvZi1iR6E8Z7B2ypql6RA8ncg/JNyjWfOlitQ5zOdW6hRYkmr77TSAbrkCqmcnHQe6ar4Eoqgk9P1S5ZmmLLy/5iKb2e9aPPH+9l8mkZp2wXYO6EYQBG7CPBIRFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYqdLGVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYqdLGVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9CFC4CEF4;
	Sun, 22 Jun 2025 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750628285;
	bh=ZYMeQoFGvpOlMGZ1tBRgXborsAE0j4pUGN4+GxrhYyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYqdLGVlfMzv+B71dgzFSSPHYLxj43eQH9utuqOr+oyeAtto9M/NfXY2lI/CklOfV
	 sxxSi9tnnneoddVbjNyHjLEufRKdbH6q/1UwkZZL8EiKElymgAo58Luw8pIaL4V9mb
	 Y7b8TpjcR+W2idnz7djRLZT+c7uWaSS4X0LEF7NlTwgw0/FGL2+6kE6cVgUydjqCCs
	 CJiTSwH8ZEF/l0aDOju2dfYubOx5MHlJkvFWBDikAQPi5CcGphD0vBnvNkw29wkM6F
	 ikn0e3RwvIe/J2B0Izy6qJoGmaPi/sQXLxqby0NnMY7oq8qiT5xvY2gd7x9xxD1kwn
	 +cWY1Wsqc4rkQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] mm/damon/sysfs-schemes: decouple from damos_action
Date: Sun, 22 Jun 2025 14:37:56 -0700
Message-Id: <20250622213759.50930-3-sj@kernel.org>
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

Decouple DAMOS sysfs interface from damos_action.  For this, define and
use new sysfs-schemes internal data structure that maps the user-space
keywords and damos_action, instead of having the implicit and unflexible
array index rule.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 80 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3747dc6678f2..117d27544173 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1614,18 +1614,52 @@ struct damon_sysfs_scheme {
 	int target_nid;
 };
 
-/* This should match with enum damos_action */
-static const char * const damon_sysfs_damos_action_strs[] = {
-	"willneed",
-	"cold",
-	"pageout",
-	"hugepage",
-	"nohugepage",
-	"lru_prio",
-	"lru_deprio",
-	"migrate_hot",
-	"migrate_cold",
-	"stat",
+struct damos_sysfs_action_name {
+	enum damos_action action;
+	char *name;
+};
+
+struct damos_sysfs_action_name damos_sysfs_action_names[] = {
+	{
+		.action = DAMOS_WILLNEED,
+		.name = "willneed",
+	},
+	{
+		.action = DAMOS_COLD,
+		.name = "cold",
+	},
+	{
+		.action = DAMOS_PAGEOUT,
+		.name = "pageout",
+	},
+	{
+		.action = DAMOS_HUGEPAGE,
+		.name = "hugepage",
+	},
+	{
+		.action = DAMOS_NOHUGEPAGE,
+		.name = "nohugepage",
+	},
+	{
+		.action = DAMOS_LRU_PRIO,
+		.name = "lru_prio",
+	},
+	{
+		.action = DAMOS_LRU_DEPRIO,
+		.name = "lru_deprio",
+	},
+	{
+		.action = DAMOS_MIGRATE_HOT,
+		.name = "migrate_hot",
+	},
+	{
+		.action = DAMOS_MIGRATE_COLD,
+		.name = "migrate_cold",
+	},
+	{
+		.action = DAMOS_STAT,
+		.name = "stat",
+	},
 };
 
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
@@ -1862,9 +1896,16 @@ static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_scheme *scheme = container_of(kobj,
 			struct damon_sysfs_scheme, kobj);
+	int i;
 
-	return sysfs_emit(buf, "%s\n",
-			damon_sysfs_damos_action_strs[scheme->action]);
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_action_names); i++) {
+		struct damos_sysfs_action_name *action_name;
+
+		action_name = &damos_sysfs_action_names[i];
+		if (action_name->action == scheme->action)
+			return sysfs_emit(buf, "%s\n", action_name->name);
+	}
+	return -EINVAL;
 }
 
 static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1872,11 +1913,14 @@ static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_scheme *scheme = container_of(kobj,
 			struct damon_sysfs_scheme, kobj);
-	enum damos_action action;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damos_sysfs_action_names); i++) {
+		struct damos_sysfs_action_name *action_name;
 
-	for (action = 0; action < NR_DAMOS_ACTIONS; action++) {
-		if (sysfs_streq(buf, damon_sysfs_damos_action_strs[action])) {
-			scheme->action = action;
+		action_name = &damos_sysfs_action_names[i];
+		if (sysfs_streq(buf, action_name->name)) {
+			scheme->action = action_name->action;
 			return count;
 		}
 	}
-- 
2.39.5
