Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2202BE056;
	Sun,  6 Jul 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832032; cv=none; b=pO2otmobVfO8mdl29Sga55cx+t8S5EEtXSxCGJmdIApOFdo71N99szsrHgBKiTAocQnwH/xIh3c9AXKbVPU+Hsc1PEQgaK9BGANWC4g6fa+HsfkY0A+Rgw5HBkXpMJqYeHkNhwjUJxrv6Sb0+rL6qj4yed1lUnv7JMd0L3CZGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832032; c=relaxed/simple;
	bh=qgCCHgMjBSqd296NRY6BPJU6GpcbgCIFTrT62DjsH+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxYG50+8UU65p2C/bel/G+Nc4Lj8rpqd5DBRmpWbUbkHumSF0PDJDSbwa1z5VJUl9rEfGfHaWL0sltVsZDbUtahoZPUnorNzC1nrLv6bzHLuE7Qesqwb+aCL/TGPIcfdtuDsWLxDbkDISwYqpbMsTPqyio/cN8SSdsMlP7+lGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8WmWqp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8WmWqp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A50DC4CEF2;
	Sun,  6 Jul 2025 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832032;
	bh=qgCCHgMjBSqd296NRY6BPJU6GpcbgCIFTrT62DjsH+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8WmWqp5pOIN39aMPaQGFH+p5aZKw8AS/c6J3FPzO732FLWrX8np8QOplYlf99KmU
	 iEHgPMCPLCFVQU5dkRKVNXmX5pVqGuQDgJQWE+9HNSfjA5K/5crGndLV4wspg2YJoU
	 tVWAg5+0sCauY+ilkIvLzlVtDeKQLQLB0n48QpCVmJ8HqHGo/HNIZrPzDiwmm1EbWa
	 LUYDAECjiJEoz5wW0N+N3DIx+Qcy4hSiLLjHjKgSUxvbdCmbMVdi4j75KITa2tIobL
	 fJt1nuTboznH6bRjz9UYPMG4qyG84DSi/uZXkeKX9Hdv6WnTywHmOFsnYySygOJF+U
	 ceUktNuq9G4rA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/14] samples/damon/wsse: use damon_call() repeat mode instead of damon_callback
Date: Sun,  6 Jul 2025 13:00:11 -0700
Message-Id: <20250706200018.42704-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
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
index 6037e5f8adf2..fb24190d2fc0 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -35,8 +35,9 @@ MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
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
