Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFA379EE7;
	Mon,  6 Jul 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347563; cv=none; b=N5XmyTcF/ENaa6QAWUseVFcm3dBt2unfJvTCEICy8c9ZOs4V+eYCwS9FwLvYpy7IyXtOqIs3UcGT7LMazELK5RzwfNM8gp3R4vjohkLO2poOc8UTUPYgQAVNEIwqoqzxznW3V0x97LUehnNRxzfxH5EdZr3FzsgoJy4UL0kdQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347563; c=relaxed/simple;
	bh=A0Dml9sCZSR9++SA30HG2iBC4alYzDpot1iwtNhCCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZGRcQZY3s8MOOO/jiZWn8vk8Y+heXzibyZVr7fWWNZtAR1g3956sfCoVqbO8tdwyatRx5K37hH+JcgzIl+EIFtcLMKqt/L2TBm6awYOrIEr/Pf1nWr5grBfJ/WXxZ3ftwRPZAvYrB6nAK6/c09ZpViQXbzz8TO3a3vvhxFwMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei4293xT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei4293xT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947351F00AC4;
	Mon,  6 Jul 2026 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347561;
	bh=cv5oEs/jNtwylkKDIq4ZcvCWk/PMjMsIoTMy1Mh6PPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ei4293xTnK6S99aqrp8NkSCMvnf5eNiTow/907Jyk2MxHToCfPDYwP7wp2PnK/Peb
	 VSsHgD+T8/OVMmy0kEdnH7WruSv0fysW2kSzrFIYSRYgIZKLWMsj4fbZWp1zMvz7zP
	 2TmHLvjjgn9xdyTXyY355/kJ+L0xVqp8An0OxUKrvQotbp7+9Q8VHM41NKSxSpO8ZR
	 GtcYQitLRW5aA+iXFd9lK4+IA8MRJpSFA+xL84yvJmg0qzM7BoeLYkTNVqz7qgzJfc
	 Z2ik3nJ5dVRHqsHOU21/T0BYoq+lEH0F5kZsGeB5/XYApV+UYl4psWi+9tX+ffJllK
	 76oNZLVarnhPw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 04/16] mm/damon/core: ask apply_probe() to return max probe hits weighted sum
Date: Mon,  6 Jul 2026 07:18:58 -0700
Message-ID: <20260706141912.88445-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_accesses() DAMON ops callback returns the maximum nr_accesses of
regions.  DAMON core uses it to calculate a reasonable region merge
threshold.  The core will need to adjust regions for not nr_accesses but
probe hits weighted sum in future.  For that, the core needs to know the
maximum weighted sum of the regions.  Update the protocol for the task.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 7 +++++--
 mm/damon/core.c       | 2 +-
 mm/damon/paddr.c      | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4aa606f691f28..e1244a06ac7e4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -648,7 +648,9 @@ enum damon_ops_id {
  * of its update.  The value will be used for regions adjustment threshold.
  * @apply_probes should apply the data attribute probes to each region and
  * accordingly update the probe hits counter of the region.  It should also
- * &set sampling_addr of each region if ``set_samples`` is true.
+ * &set sampling_addr of each region if ``set_samples`` is true.  It should
+ * also return maximum probe hits weighted sum of regions if
+ * ``return_max_wsum`` is true.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -666,7 +668,8 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
-	void (*apply_probes)(struct damon_ctx *context, bool set_samples);
+	unsigned int (*apply_probes)(struct damon_ctx *context,
+			bool set_samples, bool return_max_wsum);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7c0184cb78a50..e42f512d87a11 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3675,7 +3675,7 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, false);
+			ctx->ops.apply_probes(ctx, false, false);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index ff4fcca949660..3eba3564a31fc 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -166,7 +166,8 @@ static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
 	return pass;
 }
 
-static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
+static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
+		bool set_samples, bool return_max_wsum)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -194,6 +195,7 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
 				folio_put(folio);
 		}
 	}
+	return 0;
 }
 
 /*
-- 
2.47.3
