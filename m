Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892441;
	b=Zz2X7KiQn0sz9OoStB5T7xBgTXFABY5i31AeKYYBEPbUYcMYqanNz1q9/Jhu4VGGmB9q
	 J7wxrnSZMtVUH/OWTahnStpdWZNZYD6zoOSpHOYwtVLHIq0Dzlqr920T7JexmgS7AbHDq
	 m1z4oUf0jY01VRLzCfDdyrdjUgMNFvE07ntPMY2KtEGJ/JNsjOzlzqey05dLVPkvMuZks
	 M6kOzFW8gQ0388r/8GK7v1uQxnjPmtSrK9Lga3hTlwABV7WGD5qSwL4fGBJAaaAjkrRxq
	 WBWyFknKHgstGlXFMPYtn7dQ7vkh1ZNETma8ZIgARQCt8vC+6zMx57hdfOoeHQCpbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bdRKRFKagh7ahfwk2gV4n/6foyOOG7uiXbJX19kNPyY=;
	b=xqBtdQW5OF+EebvHTLcBLrjyonFn5wKQ6Wep89gfc+W6+M8kTZOPnOJwdbc/Q5x6/HPW
	 CfAHfn3lFIVDYNxJbPcssVVvELSMxEmKIx5dNwDd3EBAlLVQpkIggqL+CyTzyQ2pDxyK9
	 r542KuN9E75R/GgALMgOc/YQ0LG5RYeblGBdc79HlxBLynt1QaJMf5JskpX4Zw2FGjXJU
	 1n5Q0QkBEF7ld7flVm46tdrlrB7FLUNTmb/AwxJysBqxsNaLItXz7/knibp7MmUh0Y0T0
	 LH5fyRU5f68G0cDy7G6xjF5yT9Km+rA9upYx0nBbjcRbodN5HD1+45dC1r8hPaNhDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfXjSxLV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E25606A331
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfXjSxLV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042A01F00893;
	Sat, 28 Nov 2026 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892441;
	bh=bdRKRFKagh7ahfwk2gV4n/6foyOOG7uiXbJX19kNPyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfXjSxLVgZwSG7GBBXT+G2Of6CbqX5JPHuhKrMRd0/GXQBvS+I/cpwj2sX+cfKRNA
	 yOOn76JqF2ZnZueEUOY17gaAqOkzNm3zKWe8IIXT1TelhNRRx0dXEuF6O7gYv3BA7r
	 +auRvsVbe1lOZqQE2DsuWixD+jwiNqHIitSdsX7TNRa81RMgoq8VPz8ijvn1kCs4F6
	 BItFLaLgW8OKyv8mVIV05FBhYbJqaIa11/8i03zs6t5mLWfi9G1UBXJ2jEZaihwGps
	 gQgqViYGKEki7c++EPcy9P+FNDdC5QnU32MBagYSY/m1RzcfOhFfLIsAXbm4D1F1We
	 AxHn5zHO2pWTQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 1/7] mm/damon/vaddr: advance migration attempt in folio level for filter out
Date: Sat, 28 Nov 2026 11:00:26 -0800
Message-ID: <20261128190033.164440-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128190033.164440-1-sj@kernel.org>
References: <20261128190033.164440-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_va_migrate_pmd_entry() finds folios to migrate under the given
pmd, using a loop for the pmd address range.  The loop advances in page
size if a given folio is excluded by DAMOS ops filters.  DAMOS ops
filters work in folio granularity.  Hence it is more efficient and makes
sense to advance in the folio size.

Advance the loop in folio size for the ops filter out decision.  For
that, do the folio size based loop advancement offset update before
applying DAMOS ops filters.

Closes: https://sashiko.dev/#/bug/linux-67c34df7-6dfb-4e18-9ce0-0d26915e5785
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 750e643e020f..ca7ce9bd96e7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -883,12 +883,12 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio(walk->vma, addr, ptent);
 		if (!folio)
 			continue;
+		page_idx = folio_page_idx(folio, pte_page(ptent));
+		nr = folio_nr_pages(folio) - page_idx;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
-		page_idx = folio_page_idx(folio, pte_page(ptent));
-		nr = folio_nr_pages(folio) - page_idx;
 	}
 	pte_unmap_unlock(start_pte, ptl);
 	return 0;
-- 
2.47.3
