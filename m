Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387122A4D1;
	Wed, 16 Apr 2025 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777560; cv=none; b=fDvk9zSvk1lSt40tNHzF5wMm6xppKRu8tGyyKwbp+GeVQSY5YVFzm3LrBBEdFzIg/fj6T96xub16GmSuGvqo+DhbayNdUlXf0lnnzBDER4afhu1cJ5qzES27TnwBlUK/eDW51RlKwKWUEoHpb3l5l8pWmZeA9PdOoOmA9BWH7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777560; c=relaxed/simple;
	bh=9FVKfq16K1iqFomF4A+02zHJ3L+keGr+U4JdYI2U9pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLZgJHcUMm7jVXZAL4z4KRl7lYLkBBfAr8CyfDuIYvCxAyjPp7N7JQ2eyLmLO2gpeJQ5qemGYWlnP8FbcMrZA/bp3b9U13E30kyhROLM43lkBpiU+zmR+AAbL7oX3jJ0g42p5DZE84eZglmWDnThOBCDeBpZ4zN1d7dL3ruqwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUrYZfeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUrYZfeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81106C4AF09;
	Wed, 16 Apr 2025 04:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777559;
	bh=9FVKfq16K1iqFomF4A+02zHJ3L+keGr+U4JdYI2U9pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUrYZfeTmpDfX1SIxZoLmRiBugiN4zNnnvQeinfMULtF0+KkhBzzyJT0kYwMNRp0g
	 eAGrdSq/NG6TMsPGpk8lFkwn3/Zr9mX8sZ0qyVDMdjakmZYPaSrXlATUWadvkbd5OR
	 8JtVPKdAksq72LSsiWySAC57QQWQOwf93j4xQ2tGnyA+Z0eXqf0AQPdBm5Slj8F46J
	 hMzgTwyRiKD1ia8y+GSWunlRSki2fAy0cJb9kg/mdLuGvL9D5Vt7t7BO87ee+CEfpW
	 Q4VVi32UYFA04bQ9bSz5DxOiBaFL7mHFJ0owdS/42oagnc2yBDkA7WRUbtJnTnCtOZ
	 DOH8JQ9MFg97g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/10] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Tue, 15 Apr 2025 21:25:44 -0700
Message-Id: <20250416042551.158131-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of addr_unit for DAMOS_PAGEOUT action handling from the
DAMOS operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index bc188aa2f01b..169ba81d4182 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -287,10 +287,12 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_pageout(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	phys_addr_t addr;
+	unsigned long applied;
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
@@ -311,8 +313,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_add_filter(s, filter);
 	}
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -672,9 +674,11 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
 {
+	unsigned long aunit = ctx->addr_unit;
+
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme, sz_filter_passed);
+		return damon_pa_pageout(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
-- 
2.39.5
