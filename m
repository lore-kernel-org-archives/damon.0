Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFD3F2113
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880092; cv=none; b=LGn0WkpEDDetLrDcI57k3wbpdbvlrwVmsXl9Piom2JoF7D/Dyko1TGCKiDlN1rLnQmshGGgu0deZ3mdzZCK/lF5EwwyadOysO2BqzUVJWIZE6cNpIeMdHMKMdUuL4LmokI5/DiAusJcLuhMd3B48qMgepQqHyuj7ikBMcT2ecV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880092; c=relaxed/simple;
	bh=1hgIUguGCCpbntdhLkJvhmWf5z8Ow+vvXzLBm83l/RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAVOL4KwSv5e3dWGPtflPQkdmtqyFow3UMP0cDrQ0HbUq6FqZOducDxuXPCwnIA6ZfdODhu2cbs1Y4kWar3Z+j5WKPYnfQkrcR+V+skj8qefR32ebwjb5koGAnA6sjtwzLq/wTbDKS70oSzYhr307pjE/P5AQpgaBkY6Dsd3ny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=CPeVKOpq; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="CPeVKOpq"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=fr1wwam3yXWGP8K5xNNCiXv/Wq2ATv+XGc7BKR2rebs=;
	b=CPeVKOpqx4CAIv+0r/KaD2lvQPXbCeVU1t1dn/zmUNc6wbj67qGdXOhRJx9dzIoUjTdL1wyiB
	NvTLHdG/CXjDMAJl6IngyK6ubbSoJJbGk6nHNSIH1ezZfUHuQRRvCuXjbuZ6kFvQJNLjFis6HH9
	DDHx9on4j4VZNX+dN2rduGM=
Received: from TW004-1.hihonor.com (unknown [10.77.232.85])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gQRdh5qnGzYl1Gk;
	Wed, 27 May 2026 19:06:48 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW004-1.hihonor.com
 (10.77.232.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:04 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:03 +0800
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
Subject: [PATCH 14/15] mm: support merging of ANON_VMA_LAZY VMAs
Date: Wed, 27 May 2026 19:01:46 +0800
Message-ID: <20260527110147.17815-15-tao.wangtao@honor.com>
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

Allow ANON_VMA_LAZY VMAs to merge if they share the same root or if one
side has no root.
For ANON_VMA_LAZY merges, do not delete the lazy root VMA. The lazy root
VMA may still be referenced by folio->mapping.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/vma.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 0a31ef82a90c..ae1047dcfbc2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -76,9 +76,10 @@ static bool vma_is_fork_child(struct vm_area_struct *vma)
 	/*
 	 * The list_is_singular() test is to avoid merging VMA cloned from
 	 * parents. This can improve scalability caused by the anon_vma root
-	 * lock.
+	 * lock. ANON_VMA_TREE_VMA has no anon_vma_chain.
 	 */
-	return vma && vma->anon_vma && !list_is_singular(&vma->anon_vma_chain);
+	return vma && vma->anon_vma && !anon_vma_tree_is_vma(vma->anon_vma) &&
+		 !list_is_singular(&vma->anon_vma_chain);
 }
 
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
@@ -776,6 +777,17 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 	return !vma->vm_ops || !vma->vm_ops->close;
 }
 
+/*
+ * The ANON_VMA_LAZY root VMA may still be referenced by folio->mapping.
+ * Keeping the root avoids allocating an extra VMA.
+ */
+#define SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, delete_vma) do { \
+	if (anon_vma_lazy_enabled()) { \
+		if (delete_vma && vma_is_anon_vma_lazy_root(delete_vma)) \
+			swap(vmg->target, delete_vma); \
+	} \
+} while (0)
+
 /*
  * vma_merge_existing_range - Attempt to merge VMAs based on a VMA having its
  * attributes modified.
@@ -933,12 +945,15 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		vmg->end = next->vm_end;
 		vmg->pgoff = prev->vm_pgoff;
 
+		SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, middle);
+		SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, next);
+
 		/*
 		 * We already ensured anon_vma compatibility above, so now it's
 		 * simply a case of, if prev has no anon_vma object, which of
 		 * next or middle contains the anon_vma we must duplicate.
 		 */
-		err = dup_anon_vma(prev, next->anon_vma ? next : middle,
+		err = dup_anon_vma(vmg->target, next->anon_vma ? next : middle,
 				   &anon_dup);
 	} else if (merge_left) {
 		/*
@@ -954,8 +969,10 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 
 		if (!vmg->__remove_middle)
 			vmg->__adjust_middle_start = true;
+		else
+			SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, middle);
 
-		err = dup_anon_vma(prev, middle, &anon_dup);
+		err = dup_anon_vma(vmg->target, middle, &anon_dup);
 	} else { /* merge_right */
 		/*
 		 *     |<------------->| OR
@@ -974,6 +991,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		if (vmg->__remove_middle) {
 			vmg->end = next->vm_end;
 			vmg->pgoff = next->vm_pgoff - pglen;
+			SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, middle);
 		} else {
 			/* We shrink middle and expand next. */
 			vmg->__adjust_next_start = true;
@@ -982,7 +1000,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 			vmg->pgoff = middle->vm_pgoff;
 		}
 
-		err = dup_anon_vma(next, middle, &anon_dup);
+		err = dup_anon_vma(vmg->target, middle, &anon_dup);
 	}
 
 	if (err || commit_merge(vmg))
@@ -1212,6 +1230,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 
 		vma_start_write(next);
 		vmg->__remove_next = true;
+		SWAP_VMG_TARGET_IF_DELETE_ANON_VMA_LAZY_ROOT(vmg, next);
 
 		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
 		vma_flags_set_mask(&sticky_flags, next_sticky);
-- 
2.17.1

