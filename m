Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C0F1EE034;
	Fri, 13 Dec 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126807; cv=none; b=Q6UtcSp3MhM0vHbnNA7t6Q6DXhSlYjKWeUG2w6k0HUIGJWJtJxINaXdyotrZDAOYlwLeojWrLA1h+VdayaCLoE6mltrv5DuuPz5mHhO1QLkcrjyg0+rwB9wc3W8XK1cPycbRMGjPB8cB0XdRToe7T9BRVg03amcsnCZY+eRpcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126807; c=relaxed/simple;
	bh=7p5Zd1Ss19X+LmH72iki7m+ul6ZR9lC5pFElBjMKsP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F16/2CE/hfVit1BIOF6dYVOEGnDQFyexoJkWTrlRIn2y/hC4x/601+ZlGfmAefk/Vyz/FhXlsxm/gFrRurxbVEkj0ody8l2RzGpb7f+Jt1ZoqimAViKnEWXqxNF9+FHhM9c64pny02lo8tRRcD4F/iP0LeqPhWw0vkrq72wNbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m35yPDSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m35yPDSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33160C4CED6;
	Fri, 13 Dec 2024 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126805;
	bh=7p5Zd1Ss19X+LmH72iki7m+ul6ZR9lC5pFElBjMKsP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m35yPDSVC7fTsZNDdPl5J9+AKBe7MTTa/TNmqSlKnSyQeAsxwhux1PhTTRiRk6w+0
	 Q8XR1pO0ock3xaR8FRjMuL5ncDhohSGrFDooq3d+oF+yDIhqv61a9ppziz8H5muoqx
	 lGmFcYJF5hKAn+eQyLXMnJZrLPkxAc5uhjc1O2Z/YUJJS3QOoqSAuJ/n/5mWGpQ2XU
	 ImXGhlvcZgIIK5Y/C47hEc3oc/ABwmLMUmKTTdaUyrLXX5r/5ihtD1o/TJxfUx7S5C
	 YO93+u7xxESrtllExf5OCN1Fegww4Ydbymh6p6/hlgDwWLgGGKtricJ/F5e81nwhhL
	 2C5/T7ICBB3Ow==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/9] mm/damon/sysfs: use damos_walk() for update_schemes_tried_{bytes,regions}
Date: Fri, 13 Dec 2024 13:53:05 -0800
Message-Id: <20241213215306.54778-9-sj@kernel.org>
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

DAMON sysfs interface uses damon_callback with its own complicated
synchronization facility to handle update_schemes_tried_bytes and
update_schemes_tried_regions commands.  But damos_walk() can support the
use case without the additional synchronizations.  Convert the code to
use damos_walk() instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  5 +++++
 mm/damon/sysfs-schemes.c | 48 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c         | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index e79b4a65ff2d..81f1c845118f 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -55,6 +55,11 @@ bool damos_sysfs_regions_upd_done(void);
 
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 
+void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *s,
+		bool total_bytes_only);
+
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes);
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6c8f9eae75af..404c21f45640 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2188,6 +2188,54 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 	return 0;
 }
 
+/**
+ * damos_sysfs_populate_region_dir() - Populate a schemes tried region dir.
+ * @sysfs_schemes:	Schemes directory to populate regions directory.
+ * @ctx:		Corresponding DAMON context.
+ * @t:			DAMON target of @r.
+ * @r:			DAMON region to populate the directory for.
+ * @s:			Corresponding scheme.
+ * @total_bytes_only:	Whether the request is for bytes update only.
+ *
+ * Called from DAMOS walk callback while holding damon_sysfs_lock.
+ */
+void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *s, bool total_bytes_only)
+{
+	struct damos *scheme;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
+	struct damon_sysfs_scheme_region *region;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		if (scheme == s)
+			break;
+		schemes_idx++;
+	}
+
+	/* user could have removed the scheme sysfs dir */
+	if (schemes_idx >= sysfs_schemes->nr)
+		return;
+
+	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
+	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
+	if (total_bytes_only)
+		return;
+
+	region = damon_sysfs_scheme_region_alloc(r);
+	if (!region)
+		return;
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
+	if (kobject_init_and_add(&region->kobj,
+				&damon_sysfs_scheme_region_ktype,
+				&sysfs_regions->kobj, "%d",
+				sysfs_regions->nr_regions++)) {
+		kobject_put(&region->kobj);
+	}
+}
+
 /*
  * DAMON callback that called after each accesses sampling.  While this
  * callback is registered, damon_sysfs_lock should be held to ensure the
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 978de4305f2b..dafeec20ac53 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1512,6 +1512,45 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
 	return damon_call(kdamond->damon_ctx, &call_control);
 }
 
+struct damon_sysfs_schemes_walk_data {
+	struct damon_sysfs_kdamond *sysfs_kdamond;
+	bool total_bytes_only;
+};
+
+/* populate the region directory */
+static void damon_sysfs_schemes_tried_regions_upd_one(void *data, struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *s)
+{
+	struct damon_sysfs_schemes_walk_data *walk_data = data;
+	struct damon_sysfs_kdamond *sysfs_kdamond = walk_data->sysfs_kdamond;
+
+	damos_sysfs_populate_region_dir(
+			sysfs_kdamond->contexts->contexts_arr[0]->schemes,
+			ctx, t, r, s, walk_data->total_bytes_only);
+}
+
+static int damon_sysfs_update_schemes_tried_regions(
+		struct damon_sysfs_kdamond *sysfs_kdamond, bool total_bytes_only)
+{
+	struct damon_sysfs_schemes_walk_data walk_data = {
+		.sysfs_kdamond = sysfs_kdamond,
+		.total_bytes_only = total_bytes_only,
+	};
+	struct damos_walk_control control = {
+		.walk_fn = damon_sysfs_schemes_tried_regions_upd_one,
+		.data = &walk_data,
+	};
+	struct damon_ctx *ctx = sysfs_kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+
+	damon_sysfs_schemes_clear_regions(
+			sysfs_kdamond->contexts->contexts_arr[0]->schemes);
+	return damos_walk(ctx, &control);
+}
+
 /*
  * damon_sysfs_handle_cmd() - Handle a command for a specific kdamond.
  * @cmd:	The command to handle.
@@ -1542,6 +1581,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_schemes_stats, kdamond);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
+		return damon_sysfs_update_schemes_tried_regions(kdamond, true);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
+		return damon_sysfs_update_schemes_tried_regions(kdamond, false);
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
 		return damon_sysfs_schemes_clear_regions(
 			kdamond->contexts->contexts_arr[0]->schemes);
-- 
2.39.5

