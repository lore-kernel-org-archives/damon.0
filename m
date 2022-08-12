Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9B36C
	for <damon@lists.linux.dev>; Fri, 12 Aug 2022 01:27:07 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso6566389pjg.0
        for <damon@lists.linux.dev>; Thu, 11 Aug 2022 18:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r6pkBLYew73BseP+hLTOhqoRkIsBep/iLPB2yjs5hu4=;
        b=I0mTgVUKEsBOB15afJoGgRDCtfUOYBLEclD96bBTCk6xZwMNtvse4Yg3mFsZKl5ky7
         3R9SCHwbkSjq2N8RaMQVScSXxTr+Fp20m6PaunXeE5hzKvEu/cYysYKAhQAMG5ITBPNO
         iVjhe0vTHnMk234H/RLfdNUVjzkgoqonUlV7T7pLCHCh5j+5UKd27FUtHJOpN2aL8cON
         tuPbypDARlYH31Zanrsvv6fPxUMzVc00AS1i9NL6FsV0J6nFLllCTrBGXfUMGI8LGhMT
         PNM1JTuXXXxuRaEVMzmJLcSi2cnT+Qv3GeWEcZUhmCnt25JH+X6yMdwuRcYWBq3fR8d0
         OO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r6pkBLYew73BseP+hLTOhqoRkIsBep/iLPB2yjs5hu4=;
        b=OCdp82UY4DiLhDJnaoorh4BpzEv2r/CQWY0X36NrROvtJb+0/+fEWtJNyl3ndl8aN7
         igcVUGaiPAb3RIQ56ztFXfPYo14os59V9KQrINm4jvMQnBZYzpN38746iMXEQA25jlNs
         Lnn9soAKaPWmpFkxTzIeKUVv43Zjuc/oxo38yrL8ObAKbjWNGlZxTH4ZeyPVgRCWAsl8
         gM0C4yj5PYHyI6q9qZwNlaWquX6/hXTxvjc61Y/YMxb4GpIYH8G1LSnl9QVBXScJ5434
         Wr9yJ4rw0+S5Z6NStYay+oy8c9j5PFXhT1fiMBpVn8SVTqfdl5yvvLKzSr1QC266Z5pK
         4nig==
X-Gm-Message-State: ACgBeo3zZ5hGOOpJsdY4XAj7stPds/z1gX8iThHLauF28/ZmmbNKk0Kp
	knFlnGWE9EYi9g7zBv+OTso=
X-Google-Smtp-Source: AA6agR4K5xv36FYebO1ewf095xyPwaXieUgWaIsc0nTbqCWmatPVjFUaQabDKVGKhdZQ5wztSWB5+w==
X-Received: by 2002:a17:902:da89:b0:170:a235:5993 with SMTP id j9-20020a170902da8900b00170a2355993mr1720629plx.94.1660267626881;
        Thu, 11 Aug 2022 18:27:06 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052d200c8040sm322671pfy.211.2022.08.11.18.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 18:27:06 -0700 (PDT)
From: Zeng Jingxiang <zengjx95@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] mm/damon: remove dead code in damon_lru_sort_enabled_store()
Date: Fri, 12 Aug 2022 09:24:59 +0800
Message-Id: <20220812012459.481215-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

The variable damon_lru_sort_initialized is always true, causing the
corresponding conditional expression cannot be executed.

Assigning true to damon_lru_sort_initialized here
544         damon_lru_sort_initialized = true;

The value of damon_lru_sort_initialized is always true.
As a result, the following expression cannot be executed.

463         if (!damon_lru_sort_initialized)
464                 return rc;

Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 mm/damon/lru_sort.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9de6f00a71c5..e2a656e1b728 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -450,8 +450,6 @@ static void damon_lru_sort_timer_fn(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(damon_lru_sort_timer, damon_lru_sort_timer_fn);
 
-static bool damon_lru_sort_initialized;
-
 static int damon_lru_sort_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
@@ -460,9 +458,6 @@ static int damon_lru_sort_enabled_store(const char *val,
 	if (rc < 0)
 		return rc;
 
-	if (!damon_lru_sort_initialized)
-		return rc;
-
 	schedule_delayed_work(&damon_lru_sort_timer, 0);
 
 	return 0;
@@ -541,7 +536,6 @@ static int __init damon_lru_sort_init(void)
 
 	schedule_delayed_work(&damon_lru_sort_timer, 0);
 
-	damon_lru_sort_initialized = true;
 	return 0;
 }
 
-- 
2.36.1

