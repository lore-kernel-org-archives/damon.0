Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3F3A9DA5
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985977; cv=none; b=WEpFEZbkBDOkB2hX6L4XF70s5LH30xvoyhTcsG5VocRSZUPw08JVFO7KcpThPwrRY1Qs68fmb2Y1tfhsQ+UoPBG+XYEmAnzB6UpagARLBuebRfdzmAEvuCGShuVIufBfvs94X9u+mbynP+iMgBXWbhlAdqv40P90iZyebDbbvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985977; c=relaxed/simple;
	bh=3hu/dyEQniHzh5o8XFtjhNx9K6MRPA3r8Fb87pPmPWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/KVMzZJs00tndPUCxJkEOZnQD6zGN3DD9XULV6/F6qcs7vvz623NgDGE1W0hYF4ouzNVGJ4134EV5z8KO4DWA1tf+OJUcTtXPVww0tVPHpRppXhBGZZJkbGdlkLNhYiPCNPSqcfBJLLIOXPQ2FTtgoc4rMr8ktfKE1PZVXHNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6+i6440; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6+i6440"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9a20f70263so290644a12.1
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985975; x=1783590775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0FSDxOUINlONFM8pZTZE1x3+u5xWuXjjFdFIeg4Jqg=;
        b=U6+i6440NjJ9DpyZC1d5xdPuh+w1+byPtvrQxsnRcvfzD8Xg2HZf3YTw/mbQXW/8ew
         AKqwIsVZVOF/iinvJFDxQngPVm9ayIy3pc9w6A7BBMMhy9anocUxMTTxih+7HXAAKomq
         ect6v3LaaBK6SylCNmRrygqK/Jbsl3IhOtPLwBhBJ6XAV0b0b6TGGQJD/jQtbMDdRjTV
         AA1MTDBv+BBvUy/cQqbxtJMGsIqPcLxEo21zwIgikq//fhyvwr8cv2cXBdsjyWlUUwPv
         Y+Kmw7m4MsgX3vLrjI7BxqYPz6MOKhSM08cVS3EPCXmguvHv3JQ7VK5W/mL1Grzr/311
         4Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985975; x=1783590775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0FSDxOUINlONFM8pZTZE1x3+u5xWuXjjFdFIeg4Jqg=;
        b=pGhurgxTXe1yxH6kA6HxpXBvxn/Eqy1+qA/osmyocLmE2CqnfNWPTklBbEBcy23Z2J
         gBUE7yY9U7b7D8ovX0ISDkU/+yAkwZfpUuUSkCtlrQBO2NIkHCBIA0q8oucu5U2+/Jdg
         N1s6Lpsa98I+OdoJ5PBbE/hGnuKOJ08QhdLEwCN0ozgM05wfW6LHoe0SqZNxnnDfr0ss
         8PqZxFvyRRVTpLUix3XRVoUXQzBPuldvsWVTtTBqXqgp1bb7AW4KRII1g3RKoqatJzSW
         lOJp6g1sRan0A4p9nU+mlLPScyZM7FvLohmu2+IFMBHsuQXI8WcolL6PqC1FjLD5x0Pw
         NHnw==
X-Gm-Message-State: AOJu0Yz0WNNrKmwhgWCcpj9uH7PLaM/186HofLR4lLHnboobQUMw+oAX
	MC+xaVBB6Dw/f+NLTRLG22Afk+BvYdYbZJiMz91kPzBYY7R4Qk3a2hp13UbfIaurq2U=
X-Gm-Gg: AfdE7ckR4eKPkwIbi9WBqZjg87DrptEvvLL6uK+Wf1jERC8037EwTLkcJrKmlhAHlWY
	/Crhml0T0OsZ6FyDt9+/8ur+pPbKqar884e7VxCqKEDqjwd2hlbppx7oEhliw87IKDo2wCsiVDy
	l+G980thihFv1DTfYmeEROQUm7J0M8GZf6/MsjNi4Hb0S9x2m6C6EB3Wz+9eIKo9J1hTA7PJ9kB
	56S16/OOcHsPZMFXZxK7UpU3pNtJPH5Dd19V2GtlboxLne2y4UY35hfLDLdr8uocVvxuC7qJbLm
	98s+8Al0kQpFwPZkl3l+yTjXGt8fwSAnG67n59r0cmwos+1twue5TBHdnGKl99tlVun9obxmw5N
	Zq9iBnYgZsgeSdYn10hHrkRoXDOPeziOXnpFserg9Rcl8BUEX+jdmNY5rlZMXjqUaJsOrwZ0gcV
	lKBQ==
X-Received: by 2002:a05:6a21:688:b0:3b4:7459:85a0 with SMTP id adf61e73a8af0-3bfd284b30emr10138798637.18.1782985975448;
        Thu, 02 Jul 2026 02:52:55 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b86ef6asm8348869eec.13.2026.07.02.02.52.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 02:52:55 -0700 (PDT)
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
Subject: [RESEND RFC PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT handler
Date: Thu,  2 Jul 2026 17:52:27 +0800
Message-ID: <20260702095227.75866-6-lianux.mm@gmail.com>
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

