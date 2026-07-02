Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDAF365A13
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985613; cv=none; b=Q8hF4m24ePK0s+PaMEg5KIj5ImlKaoKNVdNcEGf73jrrxTfKuBqmmUlN3ugxAavWf5AAQOIg/liXcCRszRuN2mBT0Q3lew2a08PKH5nRjDqzGHg251BAeNr1PhcPl5Tc7MBlZXryvmDhOdMWguDki1NQna/CJZ72kwh5OqLtXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985613; c=relaxed/simple;
	bh=3hu/dyEQniHzh5o8XFtjhNx9K6MRPA3r8Fb87pPmPWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSglNwaSkM68oTFpaLAqXZomQZmNcUL28AY+2ElBm5WTdwhbT1CX1XlvvT3/ECz3WzV2qTbJFIOz/y+RD5A33vzFQbXvHktmg76BWf6hSDB/qpM/Cp5s2SQp3km1PkLmsj+N9GHWrjUpx2a4oY/lxztV/4dTEk3TV4y7ZjpFljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M31pzcD3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M31pzcD3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38005a36edbso1105284a91.1
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985611; x=1783590411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0FSDxOUINlONFM8pZTZE1x3+u5xWuXjjFdFIeg4Jqg=;
        b=M31pzcD3jJ6z18IRMWlAlFqeyijdcHAoQ8CdUW0DwBXWxreROc4lNTIz+FxWoXfuak
         x69+4uvbu3buFYsNwbPb0j6cBnaoCnsIhOZCJJkajwWDWwyG/wjXqbo6SCO3sxgRasDn
         8gD2SqyEunTvnLP0iD3Es2MS+BRhenwPIoQyTwgWXXO2r2u9HBD6psd1vW+g/Rc0CpsN
         ENO6mMCxeXc9/ARi+p+MJAHFb/PFQBflpC3wgnSR/72LHWs72Yitk3f+Q63Huh5afFu7
         eWZtFRJINYFPWwQnRuzoqbrD75e9fKhKH/0RgMbfdnk5WhpLeB+Z+xHnYfeisWMPrOyg
         8+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985611; x=1783590411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0FSDxOUINlONFM8pZTZE1x3+u5xWuXjjFdFIeg4Jqg=;
        b=lzKaypHFwdC2NUerRX3RAX8cZ6Oge1aVWxmS5WHAsMJqN0cXMAazEVFU0MqCmxphsi
         98c9gLinaQQIenfNND5MrVnFRS3B654nKSP7t1x4JWykCwokSoANFo8PhCENiInV/FUB
         Pmeyvp3IBndyDm+YpyON+3yYXUEuBXXZCpCi8ExKTu1D7kl/H/mB8cezQAtUEv4b1rMb
         bw7BqYHRfKkqd9mYmLd2asZpiv35hrIx3JVh9rlNP5W6/br6/kytbOJ9Aa+7jFrQoUxh
         k6yhwqnU3ZbGVnYgDTLcGQkmChAWztZdQPFS07ORsxzPLmgQaDH12hh8Ou9Uh7tIVxHI
         QSeg==
X-Gm-Message-State: AOJu0YyZmrjEXZZzAlXspFgSkCQEg5+ff3iRxaQrxIuaMQuquyZfTfc2
	En0P616jdm9QfD08qzQ/LJlPrR75ErQhsYnmmt7KP7unkPaj4GSsSQtc
X-Gm-Gg: AfdE7ckPHNAz7dNN8PXeX95aAcg8g4mbN1YG/WHi3+ZwjtOREj2Be8VDO0mshMAJ9BH
	viro06IvMekNkufIl1t4HHHpzTDeHePk0gC1zvKt2mPUa8t1gWFnA+jnDONeLJGpvSyF+aYZC0v
	vSBmjIbCISC0gZsPDNDaTmcY92TlkSPeN9GbUa874XxQClMrPAknTJKFnQFRUr55whzOVS9gw7Q
	cZPxjckW4lcwCAXmltjCyQIHxbAESp+wZtRjTlZraGyiAMSQdp+J1JzEbMxUiihp9HLtJ8CztAu
	/dggp9F1ApR0m/m0ck79vGr7LJDiZXXB/+QLuRmQSTHkms0hJsYFkILWK9H8qlv1VyPutXKSdF5
	zzN0ddQHNL7ZNuQNJHYeD8MA5jwmIoO8QI6fICttzeFaHiLTmYiYx+Z0eLIXa2Nt0decorixn1X
	NOQA==
X-Received: by 2002:a05:6a20:914a:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3bfed3bc536mr6307204637.41.1782985611341;
        Thu, 02 Jul 2026 02:46:51 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm5261121eec.11.2026.07.02.02.46.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:46:51 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: [RESEND RFC PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT handler
Date: Thu,  2 Jul 2026 17:46:33 +0800
Message-ID: <20260702094633.75658-6-lianux.mm@gmail.com>
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

Implement the vaddr operations layer handler for DAMOS_SPLIT.
For each folio in the target region that is larger than the
scheme's target_order, split it via split_folio_to_order().

This supports both anonymous and file-backed (e.g. tmpfs/shmem)
folios, covering KVM guest memory backed by THP tmpfs.

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.wang@processmission.com>
---
 mm/damon/vaddr.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 98a87609376b..a177703f7e0a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -944,6 +944,83 @@ static unsigned long damos_va_collapse(struct damon_target *target,
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
+	if (end < addr)
+		goto out_mmput;
+
+	while (addr < end) {
+		unsigned long folio_sz;
+
+		if (addr + chunk_sz < addr)
+			break;
+
+		mmap_read_lock(mm);
+		vma = find_vma(mm, addr);
+
+		if (!vma || addr < vma->vm_start ||
+		    vma->vm_flags & (VM_HUGETLB | VM_MIXEDMAP))
+			goto unlock;
+
+		folio = folio_walk_start(&fw, vma, addr, 0);
+		if (!folio)
+			goto unlock;
+
+		folio_sz = PAGE_SIZE << folio_order(folio);
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
+				applied += folio_sz;
+
+			folio_unlock(folio);
+			folio_put(folio);
+			*sz_filter_passed += folio_sz;
+			addr += folio_sz;
+		} else {
+			folio_walk_end(&fw, vma);
+			*sz_filter_passed += chunk_sz;
+			addr += chunk_sz;
+		}
+		mmap_read_unlock(mm);
+		cond_resched();
+		continue;
+
+unlock:
+		*sz_filter_passed += chunk_sz;
+		addr += chunk_sz;
+		mmap_read_unlock(mm);
+		cond_resched();
+	}
+
+out_mmput:
+	mmput(mm);
+	return applied;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -977,6 +1054,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return damos_va_stat(t, r, scheme, sz_filter_passed);
+	case DAMOS_SPLIT:
+		return damos_va_split(t, r, scheme,
+					  sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.

