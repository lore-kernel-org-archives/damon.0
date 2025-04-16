Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0422ACD3;
	Wed, 16 Apr 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777562; cv=none; b=m7kRK5mgk4Mk6VqmmHaqh5Y8UQjnlq0u5e05L0U2bsAAO6IPG/jMNQoNG6hD+lIzRgVNfGt9j9/TGE6eMeyJELh1+em+uspXRTeubcmSfUxn2PZeNEhA0OKWSoK6tvRxMLPgvDb4MQ/a1SJmcOcfat+i62onet4Tf1xI7Cqmteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777562; c=relaxed/simple;
	bh=Myr9hqDo4a3r6KKSLBNVuCCKy2yFFpmUIR+1u2z5KfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YI2Uw+B6IptaLzkvpHsiAKBs6hBH9wuxCxjIfznLKQiRdjIH207i91wBzWzPmodWhkTpOpkDZehM8cva0dyAN7Lq1K90WBvRKNlVkI0LNEjH4Rh5UIgXyl/RmCH22FHHNWZRIa6bFZEk0zYd1cuph+WxC/QBdVpzhAii/V3riQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssgOo52A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssgOo52A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA77EC4AF09;
	Wed, 16 Apr 2025 04:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777561;
	bh=Myr9hqDo4a3r6KKSLBNVuCCKy2yFFpmUIR+1u2z5KfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssgOo52A+rMsAEaIo1nl30iYl9LUCcs1e6V1UzIcrgdUsg8Q4lUrtgTm52upgkvT6
	 6WBId0vtCYjDycLRtsC6a1hm6EP3xIy2Jhh67DomvL4cbXtSkJ731/nkBOAzKUERVr
	 Pm7+eWR27haRl5A6P4pi/dHzOKewqdiJ3X93/bZ+j4x8PMuScCEa6U2i8xB5y3tZbq
	 GP2ls75H3R5q6PchY2DVVfS4/3sLdO3JhMnWa7epoYxSN8V9Xf8+4GfBphZlbc4r2Y
	 KNLtILFsYKs5rS1KvuO74Or7ZlrSZ+3vRfJl9uo8gmy6BO2f2FZZzpMwtl15kOyTyk
	 oh38xbLPIs6hA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/10] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Tue, 15 Apr 2025 21:25:46 -0700
Message-Id: <20250416042551.158131-6-sj@kernel.org>
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

Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
action handling from the DAMOS operation implementation for the physical
address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fc1c720e8cb5..20955eefcdbf 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -518,15 +518,17 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 	return nr_migrated;
 }
 
-static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_migrate(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	phys_addr_t addr;
+	unsigned long applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -691,7 +693,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 				sz_filter_passed);
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
-		return damon_pa_migrate(r, scheme, sz_filter_passed);
+		return damon_pa_migrate(r, aunit, scheme, sz_filter_passed);
 #ifdef CONFIG_ACMA
 	case DAMOS_ALLOC:
 		return damon_pa_alloc_or_free(r, scheme, true);
-- 
2.39.5
