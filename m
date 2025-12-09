Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A02FF17D
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293057; cv=none; b=bRshloE9AKlf0Sk/3K+scN+9tw8qDAfxSBrndMxSI3r6I29Fn0QINR64xjYPWhVzi7P8n8R1WrhuQXABjaNIvTqTeyCn13u/+weF6L75Ahxo5j/TI7SHlHOHXUscKB21hn4amCUWqP3YtP3DnznH43KW9Wm8cQThCWPhjq9vro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293057; c=relaxed/simple;
	bh=wyWRBqIZvAhZL8UPgHwscKLA5JCRix8vG2dzLzmNAps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eC6sX2RvZAOYzF9juYVQBNZbVTQwJtWOhiPvV+QetxZnu3qpxEAG2mhLPIX8Q/SPd+7rel5bkJ8P7F4PTBLEdBd5tOQQLfOed9zbiSUXMFlB28INu6tVtQzUtcg8Dq/slRXd3tGEA71g0zyP3RmvBUi2NxtcsnogC34kx+3/KeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWpBtPsz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWpBtPsz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29ba9249e9dso80371105ad.3
        for <damon@lists.linux.dev>; Tue, 09 Dec 2025 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765293054; x=1765897854; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49DxwA4IERFFfQvlNFCEhllKAUT3KrhJruYrNRHk3/w=;
        b=DWpBtPszX0E6ejRvGFUwwywH66LWKQqxHeTzu90YkNAQVOFiXoXRGryOv17GFnd5MF
         PQiTpzU8EvU9/u19rgt4D6PjixLZFMKf98ocD+fn98ii43LTZVo+3DHy6IfF61MiU8rD
         zSCtj19dDFs/5Kny2zyWpc8FxUvNCt7xWvwMRKSGct4LNnLg+r8FXuHUh1IdJUpbeT1F
         S7KCgfxYeZ0NALXSm5JUXZ5EN3indHjV9w1kRR7NVVbgKUqGo8BjIvAF6l0U+cw4EnZ+
         7npKVUdxZEmM/8sBVqa0mqapQ4M8HIx4k8vbJXI2zBT/K9q9YFx4flV7SWj3xdeeoLJl
         9Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765293054; x=1765897854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49DxwA4IERFFfQvlNFCEhllKAUT3KrhJruYrNRHk3/w=;
        b=aafM23Jq3c0fiuJP4/FO5qElWbYE4sBhcr+ZteIjrZNnPBwNtlU+Zq988TYRS4p+Ym
         b+tz0yNThu/DOBEs5hS7XK6/phfGQnvRzJT/+wlC4IaqJa0cmll0OgiuLHWi1osUM7YS
         4dCsY6/nbYEKb7nOKavEGoNbXi8Cpx3Veg0LVHMqK8rp39L+C87nfkSVd8j+pVhp0cAZ
         mq9VsPg6xjhKa7LfPZx5vJ74XdbMMfuAkTXZ3ltuueWq3H5HOa3hJGe9sMyChcbs5pVE
         Kzkqsp4bQ+7Dwiz6XgvkJJTUEDpsViIv5G5HtEFGtTpg0kcYgobuPXWO4hmRUk/7tpDi
         2NIw==
X-Gm-Message-State: AOJu0YwGxtm9rvQMaZtD1DOufmhgT0hgR8fwBLAXoOpmSPwKYkeguo8x
	RMh8Rt1gsp8mWGy/3IEtypycz7AwsCuf8hbvEgofY3m/oC3LkEmsV2z/XNx0+w==
X-Gm-Gg: AY/fxX5U+VJ7DmepqjpQGg0AKw9GutZlAYtIOKSkxmLCvJJOSAlSRJA3lg6w0VZblIv
	x1HAQD+q/wWnlOCLC4/YV8xBupCB9mDFPh1mKNQPwOvQCCn96Yqt0MD9BgZuswO21raBAqwGLXe
	8DjxuR/spgXfEtU1yd/lRtUU3lccZSKjkq8xVyvojvWdspBx8KCBE/iVb1PoCmgQfcolPG3VPwi
	xV1W8lVilBjGSRkTN1x7OT9PfJ3dbEvOl046TOogrO2iLO2UwNtGwGlZ746QH0qjEg72dRuKvGy
	kePL59+NF3AwdVfJ68eEva88NvOmJTJUB8toXpQBI0iPbcJOxOQ8CPjvwFN5mN9JI7aWFish8K0
	5/yWXCcVz0NQPLx/Qgid8i58kcZb6HKfwvyUTfFLz4f5kUCKjhg4phlF96DalyMOy4U+DL3sYVd
	ykxAbkifV7z/Qomzfk0caU7NHoSA==
X-Google-Smtp-Source: AGHT+IECVUNK7oNWE2SGrCYOjERm1R1tBpS+ZJuNzaphn+nqQg3fHnMx9oFUnZ+wKNMrX7vd32KDhQ==
X-Received: by 2002:a17:902:f603:b0:296:3f23:b909 with SMTP id d9443c01a7336-29df5dc1415mr117408965ad.39.1765293054198;
        Tue, 09 Dec 2025 07:10:54 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8d27:8b88:232c:c7ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6e88sm160223685ad.92.2025.12.09.07.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 07:10:53 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [PATCH] mm/damon/vaddr: fix missing pte_unmap_unlock in damos_va_migrate_pmd_entry()
Date: Wed, 10 Dec 2025 00:10:34 +0900
Message-ID: <20251209151034.77221-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the PTE page table lock is acquired by pte_offset_map_lock(), the lock
must be released via pte_unmap_unlock().

However, in damos_va_migrate_pmd_entry(), if damos_va_filter_out() returns
true, it immediately returns without releasing the lock.

This fixes the issue by not stopping page table traversal when
damos_va_filter_out() returns true and ensuring that the lock is released.

Fixes: 09efc56a3b1c ("mm/damon/vaddr: consistently use only pmd_entry for damos_migrate")
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2750c88e7225..23ed738a0bd6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -743,7 +743,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		if (!folio)
 			continue;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
-			return 0;
+			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 		nr = folio_nr_pages(folio);
-- 
2.43.0

