Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD0428821
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906454; cv=none; b=rAqNxK5VCOx8jpEl24w6hFBDRboCYCRBJGrc927ItVkd74cfa+QjqYetJu4O4yWrmXTaDgdLGMKXxle9cOF+K9lpJ6X8vYFej0BVoOQxW3URKsSDZyXrL1ioPN9S0K1c+nlDycosyvFVOICDa8v+GTnJoK5UkeSUdtyU7XGHUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906454; c=relaxed/simple;
	bh=pk1b3RFCvS1kz5GHfFQRutp3IArlWwmoY4XWmITZX2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qto2vv8VDPeUuEkYwvmZzC7zBwXD2t8w6LcTiArmdzy1AIwSwkuQpns3pI7DDmzwuSCv3dDu0k2tRnSKNXIhuyd6eS91KO3+ntK7jGoEgGK+y91lCY8CuvAudDY7XSk+WffBQ0bP98CaTdW4oQK84MOcZVx4khRX1NKxhpS5o28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBxRWraP; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBxRWraP"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30df5854e1eso1330691eec.0
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906452; x=1783511252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prz2mwcezODKOS8in2sKwxdy9E9jg7GzDEkRG5HC3ao=;
        b=UBxRWraPCLWAbjfEsHm0AQa260JIwRxhEcZkHEdEOErre0L2hvsGiogg5R5fItv+f0
         NZw2qQro6RiyfSO6bx9who+Gl8ZndMfwKQ4w0yLeLtJFlbRVKNNoWiyqwSy/8mMHOUWD
         2wCjGVDB0deTA3CtFDwmAO1W1xmMxEJFSScIRXS8ZHpCj1rxYq7PsOEyF+HG5569+Beg
         /yRs6zMAjcrZ/Bs2CqUBIWvFGssZC0xdmZZVUSl52XAEjg9HbAtdalpJVk0zXvz4AOzm
         qk2dOKVdbM4b5R9WXIetf9Vtge8tGjVqpSC7NRvvKDmBtlh/8s7ha579uWMEgmWF02ao
         xesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906452; x=1783511252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prz2mwcezODKOS8in2sKwxdy9E9jg7GzDEkRG5HC3ao=;
        b=MF2Cnt8kG6HCmO3QZ5Qnf6VacpsxXNakUHY06TweBAA1OqtOPnVqtlKnRgwzTiUdEs
         TSNfK2MMTZ+yNkjFW8tbX8rIzSVl2J6peq/F9W1b4Ez/BM4a25/lBIse6Eg82mm1MY9h
         cGVTBHze12m0uYLapmZ5tOfczzluUqf+ay89kcKKqWPI6fBSeCZ6FmAwGGtYQazQiIh1
         f8yfJDmn7K0ocMAEqchdyuKv9TOY2NV0PPieuOYQzIzEYOBEFTaw/XAn23MNfW41OkFP
         2qaCblDlYF2tG7/dfWGBlFTJG8Pvslgs0vYxosRDbzmlbOkiPdi6R47/7ws24IWKqKye
         0ycg==
X-Gm-Message-State: AOJu0YwKYRpG8iLXcX/7Jkx50VD6f0XDbNBt/TXU1wV/HAe6xFQofngH
	cE5RzWN3MxGtCb15gyqllU+g7O9TiKqAWrH+fHo914L7L1hn86Em8k02taBbQX3U
X-Gm-Gg: AfdE7cnM63NMOE+PCYWjOf2gjQJFmyB+VFuHOoGjCch1SDZu6ZieIaEoPW2g4qIsJW6
	AgXOWxXt/iHN0OS+M/vYApjgQI69DMA/sx8S03rW2hnpbkKSnFm9VfKn1IrFpYf0mU7yIj9MCjz
	UfZqbI9ldnNjf/rlDVQxoaf/tIsRRN8VLS/pqSQan3rFLhUYl76k9mm6ysgxh5mM8g1zrEE9Fsq
	DnkkmErF0MrU3hkNnibTJbRbSbQu+N98Fe/Py0sHz1VPcRzlM6T2wJ0ScD+kpYwSSb/eAAv4r95
	IQ+aaiHft50q45ITzoBj7RRlXiuGEqnfeXThiJjfE8gRS2SCjHgCpq1gZKr3HSdSCXwLINIaEGg
	BAqbR0zhSjzLFcofedI1DCONEiqp/e0C7WPZ6keeG1sEINPUWQ/zzKljqG/TQeHQu49hV6gHv7X
	qTlw==
X-Received: by 2002:a05:7301:1f0d:b0:304:cd0d:9ea5 with SMTP id 5a478bee46e88-30efe710e66mr1921630eec.7.1782906452417;
        Wed, 01 Jul 2026 04:47:32 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm22518169eec.31.2026.07.01.04.47.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:47:32 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
Date: Wed,  1 Jul 2026 19:47:13 +0800
Message-ID: <20260701114716.56503-3-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701114716.56503-1-lianux.mm@gmail.com>
References: <20260701114716.56503-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Lian <lianux.mm@gmail.com>

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
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.wang@processmission.com>
---
 include/linux/khugepaged.h |  3 +++
 mm/khugepaged.c            | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index d7a9053ff4fe..6fb8a6857790 100644
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
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 617bca76db49..0387841ba2e7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -3272,3 +3272,42 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
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
+	struct collapse_control cc = {
+		.is_khugepaged = false,
+	};
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
+	result = collapse_huge_page(mm, start_addr, 1, 0, &cc, target_order);
+	if (result == SCAN_SUCCEED)
+		return 0;
+	return madvise_collapse_errno(result);
+}
+EXPORT_SYMBOL_GPL(damon_collapse_folio_range);
-- 
2.50.1 (Apple Git-155)

