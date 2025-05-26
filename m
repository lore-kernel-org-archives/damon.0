Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70C242901;
	Mon, 26 May 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293784; cv=none; b=EUUcYFY9uAy1hOtFu44lfcvgZGmsEd+NX19boGp7nhZm0pp3wy4DlfxixoEMn5zN474LkwzazT9qrCttQ4mqregsbIIF/+zKqbnB090KF6uH4hEMtDagWoC/fjlVspTvwYk8O1QXYzpLyJtJQiSZ/rCLBqYkSyDdwWbUlB72V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293784; c=relaxed/simple;
	bh=47rhffbSXH0eMjS6yxQtcQiXlFtplaL38A+e/fJH57s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Va/CwCYNrdbiRDMGPcZcCXi2ImpY7RLmsoMl5GD95GtP+ZCJ0WJGN20T0+H/UlPIA57hamzyfwzyyFm9mrmaObF21cB31iO5QZO2luBVdUJNiHNZgaZQ+GhczCaBOCJZdnQwdEWwuwxpfMbQF2t0AyFoPfaAK5AMjTCk4VbD3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JysvVqgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JysvVqgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204C1C4CEEF;
	Mon, 26 May 2025 21:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748293783;
	bh=47rhffbSXH0eMjS6yxQtcQiXlFtplaL38A+e/fJH57s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JysvVqgKl1cSEUbpzQJvGMcJMc82ffvmnMzhG51C8hwnvpLqAcv7kXa9a0EfDCZaP
	 XVdgBBH0+abyb0PybGslT8R/OLrdpoCZc7MlObWupcQbhAx3S7jv2vABNtkkptak0l
	 sXuZzU7KWjvRqLzwzPn66XdNh46EXNgneBpnRnOMc7mCLmLlOTL0EWK2SDlG6EdP2o
	 7+/w4eWZ4F5XWdJwXw1TGDqbDkHm4EsHkR1VqfWDh13C+xDkuadGZEwOEWbuUzfhFE
	 DyXXos0VUzOXvur+A/xut9CCcT7Qv1wSwruOKGOd7sHx+Fr2Y2eCrm3Hz20YKyfS/s
	 p7P5v7wN/yYWQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/stat: calculate and expose estimated memory bandwidth
Date: Mon, 26 May 2025 14:09:34 -0700
Message-Id: <20250526210936.2744-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526210936.2744-1-sj@kernel.org>
References: <20250526210936.2744-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw form of DAMON's monitoring results captures many details of the
information.  However, not every bit of the information is always
required for understanding practical access patterns.  Especially on
real world production systems of high scale time and size, the raw form
is difficult to be aggregated and compared.

Convert the raw monitoring results into a single number metric, namely
estimated memory bandwidth and expose it to users as a read-only
DAMON_STAT parameter.  The metric represents access intensiveness
(hotness) of the system.  It can easily be aggregated and compared for
high level understanding of the access pattern on large systems.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 852848ce844e..f9ae44db265b 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -28,8 +28,42 @@ static bool enabled __read_mostly = CONFIG_DAMON_STAT_ENABLED_DEFAULT;
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
 
+static unsigned long estimated_memory_bandwidth __read_mostly;
+module_param(estimated_memory_bandwidth, ulong, 0400);
+MODULE_PARM_DESC(estimated_memory_bandwidth,
+		"Estimated memory bandwidth usage in bytes per second");
+
 static struct damon_ctx *damon_stat_context;
 
+static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long access_bytes = 0;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t)
+			access_bytes += (r->ar.end - r->ar.start) *
+				r->nr_accesses;
+	}
+	estimated_memory_bandwidth = access_bytes * USEC_PER_MSEC *
+		MSEC_PER_SEC / c->attrs.aggr_interval;
+}
+
+static int damon_stat_after_aggregation(struct damon_ctx *c)
+{
+	static unsigned long last_refresh_jiffies;
+
+	/* avoid unnecessarily frequent stat update */
+	if (time_before_eq(jiffies, last_refresh_jiffies +
+				msecs_to_jiffies(5 * MSEC_PER_SEC)))
+		return 0;
+	last_refresh_jiffies = jiffies;
+
+	damon_stat_set_estimated_memory_bandwidth(c);
+	return 0;
+}
+
 static struct damon_ctx *damon_stat_build_ctx(void)
 {
 	struct damon_ctx *ctx;
@@ -75,6 +109,7 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	damon_add_target(ctx, target);
 	if (damon_set_region_biggest_system_ram_default(target, &start, &end))
 		goto free_out;
+	ctx->callback.after_aggregation = damon_stat_after_aggregation;
 	return ctx;
 free_out:
 	damon_destroy_ctx(ctx);
-- 
2.39.5
