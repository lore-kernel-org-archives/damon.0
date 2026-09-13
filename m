Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8A38655C;
	Sun, 13 Sep 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319837; cv=none; b=p7tH9hdwWFqwwBM64U76cCK/Y82W2PNYcrMRkoam9Ts2Hu6b/h5fYjJUVHq3y8rOjJQKHG3533fJUY9kgUgzJnOGN1UelNeQlLjMIMp7algpOnKGgd4GvcwpD7KqHuky2+ItKZEIGRlIQ5w/V6uOICwlkArQ+XqH4Ish1DV7J6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319837; c=relaxed/simple;
	bh=tpVaEb4AYEZ73fAxIIPOmUa+AX18NBp3TqT+frNo5vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Syfm+NLjNdNwlq2u2+nDF9exky8BjR65+bNnDEM15+8cF4sYiUSjohhmFvlLVNtuTDGCeIle1A6gKUhU6aGw0GFizCtq9lIrWBz1dtcLZOXyWjDxQr1FAAUPYfLuBMtUjOzZuP/qvJirjJ/lxkanZdxsjKsimHdjQbtfYrNG+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0k86qgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0k86qgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A21F000FF;
	Sun, 13 Sep 2026 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319836;
	bh=SymGB/Aunbf5NpktH/MrAmxXwvCzvOB6NopidPvvPWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0k86qgTdxcrL1TMu3BFfRdT5rho6ri0dpAB17vwosjSrW6Kf/EV9EfrTAHitpmI7
	 2ssuYPLAyQ+hcc2Drmq1omyEDdueVowfnLlCpaIwu3V0X3prCI8exkKB//W0aqsHyS
	 FSk8mUb8vlrX2ra47BQIZeXI1lb1XxKsSYqj7UVk8taj3jkIop/n6zswfR2G9ItFj/
	 pQPQ1cQs0pvS8wdyF42jPHSbX2DsymaJCO05KDHU34kFKtgYqHD/+k+LJY+DG/d58n
	 qcrTjiQnE8VWVLssKq4UBWKEIzeFib5SFkV2al5VTeSZ9AWLMW1rT14P8LL8NAoQqx
	 u6g2GmwXQOMqA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/8] mm/damon/sysfs-schemes: drop centralized filter range arg validations
Date: Sun, 13 Sep 2026 10:17:02 -0700
Message-ID: <20260913171706.103052-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171706.103052-1-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
