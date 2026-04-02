Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A331F9BD
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108286; cv=none; b=DtGTGEJxLL/KeOXA4YBrwdPnTWTIVQzBQ+bgTeIKBWupy7TUlFTb+qxkHq3b7U92/vIlDV6hLv3fGsNE3Y5QUAF00ye8NpykBe6JjVnR5vWuMrEZF4vorh4nzPID6A9WXzLsdRUMd7RpJSC9olHj1zvZ9UAd/roLx7NN/Degeho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108286; c=relaxed/simple;
	bh=3wJaBgbvxsxOY5IDdNEMD5IcpLWrFV6g7qSEBD/pztA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Icn/fZ9YbVTOjh0IdDBNyScZUufbv/AgCSNgX+KJGiMnn/cfltTHkOvJ815iM3H1YWKjucYmVuhSxACRBVvcF0FjgVH6p2qObIhwYZrjl0g7tO9o9eFFesCfjEaHAEWfwVI9qbbJTU8ijbPDYEEJ8RAgK5swUMuPyay8S8iWu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNoknYH+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNoknYH+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82cf636dac8so219643b3a.3
        for <damon@lists.linux.dev>; Wed, 01 Apr 2026 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775108284; x=1775713084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpZU7evQNWPDKH6NxwB4xQqMBTVomSBrqVWkgmSAht4=;
        b=pNoknYH+mFZwUKwEZ6jGTmYIU0W/UuO6rsAuMCGowqk0ue5cRQnfMAlUIo2SesgUUS
         yJMwnxOeEpRj35+OndoGR62WT1OmJJipKCPHJbm3AcMd68mAcGgk7KJb0xW4io0/jBog
         JhbyoVtBorabc0DyPf8JYSR+fMlyfLQZgLl/86R4fUdkbjn0nEizGrTy5IoXxomu2oRW
         vpAcKug7BCoLYgIzv/ZOAG4tVIhw3TG5Z8FlWBrDr5Tpxfv10oUGhVRBxiwAp9rXhUx2
         JR68FECJ2vXvzxcKVL9NBcQcLtn217K/V79sDjiyfFGpOB1120RMEGpKLc9wQE+e3xzQ
         QN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775108284; x=1775713084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpZU7evQNWPDKH6NxwB4xQqMBTVomSBrqVWkgmSAht4=;
        b=ml75nl+yFLC1KFeBtszcsifQjcVqy7MYv+G86lhgbgLjKs1Ke6kDpZOUq+Xmise099
         0a2FslFkg6XM9d1ZVwQtv2vDs91aqiP+lITWNY/pSo+bgZzdssP+4hvhPzlRvI4qLSo9
         Nolgo5YxQsfkC+WOXLxypHYxIbuPjHeaZfYw+iVC3dMniNjx0VvlIikPyGQ5gAq15F9M
         WshYKZI9zaRV0+xnv+tS+AilzSrl9861c1FO6w1z7adTd25zGzB1/aUakdIPeffJI1yR
         t0yaeeUBnnQr9XeiwL6qAjB5rt0EBs+SobvdimcIixN4n9c7NuCsfW/3fwHPM1kWUftI
         wphw==
X-Gm-Message-State: AOJu0Yze4UBa/Z0dL9+mhACsTe1Xfc7kY1p2mSjsYoltBmp2HAq9fBSC
	96zh7tiEJg9Nz2rBHXGn3VpHmIjYaHCuIg+XR2idxcUYS2HAkNN74Whi
X-Gm-Gg: ATEYQzyfp67HiXYLI923IgA42u9EcfXxX478htZVNGDHhzC47RI3nota9SNHWec5IlT
	MRBXI/Pjs1w4jDG+ZPANcRzH58WtwZdSsn3iwKv3zFqMWABMiI6Rh0DBKqrjWtQk9MctDZfcz1G
	qaEbFeSEWBs0S2YPLCRQnwBxBgJQd8s5yHa9RX95pOr0e6GLQoJxZmlvXDJX9AHPSvAIAQVays2
	zjBKT3Kzkq5jFUzX+Ysx/Au+La+ahPC/Q5suyENvK2Gpt1x/0OFz5FALX2wBuiVZI4zd8uKCwdJ
	k4Xuvv91wjbOJek9rKOL3GWRP8b+6SxA0DMLjdeAVaNdjo6i5NzridQKSSy2doxx/iSIND+CXDv
	Ei2IxwFhxbmF8J524GFAhBS4x7TsX0Yal0P26R/kE8v31IX5Nj9us0KZA5waYt34xs5D+nNeBKf
	E59+kHiAHAuCI9wz27yFvf3Wc9SGRuv7tMjY6MS29RVTh55qwPqN8=
X-Received: by 2002:a05:6a00:2e94:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-82ce88ea8ebmr6525320b3a.6.1775108284208;
        Wed, 01 Apr 2026 22:38:04 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm1758569b3a.57.2026.04.01.22.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:38:03 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Thu,  2 Apr 2026 13:37:56 +0800
Message-ID: <20260402053756.26606-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
damon_commit_ctx() checks if 'min_region_sz' is a power of 2. But if it
is not, kdamond will terminate unexpectedly due to the user's invalid
input.

Solution
========
Add the same check to damon_{lru_sort, reclaim}_apply_parameters(), but
return -EINVAL immediately. This is to prevent user's invalid input
causing kdamond to terminate unexpectedly.

This patch is a follow-up to the discussion in [1], where we agreed that
the validation should be done on min_region_sz rather than addr_unit.

[1] https://lore.kernel.org/20260330233343.4083-1-sj@kernel.org

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
Changes from v1:
- Fix memory leak issue.
- Link to v1: https://lore.kernel.org/20260331073231.30060-1-aethernet65535@gmail.com

 mm/damon/lru_sort.c | 5 +++++
 mm/damon/reclaim.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3fd176ef9d9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..2747eef5919d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

