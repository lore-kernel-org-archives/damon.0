Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD24C900F
	for <damon@lists.linux.dev>; Mon, 11 May 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526760; cv=none; b=IhCLLN5FM80x5di9krVr5KiE0dXbs3AqIHPSN4JyMWSExchjuqkWMlZoxabnCF5MRusesxMV5pzWIeE1nDQxRL9pXdp3XpBa6iDqCUa1I437Wtpr3C5dTMKESD++YJg9eQGTWao44cgWE2fPmYCSOGa7f/A0V4dbNkq+o/Uedpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526760; c=relaxed/simple;
	bh=HMPkYA8vLk6BW/UOOQJOOgFaU8+AU+9MI2MmkTJJ3xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3OpvAPqlngw2YXpmcqZrUhoBZkberojW520Z33o91VO2Gy/e9bz+QUKqjiRdnaIvf+Odq75TXoXeGV1x2jJMPb6oJzLOocSz3CTNNhnG7rUfOLsqsvXe+mKPJBmm9UVBrFSnmUcC1xnq8VoN2Z8ioHu+2HOE4a2C3VEb5Ts7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdchHRKO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdchHRKO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so2609183a91.3
        for <damon@lists.linux.dev>; Mon, 11 May 2026 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778526758; x=1779131558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xArGq1W9dDFcfzmBReyO33DGfNzj4pxhNHfsKRuBCvQ=;
        b=pdchHRKOKSH+mBHBR4AR1aPNy1yEMkh1yvdGewUTgmM5BI8sFBs9V6k6uerMdIbUX+
         cljq0YYORzb4TUGP6Upi7g2AI/TMx+nIbzG0ZCD9Wsnadb/u+Lh8oGfQLeCBGgxAHfVx
         dOTZ0H1ggwsM2oSXAg5gByE9FAXKG6KZYL/3gsXKVZd/JP1xyWnDy4tCSXTbGfpIeG6S
         irA7ob8pJkrswL8p+GIbf3GCejvysvV2nnSjeQpnXiXJ8DjQcRz4wXJ7Ya4YAFayV3mF
         qxtos7ikE8hFDmu8N8ahGwMYTHiFMN6M43DbyK6nYEGfys5Sq34GJZwJM2dK2hnDv4Wi
         uY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526758; x=1779131558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xArGq1W9dDFcfzmBReyO33DGfNzj4pxhNHfsKRuBCvQ=;
        b=mh4Kw/jmBuDl2kSoBa6CUxoSgPmoC5X6B5/+8CzyWZWkjt9CD9rRKV7Nc22GiuLbJ/
         jQyYGi0rvxo+vn3ooA5Un+E+LrrkrGy4Ioy+uCPBLQPDj4xqdLD8YEpv42CSW3wvccnE
         acwr3ifk+baTBMlkWQOi+vHWet/O2M4s9aa75llmAzn96YLth+Dl/NdvZD9DAH7SsJPA
         fDsh53QvxcupjbYvUCgcSt4A9HRPFrC9+9IpdU4CLYH4hVlBOWm5ZuU0p2CKgpiFTyun
         PGAv5YEwmvzMg2l/VOjIfFgo9VnQamDj7bc9+i7vpCeIEwlY+zOORi8U4D6iBlZKbnao
         QPsA==
X-Forwarded-Encrypted: i=1; AFNElJ8E0CGxQjq8dInCV87opN9PabQ1kCGXVAd76U/e9MsB9Y/gBP9bAjJtqEMl4L+YCkZ1ztE+Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgPbG3hvEak1+UaTpkoC2S7GYH+MUNVJaSJJhu5EaXapsk0Oxc
	mzfgjQs0eL2xHnadTxbo/XTqd/z3J1/MqMmjrBhNs+yu387djqQnpfNn
X-Gm-Gg: Acq92OELEJR3YqrvbzhUTCnwwgavtFiRM2kNaf98XS0FhsPkMl1B57DerPCLtcLd5fa
	kY+eLoQaFV+0pSUmpMhpQRjx/g+vMx7B3s5O+jbZMwC2nLYzD2SB8Y5v6J1ZICfPq/ISU+nhifB
	1ST9VWhQGXUpRUbyRhxCHd0Gb/gi+TEzZ4mZdZnrV4yFXeeQM9+6qbKijYsWhcncdkBd9n83jPI
	lJkoOkA/GdMMfEcu24jf/1HhlIy6atsTQyKbszoin9PWMokJYx74hdPFMmp3TEFcUV52bw0ugrq
	8IDFNUmCjITbn9bO/zhUxvIi7cZMDlGetHAurzJYAaSkC5+QBf15wHt2V9s9YS+xBWGaoIy0KXq
	BdV1j95THHxYujKABXuq4G+QvgIrT7uTV7i9WpFu8+YG6kQ3lqP35DMUD2impucrQHFquQL1XDM
	RCGCWS/PHk39Hcc+jaLgf/jEDEDwR6RA==
X-Received: by 2002:a17:90b:2248:b0:35f:b348:63e with SMTP id 98e67ed59e1d1-365abbe373cmr27047114a91.9.1778526758140;
        Mon, 11 May 2026 12:12:38 -0700 (PDT)
Received: from vini ([2401:4900:8fc8:73c6:dda6:576b:fa0d:f68e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d629f3b5sm8686184a91.8.2026.05.11.12.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:12:37 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [RFC PATCH] mm/damon/sysfs-schemes: fix double increment of nr_regions
Date: Tue, 12 May 2026 00:42:15 +0530
Message-ID: <20260511191218.98881-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_sysfs_populate_region_dir() increments
sysfs_regions->nr_regions twice when adding a new region:
once explicitly before kobject_init_and_add(), and once
again through the post-increment used for the kobject name.

As a result, nr_regions no longer matches the actual
number of live regions, and region directory names skip
numbers (1, 3, 5, ...).

Use the already incremented value for naming instead of
incrementing nr_regions a second time.

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 622c3799db87..5d966ac86419 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2998,7 +2998,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
-				sysfs_regions->nr_regions++)) {
+				sysfs_regions->nr_regions)) {
 		kobject_put(&region->kobj);
 	}
 }
-- 
2.54.0

