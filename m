Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E7395702
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144273; cv=none; b=BBTe5fQYwczOb1Z0dYUwquChEl7rO5QTd9aWAtQQVV1omRiM0uRHj1L5XYlcQvY7yoiL9uYQJeACa6RTQy4YOsary9/GWQ1ApnU7fx3H0W0icGlXwknpEduNQn/iv/gabZSGBixNlCxRmZJnkRsff5orwasoVpTiV22kxN0Ig+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144273; c=relaxed/simple;
	bh=LPrYTrwnUWZ7ytHBL5nCDH6LuVnTbfijgy57EHaTEFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An6Z16e6wreoIeR2lsObB7h4TjdCR8F7WYsMZTMtXPKbWVwZPGa0Ywx0nv/vmJFmSD4hFJ1k/yM0tM6yt4jeikY97fcg+awuyw3auhty1t+Ov5zIR7L1/GN70aIDQNFUrEVncHT2aoN1QOwPaDElttavBso9oPIgVp5SfSfld4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZX3Gv1N; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZX3Gv1N"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-790948758c1so18582297b3.1
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 20:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769144264; x=1769749064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0i7a7403YgQyMlpi7E1tGdpNbWRUN7COl/lkLxdLS4=;
        b=hZX3Gv1NOh6sHNiN0Pbp4rk9Jp0EeGueswq4THGST+lEk5HTU8oPzAKOb+RRdCDoB8
         3E0HyzuLGF58DoZdegQnTgAN/1UwKRm04JITN1kTlRt89595QCZqaEIfAIjD9yTZJapu
         K64Uey6sS3mCRHSaXEBdDd58tssMTZchI9F0yU1FGU+YwKQyrXcCEMUczKLkakGKiX9x
         n3dyYg9dtGgFp0oWa7zKdqgcm/KsogvHLx22/OF7SIDfjVbJQ6tsLKslp9wd4mpnOmXZ
         RXEGJOnu4QPxVfadHs6FvHmWCMHzoskQbXFceoUPUj5VEjpV+NV/+Vj/RjQZjv9+3DCT
         owSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144264; x=1769749064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K0i7a7403YgQyMlpi7E1tGdpNbWRUN7COl/lkLxdLS4=;
        b=VJ7hMFKyW9nhgJryPUG0Moqucu2GkZ3uUoQPyr7rQj0whsDdsYflDWvg4S38azEMJf
         FfKRYSKgo12dkN8dv6F3Q2vSyMKziRu9OwiibCO1Inbz2vU2m3/Lkm8OSHhikwuxl9OX
         znsb32WLHui3HZOUsiZpTSzk4+HUTVYzUrBsFFSfwNf1Rca97Fj8W+G/XVs9Hw9eObLH
         G2Tquk17nCuQGQNTNG3qBLkzvsydvMv8BY7FEXQdCRw7Mx/BWx3Ck5ChXYY3SinSoYuX
         hweVwxRlTr2p7pwYjBSOWO5lmZpKibLE0xJhN0X/vVaXSR/L0Oi/zJhaIm2qEB/XNzdS
         r/tQ==
X-Gm-Message-State: AOJu0YzFXpRsSA4N0QVhto1ETke0Ja/a/n/sajZpbM7CufjByiFjh6u3
	ViA37mn8N23bWyR1TdB8fOLaO+POp7DWzJalGYMc3HeBtLqQPzZ+jEILb3NWMcc=
X-Gm-Gg: AZuq6aKH/hKapbrmRTwKHFqsyl4fJVagrcG97F8vBVvK+MGMHHAxN3Wa/RfZ8sDZ5a0
	7i3+dSYpZbsWKRJdpGMJofMRBP9XmWMy4oG8cwzp87IrvrzvGfSB6bIypwL9QgkpXSzEGYJwgLC
	r8Uh6LuoI0sOJgGwEw5Rk9GtVawzvi/ot7hCMDIPlxdTZVZKIggfxIIj4/daUfVQISi8SpYuWeq
	iNyKJxQnw7LqfSJFp8J3tbcrFOzkbpOo7vdwYR4IyufM/XaKLC+88MVXUE/1fiPENdTc8B+qg4h
	9rvqIJjxDgxwLyJvAwdDrykhjL4o7RG4+XJr+XfIPw3bLOsQ83MRIg7HIW/Hh96+8vdXJlao1q3
	Ej868+F0BL0FsDMP6siHd1UwIe9/VRAZ8AZZLLXjU/J7BunftK3tHGgB5GYRswtneV7FXlCJgh0
	LZGBE5UzX+3QLkIzcScWwqJHiaQa6116TpFf3In7SKV3jf9OkukjWJ0K99jS37FQ==
X-Received: by 2002:a05:690c:ed6:b0:787:b5ac:68e4 with SMTP id 00721157ae682-79440b4d2cbmr136867b3.48.1769144264173;
        Thu, 22 Jan 2026 20:57:44 -0800 (PST)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af14163sm6332217b3.7.2026.01.22.20.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:57:43 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH 2/5] mm/damon: add get_goal_metric() op and PA provider
Date: Thu, 22 Jan 2026 20:57:25 -0800
Message-ID: <20260123045733.6954-3-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123045733.6954-1-ravis.opensrc@gmail.com>
References: <20260123045733.6954-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an optional damon_operations callback `get_goal_metric()`
that lets ops providers compute goal metrics requiring address-space
knowledge.

Provide a PA implementation that handles DAMOS_QUOTA_NODE_SYS_BP by
iterating the monitored PFN regions and attributing bytes to the
goal's nid.

Core remains generic and asks ops only when needed.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h |  3 +++
 mm/damon/paddr.c      | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ec5ed1a217fc..67233898c27c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -649,6 +649,9 @@ struct damon_operations {
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup_target)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
+	unsigned long (*get_goal_metric)(struct damon_ctx *ctx,
+				struct damos *scheme,
+				const struct damos_quota_goal *goal);
 };
 
 /*
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 07a8aead439e..30e4e5663dcb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -14,6 +14,8 @@
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
 #include <linux/mm_inline.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -148,6 +150,48 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
 	return false;
 }
 
+/* System total RAM in bytes (denominator for bp computation) */
+static unsigned long damon_pa_totalram_bytes(void)
+{
+	return (unsigned long)totalram_pages() << PAGE_SHIFT;
+}
+
+/*
+ * Compute node-scoped system bp for PA contexts:
+ *   bp = (bytes attributed to goal->nid across monitored PA regions) /
+ *        (system total bytes) * 10000
+ */
+static unsigned long damon_pa_get_node_sys_bp(struct damon_ctx *ctx,
+					      struct damos *scheme,
+					      const struct damos_quota_goal *goal)
+{
+	int nid = goal ? goal->nid : -1;
+	unsigned long node_bytes = 0;
+	unsigned long total_bytes = damon_pa_totalram_bytes();
+	struct damon_target *t;
+	struct damon_region *r;
+
+	if (nid < 0 || !total_bytes)
+		return 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			unsigned long start_pfn = r->ar.start >> PAGE_SHIFT;
+			unsigned long end_pfn   = r->ar.end   >> PAGE_SHIFT;
+			unsigned long pfn;
+
+			for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+				if (!pfn_valid(pfn))
+					continue;
+				if (page_to_nid(pfn_to_page(pfn)) == nid)
+					node_bytes += PAGE_SIZE;
+			}
+		}
+	}
+
+	return div64_u64((u64)node_bytes * 10000ULL, total_bytes);
+}
+
 static unsigned long damon_pa_pageout(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
@@ -344,6 +388,19 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	return 0;
 }
 
+/* Generic goal-metric provider for PA */
+static unsigned long damon_pa_get_goal_metric(struct damon_ctx *ctx,
+					       struct damos *scheme,
+					       const struct damos_quota_goal *goal)
+{
+	switch (goal ? goal->metric : -1) {
+	case DAMOS_QUOTA_NODE_SYS_BP:
+		return damon_pa_get_node_sys_bp(ctx, scheme, goal);
+	default:
+		return 0;
+	}
+}
+
 static int damon_pa_scheme_score(struct damon_ctx *context,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -378,6 +435,7 @@ static int __init damon_pa_initcall(void)
 		.cleanup = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
+		.get_goal_metric = damon_pa_get_goal_metric,
 	};
 
 	return damon_register_ops(&ops);
-- 
2.43.0

