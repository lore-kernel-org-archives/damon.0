Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93301DF98F
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060599; cv=none; b=cx74IKxtz6qNRKDBfW+0mbFVV5CDntHA8m2fz3+Invk4c33+QF9kx/NHNxxZHHvv9JZ7MTKK3mWfGJwAqurCN8hgSp22N+orrJhGXs+13X/v7vyaSdPPEQ6WOwbky+05UxDm/lno2GfE1eZTt9VNWiju+3JlT/w8Qdx9Gi7hjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060599; c=relaxed/simple;
	bh=A8owNqUmKrddFiv3sxwqZAYgp8IhOnZKxvxLH1qdKhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdmNYlkTRrKnr+ewH4mSXbMpHT+HJ6T4DH+Ln+3aK5T9p9Jty/z511hD1GUNasNyhQFECbaALNiIdDIxZAFvZP4Ba3Zb9C2/1gHCwmdTcr2o5M9giyO+kehqULP993wTO3iAW6NH5oq+m+6ddN0upG3TA0uZ4BaSKHwpxV6jo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp/XWvsQ; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp/XWvsQ"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-857cb570f53so29164167b3.1
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060590; x=1789665390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U8F+pCWHvp6Bk2nFVk5sf15ui0cPT96FgZ/ARqD+0QM=;
        b=Yp/XWvsQrqPgN5zUe/NKCLsOD511fhrKN5ozmHfP3o81OUVOe8KLkAFikduoJW8rw9
         yFxIQO5ZU0fNvesVHbZmJZuQxxBxKXzmj2F7oBMQHG+N6FCE5+fer0QfAso0N2ROup6u
         mdO7VIVys7vZuwb9zwE4u3GDQGY9LhRUv5QfdZr2/srm4giS9MeoAWXZDP9YzI1rF4KT
         HyCk5c38/2ctFNaAmP1ki+E7HP4wWgCMHglAZUcKr/p/v3yuxowQdQ7+fFCIGPHXK4JW
         CxZXNUYDyp+/5npWf9IOp03azJn8rx3EHj9cAuX71pFR0cN5ZIKeqkldsUvUdC6tCuPZ
         Sg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060590; x=1789665390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8F+pCWHvp6Bk2nFVk5sf15ui0cPT96FgZ/ARqD+0QM=;
        b=Oh1mTvJekh8dA8iom4/i3T7lYE4DGeyvA3bAqNcuQ69lhwqHZg9tUjS/CBob39VZ7I
         6W8wv0KZC/N54eQZos+fYYDWWDB8H7L8OukAYP28fmPzo0b8CYBoeRWcOQlCZ+jqKiaL
         iJ//ALBJSG2Yi3Biq9rOwfVzwlgZmQDk90W8qO1S9BNDDL2TZL5HR9J5X95Jzd8S8eKc
         5GV0GINJHStu6WzJl2nf8kCER1i4BNIvMYUEqRQmehH57hOaQxJJlz2P1XAMlpb+x/XP
         9fErgjY+D0JaoDJV+VxJ5tHy0dWCEk3MwMoDD/eHwabc7h2s4p2Ncn8GvN05iltJO6AW
         nmSg==
X-Forwarded-Encrypted: i=1; AKwUvBxvYLqE6v9vS36jpPmqIajGujVrXKgvFDg813vGsPRO4G//HpTMCQ9+ZidRqDewcUVre+F4Vg==@lists.linux.dev
X-Gm-Message-State: AFuF++lZA/woHbBBl1BNmE820w631SR3/Vhbxm7H6F8G2EmAhMVVrjQ/
	CW0ECS6trY5TMk13lcIPgSX0T+Axqu0pVQI1SPRBezbg+pJj9g0vneU=
X-Gm-Gg: AYBFou1P4DiCimMiSGCefivtLeq38XW/HC2iaNX3yR8usJ36dIFbFVDrOH7Al/XvbEr
	GpQP73n0TqfaNTRazA9T0G0KLQvlgg+abvYrSU1vqKRx3B/KpW+wt/CzlkXfskcygUrZVAiqVYD
	MUl+37Zjke7NC/wCGXKZH0w+vqzvSffwyg2MYpmPMSqPdYtkH5+AHUsyN6ieyFIycO03A5Zvvbn
	pS5TgOUBae0PS5MTHihx8KURCIzMz+nVkgxMdx4do4a3LNkjq+ulq1LU86UgtD/KVlR9K+D4Vnj
	Oru9LpzPB+vDBkRuOpzkZzsV3aJTtScymAb+PAKcypdpPTJxYX+s3k4Ry5P6x6hi/o4Co7tWZ8B
	J5yfF3xTTlmDKx2kjf1dajETfgvLXVQEl4g6Jir3daFcIi4z3F3eGlFNiGjt1pRkT8H3zfyyuOm
	d+JKEoXZq8v3jEwuukd7oPZcD88Paatk6HLFZeUcvxN7wt98a4LKeKQEyMMP1CTyJTwXtqVRdz6
	Q2seLFCFznZ+fGLNLYvRV6bqpXkZBS+QDYfA3khlthLy94ADNkdRzVHexO2
X-Received: by 2002:a05:690c:d83:b0:865:838f:485b with SMTP id 00721157ae682-884ad14f632mr2358197b3.4.1789060590335;
        Thu, 10 Sep 2026 10:16:30 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884890160bbsm2241007b3.42.2026.09.10.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:29 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 1/9] mm/damon/vaddr: support page fault access check primitive
Date: Thu, 10 Sep 2026 10:16:15 -0700
Message-ID: <20260910171623.6638-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page-fault sampling primitive was implemented for the physical
address space only, so a virtual address space context had no way to
enable it.

Implement it for the virtual address space.  The prep installs the marker
whose fault reports the access on the sampling address of each region,
mirroring the physical address space primitive, and prepare_access_checks()
now dispatches on the enabled primitive as the physical address space one
does.

The target mm and the vma of the sampling address are both available
here, so the marker is installed on the mapping directly.  The physical
address space primitive has only a physical address and reaches its
mappings through a reverse mapping walk.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/vaddr.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d5dde97b3cd0d..1f2d923e569d6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
+#include <asm/tlb.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -329,7 +330,8 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
 	damon_va_mkold(mm, r->sampling_addr);
 }
 
-static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
+/* Use page table accessed bits */
+static void damon_va_prepare_access_checks_abit(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct mm_struct *mm;
@@ -345,6 +347,67 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
+/*
+ * Install the page table marker whose fault reports the access.  The target
+ * mm and the vma of the address are available here, so the marker is set on
+ * the mapping directly, without a reverse mapping walk.
+ */
+static void damon_va_change_protection(struct mm_struct *mm,
+		unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	struct mmu_gather tlb;
+
+	/*
+	 * The sampling address is a random offset within the region, so round
+	 * it down to the page it falls in.  change_protection() walks whole
+	 * page table entries and expects a page aligned range.
+	 */
+	addr = ALIGN_DOWN(addr, PAGE_SIZE);
+
+	mmap_read_lock(mm);
+
+	vma = vma_lookup(mm, addr);
+	if (!vma || !vma_is_accessible(vma) || (vma->vm_flags & VM_PFNMAP))
+		goto unlock;
+
+	tlb_gather_mmu(&tlb, mm);
+	/* todo: batch or remove tlb flushing */
+	change_protection(&tlb, vma, addr, addr + PAGE_SIZE, MM_CP_DAMON);
+	tlb_finish_mmu(&tlb);
+
+unlock:
+	mmap_read_unlock(mm);
+}
+
+/* Use page faults */
+static void damon_va_prepare_access_checks_faults(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct mm_struct *mm;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		mm = damon_get_mm(t);
+		if (!mm)
+			continue;
+		damon_for_each_region(r, t) {
+			r->sampling_addr = damon_rand(ctx, r->ar.start,
+					r->ar.end);
+			damon_va_change_protection(mm, r->sampling_addr);
+		}
+		mmput(mm);
+	}
+}
+
+static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
+{
+	if (ctx->sample_control.primitives_enabled.page_table)
+		damon_va_prepare_access_checks_abit(ctx);
+	if (ctx->sample_control.primitives_enabled.page_fault)
+		damon_va_prepare_access_checks_faults(ctx);
+}
+
 struct damon_young_walk_private {
 	bool young;
 };
-- 
2.43.0

