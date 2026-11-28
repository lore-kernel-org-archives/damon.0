Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892441;
	b=kulPN1vp5n2NVzvaLUPTg3zrIRClc0HsoycH7x8P11vttdxlPHdjEj3e26Z/sb2qyFkg
	 nMOyqqGHvkPxnsJQpmlDyg9kKPk67WyCUXWwLpjT0Sqki9uidFysgFdlGl1PIFA53lHPq
	 KN0NjfQy7z6/sZCU9o5q0Wj+lFaQA3zsUSlsGelFb3Q5uickPifiF6UqHlnu+eNpmk43T
	 2BzmqD5DfIWv5hNHHE5I35URNx9Lgq4eC4XHG+j/FVC9ctwFV6moT8EkGwbn3yz6qVaHr
	 gbSy7X89+Nyb6a5/8CudWGVEqnxqojnMfX7UfPl11Xufo0cJ/v8WpFM4P7d7vQ600tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xt6jbwvMmnzd4PDkuhQOhh9HypkUzxH1QoDbZvnxx80=;
	b=jIfs/qa73oFVzyqgcHVQsaOJJjhnxyaeKv6RdGceUkAOVN1pnJ3FLuZhTHYPjlDRs35G
	 kuF1MSrawEv01+AQmxWAcl2Ay65FNzg/sXM3nNdLMWjPaNRn93/Nh4xRhLlnu0Bx7eHka
	 i15JjPwjEcw/WHuVU2CnJuMtkmLHpw7zYjhYeTHGMlYhT+mBiZ5vazq/9Y8ju+pjw+mQj
	 fqdC32H7WCd6xYEkMEkwEwyIoOq00eaRXUNAWMT8icC8yzn4jn7aPdzFJ7PGZ4b/QojPX
	 /NVteIhYpowVKdZn7q3ZbFq8kMBKCXTKeCCZfJBR8ZT9duILiqWwE6Qzqv833SDBouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceLKB0qf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E35606A331
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceLKB0qf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D141F0089B;
	Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892441;
	bh=Xt6jbwvMmnzd4PDkuhQOhh9HypkUzxH1QoDbZvnxx80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ceLKB0qfWrwqJ37UUE+cHFR2X+PiUbhYHw2O3vEUJw8PhwRCnhjp+ANvCp74m34sj
	 kOjLVSjgBUZE7v5bRzpq9qwWv4qjvAGXpC28q7rQNyMyV5DyzrmFu0lsUVBdK1iMef
	 6mDpFpVQb/m1RbDHoeCV/twUxID6YpqTygtOdAaYdk6+yyclT6wTN84/brFz1ESNrQ
	 fFHGDFCjg39QK4B2/eGua6LDZBsN4bczfyv4zOMAZSF43UXX2bgJEohGfwCxd0pdST
	 f7Kr9lmAdMLX0doKBzgskRWd/f2D2yQcQKby9GlMIamPo4sxuUBCuo13Q49dlNyU2l
	 2Qv9R2OA6rdPQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 2/7] mm/damon/vaddr: use damos->last_applied for migrate action
Date: Sat, 28 Nov 2026 11:00:27 -0800
Message-ID: <20261128190033.164440-3-sj@kernel.org>
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

To avoid applying the same DAMOS action multiple times to folios that
are located across adjacent regions, damos->last_applied was introduced.
DAMOS_MIGRATE_{HOT,COLD} action support in vaddr is not utilizing it.
Use it to avoid unnecessarily applying the same action to the same folio
multiple times.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index ca7ce9bd96e7..fd649cd335c9 100644
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
@@ -885,6 +892,9 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			continue;
 		page_idx = folio_page_idx(folio, pte_page(ptent));
 		nr = folio_nr_pages(folio) - page_idx;
+		if (damos_va_invalid_folio(folio, s))
+			continue;
+		s->last_applied = folio;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
@@ -993,12 +1003,6 @@ struct damos_va_stat_private {
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
