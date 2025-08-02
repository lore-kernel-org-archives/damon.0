Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAE22A1E1
	for <damon@lists.linux.dev>; Sat,  2 Aug 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135588; cv=none; b=Q6FlmyNIQEmKGozr7aRrVGel6nlTLjL7alqwwJCG3IXt8PtREyDCBSdmXVwkIENbj60Z2w45Q/nMixClIeUWnG23Tz14voj9KgjDYqqnucVJsxSpJOdkMNdeKFoaTfkDRo/E8V8q1XE/4t9da7IPBXu3Z3WB7Q2gHlXePZPERpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135588; c=relaxed/simple;
	bh=OIhIEnmvXQYdWkNBzBDAuw6VY0qCIErnN1M9pziIRrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR1lc6FvqKHn1XDwqLW+EE19sTi2NIvF9CmKZV50GrunSRfy8ivtXlpAZxEtu+hSPTYvc9UIj3lMnWvBpoBxrI5vhF7KC/CfhxBqcTvUP+cu3OEeUs46xLqJd9XQd6HZxREH/W77N1U/vF4zsO2j77tCXrrhvx1zgPfN6/T1o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFmbhiFi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFmbhiFi"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso5150519a12.3
        for <damon@lists.linux.dev>; Sat, 02 Aug 2025 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754135585; x=1754740385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l1QuFgekZN0Ih/n7UkLBKW9hzcvuL72STInIzLZ4ZY=;
        b=CFmbhiFiGESdH/ZNafEVKT+7NpXPD9aKdBCjpQ5dyJuxWuosuVNmndN3/F8Ti6c0YM
         2StoSM2uiqUQwSAJlOwqn3FQlPZM8fUeICJGz9UoMPZ3bIOmHJ6n0G9sQ46ZTmVfzzfX
         qug8bzbqMzPjJX44hvYYgPH0korZGXdfO5CjEjMLDDBdJmH2QpytTZ0m2mtHmaOZ/wso
         hXOhsyX8ES9EPtnztm3jSDW0oKIhuuPuzTkjQF9bORRFD2MssqGwjPKZKef5VaC6/26g
         ZjJ5DvyGhZKYhWai+w6pQCUvqpnJSWhGHuqlwfbYOh3T6ao5lD/knn97/x3arIy+kPRN
         TfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754135585; x=1754740385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l1QuFgekZN0Ih/n7UkLBKW9hzcvuL72STInIzLZ4ZY=;
        b=sj2oW9WbgQx1wptQKrjwOFrrOqfYtDfItSohO7wwmDvnjRkr/s/d2xZAaSuab3ohhN
         xOZSWtkApLqEhealPyMMLtNt8Gbdc1I31p4EkqZXSLGUZYPYIM3mSyBPq+/klTk62cMP
         b9A0E6TaGZBtJy/4ccy28tbP5CVH7LbZ2f5JZqv88KNNZFpUZ+NKuVhQ+uHToX0IvKvp
         K3ulAF1K/JPveUHuoR43uyKA6Fbn3YwEXkEZXi31bzGy2lcvqwqFKX5wVjRUbX6AS50/
         4E7OCQnCyrrkDDKNFzWTM+GrVHuy74AO8nNeWw9CbymUqdRk6kcoywja3fkbM6DYnNj5
         w37Q==
X-Gm-Message-State: AOJu0Yw9w4kASLEsaNuGa388teOgK//I+Z0nQmYQOo8uSKk4EuZRw+/w
	dTXEGz8DiLEWO4hvWUsoyAxNgqW2qDBgFyIJEiAirUd34MunN/vkWcuv
X-Gm-Gg: ASbGncvLNmI8bs3xyk1I4jt9sROODFclIdemnFuT1/gUwybhSRCSOyCOHxDhLIvffuG
	WqBthOaSB0r30p0btGoS/4Rxv0IEj2HCnZrL8PnKYjWBzhjMZ9OZwex5+2U6WlNYyaBq3q5as/8
	0s5WTqowK5S0sGL0kCxB6AuwK9q+1B1iHC1cyGeBbz5g0qfI49gmJLUR8LVN1qtkD+dy4MKfW7q
	R4/OeMIouR+v5RzEHRR8YouqkNbUtRm8EkSHK8wJoLMqJM7LIzIYhujPnoyMmakoGrAskKLeG0A
	AdqpTqOaj+1hhoGFiZKFKE0E3Al/xvgIgoho6NoUwaBeqL1ANGPpwwjyvI/nucKQmpywi5FRorH
	UC2LvgGJvCSZEslN89Qn2kGvBzBz2gs6iapyW24Xcm7FuKPgsEti6bIZP+UT6+yDcc2jr9+c=
X-Google-Smtp-Source: AGHT+IEp2fGxaGZZ5CaBRX0BcTcZyFdhDrJCsMO6vtGysJGYlHpKp+oG0jgs4nIVGThUtInH3wGG+Q==
X-Received: by 2002:a17:907:2d27:b0:ae0:a359:a95c with SMTP id a640c23a62f3a-af9401adbf6mr294558466b.34.1754135584954;
        Sat, 02 Aug 2025 04:53:04 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm425028166b.20.2025.08.02.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 04:53:04 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v4 2/2] mm/damon/vaddr: support stat-purpose DAMOS filters
Date: Sat,  2 Aug 2025 11:52:46 +0000
Message-ID: <264a4b5ea202fd73c01b349c9694d8bf9978c441.1754135312.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754135312.git.pyyjason@gmail.com>
References: <cover.1754135312.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends DAMOS_STAT handling of the DAMON operations
sets for virtual address spaces for ops-level DAMOS filters.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/vaddr.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..66ef9869eafe 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -890,6 +890,107 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	return applied * PAGE_SIZE;
 }
 
+struct damos_va_stat_private {
+	struct damos *scheme;
+	unsigned long *sz_filter_passed;
+};
+
+static inline bool damos_va_invalid_folio(struct folio *folio,
+		struct damos *s)
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
+		if (damos_va_invalid_folio(folio, s))
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
+		if (damos_va_invalid_folio(folio, s))
+			continue;
+
+		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
+			*sz_filter_passed += folio_size(folio);
+		nr = folio_nr_pages(folio);
+		s->last_applied = folio;
+	}
+	pte_unmap_unlock(start_pte, ptl);
+	return 0;
+}
+
+static unsigned long damos_va_stat(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
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
+	if (!damos_ops_has_filter(s))
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
@@ -916,7 +1017,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return 0;
+		return damos_va_stat(t, r, scheme, sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.
-- 
2.43.0

