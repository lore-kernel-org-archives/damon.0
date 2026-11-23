Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460015;
	b=WqjnXkEZKv8PVe6EMU1lYQF6DSopPsCF16tSCp5LfXZXg9GCx8LAaNTfXy/iJpWgCiyf
	 iXP0m0cTz+PfvGrPw1Mz84WKdUc3U3UjRd9a6MteI0NwC9PwqXk4UEbfEy6EYDJgZwgbP
	 OkCiK+Jtgte7IdxnuA6dNxUwkwJwKVW0OuflAsbZRp0n0aSbv95l9V+YZpmE0V9w3XMz8
	 8Y7VnQNMjFj3s/KCP2Ti1B1WvTlYedU/k9XmKDEZ+LAFC0HopMnsPUUJQmLj7fB6M2aIO
	 UseBgDMxp3psnEoHhZnENxAA36P8PSXgDINWj9K886EOEGG8aYf12huaFh/HPIyHCfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460015;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qPY6Gpk1GxeXHfsNbxjcPs+9GQpLxPguF+KSpyU0BSA=;
	b=ATq9DM/fqZbhOy7Jiw+5J/FAHGB17OZu3h3R0yZL63l7Zhy7f6ltq0lIHlwusCGGvVUw
	 lT6ZU26Lgot0M4+8AczLNevZkiuYgLaE5L/zs10K+DMVdpJ35HIYn7jBBoFHfo9l7m1gj
	 sX95Vt2KK9iv4dgs0V9exJfjx+GHZ0sC9G8wZJelCbhiMr6s7K/fb8+Sb9vAakm6Lxh28
	 LFoio30ZRpmCDDcev2J1JOY7Mf5x5qBHdR7ozb9Da2/dtjT91yPP5bSwriQ5flkv2SjXb
	 5mgDkPlk4Oyu2Gdpc7WfK/hnm2jAebDKNOTG0J1/dIIFTIDXO6x2McUSsP6yhcCsL1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuqDxe5K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036B606A681
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuqDxe5K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460015;
	b=ykCXgYseupH1NWa096EtDRlPwr1kbjrRM5Ie7F89QmaP1j6sqsJ9nnZsyy7PXjLumaIm
	 L6Vb4gLB5BrQIqeR2hn1HvXmlIa69c8DpTsRRcFgDTBUbykojd8vXr9jBE7xUz/Xd8Uzd
	 2JyQOJWeQvpWjU0LN+tX7A/xvyrpk8AH4YOVXazLLzCuhmqNa1SGtS3Gga1x0/DOHDcyN
	 gxldSsSxwOcoIA17R4m5wJ2Hm1uLJ1xNlX6af1ue7u72zy5lh8IpSscvoot+69d8fErlx
	 qaYz/yxHWkiFF8TAiM87Kn9wLwt2ZPjItc3z+LJEpW8CvrgbxvzkHbax4diPXpNAIgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460015;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qPY6Gpk1GxeXHfsNbxjcPs+9GQpLxPguF+KSpyU0BSA=;
	b=mNqLLIrO/R1HSehraW1jhTPj4NAWGw/XMHsqhu9arNg51+K4g8SHOOJGsC2pDc5/tmAV
	 pMMp3oXuJ1nLrJevDYv8vFEVI9YjEx8CakdgFUh3m7g0Ajl8cw64SugQuSBEJO9m8yhW8
	 UJSBM6oATK9cH00JlqCUuL+U1W+4P3mvZywyjpS+Cjhj644gXuGgnoGAXZVAlyPDNFluB
	 qxS2dZdbhCFHe4oZPEYnRcR5b6zXGfvzaebfuT0A002exo84JNgh7cZkpbtDhCc86ZF/Q
	 HrkT4dvVCsORrNH/wZBGqblrA0+a62Yz5+TERtHeRwI81S/ZBP5hvCvX2NhLq/Z0vVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B34541F000F4;
	Mon, 23 Nov 2026 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460015;
	bh=qPY6Gpk1GxeXHfsNbxjcPs+9GQpLxPguF+KSpyU0BSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZuqDxe5KOPm164Fb2Vz05B6TeOEf0nqlV4XrPLsIR8SoKaFTv2GWIwEiLrut5qiRS
	 mFXHSNeGYU/a9601/6XXRGZmK/TK3xqvRRTHilB+RqluuV0X3tkUOzno9W5rKberCv
	 /ologgR3LW/sPuTdecaSHFMTkS1TN7SV3lC/MHp1ylXPRXshgJH61HCk6H9TwYTAzA
	 d6iB2TfK3Ylt9ZSn8St969Xd26cBJH0MPC0F30gcHOUzlz1q1Nt3gK/gi67k7fEFjX
	 IDxYP4J1p9J8hE96IqtnHz7V+zJQho11gdAuPS0eeaVAiAeaRMn+vVmoXt6NnV35IB
	 zlCPfUp+8Ilkw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 471CE4C651;
	Mon, 23 Nov 2026 18:53:01 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:02 +0800
Subject: [PATCH v6 10/18] mm/mglru, gup: mark folios referenced via a fast
 helper
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-mglru-fg-v6-10-8ffea39934a6@tencent.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
In-Reply-To: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
 SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
 Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
 Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>, 
 Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
 Ehab Ababneh <ehab.ababneh@intel.com>, 
 Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
 Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
 Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org, 
 Tianyi Chen <hi@tychen.cc>, Kairui Song <kasong@tencent.com>, 
 Ridong Chen <ridong.chen@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=5455;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=EDvLpnxrpVD1Kfz+v/3OI17Dk6Yj7fBAiXtjWEmtcfY=;
 b=n7lufqexladK34F/awLOMu/YkEQJxZMmTJft2kkPNiKhixsNSlw2tnT0Eri4RZ4Nl8hmLaSz7
 plNCLhLOSEeDefNIfoeK4sf8RYsnkDXloTqw6+THIDruqVfCyK7ORqH
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
classical LRU as before. No counter update or promotion is needed,
nonzero MGLRU refs are left unchanged.

The classical path is taken for a folio that is off the gen lists while
MGLRU is off, not on lru_gen_enabled() alone: while MGLRU is being
turned off, a folio can still be on a gen list after the static key
flips, and setting PG_referenced there would bump its refs count.

That check uses lru_get_gen_flags(), so move the helper out of the
CONFIG_LRU_GEN block, it is now built with the option off, where
LRU_GEN_WIDTH is 0 and LRU_GEN_MASK is zero. Keep the decoded value in
an int so the subtraction of the offset-by-one encoding cannot fold to
ULONG_MAX before it happens to avoid -Woverflow error with CONFIG_WERROR.

This helper only aims to be fast, it exists so the gup fast path can
stay a fast path. The new helper doesn't account for refs above
LRU_REFS_REFERENCED but that's fine for now as GUP never used that
or anything similar for CLRU either.

Convert the gup fast-path sites. No behavior change for classical LRU,
no regression for MGLRU either. Just prepare for the following changes
by providing a helper that follows the new convention.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm_inline.h | 62 +++++++++++++++++++++++++++++++++++------------
 mm/gup.c                  |  6 ++---
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b15c3618a1f2..13c8b6bce349 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -105,6 +105,22 @@ static __always_inline enum lru_list folio_lru_list(const struct folio *folio)
 	return lru;
 }
 
+/**
+ * lru_get_gen_flags - Return the LRU generation number from folio flags.
+ * @flags: folio flags
+ *
+ * Returns: A number between 0 and (MAX_NR_GENS - 1), inclusive. Returns
+ * -1 if the flags indicate the folio is off the list (e.g., isolated).
+ */
+static inline int lru_get_gen_flags(unsigned long flags)
+{
+	int gen = (int)((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF);
+
+	/* The gen is stored offset by one, so zero means off-list */
+	VM_WARN_ON_ONCE(gen > MAX_NR_GENS);
+	return gen - 1;
+}
+
 #ifdef CONFIG_LRU_GEN
 
 static inline bool lru_gen_switching(void)
@@ -168,22 +184,6 @@ static inline void lru_set_gen_flags(unsigned long *flags, int gen)
 	*flags |= (gen + 1UL) << LRU_GEN_PGOFF;
 }
 
-/**
- * lru_get_gen_flags - Return the LRU generation number from folio flags.
- * @flags: folio flags
- *
- * Returns: A number between 0 and (MAX_NR_GENS - 1), inclusive. Returns
- * -1 if the flags indicate the folio is off the list (e.g., isolated).
- */
-static inline int lru_get_gen_flags(unsigned long flags)
-{
-	int gen = ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
-
-	/* Exclude the legal -1 from the unsigned MAX_NR_GENS comparison */
-	VM_WARN_ON_ONCE(gen != -1 && gen >= MAX_NR_GENS);
-	return gen;
-}
-
 static inline int folio_lru_gen(const struct folio *folio)
 {
 	return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)));
@@ -483,6 +483,36 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 }
 #endif /* CONFIG_LRU_GEN */
 
+/**
+ * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
+ * @folio: the folio
+ *
+ * Raise refs from 0 to LRU_REFS_REFERENCED and leave hotter folios
+ * untouched. For a folio off the gen lists with MGLRU off, a plain
+ * PG_referenced set.
+ */
+static __always_inline void folio_inc_lru_refs_fast(struct folio *folio)
+{
+	unsigned long new_flags, old_flags = READ_ONCE(*folio_flags(folio, 0));
+	unsigned int refs;
+
+	do {
+		refs = lru_get_refs_flags(old_flags);
+		if (lru_get_gen_flags(old_flags) < 0 && !lru_gen_enabled()) {
+			/* For CLRU, just do folio_set_referenced() */
+			if (refs & LRU_REFS_REFERENCED)
+				break;
+			refs |= LRU_REFS_REFERENCED;
+		} else {
+			if (refs)
+				break;
+			refs = LRU_REFS_REFERENCED;
+		}
+		new_flags = old_flags;
+		lru_set_refs_flags(&new_flags, refs);
+	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
+}
+
 static __always_inline
 void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 7605da0e06d8..da04bebfff43 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2921,7 +2921,7 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
-		folio_set_referenced(folio);
+		folio_inc_lru_refs_fast(folio);
 		pages[nr_pages] = page;
 		nr_pages++;
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
@@ -2990,7 +2990,7 @@ static unsigned long gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp,
 
 	for (i = 0; i < nr_pages; i++)
 		*(pages++) = page++;
-	folio_set_referenced(folio);
+	folio_inc_lru_refs_fast(folio);
 	return nr_pages;
 }
 
@@ -3032,7 +3032,7 @@ static unsigned long gup_fast_pud_leaf(pud_t orig, pud_t *pudp,
 
 	for (i = 0; i < nr_pages; i++)
 		*(pages++) = page++;
-	folio_set_referenced(folio);
+	folio_inc_lru_refs_fast(folio);
 	return nr_pages;
 }
 

-- 
2.56.1


