Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2051851
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 00:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03CFC43146;
	Wed, 19 Oct 2022 00:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666138406;
	bh=FnyAkoXR3zSbYAw0fdOEm9Hg5cxYpV4uLYPmPdFOaDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9pp1b7B09qVbPCdp+4zdVt9V5ewegwADs3h5rc8ucicXlgPsvkz2CjkKSzuL6RdD
	 NwTo5CMgWJO11aSxsC+KXSYUHhN3MDHG2o9AXjV+hL35Zu7R1E5vLFGRH4XCA+cBPL
	 08cwrpif8ixxP1EemyWHiLIlC/PdlcOTs3yghqwG7+GmpkGfAwe/uSgx71CtComf56
	 M+cFzMkO405uvyi1p+TuUvQoiN16YsqOARcTswB60HGG0+cqTSj5gJhsgURfh95/s2
	 ndw1xlA49AAckKl+7aaDCaZbhtCyBWV82+/uiRmy+KIOo43mPn4FwWL3/yrQCs7Dv5
	 B6A6o6Gbv4jdw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/18] mm/damon/core: add a DAMON callback for scheme target regions check
Date: Wed, 19 Oct 2022 00:13:05 +0000
Message-Id: <20221019001317.104270-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: <20221019001317.104270-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For deep level investigation of DAMON, knowing exactly to what regions
each DAMON-based operation scheme is applied is helpful.  It can also be
very helpful for efficient monitoring results passing when the user has
interest in regions of specific access patterns.  Add a new DAMON
callback that will be called before each scheme is applied to each
region, to provide the functionality to the kernel API users.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 620ada094c3b..35630634d790 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -357,6 +357,7 @@ struct damon_operations {
  * @after_wmarks_check:	Called after each schemes' watermarks check.
  * @after_sampling:	Called after each sampling.
  * @after_aggregation:	Called after each aggregation.
+ * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
  * @private:		User private data.
  *
@@ -385,6 +386,10 @@ struct damon_callback {
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
+	int (*before_damos_apply)(struct damon_ctx *context,
+			struct damon_target *target,
+			struct damon_region *region,
+			struct damos *scheme);
 	void (*before_terminate)(struct damon_ctx *context);
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9ee9f752f6fc..f196feed78c7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -765,6 +765,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
+	int err = 0;
 
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
@@ -775,7 +776,10 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			damon_split_region_at(t, r, sz);
 		}
 		ktime_get_coarse_ts64(&begin);
-		sz_applied = c->ops.apply_scheme(c, t, r, s);
+		if (c->callback.before_damos_apply)
+			err = c->callback.before_damos_apply(c, t, r, s);
+		if (!err)
+			sz_applied = c->ops.apply_scheme(c, t, r, s);
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-- 
2.25.1

