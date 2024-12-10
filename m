Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86EB2397B9;
	Tue, 10 Dec 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867439; cv=none; b=IKMsY/XO6D0BEefrrjTyZKibHfSoDkTeD09Y2YJksrwCbI4vZsKXYsuICXYxTYiWODO3tS5AEw4qnMkERm53elchZlaHfy8Vfd0sM/jbkEj50zZyIeSf0J6lvPUFFsT/tWSEnxrsQNVpGhWTL2jYZua6UaS1mhmlEZ6FdmsHAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867439; c=relaxed/simple;
	bh=hoi3YSqqOR9ePv9N3p8sOerDMAcJ+RMcuGrppxt+mz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beXibOIon9Xur3n6FVmMB2xZ/EznSaUSfFOJpSBmdhPRHI51M+Jwv0zC15ZTTVESyebaNCIpmD7Ov1BzSXz/HxsCba75gBbtkVXUUn3631HrTxJxYkczPbYEHD/GrLH1jEcRvb/EYVsScodi7X9nnFoe/Kju2wZwz+QrhGIJ07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl7caDxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl7caDxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55444C4CED6;
	Tue, 10 Dec 2024 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733867438;
	bh=hoi3YSqqOR9ePv9N3p8sOerDMAcJ+RMcuGrppxt+mz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bl7caDxmLeYr/o8tpYrjKbJRh6DULZtvH6VaBGKNqJ9E7gVsm/G00XYnAtxCqsxPn
	 i8J260Ruy88dw6OYY3lGAg0E+gPFiX7P5FIql/AG4y/rdPuOCUkqofbaK0livJSP44
	 lwYtDlRNDcM0D6j4hpOKd0DlDK8F98uiP5Iddddck8qscsnNbCo3RUVg++r9aEOsug
	 THFGw1CoXBGjE/CMQNAwPlr8y0Hxqd2cNI+M2WQhks2hZ6VLsa6Tf2KY/qYE3+rQkO
	 /5P71yilA08C4due9Nrh6c5J3NjAq2SAnay8Iq1do/5xn6/R9cKK0BPbzJcR/kDF2w
	 0bx+PLksRF9iw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/5] samples/damon/wsse: start and stop DAMON as the user requests
Date: Tue, 10 Dec 2024 13:50:27 -0800
Message-Id: <20241210215030.85675-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210215030.85675-1-sj@kernel.org>
References: <20241210215030.85675-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start running DAMON to monitor accesses of a process that the user
specified via 'target_pid' parameter, when 'y' is passed to 'enable'
parameter.  Stop running DAMON when 'n' is passed to 'enable' parameter.
Estimating the working set size from DAMON's monitoring results and
reporting it to the user will be implemented by the following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 7f2cb76a1a70..2ba0c91baad9 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -27,15 +27,48 @@ static bool enable __read_mostly;
 module_param_cb(enable, &enable_param_ops, &enable, 0600);
 MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
 
+static struct damon_ctx *ctx;
+static struct pid *target_pidp;
+
 static int damon_sample_wsse_start(void)
 {
+	struct damon_target *target;
+
 	pr_info("start\n");
-	return 0;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+	target_pidp = find_get_pid(target_pid);
+	if (!target_pidp) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+	target->pid = target_pidp;
+
+	return damon_start(&ctx, 1, true);
 }
 
 static void damon_sample_wsse_stop(void)
 {
 	pr_info("stop\n");
+	if (ctx) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	if (target_pidp)
+		put_pid(target_pidp);
 }
 
 static int damon_sample_wsse_enable_store(
-- 
2.39.5

