Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E922C325;
	Mon,  3 Mar 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040256; cv=none; b=b5edyrjCLJofgtPSQSiHy6IO5lTmJIdexf8Y3UBLBhX6u3qvVWcQpTUgfKPvXxzQlhrd6HVV7GTRoLuiLWWkDefsMXBZdhX18t1UFT0aLBQtwm+JcUZxspkJ1Fq+RLYCjs8EPWQbU4/z3MwCCANZJhz4qLBiNyW5GO1UGydzWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040256; c=relaxed/simple;
	bh=0K6yd3M1vKE/q1zzJCXy7CoQ3azMzfYHIkHl3bOjRxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqKdDZ+WkM2r0prqW1rGh624GdKKOaZJDyLuq/dT5N7Omw5kSQaPMfMcS/L1o9wxfMepiWuUri0X+trFP0GlXw+V8bRVaGCvBxKOpqdwYZTu3QQaPhGUbJ3lWasyluUx0cUjN3KnIg8chQ6+mhq18VuKC+kqmEs1E/MURRM8+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK4rXPux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK4rXPux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E13CC4CEEF;
	Mon,  3 Mar 2025 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040256;
	bh=0K6yd3M1vKE/q1zzJCXy7CoQ3azMzfYHIkHl3bOjRxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kK4rXPuxpNviA59kQsLkirdxt+l1qKS/vAADRvPpMds0Qr4aQ7YDpiCbIY+dMDzTV
	 X1LFXjyyk7uHgFOl1bV4WylbXUuJZKaXgWIa1QQdLQfogGFQrf5DpNf9tmtWkIzlxl
	 g8/ocZWZJ2HRTWRHiaMe64JxsUK350bpmyi594RGUn/93wr4vrVa++ZsgPa9kBrSyY
	 a66jlImRvAPLzueiEfCjsnln3kglSOsBccuYnugtve4e0V2mUo7snHRBIWnPAPZMSf
	 /tTY31SzCeiVP9Bc6aYbYsWM5BWfmm2ugTimG0aHI9stWobSvDgoN0npC0+5ShEIK9
	 6bu4r6JrTh4fA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/sysfs: commit intervals tuning goal
Date: Mon,  3 Mar 2025 14:17:22 -0800
Message-Id: <20250303221726.484227-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect DAMON sysfs interface for sampling and aggregation intervals
auto-tuning with DAMON core API, so that users can really use the
feature using the sysfs files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index a772060300b4..fa5f004f0670 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1273,11 +1273,18 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 		struct damon_sysfs_attrs *sys_attrs)
 {
 	struct damon_sysfs_intervals *sys_intervals = sys_attrs->intervals;
+	struct damon_sysfs_intervals_goal *sys_goal =
+		sys_intervals->intervals_goal;
 	struct damon_sysfs_ul_range *sys_nr_regions =
 		sys_attrs->nr_regions_range;
 	struct damon_attrs attrs = {
 		.sample_interval = sys_intervals->sample_us,
 		.aggr_interval = sys_intervals->aggr_us,
+		.intervals_goal = {
+			.access_bp = sys_goal->access_bp,
+			.aggrs = sys_goal->aggrs,
+			.min_sample_us = sys_goal->min_sample_us,
+			.max_sample_us = sys_goal->max_sample_us},
 		.ops_update_interval = sys_intervals->update_us,
 		.min_nr_regions = sys_nr_regions->min,
 		.max_nr_regions = sys_nr_regions->max,
-- 
2.39.5
