Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2D1DE2DF;
	Fri, 28 Feb 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780216; cv=none; b=NsZm8Se2SnJCB5t7bZTtWft0na6qSc+Om03wyLAvbH+9Rkprqp/+IfmsiwJfCIBT5UxIf2PfM7ZPap3vRVbIOT1Gx0xql+a1teoygBEXJUE36KW+Vj3rhuaRLotUz4pH0GYLT1MtVUjrPghpBSF0k/a5EXQgoAYgEy/GL7plsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780216; c=relaxed/simple;
	bh=0K6yd3M1vKE/q1zzJCXy7CoQ3azMzfYHIkHl3bOjRxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTRs8vk/nEFXGNLU6FD6v6JvGbS5fIMIyds+XgeXo4gTSO+9g4f18iZeLnHclmh9HOU81iSoNG3UW6SvkcbisEido29H8lHLq6PBTEoDSVwruz7J70DqGKwsUdd20PBP/RNH0TVedB5h0rk99shvHd0NlMveHkF7rBECU2Vw59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcCtkQaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcCtkQaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E878BC4CED6;
	Fri, 28 Feb 2025 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780216;
	bh=0K6yd3M1vKE/q1zzJCXy7CoQ3azMzfYHIkHl3bOjRxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcCtkQaESFf5y1g5mOXKOhQCuzU0QktIpwpSJaWldsKbKMwcF+S0oFoQ6Y8G1knlH
	 fTjzAAZ/DpjUf7jjF5IbgcGZLXhnqPkEu2hUf/UCy4LCTaqE2kfxirOuWKGe/J59gw
	 oFnaoWl8vZcTfvZJH/4/vI2aCZ+s5hPB6Qbxj8YdKtleklCm6dJ4P55adsA1VAbjY5
	 iKzsa02CZc3r3vjfLJt9Hzx8UHr+2B/E5yhqqxLLCeBdCMLeZGri51wLi6Q5u+wDuj
	 uV4EA/ERkJx4Fzrp4TkmlwFogk98r6AVOtmBb2hxSGVpEllwkEnuGgXKfk36s+95nr
	 ZhvKbvfDpl5WA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 4/8] mm/damon/sysfs: commit intervals tuning goal
Date: Fri, 28 Feb 2025 14:03:24 -0800
Message-Id: <20250228220328.49438-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
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
