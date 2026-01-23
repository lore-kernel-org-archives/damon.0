Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05933B6EE
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134276; cv=none; b=ryq0PSDHYR9s3FqMTR5iD4az6xcM96RiamYPTJo9kLqqhEUfdiJykSbpbBo9souEqR7rsNADEUvVayPlaAxyy4jZkvpR0nj+gqTAMIrZ2GmmECKthARvA+tinfEp1GmjHsJ+pHfxZVP9lsi+OBvphH+wfqPlB6b8UiSTG/bT5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134276; c=relaxed/simple;
	bh=XdcNrO1rpl9oROTyNF0DxVnNHOaFtHkMCKTMyUXfRTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKbzJyXmBiMHU7HUM6hj4GXwMw4Xs34PiKtAnrwc2OBEpdWVjtYz/QADE6JzPHpFs8vaOJHQ3W9YgjnLNbLwvLUiQADJ4ktqxg9ngSRhzTLXzt7LwsVPlDmEuKfiQ+vkcrtgsJb+i0pDD0RblydWS7oXZQeS6NklolZGJisol3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHdEWx4O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHdEWx4O"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7b23dd036so8990025ad.3
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769134257; x=1769739057; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w43nXR7xWSoKpck0e6FCmKt3LrGCcnIPN9hu9NiuuQA=;
        b=FHdEWx4OYFhl8eMIzfIj6BmQJgr5q2/HfSY8GJjxC5qbSEEzke0LURIpSFeN1hGSmW
         uWTzPA82TFQrI0wrlb3KrDMWGpwKN071mVKewWZrD/gZZdlSYannvauY/62ZAxpTGgFj
         Db2DFotLvPjUPbIm/vDBT3nstycS3Lluzb/QYaG6sCH6NZnOAUsp5xn01A2bwgaT+l7T
         +g5utWtM5IcI8w+ngG6pE93eSEFleQ/5k0s/fpULqD5nbFI6OrDwGNapuKunRW2q5IRw
         I7MGGCQw1TbSFVWfR0ctcDU75t5pCMmw4bJK7rmb4KsnnBuJsQhbMfJDP1SA3FH04DND
         1HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769134257; x=1769739057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w43nXR7xWSoKpck0e6FCmKt3LrGCcnIPN9hu9NiuuQA=;
        b=vDP6yeeun4urQ9lJFZUM8uUTA15IGdA9DHfeSjN9og7fG4QAMyhKbT9w0hmqfdHLoG
         z+CXDEIOMQnnFPkxzPzcNYy6NplZy5H3xJ5iAbX0HV++PZIOgHnquUzbtsGqFBWkjI9z
         SdbyHNwYHfjtok32zpntyTF4cakuCQuJEmM+N0gUOHcbbZmeoVb9A439G3QKtQeH5BON
         urnM7x4ZedgelL5f9qcCBlMlrDCardS7K93YLlVs9G6ARaVexHzThTUO37jQYJiuCyU6
         FXAqnndjidCEZUZmUhWnNHSUvtealqKKZy6iG/Kt3QPriQEmSINiHVW96arkthIOLn4U
         yQTQ==
X-Gm-Message-State: AOJu0YylKQ17DkxCgtaFhXGGm5afPLtocrBK9MjEKL75EkB4/TKWQE0G
	xoS4XrT79q66KS4Sdsvq9gIRixuAH6J8+l77uT73TTQkw/YPx4o4bCJfyHmGvmlZ
X-Gm-Gg: AZuq6aIYIDOWSE2Odi9Q5NVYjI+nXiw/V7+flTZb0vQDepeY3JR7XVO0F9OBllQfZJ9
	ay+zENOPFPR8VBo3M6e8z2RGfM60X0+X5qKPvnhB7RWj5dttipRcQHK7lmi84lM1UhCip01XPXj
	fuKMwbq2xvkVh/Hr1vPVHVOwZBIRQzPC0hbZ83PDQaEKLxUnreV+ANFM0MY66Eh060TqzcBerI1
	EmWUg16TlQ+OEJNM2WhmlkuCAF9Q9gdkTwDNGt6lNn5jyoy2v6nOP+cunxhFHKDJmZ/o+wvei67
	JrKsh7XIa6ISAbsK5xxKGgu3li/U534CBMEQqrbAXZa3VtX5z5rAQUcQKRQOeCkz2H3lgW++RJT
	WP+JH4lo4kaJ74ybBjUIY62D60ufC9pFtmyC+dJTAjFBchPcDWk3OY1zvKAKBq8Fo7BAxM3Vjo6
	KXRE1m8eU4wSK2nARQ+uDAYgu0ow==
X-Received: by 2002:a17:903:2b0e:b0:2a0:8963:c147 with SMTP id d9443c01a7336-2a7fe733d7emr13125795ad.45.1769134256567;
        Thu, 22 Jan 2026 18:10:56 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:a458:c153:e5c3:234f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3533521707asm3544251a91.8.2026.01.22.18.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 18:10:56 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 3/4] mm/damon/paddr: support perf event based access check
Date: Fri, 23 Jan 2026 11:10:13 +0900
Message-ID: <20260123021014.26915-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123021014.26915-1-akinobu.mita@gmail.com>
References: <20260123021014.26915-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds perf event based access checks for physical address spaces monitoring.

The implementation is very similar to that described in perf event based access check
for virtual address space monitoring.

However, for perf events that can be specified with physical address spaces monitoring,
the data source address corresponding to the sample must be obtainable as a physical address.
In other words, PERF_SAMPLE_DATA_SRC and PERF_SAMPLE_PHYS_ADDR must be specifiable
in perf_event_attr.sample_type.
---
 mm/damon/paddr.c | 102 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 68dcde5d423f..a5293af870fd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -48,7 +48,7 @@ static void damon_pa_mkold(phys_addr_t paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_region *r,
+static void __damon_pa_basic_prepare_access_check(struct damon_region *r,
 		unsigned long addr_unit)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
@@ -56,14 +56,14 @@ static void __damon_pa_prepare_access_check(struct damon_region *r,
 	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
 }
 
-static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+static void damon_pa_basic_prepare_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(r, ctx->addr_unit);
+			__damon_pa_basic_prepare_access_check(r, ctx->addr_unit);
 	}
 }
 
@@ -81,7 +81,7 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 	return accessed;
 }
 
-static void __damon_pa_check_access(struct damon_region *r,
+static void __damon_pa_basic_check_access(struct damon_region *r,
 		struct damon_attrs *attrs, unsigned long addr_unit)
 {
 	static phys_addr_t last_addr;
@@ -103,7 +103,7 @@ static void __damon_pa_check_access(struct damon_region *r,
 	last_addr = sampling_addr;
 }
 
-static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+static unsigned int damon_pa_basic_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -111,7 +111,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(
+			__damon_pa_basic_check_access(
 					r, &ctx->attrs, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
@@ -364,6 +364,96 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+
+static void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	struct damon_target *t;
+	unsigned int tidx = 0;
+
+	if (!perf)
+		return;
+
+	damon_paddr_histogram_init(&perf->paddr_histogram);
+
+	damon_perf_populate_paddr_histogram(ctx, event);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+		unsigned int nr_accessed = 0;
+
+		damon_for_each_region(r, t) {
+			unsigned long addr;
+
+			if (r->accessed)
+				continue;
+
+			for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+				if (damon_paddr_histogram_count(&perf->paddr_histogram,
+									addr & PAGE_MASK)) {
+					r->accessed = true;
+					nr_accessed++;
+					break;
+				}
+			}
+		}
+		tidx++;
+	}
+
+	damon_paddr_histogram_destroy(&perf->paddr_histogram);
+}
+
+#else /* CONFIG_PERF_EVENTS */
+
+static void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+}
+
+#endif /* CONFIG_PERF_EVENTS */
+
+static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event;
+
+	if (list_empty(&ctx->perf_events))
+		return damon_pa_basic_prepare_access_checks(ctx);
+
+	list_for_each_entry(event, &ctx->perf_events, list)
+		damon_perf_prepare_access_checks(ctx, event);
+}
+
+static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_perf_event *event;
+	unsigned int max_nr_accesses = 0;
+
+	if (list_empty(&ctx->perf_events))
+		return damon_pa_basic_check_accesses(ctx);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t)
+			r->accessed = false;
+	}
+
+	list_for_each_entry(event, &ctx->perf_events, list)
+		damon_pa_perf_check_accesses(ctx, event);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t) {
+			damon_update_region_access_rate(r, r->accessed, &ctx->attrs);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
 static int __init damon_pa_initcall(void)
 {
 	struct damon_operations ops = {
-- 
2.43.0

