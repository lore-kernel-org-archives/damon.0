Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9F3F413A
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881211; cv=none; b=SLk1rsBzAZv22I4ye7VDVZyJX6sVg/wtTEP4DdEaJTBiiH94sTHHZ+SDJFBPnvQC7lXTnOLvAOScUjXuYlCoOcwX8Kx4WVjKgGs5Ks7eStJOp10QZw1Ccbg6CFo06KzBxcknQdl3hglxrpW5EvzJ3iiJL4cS2tpdohjOPP03nig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881211; c=relaxed/simple;
	bh=u3wyjBIt5jW+EGM9oNwMCqW+k4jPq+GElpnXGFcwr+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/y55PBdELnU9lA06ECKm8ChgZveSQBdaSBJJ9iR2gy7P8bqB96Hq9PIzXCNJd39VXmdBV6OJ98uKp+IsTgkrsWeoc4SjU7uzSJDAmE4eVVBIWcdcBtw4Qdsyy7iEuJXwuHJP1jPvHrYTi7B8hyMJNcaPeHhknbw6GjGQwK2hxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW003.hihonor.com (unknown [10.77.199.161])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gQRdN0rt8zYl3cl;
	Wed, 27 May 2026 19:06:32 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW003.hihonor.com
 (10.77.199.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:55 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:57 +0800
From: tao <tao.wangtao@honor.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<willy@infradead.org>, <sj@kernel.org>, <kees@kernel.org>,
	<luizcap@redhat.com>, <zhangjiao2@cmss.chinamobile.com>,
	<tao.wangtao@honor.com>, <kas@kernel.org>, <ljs@kernel.org>
CC: <hpa@zytor.com>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <jack@suse.cz>,
	<riel@surriel.com>, <harry@kernel.org>, <jannh@google.com>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>, <nao.horiguchi@gmail.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <pfalcato@suse.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<damon@lists.linux.dev>, <shakeel.butt@linux.dev>, <ryncsn@gmail.com>,
	<21cnbao@gmail.com>, <jparsana@google.com>, <dvander@google.com>,
	<zhangji1@honor.com>, <wangzicheng@honor.com>
Subject: [PATCH 05/15] mm: add CONFIG_ANON_VMA_LAZY and folio helpers
Date: Wed, 27 May 2026 19:01:37 +0800
Message-ID: <20260527110147.17815-6-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: TW006-1.hihonor.com (10.77.215.153) To TA003.hihonor.com
 (10.72.0.43)

Add the ANON_VMA_LAZY optimization foundation:
 - CONFIG_ANON_VMA_LAZY Kconfig option
 - FOLIO_MAPPING_ANON_VMA_LAZY flag for folio->mapping
 - add a runtime switch for ANON_VMA_LAZY

This feature delays anon_vma allocation until fork, reducing memory
overhead for VMAs without children.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 include/linux/page-flags.h | 23 +++++++++++
 mm/Kconfig                 | 14 +++++++
 mm/internal.h              | 16 ++++++++
 mm/mmap.c                  |  9 ++++
 mm/rmap.c                  | 84 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0e03d816e8b9..c0cc43118877 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -696,6 +696,12 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * the FOLIO_MAPPING_ANON_KSM bit may be set along with the FOLIO_MAPPING_ANON
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
  * structure which KSM associates with that merged folio.  See ksm.h.
+ *
+ * If CONFIG_ANON_VMA_LAZY is enabled, the FOLIO_MAPPING_ANON_KSM bit is used
+ * for the ANON_VMA_LAZY optimization. In this case, folio->mapping points to
+ * the ANON_VMA_LAZY root VMA instead of anon_vma. The folio_test_anon()
+ * check also needs to be updated accordingly.
+
  *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
@@ -711,11 +717,16 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define FOLIO_MAPPING_ANON	0x1
 #define FOLIO_MAPPING_ANON_KSM	0x2
 #define FOLIO_MAPPING_KSM	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
+#define FOLIO_MAPPING_ANON_VMA_LAZY	FOLIO_MAPPING_ANON_KSM
 #define FOLIO_MAPPING_FLAGS	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
 
 static __always_inline bool folio_test_anon(const struct folio *folio)
 {
+#ifdef CONFIG_ANON_VMA_LAZY
+	return ((unsigned long)folio->mapping & FOLIO_MAPPING_FLAGS) != 0;
+#else
 	return ((unsigned long)folio->mapping & FOLIO_MAPPING_ANON) != 0;
+#endif
 }
 
 static __always_inline bool folio_test_lazyfree(const struct folio *folio)
@@ -734,6 +745,18 @@ static __always_inline bool PageAnon(const struct page *page)
 {
 	return folio_test_anon(page_folio(page));
 }
+
+static inline bool folio_test_anon_vma_lazy(const struct folio *folio)
+{
+#ifdef CONFIG_ANON_VMA_LAZY
+	unsigned long flags = (unsigned long)folio->mapping;
+
+	return (flags & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_ANON_VMA_LAZY;
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
diff --git a/mm/Kconfig b/mm/Kconfig
index e8bf1e9e6ad9..c16b5d9b3ce9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1412,6 +1412,20 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config ARCH_SUPPORTS_ANON_VMA_LAZY
+	def_bool n
+
+config ANON_VMA_LAZY
+	bool "Lazy allocation of anon_vma"
+	def_bool y
+	depends on ARCH_SUPPORTS_ANON_VMA_LAZY && MMU
+	help
+	  For anonymous VMAs without children, avoid allocating anon_vma
+	  and anon_vma_chain to reduce memory overhead.
+
+	  Say Y to enable this optimization for anonymous VMAs without
+	  children.
+
 config IOMMU_MM_DATA
 	bool
 
diff --git a/mm/internal.h b/mm/internal.h
index 3dbbd118a78c..639f9c287f4c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -248,6 +248,22 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
 
 /* anon_vma_tree_t APIs */
 
+/* Encoded anon_vma tree type. Must fit within ANON_VMA_TREE_BITS. */
+#define ANON_VMA_TREE_REGULAR 0 /* regular anon_vma */
+#define ANON_VMA_TREE_VMA     1
+#define ANON_VMA_TREE_PARENT  2
+#define ANON_VMA_TREE_INVALID 3 /* reserved */
+
+#define ANON_VMA_TREE_BITS 2
+#define ANON_VMA_TREE_MASK ((1UL << ANON_VMA_TREE_BITS) - 1)
+
+#ifdef CONFIG_ANON_VMA_LAZY
+extern bool anon_vma_lazy_enable;
+static inline bool anon_vma_lazy_enabled(void) { return anon_vma_lazy_enable; }
+#else
+static inline bool anon_vma_lazy_enabled(void) { return false; }
+#endif
+
 static inline anon_vma_tree_t make_anon_vma_tree(struct anon_vma *anon_vma)
 {
 	return (anon_vma_tree_t)anon_vma;
diff --git a/mm/mmap.c b/mm/mmap.c
index eac1fb3823eb..2ae733eb39f0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1558,6 +1558,15 @@ static const struct ctl_table mmap_table[] = {
 				.extra2         = (void *)&mmap_rnd_compat_bits_max,
 		},
 #endif
+#ifdef CONFIG_ANON_VMA_LAZY
+		{
+				.procname	= "anon_vma_lazy",
+				.data		= &anon_vma_lazy_enable,
+				.maxlen		= sizeof(anon_vma_lazy_enable),
+				.mode		= 0600,
+				.proc_handler	= proc_dobool,
+		},
+#endif
 };
 #endif /* CONFIG_SYSCTL */
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 5c4eb090c801..48c4463d8b2c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -87,6 +87,90 @@
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
 
+#ifdef CONFIG_ANON_VMA_LAZY
+/*
+ * ANON_VMA_LAZY: defer anon_vma allocation until fork().
+ *
+ * anon_vma and anon_vma_chain exist mainly to support reverse mapping
+ * across multiple processes. For VMAs that belong to a single process,
+ * eagerly creating anon_vma introduces unnecessary memory and setup
+ * overhead.
+ *
+ * This optimization delays anon_vma creation until fork(). Before that
+ * the VMA stays in a lazy state and no anon_vma or anon_vma_chain
+ * topology is created.
+ *
+ * vma->anon_vma encodes the anonymous VMA state. Low bits of the pointer
+ * distinguish lazy states:
+ *
+ *   NULL
+ *        VMA has no anonymous or CoW pages.
+ *
+ *   regular anon_vma
+ *        Standard anon_vma with anon_vma_chain topology.
+ *
+ *   anon_vma_lazy_root | ANON_VMA_TREE_VMA
+ *        Lazy root for the VMA that first faults anonymous pages.
+ *        No anon_vma or anon_vma_chain topology exists.
+ *
+ *   parent_anon_vma | ANON_VMA_TREE_PARENT
+ *        Lazy state for VMAs created during fork(). The lazy parent_anon_vma
+ *        refers to the anon_vma of the parent VMA.
+ *
+ * Anonymous folios extend folio->mapping with FOLIO_MAPPING_ANON_VMA_LAZY:
+ *
+ *   anon_vma | FOLIO_MAPPING_ANON
+ *        regular anonymous mapping
+ *
+ *   anon_vma_lazy_root | FOLIO_MAPPING_ANON_VMA_LAZY
+ *        lazy anonymous mapping
+ *
+ * In typical workloads most VMAs remain in ANON_VMA_TREE_VMA state.
+ * These VMAs have no anon_vma, no anon_vma_chain and only a single VMA.
+ * Reverse mapping can therefore be performed without anon_vma locking,
+ * providing a faster rmap path for the common case.
+ *
+ * During fork(), VMAs in ANON_VMA_TREE_VMA are upgraded to regular
+ * anon_vma in the parent to establish sharing topology. Child VMAs are
+ * created as ANON_VMA_TREE_PARENT and do not allocate anon_vma,
+ * avoiding additional fork overhead.
+ *
+ * Folio mapping rules:
+ *
+ *   Lazy anonymous folios store the lazy root in folio->mapping using
+ *   FOLIO_MAPPING_ANON_VMA_LAZY. This allows rmap walkers to resolve the
+ *   owning VMA without requiring anon_vma topology.
+ *
+ *   folio->mapping may be updated during fork() when lazy VMAs are
+ *   upgraded to regular anon_vma. dup_anon_rmap() in copy_page_range()
+ *   performs the upgrade and installs the new anon_vma mapping.
+ *
+ *   folio_move_anon_rmap() updates folio->mapping when anonymous folios
+ *   move between VMAs.
+ *
+ *   As with regular anonymous memory, __folio_remove_rmap() does not
+ *   clear folio->mapping. Rmap walkers validate mappings using
+ *   folio_mapped().
+ *
+ * VMA split keeps vma->anon_vma unchanged. The lazy root holds an extra
+ * reference so folio->mapping remains valid without scanning folios.
+ *
+ * Internal helpers:
+ *
+ *   anon_vma_link_t
+ *        The value encodes a reference to anon_vma topology. Low bits
+ *        are used as type tags to distinguish different anon_vma
+ *        implementations (e.g. regular anon_vma or anon_vma_lazy).
+ *
+ *   anon_rmap_t
+ *        anon_rmap_t wraps the tagged pointer used by the rmap code and
+ *        provides a type-safe interface for reverse mapping operations,
+ *        covering both regular anon_vma and lazy anon_vma mappings.
+ */
+
+bool anon_vma_lazy_enable;
+#endif
+
 static inline struct anon_vma *anon_vma_alloc(void)
 {
 	struct anon_vma *anon_vma;
-- 
2.17.1

