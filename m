Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460015;
	b=j8MzOEttDYipnB1jwQNs9RQrjdt/FyiBofR+FxV++dV+USuJ2rX+0Yw2QuJZ9gmUDIWS
	 FI+ifJ7wufGHMtTWr7B/FzNnrTT7Y6G214PaRv3MLF1wq+ZLBUbQ+NkFEjfHF0adEVxTg
	 tPBRQJaMY1M4PgxkDCeuS3VIXjPDOOKoA2fDZ5Mp4YvAUww/AuABropIIW5k1i14CLy2t
	 3UT+rjChxj/yTQlGXXD8MhmbxH9k3F6KdyxIdX3c8uS/3noKzEcL4iU850/+lrb0m2tz4
	 cST8vBovryLb5Lp0/sWYKpaXujAguqnlaLblbU+pGW0yC4BbAZXyqZ/tluHk4BPnCDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460015;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=horbJ+WRFpXrHIUpt9mddEfhWXyxTruu2VhXlMsfh58=;
	b=2hI6dqRLx74PBgVIO0RbZOiSY71YGk7LmEG9w+M4ShOwFFVa9FsnmEBqqB6+hWACyAc9
	 3malG6hIe2RmPqlJWxP2PqAov/kNlez2nU9ajGushVPzHAh5MfUmqRJXQdbf+FxTshuDF
	 QtJRu/XUJs0O5eHRJUEf/WO8kBFpXjlZv+le3zPeqZdz6lQuFr6zQEzx77MIA0IjfhUpx
	 ApaPMGsZkI9vB9n9Dpslsiv3rbJG+6f7sVG40/x26YtE8hHPSGxoLAQ0NUCM5NUqvjYsl
	 wMo8m76oRpMtlTuc7Vs8D49xQrr3xwsGanIoVCbhASNMqxZExD9fSGMd14Q4QANM19g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKDIZnGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C38606A69C
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKDIZnGP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460015;
	b=G03C/5HjEjKhUH2+zf5qgZ28CMrZE6ybXryG/Af9QNxMJWzdlYCz/BXB9dkvrVFym1eZ
	 3LE8BKkWHqOMPlW1dp6HO2yPNBnBoIbT9OQrqxTzHB54hbiS8FngQkj272gxUtdI+7SJr
	 9Jw14VnYUvAZkmSKmGgvm1RAANoL4GO7HC7I23hCVOscZ+uHgZFi+Ve7go7IXfYON2hxD
	 B6ksVsdmqOQA6AtElpTPKRauofLBL8tW5y4pdSpltIJTDtuJ6koY7kh6I+L0ASucHYnaV
	 8UySGPvN0tAPv6tMgT1yd9az1FVlu1mqiHByS9VHL0BDcgBsJKcVdMtNLAxdFJEmxlw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460015;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=horbJ+WRFpXrHIUpt9mddEfhWXyxTruu2VhXlMsfh58=;
	b=w1DiTysvg81+bhT8NwrYI84j27sXnnMk7925rcada6dQNRtNHXot7m0deiM31HpqrE6n
	 kxxH5h4AmeaQzHUEMUwOx3E6hUCas3nHbpbJRNeQrGnFiUDLgsv89yDoS6B/AuODZ3euR
	 NrVLSgnR68Fv4PxLpn529c/tebnfZqVO4S/4PsPg+WOL/G4VPPCRYOf4zVbioc7hO7erD
	 Q2x5WJCX9oxNfWHB641pMudkcLuzek1+JWsN9KN27rKK9XvEXDI/qIl62Ig7sWufj2a24
	 1GD4vw4DPR1yrzjHCrHcFdqDQcnCwii7GY8ArLsJyqENpr9DnkpmMKSGqP6MGbHa7ug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8326D1F0093C;
	Mon, 23 Nov 2026 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460015;
	bh=horbJ+WRFpXrHIUpt9mddEfhWXyxTruu2VhXlMsfh58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GKDIZnGP1nsLho3StgmJtoB0tWjmF1R/i26GT0x7BDL0ofepHXYEibCqSsQ9JeZh/
	 zSfn22yG3+CDWr63hXkeKIYmB8mGiAZ2JqoBRSPtTqynG4XYked3LbDu4SLoAYdSCU
	 6NHTr2Lqdo9YY2cNgfQu66a5Le/nY62bRFTw2CNyzjMx0rkBBw7FD50ly+SwlwRiud
	 fXAaUmST/hThyCnN/E6MJ5T/q8YDAr8d6U0VV7I6abbDL8JUheUPpbn9nbag60508C
	 eJQcJeRVi6nS43VfSzgO9frGSVag93tNLakzCCmR/NM+C9ZprPcRLPQ+ejEuhbVAE0
	 Z2VgHhHi9QhNg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 630B84C655;
	Mon, 23 Nov 2026 18:53:01 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:03 +0800
Subject: [PATCH v6 11/18] mm/mglru, smaps: convert to LRU refs based
 operations for MGLRU
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
Message-Id: <20261124-mglru-fg-v6-11-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=3877;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=SyGC47j2sShmDrstNnpICQjj8oxfwuGK/s3C+V+Hk1k=;
 b=zDeAcKA97ZXD5+wk30UPTAW0+f1NPxG7RvOr5muhguEVkFZjwS92VJecDA26puiKkUFemGJIY
 FU8Dgte6mVHAd28IbxPk82XmytTsRUsfRtz/LrUROT9BqXOCuZBS2gq
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

PG_referenced is only the lowest bit of the folio LRU refs count
(LRU_REFS_FLAGS) now, and MGLRU never kept it stable: promotion used to
clear it, and now it toggles as the count grows. But with the LRU
referenced count as a stable API now, we can use two helpers to provide
in-kernel users a stable and sane reading of the referenced status of
an LRU managed folio.

Add folio_check_lru_refs() and folio_clear_lru_refs(), which use the refs
count when MGLRU is enabled and PG_referenced otherwise, and switch the
smaps paths over to them. The lru_gen_enabled() test stays inside the
helpers, so its static key is not splattered over the few call sites.

Convert smaps as the first user of them. MGLRU now reports every folio
with a nonzero count, so the reading no longer flickers and clearing no
longer results in an ambiguous status.

The classical LRU case is unchanged.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/proc/task_mmu.c        |  6 +++---
 include/linux/mm_inline.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 540c936aad47..d2a524c6ad4b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -890,7 +890,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 
 	mss->resident += size;
 	/* Accumulate the size in pages that have been accessed. */
-	if (young || folio_test_young(folio) || folio_test_referenced(folio))
+	if (young || folio_test_young(folio) || folio_check_lru_refs(folio))
 		mss->referenced += size;
 
 	/*
@@ -1690,7 +1690,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
 		folio_test_clear_young(folio);
-		folio_clear_referenced(folio);
+		folio_clear_lru_refs(folio);
 out:
 		spin_unlock(ptl);
 		return 0;
@@ -1719,7 +1719,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		/* Clear accessed and referenced bits. */
 		ptep_test_and_clear_young(vma, addr, pte);
 		folio_test_clear_young(folio);
-		folio_clear_referenced(folio);
+		folio_clear_lru_refs(folio);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 13c8b6bce349..0f470ddf5c48 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -513,6 +513,37 @@ static __always_inline void folio_inc_lru_refs_fast(struct folio *folio)
 	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
 }
 
+/**
+ * folio_check_lru_refs - Test if an LRU managed folio has been referenced.
+ * @folio: The folio to test.
+ *
+ * Returns true if the MGLRU refs count is nonzero, or PG_referenced is set,
+ * which is also correct for the non-MGLRU case. Kept as a separate helper,
+ * to avoid splattering the lru_gen_enabled() static key.
+ */
+static inline bool folio_check_lru_refs(const struct folio *folio)
+{
+	if (lru_gen_enabled())
+		return folio_lru_refs(folio) > 0;
+	return folio_test_referenced(folio);
+}
+
+/**
+ * folio_clear_lru_refs - Clear the referenced state of an LRU managed folio.
+ * @folio: The folio to clear.
+ *
+ * Reset the MGLRU refs count to zero, or clear PG_referenced, leaving
+ * PG_workingset alone for the non-MGLRU case. Kept as a separate helper
+ * just like folio_check_lru_refs().
+ */
+static inline void folio_clear_lru_refs(struct folio *folio)
+{
+	if (lru_gen_enabled())
+		folio_set_lru_refs(folio, 0);
+	else
+		folio_clear_referenced(folio);
+}
+
 static __always_inline
 void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {

-- 
2.56.1


