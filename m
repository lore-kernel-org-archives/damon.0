Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E155385D72
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516636; cv=none; b=Ge7DWA50CpkqmBafwsMMvh1BJmIJYrClQUL6p/hGXPZYqWbS3ANWPiKUn1nnv0DWz9ZWSGkobMK7GDPiNvFHDwIXSeW2Q+NM/UfuznGzo2tGNsEPyYiksy29bkNeEyVKnbs0IezpCjC7wm/Vl/7Wf7vsLtW4+y6t3UxjrT66Sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516636; c=relaxed/simple;
	bh=nS+ihT8yiDs312RlqRcd39KPDyY9S4PRM4guYmebc9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcCnxUkv7DOJRy5CWOA3iz657Qqqbj0ucus79NaQcopzIflhQ+9p41IGEnwKcSyF0HmWGL4eB7z4DV2ziqjRclqLxIYvu6nVAkGJUCmmEsKYV3EtmfpOP+w4aF7H2REpijVIwksI29XAestZLUVWbaP3e/dH9kXhlbrn/o/senQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sj5I8Xkp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj5I8Xkp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc891373e0so117080195ad.2
        for <damon@lists.linux.dev>; Sun, 19 Jul 2026 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516634; x=1785121434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+CN3F8GNJ49+wMCUtm6B3zkpBPb78+r1IbCrOzeLVY=;
        b=sj5I8XkpU0CpcXCXQP3cNsAZQPl2E1Kas+Nn9DB7MnUmC9bVUFeQUar3h1gJaCYchu
         Py7xdh0+DGhI+SUgQCOQM3WY0JBZ5PWC3n7Zj7bbjo16KP8Q5K+anAkSNTcsqQpLHNtW
         xSPqorQfZSp2K4pMaSFpT3cwYSCZZg1VUxlanjI3RHvEyQwwKKPK70Uo7ITRhpFbbVQ0
         D8JOlrSWDdp8CJZWGeQ+CE5oK2Gw+NQXhWA75erYHVPD3ex9XMO8YcLFsUsn0WCeibht
         FLLXU9w66jUH4hBPcY2PEJpqNPZKnuSK39UIz+l3dzmuWyg8BSkCdMQkxm94B7EB0hte
         oRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516634; x=1785121434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+CN3F8GNJ49+wMCUtm6B3zkpBPb78+r1IbCrOzeLVY=;
        b=TLaTYVj6+J17wRxms2p9xgFZYa4k18+QIrtyoRbEmdCkjyzTOrWNJvTNsq8+tWlAd4
         QORtUZmYGAyHnEy9vVZ0/UTB7EtpC3j2CHSn1AoWHfDhl0o/4NfnSzUQ+vdWxsw5fA0/
         A9kGvyvJNADXgGLGufJ0rOsnVNwTkFkMqmklS/hQCv218Y3xGN54lURC/T5vio3Fqh4R
         daiaf93dUHrIcamyR83zPWVJFH13OXeyXG5U8EXxtYG3+dIUS3LhN9LMDPIt1AJ/oobQ
         4Lu7JS43M8Stj0XlNIkujhG7Q+IB3yCC5ffg5bJoNqDiPq0ausRJzmx563Zf2wjpMdJ5
         5oEQ==
X-Gm-Message-State: AOJu0Yzb0WsJ1WIyM4cPp/l2tViPaVvRD4pAW9yqAse6pxMhcqdgldcV
	ArXtqk2VuDkmSE1lMmt86w7IARKtFVsrqrGfZ9t2l8fEnFqsjTQuTKDeJSIcI00J
X-Gm-Gg: AfdE7ckI+zxO7flQK2XHQ4O6R86/xtc9VAKEuTGIccMYspjksVpPhwf+orhS/K8GLpK
	wHUh9QNyZOXjzTwVsJmVRHxJcE/jlMxHoHINO8jsu5TCCO+Z4fZvBMdW7lGE9OokLRhGZEvvuzl
	QOdN2qRv62k14TLry9PKDAof7g8AfkOKJj/vkZm9aKUp162zxymQKwDRzVIxM0nQOQFkMhGbxah
	mPbBcFAzmzg6CsBNmjWzzXj95G9vfJE2l3xm8tE/4Yofmg0plCIp89NDG4Oa0mvC4MdSCaUi4OP
	6XnXLHfubIpjs1uOm9QCg7BCeLQaaJzBxLn/Xmx+1fYA3WJXj/ZqWCEwc/FQGGIwmqCbOqdUKdU
	KZZCh/TVwXX/m0shVhTuAG5d5koFxNV48SYxpkxewvi7p60xAhvJOfiBZcDF1F4E0Iz025OcGE2
	yt64MMYbzAqoutoaVAhBPX3LxuZp4=
X-Received: by 2002:a17:902:e54b:b0:2c9:b48c:fdec with SMTP id d9443c01a7336-2cf348547d0mr141397945ad.12.1784516633659;
        Sun, 19 Jul 2026 20:03:53 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344d80e6sm47783065ad.29.2026.07.19.20.03.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 20:03:53 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: [RFC PATCH v3 2/3] mm/damon/vaddr: implement DAMOS_SPLIT handler
Date: Mon, 20 Jul 2026 11:03:26 +0800
Message-ID: <20260720030327.80153-3-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720030327.80153-1-lianux.mm@gmail.com>
References: <20260720030327.80153-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMOS_SPLIT for the vaddr and fvaddr operations sets.  For
each large folio in the target region whose order exceeds the scheme's
order, split it down using split_folio_to_order() -- the same helper
used by truncation, migration, ksm and shmem.  No new core-mm code or
exported symbols are introduced.

split_folio_to_order() must not run under the page table lock, so the
folio is pinned (folio_trylock + folio_get), the walk is ended to drop
the page table lock, and the split runs while holding only mmap_read_lock.

The scheme's operations-layer filters are honoured, and the amount of
memory that passed those filters is reported via sz_filter_passed.



Co-developed-by: Kunwu Chan <kunwu.chan@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@linux.dev>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
---
 mm/damon/vaddr.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d10b8042adb5..a8607448584d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) "damon-va: " fmt
 
 #include <linux/highmem.h>
+#include <linux/huge_mm.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
@@ -896,6 +897,111 @@ static unsigned long damos_va_stat(struct damon_target *target,
 	return 0;
 }
 
+/*
+ * damos_va_split() - Split large folios in a region down to @target_order
+ * using the existing split_folio_to_order().
+ *
+ * Locking: folio_walk_start() returns the folio with the page table lock
+ * held.  split_folio_to_order() must not run under the page table lock,
+ * so we pin the folio (reference + lock), end the walk to drop the page
+ * table lock, and split while holding only mmap_read_lock.
+ * split_folio_to_order() returns -EBUSY for a raced or pinned folio;
+ * we skip such folios.
+ */
+static unsigned long damos_va_split(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	unsigned int target_order = s->order;
+	unsigned long addr = ALIGN_DOWN(r->ar.start, PAGE_SIZE);
+	unsigned long end = r->ar.end;
+	unsigned long applied = 0;
+	struct mm_struct *mm;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	while (addr < end) {
+		struct vm_area_struct *vma;
+		struct folio *folio;
+		struct folio_walk fw;
+		unsigned long folio_sz = 0;
+
+		if (mmap_read_lock_killable(mm))
+			break;
+
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
+			/* Skip the gap to the next VMA, if any. */
+			vma = find_vma(mm, addr);
+			mmap_read_unlock(mm);
+			if (!vma || vma->vm_start >= end)
+				break;
+			addr = vma->vm_start;
+			continue;
+		}
+
+		/* Folios in these VMAs are not our business. */
+		if (vma->vm_flags & (VM_HUGETLB | VM_MIXEDMAP)) {
+			addr = vma->vm_end;
+			mmap_read_unlock(mm);
+			continue;
+		}
+
+		folio = folio_walk_start(&fw, vma, addr, 0);
+		if (!folio) {
+			mmap_read_unlock(mm);
+			addr += PAGE_SIZE;
+			continue;
+		}
+
+		folio_sz = folio_size(folio);
+
+		/*
+		 * For file-backed folios, @target_order may be below the
+		 * filesystem's minimum folio order (mapping_min_folio_order()).
+		 * split_folio_to_order() will simply fail in that case and
+		 * we skip the folio.  This is a safe no-op; future work can
+		 * adjust target_order upward like split_huge_pages_in_pid()
+		 * does when a specific filesystem needs it.
+		 */
+
+		/* Honour the scheme's operations-layer filters. */
+		if (damos_ops_has_filter(s)) {
+			if (damos_va_filter_out(s, folio, vma, addr,
+					fw.level == FW_LEVEL_PTE ? fw.ptep : NULL,
+					fw.level == FW_LEVEL_PMD ? fw.pmdp : NULL)) {
+				folio_walk_end(&fw, vma);
+				mmap_read_unlock(mm);
+				goto next;
+			}
+			*sz_filter_passed += folio_sz;
+		}
+
+		if (folio_order(folio) > target_order && folio_trylock(folio)) {
+			folio_get(folio);
+			/* Drop the page table lock before splitting. */
+			folio_walk_end(&fw, vma);
+
+			if (!split_folio_to_order(folio, target_order))
+				applied += folio_sz;
+
+			folio_unlock(folio);
+			folio_put(folio);
+		} else {
+			folio_walk_end(&fw, vma);
+		}
+		mmap_read_unlock(mm);
+next:
+		addr = ALIGN_DOWN(addr, folio_sz) + folio_sz;
+		cond_resched();
+	}
+
+	mmput(mm);
+	return applied;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -926,6 +1032,8 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return damos_va_stat(t, r, scheme, sz_filter_passed);
+	case DAMOS_SPLIT:
+		return damos_va_split(t, r, scheme, sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.
