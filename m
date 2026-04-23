Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF0335BA
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905004; cv=none; b=gzAfwBEXn6jPigY/73lLHldXaNNJbApm3d/bu5+lIlwio+9iVkl6KYdXgG4VdTArE1XPk3E3vvb9JFl6Upb8atR2Fd+ZSW0PTf7vIMhKHPUytEtnMJEkLvE60jGJw/maKsAUDvV7G1Yss2whpjGRC/i6nO3qp03sZnJn6wuJC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905004; c=relaxed/simple;
	bh=zD6qz5X/rWSgQAUWCeMWedYpYNfV0SmIsAxYAR37t/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA1riLaUvd0j7vXYzInnvOIhDyxajJ6u7voiF2Jp+NaGRCJr/S62YQBnJShDPWKmM/XXWkN/oNpa8TJQbTSvIZlVfIQprT9GfvNB35fTxCqHVsttuCqmVucfB6Nsxc/fN55Y3h/dNn+kZKtsg55wYro8Kqn7aD9XtEtzgIyx324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NieBkkqq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NieBkkqq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab232cc803so29169925ad.3
        for <damon@lists.linux.dev>; Wed, 22 Apr 2026 17:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776905003; x=1777509803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXenk36amG+z5JEoRJywc9bsTkp9ZrqQnMBLXM+h9NI=;
        b=NieBkkqqlnX6vuOYO7ZfT5MsK4Vgen/ulP3B7U7X1WruBT1ta61+wEw+e9WWwyUbFX
         t4D+Gq/7VDa2HiExqHagxXdYGzZGtdflDW8hdPH9JlwOzfYwut1wQuveS/ZaKtAcorof
         jUQRR5pqZh4+D1LZtXNmaFNWyv2OdFt5sFPjjqPzdovkN9PbhJ29bVDCyfDoDnjOFpiK
         7XSWJTLDFLmEah/1770I8W9bvKL2RGzMsUyi/SQsxMpKHDmytblPW0x4shosIGeBjALi
         DvxNp3O/NHWIaAnlJQxXDfY8Sjz7jiPYCu0XHjP3n4ZBDMJ6jz32nNruMbJwJJGI4clB
         M11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776905003; x=1777509803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXenk36amG+z5JEoRJywc9bsTkp9ZrqQnMBLXM+h9NI=;
        b=GUnOEAtOn3nhXrI4y6lPOz4M68yNEgrisQKxUO/jhtsBAuUJxDOrUPATwGnJHwHhPr
         EbncLQjoYbIMo+ERKSFiKXZXdnWcqjELmWN6OWFaTfmMBQloiAhgAZipFe9j+ZqEVTn/
         SV/9tiVW+1GY0J69Q4TWvFvXkUyvfwT1v5bySub7hElMlxyuBEjzkq+H0vQZXtbqXW/R
         KRoh31JWozgA0IbdnAAqSoCfqFd7J/kONFJSgpYu/HS9f9W8lPtionigQb6jRe9hUvuY
         ByzAcoK/WtbgwZXux0Ky5nY/RezwhnVXwqX7jPiGDsO1hazTCkyx89UNhGS0Lx+fV32T
         M6Zg==
X-Gm-Message-State: AOJu0YxWVIFR4qKbQXrtoN1BcWboRlUnJCDPdvoyGYsdtBrL2BQ6Js1D
	9AV/R0eUbr43BGSmaYMfYMfza5PrE1Qt+WmTY9mihr8jzzbpsDtFNNBbnWw2UQ==
X-Gm-Gg: AeBDietcTZfZHD9MOx+TFlOdJpVVTj9eJMoRvuMvlFi0B0Mcx+LclgCXwod+m+gbd3O
	xiz6hgp8B9IALArCaphKYUr1zUzHPr9f9SqRUHGZuV9CVYdzZfsxTlcOQduuZb8DGXt/OudjP4y
	xdsXSvLyVZOTFSgcdyzEGck7Vtsy44iLAlHQF/bh2bnAdOgcwpLUC39ocgvRbC0Y+DR/WLObrPu
	FALRupXylZ7ZxJAhaGKuWdvA+2FztnmUbWlHOBq7LvW/4DIWj0a4PgzT39h6HuDmDhYa2cPX/tK
	YCiYqMbLoUVDOEM5NxgcFb5P1C4KegxDhh8J+JPiul7IGRArGxjMUPvE3dLaLdCvmY20bu2Gth2
	I4TDzueaq7YgwJPFUTVsDzw/fQEBJ4Uqh26YM/v36FJfOAMHeSqIZvMDQpoRusgjsW0OMZdmKIK
	V3Y2wVUNn+TLKtDsU70p8MUOFt0oQNjyHKKCV1EnhHnfq0qBee
X-Received: by 2002:a17:902:d505:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2b5f9d67569mr230143095ad.0.1776905002628;
        Wed, 22 Apr 2026 17:43:22 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:963d:c5da:6762:8843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4bf7bsm176724085ad.81.2026.04.22.17.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:43:22 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v3 4/4] mm/damon/paddr: support perf event based access check
Date: Thu, 23 Apr 2026 09:42:10 +0900
Message-ID: <20260423004211.7037-5-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423004211.7037-1-akinobu.mita@gmail.com>
References: <20260423004211.7037-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds perf event based access checks for physical address
spaces monitoring.

The implementation is very similar to that described in perf event based
access check for virtual address space monitoring.

However, for perf events that can be specified with physical address
spaces monitoring, the data source address corresponding to the sample
must be obtainable as a physical address.  In other words,
PERF_SAMPLE_DATA_SRC and PERF_SAMPLE_PHYS_ADDR must be specifiable in
perf_event_attr.sample_type.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/core.c       |  3 +++
 mm/damon/ops-common.h |  6 ++++++
 mm/damon/paddr.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index def72672982a..bf9318c13d0b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3031,6 +3031,9 @@ static unsigned int kdamond_check_perf_event_reported_accesses(struct damon_ctx
 	if (damon_target_has_pid(ctx)) {
 		list_for_each_entry(event, &ctx->perf_events, list)
 			damon_va_perf_check_accesses(ctx, event);
+	} else {
+		list_for_each_entry(event, &ctx->perf_events, list)
+			damon_pa_perf_check_accesses(ctx, event);
 	}
 
 	damon_for_each_target(t, ctx) {
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index da39abe07cfc..f6db6bc4d882 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -28,6 +28,7 @@ bool damos_ops_has_filter(struct damos *s);
 
 void damon_perf_prepare_access_checks(struct damon_ctx *ctx, struct damon_perf_event *event);
 void damon_va_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event);
+void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event);
 int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event);
 void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event);
 
@@ -66,6 +67,11 @@ static inline void damon_va_perf_check_accesses(struct damon_ctx *ctx,
 {
 }
 
+static inline void damon_pa_perf_check_accesses(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+}
+
 static inline int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
 {
 	return 0;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5cdcc5037cbc..97df21281fb1 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -363,6 +363,47 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	return DAMOS_MAX_SCORE;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+
+void damon_pa_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
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
+
+		damon_for_each_region(r, t) {
+			unsigned long addr;
+
+			if (r->access_reported)
+				continue;
+
+			for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+				if (damon_paddr_histogram_count(&perf->paddr_histogram,
+									addr & PAGE_MASK)) {
+					damon_update_region_access_rate(r, true, &ctx->attrs);
+					r->access_reported = true;
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
+#endif /* CONFIG_PERF_EVENTS */
+
 static int __init damon_pa_initcall(void)
 {
 	struct damon_operations ops = {
-- 
2.43.0

