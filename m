Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17F136E04
	for <damon@lists.linux.dev>; Mon, 20 May 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215467; cv=none; b=NnnpJeAJ9SmZxiSE8SA3PuyKUmK6SmoV9M7Rz8F3Udd0Rh8J7KRVeeGpxy6ypg9j0iQuhfQlYVvDcXyBHz4i9gn+WhRPaqoSq4nxmBuB7+Im8tbrcAhBQs5/IjwmJEfLpfObpVCGva2Gx1P6YcAr+2jdvpoU0pmo4vmpdkaD1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215467; c=relaxed/simple;
	bh=mDA8v9G7f+U3FaSZiKaYOCWuZt/Ho55XYWskkCZ0qEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aK++7GJLJBjILXtDI7rLXjHHpMe3ZOkTc1m+LuoT7bnuMitDsRZgLwbeoaReVpqccSV2GzyahEVVoN2UfOZltkUV7jeG/4BxHzuoabUArYZp9r6f1glGDv4ww1IoK4VG2BwTwraTA13W1CLaUFM6McW/IIHwWs9Zw1vVZHLtXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=cHOt1CfA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="cHOt1CfA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso75433375ad.2
        for <damon@lists.linux.dev>; Mon, 20 May 2024 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215464; x=1716820264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+JsgoyJouVNGeodk33FzXnjKwnGHQfbLoITrru7PxI=;
        b=cHOt1CfA6L0C6Fc9cQgvzKBzzZuAyUuTWLl6gzD8/kotINVKf4wDVI6uJzKgmUfnxJ
         Gxbz61YVKscjKGq4K83hU7eI9W3l4lQW1ZmQdopDMhPs4qKQ/Op2NVrK9SmkmBZFQ3mF
         pSMNG3VXBeW5WTLP0yrGd5UmnJdE7SvVfCJCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215464; x=1716820264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+JsgoyJouVNGeodk33FzXnjKwnGHQfbLoITrru7PxI=;
        b=XCT9KGt4klim/dwv7ghMD9xCb68ImNwi2AllJa8ureBvA6oLeFT/wT1PF4leiCtckj
         XlHIwRzR5LIGQgeXkMuh22ZcRbOYPHvG8WsBQ7Gye6BUpFMorrZ5LJ60srRKIaPf94Ht
         H2xs0rN7HPCfhmGGf2oXtBf3ra06KqiY2JmJuBgQd31JMeAEzhh/x7Te1xPBHrx8hV3O
         U1fB+0e22ilLz1Wy0vGNu6UBdLe3v6B7QR+EJZnvPiFj4vBBDzx8FYTSFRuS4xLoFRG3
         LF19OqeOqzmZBBzblPHtPbay1XYEZee3qtaEjyAr12lCM8lvHZ/X/p3WIhDKdZoMbqE5
         ioIg==
X-Forwarded-Encrypted: i=1; AJvYcCUl2LDXa04Fzhh00vuOj2EA+4r3bqr/2ermlB6HWjwUyFImoggRJT8vR6up06egj4Q+I4bv+9zQdM7NgzKiO3WIeI1i0y8=
X-Gm-Message-State: AOJu0YzMFTwYtGDGRh8cCL88K//qMtZ3CexLlGkc8r8jq89md8uvMLuj
	5k2KGM7TS6jSZEshMpre3IPA9kZmEQkgHMDbAnE4zKAYvmGb/3ujsadmbZxR/RbdUFSX1kuV3Lv
	Kqmo=
X-Google-Smtp-Source: AGHT+IFEmIm7pgm30gC+GoeJM1s6pb8RIXfriP134g6evyIVXQGX3ZSXJHm7vjFT++H0TqTRHY/rng==
X-Received: by 2002:a05:6a20:7486:b0:1a7:878f:e9a3 with SMTP id adf61e73a8af0-1afde0e6b38mr30695430637.22.1716215463579;
        Mon, 20 May 2024 07:31:03 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:31:03 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 2/3] mm/damon: add module parameters for NUMA system
Date: Mon, 20 May 2024 14:30:37 +0000
Message-Id: <20240520143038.189061-3-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520143038.189061-1-tome01@ajou.ac.kr>
References: <20240520143038.189061-1-tome01@ajou.ac.kr>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements support NUMA-aware DAMON modules by adding kernel
module parameters. With this patch, DAMON_RECLAIM and DAMON_LRU_SORT can
use this feature.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 mm/damon/lru_sort.c       | 1 +
 mm/damon/modules-common.h | 4 +++-
 mm/damon/reclaim.c        | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a6..3e25a52de 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -81,6 +81,7 @@ static struct damos_watermarks damon_lru_sort_wmarks = {
 	.high = 200,		/* 20 percent */
 	.mid = 150,		/* 15 percent */
 	.low = 50,		/* 5 percent */
+	.target_nid = NUMA_NO_NODE,
 };
 DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_lru_sort_wmarks);
 
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417..b167bb24a 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -27,11 +27,13 @@
 	module_param_named(quota_sz, quota.sz, ulong, 0600);
 
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
+	module_param_named(metric, wmarks.metric, uint, 0600);	\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
 	module_param_named(wmarks_high, wmarks.high, ulong, 0600);	\
 	module_param_named(wmarks_mid, wmarks.mid, ulong, 0600);	\
-	module_param_named(wmarks_low, wmarks.low, ulong, 0600);
+	module_param_named(wmarks_low, wmarks.low, ulong, 0600);	\
+	module_param_named(target_nid, wmarks.target_nid, int, 0600);
 
 #define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
 		succ_name, qt_exceed_name)				\
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 66e190f03..31b8830a8 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -68,6 +68,7 @@ static struct damos_watermarks damon_reclaim_wmarks = {
 	.high = 500,		/* 50 percent */
 	.mid = 400,		/* 40 percent */
 	.low = 200,		/* 20 percent */
+	.target_nid = NUMA_NO_NODE,
 };
 DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_reclaim_wmarks);
 
-- 
2.34.1

