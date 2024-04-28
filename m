Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273073176
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331687; cv=none; b=k4Icn7Wxf4Vj4VrOmSAMS2txyQgUZmooVCtRKTVA7dWqxXMTlBIeumpAEXFTVrBacxwiB/UAEIHieroDYglwXrrRYcdCM82ywKhfOfO/FM3rYov8KvjhMyseWUK5z601XNbGoudFO2g2t253ktE/7zx0QLm3e9spV1ExddCL0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331687; c=relaxed/simple;
	bh=1O+xCTh7Ei0O1yxn7zsOyNPfwVDR78wo4t+OtVQz67Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARszL5GlM2ZFKIJIVFa4cICwOFDT7GODI88y95SZRVOODieeYIpxw5dXMr/fqo4BaknPeSvO45hRUjWBAFzHq9TNmZHqk5DhYHJmxcty0qGyAgmY3ShdzWk5DIytBU8wO0Ez+hupsSpszh6jiw7cRzDBAR55rC3gM3qdFLgiX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if3n5tpl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if3n5tpl"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d858501412so48404131fa.0
        for <damon@lists.linux.dev>; Sun, 28 Apr 2024 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714331684; x=1714936484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4OLMw3lowjeCnYYDix/KsUmPkxrHIY8rPBlXsXuBxo=;
        b=if3n5tplOllERBMWUV5Qbrjlm9v7L+4dBx76mfNdLaKQRtykF6pUDQWcDxA4lMv0yG
         v4xts0itpEafg77567WrAKVH2O89vcDdEUwT+HUNIXYln/odqs4WdzWJiO5TjVmmPT3f
         ZYD3Vq3BUBiW3SsJmYWUVaiGWrNey6qe85FRSCPS3WqFT4rFApJz1VUW2RflN7RJAqYN
         tC82UWeMvo3Bw7siubV2PJMRApUPvCaqOdqktnBaOwy97HJWYgGKBQg6DJGVqi9ueD00
         tOTRigG8WLFJhNTcKcqW8vOY03Z5f5P1LzGaYIUFRfhLow0VXOGLilQewndHe9LPo6Eo
         9jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714331684; x=1714936484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4OLMw3lowjeCnYYDix/KsUmPkxrHIY8rPBlXsXuBxo=;
        b=wRGvLwDyedDdCL4WpXkU8oVAWTULGSuZMsnrYytMd7tdemd7oDopvrQ9LM7KLtcyW1
         f8URjUePTX9X4Msaaqo9/TyxHzEJgJuVc+XLlK+sgQpNRz/gGWnxBDgoR/70oi/Xn1Re
         KgFjYSQGxmRCUbwuYyn9aBtYDT76Y7gmjEADByjmiXF+csLi5NoQLiR7IR0P1LD7S9dn
         H+orEJ7CmciYuVZEUjyTcFA3vrZPM691lbMn5DLHLmG7RJ1pqYxKKA9KhDD33hy/s1oy
         su6nf8ndrxY3DsdjhnDGLrmb8qSEHLK7F1zN/lZu4lDU+wYwFImKKfVmklkvJnzxdJow
         gUiA==
X-Gm-Message-State: AOJu0YzPf8LmKtzPknd20lwR/wiheBI1FcjqIgRepZ6ilqSUqTYamS2f
	ADu1G+qIjaKmtKyPQ7/sDsx9zE2yLa4IByinuZPlP8rcwWc4GyY5bhuoUA==
X-Google-Smtp-Source: AGHT+IEIxAR1FSOBdkhaWEb5zkP7yTwGICG6BdQvx5bzicEcFDoY/COoWohfTmDPM7QnZTw6NKxQ8A==
X-Received: by 2002:a2e:9dcd:0:b0:2dd:c6c8:dff4 with SMTP id x13-20020a2e9dcd000000b002ddc6c8dff4mr4470375ljj.24.1714331683424;
        Sun, 28 Apr 2024 12:14:43 -0700 (PDT)
Received: from localhost.localdomain ([217.107.125.136])
        by smtp.gmail.com with ESMTPSA id j21-20020a2e8515000000b002df8f0bec06sm750078lji.96.2024.04.28.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:14:43 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [PATCH v3] mm/damon/core: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 22:14:39 +0300
Message-ID: <20240428191439.194027-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

damos_wmark_metric_value's return value is 'unsigned long', so
returning -EINVAL as 'unsigned long' may turn out to be
very different from the expected one (using 2's complement) and
treat as usual matric's value. So, fix that, checking if
returned value is not 0.

Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 mm/damon/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d503c1c125e..172095e68c5d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1480,12 +1480,14 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static int damos_get_wmark_metric_value(enum damos_wmark_metric metric,
+					unsigned long *metric_value)
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
@@ -1500,10 +1502,9 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 {
 	unsigned long metric;
 
-	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
+	if (damos_get_wmark_metric_value(scheme->wmarks.metric, &metric))
 		return 0;
 
-	metric = damos_wmark_metric_value(scheme->wmarks.metric);
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
-- 
2.42.0

