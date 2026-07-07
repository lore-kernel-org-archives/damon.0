Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A873D413C
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407461; cv=none; b=o8sVK+rsiVHa2DDecR/Qz54WYgBtq37EupB2XKRlLUAvu4ERuKFU9802MHOBVA3ZAup4bl6ozWsHOfBKk0tUotOY6WLQGrz9mFgckc4bsZZc4sqK6wZVLG+4NOTDVud7eqv/Lx4NfnH41De0ibK/kByJfFgKV7aQLrpx/RZa1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407461; c=relaxed/simple;
	bh=Z6vrAQ88YznWb6LkpzsyFzTG0k8B3sx3ey6wPhXijik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ng6a63CkPMy0bd9/T2+gbeQAnEa5R/9uv2tRm+2knAv/YFhh28lcqZKohnZM1MshJChB19gTbH+hAo3SdTfgJNLpqWb9KN7K/5Bbioap9sQc5CZYYPMp9CiJ45bnJ1qeeqmTGC+ZlSXJbYU/wSgEWJZn7sUqOvH8CqlvjOh2smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW004-1.hihonor.com (unknown [10.77.232.85])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gvWnH2XkwzYm5Zg;
	Tue,  7 Jul 2026 14:40:19 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW004-1.hihonor.com
 (10.77.232.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 14:40:19 +0800
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
Subject: [RFC PATCH v2 06/13] mm: implement unlink_anon_nodes for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:33:01 +0800
Message-ID: <20260707063308.29176-7-tao.wangtao@honor.com>
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

Detaching an anon_node may require traversing or removing it from the
fractal list, so the lock must be held.

Releasing an anon_node may propagate through the parent chain, while
the actual release can be performed outside the lock.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/rmap.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 93fa04c5a007..ea3557d3b56c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -859,6 +859,94 @@ int anon_node_fork_with_prev(struct vm_area_struct *vma,
 	return anon_node_add_child(parent, vma, true);
 }
 
+/* Returns true if untrack succeeds. */
+static bool anon_node_untrack_rmap_locked(struct anon_node *anon_nod,
+		struct vm_area_struct *vma, struct anon_node **release_node)
+{
+	struct anon_node *root = anon_nod->root;
+	struct anon_node *node = anon_nod;
+	struct anon_node *empty_nod = NULL;
+	bool test_empty = false;
+
+	do {
+		if (try_untrack_rmap(node, vma_rmap_base(vma), &test_empty))
+			break;
+		node = anon_node_next_rbc_child(anon_nod, node);
+	} while (node);
+
+	if (!test_empty) {
+		VM_BUG_ON_VMA(!node, vma);
+		return (bool)node;
+	}
+
+	if (node->nr_children == 0)
+		empty_nod = node;
+	else if (node == anon_nod) {
+		/* Replace an rbc child. */
+		node = anon_node_next_rbc_child(anon_nod, anon_nod);
+		if (node && try_reuse_anon_node(anon_nod,
+						atomic_long_read(&node->rbc))) {
+			atomic_long_set(&node->rbc, 0);
+			empty_nod = node;
+		}
+	}
+	/* may be released up the parent chain */
+	*release_node = empty_nod;
+	while (empty_nod && empty_nod != root) {
+		struct anon_node *parent = empty_nod->parent;
+
+		/* delete the empty_nod first, release later. */
+		list_del_init(&empty_nod->fractal_list);
+		empty_nod->mm = NULL;
+		if (--parent->nr_children == 0 && !anon_node_rmap_count(parent))
+			empty_nod = parent;
+		else {
+			empty_nod->parent = NULL;
+			break;
+		}
+	}
+	return true;
+}
+
+static void release_anon_nodes(struct anon_node *anon_nod)
+{
+	struct anon_node *root = anon_nod->root;
+
+	while (anon_nod) {
+		struct anon_node *parent = anon_nod->parent;
+
+		put_anon_node(anon_nod);
+		anon_nod = (anon_nod != root) ? parent : NULL;
+	}
+}
+
+/* Remove link between this VMA and its anon_node. */
+void unlink_anon_nodes(struct vm_area_struct *vma)
+{
+	struct anon_node *anon_nod = vma_anon_node(vma);
+	struct rw_semaphore *rmap_sem;
+	struct anon_node *release_node = NULL;
+
+	/* Always hold mmap lock, read-lock on unmap possibly. */
+	mmap_assert_locked(vma->vm_mm);
+
+	/* Unfaulted */
+	if (!anon_nod)
+		return;
+
+	rmap_sem = anon_node_rmap_sem(anon_nod->root);
+	down_write(rmap_sem);
+	anon_nod = vma_anon_node(vma); /* Recheck after locking. */
+	if (anon_nod) {
+		anon_node_untrack_rmap_locked(anon_nod, vma, &release_node);
+		vma->anon_vma = NULL;
+	}
+	up_write(rmap_sem);
+
+	if (release_node)
+		release_anon_nodes(release_node);
+}
+
 
 #endif
 
-- 
2.17.1

