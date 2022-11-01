Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFA1E9FE
	for <damon@lists.linux.dev>; Tue,  1 Nov 2022 22:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3191C4347C;
	Tue,  1 Nov 2022 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667340216;
	bh=Lnuz++qjG0JC7do/edydo/RT8MRUCyAyDHoJawRr9C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6wTjkBdABD96HBqCndDJYbQguK9IQlUs+VxKiKGMy4zPGLQb9UTBcjMLxADqPLLn
	 6sy06r4zbGougpPdg5OvORgCvcptReeQ6E+q9e7zAkexbBYsZYrqsZRJseNemMsKCm
	 g6Z2u6rybAbV3UgyaJ5gWo5RA/FBiztQF8/2giC+FpE0wkQvqJwxq+jTs0NDNXSzFk
	 Kf/Gh0u+U3Zn2BUg4iqRWdGwnkAZOq6XGxSjfkFnyo0kj6OZnWwYjEDzO2aMFAbCoG
	 W9r9NkOXZc2kq7qDXswlwTXKGKMjjUYv41tricygG6j9gXQaJ411SOwmRhRv+l77/j
	 ohKUbZ83uBJtw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/8] mm/damon/sysfs-schemes: implement DAMOS-tried regions clear command
Date: Tue,  1 Nov 2022 22:03:25 +0000
Message-Id: <20221101220328.95765-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there are huge number of DAMON regions that specific scheme actions
are tried to be applied, directories and files under 'tried_regions'
scheme directory could waste some memory.  Add another special input
keyword ('clear_schemes_tried_regions') for 'state' file of each kdamond
sysfs directory that can be used for cleanup of the 'tried_regions'
sub-directories.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  4 ++++
 mm/damon/sysfs-schemes.c | 10 +++++++++-
 mm/damon/sysfs.c         | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 634a6e7fca78..604a6cbc3ede 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -50,3 +50,7 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_ctx *ctx);
 
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
+
+int damon_sysfs_schemes_clear_regions(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index dd4ecd093cd6..f0b616f5ffc1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1241,7 +1241,7 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 }
 
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
-int damon_sysfs_schemes_update_regions_start(
+int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx)
 {
@@ -1255,7 +1255,15 @@ int damon_sysfs_schemes_update_regions_start(
 		damon_sysfs_scheme_regions_rm_dirs(
 				sysfs_scheme->tried_regions);
 	}
+	return 0;
+}
 
+/* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
+int damon_sysfs_schemes_update_regions_start(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
 	return 0;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ffb5a84059d7..aeb0beb1da91 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1004,6 +1004,11 @@ enum damon_sysfs_cmd {
 	 * regions
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS,
+	/*
+	 * @DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS: Clear schemes tried
+	 * regions
+	 */
+	DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1017,6 +1022,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"commit",
 	"update_schemes_stats",
 	"update_schemes_tried_regions",
+	"clear_schemes_tried_regions",
 };
 
 /*
@@ -1262,6 +1268,17 @@ static int damon_sysfs_upd_schemes_regions_stop(
 	return damon_sysfs_schemes_update_regions_stop(ctx);
 }
 
+static int damon_sysfs_clear_schemes_regions(
+		struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+	return damon_sysfs_schemes_clear_regions(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+}
+
 static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
@@ -1343,6 +1360,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 			damon_sysfs_schemes_regions_updating = false;
 		}
 		break;
+	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
+		err = damon_sysfs_clear_schemes_regions(kdamond);
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

