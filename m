Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3D5221
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B924C433F0;
	Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673300027;
	bh=2JLtN8tos+I5Ax4pubeTviifV4tMrNZA936nz1vxxcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fd3GB+4WIT0xNztbpTNCwyNhCDV1rv7z8xAvq8Nxtl4ZCZTIvE8E4qoOJzAuF0qd/
	 nIxdhKCEKTchIOd2lY5DKaGN1EQ2wSTEJ06oObeHGBiYuXf6fLkGhJMvJSkZFf1kW7
	 bZikE7oMHL1fDZ3JidDlVkhMdB74EQ6VYGwvUxzaf6y0k1s+VxA4Nh40zWa/Oyx1ge
	 hu7GJpQg5axP/a+/wogIcX0QmJqqRY06JBBZGPDszg/dSU8/V2wLG1VaU9PaWOwra7
	 NCsnLXECcDn2l7pAQ8RjpT/y0DEKzI5Sy9zMRvtfOpqm+BHHDySbyTDUHvsaNj77LC
	 6vtqs4qizzHYQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm/damon/vaddr: record appropriate folio size when the access is not found
Date: Mon,  9 Jan 2023 21:33:32 +0000
Message-Id: <20230109213335.62525-4-sj@kernel.org>
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

DAMON virtual address spaces monitoring operations set doesn't set folio
size of the access checked address if access is not found.  It could
result in unnecessary and inefficient repeated check.  Appropriately set
the size regardless of access check result.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c7b192006fe6..1fec16d7263e 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -452,10 +452,9 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
 					mmu_notifier_test_young(walk->mm,
-						addr)) {
-			*priv->folio_sz = HPAGE_PMD_SIZE;
+						addr))
 			priv->young = true;
-		}
+		*priv->folio_sz = HPAGE_PMD_SIZE;
 		folio_put(folio);
 huge_out:
 		spin_unlock(ptl);
@@ -474,10 +473,9 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto out;
 	if (pte_young(*pte) || !folio_test_idle(folio) ||
-			mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->folio_sz = folio_size(folio);
+			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	}
+	*priv->folio_sz = folio_size(folio);
 	folio_put(folio);
 out:
 	pte_unmap_unlock(pte, ptl);
@@ -504,10 +502,9 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	folio_get(folio);
 
 	if (pte_young(entry) || !folio_test_idle(folio) ||
-	    mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->folio_sz = huge_page_size(h);
+	    mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	}
+	*priv->folio_sz = huge_page_size(h);
 
 	folio_put(folio);
 
-- 
2.25.1

