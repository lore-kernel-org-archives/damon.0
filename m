Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A338E
	for <damon@lists.linux.dev>; Tue, 10 Oct 2023 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAWQTp/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50667C433C8;
	Tue, 10 Oct 2023 01:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696901166;
	bh=tkpBuPAHcXxVtnYMQEIhabnoxptCyM9g6IJhkHy1SMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAWQTp/K52moV1cPuIjdEwQJ611H9Xy78nBYCj90TW3I4Ov5uPdLOFPNqJYK3VXAw
	 +Ll4igPCl10aeRmwGmu+DHjgv08wOmOQnBGquWSiyOwjVkyU5kwz6VG35hAUTxFH8K
	 f8KTLiado7LKukenztqwf8o17fVXIAEb73doXRJgHbgOTxzJN4mVRFatJlxSjI7Bxk
	 qR1+S0Y6NMcIOJdjIMZL7PrPU7rS0HH/3Wh/0Le67RiElATC2oJrBpt8heZ6JaVPDS
	 TVZCQHhFbEQqHjYysEhkeyr2R2d810evFOuASv+otwr6W4Jx3TF3+7v9YBY7zHqMjB
	 uV1ETgeQCVyxw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm/damon/sysfs-schemes: do not update tried regions more than one DAMON snapshot
Date: Tue, 10 Oct 2023 01:25:58 +0000
Message-Id: <20231010012600.83140-2-sj@kernel.org>
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

DAMON_SYSFS exposes every DAMON-found region that eligible for applying
the scheme action for one aggregation interval.  However, each
DAMON-based operation scheme has its own apply interval.  Hence, for a
scheme that having its apply interval much smaller than the aggregation
interval, DAMON_SYSFS will expose the scheme regions that applied to
more than one DAMON monitoring results snapshots.  Since the purpose of
DAMON tried regions is exposing single snapshot, this makes no much
sense.  Track progress of each scheme's tried regions update and avoid
the case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a7d70b95c4dd..b07a5c544b34 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -113,11 +113,47 @@ static const struct kobj_type damon_sysfs_scheme_region_ktype = {
  * scheme regions directory
  */
 
+/*
+ * enum damos_sysfs_regions_upd_status - Represent DAMOS tried regions update
+ *					 status
+ * @DAMOS_TRIED_REGIONS_UPD_IDLE:		Waiting for next request.
+ * @DAMOS_TRIED_REGIONS_UPD_STARTED:		Update started.
+ * @DAMOS_TRIED_REGIONS_UPD_FINISHED:	Update finished.
+ *
+ * Each DAMON-based operation scheme (&struct damos) has its own apply
+ * interval, and we need to expose the scheme tried regions based on only
+ * single snapshot.  For this, we keep the tried regions update status for each
+ * scheme.  The status becomes 'idle' at the beginning.
+ *
+ * Once the tried regions update request is received, the request handling
+ * start function (damon_sysfs_scheme_update_regions_start()) sets the status
+ * of all schemes as 'idle' again, and register ->before_damos_apply() and
+ * ->after_sampling() callbacks.
+ *
+ * Then, the first followup ->before_damos_apply() callback
+ * (damon_sysfs_before_damos_apply()) sets the status 'started'.  The first
+ * ->after_sampling() callback (damon_sysfs_after_sampling()) after the call
+ * is called only after the scheme is completely applied
+ * to the given snapshot.  Hence the callback knows the situation by showing
+ * 'started' status, and sets the status as 'finished'.  Then,
+ * damon_sysfs_before_damos_apply() understands the situation by showing the
+ * 'finished' status and do nothing.
+ *
+ *  Finally, the tried regions request handling finisher function
+ *  (damon_sysfs_schemes_update_regions_stop()) unregisters the callbacks.
+ */
+enum damos_sysfs_regions_upd_status {
+	DAMOS_TRIED_REGIONS_UPD_IDLE,
+	DAMOS_TRIED_REGIONS_UPD_STARTED,
+	DAMOS_TRIED_REGIONS_UPD_FINISHED,
+};
+
 struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
 	struct list_head regions_list;
 	int nr_regions;
 	unsigned long total_bytes;
+	enum damos_sysfs_regions_upd_status upd_status;
 };
 
 static struct damon_sysfs_scheme_regions *
@@ -130,6 +166,7 @@ damon_sysfs_scheme_regions_alloc(void)
 	INIT_LIST_HEAD(&regions->regions_list);
 	regions->nr_regions = 0;
 	regions->total_bytes = 0;
+	regions->upd_status = DAMOS_TRIED_REGIONS_UPD_IDLE;
 	return regions;
 }
 
@@ -1777,6 +1814,10 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 		return 0;
 
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
+	if (sysfs_regions->upd_status == DAMOS_TRIED_REGIONS_UPD_FINISHED)
+		return 0;
+	if (sysfs_regions->upd_status == DAMOS_TRIED_REGIONS_UPD_IDLE)
+		sysfs_regions->upd_status = DAMOS_TRIED_REGIONS_UPD_STARTED;
 	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
 	if (damos_regions_upd_total_bytes_only)
 		return 0;
@@ -1793,6 +1834,29 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 	return 0;
 }
 
+/*
+ * DAMON callback that called after each accesses sampling.  While this
+ * callback is registered, damon_sysfs_lock should be held to ensure the
+ * regions directories exist.
+ */
+static int damon_sysfs_after_sampling(struct damon_ctx *ctx)
+{
+	struct damon_sysfs_schemes *sysfs_schemes =
+		damon_sysfs_schemes_for_damos_callback;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
+		if (sysfs_regions->upd_status ==
+				DAMOS_TRIED_REGIONS_UPD_STARTED)
+			sysfs_regions->upd_status =
+				DAMOS_TRIED_REGIONS_UPD_FINISHED;
+	}
+
+	return 0;
+}
+
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
@@ -1816,6 +1880,16 @@ int damon_sysfs_schemes_clear_regions(
 	return 0;
 }
 
+static void damos_tried_regions_init_upd_status(
+		struct damon_sysfs_schemes *sysfs_schemes)
+{
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++)
+		sysfs_schemes->schemes_arr[i]->tried_regions->upd_status =
+			DAMOS_TRIED_REGIONS_UPD_IDLE;
+}
+
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
@@ -1823,8 +1897,10 @@ int damon_sysfs_schemes_update_regions_start(
 {
 	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
+	damos_tried_regions_init_upd_status(sysfs_schemes);
 	damos_regions_upd_total_bytes_only = total_bytes_only;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
+	ctx->callback.after_sampling = damon_sysfs_after_sampling;
 	return 0;
 }
 
@@ -1837,6 +1913,7 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx)
 {
 	damon_sysfs_schemes_for_damos_callback = NULL;
 	ctx->callback.before_damos_apply = NULL;
+	ctx->callback.after_sampling = NULL;
 	damon_sysfs_schemes_region_idx = 0;
 	return 0;
 }
-- 
2.34.1

