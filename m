Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496383FCB2B;
	Thu, 14 May 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767760; cv=none; b=RrUXWumHFoTmzL/QXrxw/4IsZEKvIZ0VAbcb524PNVSBkaQETLkL7m08iJLJdYAI4qG34SnH2fqh4lWDdG57Kg721m8vDBwi3p87Zxeh1um6LVNDggOzzpRoHC685oP07aBqJN7FfHKssqoATUPkL4GmXcB3ReCj/5cczQiLndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767760; c=relaxed/simple;
	bh=sqTfJo5eyZfIgPieldGgPDsesotOxkPfGODr6Semhvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFIT+cpxLIbpC+2V1xK+LvnT4ZoUIuo7I/NgqhQogmEc113kHbDuMsAHlPR5ylgi5PNiF3OkeDnLZTU8ASJgGepiF4ETC56E1OjkaSxHmBfdB25lmewrrrIvq1iGus3HEsO/u76iyFalxF2SQQ30JTT4CQWdTvCn1JQq9OSa81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APmAy3P3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APmAy3P3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46CBC2BCB3;
	Thu, 14 May 2026 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767760;
	bh=sqTfJo5eyZfIgPieldGgPDsesotOxkPfGODr6Semhvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APmAy3P3zBWWFCtHrCjRInzPQ1wTdfZiuTcr4UgvclDr3G/3mLnO+A8yEQpSfp+Ln
	 aVSCANxtL7H/yq1Cpn8hD4qSvJwdYArBsVTmlP4pDQP1ROZ+T5zNoehnpJN2nYW678
	 6CidkqI4pJpO9JEOzFgdUJpmuChQQKHhXf5H4T9tBp/pSb27XThlF28DfQZrLl9ucE
	 HPMG545QEjaH9tVeBDwR5ojKnM0LNjudL47QTwh05ZF5lmKl1zBAuKDg1gGDTE0dgR
	 YlX2PDw1vAKRY+Asr5W+LREqIWXX6peVO4ruvKeLQVMccS33zyECscvz2KeFkk/U2L
	 oUk73SfHPQ0/A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Thu, 14 May 2026 07:08:38 -0700
Message-ID: <20260514140904.119781-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an array for the per-region per-probe positive samples count.  For
simple and efficient implementation, add a limit to the number of data
probes and set the array to support only the limited number of counters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 ++++
 mm/damon/core.c       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 95b2c508a63ea..19b780bfab051 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -17,6 +17,8 @@
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION_SZ	PAGE_SIZE
+/* Maximum number of monitoring probes. */
+#define DAMON_MAX_PROBES	(4)
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
@@ -47,6 +49,7 @@ struct damon_size_range {
  * @nr_accesses:	Access frequency of this region.
  * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
  *			each sampling interval.
+ * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -75,6 +78,7 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned int nr_accesses_bp;
+	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
 	unsigned int age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 240cae1420c12..72acdeb8c478e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -229,6 +229,7 @@ static void damon_verify_new_region(unsigned long start, unsigned long end)
 struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
+	int i;
 
 	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
@@ -239,6 +240,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.end = end;
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
-- 
2.47.3
