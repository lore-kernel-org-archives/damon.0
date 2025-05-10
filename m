Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A881C6FE8;
	Sat, 10 May 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914977; cv=none; b=g7PfYpopmG0jmTIKVT0PLMm+GJMoUE9EEh3TeGsn2fIeXiEazAHMZINAQREHfEltO6L8Z0P7dhN2qs58WdhyzOF0oN27aOogyYc63Jc78Jp4iKw4DfzsN/pEU3lO3DdPYqhubPY8+8OWkZWiB3p+WjSllDx2xOWvRtFS4fwtgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914977; c=relaxed/simple;
	bh=7gYbVVjK8IjX8p7c442nyW8K8z/i+LC7CKRyd44LJos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=scnlZgZTVLfZBihcP13BNYB4dahyKACWTH7lmxlIr9u5yB4029ZtBCLkqdq7HpTnkgNH40oxW762wk9SHBTwa5QjArCMb/x9vtGMqJBEYOEZJ7/1L2iximnrNxnRYMt+MhvKKqlqjZFigyylZrFGh1jA+V32NWACUqZLwvTMDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n92L39YW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n92L39YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00BC4CEE2;
	Sat, 10 May 2025 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746914976;
	bh=7gYbVVjK8IjX8p7c442nyW8K8z/i+LC7CKRyd44LJos=;
	h=From:To:Cc:Subject:Date:From;
	b=n92L39YWDsdvMe2LmPSZQozwBrF+CjJUdXD9W8iguwWjO+PKiLKAmwV2TpilKZ9sa
	 UdTvxva01sQzpKePlCcyUuLTG5GxzW2tkIVJadSXdIeyeD+7RFsS7uSKsZ2eQJsfrR
	 mVeS1lr9QM7ZFr3rb2jf9GwppeUMv25WbBubrhbuTdT+StM4VKceXvk3oSgp93mv5l
	 L/T3jtFRUtGirRpHl8szmV/RfpByw8FYel06m48SI7btc7BCAO+A9ROZhINWdSjoAh
	 INrxFzTKU3BmmDKu3r48z36by3HNWpDaYJdtOH9SZxV+jtoUH8/4BG9trmAQxoydAz
	 tXeZW/SwZXc7A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-unstable] samples/damon/mtier: fix wrong DAMON attrs setting
Date: Sat, 10 May 2025 15:09:32 -0700
Message-Id: <20250510220932.47722-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When intervals auto-tuning is enabled, DAMON monitoring attributes
should be set with damon_set_attrs().  Because damon_set_attrs() is the
only place that sets attrs->aggr_samples, not calling damon_set_attrs()
can result in divide-by-zero from damon_get_intervals_score().

mtier, which is a DAMON's sample module that merged in mm-unstable as of
this writing, is not calling the function while enabling the
auto-tuning.  Fix the problem by properly calling damon_set_attrs().

Fixes: 3a1fff3fe05b ("samples/damon: implement a DAMON module for memory tiering") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 3390b7d30c26..36d2cd933f5a 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -41,6 +41,7 @@ static struct damon_ctx *ctxs[2];
 static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 {
 	struct damon_ctx *ctx;
+	struct damon_attrs attrs;
 	struct damon_target *target;
 	struct damon_region *region;
 	struct damos *scheme;
@@ -50,14 +51,24 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	ctx = damon_new_ctx();
 	if (!ctx)
 		return NULL;
+	attrs = (struct damon_attrs) {
+		.sample_interval = 5 * USEC_PER_MSEC,
+		.aggr_interval = 100 * USEC_PER_MSEC,
+		.ops_update_interval = 60 * USEC_PER_MSEC * MSEC_PER_SEC,
+		.min_nr_regions = 10,
+		.max_nr_regions = 1000,
+	};
+
 	/*
 	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
 	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
 	 */
-	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
+	attrs.intervals_goal = (struct damon_intervals_goal) {
 		.access_bp = 400, .aggrs = 3,
 		.min_sample_us = 5000, .max_sample_us = 10000000,
 	};
+	if (damon_set_attrs(ctx, &attrs))
+		goto free_out;
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
 		goto free_out;
 

base-commit: 882bfccd259e3961b81219834715a70a23f9ea71
-- 
2.39.5
