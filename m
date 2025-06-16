Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776C288C2B;
	Mon, 16 Jun 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094631; cv=none; b=POCo4ToRbZ2+AAlFY9pmuhdRsC8Oj9X5tt0XB+KXStpNWfZfNf9jlxZDowT4ScNSBwtnIPoreIMYvUJPSqWp7saUuQ//GyXBP2M9+EjTMnvrw8lhoFLnYhm3Y98KvuUR3K1fDOfVOqu4LI06nBQThp47HoNwebORUTMc2p3uYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094631; c=relaxed/simple;
	bh=jnTsM17LtmINmtfyvAGM5i8zoPOwCcuXIDUVAUmB5ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIkXJHPCcCsZO66AAvpS/dlV4pi492Ht67BQ0Ia5uiEFG+puFU1d1i1LfSgwUA01rmTsI7gYRfGJ73Lm1KFZtq0Bi/o4J8fXTvpNOT4IYMCYnK5Q43Zku4/WBldnrpx5dze6+4shUBfyyssD8CLGwia63lfZvp47MIkZmEToOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP2bHBVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP2bHBVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C51C4CEEA;
	Mon, 16 Jun 2025 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750094631;
	bh=jnTsM17LtmINmtfyvAGM5i8zoPOwCcuXIDUVAUmB5ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aP2bHBVKWXUKPdwARM5mBbkAco1AoG3cGAYwpasfwtSu0kpmv0qKtPKiqg9p+cg+m
	 B5RKz0DUji59WKUpNBmnUfppHapP3m1EPG/9KN+kLA+L9yTSISErT1p/iRxiFhTbBe
	 oVMSbjmGCd0ihlmnTVdfVUpne+EbVkA5iTzONJMW1FRiIheo2BHA9zZYNbrConG/SD
	 ydLsrfUTGiObElvrkPS/RtCUaqcTO8QirdT1EDEZmBoRbkZC3wRJ9r3qP1yDa/1Xlq
	 rCv4lMzR+2OZqciKheK4XI9rgBEasqySGIqW1Tcwx9n0Hs5+41B9O1xPa+1ILG422T
	 EI20cr9O/A+YQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/paddr: use alloc_migartion_target() with no migration fallback nodemask
Date: Mon, 16 Jun 2025 10:23:44 -0700
Message-Id: <20250616172346.67659-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616172346.67659-1-sj@kernel.org>
References: <20250616172346.67659-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_MIGRATE_{HOT,COLD} implementation resembles that for
demote_folio_list().  Because those are not only for demotion but
general folio migrations, it makes more sense to behave similarly to
move_pages() system call.  Make the behavior more similar to
move_pages(), by using alloc_migration_target() instead of
alloc_migrate_folio(), without fallback nodemask.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4102a8c5f992..fcab148e6865 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -386,7 +386,6 @@ static unsigned int __damon_pa_migrate_folio_list(
 		int target_nid)
 {
 	unsigned int nr_succeeded = 0;
-	nodemask_t allowed_mask = NODE_MASK_NONE;
 	struct migration_target_control mtc = {
 		/*
 		 * Allocate from 'node', or fail quickly and quietly.
@@ -396,7 +395,6 @@ static unsigned int __damon_pa_migrate_folio_list(
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
 		.nid = target_nid,
-		.nmask = &allowed_mask
 	};
 
 	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
@@ -406,7 +404,7 @@ static unsigned int __damon_pa_migrate_folio_list(
 		return 0;
 
 	/* Migration ignores all cpuset and mempolicy settings */
-	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
+	migrate_pages(migrate_folios, alloc_migration_target, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
 		      &nr_succeeded);
 
-- 
2.39.5
