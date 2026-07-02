Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE63E8C67
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985608; cv=none; b=ECfGPfkIbhv/9zist0mZ5jTzvXQZSAL1aM914IvtsuBV7gvk7FtbuEybpAbseTpOomqXugShBy+Eb7Rnc0328pCiLXyH41qkQl0JjNMraJCwOgbb4o4XQ0zBs9tsB+B5rLfeizX0uBXNVR5Bi3VI2+B68DzSUEo8EyAfgMcgN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985608; c=relaxed/simple;
	bh=lZIBPfiS1B4l6KtLRu3FY/gEPxHhSq1GnM57f0sSIzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBmqn7C2QN4AySzu8NdmVnBCNRSEzZx5LNscYgRSgacf/jCAc0o2VV4rvGBAxCXgIyAbLJYsRxElDitn9sC0ieO/X8+xEyFc9CVUWoTIdfZJSUQREntAm+0MexEM42/OwCqxEgXGtcZiRKwFRlxHho5wJjIl90LxFUJLFcpDbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6BGox7P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6BGox7P"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ca1479dfe0so14822545ad.1
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985607; x=1783590407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fSUXKDujeNKobknQh3agFHmPQh62MyMSEJjjJnObnU=;
        b=p6BGox7PNcgq8xQ5vohuY30svFZ5YTyk8WHnzcHWBcIOYlVHs4//fErfCDCAQepqTD
         tH6JkIxevzrOKnXAdD1MhtCa2CacmBkfAOTZv3svarZnTligbztQu+D3GSReL0mKIVIN
         zQU9lxqBs+NdrLY8da5czAXhSyXLHqb+KnD9b/kxzkW1nROGBy7/jzLfkJm9yXJPzsJI
         9akoNWt6G4JFGKEyjkLpqE0XTkB7q5fy+t9+BAf6ROFL4f6QpEG7Bl0jymsk8OhDMSTH
         U6VGBRpUgzGsbapAhFunI/n+HmlPMGoKdaliPS4nX7Zl8d52O7a1/7z97DmxrcxkbaCW
         T9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985607; x=1783590407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+fSUXKDujeNKobknQh3agFHmPQh62MyMSEJjjJnObnU=;
        b=dEn7IoJDQ4d4xhMQlvh14YwS7yaiJElmLidUvCAGRETgRL/tIZxzQp3XSVF3wgZwIz
         ThAvb2LaczfnNkq/W4SCE9ICQt9F5fiLB5HJ/mxI2gSLfAJWBs9WIlB5spENAOjAm9gE
         fVylkdkSBeOZwiZAEDInpFO0YS2pAVW6RKo21jIttQhbcWlfFMzyQ6AIeWt7CnrLsQ/V
         JbfSManyPK6BVZwfIkU9l33fNttcXbtLpf0yMsVwzRjJ29KFeRcdwNK4cbi2TMx++vpS
         gQN6Bz4wcHJwIi+kOryzUzd2SfPY7KSbY1XsNdx6FG9SiflNgN25IMwSBYTERJgMPABK
         OJzQ==
X-Gm-Message-State: AOJu0Ywrma4tadDxTACp5YV/moGJOVPt8elpgSihoZHnZxuRSEqK1JoS
	DiMjKi3iQq4yshH3Ax9+/nUgSn+eBRc+1uYPoG6h8T0p+fJaPvtDZPpvvU34C0f4DvU=
X-Gm-Gg: AfdE7cmc+VhUYyA1f+flDC1wdoXiMExRrS1ImBEH9aGX4IsT4CIYlM9PI8/PFlx+eLz
	BUbAj/Jrb5a3wNG+4EMR87nccom2aiHtzoj34D7/j+JanhrNp3hMUuYEalJwo4S4afhGFVjbgGz
	hCTwVejyHkZQgg1Q/+LrvML6hFXRuwjt6435DFo2R05JoefqHWEB8NOlrS1TCX90jaSmHDG9xiP
	f8lyZrQsPVIcURhyjQ846oeidc398QEqAKzQSEY84/kcRYLmJTV4F3XsvbMqZP/0N/C2g0No8O8
	jFafu8Vcr6jNS7SFYjLmmfInVwmvGTg0CIaJMQb2BLm7QQLeFXJo2SETgANWX7hkGzuQE0LQnT7
	gjh+WMpiJpj9CYAFSd0h4ZyCplJUt6+khGCf1x71243Lkk2WyVWp9RqDenRJnoDznbns8R7o2MV
	9/9Q==
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3bfed1c396emr6316484637.1.1782985606688;
        Thu, 02 Jul 2026 02:46:46 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm5261121eec.11.2026.07.02.02.46.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:46:46 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
Date: Thu,  2 Jul 2026 17:46:31 +0800
Message-ID: <20260702094633.75658-4-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702094633.75658-1-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
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

