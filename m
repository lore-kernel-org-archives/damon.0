Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E29202C2A;
	Wed,  4 Jun 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061894; cv=none; b=uaE3Sq5CEkG3SYD5LA1JiJO2RWGYWTsjZTP56oteuLbf6ddRE+ortRj+QusJuOvxDFyXauxeq74xHmQ+If2t4d9HmEKTI2vUq9+8HSpeMLZqu0bk9IIa7cj+GvdEzjdDpr/xFjERRgqcNYWHyfCsS/K9EiwaM8i2RAf4sUDA+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061894; c=relaxed/simple;
	bh=47rhffbSXH0eMjS6yxQtcQiXlFtplaL38A+e/fJH57s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WN10tjZPj7nI+ypEXTTNSnyoeHRSDkJb1lWNzM43XD6QK54N9fY/2y2vKgPA3ge+8j5P3T7bIshG+Yx2qetUwVgkWdgmSD1mvvfqQ49H/ijYXDkvzv7+HQM/tey1VEHqdb5TauzbwC7wz9FoX1i4hyetS3wd2HaKXikqm3IRUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMgVJ2NZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMgVJ2NZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BCCC4CEE4;
	Wed,  4 Jun 2025 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749061893;
	bh=47rhffbSXH0eMjS6yxQtcQiXlFtplaL38A+e/fJH57s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMgVJ2NZwHWTIMKdQksngEuUav5LtGTioJTTXkSWn1ES/eutudy+HRNgaT6b6YqwO
	 eT7glfV597XfDhCBivlq1u61oe/6CXSPTsOkzf4AYShpRXAtTU+4mTMk8wlIl4TEt0
	 iMZ/V29a02+pY6+Qj8N9kKgLy7cbiUbJMODNxn1KkXlsCzULQTURqZR9Dqj0GebhaT
	 z0X3HClR4R9y3LI1omzoUnQpTdgC92CdxcB9aOBq9819hvbF4WIMDpBi2fs2+WAwHc
	 C2WqDHmb5Nxmvt0QlBeHnZITzvZhXyOp+5DbWtSg2lpRT18O2ESt217xLOB4GqxQT5
	 ehQaaWSoiMgsA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/4] mm/damon/stat: calculate and expose estimated memory bandwidth
Date: Wed,  4 Jun 2025 11:31:25 -0700
Message-Id: <20250604183127.13968-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604183127.13968-1-sj@kernel.org>
References: <20250604183127.13968-1-sj@kernel.org>
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
