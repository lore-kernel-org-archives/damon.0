Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632087;
	b=FuAVqRuxH/R5JRvdMVAvuoasxI/4gDoDt3w/mXODif3z6KHWgIHijbQlgOc+1JamPlUC
	 9Phbi+iXAM8PD0ymtJ7DCfhd10SP6KWoUJgJkMjgKepTM7cdSQJG6XeTjDgRU83ZxhXS1
	 hRKZhcOR+KSEG4TA1nKQyfyAyOFVhcOWJFEwVgiE9x2qMqh/1hiuUrfEtOMy3QBVoOeoB
	 /lcyXGahNtMERmhU2mRIEYrUiZUEd67xG8ICbF2NMoMboFVzPvs/yiW0Tdx85KXPdcwgH
	 AJEN5Z0rbtHqOudOVJUwrU3VW9lNPCZBs3DOcueOU3VgnLKobfCVLcyZZ1wrbW/Ur7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+IKR9RbbuGuGx/yVom6rw6BPG5GNPAbNpjwaKg4rCb0=;
	b=OOo1Z5ETH3kiwWFH3SxV5VoB7knNJqE2oFVotsJS7JPKxyDlp1y6mIGO3f73dFdWNhXV
	 tngyu6srj0C42+l07lN0kBpWkUgwLTFdBqwTZ0la2HU95jhE1n6IZAvez8Pl+8/oL8e8l
	 L8USB1wa1LO7fHqVbeJ47WOJ02RZyVH5iwDusvySv9DluUsblJ37bKlLyMlFdaNzquobB
	 VRhpnjRljDd0fhHnegIYoT1RfrBuyZCrurA2aj6npILdSBupooSWfVjZIYXzQwFS4EjFb
	 DHChgLHxeqEGOCkJUmpYv7nJOObXlFvRlAXwuRSW+JDLpvhIEIN2L+8dTDYx3sNtu3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCgQyS4g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550460A34D4;
	Mon,  2 Nov 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCgQyS4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A01F00A26;
	Mon,  2 Nov 2026 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632087;
	bh=+IKR9RbbuGuGx/yVom6rw6BPG5GNPAbNpjwaKg4rCb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCgQyS4gxgKrL6ivpISet83poV/dEhRXOe58Rztq6mhqbAx0PILnDAQbC2eGQZoxz
	 P5GXEwFJJa5546UnO1Szdjt0UbXAwPhU6BI4rbfKV/ZT6A2ODGnTfq2pa1ZSPjMh+O
	 QsSdlLfZKb4tHBcBLnViwunT9CLdEgNQyAi3ZqKFIlK/pyhQVZG3g1qFoswzDAHcXQ
	 bKPLwqxyv7LcL/fttn+G4UzuWC49D85BiOkz6T8McRV06dm5tfNOT6LfwRV1+lQcVm
	 LWC5uFbIqdpyeg4YzcU2Sup7ATcad4o/WCt/llXv7TDQhx746G4pFg1OkzPRe2ZE6M
	 IkbLx7R2KynxQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Bijan Tabatabai <bijan311@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/9] mm/damon/{p,v}addr: skip folios already on the migration target node
Date: Mon,  2 Nov 2026 07:07:52 -0800
Message-ID: <20261102150757.93058-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

While measuring DAMOS migration overhead, I found that the target_nid
path isolates folios already on the target node, then puts them back on
the LRU without migrating them.

Skip them before isolation in vaddr and paddr, as the vaddr explicit
destinations path already does.

In a synthetic same-node fvaddr test on a two-node x86-64 KVM guest (8
interleaved runs per kernel), guest-kernel cycles fell by about 29% with
4 KiB regions and 90% with 16 MiB regions. Median kdamond CPU time fell
by about 76% with 16 MiB regions, with no clear change with 4 KiB
regions.

Cc: Bijan Tabatabai <bijan311@gmail.com>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/179320218513.2.7432933245840036676.damon-same-node-skip@gmail.com
- Put performance results in commit message.
- Use two tabs indentation for second parameter lines.
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/paddr.c |  2 ++
 mm/damon/vaddr.c | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2cfdc356b4157..5b773012a8764 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -368,6 +368,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 		else
 			*sz_filter_passed += folio_size(folio) / addr_unit;
 
+		if (folio_nid(folio) == s->target_nid)
+			goto put_folio;
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
 		node_stat_add_folio(folio, NR_ISOLATED_ANON +
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b549496ea8e2c..1e65e7651cd98 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -786,14 +786,15 @@ struct damos_va_migrate_private {
  */
 static void damos_va_migrate_dests_add(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr,
-		struct damos_migrate_dests *dests,
+		struct damos *s,
 		struct list_head *migration_lists)
 {
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	pgoff_t ilx;
 	int order;
 	unsigned int target;
 	unsigned int weight_total = 0;
-	int i;
+	int i, nid;
 
 	/*
 	 * If dests is empty, there is only one migration list corresponding
@@ -801,7 +802,8 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	 */
 	if (!dests->nr_dests) {
 		i = 0;
-		goto isolate;
+		nid = s->target_nid;
+		goto check_nid;
 	}
 
 	order = folio_order(folio);
@@ -821,12 +823,13 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 			break;
 		target -= dests->weight_arr[i];
 	}
+	nid = dests->node_id_arr[i];
 
+check_nid:
 	/* If the folio is already in the right node, don't do anything */
-	if (folio_nid(folio) == dests->node_id_arr[i])
+	if (folio_nid(folio) == nid)
 		return;
 
-isolate:
 	if (!folio_isolate_lru(folio))
 		return;
 	node_stat_add_folio(folio, NR_ISOLATED_ANON +
@@ -840,7 +843,6 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
 	struct damos *s = priv->scheme;
-	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
@@ -858,7 +860,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
-		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
+		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
 huge_out:
 		spin_unlock(ptl);
@@ -883,7 +885,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
-		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
+		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
 				migration_lists);
 		page_idx = folio_page_idx(folio, pte_page(ptent));
 		nr = folio_nr_pages(folio) - page_idx;
-- 
2.47.3
