Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9129425CEB
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906458; cv=none; b=bb2HXXkephgu0jTdC8GlglyIsqim8BQVL8ZW0lHfkcXwc/SsS69X7fqxGzFkG4J6bgxSNa/VPI7JR5xnPhgl5IuvCRD8wzv+FRGMj1Cv3vd/LPE+fVVRKbNK+j3pYyr1fQG/mDgZ8xKfx1bXy0PJRAD49ch2NatFv1FRfYGwQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906458; c=relaxed/simple;
	bh=2vAz1Pl6ji0h4kj5zdzc1WH8+uzU4qkb4LztP5YMcqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2rjuAR8pF8KI+Njc8zq5ShaQlrzThMe7O/M7OPI5NQFAHJaBIYvEeG7vnB8wzvTWvRwdca56eBjltI0NYrOl86Kvlem6T1k7RdYToG0UIsSgD8BOcrYLYQbdZVYvph1ubvlYpxgFZc/i9+s5egTc67XJAgmBIAU4iHQorppqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWIg7dSO; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWIg7dSO"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30c09f29b64so361420eec.0
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906456; x=1783511256; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6atn2MDoT9tTt/oDby2aqEaUDrPUuFD6g1qMrGDKd0=;
        b=IWIg7dSO+o7kPyYFgWN6ivN/QCmPbmMehLNJ2MPCdqinXXEwm9BgEvgHt/jDqCyZwF
         fZuQyLCoqg3bUN/scV8VIHYBdyR82kuj1dOqL9U82S+5V1Y88LLdbnFifuI3c+ia4J6g
         pwiXT8x0RWpi6R2IlFCQr4n9I3YfwIYilqyNyT1sepYlVeywwuSAAhkuUPfmnZoAbsvZ
         XXX9XUvXkjxFRPslfBeqByYTh/Xv01CMpSyjvrfhCapKXs7JyQT7W5714a+kpqs4OtI/
         NfEPbQCSyIFaAfchvutl8D04Imgs0tjwXit1sTtR4PUmo+UbMaOBjxFdXwx8X8YA9F+1
         KPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906456; x=1783511256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6atn2MDoT9tTt/oDby2aqEaUDrPUuFD6g1qMrGDKd0=;
        b=odPCJ8vcIyarGaazbbfxlRN/LDwewh2bh/F0nZcwK6i7Br9zZq+nzYDwzrTZasW9jc
         EVKLdUaZCOrD6C7Q0bfiqH44CT4c5OPOhBPYCd1CXO8/jNMnGVy/OTunXP58hebfCpIt
         96E0eBC+IFQvBY8RFeteCwhBJ2xtjuuOou3STrLN3VYHR948CtPKPe5PLUNR+SZk63oi
         3FFmsgyNoAa8/vkLsZ+lFoGlW9qzpDgIRoZdxhLxK+vtyAzZd+mzED5hB5VSPTHydL7G
         Wjr1ZmjeFZYzoZiau9+OhLbsf/HAOWgonwhO1oMZh+Z4+JJjWwG6uq2KKwEnoq5V7q6g
         NnrA==
X-Gm-Message-State: AOJu0Yw8r/VNToAOp5HmhuVoQtMJkSBsJKY/HhFFEUUU90qTDFJJpxbT
	gs6swMqEwWuPYEzqnpVI22vcQ6s4qA2IMiTp2lYYMyOqH7qmSbtXYHs9L1ob4OnM
X-Gm-Gg: AfdE7cm98PvQCRMAaGXl9pIqTFvpspS/7gDPKVqjUkfbfNdA8qmwJKGZoNQmDCXoeID
	+MOeNv4ZN7MZ2zG3+gcINYY6vSrcnu0ZNXaZiw+45vZrD57cHcHST1isgav4AkmMN2dUettjd1N
	yZdmavlYCq3qkj4pOoSViKy0idC9bsP/fqk2RStWyEVzGp0TU78T7T1EOty2Q2uIX007qUSJ+Vv
	cn4nXBtMGrxs17EJr49cE5LoNVH34CC8tYFFS0BKwsRswOtZ42QGgZxUFYic83f8jPHcmhEVEQQ
	RXZdSFNT5wCA8+wavL+CbZJ6rHv+0KlWHJRA14LEO0kWeJ1+4oKsfaG0NV2Zl9mOgCw+f7PwmAi
	G6sCXIHSnT6mxQXDPj9DCbINvYXrgi9AehvY8nQxMHieSqyZOlnKv1tiMyapKE0dneyrYDTiA19
	4yCQ==
X-Received: by 2002:a05:7301:1001:b0:2d9:db50:c6ce with SMTP id 5a478bee46e88-30efe6d53d7mr1600277eec.3.1782906455878;
        Wed, 01 Jul 2026 04:47:35 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm22518169eec.31.2026.07.01.04.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:47:35 -0700 (PDT)
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
Subject: [PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
Date: Wed,  1 Jul 2026 19:47:14 +0800
Message-ID: <20260701114716.56503-4-lianux.mm@gmail.com>
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

When target_order is set (non-zero), the DAMOS_COLLAPSE handler now calls
damon_collapse_folio_range() to collapse pages into the requested mTHP
size, iterating over the target region in order-aligned chunks.  When
target_order is 0 (default), the existing madvise(MADV_COLLAPSE) path is
used, preserving backwards compatibility.

Region boundaries are expanded outward to the covering aligned range
(ALIGN_DOWN start, ALIGN end) so that collapse works even after
kdamond_split_regions reduces region sizes below the chunk size.
collapse_huge_page() internally validates VMA bounds, so expanding
beyond the original region is safe.

No external mmap lock is held: collapse_huge_page() acquires
mmap_read_lock internally for validation, releases it, then acquires
mmap_write_lock for the actual collapse.  Holding an outer
mmap_read_lock would cause a self-deadlock when the same thread
attempts the inner mmap_write_lock.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.wang@processmission.com>
---
 mm/damon/vaddr.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d27147603564..2a3757c13bf0 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -14,6 +14,7 @@
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
+#include <linux/khugepaged.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -899,6 +900,40 @@ static unsigned long damos_va_stat(struct damon_target *target,
 	return 0;
 }
 
+static unsigned long damos_va_collapse(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	unsigned long addr, end, chunk_sz;
+	unsigned int target_order = s->target_order;
+	unsigned long applied = 0;
+	struct mm_struct *mm;
+	int ret;
+
+	if (target_order < 2 || target_order > HPAGE_PMD_ORDER)
+		return 0;
+
+	chunk_sz = PAGE_SIZE << target_order;
+	addr = ALIGN_DOWN(r->ar.start, chunk_sz);
+	end = ALIGN(r->ar.end, chunk_sz);
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	while (addr < end) {
+		ret = damon_collapse_folio_range(mm, addr, target_order);
+		if (!ret)
+			applied += chunk_sz;
+		*sz_filter_passed += chunk_sz;
+		addr += chunk_sz;
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
@@ -922,6 +957,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		madv_action = MADV_NOHUGEPAGE;
 		break;
 	case DAMOS_COLLAPSE:
+		if (scheme->target_order)
+			return damos_va_collapse(t, r, scheme,
+						 sz_filter_passed);
 		madv_action = MADV_COLLAPSE;
 		break;
 	case DAMOS_MIGRATE_HOT:
-- 
2.50.1 (Apple Git-155)

