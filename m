Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB76155759
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786717; cv=none; b=LyJXNDnGjkW0pVHTJNzZOkxmU19hR8brcFt0Cz0qfuhuDbwhKrfaXq1wtvEkL9iM1v9aDRid8WxOLzigjcynx2TI8O+HND7C6itXHF4N1F8QgIIqch7tRc+HaL0YdJe0MvqjzyhUznIibdzeUEJ/YbpM6tH7vmW3ENv2rjRY2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786717; c=relaxed/simple;
	bh=G7Fu0wZ25rgNPynNKEIHXaUVvddrSam/Tlm3QxNTayw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmcoCvn8+s45TiV5mqNFzdZk0Ytw2Iw9t0kLks68AuPTzqhjYtCAQrpKoEUzkyvgUHUMEDVlsSp/qS/n0GpeIPIZ0FOfsvf7Yxiox2r3yytVxEIdhWu0QmsPe3G0l8ShvxMsdHLBnYKd5Ztx2UxPxtOZrUMuHw+vk/vJ1mxiGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JucXezI8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JucXezI8"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5238b7d0494so1564521e87.3
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786714; x=1716391514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctGBnUSLXrRprhSrpKhY3Uqe16Cdzk6f+Wm48VwrUoQ=;
        b=JucXezI8T/oWuQOHaFxsc87eDpcvIv2/IWTHbNto1j5/d4j0GGTPenooCVc0Oj7WBY
         5058Px5YwYD1/VEqihwSuTbXSh51AmvZ+60wUcGpHQTVjCQOwDsRQvPkz4M+UMGjmF5k
         Ko5ydG5c2TuVF19htIIQaYTVr+ISV09ZEriCSyRu4fi6pcnKDFNC9WPjR7hFnmdNFnxR
         3pQFvOhDW1hM8/5dPRdxneyyGWg73wOXQJpeyRM7MggKYDT992pnOFXQ3vF6tP3QPraN
         JPYUMcMniaPRrRUZ1bt0O6pSyzFxVXHluoIRA1lH3P1lQpo21LehBIWt1LmZQf9ZphhB
         UQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786714; x=1716391514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctGBnUSLXrRprhSrpKhY3Uqe16Cdzk6f+Wm48VwrUoQ=;
        b=k/EfKMKiiO9MyPiNiFZHORGYbAzYD3F642T5wq6/ShP8P0c191JZ+ecEBaeLx+x1Ha
         uvcBSuoRwHcGjcZgZCJ4GhzCkYXFodKguE6N2enr6z5UaQnKcLs8xnHHZ1TS5ONTf+2i
         8zdiiwwcNs20w32fu2Pa2Wx1m3ho7uxsCAILMyY+cxmFcyNsYmvS+Ivatdoib6tKoJFq
         KyhBmOtdgFiz1SjV+AIYOquhNP5dlSu/noOeim2yrWc97yTL1Uh+tLdg8vwVvaL53FN+
         dgIngj4LelfaWcbze3l7qz/KrOSl/D9E7SKSqknfSTAkzMpL/45PdsHsjxYUuZKFb8bH
         qhYQ==
X-Gm-Message-State: AOJu0YxvaqnQaHIzkm3fsYZN9JhlVjfpqSjfeFQtCQWj2pnwUervlksz
	oNlkYR7QLhRVDR1Hz0ls9iUhjWXUcwlg0qK6rIQZ5nRu3LmiE1GUcdmu/g==
X-Google-Smtp-Source: AGHT+IHoH2OQh0lMPjk+GFuTwPS5lpu2hTfvkGyRFJPjh1IvZ4+IVa7aXWECUdVJ4IoBuzJZk/x5kw==
X-Received: by 2002:a19:5f44:0:b0:51d:530f:dceb with SMTP id 2adb3069b0e04-522102779f9mr15191996e87.57.1715786711779;
        Wed, 15 May 2024 08:25:11 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:11 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 3/7] mm/damon/lru_sort: kdamond_struct abstraction layer
Date: Wed, 15 May 2024 18:24:53 +0300
Message-ID: <20240515152457.603724-4-yorha.op@gmail.com>
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

This patch implements support for DAMON_LRU_SORT
module to use kdamond_struct level of abstraction
brought in by previous patches.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 mm/damon/lru_sort.c       | 31 +++++++++++++++++++++++--------
 mm/damon/modules-common.c | 36 +++++++++++++++++++++++++++---------
 mm/damon/modules-common.h |  3 +--
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a6..1247a94fc 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -142,8 +142,18 @@ static struct damos_access_pattern damon_lru_sort_stub_pattern = {
 	.max_age_region = UINT_MAX,
 };
 
-static struct damon_ctx *ctx;
-static struct damon_target *target;
+static struct kdamond_struct *kdamond;
+
+static inline struct damon_ctx *damon_lru_sort_ctx(void)
+{
+	return damon_first_ctx(kdamond);
+}
+
+static inline struct damon_target *damon_lru_sort_target(void)
+{
+	return damon_first_target(
+			damon_lru_sort_ctx());
+}
 
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
@@ -201,6 +211,7 @@ static int damon_lru_sort_apply_parameters(void)
 	struct damos *scheme, *hot_scheme, *cold_scheme;
 	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
 	unsigned int hot_thres, cold_thres;
+	struct damon_ctx *ctx = damon_lru_sort_ctx();
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
@@ -237,7 +248,8 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(ctx, &hot_scheme, 1);
 	damon_add_scheme(ctx, cold_scheme);
 
-	return damon_set_region_biggest_system_ram_default(target,
+	return damon_set_region_biggest_system_ram_default(
+					damon_lru_sort_target(),
 					&monitor_region_start,
 					&monitor_region_end);
 }
@@ -247,7 +259,7 @@ static int damon_lru_sort_turn(bool on)
 	int err;
 
 	if (!on) {
-		err = damon_stop(&ctx, 1);
+		err = damon_stop(kdamond);
 		if (!err)
 			kdamond_pid = -1;
 		return err;
@@ -257,10 +269,11 @@ static int damon_lru_sort_turn(bool on)
 	if (err)
 		return err;
 
-	err = damon_start(&ctx, 1, true);
+	err = damon_start(kdamond, true);
 	if (err)
 		return err;
-	kdamond_pid = ctx->kdamond->pid;
+
+	kdamond_pid = kdamond->self->pid;
 	return 0;
 }
 
@@ -279,7 +292,7 @@ static int damon_lru_sort_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!kdamond)
 		goto set_param_out;
 
 	err = damon_lru_sort_turn(enable);
@@ -334,11 +347,13 @@ static int damon_lru_sort_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_lru_sort_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	struct damon_ctx *ctx;
+	int err = damon_modules_new_paddr_kdamond(&kdamond);
 
 	if (err)
 		return err;
 
+	ctx = damon_lru_sort_ctx();
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
 
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index 7cf96574c..a70b4fc7a 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -9,13 +9,7 @@
 
 #include "modules-common.h"
 
-/*
- * Allocate, set, and return a DAMON context for the physical address space.
- * @ctxp:	Pointer to save the point to the newly created context
- * @targetp:	Pointer to save the point to the newly created target
- */
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp)
+static int __damon_modules_new_paddr_kdamond(struct kdamond_struct *kdamond)
 {
 	struct damon_ctx *ctx;
 	struct damon_target *target;
@@ -34,9 +28,33 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
 		damon_destroy_ctx(ctx);
 		return -ENOMEM;
 	}
+
 	damon_add_target(ctx, target);
+	damon_add_ctx(kdamond, ctx);
+
+	return 0;
+}
+
+/*
+ * Allocate, set, and return a DAMON daemon for the physical address space.
+ * @kdamondp:	Pointer to save the point to the newly created kdamond
+ */
+int damon_modules_new_paddr_kdamond(struct kdamond_struct **kdamondp)
+{
+	int err;
+	struct kdamond_struct *kdamond;
+
+	kdamond = damon_new_kdamond();
+	if (!kdamond)
+		return -ENOMEM;
+
+	err = __damon_modules_new_paddr_kdamond(kdamond);
+	if (err) {
+		damon_destroy_kdamond(kdamond);
+		return err;
+	}
+	kdamond->nr_ctxs = 1;
 
-	*ctxp = ctx;
-	*targetp = target;
+	*kdamondp = kdamond;
 	return 0;
 }
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417..eeb5a06b9 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -45,5 +45,4 @@
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
 
-int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
-		struct damon_target **targetp);
+int damon_modules_new_paddr_kdamond(struct kdamond_struct **kdamondp);
-- 
2.42.0

