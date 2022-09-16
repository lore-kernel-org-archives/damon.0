Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954595C81
	for <damon@lists.linux.dev>; Fri, 16 Sep 2022 15:22:55 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id e5so21565854pfl.2
        for <damon@lists.linux.dev>; Fri, 16 Sep 2022 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8piKn5FnzNCRTWXKeKltQYBcUotQeP0xAHSm87BtmOg=;
        b=YKah748oMkqEZtDKOJdy63FjeXS3rfEh1bkzQ9bZPEQyZRWO+kERMHY6vVw6kAhfG3
         e1CP8tw9FI/kXPKWTntaMb/QXYAHS5QC+wAOzJtYwfCorb1I+/PBrRkFEEp2qebmiZ3k
         aEJJqL0JLKwMe7JnitgX+aSZABWgKDbbxvxSvFRgKvnvefN18Ne9RaHUdAPpiOGpZjo9
         yl4zR8qfzoinC8toiPtbgHoRmdRwSVr9WxFCrhLUKGCB0/o6Y+z1RvYj7fDPI1892c+5
         Q2ddyEuKcKEEoEzCFiWAkUuuRCCnn/rlaBTJ1qu4DMZdbqDqFUmlffJ60paVzJ29gbfb
         ZBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8piKn5FnzNCRTWXKeKltQYBcUotQeP0xAHSm87BtmOg=;
        b=rwlDnoaNiJcumX03o6zRxIbFK24cjkzfpUl6b2ErOdKmyuaR0e/77yuAepNFRSK1Iz
         hv5qRFg3PCGHmRVDbOl6U6dz5dU0YexmFquNua8BwI8VYzKdgG49JowGcbcAYusAosCw
         aRDX8X9sro8dJat80IpE5GMpIob1oIpDHQJfn/eQxGMnAcrtCIdyemge0tkU/lh+u4C4
         nQWeMvZF8AKU/6PIc3HA9B2P7lQCw2DsxxNSuAIcpIOq72qa8xyQx3KQmWIj+5/2RdFR
         vYRmHZkaOXtMqAxn2KfuaPW5j43fIcLLyHPtnFPQVh3T/jIrMgGVg/vuKmt6vztnZC5n
         l8bA==
X-Gm-Message-State: ACrzQf0CWbooU+ITzsff6rR7BvMnFnkexUvkTBocKcap2ZAF4ZhJNv3X
	QQQrXDbvTbawy3Vt/rIAYw==
X-Google-Smtp-Source: AMsMyM6xJ68WQvbE7MiwVujE3NnstM8TpzOuUmkp/ve1xHZ+2MhL2p85sgsiPNKOB//JCsfxBtwsaQ==
X-Received: by 2002:a05:6a00:b4d:b0:540:cee1:657e with SMTP id p13-20020a056a000b4d00b00540cee1657emr5359168pfo.22.1663341774957;
        Fri, 16 Sep 2022 08:22:54 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 17-20020a630d51000000b0042fe1914e26sm13845173pgn.37.2022.09.16.08.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 08:22:54 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: return void from damon_set_schemes()
Date: Fri, 16 Sep 2022 23:20:35 +0800
Message-Id: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

There is no point in returning an int from damon_set_schemes().
It always returns 0 which is meaningless for the caller, so
change it to return void directly.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 5 +----
 mm/damon/dbgfs.c      | 8 +++-----
 mm/damon/lru_sort.c   | 4 +---
 mm/damon/reclaim.c    | 4 +---
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1dda8d0068e5..e7808a84675f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -541,7 +541,7 @@ unsigned int damon_nr_regions(struct damon_target *t);
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
-int damon_set_schemes(struct damon_ctx *ctx,
+void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_nr_running_ctxs(void);
 bool damon_is_registered_ops(enum damon_ops_id id);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a843673c11cf..9c80c6eb00c2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -454,10 +454,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
  *
  * This function should not be called while the kdamond of the context is
  * running.
- *
- * Return: 0 if success, or negative error code otherwise.
  */
-int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
+void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 			ssize_t nr_schemes)
 {
 	struct damos *s, *next;
@@ -467,7 +465,6 @@ int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 		damon_destroy_scheme(s);
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
-	return 0;
 }
 
 /**
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index c00eba4448d8..6f0ae7d3ae39 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -307,11 +307,9 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 		goto unlock_out;
 	}
 
-	ret = damon_set_schemes(ctx, schemes, nr_schemes);
-	if (!ret) {
-		ret = count;
-		nr_schemes = 0;
-	}
+	damon_set_schemes(ctx, schemes, nr_schemes);
+	ret = count;
+	nr_schemes = 0;
 
 unlock_out:
 	mutex_unlock(&ctx->kdamond_lock);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index abfaf471e3e9..0abb9f8aa9af 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -203,9 +203,7 @@ static int damon_lru_sort_apply_parameters(void)
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
 		return -ENOMEM;
-	err = damon_set_schemes(ctx, &scheme, 1);
-	if (err)
-		return err;
+	damon_set_schemes(ctx, &scheme, 1);
 
 	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
 	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 039fa55e0ae9..3d59ab11b7b3 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -155,9 +155,7 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
-	err = damon_set_schemes(ctx, &scheme, 1);
-	if (err)
-		return err;
+	damon_set_schemes(ctx, &scheme, 1);
 
 	if (monitor_region_start > monitor_region_end)
 		return -EINVAL;
-- 
2.27.0

