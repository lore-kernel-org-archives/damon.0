Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCD2D6414
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487311; cv=none; b=TGCcYnuQsV3O3u7f9dw/hM4U2lZ+rvZ+YH2RTmXlYA1rWp5wGG4qxYS2MrcjVwz/XAtJg2jlpNN6FfQzNtea/W6Wp/xG4L7VDKGkFuJOVKdqH8/8ZgNehRncXBXgMRPTgS8ap0P4rZsqJNMlSjnMtLKxrDh3+P6RCtGES97pWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487311; c=relaxed/simple;
	bh=G1+nrJSlCuTm5ni6kCD8sus2FYIDGsIfqepvM+zEZ2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6QIIe52GwMVX3vvSTKqrY/PIsP+7X7c7QG7BEWTFvlc9DAMlXXSpd2nkyUiXSzpT1vUIrk+QhFAJGQgYWypapXKC782MAyPDlfj+BzELykoh5mGwPyKrXiG3PM4/Kvj64NqqUZbH6MHT767m5kMLenUTAjXIPwlxkJf9CyB0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io1DRoEk; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io1DRoEk"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e818a572828so5044731276.1
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487309; x=1752092109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMg5BL0bm2K3XwrpoVYC/9dFOzEmi6T120k7I9qtnC4=;
        b=Io1DRoEkWHNsFguU4lELfC0iA0DrOD5xsNLzcHxsGr2GbPv488hciuf99hhbSm//Oa
         jvt8+33CaH+xfbZMDWokluRK1MP4hJV2QOn1wE4RVJmAv2Wq+TyA6iYEuHLWqhl8zDWH
         wx64Bh4ExvQMKDelEBAaPzm/mftDzHabz/NKNkZCPXVpybftKsCPPZGhQHQBq1Szekch
         Lb/biz6QoyGm0J+eJdwRsQekwv0wz+w5QL9RkQooge7WywROHVVsqLELbhcln7j9C97F
         oonxWOLzkfufwf7USRM4NEQ6ZFpM3ppm2uWBPqjuYc8ijUjBDDYlefbg5IAo9Afc8S3b
         ML3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487309; x=1752092109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMg5BL0bm2K3XwrpoVYC/9dFOzEmi6T120k7I9qtnC4=;
        b=mFIvl9VPFE7Oe1lWf03Zo9MyXpV0o5r33iMCztFcYvDMAkw/wJt2mEwv8w+Er+tUmH
         t4g0rkIKzGYWj4xY1l4BbBb4U2O4aoLS0gd2x+naATQ3hibPb/PCp8TGJfR7uF5G+VA5
         CcTqxSjeDp7hsNmI2A6xsFyi7bevAZMngdqR5uSWQpX9P0HCK8yd/Rmgs17wmj7/LON2
         iFdiuVq59f5Y1WKbia2eYZ+qutvWCpRu+c8nokReyze6I6GhsZmFKwrFOKMDzUNnE5kQ
         YwSej9NafQL5Mf8fTDbXqhGGNeq2RkZc96QrqhsJ6ukPOgyZkswlE5BxcJ3YDFWD9Kvw
         Pydw==
X-Gm-Message-State: AOJu0YwMYNZWYafLjbZTBNy9znX0Rt8V3GAIVzRsjDmZfoH5jva7iQ0j
	r7wMaXNHRLs1IJnVn2Daw0Yg3jnmuLzmiQCZDksBAXKImr6oAwI1Ei6gpoAeRAtcl2I=
X-Gm-Gg: ASbGncvMf5TC4Eevk9ZRWa+O87WOmBLyYB1gL1NEsyu+h7aZa7QRaz42SGKV+X38DWK
	eiYwXm4AgGzYmfo8uj8OTe/cmwPKO4Y1KXHhk4yUtq9v/LOv5gyV8s2dsb8RhDJkSmSHQm4OKUN
	1AdcQAYlopkjuOutlA97Lu5jj4NCFrnkUBmB902itmDREqSlkhvNG42fPg9tbZto8l1osxZM+0L
	61oi4igBPy7EeNcF5tivvRdOpuvzqOi4N3Urp/alrOO7GyBcwQObzYeJwtkCl/TwfZ+tSr+1BKB
	bXP3QomrHpVzWBq2DBG9mKYenURZ62Jzd9r0sGo2+YFHFvKG6Tk7rRj4n02QUy2VD7xxPIDTESC
	JnqVjsKs=
X-Google-Smtp-Source: AGHT+IGKvPDCimyFCg/hqso7aOb/BUUZpqnaqOXEPoQpEeHLKPtOWIiEclbT23ZwcvqRjO6m/wd+RQ==
X-Received: by 2002:a05:690c:6701:b0:70e:a1e:d9c7 with SMTP id 00721157ae682-71658fe3499mr15332597b3.10.1751487308762;
        Wed, 02 Jul 2025 13:15:08 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:15:08 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH v3 13/13] mm/damon/vaddr: Apply filters in migrate_{hot/cold}
Date: Wed,  2 Jul 2025 15:13:36 -0500
Message-ID: <20250702201337.5780-14-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
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
 mm/damon/vaddr.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 5f230a427fdc..2a485bf19101 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -611,6 +611,62 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damos_va_filter_young(struct damos_filter *filter,
+		struct folio *folio, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
+{
+	bool young;
+
+	if (ptep) {
+		young = pte_young(*ptep);
+	} else if (pmdp) {
+		young = pmd_young(*pmdp);
+	} else {
+		WARN_ONCE(1, "Neither ptep nor pmdp provided");
+		return false;
+	}
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
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
+			matched = damos_va_filter_young(filter, folio, vma,
+				addr, ptep, pmdp);
+		} else {
+			matched = damos_folio_filter_match(filter, folio);
+		}
+
+		if (matched)
+			return !filter->allow;
+	}
+	return scheme->ops_filters_default_reject;
+}
+
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
@@ -695,8 +751,12 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto unlock;
 
+	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
+		goto put_folio;
+
 	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
 
+put_folio:
 	folio_put(folio);
 unlock:
 	spin_unlock(ptl);
@@ -724,8 +784,12 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
+		goto put_folio;
+
 	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
 
+put_folio:
 	folio_put(folio);
 	return 0;
 }
-- 
2.43.5

