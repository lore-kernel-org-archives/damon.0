Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF63D75AD
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407460; cv=none; b=s1rNwGAiQUdViHuknD0lNYahRkSBe0CmbFHUMqU/zIdeJHqOn4WJvElKQvOviewDBA0I2qMPpR7PmVZM4MSvrCrueXYcF0qMEkCJCySAkOyudAutUYc81IgaPCXXzkid8xm9Ok0txnGGy/5o4BOTmmdF3E8YMiG2lSkA3KLDHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407460; c=relaxed/simple;
	bh=Kl7x2iRWoui/H/yKt0sMQgW0CyvuWe2rwfhvucwsBII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgqLVsGAgNK9sUwZNTmSRyRrSOU9cNUIs0GRkyTUU9/OCXtc3gfaa7ZWoDe7vIY4mEmPPitmgWD/URyvE8vdCKdcGiV14FDVd3VT6SZcY8R76evmX8TzrTicXbNsmYDvpAxj4V0b1FL3oD3dxqZeXcYnptS3XWQK+C+eUYkG3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW005.hihonor.com (unknown [10.72.0.123])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gvWnG1QSVzYkyb0;
	Tue,  7 Jul 2026 14:40:18 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW005.hihonor.com
 (10.72.0.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 14:40:17 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:17 +0800
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
Subject: [RFC PATCH v2 02/13] mm: implement helpers for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:32:57 +0800
Message-ID: <20260707063308.29176-3-tao.wangtao@honor.com>
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

Implement basic helpers.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/internal.h | 25 +++++++++++++++
 mm/rmap.c     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index a33ed1a30f09..c1b3961b9d3e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -271,6 +271,31 @@ static inline struct anon_node *anon_node_next_descendant(
 	return node->depth > anon_nod->depth ? node : NULL;
 }
 
+static inline void get_anon_node(struct anon_node *anon_nod)
+{
+	VM_BUG_ON(atomic_read(&anon_nod->refcount) == 0);
+	atomic_inc(&anon_nod->refcount);
+}
+
+void __put_anon_node(struct anon_node *anon_nod);
+
+static inline void put_anon_node(struct anon_node *anon_nod)
+{
+	VM_BUG_ON(atomic_read(&anon_nod->refcount) == 0);
+	if (atomic_dec_and_test(&anon_nod->refcount))
+		__put_anon_node(anon_nod);
+}
+
+static inline unsigned long anon_node_rmap_base(struct anon_node *anon_nod)
+{
+	return atomic_long_read(&anon_nod->rbc) & ~ANON_RMAP_BASE_COUNT_MASK;
+}
+
+static inline unsigned long anon_node_rmap_count(struct anon_node *anon_nod)
+{
+	return atomic_long_read(&anon_nod->rbc) & ANON_RMAP_BASE_COUNT_MAX;
+}
+
 #endif
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c77d5dc06e9..fa9d82271005 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -558,6 +558,95 @@ void __init anon_vma_init(void)
 			SLAB_PANIC|SLAB_ACCOUNT);
 }
 
+#ifdef CONFIG_ANON_VMA_FRACTAL
+
+static struct kmem_cache *anon_node_cachep;
+
+static inline struct rw_semaphore *anon_node_rmap_sem(struct anon_node *node)
+{
+	return &node->root->rwsem;
+}
+
+static inline atomic_t *anon_node_vm_lock_ref(struct anon_node *node)
+{
+	return &node->root->vm_lock_ref;
+}
+
+static void anon_node_ctor(void *data)
+{
+	struct anon_node *anon_nod = data;
+
+	init_rwsem(&anon_nod->rwsem);
+	atomic_set(&anon_nod->vm_lock_ref, 0);
+	atomic_set(&anon_nod->refcount, 0);
+}
+
+static inline void anon_vma_fractal_init(void)
+{
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct anon_node, fractal_list),
+		.ctor = anon_node_ctor,
+	};
+
+	anon_node_cachep = kmem_cache_create("anon_node",
+			sizeof(struct anon_node), &args,
+			SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT);
+}
+
+static inline void anon_node_free(struct anon_node *anon_nod)
+{
+	struct rw_semaphore *rmap_sem = anon_node_rmap_sem(anon_nod);
+
+	VM_BUG_ON(atomic_read(&anon_nod->refcount));
+	VM_BUG_ON(!list_empty(&anon_nod->fractal_list));
+	VM_BUG_ON(anon_nod->nr_children);
+	VM_BUG_ON(anon_node_rmap_count(anon_nod));
+
+	might_sleep();
+	if (rwsem_is_locked(rmap_sem)) {
+		down_write(rmap_sem);
+		up_write(rmap_sem);
+	}
+
+	kmem_cache_free(anon_node_cachep, anon_nod);
+}
+
+void __put_anon_node(struct anon_node *anon_nod)
+{
+	struct anon_node *root = anon_nod->root;
+
+	anon_node_free(anon_nod);
+	if (root != anon_nod && atomic_dec_and_test(&root->refcount))
+		anon_node_free(root);
+}
+
+static inline struct anon_node *anon_node_alloc(struct vm_area_struct *vma,
+		struct anon_node *parent, bool is_fork)
+{
+	struct anon_node *anon_nod;
+
+	anon_nod = kmem_cache_alloc(anon_node_cachep, GFP_KERNEL);
+	if (!anon_nod)
+		return NULL;
+
+	anon_nod->root = parent ? parent->root : anon_nod;
+	anon_nod->parent = parent;
+	atomic_set(&anon_nod->refcount, 1);
+	anon_nod->depth = 0;
+	if (parent) {
+		get_anon_node(parent->root);
+		anon_nod->depth = parent->depth + (1 << is_fork);
+	}
+	anon_nod->nr_children = 0;
+	INIT_LIST_HEAD(&anon_nod->fractal_list);
+	anon_nod->mm = vma->vm_mm;
+	atomic_long_set(&anon_nod->rbc, vma_rmap_base(vma) + 1);
+	return anon_nod;
+}
+
+#endif
+
 /*
  * Getting a lock on a stable anon_vma from a page off the LRU is tricky!
  *
-- 
2.17.1

