Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460002;
	b=xMoevxhKoWJjKDXKFskm68kLkrZux5nU4uhsEssN4Ias9mOjZhLlCo19ZWxQFpCxR7tH
	 fHyL4kwa0K3oCy8bV+9S+kJRFZiGz/IO+Fz/fsOO256wHJRTvqFxjKCJPN9rqqMZXSoyz
	 GG6IiPnTeqXKyUYikQ4EwwqtwqujaI16f43t0UwVlf7A4eQzJFz3z1jb7aslYs8xBItjQ
	 LlOCk5+sQLDzq1+0cHCGT5+kocOyg8pohny8MiiDs8GbdQzcnW2UsumRU3SfLvcJs7mIk
	 W5hmDADyUFGBJ3DLFmwHqDBc4l+2QzakZm/5yKMsmHFlCSrGqlonjgYEPkfz9jqQmyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460002;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tn3ff8YYl9RnjGLJDIERe0STPUTUXTlN6iqTakkHSLE=;
	b=Xn8AHupaujKTsi1BLCK2Z0ZOUhPEciBVwegcQriwtedurcQsGhaDDOq8e3Ws5/mIgGh4
	 mbj2wbBex7Hxy+rbv7ZJPnO0rTng4G42ManOSHd9bpBEVErrOHlJWMs5yvvJOWGMEkow9
	 gcGWn4n/COLFmeQ26+GJ4L/pitA2KxcrqyY+Um9BpUVd31mW0A/zILRBqL9SXp/sbizAS
	 PpbgjL60oquqDccJ7zSEa5zedG3L5DalrYy9GkiHTXHpk3IcHRFbUvcaPU+0p2G4He5i4
	 EuL/iJtbC7zRn+INGIALfqHbPc4Rq2+/m1mQkEmg+vv/rgJRiv5T6VEeRolnxQvJsmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8PR5mMo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237F606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8PR5mMo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460002;
	b=DN2mgD77pvWqbIb1K1rWzfcvHmcxlwy1DmZZU4gUXUmL7Xq6MB5tXVANoDL0KEv05ql3
	 g7CNgkECRWHCsi6QCyN4sk4zajLLqhMuG7JVx/x33hybNt8AxWljC2a7o/jL+smqK+aGY
	 Z7AqxQQ5X8Yt/nefNjIcgskqiq90uaJIHCZBptUe1TuPjDWrB5leKATzqGhpgYDnkqC8C
	 xfu+uZJegUqiJoTckBYvdg8UkH6yCxiyh5MixwDjV7s++KjCe4X+EhZ9XfwIHobazzwna
	 C9Y823xxYx5aUGGxWppH5PzACOZFKG868Z0lKVXJuCNZtPPbMZNERF1A4S2+QEFStXQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460002;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tn3ff8YYl9RnjGLJDIERe0STPUTUXTlN6iqTakkHSLE=;
	b=Dcm2NnyZacTvw2k7rEqiw27svgJEpeK4Vj3kpoju9stUyr9VfHD62muZXv6gLp0vIbwi
	 ORs4TpOENTeQw8WoUdDTM0CcGdnwgDf07Q6ITQ91CdbZlvGSrxH+XyfAo5GJxmKcugMUO
	 c22G6zItWgLP9vhiHTWy5vfrJoeOZ8b7CrlUTK/bDi6C3JSz5JiP8jXpNXf3DQ/IgNqDy
	 A5tf/gjtX3Ffb5xgjteBPYVAwujXstGXIPuPtFXTuxzwBkriECCSQnMDYzO86pFovM1Eh
	 ZgydnGZtXVmeadrM47hlaRO+bE4LgT8ez0OSYRk9Wckc/s9abKaRaIbVUXBweQQ+aRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D6A501F000F0;
	Mon, 23 Nov 2026 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460001;
	bh=tn3ff8YYl9RnjGLJDIERe0STPUTUXTlN6iqTakkHSLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=b8PR5mMoYI+X0/SjA8UMJJBWtBXi3wZZVxkZBt9zCYY9ME8Em1uUPKt1hd0gaJUnv
	 Ob1sSvzESQOmUx1VgoQ5jrzGVEBK5DrmCGt8LTuPIKg73g7/9QmLeCX/aTVZnYJ9B2
	 NYCtPONxetW2vWDIORuSTtdSYz32yRl+PIYO0Yfbcl4j+I+euKH1We+CiXO2M9tzia
	 HnHHI1fCxA3L4sMh+YAErS3axLDyLg2j+E6BFqMoEKpRTtRdo5jUF2Ciyc6NK+LcUz
	 1hWYOpujsDGpWPujgOQgXA6tTUxuAaAjM/ubstW89VO3uaHvmT5gk88MVGmI5PZi8L
	 KH5BqFwj5xutg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7B3194C639;
	Mon, 23 Nov 2026 18:53:00 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:52:56 +0800
Subject: [PATCH v6 04/18] mm/mglru: make generation page counters atomic
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
Message-Id: <20261124-mglru-fg-v6-4-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=5768;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Vglaw21Vm4r80ayuV/+BBbtCvB3+vEXOhf7b40sCexI=;
 b=Ck9hVXdiDJT21PdrgJnuB2unk1HBDNmb2YyAjDOuLd2atdc8hN1vUvyXwNsOsOO7KJ3r1Cb1r
 ETM8FJPd4GWDmWtXv1L7n8ZosAWgDSifBU53dGsNoO+QuUZwuS3t+Kv
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

No feature change, convert them to atomic so we can update them without
holding the LRU lock. A temporary underflow is fine: readers clamp a
negative value to zero, and the counters only need to be eventually
consistent.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm_inline.h |  6 ++----
 include/linux/mmzone.h    |  2 +-
 mm/vmscan.c               | 26 +++++++++++++-------------
 mm/vmscan.h               |  2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 2edb9beef6d3..46beded51c7d 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -265,11 +265,9 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 	VM_WARN_ON_ONCE(old_gen == -1 && new_gen == -1);
 
 	if (old_gen >= 0)
-		WRITE_ONCE(lrugen->nr_pages[old_gen][type][zone],
-			   lrugen->nr_pages[old_gen][type][zone] - delta);
+		atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type][zone]);
 	if (new_gen >= 0)
-		WRITE_ONCE(lrugen->nr_pages[new_gen][type][zone],
-			   lrugen->nr_pages[new_gen][type][zone] + delta);
+		atomic_long_add(delta, &lrugen->nr_pages[new_gen][type][zone]);
 
 	/* addition */
 	if (old_gen < 0) {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a2ad0cff795..4e85bb520f76 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -554,7 +554,7 @@ struct lru_gen_folio {
 	/* the multi-gen LRU lists, lazily sorted on eviction */
 	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the multi-gen LRU sizes, eventually consistent */
-	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	atomic_long_t nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the exponential moving average of refaulted */
 	unsigned long avg_refaulted[ANON_AND_FILE][MAX_NR_TIERS];
 	/* the exponential moving average of evicted+protected */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bc7579d47f9b..202e0f874b23 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3350,8 +3350,7 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
 			continue;
 
 		walk->nr_pages[gen][type][zone] = 0;
-		WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
-			   lrugen->nr_pages[gen][type][zone] + delta);
+		atomic_long_add(delta, &lrugen->nr_pages[gen][type][zone]);
 
 		if (lru_gen_is_active(lruvec, gen))
 			lru += LRU_ACTIVE;
@@ -3971,11 +3970,8 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, int swappiness)
 				break;
 		}
 		flush_lru_batch(head, &batch_end, target_list);
-
-		WRITE_ONCE(lrugen->nr_pages[old_gen][type][zone],
-			   lrugen->nr_pages[old_gen][type][zone] - delta);
-		WRITE_ONCE(lrugen->nr_pages[target_gen][type][zone],
-			   lrugen->nr_pages[target_gen][type][zone] + delta);
+		atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type][zone]);
+		atomic_long_add(delta, &lrugen->nr_pages[target_gen][type][zone]);
 		if (!remaining)
 			return false;
 	}
@@ -4093,8 +4089,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness
 	for (type = 0; type < ANON_AND_FILE; type++) {
 		for (zone = 0; zone < MAX_NR_ZONES; zone++) {
 			enum lru_list lru = type * LRU_INACTIVE_FILE;
-			long delta = lrugen->nr_pages[prev][type][zone] -
-				     lrugen->nr_pages[next][type][zone];
+			long delta = atomic_long_read(&lrugen->nr_pages[prev][type][zone]) -
+				     atomic_long_read(&lrugen->nr_pages[next][type][zone]);
 
 			if (!delta)
 				continue;
@@ -4625,8 +4621,13 @@ static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec
 	child_lrugen = &child_lruvec->lrugen;
 	parent_lrugen = &parent_lruvec->lrugen;
 
+	/*
+	 * The child is offline and the lockless updaters, which hold
+	 * rcu_read_lock() over the update, avoid racing with reparenting,
+	 * so the read/set/add operations below are safe.
+	 */
 	for (gen = 0; gen < MAX_NR_GENS; gen++) {
-		long nr_pages = child_lrugen->nr_pages[gen][type][zone];
+		long nr_pages = atomic_long_read(&child_lrugen->nr_pages[gen][type][zone]);
 		int child_lru_active = lru_gen_is_active(child_lruvec, gen) ? LRU_ACTIVE : 0;
 		int parent_lru_active = lru_gen_is_active(parent_lruvec, gen) ? LRU_ACTIVE : 0;
 
@@ -4634,9 +4635,8 @@ static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec
 		list_splice_tail_init(&child_lrugen->folios[gen][type][zone],
 				      &parent_lrugen->folios[gen][type][zone]);
 
-		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
-		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
-			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
+		atomic_long_set(&child_lrugen->nr_pages[gen][type][zone], 0);
+		atomic_long_add(nr_pages, &parent_lrugen->nr_pages[gen][type][zone]);
 
 		if (lru_gen_is_active(child_lruvec, gen) != lru_gen_is_active(parent_lruvec, gen)) {
 			__update_lru_size(child_lruvec, lru + child_lru_active, zone, -nr_pages);
diff --git a/mm/vmscan.h b/mm/vmscan.h
index c2cea36289f3..6551f0a6691a 100644
--- a/mm/vmscan.h
+++ b/mm/vmscan.h
@@ -126,7 +126,7 @@ static inline unsigned long lruvec_gen_size(struct lru_gen_folio *lrugen,
 	unsigned long size = 0;
 
 	for (int zone = 0; zone < max_zone; zone++)
-		size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+		size += max(atomic_long_read(&lrugen->nr_pages[gen][type][zone]), 0L);
 
 	return size;
 }

-- 
2.56.1


