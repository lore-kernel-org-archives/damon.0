Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3011FBEAE;
	Fri,  3 Jan 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926252; cv=none; b=eLQOY1IMUXmtY5T6HH2yQ64kpLAMc5ZSGI2qqlN6+GB/Uw/8abmY3GU5e9mFksXfIi930qozJdOJZ61XMYy2slNV3V15f5voctj9f1XEbDUPigaEX833rBypSRHcr4NfhsfYHEkW0YqALOHjsjZkSS+8IfaG7WbRzyQ89Jf7/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926252; c=relaxed/simple;
	bh=KNH5L0vNE8h71jgUkE2/vzFAwU/o8fScb4koo5cYPcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHGKdB8mvdWKgzT2ppDdU/5KaiYGQgb97ydonHBs+kiS/xSLSZMY9p96zlWfmgNpk43IBaE/6P6prankGPkjY2+Y90xU/+32QQfUA7gsDNqh7Z2bEcI6Kuq+iD5HPcuxfax/6q1HZ9PnIlmO2l1/i4fgfbOv19xvyxfWalj+X0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sACGoN3o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sACGoN3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C5FC4CECE;
	Fri,  3 Jan 2025 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926252;
	bh=KNH5L0vNE8h71jgUkE2/vzFAwU/o8fScb4koo5cYPcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sACGoN3oL+qwmja5AyRlGWax/gmJ7baYZ8musT1+Y6A1MPgca3vfNzf8XXzRkSMjH
	 hCw1QsDoq6drVuV/DXW1R4bcC2ob9088NIgVmHq/uVIWuTXByszHUxOOorTko7oxwq
	 THKL+O/rRfBi7xwcWLj9Ma3GxkX1WF/5keErrkRGRDj/WXF9yCSK4aw6O4ue0vhdfb
	 61w1MUczMR4N4G8Lbj2vJfik7dAXNW/6/QC+aAEGO46FCdGGxyxmQZbbEsWZZKMVkN
	 DRk+oi3J5OiklmLjWBta2DEYurJHYKkOVn5YdoH4hE4BC9Y0Kn10jgfvcasKDQYoIE
	 ah8Aa2FfMtn+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon/sysfs-schemes: remove unnecessary schemes existence check in damon_sysfs_schemes_clear_regions()
Date: Fri,  3 Jan 2025 09:43:51 -0800
Message-Id: <20250103174400.54890-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103174400.54890-1-sj@kernel.org>
References: <20250103174400.54890-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_schemes_clear_regions() skips removing the scheme tried
region directories only if the matching scheme is still ongoing.  It is
unnecessary check, since what users want is just removing the entire
region directories.  Remove the unnecessary check.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  3 +--
 mm/damon/sysfs-schemes.c | 16 +++++-----------
 mm/damon/sysfs.c         |  2 +-
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 9a18f3c535d3..e79b4a65ff2d 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -56,8 +56,7 @@ bool damos_sysfs_regions_upd_done(void);
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 
 int damon_sysfs_schemes_clear_regions(
-		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx);
+		struct damon_sysfs_schemes *sysfs_schemes);
 
 int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b095457380b5..2aa34778a472 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2208,20 +2208,14 @@ void damos_sysfs_mark_finished_regions_updates(struct damon_ctx *ctx)
 
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_clear_regions(
-		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx)
+		struct damon_sysfs_schemes *sysfs_schemes)
 {
-	struct damos *scheme;
-	int schemes_idx = 0;
+	int i;
 
-	damon_for_each_scheme(scheme, ctx) {
+	for (i = 0; i < sysfs_schemes->nr; i++) {
 		struct damon_sysfs_scheme *sysfs_scheme;
 
-		/* user could have removed the scheme sysfs dir */
-		if (schemes_idx >= sysfs_schemes->nr)
-			break;
-
-		sysfs_scheme = sysfs_schemes->schemes_arr[schemes_idx++];
+		sysfs_scheme = sysfs_schemes->schemes_arr[i];
 		damon_sysfs_scheme_regions_rm_dirs(
 				sysfs_scheme->tried_regions);
 		sysfs_scheme->tried_regions->total_bytes = 0;
@@ -2271,7 +2265,7 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only)
 {
-	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
+	damon_sysfs_schemes_clear_regions(sysfs_schemes);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
 	damos_tried_regions_init_upd_status(sysfs_schemes, ctx);
 	damos_regions_upd_total_bytes_only = total_bytes_only;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 58145d59881d..789804986ab0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1262,7 +1262,7 @@ static int damon_sysfs_clear_schemes_regions(
 	if (!ctx)
 		return -EINVAL;
 	return damon_sysfs_schemes_clear_regions(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+			kdamond->contexts->contexts_arr[0]->schemes);
 }
 
 static inline bool damon_sysfs_kdamond_running(
-- 
2.39.5
