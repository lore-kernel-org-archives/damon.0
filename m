Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D053D2FE6
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407459; cv=none; b=SgDLOfpBLZI+wWVWV/xPyHqF6pC0eOwy+tDzlralN2ZoZiJFaOQ/mHPa/VeZiKwnrCZ2QLJoAnYbyOIguZ3D0n0c6x7C7FY/2bEPMuyO+FHatLk3QnPvZ7zFEIm75Q44AWaPNXgRqckiWL+JxafMbNa709GMUA2xHiJXBk+TQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407459; c=relaxed/simple;
	bh=NCeN+XjamdXRlv4aSYJ4/A5Aw4jYENapGFozitIo3Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eahGHVBMTtFo8DFfl2WphtOMRL0PVTbni0ZUKcdkOjHQbJV8wOrRUukag8jYcdHEjyrb6nKuMi2DzsMBcslHTrEr2jEyc4SXL2DbKticVUWKKxdPh62sM4JqUI23PC1FqccdoJSz85qOmUOI3tB4+S6DVb2qTwI+O3+FkaiGnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW001.hihonor.com (unknown [10.77.229.151])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4gvWnG5QqZzYmSQd;
	Tue,  7 Jul 2026 14:40:18 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW001.hihonor.com
 (10.77.229.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 7 Jul
 2026 14:40:18 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:18 +0800
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
Subject: [RFC PATCH v2 04/13] mm: implement anon_node_clone for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:32:59 +0800
Message-ID: <20260707063308.29176-5-tao.wangtao@honor.com>
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

Prefer using anon_node for tracking in anon_node_clone.
If the VMA is remapped or the VMA count exceeds
ANON_RMAP_BASE_COUNT_MAX, create a child anon_node.

Newly created anon_node are inserted at the tail of the rbc children.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/rmap.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index b98ba6a83272..74817876107a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -703,6 +703,91 @@ int __anon_node_prepare(struct vm_area_struct *vma)
 	return 0;
 }
 
+static inline struct anon_node *vma_anon_node(struct vm_area_struct *vma)
+{
+	return vma ? (struct anon_node *)vma->anon_vma : NULL;
+}
+
+static inline void vma_set_anon_node(struct vm_area_struct *vma,
+		struct anon_node *anon_nod, bool is_locked)
+{
+	struct rw_semaphore *rmap_sem = anon_node_rmap_sem(anon_nod);
+
+	if (is_locked) {
+		vma->anon_vma = (struct anon_vma *)anon_nod;
+		return;
+	}
+	down_write(rmap_sem);
+	vma->anon_vma = (struct anon_vma *)anon_nod;
+	up_write(rmap_sem);
+}
+
+static int anon_node_add_child(struct anon_node *anon_nod,
+	struct vm_area_struct *vma, bool is_fork)
+{
+	struct anon_node *child;
+	struct anon_node *root = anon_nod->root;
+	struct rw_semaphore *rmap_sem = anon_node_rmap_sem(root);
+	struct anon_node *rbc_ch = anon_nod, *next;
+
+	if (root->depth == 0)
+		root->depth = 1;
+	child = anon_node_alloc(vma, anon_nod, is_fork);
+	if (!child)
+		return -ENOMEM;
+
+	rmap_sem = anon_node_rmap_sem(root);
+	down_write(rmap_sem);
+	/* Add new child to the tail of rbc children. */
+	while ((next = anon_node_next_rbc_child(anon_nod, rbc_ch)) != NULL) {
+		rbc_ch = next;
+	}
+	list_add(&child->fractal_list, &rbc_ch->fractal_list);
+	++anon_nod->nr_children;
+
+	if (is_fork)
+		vma_set_anon_node(vma, child, true);
+	up_write(rmap_sem);
+	return 0;
+}
+
+/* Returns 0 on success, non-zero on failure. */
+static int anon_node_track_rmap(struct anon_node *anon_nod,
+		struct vm_area_struct *vma)
+{
+	struct rw_semaphore *rmap_sem = anon_node_rmap_sem(anon_nod);
+	unsigned long rmap_base = vma_rmap_base(vma);
+	struct anon_node *rbc_ch = anon_nod;
+
+	if (try_track_rmap(anon_nod, rmap_base))
+		return 0;
+
+	down_read(rmap_sem);
+	while ((rbc_ch = anon_node_next_rbc_child(anon_nod, rbc_ch)) != NULL) {
+		if (try_track_rmap(rbc_ch, rmap_base))
+			break;
+	}
+	up_read(rmap_sem);
+	if (rbc_ch)
+		return 0;
+
+	return anon_node_add_child(anon_nod, vma, false);
+}
+
+/* vma clones src anon_node and increments the count. */
+int anon_node_clone(struct vm_area_struct *vma,  struct vm_area_struct *src,
+	enum vma_operation operation)
+{
+	struct anon_node *anon_nod = vma_anon_node(src);
+
+	mmap_assert_write_locked(vma->vm_mm);
+	if (!anon_nod)
+		return 0;
+
+	VM_BUG_ON_VMA(vma->anon_vma != (void *)anon_nod, vma);
+	return anon_node_track_rmap(anon_nod, vma);
+}
+
 #endif
 
 /*
-- 
2.17.1

