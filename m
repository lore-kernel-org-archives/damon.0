Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818448;
	b=0vbu+8JORliohUK0Vu6m2jld6XK9+pQddoc626UxVAB94hccRC6t3l9evdhogtWk5f0J
	 KCCE9XEX7j3s5mzX5PDD60sGedYn2/2ws0lENMNwxYjhq0T4nA5DqRxhsArVitLKfvwS5
	 S7tJcNjpmIicJudQ3UR7dSLd/Gqj8FolRV4KjsbIiSmPXYkHKfm5J7kygui7La7SYBDDG
	 QmdZXAlg17dcy4xPpP9JPJCBq9qfj/VZqz1TbG1vCI6xwaG2ObyFuZvWQOin4C4GQaqZe
	 Xs5B2PZa5/QIfshlnyQBx/MqIX/7heM2Y7x3x5VH5NuBFJr7c/ukr9T0JwnH+wGTi+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nq8Fa7b2wVh3jUy0Qj4Fty4yFd7PbnbaXmqxKuMGOfA=;
	b=kvuBJpcvAaBDnwCn/KILs6E04+o9uVLf514lE43Cv1sxGmeyL8tiKajWcKQY1DJ7mw9r
	 mz8z2HFfCCUp5Luu1oMvJMIQMpNNWqI1SydfxbcCbwe4pYN4A7x0XLUp98RPoNnBSCnht
	 GviS5MoUyGrZmzXW5rST4h5sXCc2lkLRUtnD/58hvljp05Ju18nZek+WLiSA9kZyyDTKN
	 HM5DnUVCBu79QUe1GqoqmHTE5IQB+rZx03w6p5yFT+2QQJedWgUWYButow2LDq0727FAZ
	 wone3wTNfPOlerBQpgIG5KOWKCLJoMbEYUnGa30+FZ0ybDGCz5EVbHRXhdrBbKyA83g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNbROSYs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F80606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNbROSYs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBD31F00897;
	Fri, 27 Nov 2026 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818447;
	bh=nq8Fa7b2wVh3jUy0Qj4Fty4yFd7PbnbaXmqxKuMGOfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hNbROSYsdvH1w/S4paE27JdqWidZw29VsLhvVbN0bNkNMn2p9CjgjICY3ypxnUQXF
	 q5LFMkADXQ9eJdUBoCRnHUpHnF8kyJJTVHzpzeOrG5nG1igNuy1S5oLX77GQugGMNa
	 zg1DHoJ8Yv0sfGuv3ZhVHIRSmDWdIdFMbtKGTrUHjv2DF0qiriXkBh0R8cTA37fnRo
	 SE7whVqoylW51cTCVTMOkIe/x/IKf8PbF0exa42uGVEhnZcTZhAwbVH85Z2WyrAxdg
	 A+748mN340/MKoLjyGWXj7ojVL5ni5pUSsXmRKYfntUmgCDfcaycYtaJu4N2rnDArq
	 M3UI388tq61aQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 2/7] mm/damon/vaddr: use damos->last_applied for migrate action
Date: Fri, 27 Nov 2026 14:27:13 -0800
Message-ID: <20261127222719.105510-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
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
 mm/damon/vaddr.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index ca7ce9bd96e7..c8f93a19c840 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -837,6 +837,12 @@ static void damos_va_migrate_dests_add(struct folio *folio,
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
@@ -856,8 +862,9 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (!pmd_present(pmde))
 			goto huge_out;
 		folio = vm_normal_folio_pmd(walk->vma, addr, pmde);
-		if (!folio)
+		if (damos_va_invalid_folio(folio, s))
 			goto huge_out;
+		s->last_applied = folio;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
@@ -881,10 +888,11 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (pte_none(ptent) || !pte_present(ptent))
 			continue;
 		folio = vm_normal_folio(walk->vma, addr, ptent);
-		if (!folio)
-			continue;
 		page_idx = folio_page_idx(folio, pte_page(ptent));
 		nr = folio_nr_pages(folio) - page_idx;
+		if (damos_va_invalid_folio(folio, s))
+			continue;
+		s->last_applied = folio;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
@@ -993,12 +1001,6 @@ struct damos_va_stat_private {
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
