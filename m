Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5633770B
	for <damon@lists.linux.dev>; Mon, 29 Sep 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759105587; cv=none; b=sx1ibogKnmvP8DYdwRDh/qKG84yOxSi3Qj8zn/iljJrN4BPEbKEAq+g9Lql1CRbjw/ydZsnxvX8JBOF09Y3VySVWtPnVjq3d8kY5B3tv6VJUDs4yG2PFAXwyy34x0Y7TJ3qyzCgXIKoEbIX8MO9bMpYrz99MB4hJiUq01Y2z8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759105587; c=relaxed/simple;
	bh=h0+uacpQmuanoF80PG5i1ultLtnggJa/m5m7vos4QNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeuYF4buG/7Bm4+cT1EuMOxiGuwUTaDY4st9prAGjGVHKF0d9FThu7YF1CaqmprZPN6LtA9mZKBRsALd070ZIkOOx7q9/TU4Cb51kRh4nVGCsPJ6b53anA1tgpr90jj/FNik7pG8JF2INHPTqeudq31Tf5smxwzQMqEx056Xbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdrpNDVE; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdrpNDVE"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-27c369f898fso43996505ad.3
        for <damon@lists.linux.dev>; Sun, 28 Sep 2025 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759105585; x=1759710385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZrb9ZvwMY4YVa3pVe0HMYNnPnxeY8/s3k+/iyrjb1c=;
        b=IdrpNDVE6p9NbB287yCbLWF8LFU1E1XpQRwKaw8bU22AqvzNJKrTGCURuBPQ8UWDm5
         snPhzKr+aqAtYTuwdFldEsEfCmKpXZelPhBw1EEo9+Uw6gyEEWHyBj8NHfNzJRttgbOj
         JRJOWg2+flseC9pSVK+hKIVk0yT6QOfzh0L/4btTiXT8wnQFWB3916g8NWEeAV+IgTpA
         lFrAAd7wQSfbiMZ5xE1VcFDbV342arb7NLVGHzSWxTXacgypfizQqpnIBdW9t9yIV+jL
         /EP/gaqpPNoNOOiUzAKBC7BGFjU7/ZP/Qrp0Rp4TCqmY4ymfdNe+/Dr0/rERpO9I8fAr
         ceXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759105585; x=1759710385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZrb9ZvwMY4YVa3pVe0HMYNnPnxeY8/s3k+/iyrjb1c=;
        b=To/47wLGRjsD8PCEVMo+1Zei4JraK+jYHcFc2oWlCh28Hb1KcC+xU9ieYXeYENDSQP
         CCOo+xJfS+Jx9lr88KmRLOCULi+lViA5nw6FRMm4vN+eiakND7itEE/kl/YtKxsxJRKT
         xNypm2Rqlu/5nPuNeqC7VX4jE8RM5YtFjjbw8PjKOJXTHYtwVbphnay6PFfbTaVya8Ks
         8HweOe9liJR3+GuGX57nFgYJuRlZWnckAYUem8FwNw1yuq4fUQOqJWGTi2wPvgcsrEZ6
         6rVchEeyrXOjZTL+xMB1sRDqiUdeEH7CdDXStNc5Csn0dKODzTnT3RgD8EuOypVw4j1x
         lD/g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1LH5AItLzQtCgNedxgMQyJjp1XE/fQbQ44EtmdowLxEULRi5lvHqk+IJrPXJEu83yv8Y1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKkP/8PkaB5u7thcR57WCmc102IxZj6bpB2zzKPM91uPPGL4UU
	rg7ccI4EJHsj4WWXFrd6h8XZrXfKpeUCmdqIr2LmOzkjU3lKvrOWozG0
X-Gm-Gg: ASbGncvcMFJ7mLRz4/4ge4dlWclYUPaxRV9XQR5C4jZP6cQeEx3b17EK8H9M32/xrR6
	ct6FQo+AsItKAA4ZE3JGaCAngGPElhF7VgU50HMbqn34T7MHub91k80d0mPSFMWBrMS0E6SJkvY
	l7THR5n0LC1U0YZa6cAm8SeBfd61NAOlcaBOtIQd0K3736zgpVzCm1G7up4TtQWL3+Y/m9TlDAX
	8QAjIh40sq7CuqQNjcnYh96el6uer4Jo2E9d7apIKZY2GRZK7ixQrllRxtqxngOBH3mXWyYhhZi
	LNwXNLHmRMklf5xjK74a5gIXVIqUHt1xiNAkgi2Fwtsevd7VJ6j4Or2WHVrFd/EW9rczEVtpoOF
	Uaw/o2WWJACSTfWONO5dOPsl7VdjRz++KFTBYuKLDp6tyeO6AV43vPXAFmP+c2A==
X-Google-Smtp-Source: AGHT+IGrz7KB/SLZGGqdC4PjQh6NI66U1D6gdU3o+zPe+ACkknBSABitdv3/6WSkVWyn8RC6rByWxA==
X-Received: by 2002:a17:902:e806:b0:267:6754:8fd9 with SMTP id d9443c01a7336-27ed4a3cfedmr156764855ad.39.1759105585085;
        Sun, 28 Sep 2025 17:26:25 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882160sm111191395ad.71.2025.09.28.17.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 17:26:24 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: dev.jain@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	bhe@redhat.com,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	cl@gentwo.org,
	damon@lists.linux.dev,
	david@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	harry.yoo@oracle.com,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	jianyungao89@gmail.com,
	kasan-dev@googlegroups.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	nphamcs@gmail.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	shikemeng@huaweicloud.com,
	sj@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	xu.xin16@zte.com.cn
Subject: [PATCH v2] mm: Fix some typos in mm module
Date: Mon, 29 Sep 2025 08:26:08 +0800
Message-Id: <20250929002608.1633825-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
References: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "jianyun.gao" <jianyungao89@gmail.com>

Below are some typos in the code comments:

  intevals ==> intervals
  addesses ==> addresses
  unavaliable ==> unavailable
  facor ==> factor
  droping ==> dropping
  exlusive ==> exclusive
  decription ==> description
  confict ==> conflict
  desriptions ==> descriptions
  otherwize ==> otherwise
  vlaue ==> value
  cheching ==> checking
  exisitng ==> existing
  modifed ==> modified
  differenciate ==> differentiate
  refernece ==> reference
  permissons ==> permissions
  indepdenent ==> independent
  spliting ==> splitting

Just fix it.

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
The fix for typos in the hugetlb sub-module has been added.

 mm/damon/sysfs.c     | 2 +-
 mm/gup.c             | 2 +-
 mm/hugetlb.c         | 6 +++---
 mm/hugetlb_vmemmap.c | 6 +++---
 mm/kmsan/core.c      | 2 +-
 mm/ksm.c             | 2 +-
 mm/memory-tiers.c    | 2 +-
 mm/memory.c          | 4 ++--
 mm/secretmem.c       | 2 +-
 mm/slab_common.c     | 2 +-
 mm/slub.c            | 2 +-
 mm/swapfile.c        | 2 +-
 mm/userfaultfd.c     | 2 +-
 mm/vma.c             | 4 ++--
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c96c2154128f..25ff8bd17e9c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1232,7 +1232,7 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS: Update the tuned monitoring
-	 * intevals.
+	 * intervals.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
 	/*
diff --git a/mm/gup.c b/mm/gup.c
index 0bc4d140fc07..6ed50811da8f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2730,7 +2730,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  *
  *  *) ptes can be read atomically by the architecture.
  *
- *  *) valid user addesses are below TASK_MAX_SIZE
+ *  *) valid user addresses are below TASK_MAX_SIZE
  *
  * The last two assumptions can be relaxed by the addition of helper functions.
  *
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eed59cfb5d21..3420711a81d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2954,7 +2954,7 @@ typedef enum {
 	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
 	 * that currently vma_needs_reservation() has an unwanted side
 	 * effect to either use end() or commit() to complete the
-	 * transaction.	 Hence it needs to differenciate from NEEDED.
+	 * transaction. Hence it needs to differentiate from NEEDED.
 	 */
 	MAP_CHG_ENFORCED = 2,
 } map_chg_state;
@@ -5998,7 +5998,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/*
 	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
 	 * could defer the flush until now, since by holding i_mmap_rwsem we
-	 * guaranteed that the last refernece would not be dropped. But we must
+	 * guaranteed that the last reference would not be dropped. But we must
 	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
 	 * dropped and the last reference to the shared PMDs page might be
 	 * dropped as well.
@@ -7179,7 +7179,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		} else if (unlikely(is_pte_marker(pte))) {
 			/*
 			 * Do nothing on a poison marker; page is
-			 * corrupted, permissons do not apply.  Here
+			 * corrupted, permissions do not apply. Here
 			 * pte_marker_uffd_wp()==true implies !poison
 			 * because they're mutual exclusive.
 			 */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba0fb1b6a5a8..96ee2bd16ee1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -75,7 +75,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 	if (likely(pmd_leaf(*pmd))) {
 		/*
 		 * Higher order allocations from buddy allocator must be able to
-		 * be treated as indepdenent small pages (as they can be freed
+		 * be treated as independent small pages (as they can be freed
 		 * individually).
 		 */
 		if (!PageReserved(head))
@@ -684,7 +684,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		ret = hugetlb_vmemmap_split_folio(h, folio);
 
 		/*
-		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * Splitting the PMD requires allocating a page, thus let's fail
 		 * early once we encounter the first OOM. No point in retrying
 		 * as it can be dynamically done on remap with the memory
 		 * we get back from the vmemmap deduplication.
@@ -715,7 +715,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
-		 * This can occur in the case that both spliting fails
+		 * This can occur in the case that both splitting fails
 		 * halfway and head page allocation also failed. In this
 		 * case __hugetlb_vmemmap_optimize_folio() would free memory
 		 * allowing more vmemmap remaps to occur.
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 1ea711786c52..1bb0e741936b 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -33,7 +33,7 @@ bool kmsan_enabled __read_mostly;
 
 /*
  * Per-CPU KMSAN context to be used in interrupts, where current->kmsan is
- * unavaliable.
+ * unavailable.
  */
 DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..edd6484577d7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -389,7 +389,7 @@ static unsigned long ewma(unsigned long prev, unsigned long curr)
  * exponentially weighted moving average. The new pages_to_scan value is
  * multiplied with that change factor:
  *
- *      new_pages_to_scan *= change facor
+ *      new_pages_to_scan *= change factor
  *
  * The new_pages_to_scan value is limited by the cpu min and max values. It
  * calculates the cpu percent for the last scan and calculates the new
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0382b6942b8b..f97aa5497040 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -519,7 +519,7 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 	 * for each device getting added in the same NUMA node
 	 * with this specific memtype, bump the map count. We
 	 * Only take memtype device reference once, so that
-	 * changing a node memtype can be done by droping the
+	 * changing a node memtype can be done by dropping the
 	 * only reference count taken here.
 	 */
 
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..d6b0318df951 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4200,7 +4200,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * If we want to map a page that's in the swapcache writable, we
 	 * have to detect via the refcount if we're really the exclusive
 	 * user. Try freeing the swapcache to get rid of the swapcache
-	 * reference only in case it's likely that we'll be the exlusive user.
+	 * reference only in case it's likely that we'll be the exclusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
 		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
@@ -5274,7 +5274,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 
 /**
  * set_pte_range - Set a range of PTEs to point to pages in a folio.
- * @vmf: Fault decription.
+ * @vmf: Fault description.
  * @folio: The folio that contains @page.
  * @page: The first page to create a PTE for.
  * @nr: The number of PTEs to create.
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..a350ca20ca56 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -227,7 +227,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	struct file *file;
 	int fd, err;
 
-	/* make sure local flags do not confict with global fcntl.h */
+	/* make sure local flags do not conflict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
 	if (!secretmem_enable || !can_set_direct_map())
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bfe7c40eeee1..9ab116156444 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -256,7 +256,7 @@ static struct kmem_cache *create_cache(const char *name,
  * @object_size: The size of objects to be created in this cache.
  * @args: Additional arguments for the cache creation (see
  *        &struct kmem_cache_args).
- * @flags: See the desriptions of individual flags. The common ones are listed
+ * @flags: See the descriptions of individual flags. The common ones are listed
  *         in the description below.
  *
  * Not to be called directly, use the kmem_cache_create() wrapper with the same
diff --git a/mm/slub.c b/mm/slub.c
index d257141896c9..5f2622c370cc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2412,7 +2412,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 		memset((char *)kasan_reset_tag(x) + inuse, 0,
 		       s->size - inuse - rsize);
 		/*
-		 * Restore orig_size, otherwize kmalloc redzone overwritten
+		 * Restore orig_size, otherwise kmalloc redzone overwritten
 		 * would be reported
 		 */
 		set_orig_size(s, x, orig_size);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..b55f10ec1f3f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1545,7 +1545,7 @@ static bool swap_entries_put_map_nr(struct swap_info_struct *si,
 
 /*
  * Check if it's the last ref of swap entry in the freeing path.
- * Qualified vlaue includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
+ * Qualified value includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
  */
 static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
 {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index aefdf3a812a1..333f4b8bc810 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1508,7 +1508,7 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
 
 	/*
 	 * For now, we keep it simple and only move between writable VMAs.
-	 * Access flags are equal, therefore cheching only the source is enough.
+	 * Access flags are equal, therefore checking only the source is enough.
 	 */
 	if (!(src_vma->vm_flags & VM_WRITE))
 		return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..2e127fa97475 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -109,7 +109,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 static bool is_mergeable_anon_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *tgt = merge_next ? vmg->next : vmg->prev;
-	struct vm_area_struct *src = vmg->middle; /* exisitng merge case. */
+	struct vm_area_struct *src = vmg->middle; /* existing merge case. */
 	struct anon_vma *tgt_anon = tgt->anon_vma;
 	struct anon_vma *src_anon = vmg->anon_vma;
 
@@ -798,7 +798,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
  * Returns: The merged VMA if merge succeeds, or NULL otherwise.
  *
  * ASSUMPTIONS:
- * - The caller must assign the VMA to be modifed to @vmg->middle.
+ * - The caller must assign the VMA to be modified to @vmg->middle.
  * - The caller must have set @vmg->prev to the previous VMA, if there is one.
  * - The caller must not set @vmg->next, as we determine this.
  * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
-- 
2.34.1

