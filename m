Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C581B85F8
	for <damon@lists.linux.dev>; Tue, 29 Jul 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797221; cv=none; b=amCkvgTIqVhHizXeUMQ0mkwcPpv2h8oe7IsFALTxM5udqPYYZcgrLgwuoZkeXSrbR+77VrGdI6QmWhb3ONeF5ueNeaA7XbYJQajepq5o12Qb6/sFFp9nNZ+ddP4JQzf2sEw/7eC+J8W8kjHSn8WXXpX3fJlQrUlc5Ja1QQArUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797221; c=relaxed/simple;
	bh=gn/ZxVTX5/lp0cVWN7QNeZ6XIyfJ/CVMnXdlO6bojic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5TPRI+QmExQy3RHE6pePWnTsze/NZXMrXw2tZvDF1THR7lg1Y7eQBdS5WZ8kj8+ujHFuIFfEqNDlS0btS2NNYFFterjqgc+gnBhkvnnWx3ehP1Mx5hwxL6J/ZgY0WolKTgqpaca8RgnjSmQqOoOhv1wwRZNn7VKL0Wzy4Gr4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7y4TETR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7y4TETR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b780bdda21so3228335f8f.3
        for <damon@lists.linux.dev>; Tue, 29 Jul 2025 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797216; x=1754402016; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iBOO3HPD83Wia82eo/Lz71fr158dDJN9X6lTtZnvkw=;
        b=m7y4TETRflxXU38Li8jfrw2gQYqxQvSs5dupnm1eElJ9hMzEqRtH8a+iC+uY8ltePu
         BD4F3fLykJtor/wMc2cjgzML17oPhAaoYaQl2LYtOCioMuoSYhgzmF0SCILVXSK2ZaF2
         ZlcqXMPO1Lh/Wlin8dh8LvsxaaUagWgo8/wnEk2gOxlsKr/KU5lQZj+BqiEIQbFm7BUb
         xtlMcUs8aYuN7CP8NT8jkRt/YLl9FrKU9tjZTM/vkj0m4QYLEiEjerq6z0y3Ua9SAR5w
         LhIEcY1wewMnAtS/JaFxGRidEeAYcxbopaQPuvbJ4eUNNhoMqvSfMKho2JsPzzGoRtZI
         EAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797216; x=1754402016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iBOO3HPD83Wia82eo/Lz71fr158dDJN9X6lTtZnvkw=;
        b=o6mf8EREtDkAJkRcBZqK7hbHtfcy5bHRAcfK2spXd1B8OAfADAT57iT3IBP/dBiC6D
         K7xF2jiOQqo9+5545IEkTD1yzoeYZhz3Pr8SK/mdAEqdgBl0wMI2KPSqG5Wn872fi6SN
         qXC2s6eijk6LFThVuGcYoMvbPVa9Z1WlDAKZ6c/QV+QinIeqtDUJqrZBBhWsJVwLCgkr
         mpqkaT00zuPlqgS7TR+1D+rTDsU7yZOo5ao9Tjh/8Xh7phNjloBU8ITU8BLXFPcGsFMj
         /fqffrdqLLL1hpUo6cI3r3gyHzU2RD+ssc03quR981HjI64t90ORcTdrB0OpylXSZFHn
         TRnQ==
X-Gm-Message-State: AOJu0Yw7pdKv9e5btA8uBgw5nxNrAXBAOw//5UPBKD6Q3a0yVuTSG465
	ChkXSiWdy6p/PMmpRurWJjWvWi/4lfaACCMsmrdpj2Q2eO4woaWO7F+z
X-Gm-Gg: ASbGncs/k6T0NI7D+LnThsoippyHHfOrRZKkENQUzuYNltNw5rxZo9BqVJCqRSaNc5Q
	bsCHYBuNnRmyZR7u7VbqW2S6wkYTVS13xbW11tqsbO/nmh7n+JWtjc+o86oLKgo6AwIAVtxobSh
	l8yzofw+tMBMK9T8nTovSvljZwcQTDzzNSdGqLjHvD2DNpx1JX97d1GLdfDG4tJpFSjE4m1MrqU
	KFK0VXqmcVOkjYDZxWF1ycbptA68XahdjRJ/dDts+EQ0Rck0nLIpHEc7gEDD0D3t0XNogsuPfET
	pjVn1VIeTkFAzer354EgMzUL+7YGhtI6atLP1gApi0khwgrueKr76IAthsERMfP1o4znzYa01pD
	ea4TDxm+7nknne1A=
X-Google-Smtp-Source: AGHT+IEIprs1zggr9FmpwKbpcHvwinjoIgq8TSbS938lrRqegcHD6kkTnyQRwqNGGJHiAYpAFwrfXA==
X-Received: by 2002:a5d:5f93:0:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b77672df06mr9719092f8f.19.1753797215638;
        Tue, 29 Jul 2025 06:53:35 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4c::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778ebaca7sm12658402f8f.30.2025.07.29.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:53:35 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	PanJason <pyyjason@gmail.com>
Subject: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 06:53:30 -0700
Message-ID: <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753794408.git.pyyjason@gmail.com>
References: <cover.1753794408.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PanJason <pyyjason@gmail.com>

This patch adds support for damos_stat in virtual address space.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.
---
 mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..3e319b51cfd4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	return applied * PAGE_SIZE;
 }
 
+struct damos_va_stat_private {
+	struct damos *scheme;
+	unsigned long *sz_filter_passed;
+};
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damos_va_stat_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
+	struct folio *folio;
+	spinlock_t *ptl;
+	pmd_t pmde;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
+		goto unlock;
+
+	/* Tell page walk code to not split the PMD */
+	walk->action = ACTION_CONTINUE;
+
+	folio = damon_get_folio(pmd_pfn(pmde));
+	if (!folio)
+		goto unlock;
+
+	if (damon_invalid_damos_folio(folio, s))
+		goto update_last_applied;
+
+	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
+		*sz_filter_passed += folio_size(folio);
+	}
+
+	folio_put(folio);
+update_last_applied:
+	s->last_applied = folio;
+unlock:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damon_va_stat_pmd_entry NULL
+#endif
+
+static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damos_va_stat_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
+	struct folio *folio;
+	pte_t ptent;
+
+	ptent = ptep_get(pte);
+	if (pte_none(ptent) || !pte_present(ptent))
+		return 0;
+
+	folio = damon_get_folio(pte_pfn(ptent));
+	if (!folio)
+		return 0;
+
+	if (damon_invalid_damos_folio(folio, s))
+		goto update_last_applied;
+
+	if (!damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL)){
+		*sz_filter_passed += folio_size(folio);
+	}
+
+	folio_put(folio);
+
+update_last_applied:
+	s->last_applied = folio;
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
+		.pte_entry = damos_va_stat_pte_entry,
+		.walk_lock = PGWALK_RDLOCK,
+	};
+
+	priv.scheme = s;
+	priv.sz_filter_passed = sz_filter_passed;
+
+	if (!damon_scheme_has_filter(s)){
+		return 0;
+	}
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
+	mmap_read_unlock(mm);
+	mmput(mm);
+	pr_debug("Call va_stat: %lu\n", *sz_filter_passed);
+	return 0;
+
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -916,7 +1027,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
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

