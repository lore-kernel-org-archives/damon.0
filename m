Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4737187F;
	Fri, 15 May 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805898; cv=none; b=YiApbXBMaOFllYq4ChN6rDGpT07Pm8eBe6cIS9UDcS/bUim/BN4AOX6IYy/cU+S1XIiVK0MFTTtTUk3Hs5UTdomnSGWkLFRTOymsorL+EL7+pkKdAgh7SFZIy4CdvPLZKhPIyz7jXQRZlYisQr8cvYp1xyJuXigkEwPFWRzsn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805898; c=relaxed/simple;
	bh=91vAwCvsnDDGZ8DbEONtLZN4Ag+nx3FvJWUyLnt0KZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFZbX2JKYApY/dZJNmTeP04ClTdDTPoWSooepRPLhFpSzDxYUd8XweGwLkwYDhTlp7Jrt9U4pgKkQvW1W2cvr7G3IxCrSLSjj0ncvmLwgSo1rbaKx8tO+7vTGxevtRDY0kNlPOccK/1uznfrqt1S7HEqr0i8lVIpxR7OdkYMPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNX6r3YH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNX6r3YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C545C2BCF5;
	Fri, 15 May 2026 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805897;
	bh=91vAwCvsnDDGZ8DbEONtLZN4Ag+nx3FvJWUyLnt0KZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNX6r3YHo3mglvkQ1wAYFifwXjwYeX/JziaMJ7dlRr9CHCcdESTBWQ9ME7Kk4hVFB
	 SrkcKtQGNsI4vSyzKLvo8IQsLJzUssUV66Yd4WqYS2Ltk3X8v8La9QcU5pL3reNdGk
	 1MpcsF9AZ/15r0CBdqo5hMC3INPEPJI9lh1XxwPTnNYs/9OaNapkNq0gQVcxqhQcdG
	 JK2wQ2vH/CoVaFAJvrWAkCYN5fgK9pvlupEExTsqfVJtR7A7L4JR+D8ol4hFTP5JGx
	 VL9F9VT42XEJ8hW+0NNiAcyWlLNBUmnwcQ0C1vEduaxRsfMEx+PnVI0q0TUJ04vzKk
	 PFs+idCoVEidw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 25/28] mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common
Date: Thu, 14 May 2026 17:44:26 -0700
Message-ID: <20260515004433.128933-26-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
 mm/damon/sysfs-schemes.c | 40 ---------------------------------------
 3 files changed, 43 insertions(+), 40 deletions(-)

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
index 36f6e4bc57ba7..b8c164b6759cb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2732,46 +2732,6 @@ const struct kobj_type damon_sysfs_schemes_ktype = {
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
