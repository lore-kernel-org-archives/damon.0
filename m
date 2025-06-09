Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567821D5B8;
	Mon,  9 Jun 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499254; cv=none; b=n/1hHlK1tNIyjhYU1iNUce0N1RneaQQ/pFDO6+hzvJwt1RFb1Hnk8JQK8JxjPR8kd2e6ZGHkQOCXrjkTPwY+imXTGBj8se4ZHtVTD9zUJq3MNCFzOwyFOtbaejLro7vBJ6lgicT6xlqGPIZBxnm/7kR5PMctACsjCW+TtkfsWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499254; c=relaxed/simple;
	bh=jnTsM17LtmINmtfyvAGM5i8zoPOwCcuXIDUVAUmB5ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKihWtzuBS8GbPmqKenzImvFlLa5iADIrSU6ovGT3cVAUVPavbACIGJRKQ/mqwaj3EbpKHlTmHeoHuB9SgySD/OtBTfub3NTdcIKtMFJe1lzkRTryswES3mtJQkJnNEfY/gvAxMotU3F2cBiqH+A7bBP0FkhSSvUKpzN1czVQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh/HuXza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh/HuXza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A30C4CEEB;
	Mon,  9 Jun 2025 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499253;
	bh=jnTsM17LtmINmtfyvAGM5i8zoPOwCcuXIDUVAUmB5ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gh/HuXzaRqi7jyl+aFqpZ/vywENjstf6TEjhD4IR4/3I9UoEBAZxPm60h2xIIu8c+
	 drc2+NotsQfVnrpNYERtVUR7KhmCKfjF4NnDa7V8P4UzQ0wyAnyV91+70IhG0Lq1I9
	 wYMrC7bfo5X3P5W45C1cBEvu9ob/Y1D5+eCVbhGaXU+y8tzmQxdOMTq3DmK7JMCtrM
	 LZoIATgG4OMR3nA+Tty7Hsh1vQ5A/xUnGnafQrtOZKLqlbm4HsqDB3WSFqh3PmSrSq
	 JRwVpg1KDIOCeKrHSn9UQIVPvUGGk/Q5Ng4F716NX+qD3WUViqXz2BcykelbVi0uNh
	 1phnoWZuVh4OA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Simon Wang <wangchuanguo@inspur.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/3] mm/damon/paddr: use alloc_migartion_target() with no migration fallback nodemask
Date: Mon,  9 Jun 2025 13:00:46 -0700
Message-Id: <20250609200048.50914-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609200048.50914-1-sj@kernel.org>
References: <20250609200048.50914-1-sj@kernel.org>
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
