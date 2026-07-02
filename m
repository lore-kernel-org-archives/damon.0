Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0643DA51
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985966; cv=none; b=dPnzBfIRDVwLjcnXOuw0z+CJhuh3EEI63GAgQOgHFJESO0QULKwRJlb34Be60YtfF4/RnfHvYFWKnUyotC0hsrm/qNJI8lAAd5RxDVmGCPK2pO6xPlVgOfS735MToUJ7igXqqcR0X4H5/1mGOi409OzQgI1W6UV7U9OYDaj0XTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985966; c=relaxed/simple;
	bh=JwJSC6QBIXHZ6EVUA6kz1vznH9OKSQxIf7AtLS4NMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRsEe5nwApEjTBflqZaOhY4wNnRjn87zbAXKtcRmmy4RdcZ5XGTrXqifMb64ZECtSHIbUdGnIuX+nD09MAmBmc8YbcNqj2yVC6ngkxLl9TSsWrvgyrzrLTbxehOIK6Dkne48N+oJpapdgUlvwZSUGGTHagyq+jjcn2M1/tX37uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdQiU9D/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdQiU9D/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so1129043a91.3
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985964; x=1783590764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icPP3MmY8t9qE9Xpwb6MvphYCRwC/sqcyq3pTHjWUnM=;
        b=SdQiU9D/+OWfPj+Vs3WNhlh64KFbcjGj1QpipIDB52WXCKjrHuzXwkK9j/IaY9vkmH
         +BRTWOP2H2Ylot0iGwb4vj5cUlNMVU7Rckw6NaPwkth06Hgc26uvowxYPuYLiNqJpOVI
         Jk9Lwg83N14UB4nO9XEMeeFZ6yugsyYPD/rH2YMYw0M+vipyeh0L2rwKTCKGbER4dwdx
         tokcEEsxab0pSKkYE4C4Y0D53ac+v0mwjFnjLQBdtSYunvfRDnnhtmnqSQGiCYOUuXcc
         rTgGzMx0uwg0vpeT3JWKHxmTIp4NvkYz1ajFR0Er+o2drnWGbuSQI9fyx+x7PK4s/Vzf
         lLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985964; x=1783590764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icPP3MmY8t9qE9Xpwb6MvphYCRwC/sqcyq3pTHjWUnM=;
        b=BUeF97ddcDv3BJxey/uxzb+4ORhYk2zqKCgFTgNpM9kRdYq3kQTNW5S7SF1dtl8xjb
         GEAxTcrmuomWhOXbl/IrXhBm/hGFmF+lLVR705di2BJJ6lH6+pDCFZUbKWogpFNxQWsy
         J6f7Zdrp5Z3Wz6ZXvdmZO1GYSjqZQoIW/Z4UmMkjvq6KTbs9Mfk72GdnU0tQnQ/HubmD
         CEYx93EtL1y/F57OnpfMH6cUVBaCGXvfF8B3VkDsLR+IwJzJmrd1/PKpeuI2nZwNncqG
         /YRBBFBKuA9QFl9FRW0VZiALjEU8CaKvMkhFWnbaUseOlFUzi3QTyAeLLiKZZfWIIjvz
         aLsg==
X-Gm-Message-State: AOJu0YyeQ8hNrpC220Tu2l2vNaor/OlbVqj/3p6KV5K1GdvcpNaHcwfL
	/A+U8v9xJxYIeZQtuQu7gIOF1HmqTd7Xpaw0fm6pPBLSwtpLmuWXnHkz+sEfeucTzpE=
X-Gm-Gg: AfdE7ckL8eKNxZmauuHA+8QW5p545uCC0ddo2aVEgFVOZuj/Pt8JyU3hjTMkjpWhEM0
	/hMH6kdXJSB732N+aPo7t/6hzjxS6Dn57gpT5ejRuOq052PYu4906Ff61zdvppIKzonFZwbBbz+
	lEF/b0kr4+4dOUCYr40Ch6kDHcezqZ4lavHWU1HhPaCExGHvJKM0SL3161YnKJsNCTZPkN2rwUn
	WN3EFP+JHTO6ViKcH+Uz1mCz/46P2sTUJzzSAn6Xi5MRfjU8p7RKYH5Jcuwx8fO8e0vHg3GaR1i
	BfwltqSFokWUXTsDcsV7Q7WjQOpOo827UQf2YXmxs2P2BdMDZkouTM5p4cj7yxa4K8ENpBPj+SD
	UatKnS25qnbUSWDr2AVyL7OWj+uldHpTMkRuSOItbxHOLGXWc8qr/TeO5gYqkNTupuBx/ZW0kSa
	j0uA==
X-Received: by 2002:a17:90b:534e:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-380baacf7dcmr4503411a91.33.1782985964047;
        Thu, 02 Jul 2026 02:52:44 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm8348869eec.13.2026.07.02.02.52.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:52:43 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
Date: Thu,  2 Jul 2026 17:52:24 +0800
Message-ID: <20260702095227.75866-3-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702095227.75866-1-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export a thin wrapper around collapse_huge_page() that allows external
subsystems such as DAMON to trigger THP collapse on a target address
range.

Currently restricted to PMD order (HPAGE_PMD_ORDER), since
collapse_huge_page() does not yet support arbitrary mTHP orders.
The restriction can be relaxed when khugepaged gains mTHP support.

The caller must hold a reference to @mm.  Do not hold mmap lock:
collapse_huge_page() acquires mmap_read_lock for validation, releases
it, then acquires mmap_write_lock for the actual collapse.  Holding
an outer mmap_read_lock would cause a self-deadlock when the same
thread attempts the inner mmap_write_lock.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.wang@processmission.com>
---
 include/linux/khugepaged.h |  9 ++++++++
 mm/khugepaged.c            | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index d7a9053ff4fe..f7d49cba712f 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -20,6 +20,9 @@ extern bool current_is_khugepaged(void);
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		bool install_pmd);
 
+int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start_addr,
+			       unsigned int target_order);
+
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
@@ -47,6 +50,12 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 {
 }
 
+static inline int damon_collapse_folio_range(struct mm_struct *mm,
+		unsigned long start_addr, unsigned int target_order)
+{
+	return -EINVAL;
+}
+
 static inline void khugepaged_min_free_kbytes_update(void)
 {
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 617bca76db49..7fe9ce1e0533 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -3272,3 +3272,49 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
 			: madvise_collapse_errno(last_fail);
 }
+
+/**
+ * damon_collapse_folio_range() - Collapse base pages in range into a THP
+ * @mm:         mm_struct of the target process
+ * @start_addr: start address (must be order-aligned)
+ * @target_order: page order of the collapse result (currently only
+ *                HPAGE_PMD_ORDER is supported)
+ *
+ * Thin wrapper around collapse_huge_page() for external callers such as
+ * DAMON.  The caller must hold a reference to @mm.  Do not hold mmap
+ * lock: collapse_huge_page() acquires mmap_read_lock for validation,
+ * releases it, then acquires mmap_write_lock for the collapse.  Holding
+ * an outer mmap_read_lock would self-deadlock.
+ *
+ * Return: 0 on success, -EINVAL on bad arguments, negative error from
+ *         madvise_collapse_errno() otherwise.
+ */
+int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start_addr,
+			       unsigned int target_order)
+{
+	struct collapse_control *cc;
+	enum scan_result result;
+
+	if (target_order != HPAGE_PMD_ORDER) {
+		pr_warn_once("%s: only PMD order (%u) is supported, got %u\n",
+			     __func__, HPAGE_PMD_ORDER, target_order);
+		return -EINVAL;
+	}
+	if (start_addr & ((PAGE_SIZE << target_order) - 1))
+		return -EINVAL;
+
+	cc = kmalloc_obj(*cc);
+	if (!cc)
+		return -ENOMEM;
+	cc->is_khugepaged = false;
+	cc->progress = 0;
+
+	lru_add_drain_all();
+
+	result = collapse_huge_page(mm, start_addr, 1, 0, cc, target_order);
+	kfree(cc);
+	if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
+		return 0;
+	return madvise_collapse_errno(result);
+}
+EXPORT_SYMBOL_GPL(damon_collapse_folio_range);

