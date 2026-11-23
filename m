Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460014;
	b=AjCs8TKDJYyM3NwoicJUnpZWNybGUnPPts2Zyp5g1RfqHqSO1cRPHirBfHcNzrfERpb5
	 nAYTjAUb+/cNn2bmC+8S5eqwtqCTYJcHiwXVVTO3Dx5Itvd4FftslQfNndksvLkOgoumX
	 hO/2PfrOFoDLKSI6tPlcaBEkoHAi7jWzNPa3PANvMlD9ZOvSVpDCQ58p6N22uOdIUz6i2
	 MG0tSjLPc0bXnyUMn9NOi/ZoLTCb4XIHxLu4QUM/H4wz13sofeidCp6WVc4OUbAnAB9OM
	 WgIP2l114AtBXO7PspH+boQZs9Oa5F1kfw+2KQ6t6bxX3T6onXhS0fBK8JLivYgW49w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460014;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G/flV6tJgyZ+NqYZar1xR5I4MimyYfehG8yCe8+zdxk=;
	b=oC6oISQQudi3mQkVS0D1u5Ba6sizxgA079P7lZ+d4JuEPTehCuLXFsZHCZkcTqsjbBKQ
	 EUH8s4hRBloZbDAuwTqUtJRYjybCxa6K3glnZe7eBqLmLfuDJWzvni2WrxtD9Dn4gJGwF
	 cLa+i5HZZ9gP4iRILnE43aEBh54Vqvjh03NQ+s28D6RCQ9SENfwo1RGHJu7FdLwq+lTOl
	 TMgB72N0AlpsA5/do7kbOQ+h1AfSBlX/IXVx4RtwtdDyc5gKXh0597GAQsnodd9ELK4h5
	 9vhKZSahcwaUAivE8XVVlxquzebfiqh+F4jI1yA26Gch7MrgFqj1U5PYztahH1eO6VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDAqQ9oY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7427606A683
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDAqQ9oY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460014;
	b=p62Ed81Y89aMzUgxTpk78a79MrhEUmnLYavQ696wtmLCZDPYKCV3wAru/iwpu9YSsVlK
	 pMBGfz9ZmbD3kE/++IdS7WVtJ0KR3eAUfQwss1Y0GwlsU+UxG/2beUxslk1DIxXG1vSfD
	 SX4G2XWZD8eU6t3C0VL80KUgXgM1PyTtHsH4jDoowHHj6lpDy+wzWuOW9sYlMbtQbtubB
	 +4QuSrE6owogWzhZ7YLS0K/8gU6QYZd5pJr4DPxew8rmU29SLqQpTuJ+csS1+4/ZTk4yD
	 oJpELdw0zILFvjL/WtyM31ThO1o8wnirDkxPOdm8JkeUZLNZhGBVhfqvAEeo2/SEulw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460014;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G/flV6tJgyZ+NqYZar1xR5I4MimyYfehG8yCe8+zdxk=;
	b=cjayCzUJPTIWmltITr9F5PXhWsm7J1D7LH54gXHzlxdVi//axCxxu0V0Rp/V1OkNfyRm
	 Q870N/5LikpnR7H/rVQB2xr1J8umrurcFcduNb77PyHlNZZJGmtg1VdtGtAf9SExgeQYM
	 lkWRzoQwWQHxH15gQpj4X+BmaMUqe5pTH5FpILp7pYh8tGi43mBri27br0kHRHX8yiCx1
	 5KPpkGfiyrGHmNVVlKSwnxkcDyPsXLBi1TYH8sqhlnRr7IWTLODRGyHgo+qYtjGpGdoGu
	 /itjajFrGYqcFz8+PNCLiXSVj1NfwwTzgwoIt4JCGP21x1Oz0fNPT8NdG8VVrEcs9yw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 299B41F000D2;
	Mon, 23 Nov 2026 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460014;
	bh=G/flV6tJgyZ+NqYZar1xR5I4MimyYfehG8yCe8+zdxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YDAqQ9oYb3T2mS7n81kZRH2vQYH0SsQ8r/xOuYSQ7va+QK/nGVgPp7fzDgOdz4EWe
	 Y02a7JAzr8YU5G62G7w0SYmjPcVEEKjWmV0N/suPdErzu3UJfk3vLabL5yCNbjh9PR
	 YCH43StxC7FP0IWQ+CsdYfXlUeawLtvX5+/P0pbkWUOD+0z4junbyPjyB51HQqxFLw
	 g3I3A5WQDqN9m/6BoiSHwtKmHlpn/6FVIx8EIcU9KMnYpVh/1qNIVd7RUKrDk/xbF+
	 Tf/rjDNwv5xRD3PeGqO4fWJ9e4HRVWSXeA0ILXM4tvjC+kMB/F4V5+fM6u8GdnhBo/
	 E14CyLWVHRaHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 080574C649;
	Mon, 23 Nov 2026 18:53:01 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:00 +0800
Subject: [PATCH v6 08/18] mm/mglru: make folio lru referenced times count a
 generic API
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
Message-Id: <20261124-mglru-fg-v6-8-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=4795;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=PBYnbcUr9dUAP8lVbFcm0yrXQShhXuM2Q3GvdJcxzZ4=;
 b=4IBQ/rfrcPb4A6znz9CjQVL0ric1Ec41qoBxJYerdLkN9zyX5+X8c7XbuMh+IFCahStZfmZzL
 V6ntTsPl53LDvoF9eCtZGnxiDKfw/BcvCiB+68Ie6SrKJ6RXj4uonwS
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

Pure code shuffle, no behavior change.

Make the folio LRU refs helpers available regardless of CONFIG_LRU_GEN.
Without MGLRU the extra bits are never set, so they are inert. Move the
lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares for
unifying the API for checking folio referenced and workingset status.

folio_migrate_lru_refs() now migrates the complete refs count,
including PG_workingset (bit 1 of the encoding), bitwise identical to
the direct copy dropped from folio_migrate_flags().

lru_set_refs_flags() skips the nonexistent mask bits when
LRU_REFS_WIDTH collapses to 0, preserving the two independent flags for
!CONFIG_LRU_GEN builds.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm_inline.h | 55 ++++++++++++++++++++++++-----------------------
 mm/migrate.c              |  2 --
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f38dad1198fc..180db43c3a85 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -184,6 +184,12 @@ static inline int lru_get_gen_flags(unsigned long flags)
 	return gen;
 }
 
+static inline int folio_lru_gen(const struct folio *folio)
+{
+	return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)));
+}
+#endif
+
 /**
  * lru_set_refs_flags - Set the LRU referenced count to folio flags.
  * @flags: pointer to the folio flags
@@ -206,7 +212,8 @@ static inline void lru_set_refs_flags(unsigned long *flags, unsigned int refs)
 		*flags |= BIT(PG_referenced);
 	if (refs & BIT(1))
 		*flags |= BIT(PG_workingset);
-	*flags |= ((unsigned long)refs >> 2) << LRU_REFS_PGOFF;
+	if (LRU_REFS_WIDTH)
+		*flags |= ((unsigned long)refs >> 2) << LRU_REFS_PGOFF;
 }
 
 /**
@@ -252,13 +259,31 @@ static inline void folio_set_lru_refs(struct folio *folio, unsigned int refs)
 	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
 }
 
+#ifdef CONFIG_LRU_GEN
 void folio_inc_lru_refs(struct folio *folio, unsigned int flags);
+#else
+static inline void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
+{
+	/* Should not be called with !CONFIG_LRU_GEN */
+	WARN_ON_ONCE(1);
+}
+#endif
 
-static inline int folio_lru_gen(const struct folio *folio)
+/**
+ * folio_migrate_lru_refs - copy the reference state to a new folio
+ * @new: the destination folio
+ * @old: the source folio
+ *
+ * Transfer the reference state to @new during migration: the MGLRU
+ * refs count, or PG_referenced and PG_workingset (bits 0-1 of the
+ * encoding) for the active/inactive LRU.
+ */
+static inline void folio_migrate_lru_refs(struct folio *new, const struct folio *old)
 {
-	return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)));
+	folio_set_lru_refs(new, folio_lru_refs(old));
 }
 
+#ifdef CONFIG_LRU_GEN
 static inline bool lru_gen_is_old(struct lruvec *lruvec, int type, int gen)
 {
 	unsigned long min_seq = READ_ONCE(lruvec->lrugen.min_seq[type]);
@@ -424,20 +449,6 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 
 	return true;
 }
-
-/**
- * folio_migrate_lru_refs - copy the reference state to a new folio
- * @new: the destination folio
- * @old: the source folio
- *
- * Transfer the reference state to @new during migration: the MGLRU
- * refs count, including PG_referenced, or just PG_referenced for the
- * active/inactive LRU.
- */
-static inline void folio_migrate_lru_refs(struct folio *new, const struct folio *old)
-{
-	folio_set_lru_refs(new, folio_lru_refs(old));
-}
 #else /* !CONFIG_LRU_GEN */
 
 static inline bool lru_gen_enabled(void)
@@ -470,16 +481,6 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 {
 	return false;
 }
-
-static inline void folio_inc_lru_refs(struct folio *folio, unsigned int flags)
-{
-}
-
-static inline void folio_migrate_lru_refs(struct folio *new, const struct folio *old)
-{
-	if (folio_test_referenced(old))
-		folio_set_referenced(new);
-}
 #endif /* CONFIG_LRU_GEN */
 
 static __always_inline
diff --git a/mm/migrate.c b/mm/migrate.c
index 65869b8acec5..0430197fdc04 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -807,8 +807,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_active(newfolio);
 	} else if (folio_test_clear_unevictable(folio))
 		folio_set_unevictable(newfolio);
-	if (folio_test_workingset(folio))
-		folio_set_workingset(newfolio);
 	if (folio_test_checked(folio))
 		folio_set_checked(newfolio);
 	/*

-- 
2.56.1


