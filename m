Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553399;
	b=VgUbaVytDZdzl+JvdhO8cgpfPGHc2xdDXWvbemIXv1SyAI/1MnDclTe7WNb0mw1Q34uk
	 lOhkT00Yx1t+QkzO/CKGdG9ywPk5J+fRA4Bq81jWafyVjkE4h7Zp3afRibDq3/pNEhopl
	 o7ZRKVMDkxyJAG95BuX+rv8Aqh2eXzDyxjscvFjMpPc+NY1jsTdxIosAO/GAse2Sh+OuB
	 UUiaGFAcrMpUhDUoO3OJmeEzuNtjGoPXS2ZCWM7nmGFBF83iq2sDc7I8SaMIHIgBr5r6+
	 fhZ27uyiuG3DdacH1hjlC2SmqUY0Z4PO6kn2hst6C5TB+YWa3cf05MRBpV8tkVImb0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LWF8HqqZQM/4p+lXqb/vLTu7jnbhepuFV5KLr5c8wVs=;
	b=k6CFN3QE8EVizW81jhde62tWuU8KfRZWS04yVQKuLjjXcHp2BEqsAhmwuXHy/ukrQuOD
	 75M8isAGSDy8hkGFYFBmVA42e0BbXoNEtJIHCkMjbP9CZKnwDXzYclhPCr6AwRrQWFgAT
	 RKNAQcbtqLPhZmfEKyTrBSFQLnsH0H1UdjHcQoeCR5Hhhu6fBZBjfsLFU/MdE49HCOdr4
	 SWNXw0Dlh/B8DqDF+J80CG0eFFn5R7uhsNQheZ1m6ryb+LPm4E97Pqaa9PNUjzCjMmvLZ
	 +OlnUJJCEkrXLu0kzU4DkowE0BSjLbnH74U8Ip5qDii7+4J33tYH+208WAUleMHXkOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mRVe0/+Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A10606A331;
	Sun,  1 Nov 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRVe0/+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F31F00A1B;
	Sun,  1 Nov 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553398;
	bh=LWF8HqqZQM/4p+lXqb/vLTu7jnbhepuFV5KLr5c8wVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRVe0/+Ybe+Q344Ia1uQmRR0/nFDfHWg4/WCy0yK8y1JLvVyKdE9xKBbujg1iaJ3C
	 iBUYVPzMOB5Qg7xQaJv1rhZg4S5mDd4nnH0Jp8nCAMXXxDJvDwLtvw4UwRMEgHzH2J
	 Qt3HwC0z+xp/aVswXTUMNtSZeLUI+m64ng6tDUZmW6b144L/pj1+QevI3kG9vU72a8
	 L11M8hYyPZtosI6CoTbMjfL/+TyROFcK8MPkWWnC1loerqsQ1M9EmevY0EaJAImabo
	 toOn3myIwZcenoxqk6DGfXzCkrKGMp7hvC7t4meDpg5JnoGza4nU5OSGtajzKqTKog
	 U+q8HgF8QA3Pg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/6] mm/damon/vaddr: use damos->last_applied for migrate action
Date: Sun,  1 Nov 2026 09:16:25 -0800
Message-ID: <20261101171630.81477-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101171630.81477-1-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
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

To avoid applying the same DAMOS action multiple times to folios that
are located across adjacent regions, damos->last_applied was introduced.
DAMOS_MIGRATE_{HOT,COLD} action support in vaddr is not utilizing it.
Use it to avoid unnecessarily applying the same action to the same folio
multiple times.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c271b6d63c027..b1d7bcf7305bb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -834,6 +834,12 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	list_add(&folio->lru, &migration_lists[i]);
 }
 
+static inline bool damos_va_invalid_folio(struct folio *folio,
+		struct damos *s)
+{
+	return !folio || folio == s->last_applied;
+}
+
 static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
@@ -854,10 +860,11 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (!pmd_present(pmde))
 			goto huge_out;
 		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
-		if (!folio)
+		if (damos_va_invalid_folio(folio, s))
 			goto huge_out;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
+		s->last_applied = folio;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 huge_out:
@@ -879,12 +886,13 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (pte_none(ptent) || !pte_present(ptent))
 			continue;
 		folio = vm_normal_folio(walk->vma, addr, ptent);
-		if (!folio)
+		if (damos_va_invalid_folio(folio, s))
 			continue;
 		page_idx = folio_page_idx(folio, pte_page(ptent));
 		nr = folio_nr_pages(folio) - page_idx;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
+		s->last_applied = folio;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 	}
@@ -991,12 +999,6 @@ struct damos_va_stat_private {
 	unsigned long *sz_filter_passed;
 };
 
-static inline bool damos_va_invalid_folio(struct folio *folio,
-		struct damos *s)
-{
-	return !folio || folio == s->last_applied;
-}
-
 static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
-- 
2.47.3
