Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A441324C;
	Thu, 14 May 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767768; cv=none; b=lSzRpPZ0G0Zrk9PwFJRAn3FO7yYESfO0hVhHEO7kQ3O3XhuUNpBbdPNvkKi+JXq+msPPMOIWXMr35+0uR7/xheZx6xb2aMpSS/kfm2oXec10pOudTu/84Jzv0lxFD+6dO/KLB4Me0jr1etOs63IYOTZ4w/pmAyihbGoXFxFTpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767768; c=relaxed/simple;
	bh=jW0kOVlO76z3Unib/m3BDQZ8Lhaae0dgTTAXYzXNV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpJT6fCzlrrshiAV+ZD3CCcJPskCoi6+INxYPdLx5l7uPagKW+mrGFGsckhKx3hV+c4H0o9X1VFJC7ti5F+16Pl3aPB1CxV11QU+G39Bnzhx/7ntFr+0UWz26jRfg01zj95Ujcrzv/RF9GX9kilNGBCuJwvhpLNXAW71PfEXMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YotgPjwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YotgPjwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568BAC2BCB8;
	Thu, 14 May 2026 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767767;
	bh=jW0kOVlO76z3Unib/m3BDQZ8Lhaae0dgTTAXYzXNV0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YotgPjwirOwx8uED8R1YFTvMXp06UJ+PObnbH6ZNN//RwqeQ+F6lZ5Rp2t5bnf/qc
	 O53pWE1SDH/Wb0yAOVtdr190Saf0ILB6gkN4HT3LrqYzgE3XhEoqK6bMga+j+ccjbg
	 INqyByzZqga6NYtqO9INLzae+tKksWQPLvvt2VID4tTFSKYk/BtLk7sP8jceJl43sr
	 qd972ePOTan9sV3GgkRhz/cHsrA8U5gwmm6BBG+Dbk9Dc+kOvTksHUoCYjDST4T8bn
	 9rD5SgJ6epwjq4Eve68pO+wV5LiFrL2/vQhxQmfRJGsP3ETPxIx37rRzH2xR56CWyQ
	 RBG9MQ1JN4kQQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 25/28] mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common
Date: Thu, 14 May 2026 07:08:58 -0700
Message-ID: <20260514140904.119781-26-sj@kernel.org>
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

The next commit will need to find the memcg id from the user-passed path
to the memory cgroup, from sysfs.c.  memcg_path_to_id() is doing that,
but defined in sysfs-schemes.c as a static function.  Move the function
to sysfs-common.c and mark it as non-static, so that the next commit can
reuse the function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.c  | 41 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-common.h  |  2 ++
 mm/damon/sysfs-schemes.c | 41 ----------------------------------------
 3 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 83e24a9b5a0db..bdc6ae2639e4f 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -104,3 +104,44 @@ const struct kobj_type damon_sysfs_ul_range_ktype = {
 	.default_groups = damon_sysfs_ul_range_groups,
 };
 
+
+static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
+		char *memcg_path_buf, char *path)
+{
+#ifdef CONFIG_MEMCG
+	cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
+	if (sysfs_streq(memcg_path_buf, path))
+		return true;
+#endif /* CONFIG_MEMCG */
+	return false;
+}
+
+int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
+{
+	struct mem_cgroup *memcg;
+	char *path;
+	bool found = false;
+
+	if (!memcg_path)
+		return -EINVAL;
+
+	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
+			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
+		/* skip offlined memcg */
+		if (!mem_cgroup_online(memcg))
+			continue;
+		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
+			*id = mem_cgroup_id(memcg);
+			found = true;
+			mem_cgroup_iter_break(NULL, memcg);
+			break;
+		}
+	}
+
+	kfree(path);
+	return found ? 0 : -EINVAL;
+}
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 2099adee11d05..3079306966a91 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -59,3 +59,5 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 void damos_sysfs_update_effective_quotas(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 43a8224d991e8..6b21bbe97d04a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2792,47 +2792,6 @@ const struct kobj_type damon_sysfs_schemes_ktype = {
 	.default_groups = damon_sysfs_schemes_groups,
 };
 
-static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
-		char *memcg_path_buf, char *path)
-{
-#ifdef CONFIG_MEMCG
-	cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
-	if (sysfs_streq(memcg_path_buf, path))
-		return true;
-#endif /* CONFIG_MEMCG */
-	return false;
-}
-
-static int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
-{
-	struct mem_cgroup *memcg;
-	char *path;
-	bool found = false;
-
-	if (!memcg_path)
-		return -EINVAL;
-
-	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);
-	if (!path)
-		return -ENOMEM;
-
-	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
-			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
-		/* skip offlined memcg */
-		if (!mem_cgroup_online(memcg))
-			continue;
-		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
-			*id = mem_cgroup_id(memcg);
-			found = true;
-			mem_cgroup_iter_break(NULL, memcg);
-			break;
-		}
-	}
-
-	kfree(path);
-	return found ? 0 : -EINVAL;
-}
-
 static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		struct damon_sysfs_scheme_filters *sysfs_filters)
 {
-- 
2.47.3
