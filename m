Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0E338F5C;
	Thu, 28 Aug 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401173; cv=none; b=EnaI0vK9Fxw9rfQY8aAIf9GvCIvhcUKY66/ZoZoFMMH/PzgwZUzqbnM62JhwTyS7WTHED2atu0sR1HxtWjow1JvypCZnYVW1NCXANjx+oySZtA7S4zxghEP+S2Yq1APEY46zDwgSxZN3b30fVIZ0Dv23OGzQp/Bk7SgUFWrti34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401173; c=relaxed/simple;
	bh=rgx+uucpOxswRbmVzaNKcGMA1yTfBZgSAqGGyfaZrnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hbw2jZyZawhykyRf2LBW71wzpLaVtBjjBbChkR9B2i7B+geIbN+8wPd87Q3R9aACpOw57LVpKylUW17NGBXuHe4RS4rpS3kGfm6YQ9XbFoDJIrF5LeeBYHoW17Y3a+W9h8D4MXHcvXoJBFLCqY17/XjHXyasVDKPdiNc+joXYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQZRxrmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQZRxrmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E56C4CEED;
	Thu, 28 Aug 2025 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401172;
	bh=rgx+uucpOxswRbmVzaNKcGMA1yTfBZgSAqGGyfaZrnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQZRxrmnUXCJGUkcjyA/VIU9G1NHvXvMntxG/GelRHsRAbEEZMBDh8r8YO8d1weBx
	 SUqEv/LszGwvNbwYUsUtZIjhU3WOk8YWG+/8zZZ5jRraXy3tb7C9RSwk/RQm/Z8emv
	 U3Pyq+fmqntP7Z1vUr20VrpirTo5kdXjOgZIkobDOB+yrYD2QHLsDYWl7mxVog2bZi
	 fe6w8yzC8ScLgoJ+hd73ITXEv4/lduJgqP/nTKNsPOmudRPIaGtC01nbkZUPZT7n02
	 txxPetFCNvbWV7Ng6aNFmsoEZbGPGup5MyPte5q0EidokvZsFXa9eHGLeKuxF1wEaZ
	 +LtcFsTl4cFFw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 05/11] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Thu, 28 Aug 2025 10:12:36 -0700
Message-Id: <20250828171242.59810-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
action handling from the DAMOS operation implementation for the physical
address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2cd1c9953983..0a122a8a9f1c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -256,15 +256,16 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 			sz_filter_passed);
 }
 
-static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_migrate(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	phys_addr_t addr, applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -274,7 +275,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 		else
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
@@ -286,7 +287,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	applied = damon_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
 	s->last_applied = folio;
-	return applied * PAGE_SIZE;
+	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
@@ -332,7 +333,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 				sz_filter_passed);
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
-		return damon_pa_migrate(r, scheme, sz_filter_passed);
+		return damon_pa_migrate(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return damon_pa_stat(r, scheme, sz_filter_passed);
 	default:
-- 
2.39.5
