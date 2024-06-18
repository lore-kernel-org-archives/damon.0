Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254315FCFB;
	Tue, 18 Jun 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734702; cv=none; b=g2UuxahRCM22E2j41bhtkE/uxGFh0gUE6bB/JtE4cEwJA6Erj6iVXG33fpZ6iJyL+gRZibdvsdS4qRy+SEOQIlYTtKAAde5/EManfplA7FdgUb+bRwHWzuPix5yGfS4vm0FDyOonFCjRrEVj7erR4B8E2u7GLGalWXnRjpXEn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734702; c=relaxed/simple;
	bh=IvB9TY1BgcO/wE27+FMWRz+Cg1k/Z3ehFmcdbgTDhfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGWVTKZBEkJdwXqJSv14S5tN+1E6ceOfxV9Pag0SOtIJ4+I/3hIKS/GiILaZKFPBD7ifQJtX0pdacujfG1dm3J81t3kaFat5IS/C/YG92qoZllQvDtJTo9Z1e7p8nrJficrW/jMPSr4A4pfLmqjfwM8nmCXCg9HIqfppw9AzDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1QOFYNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1QOFYNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE3AC4AF50;
	Tue, 18 Jun 2024 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734701;
	bh=IvB9TY1BgcO/wE27+FMWRz+Cg1k/Z3ehFmcdbgTDhfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1QOFYNZF8ejie0JzdmDiZs20qHP66bCShDkYs6kYuVfrgDXUx9RkIj2Vt689X0LL
	 c5KGgHMaapOGrTmPZhmOjpu8mx7gR52gC1q2recUO41eCxmBKIcfIeDZhDC4F8wCDn
	 pN5fhMg6QIdP2qketSZnuOJTmskmL1wvNkfaf8yOPiho89o7HCynwTtt0CyWbCWBVX
	 uQ7NKuHV2FAqbxJsZ2v3dXdP5gNb0olBAmSaoys1f0Xr4P7Q9+dq1Ds0fNGgiav396
	 kTXFgqE4YzjkhgibHfbI2pv9Ia1icBbKh7YPt3PQBF9BLsTaVIlNJr3GF0FI8U9fCv
	 3jMgt+CtpQJAA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] mm/damon/sysfs-schemes: rename *_set_{schemes,scheme_filters,quota_score,schemes}()
Date: Tue, 18 Jun 2024 11:18:05 -0700
Message-Id: <20240618181809.82078-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions were for updating DAMON structs that may or may not be
partially populated.  Hence it was not for only adding items, but also
removing unnecessary items and updating items in-place.  A previous
commit has changed the functions to assume the structs are not partially
populated, and do only adding items.  Make the names better explain the
behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 +-
 mm/damon/sysfs-schemes.c | 12 ++++++------
 mm/damon/sysfs.c         |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index a63f51577cff..9a18f3c535d3 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -38,7 +38,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes);
 
 extern const struct kobj_type damon_sysfs_schemes_ktype;
 
-int damon_sysfs_set_schemes(struct damon_ctx *ctx,
+int damon_sysfs_add_schemes(struct damon_ctx *ctx,
 		struct damon_sysfs_schemes *sysfs_schemes);
 
 void damon_sysfs_schemes_update_stats(
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 77c0265dff5c..b095457380b5 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1908,7 +1908,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
 	return found ? 0 : -EINVAL;
 }
 
-static int damon_sysfs_set_scheme_filters(struct damos *scheme,
+static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		struct damon_sysfs_scheme_filters *sysfs_filters)
 {
 	int i;
@@ -1947,7 +1947,7 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 	return 0;
 }
 
-static int damos_sysfs_set_quota_score(
+static int damos_sysfs_add_quota_score(
 		struct damos_sysfs_quota_goals *sysfs_goals,
 		struct damos_quota *quota)
 {
@@ -1990,7 +1990,7 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 			break;
 
 		sysfs_scheme = sysfs_schemes->schemes_arr[i];
-		err = damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
+		err = damos_sysfs_add_quota_score(sysfs_scheme->quotas->goals,
 				&quota);
 		if (err) {
 			damos_for_each_quota_goal_safe(g, g_next, &quota)
@@ -2070,13 +2070,13 @@ static struct damos *damon_sysfs_mk_scheme(
 	if (!scheme)
 		return NULL;
 
-	err = damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
+	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
 	if (err) {
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
 
-	err = damon_sysfs_set_scheme_filters(scheme, sysfs_filters);
+	err = damon_sysfs_add_scheme_filters(scheme, sysfs_filters);
 	if (err) {
 		damon_destroy_scheme(scheme);
 		return NULL;
@@ -2084,7 +2084,7 @@ static struct damos *damon_sysfs_mk_scheme(
 	return scheme;
 }
 
-int damon_sysfs_set_schemes(struct damon_ctx *ctx,
+int damon_sysfs_add_schemes(struct damon_ctx *ctx,
 		struct damon_sysfs_schemes *sysfs_schemes)
 {
 	int i;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f83ea6a166c6..cffc755e7775 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1286,7 +1286,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
 	if (err)
 		return err;
-	return damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
+	return damon_sysfs_add_schemes(ctx, sys_ctx->schemes);
 }
 
 static struct damon_ctx *damon_sysfs_build_ctx(
-- 
2.39.2

