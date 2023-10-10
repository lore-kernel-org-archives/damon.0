Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3238E
	for <damon@lists.linux.dev>; Tue, 10 Oct 2023 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV6y0JX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0390C433CA;
	Tue, 10 Oct 2023 01:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696901167;
	bh=yWXWsEsp+bNgfqib0es1oavC1e2n/ntLxLviyD7crcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IV6y0JX+4rigSdZUd1hRuiKh2HaDEEjIDljRDMOeW3AB7wxj72XOAJc5kYFlY5w2S
	 6PJMuETlqeosgA3sjPLApwudm850uFTqJPJ0j4OWEx1F+Pu/1On7KhLpiVnGqjsVJA
	 U919sGnrb5xWyy5fBHtR73Lxdef0AhDjAWfeT2+QjS0hrJAQEBnAVdtA6AphxFOok5
	 BYhVIM1RMW9qvCFCEvcBK2Pp44sWxKZU62mLlJjSI0foETCl6z0Rxl4fFvX6sbEWw8
	 5fFJYuZwgmxG5HJcTrU1FXI3VbuRvFTXe9ksDIQHOM/TkM8tFfDcWK54+oYPBBdc1n
	 vUksMtObrMpBg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
Date: Tue, 10 Oct 2023 01:25:59 +0000
Message-Id: <20231010012600.83140-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010012600.83140-1-sj@kernel.org>
References: <20231010012600.83140-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SYSFS assumes all schemes will be applied for at least one DAMON
monitoring results snapshot within one aggregation interval, or makes no
sense to wait for it while DAMON is deactivated by the watermarks.  That
for deactivated status still makes sense, but the aggregation interval
based assumption is invalid now because each scheme can has its own
apply interval.  For schemes having larger than the aggregation or
watermarks check interval, DAMOS tried regions update request can be
finished without the update.  Avoid the case by explicitly checking the
status of the schemes tried regions update and watermarks based DAMON
deactivation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 ++
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 mm/damon/sysfs.c         | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index fd482a0639b4..5ff081226e28 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -49,6 +49,8 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only);
 
+bool damos_sysfs_regions_upd_done(void);
+
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 
 int damon_sysfs_schemes_clear_regions(
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b07a5c544b34..45bd0fd4a8b1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1904,6 +1904,22 @@ int damon_sysfs_schemes_update_regions_start(
 	return 0;
 }
 
+bool damos_sysfs_regions_upd_done(void)
+{
+	struct damon_sysfs_schemes *sysfs_schemes =
+		damon_sysfs_schemes_for_damos_callback;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
+		if (sysfs_regions->upd_status !=
+				DAMOS_TRIED_REGIONS_UPD_FINISHED)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock.  Caller
  * should unlock damon_sysfs_lock which held before
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e6b8e90bd450..71bdc51bea6e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1336,12 +1336,13 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
- * @c:	The DAMON context of the callback.
+ * @c:		The DAMON context of the callback.
+ * @active:	Whether @c is not deactivated due to watermarks.
  *
  * This function is periodically called back from the kdamond thread for @c.
  * Then, it checks if there is a waiting DAMON sysfs request and handles it.
  */
-static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
+static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 {
 	struct damon_sysfs_kdamond *kdamond;
 	bool total_bytes_only = false;
@@ -1373,6 +1374,13 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 				goto keep_lock_out;
 			}
 		} else {
+			/*
+			 * Continue regions updating if DAMON is till
+			 * active and the update for all schemes is not
+			 * finished.
+			 */
+			if (active && !damos_sysfs_regions_upd_done())
+				goto keep_lock_out;
 			err = damon_sysfs_upd_schemes_regions_stop(kdamond);
 			damon_sysfs_schemes_regions_updating = false;
 		}
@@ -1392,6 +1400,24 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	return err;
 }
 
+static int damon_sysfs_after_wmarks_check(struct damon_ctx *c)
+{
+	/*
+	 * after_wmarks_check() is called back while the context is deactivated
+	 * by watermarks.
+	 */
+	return damon_sysfs_cmd_request_callback(c, false);
+}
+
+static int damon_sysfs_after_aggregation(struct damon_ctx *c)
+{
+	/*
+	 * after_aggregation() is called back only while the context is not
+	 * deactivated by watermarks.
+	 */
+	return damon_sysfs_cmd_request_callback(c, true);
+}
+
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -1407,8 +1433,8 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 		return ERR_PTR(err);
 	}
 
-	ctx->callback.after_wmarks_check = damon_sysfs_cmd_request_callback;
-	ctx->callback.after_aggregation = damon_sysfs_cmd_request_callback;
+	ctx->callback.after_wmarks_check = damon_sysfs_after_wmarks_check;
+	ctx->callback.after_aggregation = damon_sysfs_after_aggregation;
 	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
 }
-- 
2.34.1

