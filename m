Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95D385D8B
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407461; cv=none; b=Uk2eXyO4x8Z3H+dkXsbB4sQ5MeYUBer7ChT2d9iRLVyd1NgiVOpvyyuKB7gCZjm9M6c+j5kb6BQdPvbwTkonaatV//rUdqYltdQ7ExIoxajznRCDF02573XMZ1g55ar1uwvjQ+yWU+UQQUAZmipyTQ4b4oZ1RECDLTcTBY7Dj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407461; c=relaxed/simple;
	bh=LyNVozLq8/ZnLFj3fReKD56dwCtjRBT0y1oDo2YKZjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeKeYym7x51GfO73THRlnjtJKye1hscnKYo4jdZOmPOpOloHbN0ptChC3d45mpAz3Jl/GqfEWhRM4wFqc3hYkaweWEz4CAYV6Pv4q+cDzlJbEO5Bx93wVZ3OsZGdVG4TBqI16iQhjnyTzmOg3i6/2oMulvG0cI5yUv0EF2jSeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW003.hihonor.com (unknown [10.77.199.161])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gvWnG3lZLzYm43k;
	Tue,  7 Jul 2026 14:40:18 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW003.hihonor.com
 (10.77.199.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 14:40:16 +0800
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
Subject: [RFC PATCH v2 03/13] mm: implement __anon_node_prepare for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:32:58 +0800
Message-ID: <20260707063308.29176-4-tao.wangtao@honor.com>
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

Add anon_node APIs corresponding to existing anon_vma operations:

- anon_node_clone() corresponds to anon_vma_clone()
- __anon_node_prepare() corresponds to __anon_vma_prepare()
- anon_node_fork_with_prev() corresponds to anon_vma_fork()
- unlink_anon_nodes() corresponds to unlink_anon_vmas()

Implement __anon_node_prepare() first to keep the patch small.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/internal.h | 11 ++++++++++
 mm/rmap.c     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index c1b3961b9d3e..710baf02575b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -314,6 +314,17 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma);
 int  __anon_vma_prepare(struct vm_area_struct *vma);
 void unlink_anon_vmas(struct vm_area_struct *vma);
 
+#ifdef CONFIG_ANON_VMA_FRACTAL
+int anon_node_clone(struct vm_area_struct *vma, struct vm_area_struct *src,
+	enum vma_operation operation);
+int anon_node_fork_with_prev(struct vm_area_struct *vma,
+	struct vm_area_struct *pvma, struct vm_area_struct *vma_prev,
+	struct vm_area_struct *pvma_prev);
+int __anon_node_prepare(struct vm_area_struct *vma);
+void unlink_anon_nodes(struct vm_area_struct *vma);
+
+#endif
+
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
 	if (likely(vma->anon_vma))
diff --git a/mm/rmap.c b/mm/rmap.c
index fa9d82271005..b98ba6a83272 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -645,6 +645,64 @@ static inline struct anon_node *anon_node_alloc(struct vm_area_struct *vma,
 	return anon_nod;
 }
 
+static bool try_track_rmap(struct anon_node *anon_nod, unsigned long rmap_base)
+{
+	const unsigned long rbc_max = rmap_base + ANON_RMAP_BASE_COUNT_MAX;
+
+	return rmap_base == anon_node_rmap_base(anon_nod) &&
+		atomic_long_add_unless(&anon_nod->rbc, 1, rbc_max);
+}
+
+static inline bool try_untrack_rmap(struct anon_node *anon_nod,
+		unsigned long rmap_base, bool *test_empty)
+{
+	const unsigned long rbc_max = rmap_base + ANON_RMAP_BASE_COUNT_MAX;
+	unsigned long rbc = atomic_long_read(&anon_nod->rbc);
+
+	if (rbc > rmap_base && rbc <= rbc_max) {
+		rbc = atomic_long_dec_return(&anon_nod->rbc);
+		*test_empty = (rbc == rmap_base);
+		return true;
+	}
+	return false;
+}
+
+/* attach an anon_node to the VMA. */
+int __anon_node_prepare(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long rmap_base = vma_rmap_base(vma);
+	struct anon_node *anon_nod;
+	struct anon_vma *anon_old = NULL, *anon_new;
+	bool test_empty = false;
+
+	mmap_assert_locked(mm);
+	might_sleep();
+
+	anon_nod = NULL; /* Fix find_mergeable_anon_vma(vma) later. */
+	if (anon_nod) {
+		anon_new = (struct anon_vma *)anon_nod;
+		if (try_track_rmap(anon_nod, rmap_base) &&
+		    !try_cmpxchg(&vma->anon_vma, &anon_old, anon_new))
+			try_untrack_rmap(anon_nod, rmap_base, &test_empty);
+		if (vma->anon_vma)
+			return 0;
+	}
+
+	anon_nod = anon_node_alloc(vma, NULL, false);
+	if (unlikely(!anon_nod))
+		return -ENOMEM;
+
+	anon_new = (struct anon_vma *)anon_nod;
+	/* maybe prepared by another thread */
+	if (!try_cmpxchg(&vma->anon_vma, &anon_old, anon_new)) {
+		try_untrack_rmap(anon_nod, rmap_base, &test_empty);
+		put_anon_node(anon_nod);
+	}
+
+	return 0;
+}
+
 #endif
 
 /*
-- 
2.17.1

