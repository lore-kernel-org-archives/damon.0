Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0555221
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 21:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673A3C433D2;
	Mon,  9 Jan 2023 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673300028;
	bh=SYYr0BTjmOo642m5NR3wSprE6Rj/MW96ULPD1Kbq3N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q25whl2K6ubCd0mSRCAhV2abNV6arYJzypS9C6dgW1BHriuFbw8yu2UNtObHkGoo5
	 gFh4wNew0WdzD5BDISr8G2JEaOWrmiWYJgLs/1Aqt8Nz50eVSW7uGSGy/N+9aXgEi4
	 6zW0OwgSDQ7zGALkkf3vCQx5muQaAmlvxH4ry1T+cYP8sS7SXLaxvgSoXehUok9YU0
	 UQsVBtCxtIJUszstXt735cqzC5YQJtPCO95WNtN0kf2zXGXXExj0kBoBkwAYFQPXDs
	 AjPDe8OGaczVaic7Pcma+e9e/jShrhySjFSw1EUGzgUl5hJ7PZczmNBCXnoEIgfmFe
	 2+MH0CMWBrBUQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm/damon/paddr: remove folio_sz field from damon_pa_access_chk_result
Date: Mon,  9 Jan 2023 21:33:34 +0000
Message-Id: <20230109213335.62525-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109213335.62525-1-sj@kernel.org>
References: <20230109213335.62525-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON physical address space monitoring operations set gets and saves
size of the folio for a given physical address inside rmap walks, but it
can be directly caluclated outside of the walks.  Remove the 'folio_sz'
field from 'damon_pa_access_chk_result struct' and calculate the size
directly from outside of the walks.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 65c1e0f91535..b51606519bbd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -80,8 +80,6 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_pa_access_chk_result {
-	/* size of the folio for the access checked physical memory address */
-	unsigned long folio_sz;
 	bool accessed;
 };
 
@@ -92,7 +90,6 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
 	result->accessed = false;
-	result->folio_sz = PAGE_SIZE;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
@@ -104,7 +101,6 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 			result->accessed = pmd_young(*pvmw.pmd) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
-			result->folio_sz = HPAGE_PMD_SIZE;
 #else
 			WARN_ON_ONCE(1);
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -123,7 +119,6 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct damon_pa_access_chk_result result = {
-		.folio_sz = PAGE_SIZE,
 		.accessed = false,
 	};
 	struct rmap_walk_control rwc = {
@@ -158,7 +153,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 	folio_put(folio);
 
 out:
-	*folio_sz = result.folio_sz;
+	*folio_sz = folio_size(folio);
 	return result.accessed;
 }
 
-- 
2.25.1

