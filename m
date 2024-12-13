Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58438196446;
	Fri, 13 Dec 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126799; cv=none; b=S9pJj7PJcI+Ex1Rf5lmDc1DU4k59Kf7n/cxrD/M6Yj1Hn3Gm9IsDcl+YG2IoBxhaxWkhMTatzipIhQ1OeuXZM0yeKtSAWUhD7iVvYjrzLasPrk//aIdMOu7YYNVioc9FIOPmbPmlwA+6xHLu1VYePLUJn748tmbL4swZyYsNeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126799; c=relaxed/simple;
	bh=LaL2B6Z67E0pzAwlb61QS3yiBPbVveY7ewg0M8543bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBcIoCLxjFO808PUeFXHpnYCeoskNNUCdtj6HzG2A7OHYRUMJEiMVNFHQfBddIM1uSmBn+TLLM7eDv3ADPW6//cvEhPLS+m7L+0G2Udhw7sHWwkW1F3w6bmkq+M/fpHezXpbQAoIN45GaVPA8yocX0Cbaa+KXMggk50UGI/djMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIHoa8xv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIHoa8xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4042C4CED4;
	Fri, 13 Dec 2024 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126797;
	bh=LaL2B6Z67E0pzAwlb61QS3yiBPbVveY7ewg0M8543bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIHoa8xvHtBEgKfFgfmzr8JhU8wuYdm22oBq3aXrAJdLT92I+YnPf+q/gazur1Svt
	 H9IJ4O5mRQQJIXElDQ0J31E4A7AQOGeqVPy0Kpz6Gz97Whk1qNbxbeYnFL6YMf0w9J
	 NxZhLEBwNgdQUk/b0Ub7ZMqCbFcqfNH7vZchKvHkSjFdzUCUCuX4hExGnI4n0j6Kx3
	 YHsIFHkl/x3L5l3dE+8A2jdnvmMTWACMZu46ymdApCGVPC36eS13a+tXgzno5OIgt6
	 Ff5siVphwaYrP4Mc2Ef1h9jtHp3dfEItjBTppVVBUnBOXXa7UpW7Sfoh7BW6Ep/FCr
	 oYIJWZBC0khMw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/9] mm/damon/sysfs-schemes: remove unnecessary schemes existence check in damon_sysfs_schemes_clear_regions()
Date: Fri, 13 Dec 2024 13:52:58 -0800
Message-Id: <20241213215306.54778-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213215306.54778-1-sj@kernel.org>
References: <20241213215306.54778-1-sj@kernel.org>
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
index 25356fe99273..65f6d3339a77 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2213,20 +2213,14 @@ void damos_sysfs_mark_finished_regions_updates(struct damon_ctx *ctx)
 
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
@@ -2276,7 +2270,7 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only)
 {
-	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
+	damon_sysfs_schemes_clear_regions(sysfs_schemes);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
 	damos_tried_regions_init_upd_status(sysfs_schemes, ctx);
 	damos_regions_upd_total_bytes_only = total_bytes_only;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 4daac92be30b..71bc2622ab35 100644
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

