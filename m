Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEF12B9F
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411BEC433C7;
	Wed,  2 Aug 2023 21:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012596;
	bh=kMVc66oZXCOktM4R7/awXD6J4keYYzNjFUaNutsI2bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTxyZN9wgm81uYCBD8tsYa8GiyQrknkGGCqGP+Zp6Wc+lvHBHfpOQUmIBlKSTGYmh
	 1UKD17lJBeOavBqNqJh3fOpnflBOMfvY+Bx0jYBVEh9fZDHTjC1jP/dOaSqYFRl+jQ
	 veY9IxAu4ARncosqjFWMds8VXLP9r2WxtyD1BaEJhw27OGS7l0Q+iUKN5psDk0se7K
	 fo0JmD6X43tdBI8eG86p92nY0vo9ypmrouOlHNvXMWIrOP1qktU2tIGPQ6yqqpzsfG
	 st/A6Dt42kSWmistvHhdf0bjHrvd2e8qx+VIySEG2VKdtpNHM1uHAeQMlcVifJDMHs
	 fhvvpLexHQ2Hw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] mm/damon/core: introduce address range type damos filter
Date: Wed,  2 Aug 2023 21:43:00 +0000
Message-Id: <20230802214312.110532-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can know special characteristic of specific address ranges.  NUMA
nodes or special objects or buffers in virtual address space could be
such examples.  For such cases, DAMOS schemes could required to be
applied to only specific address ranges.  Implement yet another type of
DAMOS filter for the purpose.

Note that the existing filter types, namely anon pages and memcg DAMOS
filters needed page level type check.  Because such check can be done
efficiently in the opertions set layer, those filters are handled in
operations set layer.  Specifically, only paddr operations set
implementation supports these filters.  Also, because statistics
counting is done in the DAMON core layer, the regions that filtered out
by these filters are counted as tried but failed to the statistics.

Unlike those, address range based filters can efficiently handled in the
core layer.  Hence, do the handling in the layer, and count the regions
that filtered out by those as the scheme has not tried for the region.
This difference should clearly documented.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 22 +++++++++++++-----
 mm/damon/core.c       | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d5d4d19928e0..476f37a883a4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -226,16 +226,24 @@ struct damos_stat {
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
- * The support of each filter type is up to running &struct damon_operations.
- * &enum DAMON_OPS_PADDR is supporting all filter types, while
- * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR are not supporting any
- * filter types.
+ * The anon pages type and memcg type filters are handled by underlying
+ * &struct damon_operations as a part of scheme action trying, and therefore
+ * accounted as 'tried'.  In contrast, other types are handled by core layer
+ * before trying of the action and therefore not accounted as 'tried'.
+ *
+ * The support of the filters that handled by &struct damon_operations depend
+ * on the running &struct damon_operations.
+ * &enum DAMON_OPS_PADDR supports both anon pages type and memcg type filters,
+ * while &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR don't support any of
+ * the two types.
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_ADDR,
 	NR_DAMOS_FILTER_TYPES,
 };
 
@@ -244,18 +252,20 @@ enum damos_filter_type {
  * @type:	Type of the page.
  * @matching:	If the matching page should filtered out or in.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
+ * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
  * page of the region matches to this and avoid applying the action if so.
- * Note that the check support is up to &struct damon_operations
- * implementation.
+ * Support of each filter type depends on the running &struct damon_operations
+ * and the type.  Refer to &enum damos_filter_type for more detai.
  */
 struct damos_filter {
 	enum damos_filter_type type;
 	bool matching;
 	union {
 		unsigned short memcg_id;
+		struct damon_addr_range addr_range;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index eb9580942a5c..f3a821215230 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -878,6 +878,56 @@ static void damos_update_stat(struct damos *s,
 	s->stat.sz_applied += sz_applied;
 }
 
+static bool __damos_filter_out(struct damon_target *t, struct damon_region *r,
+		struct damos_filter *filter)
+{
+	bool matched = false;
+	unsigned long start, end;
+
+	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_ADDR:
+		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
+		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
+
+		/* inside the range */
+		if (start <= r->ar.start && r->ar.end <= end) {
+			matched = true;
+			break;
+		}
+		/* outside of the range */
+		if (r->ar.end <= start || end <= r->ar.start) {
+			matched = false;
+			break;
+		}
+		/* start before the range and overlap */
+		if (r->ar.start < start) {
+			damon_split_region_at(t, r, start - r->ar.start);
+			matched = false;
+			break;
+		}
+		/* start inside the range */
+		damon_split_region_at(t, r, end - r->ar.start);
+		matched = true;
+		break;
+	default:
+		break;
+	}
+
+	return matched == filter->matching;
+}
+
+static bool damos_filter_out(struct damon_target *t, struct damon_region *r,
+		struct damos *s)
+{
+	struct damos_filter *filter;
+
+	damos_for_each_filter(filter, s) {
+		if (__damos_filter_out(t, r, filter))
+			return true;
+	}
+	return false;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -895,6 +945,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
 		}
+		if (damos_filter_out(t, r, s))
+			return;
 		ktime_get_coarse_ts64(&begin);
 		if (c->callback.before_damos_apply)
 			err = c->callback.before_damos_apply(c, t, r, s);
-- 
2.25.1

