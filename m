Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26712D46B6
	for <damon@lists.linux.dev>; Sat, 27 Sep 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758960472; cv=none; b=rCWM+YzsRrYlNUJxzN5E4AfgpoA4EYDvrH/2gf4OyLTqxT7Mn+CeKF0/0Q+0LfFWkxqBkoynZ9pkV8E8KqgUFfc3IEc98RUEVzuxc+art/GT0w48ACA4QXeS7D+mRNTXwFFzHLEukVR61Y0ntSUE2m62LutvTPm3AcLxItvOcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758960472; c=relaxed/simple;
	bh=TbeRTX56MxhMy1n5yAmnzxFzmAw8lMv1PmfEmD0KsEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yue8BNoHBhB7ESno4zel/34q3veUa87rtdaqKvCRfzH2ypbCxRuIsTNtTb6xC6auA3B+G8COjIYVMqZ2b/dkHmM7I7aX/Nz80xBrhVxqatJBjd9EtoOdriiKtultoJ1ha+KxTrYiYLPhE58+xDGiuINGT2Ql6/SFR0ezHINy2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdrAxVfo; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdrAxVfo"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso2402131b3a.2
        for <damon@lists.linux.dev>; Sat, 27 Sep 2025 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758960470; x=1759565270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pnX7Z7v528RTOngSyYskOdERrXRUZlzBZkjWOik6R8=;
        b=NdrAxVfoYsPEdaqHMlC4h0z0wvK1jG7uFyH+W9sHrkoA0fcB66D1Nefq8d1iS4zjTx
         KLf5bhvSZGOenc4x1xYXoeYngMNXhuH0QqE5KaXlqqbAY4Fu0CzIW0TBbkuEtUnr3qUw
         LLUo/3lVoKKZo6344bpvW86veKAnAGQJyyQb/aWWgcOoxz7jit/X+2qnYHWIdfN2O6e/
         +rZLds6We8noPzxndnGudx0Hcsua1ZNxc6j/Z9nE2W7XMRa1woqRemy8GmqxCluSRbS/
         oXdd30IxGKLdRrVtsKaudAuqRU+cITUGXh5mVM6oEPwQarS2NZgif5MvZTw6LatkhMF3
         b+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758960470; x=1759565270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pnX7Z7v528RTOngSyYskOdERrXRUZlzBZkjWOik6R8=;
        b=IoeEUrZoO+gAUSwBn2c9JAiRyGiI05egWe6Jj4RnjI5GcZwBMjLulb+hwd8T4aNexQ
         9G94TUBKf3AGRRNxtwbBFlxaH29WzZgg9ehJFN775+28dxPH7xjJs2z36vZFeVVvktKo
         2O6frZyVASUUSh3L9INf6oHU6gGkczOrJac8tJzjrpHMs5mB8IE0m4+GfrxriexbjvV1
         KrRyXUefHCjbWs2vhUIf5Og7UlGQX6+j+6+BITw4s4JZDoSIA10kKQK5JazUdRyhqBhA
         C5fPrYv/8KVNdPUEYSDBOY066Kmpq7WA6IITSHbZtvHkPbe3ZNVwIQ9+bEkdHFzsDtIa
         iNQA==
X-Forwarded-Encrypted: i=1; AJvYcCXgRBE8NZzYVJcTbi0KtUUTVoeO6MzhcAddowlklCJ+P3m8RBBLYoyVYnvs7mi3Vq7sYnaOPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznk99KobamOeEhApozN24TrHzVmMs4NLgiI7WPTCkvewjNJso0
	CH4LYd2r9SbQeXQCnIoweKoIgTVF8pqS1aUUJaWQUv8eIoH+NXIa1F39
X-Gm-Gg: ASbGncsZkmbFqY3TmCRNOhOljl+cmnlA4n4zKPp7Ch4Za71Az8kGieMjiEkp5gUrEZB
	HcEpea0Ig6zgUsoL70veeFSipzKGFOoD80jXEHs2qfveOlbEqd6Vn1kHSaxJn3uNaClRR7ywshm
	LRyjdp6EishS+5RuaJ5r3D9t6WxQQJhAxlwwflU4cQWgd3vNgGVC8B29sLa2M4NkTJRo1WpQcKB
	xElpc2ZMEYLHAcBTecFvm0iJjpzZA9qTBnfFvFQ+gIH6DwZBp4kmwevUbgTRIR0yYkbuU3nK7cx
	4xm5vAy691tgebrMZ05gCHHbPF6M3Uh+gUz2oSu8TmYf1IEiW7DTFxG4SF6zFfyC2l/5GI/hfyk
	lpaBL/1eIPnPrO4ur6vMcptzJzP5QH/LQ1Vxma0Qu
X-Google-Smtp-Source: AGHT+IHa8OtN7NuIoR42xaLkir4lydhP4OP69ifxN66GwwvL4dolRG1B/QZf4EvOu693LGSGG6zhKg==
X-Received: by 2002:a05:6a00:14c5:b0:781:d163:ce41 with SMTP id d2e1a72fcca58-781d163d14bmr599623b3a.11.1758960469954;
        Sat, 27 Sep 2025 01:07:49 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810cfdb99fsm4744233b3a.31.2025.09.27.01.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 01:07:49 -0700 (PDT)
From: "jianyun.gao" <jianyungao89@gmail.com>
To: linux-mm@kvack.org
Cc: "jianyun.gao" <jianyungao89@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
	linux-kernel@vger.kernel.org (open list),
	kasan-dev@googlegroups.com (open list:KMSAN)
Subject: [PATCH] mm: Fix some typos in mm module
Date: Sat, 27 Sep 2025 16:06:34 +0800
Message-Id: <20250927080635.1502997-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Just fix it.

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
 mm/damon/sysfs.c  | 2 +-
 mm/gup.c          | 2 +-
 mm/kmsan/core.c   | 2 +-
 mm/ksm.c          | 2 +-
 mm/memory-tiers.c | 2 +-
 mm/memory.c       | 4 ++--
 mm/secretmem.c    | 2 +-
 mm/slab_common.c  | 2 +-
 mm/slub.c         | 2 +-
 mm/swapfile.c     | 2 +-
 mm/userfaultfd.c  | 2 +-
 mm/vma.c          | 4 ++--
 12 files changed, 14 insertions(+), 14 deletions(-)

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

