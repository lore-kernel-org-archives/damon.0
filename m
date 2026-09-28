Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC6481FDF;
	Mon, 28 Sep 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584809; cv=none; b=aHZvQpB3JY1yzeB8TVgBkuzgLFLGAr56reOZXWbRdOHbQ1fAkotIQQDLdgJmfr9ToJf/XNkKwfXM9MF0WOMtS1fGMwB/QN8wbSuUNsPhvQj+Ha8LehpQkqcp50gAMqnGHr1O4dpFbiTt8K8/Hg43CbVtG4UeI77fTH05Do8ynRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584809; c=relaxed/simple;
	bh=OcmG0Y0qv+q80YJ75YzHC56qOPiVxrdDN1qj4YeCJOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+4piPYkF7IcCNiM5oLQDeQCUXM/xlZK3ouV3lnN5s3WfQE88x4m2okuSg/cw3H20Qa68UKJEacm56dP87JSo51OzlIqTLDo3ka2IPseOSvC8i4MiEw4xSUh3aDJbrqM/EY0K2XVaSsq3d6uRC8d7Pohn/U/1eCJ2ZkHMOAHRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQundLEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQundLEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C44C1F00898;
	Mon, 28 Sep 2026 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584808;
	bh=q2+vyI0uwtaGYfGHMp+R06X3EoG+48/p3c3tZsMizMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQundLEGOu6eEO8jgqUlI3iTPgbXb0YJUuVytRyOzpsjHNI3GcMnvJTabitLJbrOI
	 eBCebOAUV/giTUc5XmMurZJuv7k30PCk9SE8MLnr4zfRaj0DlRRvAVL1EKBPoQbaAE
	 UPictBPKmuxz5513dLXvKE01tjijw0lAqGIDQJFvoLJKIOXW3WHWpqPgzfq/Z7EJmv
	 qj23PI/EZd1IaMtYWgslqLxDXrymgWPi2VwM5MKcuLJaX/+aMarEDByVadiBg+gYuo
	 Ys2pvIoq4T6/7LT2K1rNCglE8/DgCCT2EbEpt6pgYEJR9TaBW+8UTsU2yux5J/Ouhm
	 ASxtiPKjHkLlQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/api: remove unused NR_DAMOS_* enumerators
Date: Mon, 28 Sep 2026 01:39:55 -0700
Message-ID: <20260928083959.4030-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928083959.4030-1-sj@kernel.org>
References: <20260928083959.4030-1-sj@kernel.org>
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
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260920012028.9565-1-zenghui.yu@linux.dev
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 include/linux/damon.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 844b175120f0..6a29dc2ac8db 100644
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
2.47.3
