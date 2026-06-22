Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BED3B9DA1;
	Mon, 22 Jun 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138111; cv=none; b=ud0ItpFwyk2It/heHADNVr89PkZttuXVFqwTS6CMH8B77w2vBmK0ssO4A7/dTL7po/c+rBMtSIbZ0XT4EnmFNR9gNEoCnENZUtWI+gtJXYy4YEnD88Kxt2DOghWhNmn1F1wUK8opIu8UZQC/nB9yeJSKSgHRwtOnUxl4gid+4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138111; c=relaxed/simple;
	bh=dDin/tgAj752XfsJTsT7xgYy4DHTcljKAUMmXeGGnek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2xhiYK4ZG5esvhuW104X2UhwnSzWMh3+TiIJ1Vy8E5l0R01EmFXQOk5TN0E2VVBFFB4X9+G7H2u00/l6Z0cPS/u4wr0mdN2WE6cubSE2aaz9lgcY5NhS4BivAXH89K5MgDo/fCh6aQr26d+x60u6Om8KOqigjPgVQRFdC7Gw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdk2cCzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdk2cCzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1281F00A3A;
	Mon, 22 Jun 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138108;
	bh=PW3d+q8npWZrb3x06ugVhBqktV8pPfeMClJh66u1ZQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tdk2cCzBg93P7oacSzLnkTDk1fq9ng/UXBC7wn9QkpKie1gvcIw0Tr+RF7b48llf1
	 KjjejimQ6snfZJ5aCQ9Bifd7DShpPkTvNQiCzfBJGogTkpYIwQ9byruYZ5DHybWskF
	 2oZsMkd+z3DH4TjUXGmZTbL4MBiF1U/AxFX21cY/s9vKAHEREsyG7MtcANzgRQv6C6
	 1TQqfyXVtSR0jXhfcRFfWGsTXfmmmomYn0ACESNBCXnAtpJihX7h5+ekQMNigXpml3
	 WQl/9Iaqp4a2rAHtSS3aEcJCi4k8R0RGXF4DsQhPFqKSrkAqrUGrAJy25NMYqkvrrf
	 HlrwZuXSOdkDA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 01/18] mm/damon: introduce damon_nr_accesses_mvsum()
Date: Mon, 22 Jun 2026 07:21:21 -0700
Message-ID: <20260622142139.30269-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new DAMON core function, damon_nr_accesses_mvsum().  It
returns a pseudo moving sum value of a given region's nr_accesses for
the last aggregation interval.  The internal logic is the same to
nr_accesses_bp.  The difference is that nr_accesses_bp is updated for
each sampling interval, while the new function needs to be executed only
when requested.  Hence the function's return value is the same as the
value of nr_accesses_bp.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 02ac34537df9a..55a743d99b567 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1013,6 +1013,8 @@ struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
+unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
+		struct damon_ctx *ctx);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5b84b3ce3fcff..2cc911fa221aa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -210,6 +210,68 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
+/*
+ * damon_mvsum() - Returns pseudo moving sum value for a time window.
+ * @current_nr:		The value of the current aggregation window.
+ * @last_nr:		The value of the last aggregation window.
+ * @left_window_bp:	Left time of the current aggregation window.
+ *
+ * This function calculates a pseudo moving sum value of a counter that is
+ * aggregated for each time window.  @current_nr is the value of the counter
+ * that aggregated so far (maybe not yet complete), from the beginning of the
+ * current aggregation time window.  @last_nr is the value of the counter that
+ * has completely aggregated in the last aggregation time window.
+ * @left_window_bp represents how much time is left for the current aggregation
+ * time window in bp (1/10,000).  For example, the aggregation time window is
+ * for every 10 seconds and 7 seconds has passed since the beginning of the
+ * current window, this parameter will be 3000 ((10 - 7) / 10 * 10000).
+ *
+ * The logic assumes the aggregation in the last phase was made in a single
+ * speed.  Based on the assumption, the value from the last window that needs
+ * to be added to the current value is calculated as a portion of the last
+ * value based on the remaining time window.
+ */
+static unsigned long damon_mvsum(unsigned long current_nr,
+		unsigned long last_nr, unsigned long left_window_bp)
+{
+	return current_nr + mult_frac(last_nr, left_window_bp, 10000);
+}
+
+/**
+ * damon_nr_accesses_mvsum() - Returns moving sum access frequency score.
+ * @r:		Region to get the access frequency of.
+ * @ctx:	DAMON context of @r.
+ *
+ * This function returns for how many sampling iterations in the last
+ * aggregation interval (&damon_attrs->aggr_interval) the region was found to
+ * be accessed.  Hence the value can be interpreted as the relative access
+ * frequency score of the region (@r).  The value is calculated as a pseudo
+ * moving sum, and hence it is not an exact value but just a best-effort
+ * reasonable estimation.
+ *
+ * Return: the pseudo moving sum access frequency score.
+ */
+unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
+		struct damon_ctx *ctx)
+{
+	unsigned long sample_interval, aggr_interval;
+	unsigned long window_len, left_window, left_window_bp;
+
+	sample_interval = ctx->attrs.sample_interval ? : 1;
+	aggr_interval = ctx->attrs.aggr_interval ? : 1;
+	window_len = aggr_interval / sample_interval;
+	if (time_after_eq(ctx->passed_sample_intervals,
+				ctx->next_aggregation_sis))
+		left_window = 0;
+	else
+		left_window = ctx->next_aggregation_sis -
+			ctx->passed_sample_intervals;
+	left_window_bp = mult_frac(left_window, 10000, window_len);
+
+	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
+			left_window_bp);
+}
+
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_new_region(unsigned long start, unsigned long end)
 {
-- 
2.47.3
