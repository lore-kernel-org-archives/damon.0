Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AE38F25A
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144274; cv=none; b=L02N1COPMYoXjJCpcCcyn89xrmEFrBy6KKaj09cXVXICgdmaoVgAHs9umNQ84Xfq1vPBxJetf1SHUWXVrINVH1oT7/HOTgYXCr2PWvFDVq0xrdauIH71zyZK2YoxvyyxI3DGhDUoEzH4h7tOnE4A6XBvaEcNM8me1ptqf/B10Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144274; c=relaxed/simple;
	bh=+AOWSwl3iOQaWr6u6EF8dNnZr3QA8X8HEruWVBZRH4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffaUqA5zOT3STxeGIkNumd1POW45tLXCtn9JwPx049oEMkAdfHmnQ0LfWnRNOLJahaE/jUHa/EboVtPGxb71KgEwK6P5gHY3rNHSWzgDoSjfYry2hQu1VWhtq0WjEJyLVNyhD8DQ553/hNFdLuCm3jckqaSZdp1cw23ybd7LwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwtT28i7; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwtT28i7"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79407df9391so19297717b3.1
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 20:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769144266; x=1769749066; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D+wUgUp3AIJjrSF87TlviSGACs4vs0t8FpLdk/Qkks=;
        b=WwtT28i7NMXHKb0SZROJ4EcUUs0DKyIRObWlPiYedWJr+bxJqV6ctv6IrvRZ4YsmRZ
         UORl6d9pdGasntM5GNuTRA8U6L0vUvry1PyjH4wsKY+CwTCvHZGGL0lSHRw5YV8Gu1mJ
         OjWgVw1JX8WrqZII0THRogBxkUmJ6Tyb612ML91f0FyU0+Ci/RPxKwmKA4Q4GxfWxIFP
         dUo3UV/fCym907AhDx2gE4VRPRAwn2xHFuREf9ihlGdwlN+V9XQ/VWBKn/hlgfbS6S19
         UI9Aa3YkOZigdJ6avpK+Uzi4kF/xdDevTzzjaVhtwfZ5aSjdIRGUk2Z/kTPl9F1CsDpB
         Y+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144266; x=1769749066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1D+wUgUp3AIJjrSF87TlviSGACs4vs0t8FpLdk/Qkks=;
        b=IoPMexdBBJD5m2a9Zg45eYnDYB5mgcXSZN8j7E9IYwqO3FCvTLK+XaU6QZvJUElqI1
         3so8FLbHnI1GmZg1Om9jFBLOR9EYeW1I8kO7LAYpOo1KctH769JUJbKpuXVO1sDzxM4c
         WiQU8exAFNUPlmoklslndgf4acgFI6BkW2UyvTMC/XTKa/SFu6pb/OATT7q0ubRS1wgg
         SHpYSWlEOHg5CstES5CSrrPdjcyZTKHZXzgPBZcXCI/UxCKsZNvViMi+/L4S9gCSfJaY
         2s7N4uXJoxFM0B/5xoY9PlY5r4C7e34e6e0R0DBmukiDcudJ6FFYI+ld/eDWJUeLrhFz
         LSkw==
X-Gm-Message-State: AOJu0Yx0GS7bYaQ/yfR0e8FxTOluqHWNcp52TkFQqWfkDERtzdPUlf0i
	yZ4cWqYFmG6uMYQCWjHfPIGQ7573XFyVMCS9mGE7bi5/TrQI9XI7ovDWjFdzclQ=
X-Gm-Gg: AZuq6aJL5fIDo9OfaQ3B3DtSRRxQ7ZAugrAX2JbwYXgRrVbCBjmKuHNnNsQXcYniEgs
	ZE5A3sSP515FarvbnVSU6dtj2oB2KkWS/NSYLrQtZcw/xX2aO3JCh//POK164yjsihPagREyM6E
	+rPfxUUXvnRHcjZ9b2ETZiRyiXcN6CseJal/ZiyW56Uerg8a5DaOjL6fg13+Y6B8ujvFuLZLJpt
	OccyI7EMKgG5KiyVPD452fdRFNzSJ1u9lsGDRt/uFh6AxXec82G1OCsfp/Tsc68PjXH+hOUxhy9
	oAidzIWr8i602WhgzweUE1TskUrvE7HY+S0oyrxdRiSr1+i0XJqIo9Tu+TXFpwo4f6We8uOcEPL
	nXkF+EW8QKdN3SGBudadtLTVYad4iSpsh0cEL5zpk/5/YJItqTWv1gTX4p6flqUaHLMQESd+hyH
	HgFfjcnl3sLaY+pH82BdXT3Udhw74eeey+LRHi+gTQ6ptqA1iYzeAuXTHzjnOE3A==
X-Received: by 2002:a05:690c:630a:b0:793:c850:9e05 with SMTP id 00721157ae682-79439900187mr15750197b3.28.1769144265778;
        Thu, 22 Jan 2026 20:57:45 -0800 (PST)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2d060esm6104507b3.56.2026.01.22.20.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:57:45 -0800 (PST)
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
Subject: [RFC PATCH 3/5] mm/damon/core: add new ops-specific goal metric
Date: Thu, 22 Jan 2026 20:57:26 -0800
Message-ID: <20260123045733.6954-4-ravis.opensrc@gmail.com>
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

Convert static functions in core.c to pass damon_ctx* and damos* down to
`damos_set_quota_goal_current_value()`. This keeps all goal metrics (PSI,
node_mem*, node_memcg*, and the new node_sys_bp) computed in one place,
while core remains generic and ops-specific computation is delegated via
ctx->ops.get_goal_metric().

Only static functions in this file are touched; no external ABI changes.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 84f80a20f233..d898bfcbef72 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2119,8 +2119,20 @@ static unsigned long damos_get_node_memcg_used_bp(
 }
 #endif
 
+static unsigned long
+damos_get_goal_metric_from_ops(struct damon_ctx *ctx, struct damos *scheme,
+				       const struct damos_quota_goal *goal)
+{
+	if (!ctx || !goal)
+		return 0;
+	if (!ctx->ops.get_goal_metric)
+		return 0;
+	return ctx->ops.get_goal_metric(ctx, scheme, goal);
+}
 
-static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+static void damos_set_quota_goal_current_value(struct damon_ctx *ctx,
+				       struct damos *scheme,
+				       struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
 
@@ -2141,19 +2153,25 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		goal->current_value = damos_get_node_memcg_used_bp(goal);
 		break;
+	case DAMOS_QUOTA_NODE_SYS_BP:
+		goal->current_value = damos_get_goal_metric_from_ops(ctx,
+							scheme, goal);
+		break;
 	default:
 		break;
 	}
 }
 
 /* Return the highest score since it makes schemes least aggressive */
-static unsigned long damos_quota_score(struct damos_quota *quota)
+static unsigned long damos_quota_score(struct damon_ctx *ctx,
+				       struct damos *scheme,
+				       struct damos_quota *quota)
 {
 	struct damos_quota_goal *goal;
 	unsigned long highest_score = 0;
 
 	damos_for_each_quota_goal(goal, quota) {
-		damos_set_quota_goal_current_value(goal);
+		damos_set_quota_goal_current_value(ctx, scheme, goal);
 		highest_score = max(highest_score,
 				goal->current_value * 10000 /
 				goal->target_value);
@@ -2165,7 +2183,9 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damon_ctx *ctx,
+				      struct damos *scheme,
+				      struct damos_quota *quota)
 {
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
@@ -2176,7 +2196,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	}
 
 	if (!list_empty(&quota->goals)) {
-		unsigned long score = damos_quota_score(quota);
+		unsigned long score = damos_quota_score(ctx, scheme, quota);
 
 		quota->esz_bp = damon_feed_loop_next_input(
 				max(quota->esz_bp, 10000UL),
@@ -2227,7 +2247,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	/* First charge window */
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s, quota);
 	}
 
 	/* New charge window starts */
@@ -2240,7 +2260,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
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

