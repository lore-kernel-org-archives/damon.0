Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000C4432
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC60C433C1;
	Thu, 15 Sep 2022 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663248645;
	bh=h5IX1MKrcfUblY8yoekIagX32KlVYCASL/Rb+1FBFqM=;
	h=From:To:Cc:Subject:Date:From;
	b=LixP+DrQUxm+g9O13ts3MR4iOUlsbJOQFNVFmiypecGAC/BiHSpkxPJXS/iRueKme
	 NixrvAdN+FznronfXGHhGCNiaFKyDEU7VGHZ7xQblaPWd358sqCgYrXM8gDjL4s27P
	 REekv1RG2X8/vpVzBF7oCI+WWsUv7ZOI7gJp6WYcYSlI6yrzSlnHnrLA6ASN9OlUFu
	 8vfdzVyAo/h2d5TMqjYzbOwX4epvCjhgA8qJIB2BJ9NiBC5xF2VM1JGfkgF8/Mha6e
	 r8DBVEKAgb9LOmyJAXBGyGST/xs9h/XanpKe4gdh2SOSd9I/zeEkhXMrsZSfeRc5p5
	 L+mmH1wGc3wVA==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xin Hao <xhao@linux.alibaba.com>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v4] mm/damon: simplify scheme create in lru_sort.c
Date: Thu, 15 Sep 2022 13:30:41 +0000
Message-Id: <20220915133041.71819-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Hao <xhao@linux.alibaba.com>

In damon_lru_sort_new_hot_scheme() and damon_lru_sort_new_cold_scheme(),
they have so much in common, so we can combine them into a single
function, and we just need to distinguish their differences.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
changes from v3
(https://lore.kernel.org/damon/20220915023655.41923-1-xhao@linux.alibaba.com/)
- Cosmetic cleanups

Changes from v2
(https://lore.kernel.org/linux-mm/20220914113859.37637-1-xhao@linux.alibaba.com/)
- Add static global 'struct damos_access_pattern' stub variable

 mm/damon/lru_sort.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 46e7c0738bc5..abfaf471e3e9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -132,6 +132,18 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_cold_stat,
 		lru_sort_tried_cold_regions, lru_sorted_cold_regions,
 		cold_quota_exceeds);
 
+struct damos_access_pattern damon_lru_sort_stub_pattern = {
+	/* Find regions having PAGE_SIZE or larger size */
+	.min_sz_region = PAGE_SIZE,
+	.max_sz_region = ULONG_MAX,
+	/* no matter its access frequency */
+	.min_nr_accesses = 0,
+	.max_nr_accesses = UINT_MAX,
+	/* no matter its age */
+	.min_age_region = 0,
+	.max_age_region = UINT_MAX,
+};
+
 static struct damon_ctx *ctx;
 static struct damon_target *target;
 
@@ -157,36 +169,19 @@ static struct damos *damon_lru_sort_new_scheme(
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and accessed for more than the threshold */
-		.min_nr_accesses = hot_thres,
-		.max_nr_accesses = UINT_MAX,
-		/* no matter its age */
-		.min_age_region = 0,
-		.max_age_region = UINT_MAX,
-	};
+	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
 
+	pattern.min_nr_accesses = hot_thres;
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
 static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 {
-	struct damos_access_pattern pattern = {
-		/* Find regions having PAGE_SIZE or larger size */
-		.min_sz_region = PAGE_SIZE,
-		.max_sz_region = ULONG_MAX,
-		/* and not accessed at all */
-		.min_nr_accesses = 0,
-		.max_nr_accesses = 0,
-		/* for min_age or more micro-seconds */
-		.min_age_region = cold_thres,
-		.max_age_region = UINT_MAX,
-	};
+	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
 
+	pattern.max_nr_accesses = 0;
+	pattern.min_age_region = cold_thres;
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
-- 
2.25.1

