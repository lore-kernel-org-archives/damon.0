Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5A39E177;
	Tue,  6 Oct 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269548; cv=none; b=Nw+5WjGIKL9Cm3lZWgOdKsIVT7YNR1q8c64QioJ1FzL7O0ByWstByVnlM1qa3xLM8I26u4z6dkBRDKawuy3VuaBnypTvU7QRy2WXfxf1GWm0ON/4sD6sQvOYVmU+/RHN6rerrrrvgdVbgxyrAdWZ/R5ditYX7dVulX5wXjyamhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269548; c=relaxed/simple;
	bh=BXJoVN0Ef/kCVwiqKKDyjfquHdXmS5V/bfX7R4PwsFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKz6/HZwXuo3YsBNW+d/iIe4dUvJJKQmFVdtsTLGKWa7yGpDRzcio/MTwUzVtoNs32aUDJH2h9f70jBqZ4Sp4pDWzBszOKmHFYfCOB1Vu54RenQOo/VEkfyAC/G39BHuHLQ66UU6TyqqK97kOHPmdQvIuU8BL5CLuHGVxTwiXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA6B6DDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA6B6DDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C761F000FF;
	Tue,  6 Oct 2026 06:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269540;
	bh=rjEiceRfwihVxvjUsA6PydjZA8ZEeM2KvlKASHa3zWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FA6B6DDdGbXCE4uDg89PIIdqfeKxPGTGxV1RGHAlFJnKB6ymf04I3VPPi7qXxVh6b
	 74rJxhhHcb8IP5rq0ZSrk766NYCBEyRz+uYEWunjHJ+cswbrKLr3huOPg6oBMWymvO
	 s5clc2JeRA2bf2ipKRQrqZUEcADoq6o8BcjN+NLv4zw7bPwvMbNG+lx1FP5OPAWK8b
	 LpIvhNwdTh+WoPIlJ/ww5XhCiCJUcPUCmRCg7XWkR8sPSFl4eCMHRceV9UcjKasI8B
	 zmdSyavm4kMhm/OX7/TiyR3AUvW0IDpOMQezoqNL/CjW1FAAwJDVF5u9l+5Lh4Fu01
	 I+4dsu1jk6ENg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gregory Price <gourry@gourry.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm/damon: use damon_get_monitor_folio() for hugetlb entries
Date: Mon,  5 Oct 2026 23:52:06 -0700
Message-ID: <20261006065209.41507-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006065209.41507-1-sj@kernel.org>
References: <20261006065209.41507-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry@gourry.net>

Hugetlb folio acquisition is open-coded in three places:
  - damon_hugetlb_mkold()
  - damon_young_hugetlb_entry()
  - damon_va_probe_hugetlb_entry()

DAMON already has damon_get_monitor_folio(), which paddr uses to
get monitored LRU and hugetlb folios and to filter them through
damon_folio_acceptable().  These paths bypass that check.

Use that helper in these paths too, so that DAMON acquires hugetlb
folios and applies its acceptance policy in one place.

No functional change intended. All callers reach these paths with a
present hugetlb PTE under the page table lock, so the folio is always
a mapped hugetlb folio and the helper always returns it.

Cc: Gregory Price <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261002140727.701709-1-gourry@gourry.net
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/ops-common.c |  6 ++++--
 mm/damon/vaddr.c      | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 7a7429359dc8..2f3bf86a221b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -140,9 +140,11 @@ void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(mm, addr, pte);
-	struct folio *folio = pfn_folio(pte_pfn(entry));
+	struct folio *folio;
 
-	folio_get(folio);
+	folio = damon_get_monitor_folio(pte_pfn(entry));
+	if (!folio)
+		return;
 
 	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
 	if (mmu_notifier_clear_young(mm, addr,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d5dde97b3cd0..b549496ea8e2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -411,8 +411,9 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto out;
 
-	folio = pfn_folio(pte_pfn(entry));
-	folio_get(folio);
+	folio = damon_get_monitor_folio(pte_pfn(entry));
+	if (!folio)
+		goto out;
 
 	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr))
@@ -660,8 +661,9 @@ static int damon_va_probe_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto out;
 
-	folio = pfn_folio(pte_pfn(entry));
-	folio_get(folio);
+	folio = damon_get_monitor_folio(pte_pfn(entry));
+	if (!folio)
+		goto out;
 	damon_va_probe_folio(priv->ctx, priv->r, folio, &entry, NULL,
 			walk->vma->vm_mm);
 	folio_put(folio);
-- 
2.47.3
