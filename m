Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE71547E0;
	Thu, 13 Feb 2025 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411097; cv=none; b=O29I0qyxxbV+NY2bvyXhb7KcxHHUsmBbI7tZqX2MdsnB5KTCl9tQ2QU7EGZUMDVGrWz3RZlVCsZocm2g07bL0n7UA6BLTMZRe//NHl62zBTTz3H240z1KwYipngW63oIZUm/dgnhtoNK0ucf51wgHFFJRB+p6S76wyNMYkzHBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411097; c=relaxed/simple;
	bh=SH+BrCdqMvUM36Uwz4yzyW+qLxd/wx4qLa3uUpiLw/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rb95F1fUaE/gQhd6/Mg3kpsAJ/3ukiuh9SNZcmON+cjKtQwmgiajSxpBhrTUEptuqmwKovaa2wVmDv1hh1CNVr5OGZ4s+LuaDqeF+4fcfEQS+veuv0TGWCVwXjU2mkCzM86keBHcC0se03n3ixvJZGdNYdTu1lwFf72zKEo61aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3BAzxdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3BAzxdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B8EC4CEEE;
	Thu, 13 Feb 2025 01:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411097;
	bh=SH+BrCdqMvUM36Uwz4yzyW+qLxd/wx4qLa3uUpiLw/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3BAzxdTETczFGrUG8o7JUdylo96Ur3zoYSlw/fbI7BU0QXIDCDUDHMAjvuMFKII7
	 m0h1oKeDmtxfE+Qmxo3BkJYU+LxLKX3X/0KnpV9pjXcsPg3JbWOAwMI7hcnvv4dugL
	 lloi9hWurShWd7jjBMX2QbaIYKNR4BJ7nVpft6YMtOoGyY5iEiNsTQogI6zq/Mlg0f
	 3uBRaRHifi8uMUVGaIgS5ygoHDR/+8pGluxcxSV9AtVQonSv0Ql3tU1gzdA2VlpzIl
	 ciae/dt9ALe8ya2rF3QL0CSJQkhMfoIg6U0+RItxQA2gZXWppCgSM6pR6x2QogUG0N
	 g9O3QQnmG4buw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/8] mm/damon/sysfs: commit intervals tuning goal
Date: Wed, 12 Feb 2025 17:44:34 -0800
Message-Id: <20250213014438.145611-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
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
index ff774cc19d1f..f9bfe9ea0ae6 100644
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
+			.samples_bp = sys_goal->samples_bp,
+			.aggrs = sys_goal->aggrs,
+			.min_sample_us = sys_goal->min_sample_us,
+			.max_sample_us = sys_goal->max_sample_us},
 		.ops_update_interval = sys_intervals->update_us,
 		.min_nr_regions = sys_nr_regions->min,
 		.max_nr_regions = sys_nr_regions->max,
-- 
2.39.5
