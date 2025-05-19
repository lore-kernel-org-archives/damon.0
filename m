Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EE288506;
	Mon, 19 May 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673063; cv=none; b=jVXDIr2K7eW6HOYupUHwajwbi+tJ5WASihVJIU1jd2ByzedRIzrlj/a5L7UOkgoJF6oIVARUB3GQ35l0SDLLZWIoCLT126UQmLqXVDKZH47uk7ZCQwN3HZNhJnV7Zm9fvhcukdyv1qABHmx49P/opWvaW5/LMmhw+BRz2eUX/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673063; c=relaxed/simple;
	bh=aEHaE8W06Fq5hALcrvZOQ2IWuHzzkcZJHOLo+mefNe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSoIdZUhIvc6RtPIeD+87CZ/Cb1Q/HHPn3mtwadcJCjOY3/SBkWmquChyKoKnJBXYFCfG02xVWbeuifnmsvW5f3NmL83fF0s0EVP2GiEBKfFoQKH4eTTaK/3ua9pH99eDOGBrTBurd6xJz6gA7vUpZC3qC6sFtqoPfTVdP8Mhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g46DMzW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g46DMzW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5174CC4CEE9;
	Mon, 19 May 2025 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747673062;
	bh=aEHaE8W06Fq5hALcrvZOQ2IWuHzzkcZJHOLo+mefNe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g46DMzW0Ra+JSIykpWnDpHN1/7r2XsIY1kQ/mXixnOkME0IZGmBYlIqCPsGxKlzST
	 GspthY0pYkZstR2betw+cfpgvYUBhMRJt0Oiuu3AUy5Qu5ZbLe4P7uqkCJPU3pW6cs
	 9M7dZ166PO4qDqsr49f1g5eu3egKwHzBGG9SdLdENvez9v3f0dnHFaE/zseY/ERREN
	 AY6Cq8VytXLt9NZrs6JfLCT4LcdX3irWKgyPQfsRBBh3PAkDTuCsdYPRP80Zg+aq3J
	 U7M5t03ANUf9JzHeksEUDG1JLSW/euot7o1RFgA5hu0H047Dc0CsH7thvnbxPcyJo3
	 WKDmz1d5UTU8Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/3] mm/damon/stat: calculate and expose estimated memory bandwidth
Date: Mon, 19 May 2025 09:44:14 -0700
Message-Id: <20250519164415.43935-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519164415.43935-1-sj@kernel.org>
References: <20250519164415.43935-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw form of DAMON's monitoring results captures many details of the
information.  However, not every bit of the information is always
required for understanding practical access pattern.  Especially on real
world production systems of high scale time and size, the raw form is
difficult to be aggregated and compared.

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
