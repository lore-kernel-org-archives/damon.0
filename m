Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAC7B
	for <damon@lists.linux.dev>; Wed, 26 Oct 2022 22:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D0C43142;
	Wed, 26 Oct 2022 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666825194;
	bh=ntGtZw3yOs+uZ3gGOlcjovkmvzOGben11U2Vk6cgNsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apA/DBpn9ihjONGTe+7Tm+CF2VK2nXdQwrRSROG0uPjYVHC6AfMycLiYCPgw4tSV2
	 Bjryu70eLbWJwZ3NnTsY4AVkIq6TUoB9gxxBJDdYo6uGFuIOdvOmyM2ICd2Cwgeqh1
	 bTgFL7CxZRZOpao4OYSzJN/iSg34iczbkjbdwE9d9E28XH99UhR/tWLjlRWvTEmtqF
	 FMSuaipMVFPhD+vCFcKCokDIHnrMv8uH4EJ1suKOml4QfwTOj3gtr8C5rM00UCydjr
	 ZzzldyJunEtbF2+KVU4QrINjXm4ToX4LMI7rLviAU6jxY6ZWlaCORklG3p0m8AeQtA
	 2CdoglM3N20DQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 09/12] mm/damon/sysfs: split out kdamond-independent schemes stats update logic into a new function
Date: Wed, 26 Oct 2022 22:59:40 +0000
Message-Id: <20221026225943.100429-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'damon_sysfs_schemes_update_stats()' is coupled with both
damon_sysfs_kdamond and damon_sysfs_schemes.  It's a wide range of types
dependency.  It makes splitting the logics a little bit distracting.
Split the function so that each function is coupled with smaller range of
types.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 129743292e17..082c55e68e0e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2204,6 +2204,25 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->kdamond_lock);
 }
 
+static void damon_sysfs_schemes_update_stats(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_stats *sysfs_stats;
+
+		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
+		sysfs_stats->nr_tried = scheme->stat.nr_tried;
+		sysfs_stats->sz_tried = scheme->stat.sz_tried;
+		sysfs_stats->nr_applied = scheme->stat.nr_applied;
+		sysfs_stats->sz_applied = scheme->stat.sz_applied;
+		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+	}
+}
+
 /*
  * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
  * @kdamond:	The kobject wrapper that associated to the kdamond thread.
@@ -2216,23 +2235,11 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx = kdamond->damon_ctx;
-	struct damon_sysfs_schemes *sysfs_schemes;
-	struct damos *scheme;
-	int schemes_idx = 0;
 
 	if (!ctx)
 		return -EINVAL;
-	sysfs_schemes = kdamond->contexts->contexts_arr[0]->schemes;
-	damon_for_each_scheme(scheme, ctx) {
-		struct damon_sysfs_stats *sysfs_stats;
-
-		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
-		sysfs_stats->nr_tried = scheme->stat.nr_tried;
-		sysfs_stats->sz_tried = scheme->stat.sz_tried;
-		sysfs_stats->nr_applied = scheme->stat.nr_applied;
-		sysfs_stats->sz_applied = scheme->stat.sz_applied;
-		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
-	}
+	damon_sysfs_schemes_update_stats(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
 }
 
-- 
2.25.1

