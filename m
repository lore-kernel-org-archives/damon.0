Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813631DED49;
	Wed, 13 Nov 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515192; cv=none; b=rGPgd96uLQkXt9fQfFP4NMsxqXao2+8371UTUEvHQ1Pcu/76VC5rz4x3mo9Cu3CZfM7RL1XRfVJv7hvXpgR4ckRji9sMM2pAU6x2cskzNiBUM2JyejkxhZqbbaI+NZyVAkzdplMelm5U1c9wwXuDPkb9IUWXFq2XfSCHahFz0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515192; c=relaxed/simple;
	bh=6Kv8j6GXmb5OgoQ5xsiPf6fy1wOOGSi9iB0lHZRsXOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+svLScKa8qJHKpizUKbF+SMh3e0kKgQK/541qg4dShmpJdOsLssIUYqQ9TcvOtePj3ej77ISdUgYBiWaGk/uImXEX07gdvo7mEGi5k0uoNkL+KqlnuEqVmYWQbIJGTjz8Frqvt1TPLoNT+avBwX7hRMJ9PviowSQ+wq0SE+m48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1/agY4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1/agY4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D835AC4CECF;
	Wed, 13 Nov 2024 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515191;
	bh=6Kv8j6GXmb5OgoQ5xsiPf6fy1wOOGSi9iB0lHZRsXOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1/agY4mtPOWPXWZBhVsqgjbwv8NMsbuCUP2I9qvZ5wF/90hlRy8DhVmtSg7OSDku
	 pyz5low1w7vWU5yo3CU8zLSdJN1o8MSsS3I2p2hjntM+ji1MCf6jxv/FGD3c9WR45R
	 nlkG1pMI5X2xqnwEOgSI4x4QVzEztAoLpK7iZ/PDyGTg4wx1D3TikN6WqGsS5c4IJm
	 Hn9QIr+XYSv+fITSvjfkqh4pNORtFhSDmsXJ2zNlfaYhYlWX8EDv7UVUUKnCTkB6tK
	 ghKzb432jDLcwBmImZJ48ywfO1qpdiQ6Q/rkxubKlBHBadv0EAxiruqVgFSCQzleZE
	 Jrm7ClSIAvi4g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 2/5] samples/damon/wsse: implement DAMON starting and stopping
Date: Wed, 13 Nov 2024 08:26:21 -0800
Message-Id: <20241113162624.48973-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241113162624.48973-1-sj@kernel.org>
References: <20241113162624.48973-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start running DAMON for the process that user requested to estimate the
process via 'pid' parameter, when 'y' is passed to 'enable' parameter.
If 'n' is passed, stop running DAMON.  Iterating the DAMON monitoring
results and estimating the working set side is not yet implemented.  It
will be implemented by the following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 5912f15181c8..119ac8a2c901 100644
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

