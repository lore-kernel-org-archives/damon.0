Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C73D667F
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407462; cv=none; b=HlH8ZvMLiSu4ONqx3NXhpeMk8qRFTN+itVvup3MSbxxkbTiL34vKtsd+XdJHcNPnFTIhpDk7W0+HqO7Ht1G+ayrHwcEtj75wK15B+g1JGsypFS6/Ac/eKhKGCZbw4fx0iYZg8h1C03g6Se9sstywK+x4xniIlHENtPphXcdsvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407462; c=relaxed/simple;
	bh=eDQgB0seKhJExd1mpMoBwKP84AQrrwiajeZB873z4cY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhKvgNAHhxRT3htzrLw9vkCgBpRHTr5WfrkYebON1Wd/F2JkXPlIGL/zilv66RHxyl8+bC4nCzgUiL8SwayxkrKSwkyeJPjmbqCICayBkEMaaHJOk7pGQHFhxDH/O8ACtcXcrTff7h7Z9jFBav/qrbl3ubyW50WFevPsCFdvbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW005.hihonor.com (unknown [10.72.0.123])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gvWnJ0w5HzYm8lZ;
	Tue,  7 Jul 2026 14:40:20 +0800 (CST)
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
Subject: [RFC PATCH v2 09/13] mm: prepare anon_node replacement for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:33:04 +0800
Message-ID: <20260707063308.29176-10-tao.wangtao@honor.com>
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

Since this replacement involves large code changes, introduce macros
in vma.c first to isolate code differences and split the changes into
smaller patches.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/internal.h | 16 ++++++++++++++++
 mm/rmap.c     |  2 +-
 mm/vma.c      | 52 +++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b38c7b4c2a8f..6f0ff492a89c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -296,6 +296,22 @@ static inline unsigned long anon_node_rmap_count(struct anon_node *anon_nod)
 	return atomic_long_read(&anon_nod->rbc) & ANON_RMAP_BASE_COUNT_MAX;
 }
 
+static inline bool anon_node_can_share(struct anon_node *anon_nod)
+{
+	return anon_nod->depth == 0 &&
+		anon_node_rmap_count(anon_nod) <= ANON_NODE_SHARE_LIMIT;
+}
+
+static inline void anon_node_verify(struct anon_node *node)
+{
+	struct anon_node *rbc_ch = node;
+
+	WARN_ON_ONCE(anon_node_rmap_count(node) == 0 && node->nr_children == 0);
+	while ((rbc_ch = anon_node_next_rbc_child(node, rbc_ch)) != NULL) {
+		WARN_ON_ONCE(anon_node_rmap_count(rbc_ch) == 0);
+	}
+}
+
 static inline unsigned long anon_node_rmap_address(struct anon_node *anon_nod,
 		unsigned long pgoff)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 1551e9d2121d..12c6a1bdff3f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -690,7 +690,7 @@ int __anon_node_prepare(struct vm_area_struct *vma)
 	mmap_assert_locked(mm);
 	might_sleep();
 
-	anon_nod = NULL; /* Fix find_mergeable_anon_vma(vma) later. */
+	anon_nod = (struct anon_node *)find_mergeable_anon_vma(vma);
 	if (anon_nod) {
 		anon_new = (struct anon_vma *)anon_nod;
 		if (try_track_rmap(anon_nod, rmap_base) &&
diff --git a/mm/vma.c b/mm/vma.c
index d2996369e30d..02178112daa0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -269,19 +269,23 @@ static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 static void
 anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma)
 {
+#ifndef CONFIG_ANON_VMA_FRACTAL
 	struct anon_vma_chain *avc;
 
 	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 		anon_vma_interval_tree_remove(avc, &avc->anon_vma->rb_root);
+#endif
 }
 
 static void
 anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 {
+#ifndef CONFIG_ANON_VMA_FRACTAL
 	struct anon_vma_chain *avc;
 
 	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
+#endif
 }
 
 /*
@@ -651,10 +655,6 @@ void validate_mm(struct mm_struct *mm)
 
 	mt_validate(&mm->mm_mt);
 	for_each_vma(vmi, vma) {
-#ifdef CONFIG_DEBUG_VM_RB
-		struct anon_vma *anon_vma = vma->anon_vma;
-		struct anon_vma_chain *avc;
-#endif
 		unsigned long vmi_start, vmi_end;
 		bool warn = 0;
 
@@ -675,12 +675,19 @@ void validate_mm(struct mm_struct *mm)
 			vma_iter_dump_tree(&vmi);
 		}
 
-#ifdef CONFIG_DEBUG_VM_RB
-		if (anon_vma) {
+#if CONFIG_DEBUG_VM_RB
+		if (vma->anon_vma) {
+#ifdef CONFIG_ANON_VMA_FRACTAL
+			anon_node_verify((void *)vma->anon_vma);
+#else
+			struct anon_vma *anon_vma = vma->anon_vma;
+			struct anon_vma_chain *avc;
+
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
+#endif
 		}
 #endif
 		/* Check for a infinite loop */
@@ -2027,8 +2034,13 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old,
 	if (anon_vma_compatible(a, b)) {
 		struct anon_vma *anon_vma = READ_ONCE(old->anon_vma);
 
+#ifdef CONFIG_ANON_VMA_FRACTAL
+		if (anon_vma && anon_node_can_share((void *)anon_vma))
+			return anon_vma;
+#else
 		if (anon_vma && list_is_singular(&old->anon_vma_chain))
 			return anon_vma;
+#endif
 	}
 	return NULL;
 }
@@ -2157,6 +2169,9 @@ static DEFINE_MUTEX(mm_all_locks_mutex);
 
 static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 {
+#ifdef CONFIG_ANON_VMA_FRACTAL
+	vm_lock_anon_node(mm, (void *)anon_vma);
+#else
 	if (!test_bit(0, (unsigned long *) &anon_vma->root->rb_root.rb_root.rb_node)) {
 		/*
 		 * The LSB of head.next can't change from under us
@@ -2176,6 +2191,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 				       &anon_vma->root->rb_root.rb_root.rb_node))
 			BUG();
 	}
+#endif
 }
 
 static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
@@ -2237,7 +2253,6 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
 int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-	struct anon_vma_chain *avc;
 	VMA_ITERATOR(vmi, mm, 0);
 
 	mmap_assert_write_locked(mm);
@@ -2278,9 +2293,16 @@ int mm_take_all_locks(struct mm_struct *mm)
 	for_each_vma(vmi, vma) {
 		if (signal_pending(current))
 			goto out_unlock;
-		if (vma->anon_vma)
+		if (vma->anon_vma) {
+#ifdef CONFIG_ANON_VMA_FRACTAL
+			vm_lock_anon_vma(mm, vma->anon_vma);
+#else
+			struct anon_vma_chain *avc;
+
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_lock_anon_vma(mm, avc->anon_vma);
+#endif
+		}
 	}
 
 	return 0;
@@ -2292,6 +2314,9 @@ int mm_take_all_locks(struct mm_struct *mm)
 
 static void vm_unlock_anon_vma(struct anon_vma *anon_vma)
 {
+#ifdef CONFIG_ANON_VMA_FRACTAL
+	vm_unlock_anon_node((void *)anon_vma);
+#else
 	if (test_bit(0, (unsigned long *) &anon_vma->root->rb_root.rb_root.rb_node)) {
 		/*
 		 * The LSB of head.next can't change to 0 from under
@@ -2310,6 +2335,7 @@ static void vm_unlock_anon_vma(struct anon_vma *anon_vma)
 			BUG();
 		anon_vma_unlock_write(anon_vma);
 	}
+#endif
 }
 
 static void vm_unlock_mapping(struct address_space *mapping)
@@ -2333,16 +2359,22 @@ static void vm_unlock_mapping(struct address_space *mapping)
 void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-	struct anon_vma_chain *avc;
 	VMA_ITERATOR(vmi, mm, 0);
 
 	mmap_assert_write_locked(mm);
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
 
 	for_each_vma(vmi, vma) {
-		if (vma->anon_vma)
+		if (vma->anon_vma) {
+#ifdef CONFIG_ANON_VMA_FRACTAL
+			vm_unlock_anon_vma(vma->anon_vma);
+#else
+			struct anon_vma_chain *avc;
+
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
+#endif
+		}
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
-- 
2.17.1

