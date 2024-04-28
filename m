Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55D6FE2D
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714329746; cv=none; b=SwYTM2IcqBTIfUkoyRQ9zuUSTHig8VxZf4xJK2yQc6Yq/bQAjDdQItfm4RiL+CdWXzH5ps0UPk0G1SLQl6lCvwC2E2J/2uINd7CP9ekt8iYbxV5w6IczEXMsLnqs119k/BVGyrXclYoyT5YnHhK3p9dZxafAoR80YyAQEWK/VqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714329746; c=relaxed/simple;
	bh=dE3bmZsbYi7VEkJlsY36cYNHBY9+oidTiOF0oS6UVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDgJsqhyfvehneCPgPSuUC4VUGUDV/EUMeL1MDcbTbT32DlbkKsF1AJQ7/bQnTIKXXiVS8LNVhmSl/xly2+YaKJ0QU/tt92ikroSE0D2SUFnHdhORM4wR+8aoc47/4jHiPxigA7AOBGOglD/mDj/xf79fIurjlrWHilnSdL0ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHovZMop; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHovZMop"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so42466921fa.3
        for <damon@lists.linux.dev>; Sun, 28 Apr 2024 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714329742; x=1714934542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsVmc0/ynjrP+nUinuwPYHpExlOuN4uGVdoe+2kmbfY=;
        b=RHovZMop1BJurWC1jyvH4xzY0xro0OUFXlV7wWkQN3OrRY58AGmMt5elHM+PJT0xpj
         V/U+3wxaBQwJ23JdmmNuRpFp3Mf3AaVrbw8+sswrfGUFTj5MsFEn+DgZyHyJkRkP3Fqb
         Ii4YTwK+cAuaGyy+4K4KYBCAmH+GJwXGnErJmfNPnHSpmiFSbYEtCH7asdvRjpEd+9Vi
         /iAeIemALk4jgl5ZiK0D9OeVhZAA5Q5RNOjP/3hMXQQdSNUTk78ueKHCY9lHaxJQQR1K
         ZMys3P+R9ZJKgXQb2vpldifW7/r6eojo9akN+UYll3FjMzUx6HWtI+sVng8t+mgtHADn
         2WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714329742; x=1714934542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsVmc0/ynjrP+nUinuwPYHpExlOuN4uGVdoe+2kmbfY=;
        b=p/aVrhCJkaOOBINke7OdbKcCKJWTHGJoW3AKKzty9GRbrD5OR37SwYmQYxGXN7FnTK
         Xt9TXmb74IB793r/VUnRHGFKlX9VtotvN3DNEHs1RGckdyx51IsF2gbrfocyTdxSnNVN
         lRuaOGAO4HSETKCbMeErz7Fjergwi0aEt//aqYUSedVoupmcwf/79952NcHF0iUAAMoz
         2vbV3kU6hDjaY+DuvpAO51lewfw34VFiW4LMOKoZLd/98uSHz/esC8l2tktsaOKs3vrL
         seJJJMojEe10mTG/5J6jg5bZ4E2Hykt6miTqggoayCoynuLl8Duk8SJRZyCXU0gPKJNH
         zKNA==
X-Gm-Message-State: AOJu0YxUrGGIzIcPzqHh6oQSBu/ChAltkwEluZACl/7Qg6DOvGu8y7aI
	tov/iinE8A5AzpH5wBpOIWt9J1jEL/NVu4sbecnMBm0XjWFY0MlF8j6j4Q==
X-Google-Smtp-Source: AGHT+IFoh28/VKpPZBotxdG+3d9GwQD4fxgPHcRKC0gIVqVepeV+V3UXuIlj4V9GZ7j465BDKwKfng==
X-Received: by 2002:a2e:7215:0:b0:2df:1e3e:34c7 with SMTP id n21-20020a2e7215000000b002df1e3e34c7mr5251550ljc.22.1714329741824;
        Sun, 28 Apr 2024 11:42:21 -0700 (PDT)
Received: from localhost.localdomain ([217.107.125.136])
        by smtp.gmail.com with ESMTPSA id n17-20020a2e9051000000b002d81c25febfsm3175747ljg.108.2024.04.28.11.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 11:42:21 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [PATCH v2] mm/damon/core: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 21:41:59 +0300
Message-ID: <20240428184159.188535-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240428154933.183760-1-yorha.op@gmail.com>
References: <20240428154933.183760-1-yorha.op@gmail.com>
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
 mm/damon/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d503c1c125e..53d33b2fa0b9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1480,12 +1480,17 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static int damos_get_wmark_metric_value(enum damos_wmark_metric metric,
+					unsigned long *metric_value)
 {
+	if (metric == DAMOS_WMARK_NONE)
+		return -EINVAL;
+
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
+		*metric_value = global_zone_page_state(NR_FREE_PAGES) * 1000 /
 		       totalram_pages();
+		return 0;
 	default:
 		break;
 	}
@@ -1500,10 +1505,9 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
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

