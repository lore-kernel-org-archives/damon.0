Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A019E7D1
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022886; cv=none; b=rCKu/A72kbqGuK0UCF4iNBfW6iMFNFbPtwWZjpHbG+rxpmOEFLxZQCE87q1woAoSGJRsENxLgBXQofuLD4IjGhlajnKIL3JSiqD2k19ubrdcYN4dj8iKHDUG+AR9+u1gWX8PxBfHpxSamSVxts3EXb7VtaDHmMRL1+eD4O/lNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022886; c=relaxed/simple;
	bh=e+T1fhlgewUCMGkVoR3tTxRjhF3Cc5drfaDrOO75184=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ1n+o37j6qxxPLZST6wlbe/d3Eqvx+4OmeYbmGEun2UOxB1HrBRr2BKkeV4yeAyiJBf/DPraT4SyZV/xR2cRXXoQtf3DZUV/dtDyCjvR3mn4+DD80YjvaiKK6EC9R/v1u6953rG8YrRrdfoDEvZ8HhpJeXxsFIsytCKsav3Xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUwM3hL1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUwM3hL1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e75668006b9so5041514276.3
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022883; x=1752627683; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZC5q8LZ5pc6UFxmCdVHkQ+xcSY0x1BRxLFRLW7GuXk=;
        b=ZUwM3hL1zJJQa7ZQph7y30UJ/xKwU6cNF17pNUtNpnG3x8Gtp/A6GjumxkMnrAyZoh
         ND13VIc/tT1HNW1W+cumrtHQd/PBMjbDFaVtCA/fCfNrRjlCOgEnmN5PUWUs26EN4Hgy
         OEzGvHkPECQgGAtAmfv1D4y8GQ58Rq1KlSY46jAssQAuUuHziJxr+c22uS/Ph/pLn8eO
         w5+iT4Xt/ffKFQf1+JbsdSbT+scdWZoVW5EP0CzJdQeO81LnVmWoQ+JxwGMk6jOW7YTy
         bP+dD84WXGQFaD10wWuLLYobgDWi1BKZ/zzFKL9Rynjyky9rRtjoPZjZlYOZ/ydrsylD
         86eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022883; x=1752627683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZC5q8LZ5pc6UFxmCdVHkQ+xcSY0x1BRxLFRLW7GuXk=;
        b=soLeWg5sRD2uCF/jUCUGzC6UGpKLFsY1rF2JAd5rhk15bWvlcHV6QMCCC2o0mFpl8O
         H1E9lQVzJJqT2cmq2tonztxBhEHR37K4/nawNmQKoDs8yyM6IM4sVtkhGJSg8lu0lFER
         VgNAA3h46Zl00A2Miwn3QQ7oxVNt98H5KAxbl272o55vlfbO1e/G9krc3cO3oB5NPwvN
         h5SxQaz28lQyRUidvizMe/xQvI8YtBA2/4GWeJR14E8mTnUC1IUlA0q1hUh+0f3mlC9g
         pCpX2M+VXvQvVyZ55OSHW8mctYXDK+OD5vb/cwoLjslrnnZjOdh1y3/JGI3Txs9RfX1O
         kWAA==
X-Gm-Message-State: AOJu0YzFzHfDOXOWg5pu1qBceydwqMQujROJS20ZpuqUScR7Lxt0YeEH
	uCl1T6/NhcuGaqOEjy6GV4ASXK31CmHD7scD6bEuqFBEKxpi9F2fQt6luGP53ONJF8w=
X-Gm-Gg: ASbGncvqIuyRRIoHjddDRbMSFGkoIwkniu/loDdRitHKwksoMarbYqsunwBpWEaYL5v
	UUUjvUDXpaBKjTpOKZGetjeKrEeROazAVZXQxyTNHxy5hM8uu+3nKgADlxbadSkF8SAu24ycrtt
	doffuPm1SdVkv1py5WOBEKDKrn0e3cj6w7yT2NNuiNvCEkSzSKOC3leGPNOrMRXoAD0Ir9kuuvq
	cg5Zs8Mf3yg5BCZNlURfqj6pljB9QAf+dccQIKzLZf0GLlQattF0H99nU3pMHEpmIBdfTDYnHv8
	0XbdbYInZx/vNi7yixKUGBG07epbRBCki5NVoLPMNlqoemQTiptXaveYHm2//9qdLkS275CWqpa
	aYLj7ymc=
X-Google-Smtp-Source: AGHT+IGBVL08fCEmXie0BqOThtC53srTZke6UZuD3rNGM0GVPqcqyBQP9Gr6apPaTrB4/7lyEi3sSA==
X-Received: by 2002:a05:6902:2609:b0:e8b:444a:9298 with SMTP id 3f1490d57ef6-e8b6e0de728mr1064674276.5.1752022883567;
        Tue, 08 Jul 2025 18:01:23 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:01:23 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 13/13] mm/damon/vaddr: Apply filters in migrate_{hot/cold}
Date: Tue,  8 Jul 2025 19:59:43 -0500
Message-ID: <20250709005952.17776-14-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

The paddr versions of migrate_{hot/cold} filter out folios from
migration based on the scheme's filters. This patch does the same for
the vaddr versions of those schemes.

The filtering code is mostly the same for the paddr and vaddr versions.
The exception is the young filter. paddr determines if a page is young
by doing a folio rmap walk to find the page table entries corresponding
to the folio. However, vaddr schemes have easier access to the page
tables, so we add some logic to avoid the extra work.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/vaddr.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 47d5f33f89c8..7f5dc9c221a0 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -611,9 +611,60 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damos_va_filter_young_match(struct damos_filter *filter,
+		struct folio *folio, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
+{
+	bool young = false;
+
+	if (ptep)
+		young = pte_young(ptep_get(ptep));
+	else if (pmdp)
+		young = pmd_young(pmdp_get(pmdp));
+
+	young = young || !folio_test_idle(folio) ||
+		mmu_notifier_test_young(vma->vm_mm, addr);
+
+	if (young && ptep)
+		damon_ptep_mkold(ptep, vma, addr);
+	else if (young && pmdp)
+		damon_pmdp_mkold(pmdp, vma, addr);
+
+	return young == filter->matching;
+}
+
+static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, pmd_t *pmdp)
+{
+	struct damos_filter *filter;
+	bool matched;
+
+	if (scheme->core_filters_allowed)
+		return false;
+
+	damos_for_each_ops_filter(filter, scheme) {
+		/*
+		 * damos_folio_filter_match checks the young filter by doing an
+		 * rmap on the folio to find its page table. However, being the
+		 * vaddr scheme, we have direct access to the page tables, so
+		 * use that instead.
+		 */
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG)
+			matched = damos_va_filter_young_match(filter, folio,
+				vma, addr, ptep, pmdp);
+		else
+			matched = damos_folio_filter_match(filter, folio);
+
+		if (matched)
+			return !filter->allow;
+	}
+	return scheme->ops_filters_default_reject;
+}
+
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
-	struct damos_migrate_dests *dests;
+	struct damos *scheme;
 };
 
 /*
@@ -673,7 +724,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
-	struct damos_migrate_dests *dests = priv->dests;
+	struct damos *s = priv->scheme;
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pmd_t pmde;
@@ -691,9 +743,13 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto unlock;
 
+	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
+		goto put_folio;
+
 	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 		migration_lists);
 
+put_folio:
 	folio_put(folio);
 unlock:
 	spin_unlock(ptl);
@@ -708,7 +764,8 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
-	struct damos_migrate_dests *dests = priv->dests;
+	struct damos *s = priv->scheme;
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	pte_t ptent;
 
@@ -720,9 +777,13 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
+		goto put_folio;
+
 	damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 		migration_lists);
 
+put_folio:
 	folio_put(folio);
 	return 0;
 }
@@ -790,7 +851,7 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 
 	use_target_nid = dests->nr_dests == 0;
 	nr_dests = use_target_nid ? 1 : dests->nr_dests;
-	priv.dests = dests;
+	priv.scheme = s;
 	priv.migration_lists = kmalloc_array(nr_dests,
 		sizeof(*priv.migration_lists), GFP_KERNEL);
 	if (!priv.migration_lists)
-- 
2.43.0

