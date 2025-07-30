Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A514883F
	for <damon@lists.linux.dev>; Wed, 30 Jul 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896005; cv=none; b=F1948NHzeJ7t+pEaJfi3ibHjwLNaK5wRC83PXF62PrwMgBZhOtnYx88IBRcQaQHpj+aMwW6WWmZ8jZAmcNphw6BpbQZgtH9h3xAtcaW/Zi14oq9SYHKoGeuMn/zpRbi6BeRoSJHJ/EZYzCUULRakEieFJEKOOPcOiupR/UcgZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896005; c=relaxed/simple;
	bh=GdobNqCOO20Whsgzozafpby6KJFetdejZjlrCnc5zdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKVo4QpSv8t9pczVuAD6pJrmxv1gew3ZnCdSSGeHps96Bqfg8YtcHnvOXyD/iYCQ3XYk4mVKhM96r0l0H0a31qfAdVKaVQ3fgVBPdJPyjnboR9fmSxYPwfnkNcwjCHD3J4hMy+GaSCJLcW8yk79KB/ymRqXhAjO5UIXPyi9NOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXoUsvKd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXoUsvKd"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b77b8750acso832790f8f.0
        for <damon@lists.linux.dev>; Wed, 30 Jul 2025 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753896002; x=1754500802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m56piLiCUsf4x2+WWsFp57PljOix1hfz8SW0ckD+2q4=;
        b=dXoUsvKds3I2TDF+jShV/GR01nBpfiNFJrp4lZemGVv+ylLRvJH2KaZ+MTxXs8RuqI
         2T1tVCZo4JtXhX8jsSZlDZO1m5AusCB6tyO65i4G0bxR9qP1BlQ9TqU5rpswkPAFPEsg
         RXAc5yCjI2xCpTFPOCoL/CRGdXXKhS0SZt5ZnlWcCMD94wKGTdA+FppIeUdDZ11Ic7jM
         vk5b8l2ZSwtrPvjPVolihayMvJIG4utX0Wx1MYJbupAyeEZ4oJ/Rl8xtThUFwXm10wMs
         Q4HqQKClT85rK9MgynNgmJi7u2RIzolZGembKpryZmJ9tWgrLo5srbdf9tuQtmg3+Ol3
         WKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896002; x=1754500802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m56piLiCUsf4x2+WWsFp57PljOix1hfz8SW0ckD+2q4=;
        b=XsaxOg/Vei0KoWzr5aphp3Y3sZF0ZBWTPqG9wqeRpmswRUC3JRUI88gEccA+NdXkzF
         dvqJyJoMucIX851Oxhj44KiQuF1f6jLbSD685JhgfQCVkW8M5/LVxd2QX796rNfpE0VV
         5W3G/hCeMaCgWpL95nmD0e3ZMHz1RnkOWJmz20EOm5dVKTjOaVLSGU6akOt5lZ2RklI9
         Vq5jX/ghxQzJJNw13YY/dUtG88VZmkNz+AE81oDTb/aP29holjS60a0D0NJQZUBlvBc4
         0iIK8qqhzlhW+8Uf4mNS3tKi5S1/KlB+ypTEci6h1ul6A/3b2yj3J7RK7GBYGXAraS7j
         xsKg==
X-Gm-Message-State: AOJu0Yx2vaJzjT6W7ywhWT3orkG1Z39oqolINbo7g/0agAMApV9K4P29
	IGj/mSSqV3QwcPRrZyOCWrSLaonvrdDddB3eo6HaogdJgZAqx79xZZUz
X-Gm-Gg: ASbGncu9ErJ8q47wwk5FTgE0RuBsA6MB4JF0QEehshlldZttrPNxkm9g3ExaEWx+tq9
	PzsrNWPiDLf5Jv0EsFw6LuGzI4Zh9zjvFB4rFdgktz4Q2nhGneiP2+FG+BZCRcL/sG/XaOZjvkg
	TL9LftJcLahGSY4ycnFdtPMZkoyy5M+wDIR77G4z60mE4NcA4rL/S090x0of38qBVWwW3GtoND3
	iyWiE3AcAbPw4W6f01Fk/BiHp9B+vQf60Gk8dJjdKw/ujruNX+tISbbZd6L++YZEt+cxDaURvCo
	7GJ1cp0LiV+FF9PHC1H96gSlXX4zltna/RE/p5I50TBs6LAVRGHjikRDEQF7WaJi+hHWns8BYKk
	CD75/qar2Y71ojR4=
X-Google-Smtp-Source: AGHT+IGCdHpb01HVcfRvMatDM7O3m0xWJobij7p29QqoVPfMGp10ngvKQXKEPQiuMocwu72i1Rx6hw==
X-Received: by 2002:a05:6000:2311:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b78e72803dmr7193414f8f.27.1753896001745;
        Wed, 30 Jul 2025 10:20:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377ae2sm33277545e9.12.2025.07.30.10.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:20:01 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon: Add damos_stat support for vaddr
Date: Wed, 30 Jul 2025 10:19:56 -0700
Message-ID: <c05b1b4f66758c0154e4d037adcb15c43917f38b.1753895066.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753895066.git.pyyjason@gmail.com>
References: <cover.1753895066.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for damos_stat in virtual address space.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/vaddr.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..6ed919e817e2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -890,6 +890,109 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	return applied * PAGE_SIZE;
 }
 
+struct damos_va_stat_private {
+	struct damos *scheme;
+	unsigned long *sz_filter_passed;
+};
+
+static inline bool damon_va_invalid_damos_folio(struct folio *folio, struct damos *s)
+{
+	return !folio || folio == s->last_applied;
+}
+
+static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damos_va_stat_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
+	struct vm_area_struct *vma = walk->vma;
+	struct folio *folio;
+	spinlock_t *ptl;
+	pte_t *start_pte, *pte, ptent;
+	int nr;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_trans_huge(*pmd)) {
+		pmd_t pmde;
+
+		ptl = pmd_trans_huge_lock(pmd, vma);
+		if (!ptl)
+			return 0;
+		pmde = pmdp_get(pmd);
+		if (!pmd_present(pmde))
+			goto huge_unlock;
+
+		folio = vm_normal_folio_pmd(vma, addr, pmde);
+
+		if (damon_va_invalid_damos_folio(folio, s))
+			goto huge_unlock;
+
+		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
+			*sz_filter_passed += folio_size(folio);
+		s->last_applied = folio;
+
+huge_unlock:
+		spin_unlock(ptl);
+		return 0;
+	}
+#endif
+	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return 0;
+
+	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
+		nr = 1;
+		ptent = ptep_get(pte);
+
+		if (pte_none(ptent) || !pte_present(ptent))
+			continue;
+
+		folio = vm_normal_folio(vma, addr, ptent);
+
+		if (damon_va_invalid_damos_folio(folio, s))
+			continue;
+
+		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
+			*sz_filter_passed += folio_size(folio);
+		nr = folio_nr_pages(folio);
+		s->last_applied = folio;
+	}
+
+	pte_unmap_unlock(start_pte, ptl);
+
+	return 0;
+}
+
+static unsigned long damos_va_stat(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+
+	struct damos_va_stat_private priv;
+	struct mm_struct *mm;
+	struct mm_walk_ops walk_ops = {
+		.pmd_entry = damos_va_stat_pmd_entry,
+		.walk_lock = PGWALK_RDLOCK,
+	};
+
+	priv.scheme = s;
+	priv.sz_filter_passed = sz_filter_passed;
+
+	if (!damon_scheme_has_filter(s))
+		return 0;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
+	mmap_read_unlock(mm);
+	mmput(mm);
+	return 0;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -916,7 +1019,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return 0;
+		return damos_va_stat(t, r, scheme, sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.
-- 
2.47.3

