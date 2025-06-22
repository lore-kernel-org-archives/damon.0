Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32652222A0;
	Sun, 22 Jun 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628288; cv=none; b=LXmZ0duc1WHv0Jy3wJl6BQpF2M7UrhSs2b/BiphKEgjf8DBFlLyRhAg6zYLUUvgkNSQV4bLiNrxXy8qqGOHV40mWDFeiGs/8NtuUnomLM0e8luhOx1KhzcjsdFSmwB3eUbuJ3bf08ec1ssZFgdjQ3glB2Xmfv6GXIH+vpeIkJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628288; c=relaxed/simple;
	bh=ymfyB5LlwDbRaP7p17J2Z3u41y4+obtRgutiM/OpQ2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se2HuzRNJMWCG0mibqaWwWu7wvHhZ0E6fZaePEWUEEwcxVoRyGoTQ/K3SufKr+e7tYKUTR1QadCb4b8E1FhUHGmm+BH84cFaW68fGtYQSvp7prGEYfGtKNqyunTb1fxTSCT2j8UkhEGSeTodFhbUO7GCrxvGHcLVE7wrsgXUbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCeBDslP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCeBDslP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440C3C4CEED;
	Sun, 22 Jun 2025 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750628288;
	bh=ymfyB5LlwDbRaP7p17J2Z3u41y4+obtRgutiM/OpQ2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCeBDslPZK3Y0nq+wMvdaiYBEHpwK0wkveZwzRxTNHBgSHv4DcgQ4oANd/DmmNuQ9
	 Bc0qJxz/gbmIGvwWfGN6VuyoNdH4xA9rbagaNXPtiS3o7CdaimZkZEwXNYXH/oZhfH
	 vwYps+1bjg5qKjf5bKcjoOPnMSUIthU9fs7yJnFyC++/ybsLxMzcQFcoC4A5zp4BFr
	 tVPvz36P1rvsV3hc2jj2Vc21a1AGGF89lGG+ntV7TltlERogmBxUF54XN8FyG1ih1h
	 P/owAe8s+bD5QRw2FyyPyqjCOrZpSBaQOUwbnb+y/4UjTtJPmVtNDFSjXmqPJVBrVb
	 9K5Bppypg8+tg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] mm/damon/sysfs: decouple from damon_ops_id
Date: Sun, 22 Jun 2025 14:37:59 -0700
Message-Id: <20250622213759.50930-6-sj@kernel.org>
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

Decouple DAMON sysfs interface from damon_ops_id.  For this, define and
use new mm/damon/sysfs.c internal data structure that maps the
user-space keywords and damon_ops_id, instead of having the implicit and
unflexible array index rule.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 56 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1af6aff35d84..1b1476b79cdb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -811,11 +811,24 @@ static const struct kobj_type damon_sysfs_attrs_ktype = {
  * context directory
  */
 
-/* This should match with enum damon_ops_id */
-static const char * const damon_sysfs_ops_strs[] = {
-	"vaddr",
-	"fvaddr",
-	"paddr",
+struct damon_sysfs_ops_name {
+	enum damon_ops_id ops_id;
+	char *name;
+};
+
+static const struct damon_sysfs_ops_name damon_sysfs_ops_names[] = {
+	{
+		.ops_id = DAMON_OPS_VADDR,
+		.name = "vaddr",
+	},
+	{
+		.ops_id = DAMON_OPS_FVADDR,
+		.name = "fvaddr",
+	},
+	{
+		.ops_id = DAMON_OPS_PADDR,
+		.name = "paddr",
+	},
 };
 
 struct damon_sysfs_context {
@@ -934,14 +947,16 @@ static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
 static ssize_t avail_operations_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	enum damon_ops_id id;
 	int len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_ops_names); i++) {
+		const struct damon_sysfs_ops_name *ops_name;
 
-	for (id = 0; id < NR_DAMON_OPS; id++) {
-		if (!damon_is_registered_ops(id))
+		ops_name = &damon_sysfs_ops_names[i];
+		if (!damon_is_registered_ops(ops_name->ops_id))
 			continue;
-		len += sysfs_emit_at(buf, len, "%s\n",
-				damon_sysfs_ops_strs[id]);
+		len += sysfs_emit_at(buf, len, "%s\n", ops_name->name);
 	}
 	return len;
 }
@@ -951,8 +966,16 @@ static ssize_t operations_show(struct kobject *kobj,
 {
 	struct damon_sysfs_context *context = container_of(kobj,
 			struct damon_sysfs_context, kobj);
+	int i;
 
-	return sysfs_emit(buf, "%s\n", damon_sysfs_ops_strs[context->ops_id]);
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_ops_names); i++) {
+		const struct damon_sysfs_ops_name *ops_name;
+
+		ops_name = &damon_sysfs_ops_names[i];
+		if (ops_name->ops_id == context->ops_id)
+			return sysfs_emit(buf, "%s\n", ops_name->name);
+	}
+	return -EINVAL;
 }
 
 static ssize_t operations_store(struct kobject *kobj,
@@ -960,11 +983,14 @@ static ssize_t operations_store(struct kobject *kobj,
 {
 	struct damon_sysfs_context *context = container_of(kobj,
 			struct damon_sysfs_context, kobj);
-	enum damon_ops_id id;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_ops_names); i++) {
+		const struct damon_sysfs_ops_name *ops_name;
 
-	for (id = 0; id < NR_DAMON_OPS; id++) {
-		if (sysfs_streq(buf, damon_sysfs_ops_strs[id])) {
-			context->ops_id = id;
+		ops_name = &damon_sysfs_ops_names[i];
+		if (sysfs_streq(buf, ops_name->name)) {
+			context->ops_id = ops_name->ops_id;
 			return count;
 		}
 	}
-- 
2.39.5
