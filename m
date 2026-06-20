Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B509331ECF;
	Sat, 20 Jun 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976202; cv=none; b=Z1iGMm+copq1Lci1Dgbb5gBEO3fqYTcn6Wd2iPHGDxXOw5RmOzGr93i+TYud2mh3aPO53hYD7/up/NdVjlxLKqan7+G0rHKJByA/rgAJeabU/W8fD87hDcLUzpYatpwS6Re7BNC9WvuQ7XkCoe/55J71SqxTyn/Tn7hk3E0OO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976202; c=relaxed/simple;
	bh=Okct9WxhDCRl3pYyIXEvkAEkUhK1r6Acebvy/YPoM7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h124JDFUOlX0lGCIvIC7QaGAy3kNCd+YvaLRxG5nljySJHab+u67utNdO7xMR8bI0wDBua04yU8jNJPsbrTzCeMcUBkCOkQAidf7Jw5l7Fm2hCzn4tbiM+ewW/+4bBbaguN5tsVTLJVajTtPDoY4MuD2US7UEYXPyc6tNS1CAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoWhKPDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoWhKPDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BE81F00A3A;
	Sat, 20 Jun 2026 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976191;
	bh=E40P358cYrxpYfQ/+KC5PiFZHdq8eKTdsuOzYb/xPVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoWhKPDObMVUxx7K89FLrUtlZYwPL/utX18TjsuF0ZzniJ5Ct4iTEFlGy5pr5MPnl
	 y6aTbVwIJtyzjFDlYCaBqqs6Em5VnLIcl4gcyz1Ss1YA5zTDA0pDkVKIf041eUaJJ3
	 7YFJNM0r7Uww7y9mnPnMLpPXYv16Si+t2mMnnDC5shMEMJaCwDplAdTT1zpYJekmX6
	 m8vmTeUyE2YSeqivZbkIMV3XNneYX61zlYJ+bz42qjt8RXNhUyNK1Yl1sWTq0WHk1P
	 cuLKMT5NHP7WQP0OfdqCmwCfk3xj9d/QBxyqN2FDggFAf6WgSFcACl9yjDGgTrp9WY
	 ghvM94y6jC56Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 13/13] mm/damon: remove damon_region->nr_accesses_bp
Date: Sat, 20 Jun 2026 10:22:43 -0700
Message-ID: <20260620172244.90953-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code touches damon_region->nr_accesses_bp field.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ----------
 mm/damon/core.c       |  3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 55a743d99b567..90d2910b3217a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -47,8 +47,6 @@ struct damon_size_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
- * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
- *			each sampling interval.
  * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
@@ -61,13 +59,6 @@ struct damon_size_range {
  * not be done with direct access but with the helper function,
  * damon_update_region_access_rate().
  *
- * @nr_accesses_bp is another representation of @nr_accesses in basis point
- * (1 in 10,000) that updated for every &damon_attrs->sample_interval in a
- * manner similar to moving sum.  By the algorithm, this value becomes
- * @nr_accesses * 10000 for every &struct damon_attrs->aggr_interval.  This can
- * be used when the aggregation interval is too huge and therefore cannot wait
- * for it before getting the access monitoring results.
- *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -77,7 +68,6 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
-	unsigned int nr_accesses_bp;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f96f54a7f178a..abccac9e9f9e8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3580,8 +3580,7 @@ static int kdamond_fn(void *data)
 				 * aggregation, and make aggregation
 				 * information reset for all regions.  Then,
 				 * following kdamond_reset_aggregated() call
-				 * will make the region information invalid,
-				 * particularly for ->nr_accesses_bp.
+				 * will make the region information invalid.
 				 *
 				 * Reset ->next_aggregation_sis to avoid that.
 				 * It will anyway correctly updated after this
-- 
2.47.3
