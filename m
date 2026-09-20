Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244251FE471
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867251; cv=none; b=i0F4VIFedt9D4QErGkUMYohGqYX+rhwW38FxDu3nYEgh4ERnkyVFO4GJ/4N/nW51uANl/O3cibYUQ7Aq0Ez4A/MHm6iHtV1ANTU/qDA3+QHps488ZEDxlAFmiERo63f7nLQyNhgHjMXSxv3gZiPBLFMLAhNnqr5ioQ5zSooJnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867251; c=relaxed/simple;
	bh=6JLFnQ2GqjFyzuoWv/rqBbpaJm8GdN8HP1t2XRMoARc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkeVmZyPKcc8YQJMrDd5k2CfnlIIDbLpEWmlAys30grpW9WCc5NQyBQtokMLlNPquO2lDAA9I9s083xfV57VIoO2eH/yvCqNSgBR/+J3Ufm1/Kj2sPo+WidxORUMGlWiRvIEB0Gr9adpeey2zktEAvgNdYIlW9tz+yQVwJGRWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tmx/zWB2; arc=none smtp.client-ip=95.215.58.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tmx/zWB2"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6JLFnQ2GqjFyzuoWv/rqBbpaJm8GdN8HP1t2XRMoARc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789867247; v=1; x=1790472047;
 b=Tmx/zWB2JeaW7F881TUFnNK3uRqdQWJd5p4PJ82KlOOCFkAx3nEb1n0r4ReYcao6WnRo91/k
 Brydf6CJSPPIxfG7T5eFJZh1vNozEDUUSLowNIYbpVPTrv205N2WeDiE6FSqWwHcU3IrjywCGlp
 LT9bjEBvLEPEgVo4vjeuJMPc=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 8b0a3ddd2e356c4f;
	Sun, 20 Sep 2026 01:20:46 +0000
X-Mizu-Trace-ID: 8b0a3ddd2e356c4f
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] mm/damon/api: remove unused NR_DAMOS_* enumerators
Date: Sun, 20 Sep 2026 09:20:28 +0800
Message-ID: <20260920012028.9565-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

NR_DAMOS_ACTIONS, NR_DAMOS_QUOTA_GOAL_METRICS, and NR_DAMOS_WMARK_METRICS
are not referenced by any code.  Remove them.

They can be reintroduced if a real user comes up.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 include/linux/damon.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 836353c4ab9a..6258ef8be764 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -117,7 +117,6 @@ struct damon_target {
  * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
  * @DAMOS_MIGRATE_COLD:	Migrate the regions prioritizing colder regions.
  * @DAMOS_STAT:		Do nothing but count the stat.
- * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
  * The support of each action is up to running &struct damon_operations.
  * Refer to 'Operation Action' section of Documentation/mm/damon/design.rst for
@@ -137,7 +136,6 @@ enum damos_action {
 	DAMOS_MIGRATE_HOT,
 	DAMOS_MIGRATE_COLD,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
-	NR_DAMOS_ACTIONS,
 };
 
 /**
@@ -154,9 +152,6 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:	Scheme-eligible memory ratio of a
  *					node in basis points (0-10000).
  * @DAMOS_QUOTA_HUGEPAGE_MEM_BP:	Huge page to total used memory ratio.
- * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
- *
- * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
  */
 enum damos_quota_goal_metric {
 	DAMOS_QUOTA_USER_INPUT,
@@ -169,7 +164,6 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
 	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
 	DAMOS_QUOTA_HUGEPAGE_MEM_BP,
-	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
 /**
@@ -313,12 +307,10 @@ struct damos_quota {
  *
  * @DAMOS_WMARK_NONE:		Ignore the watermarks of the given scheme.
  * @DAMOS_WMARK_FREE_MEM_RATE:	Free memory rate of the system in [0,1000].
- * @NR_DAMOS_WMARK_METRICS:	Total number of DAMOS watermark metrics
  */
 enum damos_wmark_metric {
 	DAMOS_WMARK_NONE,
 	DAMOS_WMARK_FREE_MEM_RATE,
-	NR_DAMOS_WMARK_METRICS,
 };
 
 /**
-- 
2.53.0

