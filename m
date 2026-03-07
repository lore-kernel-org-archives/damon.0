Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5633C198;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913247; cv=none; b=pZbD+f+UU0EdrI4pseqH/7SPrY0hhs2xf81txGVnF7FG1QktAN8UIMNUtP2ZJxI2apynC+TJBXG7UJmmiW8QNOKNkuodWAhtjn+4+QmMWaCIvrQCY1RKcJ4TT5u/bIFaCrpnkd0Huc+rwdHPeqAkd5RCJRxYRT0gSfeQ97S1BjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913247; c=relaxed/simple;
	bh=JAJpE6K1OeR9GVQIfwKv0nXxU/6wR4CIuDdh8NIuA0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5+WwECWcVhWkqtWedoSyhXQutOUW/9hjftjNSiML4TUH4hH9mcOy1a2NlERGsnvbGzL4SWzhEVcv6SxsUMTXhDmFOAZSW5rifRi2IHiDW0t9P4oE09nb/wpYgPI+eA9G+x0A70BzkdWoceNAImhk6EmViZfqMZPSjlgBgX6Luw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvI/3slL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvI/3slL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42748C2BCB2;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913247;
	bh=JAJpE6K1OeR9GVQIfwKv0nXxU/6wR4CIuDdh8NIuA0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvI/3slLTixTWJPuy8wRgOO7cNbeRJ12UJMkkQu4o6PX9jqH5pgpLj1u5hXria7XV
	 HA16d7/8v+ycDnzUleKLRhdztkVi/mjdmyPnLBmjWEi9T71/8P7MsOb1KqA5fxX3jF
	 9ec4n7LyCq2DJI882zt8zstCfyRmShCocp7SmfjWy0DGW6OALxOqk3gE7Gu5dUlLyF
	 wVLV2AAlFe39YCEm+TfNs8eK9QrS3DTNi7tkoPoy0yJYvUdjyoX1qjL+m9kubIV5Dw
	 Fd4kfCQ7zKWBNMvGhR4a7tuGEhVi8occ9UK4G4IKK+7sYwmE9EgQSowLHpSXTvxC0V
	 H9FLAC4L+lVrQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/core: use mult_frac()
Date: Sat,  7 Mar 2026 11:53:49 -0800
Message-ID: <20260307195356.203753-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307195356.203753-1-sj@kernel.org>
References: <20260307195356.203753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple places in core code that do open-code rate
calculations.  Use mult_frac(), which is developed for doing that in a
way more safe from overflow and precision loss.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cd2d7a8e3fe92..4e931f7380477 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -665,7 +665,7 @@ static unsigned int damon_accesses_bp_to_nr_accesses(
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
-	return nr_accesses * 10000 / damon_max_nr_accesses(attrs);
+	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
@@ -1722,7 +1722,7 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
 	}
 	target_access_events = max_access_events * goal_bp / 10000;
 	target_access_events = target_access_events ? : 1;
-	return access_events * 10000 / target_access_events;
+	return mult_frac(access_events, 10000, target_access_events);
 }
 
 static unsigned long damon_feed_loop_next_input(unsigned long last_input,
@@ -2202,7 +2202,7 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 		numerator = i.totalram - i.freeram;
 	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
 		numerator = i.freeram;
-	return numerator * 10000 / i.totalram;
+	return mult_frac(numerator, 10000, i.totalram);
 }
 
 static unsigned long damos_get_node_memcg_used_bp(
@@ -2235,7 +2235,7 @@ static unsigned long damos_get_node_memcg_used_bp(
 		numerator = used_pages;
 	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
 		numerator = i.totalram - used_pages;
-	return numerator * 10000 / i.totalram;
+	return mult_frac(numerator, 10000, i.totalram);
 }
 #else
 static __kernel_ulong_t damos_get_node_mem_bp(
@@ -2265,8 +2265,8 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
 	total = active + inactive;
 	if (active_ratio)
-		return active * 10000 / total;
-	return inactive * 10000 / total;
+		return mult_frac(active, 10000, total);
+	return mult_frac(inactive, 10000, total);
 }
 
 static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
@@ -2309,8 +2309,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 	damos_for_each_quota_goal(goal, quota) {
 		damos_set_quota_goal_current_value(goal);
 		highest_score = max(highest_score,
-				goal->current_value * 10000 /
-				goal->target_value);
+				mult_frac(goal->current_value, 10000,
+					goal->target_value));
 	}
 
 	return highest_score;
@@ -2340,8 +2340,8 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (quota->ms) {
 		if (quota->total_charged_ns)
-			throughput = mult_frac(quota->total_charged_sz, 1000000,
-							quota->total_charged_ns);
+			throughput = mult_frac(quota->total_charged_sz,
+					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
-- 
2.47.3
