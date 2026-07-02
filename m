Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3F47CC83
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985606; cv=none; b=uc9kzagIaZSmnIpK8E0/61mbjLRje8oZ6/J2G2/n/NwVnWSS6IR8HLU/DHqXDaKhuui060aftWFiADqffwDWeqED73dWw8nIe3mGwZbcU2P93LaN6gs056izq+c2S046jyPXOdkIO5wV7DQhdyPIlIGBJMQ+PggTQ9YG/6Xu/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985606; c=relaxed/simple;
	bh=JwJSC6QBIXHZ6EVUA6kz1vznH9OKSQxIf7AtLS4NMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCW0M4NcqCwaO3szBatX6Of0l7oYtUVd5rfKXM7e08B/nuPaaCnX7KJS7XssZOJh1XirzzdFhxZ4RkJmItqHVM/eeZ8A1hT+T5gDKhGmludOOCNvdrsYOP/hagE4YCzmEibvHixICFJHZ6vbF5gAfAB2yx55XTyuAQFk0dZ1hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHnE+Qvb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHnE+Qvb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c7ebfb63c6so12208275ad.3
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985604; x=1783590404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icPP3MmY8t9qE9Xpwb6MvphYCRwC/sqcyq3pTHjWUnM=;
        b=lHnE+Qvb6OflTpXpWp/4IqvkRXvz5+Vt1QKOK8OnEhh54UCFy9rwNCZnAG11jGTnPB
         k+JmIz8gm55tVsc8XNhdcMz9p4ZLiIYzU9Fo0BQnGXGPzizzCqWE0Nbe4ardVBUv2ASj
         k3NYAj/OB5olvFdWonIbcKCk2H7lCkNXQzniWyU9oZcqagk0n1fzDNEqDaSBylM9yDxq
         rjRbiOuIO60wqKYVnPMDDB+KxSZirul62AW/HEyszdbBVn8/Q3RS3EjCCokg3JSC0NtU
         bwIZpeb7TKlJkl/sLawUiClY/+DHK8ZyY7C/9K1gsWqG/DIbT8/6mc8V7REFA6MpDDSM
         wBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985604; x=1783590404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icPP3MmY8t9qE9Xpwb6MvphYCRwC/sqcyq3pTHjWUnM=;
        b=SsfOUYOPIdu6nTLhR8gupFLxNmxfzEqc28KkvxFRe52hKJQM0p3kgerwl1VtxaOgJ/
         u0M0VXdhU/jbu/LR0SFKsS7NbPUIvLNXrZuw7T2JCg/Crhfix/KwEKecoNYYqoXt+Vnq
         V/KTn1ZlzfzwgmSDZtIJ3jopnLT+mWVOb5HevTAg4h8Jvnmb3yyVog/DK+Z6TJZ3nmbR
         5XwtMQ+/hw4b06z07MPK2H+t2JuyzqC815Ge68EAgL47o987kpWDbesd8RYgYRTW3ghA
         WjCYCM9bHqplEWsv3GlY42IIm1rYKyK4bekcbtwwJq7yQguItqJXbSVvnzawYSaaJOsD
         nTVw==
X-Gm-Message-State: AOJu0YzkyTgMWuoHgiA1mkwOFG3Z9khqe6WS7jtrrIjMU+Uxpn22iF2j
	1RVkrwVkDmsVVnFG55TVdJE6Q0GVpolqd0L8Hdrhyl1xeZvEMXMaXtKl
X-Gm-Gg: AfdE7cnFqhFZ0fnDsjeC2raUt1npnfna+uqUWVELf9vPMDkKIqWlbyvpJtrUn1GcSUz
	ZsiFP+6fgS5AZMfWW/wmnhrdOGLWTVu14zIy5jaYZ3QEzXvlXk+qAKJM1XQ7EU9+A6LVlBiG9LF
	SfNZxNsrOZddgEguq5gwRBcgvFL2nqIO1aGXOPiLnah7Mhl61YSibaZ/MsBY0ojYUrsbT2H1lDc
	wde8UX/8wC/pdGkrwam/E9qFnatG5Fxc18O4MfG1DyZiRmHCGUnK9gH+XJVFuRslnkeI3mInMEB
	DSmUcn8CsLo+tNtqRm/g6GPG7Qpui+jAFpbdjH2HmX6n2Qawv+pmD4CL7pM0LIh0o6Qf3SbPtWW
	mogXjRvlr6IDd6Td6U/DdHW7J7AyYc4j4XpZwWrhXVqBBmbVH96PFh3i+8vzxoPykiEcRuz0+PU
	jbuA==
X-Received: by 2002:a05:6a20:6f93:b0:3bf:9a30:3a12 with SMTP id adf61e73a8af0-3bff4301c4dmr5363264637.50.1782985604293;
        Thu, 02 Jul 2026 02:46:44 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm5261121eec.11.2026.07.02.02.46.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:46:44 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
Date: Thu,  2 Jul 2026 17:46:30 +0800
Message-ID: <20260702094633.75658-3-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702094633.75658-1-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
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

