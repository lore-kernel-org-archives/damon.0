Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795460028;
	b=csV/ocsSyIoQ6SXORaHVakmhADr/1jouKn+L5VfZjLhKObDNDeIU5J6ExAElVsxtbJ6q
	 XP0zwHWH/ZAjFNqxbgNtJL1JYxFctI9+uq+NIo0YpOGjOj1vj0+JYdTog1SoDVKKP7Av5
	 6RU+Poz7rUDYJxi7xFSFnnTWwF6c06Yld3a8Eoz/i7ZvKv1bSF0PlXugp5//aLmBb7ZmY
	 3TWkRLRDexI/Ke7FBgxvwGwKBpfKZOzAFOrWfMsWi5wIS9AKm4S4G41h6kHL/bS71HJSa
	 Pdum66L6qdHbkZidM3f3en4rHj3PW29u6UP4UeGACrbERg3OmmIPxhhWMgbgUJ9xj8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460028;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HW3m15cwOhOmCQi5QS7IBcTVWDziQbgROwHGLA00qiA=;
	b=xiqP9vpNCCiqRJYWUARIsUCginBAYT/5RUUbOI1uAQuRurMe+2ydSbzvnjZo2Eyn1Wz6
	 POFN/bK6XKkRFRXLoonGJqbNGZc2diRMIT3HTt/IArs8DAzWCNPP4VCPIX811wIFG7nFu
	 aqBsgUxKgtNdWq+3LaO5HnaJ/1JPLorwXNw42Y1JZco0Qcj09f4YpZS3IHkU93TvvxBG6
	 X/0zpZ7hjQNsKE6BBOovEGmrdd4MHJREt2yFy4t2ybRjG8No9Ml8flQH6qVNlNj44cXm7
	 Wf5T5znElUh/WbnE1xUNyfmkHKQ6DJIxZanSUj/tyPMYtze9SNMzD7QTMiXFdw1FYeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLmBPePZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FC606A699
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLmBPePZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795460028;
	b=dFAu+mJp6OfCsTpxluInBZ3o7ZvM9dBnAH7y8NlUM9MdqlHTF01cdYtZTnFR88NzyQTH
	 ENYgUD4un9oh9jJbktq2LlVDWMuGgGdeD+EIPrFCJQ6JxRfX7S0oi11vffUnThvsvvQ3R
	 UENrL/uILrm5DpB+l0k4JeD+YR993juHdgAhpgky2mevbGbiiAyLDc8GRCPxtosgoMZ5Z
	 9H34xJx/3pPKifXUH1E1J5H8jXeSUinpKqOi/eSQ/IdT5Fb13+ibzLmLCQU4Dv+QabNH1
	 5rkSpPW5+9GHIIe3JE5h9H++kRXatWk9e9lgq/qbaBCknbi6A15nlA/Vrp5nmVQQ33g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795460028;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HW3m15cwOhOmCQi5QS7IBcTVWDziQbgROwHGLA00qiA=;
	b=XgBZl4wvzic70qf8WtOKC9Xv6OW/mfEFwTHRbPTdUws3iy2uSAX12La9ML6u2R9HPsKk
	 xlcfychCBHhq4vH8xvWlWFNDB9HlVToHzOpW3n9QxA1UtyCJjAFsZlmcLBsuucXzniJnJ
	 gz4FZEogh9K6Zd1emk9RBjS2b/nQG5wxStDktgPW64fwXnZiglvxzvtQPe3yny/J4TXJS
	 3VYiWWgh9BHjH7KQQXmJbrxXtzvTBEWmONI6nq+M6sG875F22yf/TPuQ0InbIRdA05URm
	 nBu2GsgomcmAjXnn76Hx6co5Nog9Pv+UAyVZFxyormwtTXLv9Ufh76ugW6By/cVeGiw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 938841F01566;
	Mon, 23 Nov 2026 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460027;
	bh=HW3m15cwOhOmCQi5QS7IBcTVWDziQbgROwHGLA00qiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CLmBPePZO0lRAPAN5U/EkdRANd/IxuCCBfyUGRY5CFXqzNS3EQhB52hvaLAd3xdFU
	 gSVwvlJDNAZsOdoeLqauEN3AcJ3nNC0hIvSoKhV8FUcXRjc6s/RGl1sHrvzgZ+Ktcp
	 liRPdDR8OFvyOmGA9BGEZ1sC7VUVaFj0ZPs9eQaXVAgkXazuX+EdqlCC0pf1rGEJnn
	 3yATTrzxwDwPPBTMmZZcReKXtQSj/qIsOIUoEhq7S0ZHp/G4QzeZmWiDYCg89KFlBn
	 8RKHiUNtVtrTFWzO0FcLbua2UiNEJrqIgtCavzMKzOZ6bv1cyUQlwxS7OCNkZ83VmW
	 wBMNReqvzoGzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0038E4C669;
	Mon, 23 Nov 2026 18:53:02 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 24 Nov 2026 02:53:08 +0800
Subject: [PATCH v6 16/18] mm/mglru: make PG_workingset helpers work based
 on folio LRU refs
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
Message-Id: <20261124-mglru-fg-v6-16-8ffea39934a6@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459977; l=6298;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=FeZ1X36y0gjLoNuGBhnIl7GXAntfQovoxU409olinNk=;
 b=1VQ9pndS33m4Kvn5Bxu4wL7Vfltv3HU9XfA3NipSyzY8gijlcuTI7FnfCR5lNBgS/0H+Szg78
 zZU1/x1iy0HCGin+8N0ZqTISRFUtg1fGvsKT9WkEUVt/8aQ4GtDYp8c
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

folio_test_workingset() currently tests the PG_workingset bit, which
is only the second lowest access bit of the folio LRU refs count now.
Folios with refs 4 or 5 carry it in the LRU_REFS_MASK field
and no longer have PG_workingset set, so the bit test misses them.

folio_set_workingset() currently sets the PG_workingset bit with a
plain set_bit(), which also over-promotes folios at a higher refs
count: e.g. a folio at refs 4 is bumped to refs 6, advancing it
toward LRU_REFS_MAX and an earlier generation promotion.

Move both helpers into mm_inline.h, the test as an inline helper based
on folio_lru_refs(), checking refs >= LRU_REFS_WORKINGSET.

The set stays reserved for the classical LRU, as under MGLRU the refs
count is maintained by folio_inc_lru_refs(): it now warns when the folio
is on a gen list, where the raw bit would corrupt its refs count.

MADV_COLD, the one caller that runs on an on-list folio, sets the
count with folio_set_lru_refs() instead. The one PageWorkingset() user
in erofs is converted to the folio helper.

There is no behavior change for the classical LRU: it does not maintain
the refs count, so for a folio that was never on a gen list the test is
equivalent to the PG_workingset bit test.

This prepares the convention for follow up MGLRU change.

Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/btrfs/compression.c     |  1 +
 fs/erofs/zdata.c           |  3 ++-
 include/linux/mm_inline.h  | 30 ++++++++++++++++++++++++++++++
 include/linux/page-flags.h |  2 --
 mm/filemap.c               |  1 +
 mm/madvise.c               |  2 +-
 mm/page_io.c               |  1 +
 7 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ad90e14032db..127c5ee38979 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/mm_inline.h>
 #include <linux/folio_batch.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e981e371d6c2..34ee41e1ccdc 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -6,6 +6,7 @@
  */
 #include "compress.h"
 #include <linux/psi.h>
+#include <linux/mm_inline.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
 
@@ -1713,7 +1714,7 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
 				DBG_BUGON(bvec.bv_len < sb->s_blocksize);
 			}
 
-			if (unlikely(PageWorkingset(bvec.bv_page)) &&
+			if (unlikely(folio_test_workingset(page_folio(bvec.bv_page))) &&
 			    !memstall) {
 				psi_memstall_enter(&pflags);
 				memstall = 1;
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 0f470ddf5c48..a4daf366e6aa 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -283,6 +283,21 @@ static inline void folio_migrate_lru_refs(struct folio *new, const struct folio
 	folio_set_lru_refs(new, folio_lru_refs(old));
 }
 
+/**
+ * folio_test_workingset - Test if a folio is in the workingset.
+ * @folio: the folio
+ *
+ * A folio is workingset when its LRU refs count reaches
+ * LRU_REFS_WORKINGSET. Under the classical LRU flag encoding,
+ * this is just testing the PG_workingset bit.
+ *
+ * Return: true if the folio is workingset.
+ */
+static __always_inline bool folio_test_workingset(const struct folio *folio)
+{
+	return lru_refs_is_workingset(folio_lru_refs(folio));
+}
+
 #ifdef CONFIG_LRU_GEN
 static inline bool lru_gen_is_old(struct lruvec *lruvec, int type, int gen)
 {
@@ -544,6 +559,21 @@ static inline void folio_clear_lru_refs(struct folio *folio)
 		folio_clear_referenced(folio);
 }
 
+/*
+ * For the classical LRU or isolated folios only: with MGLRU the PG_workingset
+ * bit is part of the folio refs count maintained by folio_inc_lru_refs(),
+ * a raw set would corrupt it.  The warning below catches folios still on a
+ * gen list, the classical paths in the switching window only see off-list ones.
+ */
+static __always_inline void folio_set_workingset(struct folio *folio)
+{
+	unsigned long flags;
+
+	flags = set_mask_bits(folio_flags(folio, 0), BIT(PG_workingset),
+			      BIT(PG_workingset));
+	VM_WARN_ON_ONCE(lru_get_gen_flags(flags) != -1);
+}
+
 static __always_inline
 void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b0ddc652e76c..f6625dc042da 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -549,8 +549,6 @@ PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
 FOLIO_FLAG(active, FOLIO_HEAD_PAGE)
 	__FOLIO_CLEAR_FLAG(active, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(active, FOLIO_HEAD_PAGE)
-PAGEFLAG(Workingset, workingset, PF_HEAD)
-	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
 /* Xen */
diff --git a/mm/filemap.c b/mm/filemap.c
index dc0ceaa58a0f..acf5e562b732 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -21,6 +21,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/mm_inline.h>
 #include <linux/leafops.h>
 #include <linux/syscalls.h>
 #include <linux/mman.h>
diff --git a/mm/madvise.c b/mm/madvise.c
index 7e562e78d52a..e138082c518a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -378,7 +378,7 @@ static void madvise_cold_prep_folio(struct folio *folio)
 	if (!lru_gen_enabled()) {
 		folio_clear_lru_refs(folio);
 		if (folio_test_active(folio))
-			folio_set_workingset(folio);
+			folio_set_lru_refs(folio, LRU_REFS_WORKINGSET);
 	}
 }
 
diff --git a/mm/page_io.c b/mm/page_io.c
index a57cdcf2892d..12deab296718 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/mm_inline.h>
 #include <linux/bio.h>
 #include <linux/swapops.h>
 #include <linux/writeback.h>

-- 
2.56.1


