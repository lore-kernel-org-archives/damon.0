Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5C48BD33
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985970; cv=none; b=CW97S11+VsVCGzAhEY55iwcBPQQeGjFdPr6iRk24GlwT3AsvlLplZTxMNLkLez9t0UbmfTXv4G6DNAxwtjsMRO5p9pLnyoS8xZYuTPOmDIaN2Nfl9D5SvEY3OVk34aXb5SEboj80dLk9DFXFAVAZKU5aUO3+50gLWvmy9mf3rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985970; c=relaxed/simple;
	bh=lZIBPfiS1B4l6KtLRu3FY/gEPxHhSq1GnM57f0sSIzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkDVifVJvmnZJA1WCzi3dyL5+XU1USzCFzbeR/nZVqoYv+hwZIrXtw3J6BH15WlTJtgmff0UjE7+Dg/3gZ5LiYR3qvQFFOSoQTAc/tgcjZ/tcCn8ZnzGmlIfNqMwMC+TNJhGnRTNHvGiOtFFDrmg0m//v/6EbOADr5tgojxu1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l12v72Sv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l12v72Sv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso1294726a91.0
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985968; x=1783590768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fSUXKDujeNKobknQh3agFHmPQh62MyMSEJjjJnObnU=;
        b=l12v72Svw2gm6SkYjvfPB8GN0wsKLCvt3z59Ay8gLIYjKrrBLneRCluZcFDBr+TMqg
         sVzJHyUxBWh04ijFHJDSC1EPaQgLbOr3/1o8uJLJTGUptK1o/3DwHfN7dH8KahCm2oD8
         cU9V6k39t0iNG7Mj7jtsJ+jnAjV9MURMnIDJZX8nsYEjH50dqfpAFGzzHDqxyLsyQGpf
         1omTG1c5CgmkNWFv0pB3UziyF3HTGsTfEu+fy8vnYNZrMcOxHjgjjpbgMVtBkyYC4/Mv
         syZVB6Og+2K5rXUkM1cw3nygs0Hhy7CL4tvFN2Puf/EM8d2ufviANP4dy+W8t0m32kC8
         i5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985968; x=1783590768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+fSUXKDujeNKobknQh3agFHmPQh62MyMSEJjjJnObnU=;
        b=OfS2ma9GJZAy4WpnGDA55TyyGilhWcJE3MH1G8RFJH4dsvYaziGPA9R01QcuDZw3j1
         nsuAKkG/T4egueLy2v+jNSDaFqDj4rB0WCgdYRG+MVYdjLcI6CHl9SrZIdmoo/pWDP3i
         XRAVkPjHb6m5mtjpY9lBcAN+SP5Odbo72NzUnTExZe0hCw4YTqdJLFwQ/Z+RGydBwkiX
         laZFzhGU2IHWVa0tW5IWw30Wi1z/UVZwpfuGA9F7erKz5jS6Sv9NRnSxRUs9z4sL0JP1
         NclPDAzvAtK5XITff5771yjBcg/KGnLbMAyeQ/0trlEDxKpsaZ30qy3tIa7qVhoDcAws
         wAAg==
X-Gm-Message-State: AOJu0Yyy0GNkFgsTXhFi4p5kfqr8gdQSQo/LxmJAFE0wEOMV3n8YQXAd
	UARxuED7lWp3EW+wBNY1whlKwOtmWYLplkF6aVZcNaBlR4FhqXWu/SO2FhBuy80Ekp4=
X-Gm-Gg: AfdE7cl3okl0ju2ms63vHKoatv2OfNLbaCB5eBK2G6J9DRqEO/YPoAqdDAtgvA3Fmdg
	U0TDwacIyRvzPZMqeHlWyyUXabxNX6GF5BzffIeyk+jK5LqbwO7f+wxB14ronI+v7U78uL2eYE/
	J8qjW3AqCs1MfF3YuLT4Z0c/66fSWgQy8gqGyDxNzqoEga4aoljBY/rtUCQUTUHD/NtP1HiknF7
	SUw/nuSmgVcno0lN5FcAYsTsJ/YUjyvY40v5pQ5Nsz+neL2OvMOq1s+T8T3Q+LAm9jLWle+DMVB
	/h9xPp1JjaQ7AAf2jLh8iGj3GFBucVoAGzj33ObxNxt6rMQzQQvwholMMwa780O3Ongyl9jc8iR
	DnV1q99VgceFrchFiMaXBv8kF1WrknUiJoqTMIRkg85m1z2QaZEdA1fWmxkfV5iT4FbKYlC89VW
	3vIQ==
X-Received: by 2002:a17:90b:2652:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-380ba91c157mr3597365a91.27.1782985967745;
        Thu, 02 Jul 2026 02:52:47 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm8348869eec.13.2026.07.02.02.52.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:52:47 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	sj@kernel.org,
	gutierrez.asier@huawei-partners.com,
	daichaobing@sangfor.com.cn,
	lianux.wang@processmission.com,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
Date: Thu,  2 Jul 2026 17:52:25 +0800
Message-ID: <20260702095227.75866-4-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702095227.75866-1-lianux.mm@gmail.com>
References: <20260702095227.75866-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.wang@processmission.com>
---
 mm/damon/vaddr.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d27147603564..98a87609376b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -14,6 +14,7 @@
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
+#include <linux/khugepaged.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -899,6 +900,50 @@ static unsigned long damos_va_stat(struct damon_target *target,
 	return 0;
 }
 
+static unsigned long damos_va_collapse(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	unsigned long addr, end, chunk_sz;
+	unsigned long last_chunk = ULONG_MAX;
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
+	if (end < addr)
+		return 0;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	while (addr < end) {
+		if (addr + chunk_sz < addr)
+			break;
+		if (addr == last_chunk)
+			goto next;
+		last_chunk = addr;
+
+		ret = damon_collapse_folio_range(mm, addr, target_order);
+		if (!ret)
+			applied += chunk_sz;
+		*sz_filter_passed += chunk_sz;
+next:
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
@@ -922,6 +967,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		madv_action = MADV_NOHUGEPAGE;
 		break;
 	case DAMOS_COLLAPSE:
+		if (scheme->target_order)
+			return damos_va_collapse(t, r, scheme,
+						 sz_filter_passed);
 		madv_action = MADV_COLLAPSE;
 		break;
 	case DAMOS_MIGRATE_HOT:

