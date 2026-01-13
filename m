Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E2392C47;
	Tue, 13 Jan 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318051; cv=none; b=uTfQjJWTVeBvDuB3E9yuCahb3XmPA3nwAzOWbk6tVLfaniHDR+5D6K6wyGIUyK6HAYsMei6gIDArEzupZ8qnF87Er5Y2RqmbemUNKIjQ3M/Rk84U4vxup48lLZPaojNlmu0DMKps+KX3PwzJZgnJtNiJ6LWqxXFIAVAVeRAFxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318051; c=relaxed/simple;
	bh=F7+1XG5LjId9vgDKAd+pvaqjxO2poIILsvjkJM5g+64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8gXF/XVyvhl1tUz9Xkv5L/eyFdfAFJep/4Y7r712gaOo2mifxhtc3eo7s8zBRzWc2z1iK4QTNGkX1I7kMyoGIzeP4/SCjF6JcG1eBUnNg/S2MoYhp7xydNPlL3S/6tyDmwaY5XqngVwn9BdZR1hFc+tDnDAd44aQ24sxSjT+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYeyIAc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYeyIAc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812C2C116C6;
	Tue, 13 Jan 2026 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318051;
	bh=F7+1XG5LjId9vgDKAd+pvaqjxO2poIILsvjkJM5g+64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYeyIAc0DPPpy3z1Rl+8ig1Nyu0ySouQKyf6phjuEuB3RGheVTYUKbsvTHuTPDbmz
	 8aXf2v1J9bYSbGQyX3xR/g3cZIr4+ecuI3pAVK9JB2E19hYEVwytMRHmT7jadC4lZh
	 le0SJ31b3yfaNdvUhND+LOseKXPoiSYG29BonPklsL78TldIy1YGleHzemv41TvCmq
	 I/7Z1bcyf+tggipDawjvytAsszupZBKu6jrTedzFAub5n97J8xrc1h8M6ZM5ex7GT5
	 jI0Y8b709XpJCHtIalPaY18mdwJV1D4wSjkN77ZSd7DXKwYePkiYAO14j9X2d0LiT4
	 BXWifBme6kvGg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/11] mm/damon/paddr: activate DAMOS_LRU_PRIO targets instead of marking accessed
Date: Tue, 13 Jan 2026 07:27:09 -0800
Message-ID: <20260113152717.70459-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_LRU_DEPRIOD directly deactivates the pages, while DAMOS_LRU_PRIO
calls folio_mark_accessed(), which does incremental activation.  The
incremental activation was assumed to be useful for making sure the
pages of the hot memory region are really hot.  After the introduction
of DAMOS_LRU_PRIO, the young page filter has added.  Users can use the
young page filter to make sure the page is eligible to be activated.
Meanwhile, the asymmetric behavior of DAMOS_LRU_[DE]PRIO can confuse
users.

Directly activate given pages for DAMOS_LRU_PRIO, to eliminate the
unnecessary incremental activation steps, and be symmetric with
DAMOS_LRU_DEPRIO for easier usages.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 7d887a3c0866..4c2c935d82d6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -206,9 +206,9 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
-static inline unsigned long damon_pa_mark_accessed_or_deactivate(
+static inline unsigned long damon_pa_de_activate(
 		struct damon_region *r, unsigned long addr_unit,
-		struct damos *s, bool mark_accessed,
+		struct damos *s, bool activate,
 		unsigned long *sz_filter_passed)
 {
 	phys_addr_t addr, applied = 0;
@@ -227,8 +227,8 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		else
 			*sz_filter_passed += folio_size(folio) / addr_unit;
 
-		if (mark_accessed)
-			folio_mark_accessed(folio);
+		if (activate)
+			folio_activate(folio);
 		else
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
@@ -240,20 +240,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
-static unsigned long damon_pa_mark_accessed(struct damon_region *r,
+static unsigned long damon_pa_activate_pages(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, addr_unit, s, true,
-			sz_filter_passed);
+	return damon_pa_de_activate(r, addr_unit, s, true, sz_filter_passed);
 }
 
 static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, addr_unit, s, false,
-			sz_filter_passed);
+	return damon_pa_de_activate(r, addr_unit, s, false, sz_filter_passed);
 }
 
 static unsigned long damon_pa_migrate(struct damon_region *r,
@@ -327,7 +325,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_PAGEOUT:
 		return damon_pa_pageout(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
-		return damon_pa_mark_accessed(r, aunit, scheme,
+		return damon_pa_activate_pages(r, aunit, scheme,
 				sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, aunit, scheme,
-- 
2.47.3
