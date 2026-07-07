Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE73D3314
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407460; cv=none; b=oAD4ihnlMIr75Rqo6Lx1huYKMvxR2Kes01mVo8CKrtphEcoY0uDv5u4WxoQOXkCjV1d/VoL6g7WeeELNPJ3zvQR4AMXJ++vAjFtgLPe5qBLNdT80sMaeaR7Kc0EcE9SluGI4R086DsQ6TWf3fo8q8Kf6x58qobBgzkxbeAYiK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407460; c=relaxed/simple;
	bh=fwXfFr9I8Qrv7AsTjkGpQNNTSx/ObgqQdRPomKbX3tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbiuY/BRT1BOU6IPhQg16th3oBCnmU2q6+Eub8Bf6W1Wnb72fhe5Wz9qVlhflLWCD/RspYxEPELFPvOgZCxHjnhx+K0UfJ8yT4ARbng4k7FwmfVIJvDx29HdxF34+xXgE08bPR4QGnZzT4MGWmC97UKNtjIxROy16MGYdHpnFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW001.hihonor.com (unknown [10.77.229.151])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gvWnJ5jTJzYmWKW;
	Tue,  7 Jul 2026 14:40:20 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW001.hihonor.com
 (10.77.229.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 14:40:20 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:20 +0800
From: tao <tao.wangtao@honor.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <willy@infradead.org>, <sj@kernel.org>, <kees@kernel.org>,
	<luizcap@redhat.com>, <zhangjiao2@cmss.chinamobile.com>, <kas@kernel.org>,
	<ljs@kernel.org>
CC: <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <jack@suse.cz>,
	<riel@surriel.com>, <harry@kernel.org>, <jannh@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
	<baoquan.he@linux.dev>, <nao.horiguchi@gmail.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<pfalcato@suse.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <damon@lists.linux.dev>, <shakeel.butt@linux.dev>,
	<ryncsn@gmail.com>, <jparsana@google.com>, <dvander@google.com>,
	<zhangji1@honor.com>, <wangzicheng@honor.com>, tao <tao.wangtao@honor.com>
Subject: [RFC PATCH v2 11/13] mm: optimize rmap for ANON_VMA_FRACTAL with PVL
Date: Tue, 7 Jul 2026 14:33:06 +0800
Message-ID: <20260707063308.29176-12-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260707063308.29176-1-tao.wangtao@honor.com>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: TW002-1.hihonor.com (10.72.0.137) To TA003.hihonor.com
 (10.72.0.43)

Leaf anon_nodes have no children, and a given address can belong to at
most one VMA. In this case, PVL can protect the rmap.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/internal.h | 22 ++++++++++++++++++
 mm/rmap.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 205f1b5226aa..f8dd2120b780 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -354,6 +354,23 @@ int anon_node_trylock_rmap(struct anon_node *anon_nod);
 void anon_node_lock_rmap(struct anon_node *anon_nod);
 void anon_node_unlock_rmap(struct anon_node *anon_nod);
 
+#define ANON_RMAP_LEAF_VMA	1
+#define ANON_RMAP_FLAGS 	(ANON_RMAP_LEAF_VMA)
+
+static inline bool anon_rmap_is_leaf_vma(void *anon_rmap)
+{
+#ifdef CONFIG_PER_VMA_LOCK
+	return ((unsigned long)anon_rmap & ANON_RMAP_FLAGS) == ANON_RMAP_LEAF_VMA;
+#else
+	return false;
+#endif
+}
+
+static inline struct vm_area_struct *anon_rmap_to_leaf_vma(void *anon_rmap)
+{
+	return (void *)((unsigned long)anon_rmap & ~ANON_RMAP_FLAGS);
+}
+
 #define ANON_RMAP_FOREACH_VMA(anon_vma, addr, start, last, rmap_proc_vma) \
 do { \
 	struct vm_area_struct *vma = NULL; /* must be named vma */ \
@@ -362,6 +379,11 @@ do { \
 	unsigned long _pgoff = (start); \
 	unsigned long _nr = 0, _total = 1; \
 	\
+	if (anon_rmap_is_leaf_vma(_anon_nod)) { \
+		vma = anon_rmap_to_leaf_vma(_anon_nod); \
+		(rmap_proc_vma); \
+		break; \
+	} \
 	while (_nod) { \
 		vma = anon_node_lookup_vma(_nod, (addr), _pgoff); \
 		if (vma) \
diff --git a/mm/rmap.c b/mm/rmap.c
index 11239838b722..d1099a2fef0a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -572,6 +572,8 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 
 static struct kmem_cache *anon_node_cachep;
 
+
+
 static inline struct rw_semaphore *anon_node_rmap_sem(struct anon_node *node)
 {
 	return &node->root->rwsem;
@@ -1035,9 +1037,48 @@ void anon_node_lock_rmap(struct anon_node *anon_nod)
 
 void anon_node_unlock_rmap(struct anon_node *anon_nod)
 {
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Corresponds to folio_lock_anon_vma_read(). */
+	if (anon_rmap_is_leaf_vma(anon_nod)) {
+		vma_refcount_put(anon_rmap_to_leaf_vma(anon_nod));
+		return;
+	}
+#endif
+
 	up_read(anon_node_rmap_sem(anon_nod));
 }
 
+static struct vm_area_struct *trylock_leaf_vma_rmap(
+		struct anon_node *anon_nod, const struct folio *folio,
+		struct mm_struct **other_mm)
+{
+	unsigned long pgoff_start = folio_pgoff(folio);
+	unsigned long pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
+	unsigned long addr = anon_node_rmap_address(anon_nod, pgoff_start);
+	struct mm_struct *mm = anon_nod->mm;
+	struct vm_area_struct *vma;
+	int oldcnt;
+
+	if (anon_nod->nr_children)
+		return NULL;
+
+	if (!addr || !mm || !mmget_not_zero(mm))
+		return NULL;
+
+	vma = vma_lookup(mm, addr);
+	mmput_async(mm);
+	if (!vma || vma_last_pgoff(vma) < pgoff_end)
+		return NULL;
+
+	if (!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
+						     VM_REFCNT_LIMIT)) {
+		return NULL;
+	}
+
+	*other_mm = (vma->vm_mm == mm) ? NULL : vma->vm_mm;
+	return vma;
+}
+
 #endif
 
 /*
@@ -1117,6 +1158,8 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 {
 	struct anon_vma *anon_vma = NULL;
 	struct anon_vma *root_anon_vma;
+	struct vm_area_struct *leaf_vma = NULL;
+	struct mm_struct *other_mm = NULL;
 	unsigned long anon_mapping;
 
 	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -1130,6 +1173,15 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 
 	anon_vma = (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
+#if defined(CONFIG_PER_VMA_LOCK) && defined(CONFIG_ANON_VMA_FRACTAL)
+	leaf_vma = trylock_leaf_vma_rmap(anon_vma, folio, &other_mm);
+	if (leaf_vma && !other_mm && folio_mapped(folio)) {
+		rcu_read_unlock();
+		return (void *)leaf_vma + ANON_RMAP_LEAF_VMA;
+	}
+	if (unlikely(other_mm))
+		mmgrab(other_mm); /* put vma after unlock. */
+#endif
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
 		/*
 		 * If the folio is still mapped, then this anon_vma is still
@@ -1156,9 +1208,8 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 	}
 
 	if (!folio_mapped(folio)) {
-		rcu_read_unlock();
 		put_anon_vma(anon_vma);
-		return NULL;
+		goto out;
 	}
 
 	/* we pinned the anon_vma, its safe to sleep */
@@ -1176,10 +1227,17 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 		anon_vma = NULL;
 	}
 
-	return anon_vma;
+	goto out_unlocked;
 
 out:
 	rcu_read_unlock();
+out_unlocked:
+#ifdef CONFIG_PER_VMA_LOCK
+	if (leaf_vma)
+		vma_refcount_put(leaf_vma);
+#endif
+	if (other_mm)
+		mmdrop(other_mm);
 	return anon_vma;
 }
 
-- 
2.17.1

