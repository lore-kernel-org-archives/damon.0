Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060971FDE33;
	Fri,  3 Jan 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926261; cv=none; b=gpr7188JPWfWrHY3IQMQ5AaUYJ9y+DtuS0CjrOZCGonBE7aO3KEXS9TuFc7kR+kt5lJq70kPzbxkBdzPYCYM9lM6HjnWyKACGElP5lqQ2wU0DsLspYt5nd/7Sy3vdQXk1wI/SlFXCtg/Lf6cKnKJCHUi4CZ2T3nkUfuG66HsrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926261; c=relaxed/simple;
	bh=0AG/RC/M0bhm6WeM0GMTuPdy7IYbXvGsIfaoLaPfpCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQJ4letZXXc8oU5KuXqTvKjj+XcJ0N+zjCN/ZOzeswPVesOnq97AqLFGGlDZNgm3V60c7Dde/By3mmFov7ekUxL6elrivmqLsexEs/l6ruxxvM8+kSuD3KqM1HOQ9cmvXjVu48KVpAsGQkUSLjxu5LCcGHM2KsI5a+xHi36wX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJjyRE9+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJjyRE9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF26CC4CECE;
	Fri,  3 Jan 2025 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926260;
	bh=0AG/RC/M0bhm6WeM0GMTuPdy7IYbXvGsIfaoLaPfpCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJjyRE9+8H54mkpZ6BRFxdU14eB4Phkr6Ho40LTYktzdahdxWg1oftRRevZOtCu3f
	 Qautu2v6d+NS6ozj/xOddO7xD9bEMTrAt8NOqv708mPGoOac9PiK/Ea/y65nPfx3N8
	 pfeeQwuJ2H1hcdhXBTwc9Gk5Y9WhPnJG3kD6gWIS4at0P4vocjSA+cxHXSjux2L7QD
	 GTueVv+Wtt+5A93Q9NV099U3xDMSsEjSG3AhE6u7Ls8T/ZfYClEjqRZwdQ+oxFjYFf
	 1Hzu2poCoxe5n0guUXVGrEDKeZ2+Jf1BgsCFNb0hmRi3E43/QubKc5Fa6M9OgWrVd8
	 mNQPMKt0hD9tw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] mm/damon/sysfs: use damos_walk() for update_schemes_tried_{bytes,regions}
Date: Fri,  3 Jan 2025 09:43:59 -0800
Message-Id: <20250103174400.54890-10-sj@kernel.org>
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
index c57ab47686ff..1d8ad637051a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2183,6 +2183,54 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
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
index 917e6aca3f58..4ba44a314f2e 100644
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
