Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1A221546
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406422; cv=none; b=NkyzfYKXT+qqGKG67KBxOxgutmSnPdk5gkh8pBRQukz8MwlAUHATys7ZE9mLpu4qGAfE4ptoXN1ZyK6PXRdCIxJvJnp6Z+VXgfc8DSZr1RU7CVJhlVCYX65AS/jCoZfpDSw7yq7s7l3HtfQQQEoXhSqZ5M5flaQ35Nr21+AbsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406422; c=relaxed/simple;
	bh=miF/5AF4FIfygDAx2is1w3V3Kn+6Ga3kh2CTj4+ntVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iC5jHZhayolD3az8/A7htulVVtpNJDyzgnlYnOQxdzrLylB3DBkpcWx4ntLMKUtsroxhXSCZUshB6NHJR8LWtRzvGBzY47xOcD0CLNIksUQF88DlyI5iKq0GzSdZJZKCJ6EhgnMdHI5pI4IHHc+kJnT/N8bZvgmjx5bMKa7XXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=iasSZFKR; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="iasSZFKR"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=O4P7InBYaG4rmwPlF5sL6FgR3mPgxPHfvBAsEBV5dVQ=;
	b=iasSZFKRAL1e27RLlbdaqxBrk0RdlshKlJHzamh6aX7qZRA7go3a55bxpUovpbC87MTgiZ2Aj
	oFkGbCMbmT+6obXaXwRkkyKa24hF+U4iQU2O/TDA9g5161vl/QfSvAXtLnIgRfQazWda1bogdIi
	GAuFp9YVDvHPkgkc/gya1ao=
Received: from TW002-1.hihonor.com (unknown [10.72.0.137])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gvWnF61KPzYl1nh;
	Tue,  7 Jul 2026 14:40:17 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW002-1.hihonor.com
 (10.72.0.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
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
Subject: [RFC PATCH v2 01/13] mm: add CONFIG_ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:32:56 +0800
Message-ID: <20260707063308.29176-2-tao.wangtao@honor.com>
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

Use vma_rmap_base(vma) to compute page addresses during rmap and
look up the corresponding VMA in mm_mt. Since vma_rmap_base(vma)
remains invariant across VMA merge and split, VMA operations only
need to adjust the VMA count of the corresponding anon_vma,
eliminating anon_vma_chain.

Fork creates derived anon_vmas in a fractal-like structure. A list
tracks anon_vmas, while fork depth is used to locate descendant
anon_vmas during rmap traversal.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 include/linux/rmap.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig           | 28 ++++++++++++++++++++++++++
 mm/internal.h        | 28 ++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8dc0871e5f00..75738f4ede1f 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -67,6 +67,54 @@ struct anon_vma {
 	struct rb_root_cached rb_root;
 };
 
+#ifdef CONFIG_ANON_VMA_FRACTAL
+
+/* struct anon_node - Replace anon_vma for anonymous page reverse mapping. */
+struct anon_node {
+	struct anon_node *root;		/* Root of this anon_node fractal tree */
+	struct rw_semaphore rwsem;
+	atomic_t vm_lock_ref;		/* for vm_lock_anon_vma */
+	atomic_t refcount;
+
+	struct anon_node *parent;	/* NULL if created by a page fault */
+
+	/*
+	 * depth is initialized to 0. When a child is added, depth is set to 1.
+	 * An rbc child has depth = parent->depth + 1,
+	 * and fork child has depth = parent->depth + 2.
+	 *
+	 * A forks B and C; B remaps D and forks E and F; C forks G.
+	 * The fractal_list is as follows:
+	 *                  (1A)--------------o
+	 *                 /                   \
+	 *               (3B)      (3C)         o
+	 *               /         /  \        /
+	 *             (4D)       /    \      /
+	 *             /         /      \    /
+	 *           (5E)----(5F)        (5G)
+	 */
+	unsigned int depth;
+	unsigned int nr_children;	/* < PID_MAX_LIMIT + max_map_count. */
+	struct list_head fractal_list;
+
+	/* mm and rmap_base can be used to find the VMA a page belongs to. */
+	struct mm_struct *mm;
+	/* rmap_base with VMA count in the low PAGE_SHIFT bits. */
+	atomic_long_t rbc;
+};
+
+/* Create rbc child anon_node on VMA remap or when count exceeds MAX. */
+#define ANON_RMAP_BASE_COUNT_MASK	(PAGE_SIZE - 1)
+#define ANON_RMAP_BASE_COUNT_MAX	(ANON_RMAP_BASE_COUNT_MASK)
+
+/*
+ * Allow VMAs to share an anon_node only if the number of VMAs attached
+ * is below this limit; keep it small to reduce lock contention.
+ */
+#define ANON_NODE_SHARE_LIMIT	(ANON_RMAP_BASE_COUNT_MAX / 1000)
+
+#endif
+
 /*
  * The copy-on-write semantics of fork mean that an anon_vma
  * can become associated with multiple processes. Furthermore,
diff --git a/mm/Kconfig b/mm/Kconfig
index 9e0ca4824905..c4c6d3e52d72 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1451,6 +1451,34 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config ANON_VMA_FRACTAL
+	bool "anon_vma fractal list"
+	def_bool n
+	depends on MMU
+	help
+	  This option uses vma_rmap_base(vma) during rmap to compute the page
+	  address and look up the corresponding VMA in mm_mt.
+
+	    vma_rmap_base(vma) = vma->vm_start - vma->vm_pgoff * PAGE_SIZE
+
+	    page_address(vma, pgoff)
+	     = vma->vm_start + (pgoff - vma->vm_pgoff) * PAGE_SIZE
+	     = vma->vm_start - vma->vm_pgoff * PAGE_SIZE + pgoff * PAGE_SIZE
+	     = vma_rmap_base(vma) + pgoff * PAGE_SIZE
+
+	  Since vma_rmap_base(vma) remains invariant across VMA merge and
+	  split, VMA operations only need to adjust the VMA count of the
+	  corresponding anon_vma, eliminating the need for anon_vma_chain.
+
+	  Process fork behaves like a fractal expansion of both tasks and
+	  anon_vmas. A list records forked anon_vmas, and descendant anon_vmas
+	  are derived from fork depth for rmap handling.
+
+	  The fractal list remains unchanged during VMA merge or split. It
+	  is only updated when anon_vmas are created or removed, and traversed
+	  during rmap walks. Since rmap_one operations may switch tasks,
+	  semaphores are still required instead of spinlock_t protection.
+
 config IOMMU_MM_DATA
 	bool
 
diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a2..a33ed1a30f09 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -202,6 +202,16 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
 
 #ifdef CONFIG_MMU
 
+static inline unsigned long rmap_base(unsigned long vm_start, pgoff_t pgoff)
+{
+	return vm_start - (pgoff << PAGE_SHIFT);
+}
+
+static inline unsigned long vma_rmap_base(const struct vm_area_struct *vma)
+{
+	return rmap_base(vma->vm_start, vma->vm_pgoff);
+}
+
 static inline void get_anon_vma(struct anon_vma *anon_vma)
 {
 	atomic_inc(&anon_vma->refcount);
@@ -245,6 +255,24 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
 	up_read(&anon_vma->root->rwsem);
 }
 
+#ifdef CONFIG_ANON_VMA_FRACTAL
+
+static inline struct anon_node *anon_node_next_rbc_child(
+		struct anon_node *anon_nod, struct anon_node *node)
+{
+	node = list_next_entry(node, fractal_list);
+	return node->depth == anon_nod->depth + 1 ? node : NULL;
+}
+
+static inline struct anon_node *anon_node_next_descendant(
+		struct anon_node *anon_nod, struct anon_node *node)
+{
+	node = list_next_entry(node, fractal_list);
+	return node->depth > anon_nod->depth ? node : NULL;
+}
+
+#endif
+
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
 /* Operations which modify VMAs. */
-- 
2.17.1

