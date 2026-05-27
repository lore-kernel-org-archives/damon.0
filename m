Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50D3FA5F2
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880092; cv=none; b=jNrdIknRYGMXeYkmFSd4Vpl3TZXokIcbxoap0dhwSjMO7q7B5hCL+3OHvAK4f8BmUJ5dlLnozCp82epzfZbhaMO7ocfDXcuZmN0rgGF1RzOfqmzFGwifATsA93uHFRBlPZCSbUeUYOjQ5Y/KAwDj9kpdnef0hoL3GaWGQEpxcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880092; c=relaxed/simple;
	bh=Dk7SM3To25Cme62PVbHQX7dIZzrQQBtRDWTHoV7EWI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBGUx1I076MJaaXdIL1FXwtSJahJlIUCK3rSr9hQmr5oaiK+HJwXOZf11OF9OxefN1qdWKBMSDGjOyhsH8/kdSq4eKHHnkgY4veofg+5muYrPF1O1G1M3ECnxrLOJWXHbqelmnkWBg7sl/eCf20L2mRf89AlGqCBGRqqSDdVQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gQRdP2F6tzYl7vQ;
	Wed, 27 May 2026 19:06:33 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:59 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:58 +0800
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
Subject: [PATCH 07/15] mm: replace direct FOLIO_MAPPING_ANON usage with helpers
Date: Wed, 27 May 2026 19:01:39 +0800
Message-ID: <20260527110147.17815-8-tao.wangtao@honor.com>
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

Replace direct uses of FOLIO_MAPPING_ANON in external modules with
helper functions in preparation for ANON_VMA_LAZY.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 fs/proc/page.c             |  6 ++----
 include/linux/page-flags.h | 15 ++++++++++++---
 include/linux/pagemap.h    |  2 +-
 mm/gup.c                   |  6 ++----
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f9b2c2c906cd..93ddfda9fa1d 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -148,7 +148,6 @@ u64 stable_page_flags(const struct page *page)
 	const struct folio *folio;
 	struct page_snapshot ps;
 	unsigned long k;
-	unsigned long mapping;
 	bool is_anon;
 	u64 u = 0;
 
@@ -163,8 +162,7 @@ u64 stable_page_flags(const struct page *page)
 	folio = &ps.folio_snapshot;
 
 	k = folio->flags.f;
-	mapping = (unsigned long)folio->mapping;
-	is_anon = mapping & FOLIO_MAPPING_ANON;
+	is_anon = folio_test_anon(folio);
 
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
@@ -173,7 +171,7 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_MMAP;
 	if (is_anon) {
 		u |= 1 << KPF_ANON;
-		if (mapping & FOLIO_MAPPING_KSM)
+		if (!PageAnonNotKsm(page))
 			u |= 1 << KPF_KSM;
 	}
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index c0cc43118877..50c80a1e2c7c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -720,15 +720,20 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define FOLIO_MAPPING_ANON_VMA_LAZY	FOLIO_MAPPING_ANON_KSM
 #define FOLIO_MAPPING_FLAGS	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
 
-static __always_inline bool folio_test_anon(const struct folio *folio)
+static __always_inline bool mapping_is_anon(unsigned long mapping)
 {
 #ifdef CONFIG_ANON_VMA_LAZY
-	return ((unsigned long)folio->mapping & FOLIO_MAPPING_FLAGS) != 0;
+	return (mapping & FOLIO_MAPPING_FLAGS) != 0;
 #else
-	return ((unsigned long)folio->mapping & FOLIO_MAPPING_ANON) != 0;
+	return (mapping & FOLIO_MAPPING_ANON) != 0;
 #endif
 }
 
+static __always_inline bool folio_test_anon(const struct folio *folio)
+{
+	return mapping_is_anon((unsigned long)folio->mapping);
+}
+
 static __always_inline bool folio_test_lazyfree(const struct folio *folio)
 {
 	return folio_test_anon(folio) && !folio_test_swapbacked(folio);
@@ -738,7 +743,11 @@ static __always_inline bool PageAnonNotKsm(const struct page *page)
 {
 	unsigned long flags = (unsigned long)page_folio(page)->mapping;
 
+#ifdef CONFIG_ANON_VMA_LAZY
+	return (flags & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_KSM;
+#else
 	return (flags & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_ANON;
+#endif
 }
 
 static __always_inline bool PageAnon(const struct page *page)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..746939872ac4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -507,7 +507,7 @@ static inline pgoff_t mapping_align_index(const struct address_space *mapping,
 static inline bool mapping_large_folio_support(const struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
-	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
+	VM_WARN_ONCE(mapping_is_anon((unsigned long)mapping),
 			"Anonymous mapping always supports large folio");
 
 	return mapping_max_folio_order(mapping) > 0;
diff --git a/mm/gup.c b/mm/gup.c
index ad9ded39609c..69dda325b082 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2740,7 +2740,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	bool reject_file_backed = false;
 	struct address_space *mapping;
 	bool check_secretmem = false;
-	unsigned long mapping_flags;
 
 	/*
 	 * If we aren't pinning then no problematic write can occur. A long term
@@ -2792,9 +2791,8 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 		return false;
 
 	/* Anonymous folios pose no problem. */
-	mapping_flags = (unsigned long)mapping & FOLIO_MAPPING_FLAGS;
-	if (mapping_flags)
-		return mapping_flags & FOLIO_MAPPING_ANON;
+	if (mapping_is_anon((unsigned long)mapping))
+		return true;
 
 	/*
 	 * At this point, we know the mapping is non-null and points to an
-- 
2.17.1

