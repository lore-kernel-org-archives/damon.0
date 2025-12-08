Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239B13790B;
	Mon,  8 Dec 2025 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175417; cv=none; b=jDa3Z0bx1CT1o+dfjFk5N4XAnoDfJU1HU0v25rl7yURiV2cGwjjcGdkJYzEJ8Vb88JlnyNmmrNABwSFxFAP3g3qb7JZfx5lMWejxVudMuDHai0tL6T0DEXzPoy1K5grWlYDPFyxcPptKjO5BX+BBSFAZVDYKWUJX7fNfXuk13xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175417; c=relaxed/simple;
	bh=Fdrtqh4dKdLy2JHMv9GeJLVmZnlNDk6aLdhfIH2zS/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKvmaxQq1DBS9d9u4g29ZtA1yZoH+7GkT2BcysZ/zGLR1OhBKcUyMy83xTCxDsSwghl3aewHYld7XfdGFT5VmTKrvbbfcZhsP0BHj8SjaRRtVsEARg+ffPehG4RB0ULgkl+TupipZWhsyAptAFee4Hevv2QIew7KlsV2XuJtzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZn3EHdk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZn3EHdk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A998C116B1;
	Mon,  8 Dec 2025 06:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175416;
	bh=Fdrtqh4dKdLy2JHMv9GeJLVmZnlNDk6aLdhfIH2zS/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZn3EHdkDpxrRmJltAlArQeaA57+8Wo92tB0OhFhhDJ4QTwsfWMhHq3XoUr5ZNDpA
	 GqBKwPf/5UC82CkIgWWTfyNVmJzrSmvqVvVn6Jt+UUQvfoDGHjye+RvrC7zuoZ20oG
	 EgguVOwNeu6ve5Dtxrf5Bo3fzHPjtI9ZJu/dpVkNSjpWhHDSMYWoP23uhZH/xMjmka
	 +qc4Zd9URYiVZRPV7ykkEm3gACny9AZ53ua1BElOi8w7XvPqBmls2ZWMllFgtiEnHr
	 1/qBFl51cnDBPbOi68h1fTJnvqk8NyIIJ/3VcoZIsOHqmHlKfkcMtZukfOSXuhJdbe
	 sFtnr5Tv+8Jmg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 18/37] mm/damon/core: apply sample filter to access reports
Date: Sun,  7 Dec 2025 22:29:22 -0800
Message-ID: <20251208062943.68824-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data structure for access sample results filtering is not really
being used on the core layer.  Implement the support.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d952a833a05e..b627fc84161c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -586,6 +586,13 @@ static struct damon_sample_filter *damon_nth_sample_filter(int n,
 	return NULL;
 }
 
+static struct damon_sample_filter *damon_last_sample_filter_or_null(
+		struct damon_sample_control *ctrl)
+{
+	return list_last_entry_or_null(&ctrl->sample_filters,
+			struct damon_sample_filter, list);
+}
+
 struct damon_ctx *damon_new_ctx(void)
 {
 	struct damon_ctx *ctx;
@@ -2866,11 +2873,45 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	}
 }
 
+static bool damon_sample_filter_matching(struct damon_access_report *report,
+		struct damon_sample_filter *filter)
+{
+	bool matched = false;
+
+	switch (filter->type) {
+	case DAMON_FILTER_TYPE_CPUMASK:
+		matched = cpumask_test_cpu(report->cpu, &filter->cpumask);
+		break;
+	default:
+		break;
+	}
+	return matched == filter->matching;
+}
+
+static bool damon_sample_filter_out(struct damon_access_report *report,
+		struct damon_sample_control *ctrl)
+{
+	struct damon_sample_filter *filter;
+
+	damon_for_each_sample_filter(filter, ctrl) {
+		if (damon_sample_filter_matching(report, filter) &&
+				!filter->allow)
+			return true;
+	}
+	filter = damon_last_sample_filter_or_null(ctrl);
+	if (!filter)
+		return false;
+	return !filter->allow;
+}
+
 static void kdamond_apply_access_report(struct damon_access_report *report,
 		struct damon_target *t, struct damon_ctx *ctx)
 {
 	struct damon_region *r;
 
+	if (damon_sample_filter_out(report, &ctx->sample_control))
+		return;
+
 	/* todo: make search faster, e.g., binary search? */
 	damon_for_each_region(r, t) {
 		if (report->addr < r->ar.start)
-- 
2.47.3
