Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E323AA4E3
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406432; cv=none; b=mD7lZjvy+9aSokErJMFseBFHgyv6De/fReaYX94uhdCyqATSvJjxmatbpE8wUrwbea0ucOqlTGH+LEttRG1iUV3ePnBlM49jkEQVDMjDYArO4JuhIc2XVRUR8fHPW+T7aH4ienJCDWZ0QWlVafjZlSCfI7gfK10iwy4PJrAuAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406432; c=relaxed/simple;
	bh=Wp+tuwt1A/XVubwx/TCx1nOuSk6erQtT0+uDgSBXI2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYt23weTuyPGVMqElTsN7n1AU5gbjIElE1dXSKg55fzajYSGjwOCb+EsaxbM0hGUP14NitqYAlWh4RKy6ErsU6fiTGXHXWa3yr/gHybws0a6Qpc9zsvrI5cUNdD1yQqjy4CX2zqLFTstlSgdrmSLfj2/83tAlcm5Gp/XRjRZlWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=W+rm16pI; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="W+rm16pI"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=2HAQWJ3pVwWfob9ODqC/Kr1JqfriaUqoCgw5Fb97ovc=;
	b=W+rm16pI01FqtDtqFMYMSfa+ApAyTpe0XPZq3wSew34VUomsQ5Z38SmDdLwIE9QlWhhEVdpcA
	893xUhztJ0YcExPDl1Ioi+xR5VoNJ4hPCJ9JRhKS/wLhu5pd8mtwlFTEF4t4fhjKTxFWhJgN+3y
	uVHrTwHvP35Hm0vNQ4FwpEM=
Received: from TW006-1.hihonor.com (unknown [10.77.215.153])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gvWnH0THRzYl1nh;
	Tue,  7 Jul 2026 14:40:19 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW006-1.hihonor.com
 (10.77.215.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
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
Subject: [RFC PATCH v2 05/13] mm: implement anon_node_fork_with_prev for ANON_VMA_FRACTAL
Date: Tue, 7 Jul 2026 14:33:00 +0800
Message-ID: <20260707063308.29176-6-tao.wangtao@honor.com>
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

Fork handling introduces two additional parameters to help child VMAs
clone anon_node. The logic follows three cases:
1) Fast path: clone the anon_node with the previous VMA.
2) Reuse an empty anon_node from an ancestor.
3) Allocate a new anon_node and insert it into fractal_list.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/rmap.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 74817876107a..93fa04c5a007 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -667,6 +667,17 @@ static inline bool try_untrack_rmap(struct anon_node *anon_nod,
 	return false;
 }
 
+static bool try_reuse_anon_node(struct anon_node *anon_nod,
+		unsigned long new_rbc)
+{
+	long old_rbase;
+
+	if (anon_node_rmap_count(anon_nod))
+		return false;
+	old_rbase = anon_node_rmap_base(anon_nod);
+	return atomic_long_try_cmpxchg(&anon_nod->rbc, &old_rbase, new_rbc);
+}
+
 /* attach an anon_node to the VMA. */
 int __anon_node_prepare(struct vm_area_struct *vma)
 {
@@ -788,6 +799,67 @@ int anon_node_clone(struct vm_area_struct *vma,  struct vm_area_struct *src,
 	return anon_node_track_rmap(anon_nod, vma);
 }
 
+static struct anon_node *fork_reuse_ancestor(struct anon_node *parent,
+		struct vm_area_struct *vma)
+{
+	struct anon_node *root = parent->root;
+	struct anon_node *node;
+	unsigned long new_rbc = vma_rmap_base(vma) + 1;
+	/* At least N anon_nodes between parent and root: P -> a1 .. aN -> R */
+	const unsigned int ANON_DEPTH_REUSE_THRESHOLD = 1 + (5 << 1);
+
+	if (parent->depth < ANON_DEPTH_REUSE_THRESHOLD)
+		return NULL;
+
+	/* Release from leaf only; parent is stable, no lock needed. */
+	for (node = parent; node != root; node = node->parent) {
+		if (READ_ONCE(node->nr_children) > 1)
+			continue;
+		/* Replace with the new_rbc atomically. */
+		if (!try_reuse_anon_node(node, new_rbc))
+			continue;
+
+		node->mm = vma->vm_mm;
+		vma_set_anon_node(vma, node, false);
+		return node;
+	}
+
+	return NULL;
+}
+
+/* Clone an anon_node from prev or fork one from the parent pvma. */
+int anon_node_fork_with_prev(struct vm_area_struct *vma,
+	struct vm_area_struct *pvma, struct vm_area_struct *prev,
+	struct vm_area_struct *pvma_prev)
+{
+	struct anon_node *parent = vma_anon_node(pvma);
+	struct anon_node *anon_nod = vma_anon_node(prev);
+	unsigned long rmap_base = vma_rmap_base(vma);
+
+	if (!parent)
+		return 0;
+
+	/* Drop inherited anon_nod. */
+	vma->anon_vma = NULL;
+
+	/* 1) Fast path: clone the anon_node with the previous VMA. */
+	if (anon_nod && pvma_prev && parent == vma_anon_node(pvma_prev)) {
+		if (try_track_rmap(anon_nod, rmap_base)) {
+			vma_set_anon_node(vma, anon_nod, false);
+			return 0;
+		}
+	}
+
+	/* 2) Reuse an existing anon_node. */
+	anon_nod = fork_reuse_ancestor(parent, vma);
+	if (anon_nod)
+		return 0;
+
+	/* 3) Fork a new anon_node. */
+	return anon_node_add_child(parent, vma, true);
+}
+
+
 #endif
 
 /*
-- 
2.17.1

