Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4ABE5E
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018041; cv=none; b=hUMUfopBvzCLOBnndIGfriauRMS1T+rzNQF6J4DeFC6XXjMfDlX0OxJ6yMD/Fh0Mgsv83/3viDQLnfTSVouchxy5Pzns8QtqaCbmQA7htWA6nUpoiUgKApDfVRLz8UlAePTlzIwgUapCPDd/SLwtZL5eOdO/i/dkOz2uLZBkIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018041; c=relaxed/simple;
	bh=XdcNrO1rpl9oROTyNF0DxVnNHOaFtHkMCKTMyUXfRTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq1OuUvTfMdl3dd5YoTYK6DUq9mmnZl/JcVUuCWtMSFXf4KLQX6yhMq7zwHrBlc6fD6SfRRE3kUG6o7yZ+4K7qNuJHswigOby+TuW/BrAfyoi8cP5AZvcyT15wzFQwdakecsvDaGswdkKCdfQ9fiPtsvJr3esZuyuY0PwaW9f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke4KLaiT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke4KLaiT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82980945556so1581134b3a.0
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018039; x=1773622839; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w43nXR7xWSoKpck0e6FCmKt3LrGCcnIPN9hu9NiuuQA=;
        b=Ke4KLaiT9zvf93bTjibpGyrACti9B2/rvBK+nANibvR4ZCP24jfr5iEINZ+5e0WecN
         a/9qUsUTdPlD9SjmqNtX0xVYx9X1SrlwQjVDHda0AnKvlnQ4H3L76FRylpXC2e81qrZf
         9y5ubrG8NLBczDZ8N2xNrweZf7ZiwsVlsnFuDPo4Loajf5CXk3qrhxGmG726vY97cWiJ
         Ge3v1ZnxuTizSeO9TlOuJKhmoz6Z53FABdplbmZRkfT8M8v6Ty0Bw79j42mg5p4Zu67Z
         PhY8KhxXlt4+YDod7FwE56ZhUahqhRtdcwY5pZ3+J5QvL5JaorXn6Sd6llG0f+JBWnNI
         hpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018039; x=1773622839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w43nXR7xWSoKpck0e6FCmKt3LrGCcnIPN9hu9NiuuQA=;
        b=QnAgpHv5Nehi9dKf0x2NYaItztq3ngI97pAbMxNItM3S5xpRYtO6c2IH69+YP6HJxk
         Qbc1tYlCVu3H84q3SPPDVoNukDjz4IhEdbIPzaGPeV+Xl1yrGWVu9tjk38DHa8C9j8Js
         cwAkYAB79IETWcJzudCtQLrUIJK2w3QJldtfr1znkhuBNz7fWTVS8VmxRe23vDH/7wd7
         8F8BRM3tT+Q8Wk1uX76Qpd2weYctcQS71BgdAgOsp5CWvPWaoFVzVWWJa+xlSdLa3p+K
         6vzFsmi7VIgXdUaBLBt1D5A2AuqF+6NsWjSeYb5h7qk4eMS+6UUfoufDK9E8xesvhG+o
         Z3lw==
X-Gm-Message-State: AOJu0YyrmCriYCQt5k/tfVh1mZhaSDLNEKhJrdHpS3MNLExjNGqplu8r
	JXARGllmWz4LYuoGaqJmkSalE/7WIZbdZ/L5f3x1iw58mBAah7FWgB3NupQ78A==
X-Gm-Gg: ATEYQzwQ0SBaYGdJDlsFka/6OrcF8aJebeVlY8Od8bolS6N2JYaODgn8aJ1J22HlfEo
	YyXhFqHgGZA80zg2G8d50TXTvI9UYAbApFchVkmCtlrZ7ji65CafDk+lEk9JA1In3bWvYMQKfAr
	FEW5ivELwo0nA4N0BkZw7UHYGO4vLM9Art6SGyEadH9WDE/dJi266tEEJRvCwVq2l5BnrE5vUbc
	USmnkY5+BGFZ56xA94I0X0gYH4sye+cMSrhoazllM0yEe0dsMx0SV4C/mwl9sZ50s0EAJOGapXD
	p8lVSQNZHIisWINCkFPGb3l16X4brSm9SqL2KPx6rcLOR0krSEukp6MCfam7O5dv2u5QZUWjumv
	wlDTq2M/ctcujcr2AIW6HYKgoF67oxQTUGsZPw2nlUHX+BagzJqX7lpOrghLdYwGRv/YNUo5E8c
	snWj120LCfxif1toEJjBrIuuiBE8U17S0uT1C9PA==
X-Received: by 2002:a05:6a00:cd0:b0:823:c59:9cb0 with SMTP id d2e1a72fcca58-829a2db98d7mr8752687b3a.1.1773018038895;
        Sun, 08 Mar 2026 18:00:38 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:38 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 5/6] mm/damon/paddr: support perf event based access check
Date: Mon,  9 Mar 2026 10:00:08 +0900
Message-ID: <20260309010009.11639-6-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
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

