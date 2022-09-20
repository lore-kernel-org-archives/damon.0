Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4777462
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 16:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EA8C433D6;
	Tue, 20 Sep 2022 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663692811;
	bh=MhK06VKXEbUPmz2LhTWx+TjTU9r3tTbrPFjTsReXv64=;
	h=From:To:Cc:Subject:Date:From;
	b=NPvnJ37oloTflaC0S+gwZh0iYGu1+c5i41/vIDozekndkpBFv4w8S2NZN9WcseDnb
	 D6Itra/jYeI05wJ223XUKCd2O9aZzWMsv+Y8GcjcWFrpBXr/P/Nes6pdCjABog7IMa
	 7qKrGPAC9/9DFVipfj8Ny4HTMF/DUsQvEL09U8dcUMsLPvphnaaNyHoG4XiCHWlhUh
	 7TyQ8xQDJ9u0/+y6kzMQaqlKJuhdq4/8iCt2ImvznL68kjW0SnxXFa8xG5jbYIkE5j
	 LAzs3oZdau8HkAyAcz/srBa9kHydOfmu5jZAT+2SoMW2p++tvMUhJapINOkkeox5lN
	 NbKf5DeOCpAwQ==
From: SeongJae Park <sj@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: xiakaixu1987@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v3] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
Date: Tue, 20 Sep 2022 16:53:22 +0000
Message-ID: <1663645461-21084-1-git-send-email-kaixuxia@tencent.com> (raw)
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220920165322.jgLeKJ8d9XJNL-ecnFMwjxtKYM3WwJEXz-kbSOmDOfs@z>

From: xiakaixu1987@gmail.com

From: Kaixu Xia <kaixuxia@tencent.com>

The bodies of damon_{reclaim,lru_sort}_apply_parameters() contain
duplicates. This commit adds a common function
damon_set_region_biggest_system_ram_default() to remove the
duplicates.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Patch changelog

from v2
(https://lore.kernel.org/damon/1663645461-21084-1-git-send-email-kaixuxia@tencent.com/):
 - fix some trivial grammar mistakes
 - add links to previous versions
from v1
(https://lore.kernel.org/damon/1663568889-17634-1-git-send-email-kaixuxia@tencent.com/):
 - change the common function name and add kernel comment.

 include/linux/damon.h |  3 ++-
 mm/damon/core.c       | 35 ++++++++++++++++++++++++++++++++++-
 mm/damon/lru_sort.c   | 13 +++----------
 mm/damon/reclaim.c    | 13 +++----------
 4 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e7808a84675f..ed5470f50bab 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
-bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
+int damon_set_region_biggest_system_ram_default(struct damon_target *t,
+				unsigned long *start, unsigned long *end);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9c80c6eb00c2..9e96cb9fb5db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1245,7 +1245,8 @@ static int walk_system_ram(struct resource *res, void *arg)
  * Find biggest 'System RAM' resource and store its start and end address in
  * @start and @end, respectively.  If no System RAM is found, returns false.
  */
-bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
+static bool damon_find_biggest_system_ram(unsigned long *start,
+						unsigned long *end)
 
 {
 	struct damon_system_ram_region arg = {};
@@ -1259,6 +1260,38 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
 	return true;
 }
 
+/**
+ * damon_set_region_biggest_system_ram_default() - Set the region of the given
+ * monitoring target as requested, or biggest 'System RAM'.
+ * @t:		The monitoring target to set the region.
+ * @start:	The pointer to the start address of the region.
+ * @end:	The pointer to the end address of the region.
+ *
+ * This function sets the region of @t as requested by @start and @end.  If the
+ * values of @start and @end are zero, however, this function finds the biggest
+ * 'System RAM' resource and sets the region to cover the resource.  In the
+ * latter case, this function saves the start and end addresses of the resource
+ * in @start and @end, respectively.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_region_biggest_system_ram_default(struct damon_target *t,
+			unsigned long *start, unsigned long *end)
+{
+	struct damon_addr_range addr_range;
+
+	if (*start > *end)
+		return -EINVAL;
+
+	if (!*start && !*end &&
+		!damon_find_biggest_system_ram(start, end))
+		return -EINVAL;
+
+	addr_range.start = *start;
+	addr_range.end = *end;
+	return damon_set_regions(t, &addr_range, 1);
+}
+
 static int __init damon_init(void)
 {
 	damon_region_cache = KMEM_CACHE(damon_region, 0);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index d7eb72b41cb6..efbc2bda8b9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -188,7 +188,6 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 static int damon_lru_sort_apply_parameters(void)
 {
 	struct damos *scheme;
-	struct damon_addr_range addr_range;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
@@ -211,15 +210,9 @@ static int damon_lru_sort_apply_parameters(void)
 		return -ENOMEM;
 	damon_add_scheme(ctx, scheme);
 
-	if (monitor_region_start > monitor_region_end)
-		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-	    !damon_find_biggest_system_ram(&monitor_region_start,
-					   &monitor_region_end))
-		return -EINVAL;
-	addr_range.start = monitor_region_start;
-	addr_range.end = monitor_region_end;
-	return damon_set_regions(target, &addr_range, 1);
+	return damon_set_region_biggest_system_ram_default(target,
+					&monitor_region_start,
+					&monitor_region_end);
 }
 
 static int damon_lru_sort_turn(bool on)
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3d59ab11b7b3..162c9b1ca00f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -144,7 +144,6 @@ static struct damos *damon_reclaim_new_scheme(void)
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damos *scheme;
-	struct damon_addr_range addr_range;
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -157,15 +156,9 @@ static int damon_reclaim_apply_parameters(void)
 		return -ENOMEM;
 	damon_set_schemes(ctx, &scheme, 1);
 
-	if (monitor_region_start > monitor_region_end)
-		return -EINVAL;
-	if (!monitor_region_start && !monitor_region_end &&
-	    !damon_find_biggest_system_ram(&monitor_region_start,
-					   &monitor_region_end))
-		return -EINVAL;
-	addr_range.start = monitor_region_start;
-	addr_range.end = monitor_region_end;
-	return damon_set_regions(target, &addr_range, 1);
+	return damon_set_region_biggest_system_ram_default(target,
+					&monitor_region_start,
+					&monitor_region_end);
 }
 
 static int damon_reclaim_turn(bool on)
-- 
2.27.0
