Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52080293C61;
	Sat, 12 Jul 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349829; cv=none; b=l0HGVOM/F1qRizc1fwYcahZ/u7k0FXptXN3u8SvQZlityRhbXqYp/O389KB7xm+iEG7H9qGcNKrhZhFzyfoD7FOVIRcdZRHNeTjEYSGDCJEs37xb3lxHmmT+GVhNmlEyiW2HhDj/jF9tFAauvGbVIy7UWlwxfJBw8AISw4YJ8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349829; c=relaxed/simple;
	bh=ikK+Sa8v3BhJZJAUTG8MzTN6GxVcuKS7QD6jsmPU43w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvRcin1/TqvbfWRp+P0tn/uS7q69p/9a5/w50RSsUINxtc0LCosD+9FPbp/S25GudxibUtN1X0SiirgwKDjDcT/THoM+figZzBnYsuJWm2hSju1VDBvB0y3lNmePpFDHfTBa6uYYWjfvvGrX0LtOdBS0UJc7r7mEjdVxE/lXz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqyvPtNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqyvPtNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A645FC4CEF1;
	Sat, 12 Jul 2025 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349828;
	bh=ikK+Sa8v3BhJZJAUTG8MzTN6GxVcuKS7QD6jsmPU43w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqyvPtNiCmv3jSG8kU4DMI35E9lVuUa2RCtxo2cW4xZCDn8TvFbUPdd0G7WIOHEFD
	 vlnR+7mf5beW+zcxzghbfPMMeVcvKz8ZtDEbxHTu+2Z2e9HS6Mi1mHjEPNj8AUUWkY
	 heQRhGZbUv9vVGyUmsqORwvlH6P0Qq6dNwp4TojVbyV10u4u6QTZVOKG+iflteQJzf
	 yCChGBkEu9KpV0O45jrr/pJkvNJ3LAk1PxgPXpMJb+x0kEd7yLaiQ607ql6cuy4SLm
	 i4gVdmUb+aybB//Nc8R7g8Ay6QYGWIn7VXpp5bVWK8oYQQ+YU1TgkpTz8TqGM4bm7A
	 U6NwqD8A+vBIA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/14] samples/damon/wsse: use damon_call() repeat mode instead of damon_callback
Date: Sat, 12 Jul 2025 12:50:09 -0700
Message-Id: <20250712195016.151108-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195016.151108-1-sj@kernel.org>
References: <20250712195016.151108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wsse uses damon_callback for periodically reading DAMON internal data.
Use its alternative, damon_call() repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index d87b3b0801d2..a250e86b24a5 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -35,8 +35,9 @@ MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_WSSE");
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
 
-static int damon_sample_wsse_after_aggregate(struct damon_ctx *c)
+static int damon_sample_wsse_repeat_call_fn(void *data)
 {
+	struct damon_ctx *c = data;
 	struct damon_target *t;
 
 	damon_for_each_target(t, c) {
@@ -52,9 +53,15 @@ static int damon_sample_wsse_after_aggregate(struct damon_ctx *c)
 	return 0;
 }
 
+static struct damon_call_control repeat_call_control = {
+	.fn = damon_sample_wsse_repeat_call_fn,
+	.repeat = true,
+};
+
 static int damon_sample_wsse_start(void)
 {
 	struct damon_target *target;
+	int err;
 
 	pr_info("start\n");
 
@@ -79,8 +86,11 @@ static int damon_sample_wsse_start(void)
 	}
 	target->pid = target_pidp;
 
-	ctx->callback.after_aggregation = damon_sample_wsse_after_aggregate;
-	return damon_start(&ctx, 1, true);
+	err = damon_start(&ctx, 1, true);
+	if (err)
+		return err;
+	repeat_call_control.data = ctx;
+	return damon_call(ctx, &repeat_call_control);
 }
 
 static void damon_sample_wsse_stop(void)
-- 
2.39.5
