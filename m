Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E73CE4B2
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407462; cv=none; b=HZ3ek2rgbE/sl0BIN6YjE8Cer8SZ56brSTAyi6Mf+i5jLErpOlijWQK/ZiKDP6T1Id5FA4NQFrC5fHyuCr/POkWC5vtjf5xO3kTQqLuaGczN8D2KdfUIklHZ0PHC7O6F7xKbBmm8wq+abnVL0WDV18ffsiHzjh0ZUnIgo72ErG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407462; c=relaxed/simple;
	bh=HAvanrSkpPw5e3LfSeWQehg5tDKI1E7vfhyUPkbFsWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG1zrRnjgCdt37fdlIM8TygKyuvysLnMe7mVde8GnSLqQxnkP+/AXVrtPi8TW0laoXoQg4KssYqZKRtr49GWIqStDJ3EExnktkLwNShMKeRNTa5UKZsfzPR3xD44nyP5mDGkYfqFNtOAM6mNrvcQ6tUiIpXmGwTF34Vr57DakI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW005.hihonor.com (unknown [10.72.0.123])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gvWnH714QzYm8lp;
	Tue,  7 Jul 2026 14:40:19 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW005.hihonor.com
 (10.72.0.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 14:40:19 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:19 +0800
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
Subject: [RFC PATCH v2 08/13] mm: implement anonymous folio rmap for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:33:03 +0800
Message-ID: <20260707063308.29176-9-tao.wangtao@honor.com>
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

Add the ANON_RMAP_FOREACH_VMA() macro to encapsulate rmap traversal and
hide implementation differences from external users.

During reverse mapping of an anonymous folio, traversal first handles the
folio's own anon_node, then iterates through its descendants. Since large
folios may span multiple VMAs, VMA updates are used to advance pgoff, and
pgoff is used to determine completion of the current anon_node traversal.

For KSM, the VMA is located directly using the supplied address.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/internal.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 970f11b1af50..b38c7b4c2a8f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -296,6 +296,55 @@ static inline unsigned long anon_node_rmap_count(struct anon_node *anon_nod)
 	return atomic_long_read(&anon_nod->rbc) & ANON_RMAP_BASE_COUNT_MAX;
 }
 
+static inline unsigned long anon_node_rmap_address(struct anon_node *anon_nod,
+		unsigned long pgoff)
+{
+	if (!anon_node_rmap_count(anon_nod))
+		return 0;
+	return anon_node_rmap_base(anon_nod) + (pgoff << PAGE_SHIFT);
+}
+
+static inline struct vm_area_struct *anon_node_lookup_vma(
+	struct anon_node *anon_nod, unsigned long addr, unsigned long pgoff)
+{
+	struct vm_area_struct *vma;
+
+	if (!addr)
+		addr = anon_node_rmap_address(anon_nod, pgoff);
+	if (!anon_nod->mm || !addr)
+		return NULL;
+
+	vma = vma_lookup(anon_nod->mm, addr);
+	return (vma && vma->anon_vma == (void *)anon_nod) ? vma : NULL;
+}
+
+void vm_lock_anon_node(struct mm_struct *mm, struct anon_node *anon_nod);
+void vm_unlock_anon_node(struct anon_node *anon_nod);
+int anon_node_trylock_rmap(struct anon_node *anon_nod);
+void anon_node_lock_rmap(struct anon_node *anon_nod);
+void anon_node_unlock_rmap(struct anon_node *anon_nod);
+
+#define ANON_RMAP_FOREACH_VMA(anon_vma, addr, start, last, rmap_proc_vma) \
+do { \
+	struct vm_area_struct *vma = NULL; /* must be named vma */ \
+	struct anon_node *_anon_nod = (void *)(anon_vma); \
+	struct anon_node *_nod = _anon_nod; \
+	unsigned long _pgoff = (start); \
+	unsigned long _nr = 0, _total = 1; \
+	\
+	while (_nod) { \
+		vma = anon_node_lookup_vma(_nod, (addr), _pgoff); \
+		if (vma) \
+			(rmap_proc_vma); \
+		_pgoff = vma ? vma->vm_pgoff + vma_pages(vma) : _pgoff + 1; \
+		if (!(addr) && _pgoff <= (last)) \
+			continue; \
+		_pgoff = (start); \
+		BUG_ON(++_nr > (_total += _nod->nr_children)); \
+		_nod = anon_node_next_descendant(_anon_nod, _nod); \
+	} \
+} while (0)
+
 #endif
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index fd22576b0f58..1551e9d2121d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -982,6 +982,47 @@ void vma_post_update_rmap_base(struct vm_area_struct *vma, unsigned long diff)
 		release_anon_nodes(release_node);
 }
 
+#define ANON_VM_LOCK_REF	VM_REFCNT_EXCLUDE_READERS_FLAG
+
+void vm_lock_anon_node(struct mm_struct *mm, struct anon_node *anon_nod)
+{
+	atomic_t *vm_lock_ref = anon_node_vm_lock_ref(anon_nod);
+	struct rw_semaphore *rmap_sem = anon_node_rmap_sem(anon_nod);
+
+	if (!(atomic_read(vm_lock_ref) & ANON_VM_LOCK_REF)) {
+		down_write_nest_lock(rmap_sem, &mm->mmap_lock);
+		BUG_ON(atomic_read(vm_lock_ref));
+		atomic_set(vm_lock_ref, ANON_VM_LOCK_REF);
+	}
+}
+
+void vm_unlock_anon_node(struct anon_node *anon_nod)
+{
+	atomic_t *vm_lock_ref = anon_node_vm_lock_ref(anon_nod);
+	struct rw_semaphore *rmap_sem = anon_node_rmap_sem(anon_nod);
+
+	if (atomic_read(vm_lock_ref) & ANON_VM_LOCK_REF) {
+		BUG_ON(atomic_read(vm_lock_ref) != ANON_VM_LOCK_REF);
+		atomic_set(vm_lock_ref, 0);
+		up_write(rmap_sem);
+	}
+}
+
+int anon_node_trylock_rmap(struct anon_node *anon_nod)
+{
+	return down_read_trylock(anon_node_rmap_sem(anon_nod));
+}
+
+void anon_node_lock_rmap(struct anon_node *anon_nod)
+{
+	down_read(anon_node_rmap_sem(anon_nod));
+}
+
+void anon_node_unlock_rmap(struct anon_node *anon_nod)
+{
+	up_read(anon_node_rmap_sem(anon_nod));
+}
+
 #endif
 
 /*
-- 
2.17.1

