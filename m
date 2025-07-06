Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45E2BD5A1;
	Sun,  6 Jul 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832028; cv=none; b=hFiIyjM+fQqeTGH3OdtWsMYv/zak2dAN8/pV6wTMgKzOZ/aGvITsYfz0JnY5WqM2NQckNOV116gwiTIcItzmLF1TjrtpuEwnM0+4sEGQd9EJqJ97i9Op6sg8Ac4GSrhwfpph4w5z+EECwmve+aLYli1C82nHypZJDbYQaLoDT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832028; c=relaxed/simple;
	bh=zg5wCAX53+Zaz9D4ii0pAZ1fdfy4NlBPdESVNdjo6HE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGE7TnDpzm2v3uFc+kzrAVwrmE3YcFZqJKZCCsDDz6d060BbfwSXYsXx3xgAg0yBSFaAJkGwXzvLR1OhP/duCseiOyx/qAhXNB6sEcllZm45+EM4aG6m+Saz1lYfenOyzaFwojWn0Y+HIMr8BwMSfKzq15l5jN9QfiBnAr9rGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it7NQBAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it7NQBAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C53EC4CEF8;
	Sun,  6 Jul 2025 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832028;
	bh=zg5wCAX53+Zaz9D4ii0pAZ1fdfy4NlBPdESVNdjo6HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=it7NQBAWoPO1aaM9WpLvrXffl0pPOFaII5ba1fwJtcuYoLlKgAlonWs98iz+wwdWP
	 Do0DFn0jT1Q7jPqxaHWU7dhBY4eQ9lDPuA0Sf27Mt4qSANRkV1ub05pW1ZZ46k8Qa/
	 lzgm5fc314ixUmmp5kxMNPXkakT7xgOXHfeoEXQpuiKbw1Fkspm8hIQ9rqui0OZ45Z
	 XWC8y3/54QuPlziwBdvE0S+wJG8UE8+ivDRG12LtaQiv7w5N8piHpaIQ7vkYK8cZum
	 1PSun8pa+xGy+MsOsLfA4HVbWmXFh9Kd13a2ZcJnYId61dynFyf32kpccGqo624mpx
	 21IpiqPIL4SSg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/14] mm/damon/stat: use damon_call() repeat mode instead of damon_callback
Date: Sun,  6 Jul 2025 13:00:07 -0700
Message-Id: <20250706200018.42704-4-sj@kernel.org>
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

DAMON_STAT uses damon_callback for periodically reading DAMON internal
data.  Use its alternative, damon_call() repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b75af871627e..87bcd8866d4b 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -122,8 +122,9 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 	kfree(sorted_regions);
 }
 
-static int damon_stat_after_aggregation(struct damon_ctx *c)
+static int damon_stat_damon_call_fn(void *data)
 {
+	struct damon_ctx *c = data;
 	static unsigned long last_refresh_jiffies;
 
 	/* avoid unnecessarily frequent stat update */
@@ -182,19 +183,29 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	damon_add_target(ctx, target);
 	if (damon_set_region_biggest_system_ram_default(target, &start, &end))
 		goto free_out;
-	ctx->callback.after_aggregation = damon_stat_after_aggregation;
 	return ctx;
 free_out:
 	damon_destroy_ctx(ctx);
 	return NULL;
 }
 
+static struct damon_call_control call_control = {
+	.fn = damon_stat_damon_call_fn,
+	.repeat = true,
+};
+
 static int damon_stat_start(void)
 {
+	int err;
+
 	damon_stat_context = damon_stat_build_ctx();
 	if (!damon_stat_context)
 		return -ENOMEM;
-	return damon_start(&damon_stat_context, 1, true);
+	err = damon_start(&damon_stat_context, 1, true);
+	if (err)
+		return err;
+	call_control.data = damon_stat_context;
+	return damon_call(damon_stat_context, &call_control);
 }
 
 static void damon_stat_stop(void)
-- 
2.39.5
