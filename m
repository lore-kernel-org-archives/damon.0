Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BA15573E
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786719; cv=none; b=FttaxNUBPOeZRC8ax+GOBk8ikbj4Qj7nWNfFAufz7qE3lhMidTttxBn5cgM5kY4FQRRuTcxIX8ncUp69kowZAp30GjBuldZOcG5V26aVAgJWOMITf+vqLFwrB1ngg7IluzQDYGQ5sOKVVs7wCu8RpddVd7/xdJg5GIoU1uKizKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786719; c=relaxed/simple;
	bh=GL0VdvrYXZuO6pdGCdsuS4qDsnIWOGSYuTZ2G3rJYn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jgizt2yeHd2xZf/SRuyw3gbrPz0EpuckmDr55FPqIRlAcuNQawlDC11BpJwgeJURwDPMkKJR6Wdb3p4jx/oGpVkbv5C19ZDiosJQvPshfkw737yIRguQrXPC4nwwj2DQrejQsi3P1q9wmFlgtx7GQBh3y63hIxIbWekMnQrbEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJhAzva+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJhAzva+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so8315205e87.0
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786715; x=1716391515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBq7qQtY+s9zT3i/odIQ1rLKUFP/64Y9F7eSqAck0J0=;
        b=WJhAzva+N1SnokD3hbB1AucrMvjvdhocondPl6kwKzCVVv6okqEw4zd9u62V7IFv+x
         we/4NKSwFJ4GDfGX7mMIvY8F4miMkwLmteel8UTSp6aS9GiQwEFw4FG2dt1kKOwdGIyE
         toGzUdpCxkq2x3k7kCuK1SvDoefQky/h/84HCHLz/1KHsjtW2b48mXOsQwX+bjGtlcwx
         D9efo5QAZHwM0A5qYDrx+Wg7zSDyPuRHmAOUFWlRfScd0ZKSJ/f3qjVYVSSGnu6JKgjo
         4sMkPR4XrWLDjgnzMAQDty0V27BB7lslcM4ACi7HX5wgCxEaOLdDl6dNCansnT0PyquW
         AN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786715; x=1716391515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBq7qQtY+s9zT3i/odIQ1rLKUFP/64Y9F7eSqAck0J0=;
        b=YGTrHKDqssiJvz5WR53TPsElevnJndh7lvuT/N8rOlpRKioeUyK8bBEBZfAZEnF7FX
         k94rpI/wmwS4+MP9ZmvXEDlJ6vnHxi9vNe8gBPguwGNeAIkxhtSPd7tHdjpejHRJuUzp
         0HYWeE8cZLUlXXjFAAQ8eUyuELy+0EyJ4N1x2SRi4nKDC8No07oK1KA0n62/bmHGsLkE
         C0pXhze2F8rOuwJEUst23ikdrrw8d/ddyp/PAUY03jc+gPViFd5h4H66JcxjGKqPodr2
         P4LrEBNly8khnNbjXRv0XaacYop68e9lZcEUB1K8Pszxs0M/azoZH1Bq/HMqVH8Wgj+j
         5IZQ==
X-Gm-Message-State: AOJu0Yy6fNIN9wwTtg5QCThNPrroUmSQ3mKCywUASpIreaO4MAQZ+2UI
	cs05nC5FYzfPbcr3QUpZQoEiTS5Nc1p7g1yqeXQYtI17wsmXsjVXSOt95A==
X-Google-Smtp-Source: AGHT+IGeWfAuJ6YnFkuU+kNgFWgKD9fmzDFs/xYk11A0K66FmiKcAMBayy+mVeVkSYffH3fLKCuRYg==
X-Received: by 2002:ac2:454b:0:b0:523:8723:32de with SMTP id 2adb3069b0e04-5238723342fmr2909032e87.53.1715786715334;
        Wed, 15 May 2024 08:25:15 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:15 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 4/7] mm/damon/reclaim: kdamon_struct abstraction layer
Date: Wed, 15 May 2024 18:24:54 +0300
Message-ID: <20240515152457.603724-5-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240515152457.603724-1-yorha.op@gmail.com>
References: <20240515152457.603724-1-yorha.op@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This patch implements support for DAMON_RECLAIM
to use kdamond_struct abstraction layer
brought in by previous patches.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 mm/damon/reclaim.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9bd341d62..ee760cbcc 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -150,8 +150,18 @@ static struct damos_stat damon_reclaim_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
 
-static struct damon_ctx *ctx;
-static struct damon_target *target;
+static struct kdamond_struct *kdamond;
+
+static inline struct damon_ctx *damon_reclaim_ctx(void)
+{
+	return damon_first_ctx(kdamond);
+}
+
+static inline struct damon_target *damon_reclaim_target(void)
+{
+	return damon_first_target(
+			damon_reclaim_ctx());
+}
 
 static struct damos *damon_reclaim_new_scheme(void)
 {
@@ -197,6 +207,7 @@ static int damon_reclaim_apply_parameters(void)
 	struct damos *scheme, *old_scheme;
 	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
+	struct damon_ctx *ctx = damon_reclaim_ctx();
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -244,7 +255,8 @@ static int damon_reclaim_apply_parameters(void)
 	}
 	damon_set_schemes(ctx, &scheme, 1);
 
-	return damon_set_region_biggest_system_ram_default(target,
+	return damon_set_region_biggest_system_ram_default(
+					damon_reclaim_target(),
 					&monitor_region_start,
 					&monitor_region_end);
 }
@@ -254,7 +266,7 @@ static int damon_reclaim_turn(bool on)
 	int err;
 
 	if (!on) {
-		err = damon_stop(&ctx, 1);
+		err = damon_stop(kdamond);
 		if (!err)
 			kdamond_pid = -1;
 		return err;
@@ -264,10 +276,10 @@ static int damon_reclaim_turn(bool on)
 	if (err)
 		return err;
 
-	err = damon_start(&ctx, 1, true);
+	err = damon_start(kdamond, true);
 	if (err)
 		return err;
-	kdamond_pid = ctx->kdamond->pid;
+	kdamond_pid = kdamond->self->pid;
 	return 0;
 }
 
@@ -286,7 +298,7 @@ static int damon_reclaim_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!kdamond)
 		goto set_param_out;
 
 	err = damon_reclaim_turn(enable);
@@ -337,11 +349,13 @@ static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_reclaim_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	struct damon_ctx *ctx;
+	int err = damon_modules_new_paddr_kdamond(&kdamond);
 
 	if (err)
 		return err;
 
+	ctx = damon_reclaim_ctx();
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
-- 
2.42.0

