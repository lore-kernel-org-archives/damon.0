Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E4224AF2
	for <damon@lists.linux.dev>; Tue, 12 May 2026 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559132; cv=none; b=pC6m6IXKx2N1uqKuVHU34oX+ainKJQM+4L3JJep2iVz0cXZRZp+Z4L7HByaf7iNEiePKGNebdB95+GX79ZbLkttTxzdch5Ws3KjAcAnrq/hxbzwZ1r0lgHPNaq7KKHBOTVrFG6IiARQGLsXgQkju3gxV7Do61bZvuS8q9tRPffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559132; c=relaxed/simple;
	bh=d71o6GJ+kZubNzWiM4mqlQWz/y4qngthAy2ag9npHgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhGwN8MeKGtDEpE/AZ/ssqOH6epHVcBMhov5Wk8r8UiTlNfJOzVAFx8ACf3x63ZaKX4QyUVzrUhv8vusztJsgJpqvXJeX46JByAPPzWV4tfInRtDJA8ambtPFkP8AUKGg63NH9w1AWNQuGfJ8Pr8Um2NFXdudUH/XtbJ0hiioHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps2VK0xE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps2VK0xE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba17c8cfacso51854725ad.2
        for <damon@lists.linux.dev>; Mon, 11 May 2026 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559131; x=1779163931; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPUpmSjgTJAbeTHDAZfVXaAmUiYjeKJO1WxUBCqQG2M=;
        b=Ps2VK0xEbsxlnHiyzG257V8ZOs7dS6FWZdSje2K+lIbHURY9hw/y7dhRxbDDzilc1l
         SkdLXfYcBvuHr9WAxWAQZ0vZsvmWGGiTiic/d/OqSROtc6d1D0qnqBzqVRFGELk/C1dO
         /Dql+xBG7jpIqOmB/j53Gw3uZ8VebsrSZZegztbpgFWdYbToQOKJtP4Y8IhNzRPbMzgd
         6RlVSTvFGltRudzx4NjXoNovVDHuASo76oYrT1OM4PkDJb1/vM/MEWAf/855IprL3Mkz
         QOrnCWyjcI+DSups1mp8+zSUlfN5d09LLwHbwRH1FZDK3doFjjkPJNTGhnIOA/4AFyBy
         c2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559131; x=1779163931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPUpmSjgTJAbeTHDAZfVXaAmUiYjeKJO1WxUBCqQG2M=;
        b=eX5sgYqgIT9JPMqLUGEhRffsmJLtRgQkZ6m+p206ujgyJ/XyoeKWqr5pDWJue2GNj4
         8iQJZv520qTq3AGdkyByKV8BrUQjycQzjGBwslXOGDWADicIVA/z8BKXg9ulDrltsn5O
         Yo1ZAg4pRWNxw5Fbk9cHu3EU7j4oGcz80mCIPSP4qJlOQk0rwjw32M7J3WXMVtyfD2Dp
         IRU/qa/7RXdG6WwHdfAkKUyh0qb+OpJHV/LXK9X8Kfe2BokLzSwfC5YIo0eFPh5xHnzp
         xwy878Y3gE2AXHUh8dI205RS+oKJ24+D/EA+RrNAYVO5S9rGzssI4rpGqOD5ECPA82gR
         fJBg==
X-Forwarded-Encrypted: i=1; AFNElJ/1HHmxtdqQfUKA7Oa29zI7h3wLpQOslSATquSOrVu5SEfKQPwBJlSajLeszp73p08TL3xuGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUAzkOUtGpXgqWP+FMR+tacsDqTU0M+qszqZtBxFpgaukQe3y+
	927zg7N3LZyTkfvK+OKM1LQXk/xu+qqxfR4t0xGEKF9Ci6ShpIYz/UN5
X-Gm-Gg: Acq92OEIahEcbUI8H3PydFg5pLOb2w/r4oYZ9g5DDNsAvULdLP18F+3GtfHX53jwCDY
	VLwjC84E3c/x9W6TVJCM45iRVda+aXZC5S173YZnj7sN8fLACccpSbEWHFUzc5tuFxxEsjiJXEt
	CmEgtku72v8C/qLZ+T/XldEIx+Ug7ejH6l9m8YV/SmxHK0M/v7ZromVQ6TAjfScaOeNqASOVCrg
	5RVD5pA8DNE75c1rDu70axA0pEuCU5LEFrKtbSKDr+yMl9QCVZ412oAC8rVkHH/+WkG0IpYMGn6
	baLmF9UNwcTZMtNSBvTanUZSuV6SKdFtpzj/HIK6ipDjkmdSmR3vu4XAyK/9XIb0P0wWzx4BbhT
	R142tACslaDlf6Qnnrk/OGME6iyNtFf5akWEeSyhucxuOzlr04T66ksEiCH4oBgztDsje4Sn3WZ
	2qxx4mp7nAHpbPSjvzTunYulhdR91Dk7w/WGlDR4zl
X-Received: by 2002:a17:902:bd47:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2bd01174247mr10425085ad.17.1778559131150;
        Mon, 11 May 2026 21:12:11 -0700 (PDT)
Received: from vini ([2401:4900:8fc8:73c6:dda6:576b:fa0d:f68e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bc83101ee1sm85082565ad.79.2026.05.11.21.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:12:10 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH] mm/damon/sysfs-schemes: fix double increment of nr_regions
Date: Tue, 12 May 2026 09:41:57 +0530
Message-ID: <20260512041157.109845-1-agarwal.vineet2006@gmail.com>
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

Fixes: 66178e4ec30a ("mm/damon/sysfs: use damos_walk() for update_schemes_tried_{bytes,regions}")
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

