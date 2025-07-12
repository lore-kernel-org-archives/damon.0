Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FD292933;
	Sat, 12 Jul 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349828; cv=none; b=D/w7SUsacKv+0QEqC/zyQv4dbQb59Z+Ge0sCWeuGWpHQkOLlMDrM8Y5HzcfWVt2cPaPVnYWLQM6Eqsf/35BkLAJaO2OlzRNTIhxEIOg0u/gXTigPHSVZU5WygylBc81shjFV2TjrjyiiON06Ax83V5+nlgot+T0CloC13FEbDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349828; c=relaxed/simple;
	bh=OcwCWpW+gdDxIZHIlmwdIcrtDzrp/aZZNpUe+KYMNyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZh6SMaMFOSmZgqTz+zYJsTZFynljBNN+myIxBaqnDd1owGQP0Z5SyMWoGywUYfOqmUOBOU6YFvAQrxIkFzZlfTZTzwQdU1tyHpWTe9KF2Ch583eR7ebuvljpsz3PC42U8jZCDrsJnkwIOrgMsDNFGsmpFSSoMcr0Jun4eD0tK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoHT9o7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoHT9o7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9420EC4CEF7;
	Sat, 12 Jul 2025 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349827;
	bh=OcwCWpW+gdDxIZHIlmwdIcrtDzrp/aZZNpUe+KYMNyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoHT9o7neTDGCfTetH92f6SPSSQQ4gZ83vz4dRrQm7cPm00O2608YsjoNdxSCb1tw
	 lekOjYFQQngnDAaSVPYl8R4ZeTmp7RA46ZFwRfACQsQJgrLIoP2hkr/89WpQ4CM2pb
	 XdwFWc1rtMQpAFNM9KRCD0R1mKyxndDzJO1iA5GPx/LKho6AIM7PHhJVNOyOeT5a+t
	 YLKnKUZc4PbERRpJ+tKccu9JEzhBvLHkQ/CyG8U1seatzpVS/NvmbxnzpRUZ4rLpzw
	 ygbhVTty2PtzYFabUfFcCQLFlIoWXpJUi4IMTHb5IoYlKEgTBcyT9cp09wa51600UB
	 d4GOFX4fSjuHA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/14] samples/damon/prcl: use damon_call() repeat mode instead of damon_callback
Date: Sat, 12 Jul 2025 12:50:08 -0700
Message-Id: <20250712195016.151108-7-sj@kernel.org>
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

prcl uses damon_callback for periodically reading DAMON internal data.
Use its alternative, damon_call() repeat mode.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 8a312dba7691..25a751a67b2d 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -34,8 +34,9 @@ MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_PRCL");
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
 
-static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
+static int damon_sample_prcl_repeat_call_fn(void *data)
 {
+	struct damon_ctx *c = data;
 	struct damon_target *t;
 
 	damon_for_each_target(t, c) {
@@ -51,10 +52,16 @@ static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
 	return 0;
 }
 
+static struct damon_call_control repeat_call_control = {
+	.fn = damon_sample_prcl_repeat_call_fn,
+	.repeat = true,
+};
+
 static int damon_sample_prcl_start(void)
 {
 	struct damon_target *target;
 	struct damos *scheme;
+	int err;
 
 	pr_info("start\n");
 
@@ -79,8 +86,6 @@ static int damon_sample_prcl_start(void)
 	}
 	target->pid = target_pidp;
 
-	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
-
 	scheme = damon_new_scheme(
 			&(struct damos_access_pattern) {
 			.min_sz_region = PAGE_SIZE,
@@ -100,7 +105,12 @@ static int damon_sample_prcl_start(void)
 	}
 	damon_set_schemes(ctx, &scheme, 1);
 
-	return damon_start(&ctx, 1, true);
+	err = damon_start(&ctx, 1, true);
+	if (err)
+		return err;
+
+	repeat_call_control.data = ctx;
+	return damon_call(ctx, &repeat_call_control);
 }
 
 static void damon_sample_prcl_stop(void)
-- 
2.39.5
