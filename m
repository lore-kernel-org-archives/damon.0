Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA937104D;
	Sun, 21 Jun 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078165; cv=none; b=NjbrWApy3+51LPg1Q7M0dm7/TyOa3a32keJtHxhS6iGp4kzgXR/D2dRrYRDzU1nuzfNo7xuxVZyWOhYuce+MHplFtMF95DWBIOxT3LkD6GppK+d1LiC6/EDDwfaz1uirTcvVTz7QWds/utUsBD3SlqKqb1Gw4Y2lHv8pw9qiPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078165; c=relaxed/simple;
	bh=RsnvypQJD1AIlkKDq+ddfQ5AKJTdMIm0t81r3PY7Mv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eePcIXuPxdexxFfKIwa1mVWAM9Zstq29Xxr0uOOhLn7UX0aT+Fc76Jp4z1BbZvXetkrFiKU/wW4CJLunY0nWA/NM8apKydYO31YFu+Qr4ZKCK6KU8dxttbdke7EP9ySUVRUWOUYkO8ORnaTP70mCi/4LaDRk8tSLEVperD5c33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7dwOt2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7dwOt2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D6F1F00A3A;
	Sun, 21 Jun 2026 21:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078164;
	bh=tJEseaHHCaR7alUdOrkcXmwKm0hManVh4CS4wmeZKl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7dwOt2QkmiBJlXfUdszrI5fH5+4hgFIvD7ZXE3Z/8a5xTRMbUNiPPS98OSm/zH2q
	 nWgEOb4ZB4urgWp1/s0MDh9avHxANqF8WOj405jXQiZpD4DHj2xUihgDLpRZAyS/Al
	 JgFHbfY+skYIjmmhrd8uJ90+/plH6P0J/tY6wWkgh3eYP2D3DzpvP3JU7J3pPiB6YJ
	 78hIffa8B8/LmlfUVAwwiqDm3ihxRr+QpAGSFhDIQfPLG013DRj/PQLWK4JMbD2IMB
	 /4ew415c6MkoQh3Rx7sbvPyAL/JpiKBWwxyzctgQe1QTA4wQNjVFfyKA1kxoQroG2y
	 q5wQNpjPsPBgQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/3] mm/damon/core: introduce damon_probe_hits_mvsum()
Date: Sun, 21 Jun 2026 14:42:29 -0700
Message-ID: <20260621214231.13449-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621214231.13449-1-sj@kernel.org>
References: <20260621214231.13449-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a function for getting a reasonable best effort quality pseudo
moving sums of probe_hits on demands.  It reuses the internal function
for the pseudo moving sum for data access frequency (nr_accesses).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f0dd45ca788f5..46394171cd2d0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1005,6 +1005,8 @@ void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 		struct damon_ctx *ctx);
+unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
+		struct damon_ctx *ctx);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e84f2f1b07cc6..b5f63f2f726be 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -275,6 +275,27 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 			left_window_bp);
 }
 
+unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
+		struct damon_ctx *ctx)
+{
+	unsigned long sample_interval, aggr_interval;
+	unsigned long window_len, left_window, left_window_bp;
+
+	sample_interval = ctx->attrs.sample_interval ? : 1;
+	aggr_interval =  ctx->attrs.aggr_interval ? : 1;
+	window_len = aggr_interval / sample_interval;
+	if (time_after_eq(ctx->passed_sample_intervals,
+				ctx->next_aggregation_sis))
+		left_window = 0;
+	else
+		left_window = ctx->next_aggregation_sis -
+			ctx->passed_sample_intervals;
+	left_window_bp = mult_frac(left_window, 10000, window_len);
+
+	return damon_mvsum(r->probe_hits[probe_idx],
+			r->last_probe_hits[probe_idx], left_window_bp);
+}
+
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_new_region(unsigned long start, unsigned long end)
 {
-- 
2.47.3
