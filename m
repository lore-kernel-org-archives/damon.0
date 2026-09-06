Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F93C9885;
	Sun,  6 Sep 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728724; cv=none; b=Ej9rkFVNfEQR4JuIyYpyEoTGEz9WwO7OaJOGE90Rx8HkP88jB+lYayiVp/CCyKBBPPDTMJDh9ncj3HBjUXIBzFc7FYO8KCe6vTx9P4b2GhBuaNEuwklyLMqI3hPnT4M+Hj5IsjrlIbMW/Txvp8w3ovpL/cdAYIvpB8vhlebp1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728724; c=relaxed/simple;
	bh=tYbGXcb0qnfSN33+x6et/LLdKLw2KZ5gfO/OCyF39B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOybj/riWOWyODDflZi990wOClkDinc9gz3Go+L5nLde7Uqahbp9yvPWMKZmfswFCVw+l9/yzWsatb29gFDF3FyjcutuYpQNblxEX6a5kTHA9yk6LwK8OP+Am7CGeMKo11ZaJb/fXQndYn+jwr218BBtVqoU3qO+1K1fc5H+Gpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QayqpzHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QayqpzHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B89F1F00A3D;
	Sun,  6 Sep 2026 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728722;
	bh=yd4lCB6dTAYrU/arXR8SQcBFL5XuW/pHu+vMb4NXhus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QayqpzHD16IlfVZM5Gglq53PCSNrzfSPPbd/9zNKg991mdo3gVo3+lqZew3+JL80o
	 xbm9np+WP9bKdLQCN4yjd2pOHPKfPNHaCmhT/i9OKDcrIEGEzgvIV2bz/cc0GjvU2E
	 lHFShHzmCm5FHEyyb1sHIvTJ3IbHwbodsdaIpQvnzUPhks+Kku7GIw2u1g5Nf+zCte
	 tvChj9oKGJbHJJyXliQdWHeY47mdBYIGLUS0g2gd7QUZvpcWchfCddEwr9ulFabG7Q
	 w5tT2Mukz6ZjIo2YGFrWbAUdfoAhXB1JRUirQuu8H2Al7WDMKYDCUjtBOZ9lnpPpeY
	 Z/p14P9/KCUvQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] mm/damon/core: support probe_hits_wsum damos core filter
Date: Sun,  6 Sep 2026 14:05:08 -0700
Message-ID: <20260906210513.106895-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906210513.106895-1-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement probe_hits_wsum DAMOS core filter support in the core layer.
Make three small changes for the support.  First, update
damos_filter_for_ops() to treat probe_hits_wsum filter as core filter.
Second, Update destination damos_filter->range_{min,max} for
probe_hits_wsum type damos filter commits.  Third, extend
damos_filter_match() to handle probe_hits_wsum type filter. Calculate
the weighted sum of the given region and compare it with the given
filter's target weighted sum range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1752afede01e2..5b976162c5eed 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -654,6 +654,7 @@ bool damos_filter_for_ops(enum damos_filter_type type)
 	switch (type) {
 	case DAMOS_FILTER_TYPE_ADDR:
 	case DAMOS_FILTER_TYPE_TARGET:
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
 		return false;
 	default:
 		break;
@@ -1328,6 +1329,10 @@ static void damos_commit_filter_arg(
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
 		dst->sz_range = src->sz_range;
 		break;
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		dst->range_min = src->range_min;
+		dst->range_max = src->range_max;
+		break;
 	default:
 		break;
 	}
@@ -2506,7 +2511,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
-	unsigned long start, end;
+	unsigned long start, end, wsum;
 
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
@@ -2541,6 +2546,11 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		damon_split_region_at(t, r, end - r->ar.start);
 		matched = true;
 		break;
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		wsum = damon_probe_hits_wsum(r, false, ctx);
+		matched = filter->range_min <= wsum &&
+			wsum <= filter->range_max;
+		break;
 	default:
 		return false;
 	}
-- 
2.47.3
