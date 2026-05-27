Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBE3F413A
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881215; cv=none; b=ly5FlCEqFBoVtFgLvItYGHfknF0Vjc1u71EwHZu79O2HnmbJUo7/O1zQ56whHexrfLl1bVNfPJICpw+afUC6n+TyIPcpvpuv7GJZZaOdFGnJUjRbDOxdzLQ+hu3ziU9UqJ+uBRpxfaRIXVA1AcSWvURYCR6Ni5KBORFgkc55d1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881215; c=relaxed/simple;
	bh=qIYNFJAPjU9ghkiPO1zZBGrcxFbZhjCPI2Kl4xfIX8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaqwuaGt9lbi6IdAibAEvA3/lSGb6qLHm4hT4GjgIKesR3UJNnBsFsEGEtBKH52ZUiAVl+fwucQ1ee+B3hw6C6H2AnQwATOgZt5+LKA0gBwC6QdzQ8gQLXyxyQwYZrAiu/rItggCfL9Zr+JllD0fiYFUpz17ntxqxzJmsTCXNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gQRdH25mSzYlBHf;
	Wed, 27 May 2026 19:06:27 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:03 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:02 +0800
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
Subject: [PATCH 13/15] mm: support setup and upgrade of ANON_VMA_LAZY folios
Date: Wed, 27 May 2026 19:01:45 +0800
Message-ID: <20260527110147.17815-14-tao.wangtao@honor.com>
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

new_anon_rmap() and move_anon_rmap() decide whether to set
PAGE_MAPPING_ANON_VMA_LAZY.

try_dup_anon_rmap() upgrades the folio to PAGE_MAPPING_ANON
during fork() when required.

rmap_walk_anon() detects ANON_VMA_LAZY upgrades and retries
the walk to ensure the mapping is handled correctly.

remove_rmap() needs no special handling since folio_mapped()
is checked before use.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 include/linux/rmap.h | 38 ++++++++++++++++++++++++++++++++++++++
 mm/rmap.c            | 21 ++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 59244481a8c1..9b1970698204 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -392,6 +392,14 @@ static __always_inline void __folio_rmap_sanity_checks(const struct folio *folio
 		unsigned long mapping = (unsigned long)folio->mapping;
 		struct anon_vma *anon_vma;
 
+		if (folio_test_anon_vma_lazy(folio)) {
+			struct vm_area_struct *root_vma =
+				(void *)(mapping - FOLIO_MAPPING_ANON_VMA_LAZY);
+
+			VM_WARN_ON_FOLIO(!rcuref_read(&root_vma->vm_rcuref), folio);
+			return;
+		}
+
 		anon_vma = (void *)(mapping - FOLIO_MAPPING_ANON);
 		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
 	}
@@ -431,6 +439,31 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+/**
+ * folio_upgrade_anon_vma_lazy - upgrade folio->mapping from ANON_VMA_LAZY to
+ *                               an anon_vma
+ * @folio: The folio to upgrade
+ * @vma:   The VMA the folio currently belongs to
+ *
+ * Upgrade folio->mapping from ANON_VMA_LAZY to an anon_vma.
+ * This transition is strictly one-way and never reverts back to a lazy
+ * mapping.
+ *
+ * Called during fork() while holding the mmap lock and the VMA write lock,
+ * but without taking the folio lock. Concurrent readers may briefly observe
+ * the old lazy mapping. Migration relies on folio_trylock_get_anon_rmap()
+ * to ensure atomicity, while other rmap operations remain unaffected.
+ */
+static inline void folio_upgrade_anon_vma_lazy(struct folio *folio,
+					       struct vm_area_struct *vma)
+{
+	unsigned long anon_tree = (unsigned long)vma->anon_vma;
+
+	VM_BUG_ON_VMA(!anon_tree || !IS_ALIGNED(anon_tree, sizeof(long)), vma);
+	anon_tree = anon_tree + FOLIO_MAPPING_ANON;
+	WRITE_ONCE(folio->mapping, (struct address_space *)anon_tree);
+}
+
 /* See folio_try_dup_anon_rmap_*() */
 static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma)
@@ -438,6 +471,9 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
+	if (folio_test_anon_vma_lazy(folio))
+		folio_upgrade_anon_vma_lazy(folio, vma);
+
 	if (PageAnonExclusive(&folio->page)) {
 		if (unlikely(folio_needs_cow_for_dma(vma, folio)))
 			return -EBUSY;
@@ -573,6 +609,8 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 	int i;
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	if (folio_test_anon_vma_lazy(folio))
+		folio_upgrade_anon_vma_lazy(folio, src_vma);
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 46876b3dbfbc..e14509b47412 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2002,6 +2002,16 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 	void *anon_vma = vma_anon_vma(vma);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (!anon_vma) {
+		const struct vm_area_struct *root_vma = vma_anon_vma_lazy_root(vma);
+
+		VM_BUG_ON_VMA(!root_vma, vma);
+		root_vma = (void *)root_vma + FOLIO_MAPPING_ANON_VMA_LAZY;
+		WRITE_ONCE(folio->mapping, (struct address_space *)root_vma);
+		return;
+	}
+
 	VM_BUG_ON_VMA(!anon_vma, vma);
 
 	anon_vma += FOLIO_MAPPING_ANON;
@@ -2023,7 +2033,16 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 			     unsigned long address, bool exclusive)
 {
-	struct anon_vma *anon_vma = vma_anon_vma(vma);
+	anon_vma_tree_t anon_tree = vma->anon_vma;
+	const struct vm_area_struct *root_vma = vma_anon_vma_lazy_root(vma);
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	if (root_vma && (anon_vma_tree_is_vma(anon_tree) || exclusive)) {
+		root_vma = (void *)root_vma + FOLIO_MAPPING_ANON_VMA_LAZY;
+		WRITE_ONCE(folio->mapping, (struct address_space *)root_vma);
+		folio->index = linear_page_index(vma, address);
+		return;
+	}
 
 	BUG_ON(!anon_vma);
 
-- 
2.17.1

