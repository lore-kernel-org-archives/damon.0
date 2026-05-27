Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12323F8ED3
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880089; cv=none; b=GJ7wyQUd/12QXiv4JMT+2uL6+6xPF+3swbBZiLP05Qj2c1N78gEm/Rzmv+Ud7Vc5wh3sL3YMD8gDI68gqUlNvUYGwsZLQF9OD8/1hniMCDa2MrUJTwh+iK2kf4vU5fS1Pvf2AQAG9UWsmfLC34KF6QLY1YL4gmOPnCbWI5YP6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880089; c=relaxed/simple;
	bh=3EcCp4Gw030E4P+Z/BQF5V4KmCi7yOeuuHKsvzHSxOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxtEMof8dwWKClL4acPNx1uOisQOkpQqBEzZoDzG89Xh9kZ7+sJNuqWSihSS3gvbVh2b2wh8RPSRUaismqiifEAbQx/oIAxruJ3opVm7SlWGpcZIxpvyOmkVFj8T1MzNUvIq/ZtQIAFs5lRLZbHW9Kux710X+mS0mttUfMg9A2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=j6PuxmT0; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="j6PuxmT0"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=B/D3Hq7FcaguQsGLfZNTY7RVE4zbG/cH9UzpMbWmWQk=;
	b=j6PuxmT0nB/SvuBB1nifbsqSH66ihs0KrqETIo5mxMj7mFxKHZ1P+hYlUtEehfjRZ1u1tCRq/
	jHjTRLa2cHvCdDJ3NvQz5ky5jztpwpx4WwiI4DyXSArFCA6y5DVIHkv7EAavcWiCFcfQ8I7t9a/
	MpcdBKwc4Aif1G4/JDZDpeQ=
Received: from TW003.hihonor.com (unknown [10.77.199.161])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gQRdg003JzYl1Gk;
	Wed, 27 May 2026 19:06:46 +0800 (CST)
Received: from TA003.hihonor.com (10.72.0.43) by TW003.hihonor.com
 (10.77.199.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:07:58 +0800
Received: from localhost.localdomain (10.144.18.117) by TA003.hihonor.com
 (10.72.0.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 19:08:01 +0800
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
Subject: [PATCH 11/15] mm: handle ANON_VMA_LAZY in huge page operations
Date: Wed, 27 May 2026 19:01:43 +0800
Message-ID: <20260527110147.17815-12-tao.wangtao@honor.com>
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

When splitting a huge page, the folio needs to be converted into multiple
subpages. Holding only folio_lock(folio) cannot guarantee that the split
operation completes atomically.

Check and upgrade anon_vma during huge page allocation and collapse to
ensure the anon_vma is properly protected.

Signed-off-by: tao <tao.wangtao@honor.com>
---
 mm/internal.h   |  5 +++++
 mm/khugepaged.c |  5 +++++
 mm/memory.c     | 17 +++++++++++++----
 mm/rmap.c       | 15 +++++++++++----
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0a36eba3f63c..a746f5272aa6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -419,6 +419,11 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma);
 int  __anon_vma_prepare(struct vm_area_struct *vma);
 /* Called on first anon fault or from anon_vma_prepare(). */
 void vma_prepare_anon_vma_lazy(struct vm_area_struct *vma);
+/*
+ * Upgrade VMA ANON_VMA_LAZY to a regular anon_vma during fork, or when
+ * cloning ANON_VMA_TREE_PARENT or a hugepage VMA.
+ */
+int vma_upgrade_anon_vma_lazy(struct vm_area_struct *vma);
 void unlink_anon_vmas(struct vm_area_struct *vma);
 
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 747748eace91..a33cda026be7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1164,6 +1164,11 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	/* Upgrade anon_vma_lazy to protect the anon_vma. */
+	if (vma_upgrade_anon_vma_lazy(vma)) {
+		result = SCAN_FAIL;
+		goto out_up_write;
+	}
 	anon_vma_tree_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
diff --git a/mm/memory.c b/mm/memory.c
index 8fd3877f69fb..26d116b3393c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3819,19 +3819,28 @@ vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
+	bool maybe_huge = pmd_none(*vmf->pmd);
 
-	if (likely(vma->anon_vma))
-		return 0;
-	if (anon_vma_lazy_enabled()) {
+	if (likely(vma->anon_vma)) {
+		if (!vma_is_anon_vma_lazy(vma) || !maybe_huge)
+			return 0;
+	}
+#ifdef CONFIG_ANON_VMA_LAZY
+	if (anon_vma_lazy_enabled() && !maybe_huge) {
 		vma_prepare_anon_vma_lazy(vma);
 		return 0;
 	}
+#endif
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		if (!mmap_read_trylock(vma->vm_mm))
 			return VM_FAULT_RETRY;
 	}
-	if (__anon_vma_prepare(vma))
+	if (!vma->anon_vma  && __anon_vma_prepare(vma))
+		ret = VM_FAULT_OOM;
+#ifdef CONFIG_ANON_VMA_LAZY
+	if (vma->anon_vma && maybe_huge && vma_upgrade_anon_vma_lazy(vma))
 		ret = VM_FAULT_OOM;
+#endif
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
 		mmap_read_unlock(vma->vm_mm);
 	return ret;
diff --git a/mm/rmap.c b/mm/rmap.c
index d9424f4eb6d0..57cd85efc50a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -452,13 +452,20 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	return vma_prepare_anon_vma(vma, false, NULL);
 }
 
-static int vma_upgrade_anon_vma_lazy(struct vm_area_struct *vma)
+/**
+ * vma_upgrade_anon_vma_lazy - upgrade a VMA's lazy anon_vma to a regular one
+ * @vma: the VMA whose anon_vma_lazy is being upgraded
+ */
+int vma_upgrade_anon_vma_lazy(struct vm_area_struct *vma)
 {
-	anon_vma_tree_t vma_tree = vma->anon_vma;
+	anon_vma_tree_t anon_tree = READ_ONCE(vma->anon_vma);
 	struct anon_vma *parent_anon_vma = NULL;
 
-	if (anon_vma_tree_is_parent(vma_tree))
-		parent_anon_vma = anon_vma_tree_anon_vma(vma_tree);
+	VM_BUG_ON_VMA(!anon_tree, vma);
+	if (!anon_vma_tree_type(anon_tree))
+		return 0;
+	if (anon_vma_tree_is_parent(anon_tree))
+		parent_anon_vma = anon_vma_tree_anon_vma(anon_tree);
 	return vma_prepare_anon_vma(vma, true, parent_anon_vma);
 }
 
-- 
2.17.1

