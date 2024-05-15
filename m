Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D7155747
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786722; cv=none; b=o/vbAAO/NGQ2Lwlwmk9xs1hxoj7KsOptBuyuz0njLS8pOU3zisVwdyMhKSfoQE7L5NxzGv3SOTnc4vCZQvNbTRg8i01euQlidYT5DUTa9kfSO2LBuEoxxYEotE1zERttANbMnQr1RaloC+QbTRHBexSBgudfTsSah+a5SLUyROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786722; c=relaxed/simple;
	bh=yWWwvRFB+YRdK3nwb0W0UQdyeEDOnRcMw5X2C+YdaMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT0yXWrOGHYsdhAzNRKs/+qft8OXSKoisgbpoPBDw2qsFpM5ebu5cDdu2WBAwLg1DozpSwK8a+8fx2MkgotK9BwvPpxsLC+oCjngR7K8k4Dch866dV3OHe1jjD2/pny4gV0bU7nBjlMC0xkG7N+ZAet7XsO4BpTLat7A9BfAEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0xc0khT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0xc0khT"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5238cb1e3bbso1375907e87.3
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786719; x=1716391519; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENEnhGIX+ia8WlQUQl4nkYsBHasgAfMqGyY/LxBj4HM=;
        b=O0xc0khTXenNFEFrtleOPF/siL5nXfAaMdkJ99Kl9LMXtIPtx9vSmjauNcqfPI171/
         Dx2WQseHR7KEfHQReBH6GxgRh9KPBH9kIIOqz+d546q+1YscspUyuOSJ6ScYP3fJZ1la
         +/SD/vU3U1QjMOVEy4aCx/fOxprp+RyUFDOLaxKFuu0mqnVhyha+m1gjjmOYe9J4QROD
         etGsqYdyoHamj0bJ4+rhREBAN38fUkBRedEUbStGcA9ypNGuHQh2opw/lq9EROlklpts
         cl/V3ojY6x+Xi2E4tQ3kycwZoOLePhEu22wRC9OChUdyjAjLR6y4WjMFQOcVH4LiWTMd
         8e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786719; x=1716391519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENEnhGIX+ia8WlQUQl4nkYsBHasgAfMqGyY/LxBj4HM=;
        b=qtWXO1KqxtNvK4izR47wwoioqZEZDrGMYuns/gIpblwjlyWfCbu/w04FuzEwcYRAcu
         ngSGQ0Ur39PzemPGBkoG8LGydodpcNMcdIEci86Fjuer/jlOyd8xBMAFP9s8UXOc1uI7
         D7sXltBv7hfL3fmSTz/R/wONkt6z6osGuCUn01FHdtK9yWurI88cCPAcMWCFrezrSpiw
         2q1nEPC0bLF7DgGlmKVCXljJO4Da7zZaL3cxq7FJgbUVTPXqjlpN1Alb3LesJquyXzww
         vaEIhs5F3x5iyauTQ8tKhJ9ZN7/oIkCaCfpt6y2diKaavq5LjeNf0YzC9Ke56avkjXxN
         tdAA==
X-Gm-Message-State: AOJu0YzzGkoowxb61mqTwFkUKOhuIUduWtJHUTUlWxFrrppDLVjIXJUL
	PcYrNcN3K8T1lhRyaO+IZdT136ReRddAn1l6xvQna4JFY6VFP3c4UiqaCw==
X-Google-Smtp-Source: AGHT+IFV25/Ec137nA1PsQpv6JgpSSjBPVpM+iMNY0wo7QPUECOqK6vxKqIW03pwspGCM71+QL3Flg==
X-Received: by 2002:ac2:4e14:0:b0:522:4062:6e79 with SMTP id 2adb3069b0e04-52240626f95mr10005984e87.31.1715786718936;
        Wed, 15 May 2024 08:25:18 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:18 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 7/7] mm/damon/core: multi-context awarness for trace events
Date: Wed, 15 May 2024 18:24:57 +0300
Message-ID: <20240515152457.603724-8-yorha.op@gmail.com>
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

damos:damon_before_apply already had context index
in its trace, it just used only zero context index.

damon:damon_aggregated didn't have multi-context
awarness, so now its trace looks like:

    "context_id=%lu target_id=%lu nr_regions=%u %lu-%lu: %u %u""

There's only one new fields: "context_id".

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 include/trace/events/damon.h | 14 ++++++++------
 mm/damon/core.c              | 29 ++++++++++++-----------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 23200aabc..d5287566c 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -50,12 +50,13 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 
 TRACE_EVENT(damon_aggregated,
 
-	TP_PROTO(unsigned int target_id, struct damon_region *r,
-		unsigned int nr_regions),
+	TP_PROTO(unsigned int context_id, unsigned int target_id,
+		struct damon_region *r, unsigned int nr_regions),
 
-	TP_ARGS(target_id, r, nr_regions),
+	TP_ARGS(context_id, target_id, r, nr_regions),
 
 	TP_STRUCT__entry(
+		__field(unsigned long, context_id)
 		__field(unsigned long, target_id)
 		__field(unsigned int, nr_regions)
 		__field(unsigned long, start)
@@ -65,6 +66,7 @@ TRACE_EVENT(damon_aggregated,
 	),
 
 	TP_fast_assign(
+		__entry->context_id = context_id;
 		__entry->target_id = target_id;
 		__entry->nr_regions = nr_regions;
 		__entry->start = r->ar.start;
@@ -73,9 +75,9 @@ TRACE_EVENT(damon_aggregated,
 		__entry->age = r->age;
 	),
 
-	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
-			__entry->target_id, __entry->nr_regions,
-			__entry->start, __entry->end,
+	TP_printk("context_id=%lu target_id=%lu nr_regions=%u %lu-%lu: %u %u",
+			__entry->context_id, __entry->target_id,
+			__entry->nr_regions, __entry->start, __entry->end,
 			__entry->nr_accesses, __entry->age)
 );
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index dc92a8703..43bd6df75 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -865,7 +865,7 @@ int damon_stop(struct kdamond_struct *kdamond)
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
-static void kdamond_reset_aggregated(struct damon_ctx *c)
+static void kdamond_reset_aggregated(struct damon_ctx *c, unsigned int ci)
 {
 	struct damon_target *t;
 	unsigned int ti = 0;	/* target's index */
@@ -874,7 +874,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
-			trace_damon_aggregated(ti, r, damon_nr_regions(t));
+			trace_damon_aggregated(ci, ti, r, damon_nr_regions(t));
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
@@ -1041,21 +1041,15 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	return false;
 }
 
-static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
-		struct damon_region *r, struct damos *s)
+static void damos_apply_scheme(unsigned int cidx, struct damon_ctx *c,
+			       struct damon_target *t, struct damon_region *r,
+			       struct damos *s)
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz = damon_sz_region(r);
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
 	int err = 0;
-	/*
-	 * We plan to support multiple context per kdamond, as DAMON sysfs
-	 * implies with 'nr_contexts' file.  Nevertheless, only single context
-	 * per kdamond is supported for now.  So, we can simply use '0' context
-	 * index here.
-	 */
-	unsigned int cidx = 0;
 	struct damos *siter;		/* schemes iterator */
 	unsigned int sidx = 0;
 	struct damon_target *titer;	/* targets iterator */
@@ -1111,7 +1105,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	damos_update_stat(s, sz, sz_applied);
 }
 
-static void damon_do_apply_schemes(struct damon_ctx *c,
+static void damon_do_apply_schemes(unsigned int ctx_id,
+				   struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
 {
@@ -1136,7 +1131,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!damos_valid_target(c, t, r, s))
 			continue;
 
-		damos_apply_scheme(c, t, r, s);
+		damos_apply_scheme(ctx_id, c, t, r, s);
 	}
 }
 
@@ -1317,7 +1312,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	quota->min_score = score;
 }
 
-static void kdamond_apply_schemes(struct damon_ctx *c)
+static void kdamond_apply_schemes(struct damon_ctx *c, unsigned int ctx_id)
 {
 	struct damon_target *t;
 	struct damon_region *r, *next_r;
@@ -1343,7 +1338,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	damon_for_each_target(t, c) {
 		damon_for_each_region_safe(r, next_r, t)
-			damon_do_apply_schemes(c, t, r);
+			damon_do_apply_schemes(ctx_id, c, t, r);
 	}
 
 	damon_for_each_scheme(s, c) {
@@ -1696,7 +1691,6 @@ static bool kdamond_prepare_access_checks_ctx(struct damon_ctx *ctx,
 			ctx->callback.after_sampling(ctx))
 		goto invalidate_ctx;
 	*sample_interval = ctx->attrs.sample_interval;
-	ctx->prepared = true;
 	return true;
 invalidate_ctx:
 	ctx->valid = false;
@@ -1718,6 +1712,7 @@ static int kdamond_fn(void *data)
 		goto done;
 
 	while (!kdamond_need_stop()) {
+		unsigned int ctx_id = 0;
 		unsigned long nr_valid_ctxs = 0;
 		unsigned long min_wait_time = 0;
 		unsigned long sample_interval = 0;
@@ -1773,7 +1768,7 @@ static int kdamond_fn(void *data)
 			 * possible, to reduce overhead
 			 */
 			if (!list_empty(&ctx->schemes))
-				kdamond_apply_schemes(ctx);
+				kdamond_apply_schemes(ctx, ctx_id);
 
 			if (ctx->passed_sample_intervals == next_aggregation_sis) {
 				ctx->next_aggregation_sis = next_aggregation_sis +
-- 
2.42.0

