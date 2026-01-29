Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBB367F42
	for <damon@lists.linux.dev>; Thu, 29 Jan 2026 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723904; cv=none; b=SCU+sveN/cQQ0fAA3jOfKLzv0zcp0HnOtWfzR42NhfMD6oMHu6d6vx9hHSk+PqSKjdLM0HAyQ1QVo0bwpDlvO160RjbbHA3ZXd1b/LbXlVwclWV9Y3bR1bvPnQQpfW8l8+clELlOrvJavZVusxW3Svcy2a+/uihzaE66xmkNnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723904; c=relaxed/simple;
	bh=Lz87npd8Ymj4dgzZ8guZFLbK7FQeXfTehjSY3ldIw48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKgjMe6xzh7KCkr9KuBc9txRVYwPOubavvof5oCWgNzw+rncwSPEdv/jh8vgXCWX6rdXXcMi+79S08vwaGWIKzPu5n6827qmf6l0WFhnli3Xa1GmFlTLpr8cpXEnSm0/6YnSK+vhcycD72M5/E3Ej9zLKZ9FBQXRa0Zm1+WE2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejEp8lkx; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejEp8lkx"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b720bb90d0so1565101eec.0
        for <damon@lists.linux.dev>; Thu, 29 Jan 2026 13:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723902; x=1770328702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0za+mTabqTtCcABlRwV4DBkxWsk326LNSJGiU0z1JGs=;
        b=ejEp8lkxrd5nW0dix3/yqedqTm3S5FzFUXj6o3kv0YyzPEJmUvy33L/7LKfQ7WBlmx
         1/6/TGU2zpwxynO/JwzShSc5/ggPN/by5yg/zSPuBOlAJZ7K5i2+rAsGxU/b9YiAAbXR
         EoqmX/RHnD9n+RmAU/M7xTdo0LXf9KKX0ELhtXf46NX9gYGPHqy5uuvHUkpd7eoW1nJ6
         4LW8QWzdqUzvbJfnMYh+LUIDzn4UouvrCLdbTqpBfG0aJraDhKeC0mrSDz0e+TNvPpb3
         kF9y0PU7UIdwH3xOeWTyEeuLHrCUxcZ/8JMfBctjdZyWL4USofjh00GkKcoXcGEfCyc2
         18dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723902; x=1770328702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0za+mTabqTtCcABlRwV4DBkxWsk326LNSJGiU0z1JGs=;
        b=NmyNbYO/OVB03eQ0gMPBUsCrAHO1+UDNRAouDp+mw/a5OI4QECVY7KibAYynx3azw3
         t+x6HIAlKtwnhi8gmw5GBeSLFIH3c66Q/0pX41tzd0LgBY1oc+0biKB1o09wBxjXGpbV
         kFIPEkWIhJtJT+ls0wqaR5vIRnHdlbYXdIT8+jdkRJWo2L4VMblvvPA6FbklDgYqlZw8
         PaGayIipSnT0wuhhXuzzjdl4WI7R+YJVSig4n+zDkunXb9P5AXCACT5xBl7SP7TSqVbt
         SAuhcxxsq2MAvBkGReE/n3jy2q2tpuZjJU4WPLjc9b3CtHPbK3JKb/IrvvxNeNH/f3Kz
         SehQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzolDgnW3k+Y62umTRujlVGC4zCc7u+fLTWJEDKpTjkJTvPJNwi0NLo06B9hukCt+HvZ7Ncw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq16SYugTRVxeJvXVbShPVoKn2UuRCDS0c/m0zPACzplFl8zMU
	5C0XKxqQT3Yj7NFmCsFNlcJah++jtKLYb0MpvMIogiAFGACiUse5lZQ=
X-Gm-Gg: AZuq6aLiNV7E+xZJNz6CQ//OQLx3wxMlTf7GwYJkrNoGctRvV1lM7uS/yuFcy91MpJN
	B1LEAqeE9Pjyrc5iEre1m4jrlpXlG3lsONa/ceaKtzJSYGqqeDeuuwEw9K2+ZRBLhykpGZqn8Tk
	fU9v4qpXRaWC4k37AyM7Q9vK8HMJ87KjjFPwaElpcH9bkEHG7XB8aubhCXm4DPxjv422rFLFFtl
	+Zgq/IjBzqdeDs68DAf45wAFZMZR6aNEJxNV7sBdGXjoS5+9ROTb8/8pNwGkWHSrk6AuhsXImpl
	s9f25VKE5JNIkQZdMP9hIz3nh/5icTji/3JmMe6IKoEXxH0Bz+H/denl67cpX8pEzl5JAbajlYS
	HFY+ug//O/ZU6MXsxgr8GyQUmBX0la3eg7LIyGzFn+wi6vNdnV786dnEm8FmRfBD5kDzPaaLXVz
	6i0EopbI0OYA==
X-Received: by 2002:a05:7300:bc05:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b7c8903199mr438341eec.36.1769723902104;
        Thu, 29 Jan 2026 13:58:22 -0800 (PST)
Received: from localhost ([137.201.204.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16ec51csm8713746eec.10.2026.01.29.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:58:21 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [PATCH 2/3] mm/damon/core: implement NODE_TARGET_MEM_BP metric calculation
Date: Thu, 29 Jan 2026 13:58:13 -0800
Message-ID: <20260129215814.1618-3-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129215814.1618-1-ravis.opensrc@gmail.com>
References: <20260129215814.1618-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add damos_get_node_target_mem_bp() function that calculates the ratio of
scheme-eligible memory on a specific NUMA node to the total node capacity,
expressed in basis points (bp, 1/10000).

The function iterates through all regions that match the scheme's access
pattern criteria (checked via __damos_valid_target) and counts how many
pages from those regions reside on the specified node. This enables
quota auto-tuning based on the actual distribution of hot/cold pages
across NUMA nodes.

To support this new metric which requires access to both the DAMON
context and scheme:
- Update damos_set_quota_goal_current_value() signature
- Update damos_quota_score() to pass ctx and scheme through
- Update damos_set_effective_quota() and its callers

This metric is particularly useful for heterogeneous memory systems
(e.g., DRAM + CXL) where controlling the distribution of hot pages
across nodes can optimize memory bandwidth utilization.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 84f80a20f233..1482c97828e8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -12,6 +12,7 @@
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
+#include <linux/mmzone.h>
 #include <linux/psi.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -2119,8 +2120,52 @@ static unsigned long damos_get_node_memcg_used_bp(
 }
 #endif
 
+static unsigned long damos_get_node_target_mem_bp(
+		struct damon_ctx *ctx, struct damos *scheme,
+		struct damos_quota_goal *goal)
+{
+	int nid = goal->nid;
+	unsigned long node_capacity, scheme_node_bytes = 0;
+	unsigned long addr_unit = ctx->addr_unit;
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long start_pfn, end_pfn, pfn;
+
+	/* Only supported for physical address space monitoring */
+	if (ctx->ops.id != DAMON_OPS_PADDR)
+		return 0;
+
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
+		return 0;
+
+	node_capacity = NODE_DATA(nid)->node_spanned_pages << PAGE_SHIFT;
+	if (!node_capacity)
+		return 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			if (!__damos_valid_target(r, scheme))
+				continue;
+
+			start_pfn = (phys_addr_t)r->ar.start *
+					addr_unit >> PAGE_SHIFT;
+			end_pfn = (phys_addr_t)r->ar.end *
+					addr_unit >> PAGE_SHIFT;
+
+			for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+				if (pfn_valid(pfn) &&
+				    page_to_nid(pfn_to_page(pfn)) == nid)
+					scheme_node_bytes += PAGE_SIZE;
+			}
+		}
+	}
+
+	return mult_frac(scheme_node_bytes, 10000, node_capacity);
+}
 
-static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+static void damos_set_quota_goal_current_value(
+		struct damon_ctx *ctx, struct damos *scheme,
+		struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
 
@@ -2141,19 +2186,25 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		goal->current_value = damos_get_node_memcg_used_bp(goal);
 		break;
+	case DAMOS_QUOTA_NODE_TARGET_MEM_BP:
+		goal->current_value = damos_get_node_target_mem_bp(
+				ctx, scheme, goal);
+		break;
 	default:
 		break;
 	}
 }
 
 /* Return the highest score since it makes schemes least aggressive */
-static unsigned long damos_quota_score(struct damos_quota *quota)
+static unsigned long damos_quota_score(
+		struct damon_ctx *ctx, struct damos *scheme,
+		struct damos_quota *quota)
 {
 	struct damos_quota_goal *goal;
 	unsigned long highest_score = 0;
 
 	damos_for_each_quota_goal(goal, quota) {
-		damos_set_quota_goal_current_value(goal);
+		damos_set_quota_goal_current_value(ctx, scheme, goal);
 		highest_score = max(highest_score,
 				goal->current_value * 10000 /
 				goal->target_value);
@@ -2165,7 +2216,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damon_ctx *ctx,
+		struct damos *scheme, struct damos_quota *quota)
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
@@ -2176,7 +2228,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	}
 
 	if (!list_empty(&quota->goals)) {
-		unsigned long score = damos_quota_score(quota);
+		unsigned long score = damos_quota_score(ctx, scheme, quota);
 
 		quota->esz_bp = damon_feed_loop_next_input(
 				max(quota->esz_bp, 10000UL),
@@ -2227,7 +2279,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s, quota);
 	}
 
 	/* New charge window starts */
@@ -2240,7 +2292,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->charged_sz = 0;
 		if (trace_damos_esz_enabled())
 			cached_esz = quota->esz;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s, quota);
 		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
 			damos_trace_esz(c, s, quota);
 	}
-- 
2.43.0

