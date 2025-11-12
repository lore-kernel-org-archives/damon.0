Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE433F381;
	Wed, 12 Nov 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962151; cv=none; b=QMUb3J9QCBTQWphf+L8u7yElR+Vm4jLqLNKT7TrwGrHMiy6sOX6dFEeSn59b3KWg4XPPDyp299FtwcHzaYp7HbCfyqhDb5jgmxbGnjuIDha7BBuWY4Q3m7SkshLL3vFz9uCtMJYc0vs2OoNi5Aukkkuq3FYTo2AJXVU9AvMya/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962151; c=relaxed/simple;
	bh=oV9KpZkPcPBVuXqYBkV9kaSGZ1/EOa6v/e8B2pFRGFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIPwupGuQFuh1UwpBkhDnwYedch2O09gEqU7p8jVvQbp7beINY1tmaIetyTpVtAnSEb6eZq8rIFnha82XlJKpbON8FIp/jqqsYAWVSWJJYZ+/aWIM0UHYk639Nvv/RzcQtnXHSwe7BxWkfDcV9GfUxLiDA5DMabPYJsEq8h+Kbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWKbwFmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWKbwFmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DCEC4CEF8;
	Wed, 12 Nov 2025 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962150;
	bh=oV9KpZkPcPBVuXqYBkV9kaSGZ1/EOa6v/e8B2pFRGFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWKbwFmZmbqtbdTh322aK72q/tDo78ckesGHoFb9PYCGYvrGLRtAd5Az9X4HS373a
	 GAdfpe+jcawZ78w7TlE8qpfEqZr9g/lqyVEONHn6SkUnAbSCZlcerqNSYMe+zixwSg
	 8zACGTEcu8xIYXj6kzCNxaJIrnPHPe6w9ZgzGscoJHlmjXfRelvA5SimG+/3PNI9hj
	 C4LTWi2mlE0qsAZGTTGeC1sk5LVXHaAtax17Z9DxukagyT9NEcB/wNmPUQ3wyDoI59
	 4DJ0HX2Syt6kAsGAZbtwJC7pwahLw75Bc3MKf/wnqALNCc6Rn5YQuozQ+ATbZ2Qup0
	 Z97FMaJjH7ecg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 4/9] mm/damon/vaddr: use vm_normal_folio{,_pmd}() instead of damon_get_folio()
Date: Wed, 12 Nov 2025 07:41:07 -0800
Message-ID: <20251112154114.66053-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few page table walk entry callback functions in vaddr.c uses
damon_get_folio() with p{te,md}_pfn() to get the folio, and then
put_folio().  Simplify and drop unnecessary folio get/put by using
vm_normal_folio() and its friends instead.

Note that this cleanup was suggested by David Hildenbrand during a
review of another patch series [1] and the patch was updated following
the suggestion.  This patch further applies the cleanup to DAMON code
that merged before the patch.

[1] https://lore.kernel.org/0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0ad1ce120aa1..9c06cfe4526f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -442,7 +442,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 		if (!pmd_present(pmde))
 			goto huge_out;
-		folio = damon_get_folio(pmd_pfn(pmde));
+		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
 		if (!folio)
 			goto huge_out;
 		if (pmd_young(pmde) || !folio_test_idle(folio) ||
@@ -450,7 +450,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 						addr))
 			priv->young = true;
 		*priv->folio_sz = HPAGE_PMD_SIZE;
-		folio_put(folio);
 huge_out:
 		spin_unlock(ptl);
 		return 0;
@@ -463,14 +462,13 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	ptent = ptep_get(pte);
 	if (!pte_present(ptent))
 		goto out;
-	folio = damon_get_folio(pte_pfn(ptent));
+	folio = vm_normal_folio(walk->vma, addr, ptent);
 	if (!folio)
 		goto out;
 	if (pte_young(ptent) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
 	*priv->folio_sz = folio_size(folio);
-	folio_put(folio);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
@@ -718,18 +716,16 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	/* Tell page walk code to not split the PMD */
 	walk->action = ACTION_CONTINUE;
 
-	folio = damon_get_folio(pmd_pfn(pmde));
+	folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
 	if (!folio)
 		goto unlock;
 
 	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
-		goto put_folio;
+		goto unlock;
 
 	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 		migration_lists);
 
-put_folio:
-	folio_put(folio);
 unlock:
 	spin_unlock(ptl);
 	return 0;
@@ -752,18 +748,15 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (pte_none(ptent) || !pte_present(ptent))
 		return 0;
 
-	folio = damon_get_folio(pte_pfn(ptent));
+	folio = vm_normal_folio(walk->vma, addr, ptent);
 	if (!folio)
 		return 0;
 
 	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
-		goto put_folio;
+		return 0;
 
 	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 		migration_lists);
-
-put_folio:
-	folio_put(folio);
 	return 0;
 }
 
-- 
2.47.3
