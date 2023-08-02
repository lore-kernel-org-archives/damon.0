Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3E101FC
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611F0C433CC;
	Wed,  2 Aug 2023 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011948;
	bh=ywwkrzBmUQl1yAbJ8J8SAzYo0s1zHyng9N/GQVlAxuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGGKjcUzdRVYJx6iCGw2mNOxfYk2F0Zbi0payg8qfCkVAxiswPvCfUtoycnPmji2R
	 9xCQe4RbaWucotEQRU7vUzK/8Ph+JErkYGKaYt4/JLfv4+IA2OlbtCl2dn7NZKcr/C
	 Np+li/YqLNEoHSBJBkHtFRlpEl4aePIzjwkNcHooheN5Zmi6E0+4tbPwHPAkCZvvgA
	 mQQEB8Bt71voaV2qubWVy3vy7fIq5Re5P7IwIMpjM8hE3yhRfSXYxrrjMD1wVm3PG8
	 OEBM/FFLVOr6nDOrAwuMTbMp7CSnSx1mPyl4UwLJYYIzPLyho1Xf0LGF9qMJB21chY
	 DFaVUjkDo4NUA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm/damon/sysfs: implement a command for updating only schemes tried total bytes
Date: Wed,  2 Aug 2023 21:32:18 +0000
Message-Id: <20230802213222.109841-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802213222.109841-1-sj@kernel.org>
References: <20230802213222.109841-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using tried_regions/total_bytes file, users can efficiently retrieve the
total size of memory regions having specific access pattern.  However,
DAMON sysfs interface in kernel still populates all the infomration on
the tried_regions subdirectories.  That means the kernel part overhead
for the construction of tried regions directories still exists.  To
remove the overhead, implement yet another command input for 'state'
DAMON sysfs file.  Writing the input to the file makes DAMON sysfs
interface to update only the total_bytes file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 +-
 mm/damon/sysfs-schemes.c |  7 ++++++-
 mm/damon/sysfs.c         | 26 ++++++++++++++++++++------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index db677eba78fd..fd482a0639b4 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -47,7 +47,7 @@ void damon_sysfs_schemes_update_stats(
 
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx);
+		struct damon_ctx *ctx, bool total_bytes_only);
 
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6d3462eb31f2..9a015079f3a4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1635,6 +1635,7 @@ void damon_sysfs_schemes_update_stats(
  */
 static struct damon_sysfs_schemes *damon_sysfs_schemes_for_damos_callback;
 static int damon_sysfs_schemes_region_idx;
+static bool damos_regions_upd_total_bytes_only;
 
 /*
  * DAMON callback that called before damos apply.  While this callback is
@@ -1664,6 +1665,9 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
 	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
+	if (damos_regions_upd_total_bytes_only)
+		return 0;
+
 	region = damon_sysfs_scheme_region_alloc(r);
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
@@ -1702,10 +1706,11 @@ int damon_sysfs_schemes_clear_regions(
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx)
+		struct damon_ctx *ctx, bool total_bytes_only)
 {
 	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
+	damos_regions_upd_total_bytes_only = total_bytes_only;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
 	return 0;
 }
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 33e1d5c9cb54..b86ba7b0a921 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -999,6 +999,11 @@ enum damon_sysfs_cmd {
 	 * files.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES: Update
+	 * tried_regions/total_bytes sysfs files for each scheme.
+	 */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS: Update schemes tried
 	 * regions
@@ -1021,6 +1026,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"off",
 	"commit",
 	"update_schemes_stats",
+	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
 	"clear_schemes_tried_regions",
 };
@@ -1206,12 +1212,14 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 	struct damon_sysfs_kdamond *kdamond;
+	enum damon_sysfs_cmd cmd;
 
 	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
 	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (kdamond && damon_sysfs_cmd_request.cmd ==
-			DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS &&
-			ctx == kdamond->damon_ctx) {
+	cmd = damon_sysfs_cmd_request.cmd;
+	if (kdamond && ctx == kdamond->damon_ctx &&
+			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
+			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES)) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
 		mutex_unlock(&damon_sysfs_lock);
 	}
@@ -1248,14 +1256,15 @@ static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 }
 
 static int damon_sysfs_upd_schemes_regions_start(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *kdamond, bool total_bytes_only)
 {
 	struct damon_ctx *ctx = kdamond->damon_ctx;
 
 	if (!ctx)
 		return -EINVAL;
 	return damon_sysfs_schemes_update_regions_start(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+			kdamond->contexts->contexts_arr[0]->schemes, ctx,
+			total_bytes_only);
 }
 
 static int damon_sysfs_upd_schemes_regions_stop(
@@ -1332,6 +1341,7 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
 	static bool damon_sysfs_schemes_regions_updating;
+	bool total_bytes_only = false;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */
@@ -1348,9 +1358,13 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
+		total_bytes_only = true;
+		fallthrough;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
 		if (!damon_sysfs_schemes_regions_updating) {
-			err = damon_sysfs_upd_schemes_regions_start(kdamond);
+			err = damon_sysfs_upd_schemes_regions_start(kdamond,
+					total_bytes_only);
 			if (!err) {
 				damon_sysfs_schemes_regions_updating = true;
 				goto keep_lock_out;
-- 
2.25.1

