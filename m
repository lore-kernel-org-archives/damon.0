Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BF3ED5A2
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881211; cv=none; b=GANG6s5nEXHbNKy2gg3C4j3VhT1V3JghsjRSgGlaF4DMZl6t9jsgiuHpvMO7e8Hwm2VenJu4wOMWNPwz0kMQjbS5QpIa26I19tHUORgmuxZh7qkiVHyuujGGGwx/WU60EMLT3brdFkkz6LwOCzAUhPaIeXXG5+oKAnYuxps8ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881211; c=relaxed/simple;
	bh=sFTjpTy9jS1J6p+gZVpzAXiVY7b1vJQet9M2pL8BGtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdlemqD8VPdscQAKFIZPJDPHY8B8GaAdw8OXKdDpyL/BizL6ZAp4bRnJvWPSa65vmfrG0JXWR1y30Iw2xezvrJsM6ZsWD/PQRwp6pE5niV4GAUt5tx7+M8lCVht0iTzjNMCwR+l8gNboRzVOqZETMxxGiVSOHFHM9AqsNM30jgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from TW002-1.hihonor.com (unknown [10.72.0.137])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4gQRdL5rLWzYkxQN;
	Wed, 27 May 2026 19:06:30 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW002-1.hihonor.com
 (10.72.0.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:57 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:56 +0800
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
Subject: [PATCH 03/15] mm: introduce anon_vma_tree_t for multiple anon_vma topologies
Date: Wed, 27 May 2026 19:01:35 +0800
Message-ID: <20260527110147.17815-4-tao.wangtao@honor.com>
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

Prepare for upcoming ANON_VMA_LAZY support and RCU-based lockless rmap
traversal by clearly separating anon_vma topology handling from the
anon_rmap semantics.

Prepare for supporting multiple anon_vma topologies by introducing
lightweight abstractions used by the VMA and rmap code.

Introduce anon_vma_tree_t as the type stored in vma->anon_vma:

    typedef unsigned long anon_vma_tree_t;

It represents a tagged pointer encoding a reference to the anon_vma
topology. The low bits are reserved as type tags to distinguish
different implementations (e.g. regular anon_vma and lazy anon_vma).
This keeps the VMA representation compact while allowing the topology
to evolve without changing the VMA layout.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 include/linux/mm_types.h |  3 +++
 mm/internal.h            | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..5f4961ea1572 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -917,6 +917,9 @@ struct vm_area_desc {
 	struct mmap_action action;
 };
 
+/* Tagged pointer stored in vma->anon_vma. Low bits encode anon_vma type. */
+typedef unsigned long anon_vma_tree_t;
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b..76544ad44ff0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -246,6 +246,60 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
 	up_read(&anon_vma->root->rwsem);
 }
 
+/* anon_vma_tree_t APIs */
+
+static inline anon_vma_tree_t make_anon_vma_tree(struct anon_vma *anon_vma)
+{
+	return (anon_vma_tree_t)anon_vma;
+}
+
+static inline struct anon_vma *anon_vma_tree_anon_vma(anon_vma_tree_t anon_tree)
+{
+	return (struct anon_vma *)anon_tree;
+}
+
+static inline void anon_vma_tree_lock_write(anon_vma_tree_t anon_tree)
+{
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	anon_vma_lock_write(anon_vma);
+}
+
+static inline int anon_vma_tree_trylock_write(anon_vma_tree_t anon_tree)
+{
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	return anon_vma_trylock_write(anon_vma);
+}
+
+static inline void anon_vma_tree_unlock_write(anon_vma_tree_t anon_tree)
+{
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	anon_vma_unlock_write(anon_vma);
+}
+
+static inline void anon_vma_tree_lock_read(anon_vma_tree_t anon_tree)
+{
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	anon_vma_lock_read(anon_vma);
+}
+
+static inline int anon_vma_tree_trylock_read(anon_vma_tree_t anon_tree)
+{
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	return anon_vma_trylock_read(anon_vma);
+}
+
+static inline void anon_vma_tree_unlock_read(anon_vma_tree_t anon_tree)
+{
+	struct anon_vma *anon_vma = anon_vma_tree_anon_vma(anon_tree);
+
+	anon_vma_unlock_read(anon_vma);
+}
+
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
 /* Operations which modify VMAs. */
-- 
2.17.1

