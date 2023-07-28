Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2551BB28
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 20:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A610AC433C9;
	Fri, 28 Jul 2023 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576494;
	bh=lBNvXKzEBU9SpXm5U6wWrF6OxTFy+UZXhLu/dKriIQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrOFSGFNnrBc5Reg0+yJCBH7k9bWeWBT5Gq+TF4ipLVskyigsxce3viD7Y6iwy+S/
	 whBMJQI/svZuVbpeKEWFPGGOlDIiJ1yfXFd9TBr57ujIvjkA9LgLV0wAppx2r9Xt0K
	 3BdjuxLZa+l5OQTbe2UyHjBtMo0AYThLHmfBix6+VAbWj3e05tx9OkPH5QN0LcENxS
	 8msdjvmyMmwUNx//uRUz0LW6+dyERhdC6rb4ilktALtVGfP7mVHc1IcgSkbHlxDai0
	 zrFGFjGmYl8Nx8x2urnvKcX+I5dNy/iSIC/E6qe8SBndPORNPboomgqV2t0rO/e9Jn
	 blzDGsBDvqg9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/13] mm/damon/core: implement target type damos filter
Date: Fri, 28 Jul 2023 20:34:39 +0000
Message-Id: <20230728203444.70703-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One DAMON context can have multiple monitoring targets, and DAMOS
schemes are applied to all targets.  In some cases, users need to apply
different scheme to different targets.  Retrieving monitoring results
via DAMON sysfs interface' 'tried_regions' directory could be one good
example.  Also, there could be cases that cgroup DAMOS filter is not
enough.  All such use cases can be worked around by having multiple
DAMON contexts having only single target, but it is inefficient in terms
of resource usage, thogh the overhead is not estimated to be huge.

Implement DAMON monitoring target based DAMOS filter for the case.  Like
address range target DAMOS filter, handle these filters in the DAMON
core layer, since it is more efficient than doing in operations set
layer.  This also means that regions that filtered out by monitoring
target type DAMOS filters are counted as not tried by the scheme.
Hence, target granularity monitoring results retrieval via DAMON sysfs
interface becomes available.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  6 ++++++
 mm/damon/core.c       | 22 ++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 476f37a883a4..ae2664d1d5f1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -227,6 +227,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
+ * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
  * The anon pages type and memcg type filters are handled by underlying
@@ -244,6 +245,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_ADDR,
+	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
 };
 
@@ -253,6 +255,9 @@ enum damos_filter_type {
  * @matching:	If the matching page should filtered out or in.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
+ * @target_idx:	Index of the &struct damon_target of
+ *		&damon_ctx->adaptive_targets if @type is
+ *		DAMOS_FILTER_TYPE_TARGET.
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
@@ -266,6 +271,7 @@ struct damos_filter {
 	union {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
+		int target_idx;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c061d289c832..334bc5823d83 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -906,13 +906,23 @@ static void damos_update_stat(struct damos *s,
 	s->stat.sz_applied += sz_applied;
 }
 
-static bool __damos_filter_out(struct damon_target *t, struct damon_region *r,
-		struct damos_filter *filter)
+static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos_filter *filter)
 {
 	bool matched = false;
+	struct damon_target *ti;
+	int target_idx = 0;
 	unsigned long start, end;
 
 	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_TARGET:
+		damon_for_each_target(ti, ctx) {
+			if (ti == t)
+				break;
+			target_idx++;
+		}
+		matched = target_idx == filter->target_idx;
+		break;
 	case DAMOS_FILTER_TYPE_ADDR:
 		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
 		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
@@ -944,13 +954,13 @@ static bool __damos_filter_out(struct damon_target *t, struct damon_region *r,
 	return matched == filter->matching;
 }
 
-static bool damos_filter_out(struct damon_target *t, struct damon_region *r,
-		struct damos *s)
+static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, s) {
-		if (__damos_filter_out(t, r, filter))
+		if (__damos_filter_out(ctx, t, r, filter))
 			return true;
 	}
 	return false;
@@ -982,7 +992,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			}
 			damon_split_region_at(t, r, sz);
 		}
-		if (damos_filter_out(t, r, s))
+		if (damos_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
 		if (c->callback.before_damos_apply)
-- 
2.25.1

