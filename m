Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C61C2D
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714319395; cv=none; b=Wf6h7bfQ4S5VE+HSZtDQOEnlw/ffvylzAJryuLGaavP9pwNDf2weCDXROUBfasS9a8FNK7GOFdoNcKg77+ZEvIS699Tx/DO0A77AgYdP9GUfQs8Ttt0mL0tb2xtuaAAl3SHQCGSzyKm9aORryQD2yFc2razT1E939RUqbKkkvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714319395; c=relaxed/simple;
	bh=FEuHsNr9sHQu/PKrfT6+Fgj0YmZ2ha3SJ+R+uNmZfe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTKi45cZMONP/g2Ms+M1s9WKJzFfoKSJPu0gHjeFXk6GNEP7NRaloAsezb35RhE4+m3QvG1aUnc3B61M7NMDkwOOO75DZ7ZFQZ3N6nCAEvjXbvBew8l0iCNcDZvPTdaycsFp9iWuZ3NrA1SZcmwvh9q8/UzcA78yo8MuYwI6R/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOTHbnzN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOTHbnzN"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51967f75763so4254178e87.2
        for <damon@lists.linux.dev>; Sun, 28 Apr 2024 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714319391; x=1714924191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eC0uh5DnA8Lr/h0xRVODqCfHrWrk7DcxZB4WXuckG4=;
        b=fOTHbnzNAoEN5wmqC7S+26I7qP/HlRNlxXJV2r86Qewb6XOQ1jmlZQHNT07v/ow4XV
         SPj5P8I6n7vHaWSYa7HKfna3u/jhPq/66wu8Rku7MZ1fRYmdechzzvKjahM/EyZS5CYI
         NCYMIPl/CUAhMnyi4J3u9aPoMs2VnXND4rfpLz6YS6nADsSFWoy1//1ZF3XJ7cSgg6Rr
         nfxulUz3AL5lCOBXUMSAxez6CneqZ0uVP4N9hAOeAhBGf8d88Oh+RdaTq9UcEqnhvdcY
         JdnHP810t9RcbBRk8nVjKpTlzKJSsS9vGO+Crwu1PA2LIj4NQNnIg/hJwwsUEfMrk1Rq
         4xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714319391; x=1714924191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eC0uh5DnA8Lr/h0xRVODqCfHrWrk7DcxZB4WXuckG4=;
        b=YihpmS3uS0C33wv+s26SoN+w9o2DwLAWeyfSbU98HEdfbdnd0FNcg9rgJEg3T9bKGE
         a/MGuRdMKSjdoJzdZVTBwrdBzf9bRTtgKFOrkMBMdhjZRUqarB9jZf68mrzLHLd3XKXm
         UObjVaLxT9XDIQ6FU6za5T/6v+cB2/M2y8zxc8eSq6MfcKgUg2jNr7c3YDlg01VFle/y
         4Z3x+qcnMBGi8BpOVYrE4axR2KdPvxJde5Icp2CTw6jqzssQbj/NaOXo6BPBcHZe2dLS
         DUqM+nMhj0AX8RAKnCAqUTEPozpT/3pe9ASIfDhbHHd0FVWmVeO0zMiAHL3CwfeRKQdL
         pxJw==
X-Gm-Message-State: AOJu0YzQJYb/8zNoWNY9A3Y9Wfj0QX+NSUmATJV1oO2jpqzBBJZSWVOc
	geT09qD7AAV+3CiZEGb5NBmF+rYxjmERLrhnllHZfJxxqwQXt0smDYnATQ==
X-Google-Smtp-Source: AGHT+IHvQfX1l1nvvDRkFdQxuR9LImGByrcJN5JOvH/vKAXoHK47NgIWHf4TfVWhJyrYwO8rIJnAZQ==
X-Received: by 2002:a05:6512:ba5:b0:51c:a0e1:2a44 with SMTP id b37-20020a0565120ba500b0051ca0e12a44mr6898746lfv.26.1714319391207;
        Sun, 28 Apr 2024 08:49:51 -0700 (PDT)
Received: from localhost.localdomain ([217.107.125.136])
        by smtp.gmail.com with ESMTPSA id v19-20020a05651203b300b005159412ab81sm3803147lfp.216.2024.04.28.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 08:49:50 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [PATCH] DAMON: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 18:49:33 +0300
Message-ID: <20240428154933.183760-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 mm/damon/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d503c1c125e..994ccd272555 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1480,12 +1480,14 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static int damos_wmark_metric_value(enum damos_wmark_metric metric,
+				    unsigned long *metric_value)
 {
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
+		*metric_value = global_zone_page_state(NR_FREE_PAGES) * 1000 /
 		       totalram_pages();
+		return 0;
 	default:
 		break;
 	}
@@ -1500,10 +1502,10 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 {
 	unsigned long metric;
 
-	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
+	if (scheme->wmarks.metric == DAMOS_WMARK_NONE ||
+	    damos_wmark_metric_value(scheme->wmarks.metric, &metric))
 		return 0;
 
-	metric = damos_wmark_metric_value(scheme->wmarks.metric);
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
-- 
2.42.0

