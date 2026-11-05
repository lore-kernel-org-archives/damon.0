Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853884;
	b=qW81mGfRCO6xUsqlOqUYaLyv6OkK9ks25tPTiRqAqnP+ZXNBjU+VHUdbh2RNQtz8qhY1
	 WCS01gvMDvIm3I0xyNWBlpFq6tCYaTahum6fG7zP3ohD9Nufe1aGo1CTI+pjBUyNR+PhU
	 2bNut6EAwVurDqhDPxzmZPH8qJvdV173V79VCsZVp/k9TmFoWtEtKW1dQOU+Y743ZOQEh
	 VT5lNTi4PwbjipuoyW591w/Bd26WKX0mEfWsfHxSVXKje32rayVzLI/lqnaIDFHpjLV5x
	 nVUpwYisaJeyaabV2N2UiZllweS5H2y0RY++c7i1e1pXE14eS1cNoO6vEJFNHtWpxnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0E1yY97q/pydVP7NezmXD+YUjsSoHVSYEsMffIc/xZM=;
	b=CMTL0TJg75Ho9YW06RYkNnSzK9M2DeCWrxfwht76i+Tz5x7ORaM8JfdYjIk9Y5XD0YGr
	 WqnyovMjoJQnGk0gVNwr/eoEV2BRVqAo/P0WZ2O1tg6r0djBoJsyp9gJs3IzoZxggVc/A
	 CEFfryvwkVuUEFzZnuSgUc0/OxrOXa98Agvmf64GcPaciuWYKiVbuJTk5U03MasPileN5
	 +YcfBTfR8f0A4uJAf/buVmTzwBm1Lsd9qoV3OjupzAJbVwHpuL47mwHET7yt9R9duW0lu
	 RVOnAiw0o9g9xPo2JH/sQkOfIDrHz5+KEfRrifh8ZFQY0Jvd84IQQ+2VZ3InR/5oc+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLA7DNSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2550606A333;
	Thu,  5 Nov 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLA7DNSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9CA1F0093A;
	Thu,  5 Nov 2026 04:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853883;
	bh=0E1yY97q/pydVP7NezmXD+YUjsSoHVSYEsMffIc/xZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLA7DNSpQtaLkg6G/4UXy4ihZNO1i84EybNVBIO3rvMBbbx2XTwHwflUN49ZgIUbr
	 13GwnTmSTD1yn7U7qDg8NUULnqTJ+MrtyqyA7X8HZlWE+SwhH6wIpNu52uQ9A9W/N0
	 AYp/XrQ9Ndza/H2F85YWVoKYRGCYa+5ttpniRmJGUHDBkfqTHBmKWFN93PyW1Acphq
	 o9WmgspkQeFKzF4SkWdTf0BXQkPk9nT0hXQECwRB17qCGTH6TwqIlDC5eSqU2Zgqfe
	 UmYO+cYSIZ63iIcdFtgy1g08ypYEB8L2pQ+2Ol1SmwSit3qMriKafdTB49d3IzPO1H
	 WS/zywksWuT5w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 20:44:21 -0800
Message-ID: <20261105044425.87142-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105044425.87142-1-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no way to specify DAMOS target regions with a deterministic
time based age range.  Extend DAMOS core filter to specify target
regions with age in milliseconds.  Introduce new damos_filter_type,
DAMOS_FILTER_TYPE_AGE_MS in DAMON API, and implement support of the type
in the core layer.

Convert the age in aggregation intervals to milliseconds and use it when
the filter is evaluated.  Reuse damos_filter->range_{min,max} to save
the age range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 16 ++++++++++------
 mm/damon/core.c       | 10 +++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 380f9cf6ddd82..1302ffb6f0bcb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -394,13 +394,16 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
+ * @DAMOS_FILTER_TYPE_AGE_MS:	Region age range in milliseconds.
  *
- * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
- * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
- * damon_operations as a part of scheme action trying, and therefore accounted
- * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET
- * and &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filters are handled by the core layer
- * before trying of the action, and therefore not accounted as 'tried'.
+ * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET,
+ * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM and &DAMOS_FILTER_TYPE_AGE_MS are handled
+ * by the underlying &struct damon_operations as a part of scheme action
+ * trying, and therefore accounted as 'tried'.  In contrast,
+ * &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET,
+ * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM and &DAMOS_FILTER_TYPE_AGE_MS filters are
+ * handled by the core layer before trying of the action, and therefore not
+ * accounted as 'tried'.
  *
  * Support for the operations-handled filters depends on the running
  * &struct damon_operations.
@@ -415,6 +418,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+	DAMOS_FILTER_TYPE_AGE_MS,
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d36823f4d0928..0a056949604f9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -659,6 +659,7 @@ bool damos_filter_for_ops(enum damos_filter_type type)
 	case DAMOS_FILTER_TYPE_ADDR:
 	case DAMOS_FILTER_TYPE_TARGET:
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+	case DAMOS_FILTER_TYPE_AGE_MS:
 		return false;
 	default:
 		break;
@@ -1336,6 +1337,7 @@ static int damos_commit_filter_arg(
 		dst->sz_range = src->sz_range;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+	case DAMOS_FILTER_TYPE_AGE_MS:
 		if (src->range_max < src->range_min)
 			return -EINVAL;
 		dst->range_min = src->range_min;
@@ -2552,7 +2554,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
-	unsigned long start, end, wsum;
+	unsigned long start, end, wsum, age_ms;
 
 	*err = 0;
 	switch (filter->type) {
@@ -2594,6 +2596,12 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = filter->range_min <= wsum &&
 			wsum <= filter->range_max;
 		break;
+	case DAMOS_FILTER_TYPE_AGE_MS:
+		age_ms = div_u64((u64)r->age * ctx->attrs.aggr_interval,
+				USEC_PER_MSEC);
+		matched = filter->range_min <= age_ms &&
+			age_ms <= filter->range_max;
+		break;
 	default:
 		return false;
 	}
-- 
2.47.3
