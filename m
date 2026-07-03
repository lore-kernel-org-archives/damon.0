Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674152D73BC;
	Fri,  3 Jul 2026 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098372; cv=none; b=KAOvxLDYkyAu8sPoici/lTQvwOTtHXHUmC+QqHNId7MQHxrUyyKEfYkAzyuqA4+i0I7FlXkyktjBR5Vi+vtrC0HGBZgBJ2Z7jt+94PZmHtdXIWHJSSDFRNA7Si8vFt9tURuYQxey9yUk3xbAvkEkaPQX+PVDLyHf3dvrcyAeJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098372; c=relaxed/simple;
	bh=jrgIUoLLFqMVTSTWxKojT8UnjaDZsGJyBEimLQDP9AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwxADgDRGyd65MzsL5kj/8aTo9npEr0Xw60SNZQpgYo1GSxwK7p3/3xBn1KkDobv9Pcg+PKq/LCiFcAr4XgBG8fPtQa0nNRrWnGGfV4Nv0ub944V6AuSsdLvCkV0+mA+H/UrTlVWzBfuSDWkb0u1t/9Un948EjHC0YxHDGOl+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY+P8mRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY+P8mRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C731F00ACF;
	Fri,  3 Jul 2026 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783098371;
	bh=Gcy9SSkJ7cJu/6jz9kUdhF88DVRVIoJailmK3qTsD+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CY+P8mRkXvwTm1h8+uEnZLKWUSGsJP+g7KFLKExw/zusH2OtmFWTcknvg3fr+MGqS
	 NT8f1io8Lt0RXDKEJ9GliUKcAEqA9CqP8uCGrtLWDZTXE59vLJaaMSS8BxTixYPCup
	 Ijn1uHrGzog/xVlADzoufRfPJYQczPGvx2No2NBttINLyDrwhBvZsdani0Z0+ANhtE
	 RmPhTU7BUvE26hOoEKU1lA/XvId1JudWq0iPE/CDJrpVoz3cBcSSku6VpzOOQANHxJ
	 ZAUlhS61sSv4wLUwqLNKFbE8bTVH/lKj0vJR9RbHKGXzUnBaM8y6BvzwvzbrPY9G5v
	 FwOzpkVpXcVJw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm/damon/core: introduce damon_probe_hits_mvsum()
Date: Fri,  3 Jul 2026 10:06:02 -0700
Message-ID: <20260703170605.94472-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703170605.94472-1-sj@kernel.org>
References: <20260703170605.94472-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4f7e305b261c3..616bdf0954b52 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1003,6 +1003,8 @@ void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 		struct damon_ctx *ctx);
+unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
+		struct damon_ctx *ctx);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d45dc87fbbd9c..871c6f5257c9e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -273,6 +273,27 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
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
