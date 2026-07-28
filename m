Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F74734E7
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268052; cv=none; b=ckW8nffESzzW0hr9iIOlvSxi4vYdlG2Z4XaMMoWeqNMDSq2MYfmawdXJ2x71ZEPD9CGukLP+4k4ETJhkrIPtNudeNyGVr9+KRA8fV6uDqA6dD2tT93p7D79lwfzoA5HiwMQ3F6UINm73u9Hwk80yyy+kWh7lk1VZ6DiTZD1WRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268052; c=relaxed/simple;
	bh=kIrfus/hl/pctQx7Y9xBksIrFueXRHfHKGKjTDmfFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9QGwmJs2rK2gAGuBEr7pEExlery8803HAliXAatQwidycMiX4rjQRRUloLorf/DRFqLjw7yofF9RmF5whgDzOqFASeyPE+j1EHrZPPRGW/WJBFlp+HKiRmWfFAmvE60hElXfireWjHlp3MMYGVjxl406u1EjCAO48FMu4J/oF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SGb0BFkw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SGb0BFkw"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-902fc790cd5so1152686d6.1
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785268049; x=1785872849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFasOBUZoPmfk9ObuRJF8YRYjBN1D6LiYKjqRhex4gk=;
        b=SGb0BFkw36wSc+4MnQCKQs6tHiKpaCgih55oed7Pj/rx1+oXsuF2fV8ojGue4XyQvN
         36uqP/AtzttgmTBTeMuTbCn2vcSPTBxb7cIzcMHOIQB4cW2cEh0a3x0x2J8hZ+zSm7hE
         I4zcW5KqF1Vs2rwmBrD9PaXt/LT++AKzNAUq/blODwv4/73GOyWL4xOGmwB35TXbq3O6
         w3yYiRb8WI0NwxqMuJ+jTgIw6c7kaP4EHFyYRolmKJh2/TeGIqLCrdip/Xy6Bxy+txS2
         d7AkoA+upvr66G1x9m7v8L0WhwTP0tnpG5Y8B0HRrmBOGVn9HMJ+Rsc8pDjD3qHrInWD
         Qx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268049; x=1785872849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lFasOBUZoPmfk9ObuRJF8YRYjBN1D6LiYKjqRhex4gk=;
        b=JKfQzz8vlhMOZtT5B2jUaMVIwXtds2ibu0V6Xs8+nFubBJuB1qIfe+cpppOQtdAEAc
         SXE002RUG+2eiZSQfYjfE96ZI1NNXljfexrAmgzU+wYYluzacyLrw4YMUqgzx7fSo3M2
         RqkR5Ol11Geha38c/YJGXDGCXB1517+fINLW/VbZF1Mh6JzauCGDELXmNaHs4ywVyaHU
         m2vn+5TRv1R5UKzKIXu+lbea9lhahliRBzdwLDMl10db4aPiUPOJUoP1QSANhGzxv/UL
         jFFcr/kRTOFyIk0843nT0I6jSc5UkyZCamxZJ51xPnO1FBj6YFGWYbAwBDDWRiXemFFp
         9T3A==
X-Gm-Message-State: AOJu0Yz4oyE6pOFISgGR20yZOHN85mANF6YIMbfjMwvo/aY9fH4eObcU
	sHX8ufWPH8fdVIrhbDN+zY5tQB8j7GkzJkYauAPakOQtKNOgkcoedRMz62SDOmY4y2w=
X-Gm-Gg: AR+sD11ZrQYgcOt+RWFLtKuexSQySB9Wq+ORncGgg6sila3Len0DMxxSs5NQGKWkR1m
	T4G/kDIMmRWwcODgo5Id4PE9LW7Lym8gKou1/qQY+rB5b/gAT+RxV+ioriIaZyJURASgibB66lG
	cpU45EMhN+T1yTugF+6F5EwDwEHoi2So+D+UjI2yuQuVqUSEmXAc1Vdc2VtnpZD4MCgpyXEvjcn
	no2ZPPA+Cslaw39CvHNEyV4S51pH80SjRrvCifOfqo0sGFKU97Oe+V4tXtKg/w/z2Cxq385UVPh
	l/2Ukc61O7sdEeuMpREIPtdFmAcM9gZbpMSwohZdzj+qU2U3ekp5J3RPSKZSh8/ynr+yi05ti8E
	/6ttWuDzkWpEo1TvWY5WDhUvJx6POvXEDkp74uY6bKvroR9KdaJSiKuZw4jZXRcw+vbk5RWy+20
	p/B3bmZ6rnlT4RWn6HVrPOOqaO7eJvoMpl5JTnKrTXYZPB/l4U5eWXhqj+gzC0aei11BkvB9LZk
	dT6G9tzr8aqAydcyP9MoAv+ZG7ODwxHNn6G1UODQo12gO5NkQ==
X-Received: by 2002:a05:6214:4847:b0:908:1bd5:9c38 with SMTP id 6a1803df08f44-9081bd59cc7mr30163246d6.14.1785268047908;
        Tue, 28 Jul 2026 12:47:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6b539sm6700176d6.41.2026.07.28.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:47:27 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com
Subject: [PATCH 4/4] mm/mempolicy: skip zone device folios when queueing folios
Date: Tue, 28 Jul 2026 15:47:14 -0400
Message-ID: <20260728194714.3713735-5-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728194714.3713735-1-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_folios_pte_range() already pairs vm_normal_folio() with an
explicit folio_is_zone_device() check before adding folios to the
migration pagelist.

vm_normal_folio() alone does not reject zone device memory (a present
device-coherent page in a normal VMA is returned as "normal").

Mirror the explicit check in the two other walkers.

queue_folios_pmd() uses pmd_folio() directly and can encounter a present
zone device PMD - e.g. a device-coherent THP.

This is not filtered by existing checks:
  !pmd_present()   - only rejects non-present device-private and
                     migration entries

  vma_migratable() - excludes DAX and VM_PFNMAP.

The early return also means such a folio is no longer counted in
qp->nr_failed under MPOL_MF_STRICT.  This is the same pattern used
by queue_folios_pte_range() (skipping zone device without failing).

queue_folios_hugetlb() cannot see zone device memory - hugetlb folios
are never ZONE_DEVICE - so the check there is purely defensive and keeps
all three walkers consistent.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5720f7f54d94..bd79e61a40d1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -668,6 +668,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 	}
 	if (!queue_folio_required(folio, qp))
 		return;
+	if (folio_is_zone_device(folio))
+		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma) ||
 	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
@@ -797,6 +799,8 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	folio = pfn_folio(pte_pfn(ptep));
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
+	if (folio_is_zone_device(folio))
+		goto unlock;
 	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma)) {
 		qp->nr_failed++;
-- 
2.55.0

