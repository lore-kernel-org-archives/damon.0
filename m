Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34E4266AE
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906465; cv=none; b=Eu3EVesGNZk54ikT3CzYbGpYzmZp1TBUVV9TvRbpf0gMP+YiY8RG9Kqa8+UQIHZl0A91o1bmaySX/pHv5MTy1MmMgaFzQnxJSMRJL+SrPhEix/YH5/yjltznnFXQ6eoMMw9NG4lVwdp7jGRBQpNSVoZm1xfeREjYuSx4nInkiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906465; c=relaxed/simple;
	bh=JAzsI46xUUb7MY3eGvanhcLRnqm8mrwI8JOlp9MJq1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbZliggkWjW8S7S66V46n3SETz8rFCuke8t488cUyNT0GDqNwt1yIMJh01h0tn+GyqSox84n7Cg3lAYM3lEg6se6sm3KybAVl/smLdX9rTAlyRXAhGDjl67aA5AtjgVACASr0f9+W70E98+dy8Lj/vUvlza0W4i3Ql1FOJ0zPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je/fek8I; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je/fek8I"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30eac9abd79so949846eec.1
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906463; x=1783511263; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5mNQO60b8nT7uv9aRlYZCg/3s0UiXqqPoo14TkqY90=;
        b=je/fek8I6eFuKkVhiXGcOJMMZ8GqPV9RJPTVg0sweXfAy4d7M9Z/EQTIuOPy7eLs5d
         JtM234zkI4NiIeZI1u2MhslWJeHtrJCX4yFbG8XyMHcXawnBu8q/hRQIZS+dB7dryC2f
         Vt8Fnc2ftotqDclaJRzUDql7ry0J0eoZXScqWH8L2V8VQnBMkTK+d46PZBDMG/LU0QFy
         xsKaLWus9uMdxzC9okbmIrwPd3glauWDm63aUkmkh/KX6mK+uetlnYG2a7CirziUXd/o
         oSV5FemdofqM6tmtNgfqURnG+9Gh1ceumhhVN2wx+i9M30SfAsRu1NcLUmtWiFKgko++
         yx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906463; x=1783511263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5mNQO60b8nT7uv9aRlYZCg/3s0UiXqqPoo14TkqY90=;
        b=GPj6fbNmlW8aSd7qzs8HMChmbszx4WOEdyiyt64BIv6lZbJg+kvYyxfwJ+EsTRbBEE
         MYh5Tn9a8sKUk+R8MDIYbUdtG4y25EJXLLprH0DRpkNbVuUXqa2CkTNTqCLlPh+aBLt0
         gx2qCe/IxoikNaXG6Hjl5nqzRa2qPAv79gWe1AdwAbVWevfH1Ujhmk8jfaVDFUSAzf9Q
         RqhlZ152h57eA6SoEuxVzkW8xyl2RPeCaRydiK3WtmPL3MwwtAlnfDCZqREYSTa2cWBL
         +28I3OJBPegUKChEHFcQO1q+Oyn5JFYqy0tCpoB/9C7MqWh2iLO99O8O/i/EduDGqmQ3
         E1KA==
X-Gm-Message-State: AOJu0YzRwTF/MpBn/AbZOq+f+e30a1XlarRbQnHQRATp7M7NLc5d3Ma0
	hC1Mwdo6blSZCLKG84JyBtc+u8WqdEScfiVnu0nJIfW+9WCwSPxqxwTuHOYJcJIk
X-Gm-Gg: AfdE7cnmUl6d7sErQ1VK0xMab5DI3lf4NgWWD8hSRU11djh/oD9hDqzvC1iH/No6UT4
	x5Rvy4dT0Qfl48uEA503D4afMOg+oFWgL6wxtJJVVR780HRw0V2ZqSs7Vs2vEtttzET5ZcZcsLx
	H+StXeCtuqK4xEMlnkDR4Gr2N8xZQ33xXvs2iMw4ig6WGwt/I+keR8iuZjhkgdvug3EEDtMeRZi
	H110cA90ppkk5ShOO+/hq+Ey1lBipycQQ+J9oGr98jOoxdtmcvjbhq6b0dzDLgUEkgGgazNZRh7
	PI0k5IzEh+fXTMw5vNnohJ5AtrNajr3Quampk0u4xtHdk2g8DxA0IWUoyEOqObGzwFOlZwMivB3
	xlsZOyjZ+/ct2JqUvK8MRR6cjX+OXfBTdaHk/USEUT3ebqDTObmDfiI6kue0vv0RcAkPfdW1fSa
	71dw==
X-Received: by 2002:a05:7300:d50b:b0:30c:1865:d9e0 with SMTP id 5a478bee46e88-30eff07d7fdmr1439014eec.16.1782906463047;
        Wed, 01 Jul 2026 04:47:43 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm22518169eec.31.2026.07.01.04.47.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:47:42 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT handler
Date: Wed,  1 Jul 2026 19:47:16 +0800
Message-ID: <20260701114716.56503-6-lianux.mm@gmail.com>
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

Implement the vaddr operations layer handler for DAMOS_SPLIT.
For each folio in the target region that is larger than the
scheme's target_order, split it via split_folio_to_order().

This supports both anonymous and file-backed (e.g. tmpfs/shmem)
folios, covering KVM guest memory backed by THP tmpfs.

Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.wang@processmission.com>
---
 mm/damon/vaddr.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2a3757c13bf0..3f2061b29ed8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -934,6 +934,71 @@ static unsigned long damos_va_collapse(struct damon_target *target,
 	return applied;
 }
 
+static unsigned long damos_va_split(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	unsigned long addr, end, chunk_sz;
+	unsigned int target_order = s->target_order;
+	unsigned long applied = 0;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct folio *folio;
+	struct folio_walk fw;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	chunk_sz = PAGE_SIZE << HPAGE_PMD_ORDER;
+	addr = ALIGN_DOWN(r->ar.start, chunk_sz);
+	end = ALIGN(r->ar.end, chunk_sz);
+
+	while (addr < end) {
+		mmap_read_lock(mm);
+		vma = find_vma(mm, addr);
+		/*
+		 * split_folio_to_order() supports both anon and shmem
+		 * folios, so we accept any VMA that has a folio at @addr.
+		 * This covers important use cases like tmpfs THP-backed
+		 * KVM guest memory where cold and hot pages are bundled
+		 * together in a single PMD THP.
+		 */
+		if (!vma || addr < vma->vm_start)
+			goto unlock;
+
+		folio = folio_walk_start(&fw, vma, addr, 0);
+		if (!folio)
+			goto unlock;
+
+		if (folio_order(folio) > target_order) {
+			if (!folio_trylock(folio)) {
+				folio_walk_end(&fw, vma);
+				goto unlock;
+			}
+			folio_get(folio);
+			folio_walk_end(&fw, vma);
+
+			if (!split_folio_to_order(folio, target_order))
+				applied += chunk_sz;
+
+			folio_unlock(folio);
+			folio_put(folio);
+		} else {
+			folio_walk_end(&fw, vma);
+		}
+
+unlock:
+		*sz_filter_passed += chunk_sz;
+		addr += chunk_sz;
+		mmap_read_unlock(mm);
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
@@ -967,6 +1032,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return damos_va_stat(t, r, scheme, sz_filter_passed);
+	case DAMOS_SPLIT:
+		return damos_va_split(t, r, scheme,
+					  sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.
-- 
2.50.1 (Apple Git-155)

