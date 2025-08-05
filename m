Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D24292B35
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410854; cv=none; b=VkC6t6TpdczhfzFbslIT0vv1yoR7PmQYAaLOy5sBRBMbKKWTGO7bpv2pGy8HQi8Icn2Hu8KsuqqqF0gZcwtnNzQNCKseo6lzTDNmwPt1yxHufWQWNATvPfnIH/T5D5RpXPtwAZBf5or1ZpC19enbpneelkG10WryyRpRBhDadZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410854; c=relaxed/simple;
	bh=tF65PXhkOzWY/Nr9yG/G9amh/Bayj25Uf9hB29HafnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwb4hK3FswNbSP6DrqVlOF64Es8YY365pRm53VOhjHzpHbkpJ4X/Sk6iERUA5W3ZK9QvXGNSxQOp6dlRa6H+8+4p0iOhlloeQs4TVqUADCXj9aGVNintMtNJkbvB9bN44wMjJAxAcw0cj7ImPk2cRmGNXW/tNCSxhqt1HheIyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTutUr1t; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTutUr1t"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-719f5a141a3so290737b3.1
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410852; x=1755015652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDs8MlFPdGXXGi6TlMzCzWKbAeHvaPRj6HPGrEA8aHE=;
        b=FTutUr1tNdV4mm1LzorYevFy1QyU3FLb4BOQrb+8pHsUkaEpur+2ksnNZ2siZXktt8
         45MDLwvygUMBJz14/VNv+GQbxlkBM+VSEhKl2YbT7xxaFJYR0R63n9MTBmwtl2b5VU5u
         SVx9U9LADGIx3Lef47c9Nm/9lhxLosJdEPjzE1K2STvWBHBOWveNsDygqpiY++W6wot8
         F+4ayC9JH6+F4vNUjymvX7NTTW3GJ/NMMhaOH6lOiEeYhAWdt3tG9RqSJYH0p+2ZQQBh
         yZE8GmCbQzmDtDRK3HTyjv/r7ylPOAw2EcUmiK8TvOBsIJVsGeCVEbiF1zHzJDvFo6Vx
         cF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410852; x=1755015652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDs8MlFPdGXXGi6TlMzCzWKbAeHvaPRj6HPGrEA8aHE=;
        b=QBlFV/rvKSF3e0h5yHRmRvp6ZmgifDscP8wHDfjRU5x2h14Fm6Vq18kjh7JRtwE5Kr
         8Xudmqm+M3sFLl6M7hlKc5azD4hAyFyGwfl0BgRFKQYtHfsyC+dq/mjYRsZWZmNGeM8+
         2JxDxH/fkvGXgEMXrWixzeT4NFWbAKR5dRJYPds/4Go+bScTKGA+VNi+TjVipk1VWZvp
         3acsOdH8gmtkksr1Dph3465cg9gvvgaMDXj5fm5XWLfW65vFJ7Y7AG3otv7M3kL8Rjep
         64yQ4ujwkM0O17A3StxX5bDaN4uqtWN8zpOiS3IY5GGJdlNKW+QoNCdp5Fw/O6nV+FO9
         /AIg==
X-Gm-Message-State: AOJu0Yzsn/CVKAYQrKKWiinr2snAgE79Qb7vT508lAR7UJE90iRrRsft
	HKLcqf4XlWkx93A5kvgCAaDJx2rBuenpCOTBX6D1UUStnNJBwb1SGAzNoy69+w==
X-Gm-Gg: ASbGnctv0sSoR2sywTMJgv1qtvlgNiXS+OTKGsy9uD+/emIZZFv45gCwkpQre+zNHG8
	SDHlMgaHJVnuVP4jx+g9KZRK8NyjyArTL6QRzatRKX6oaY1AgFT7DacPDVSu5RKEOZ+3LQ+pygK
	Liu9jT17hv8/AaX/mgKjm3ojhbATDB/AHDraWKg5STS4+ls7/W+MLpanJLjD0PCrKycejpqdyEw
	SnLxbFSxGpoxXKqdSOwAhvKbBgvUmjfSpy4XgTwZLMht3toQxNLIT5UwsLIyJLAizKmE7fQ7qF5
	Sl/uPQTylni+3I2W13Jja2UOiWvxN1cjKbwcn0PfhEc3P3NI7YVHpJUU+SJWp6iATBeD+oyhQMd
	TU2HzSdw8Wka0J93sbd2zUc5WrgfLveMLw4ysUpaZ060IXFwKD6rHMg==
X-Google-Smtp-Source: AGHT+IFnyMpRgYiV7oRfT3D4U/J6G+wtU+eDsuK0pB5vtb532dpTisNQyFGaJtTj/nzk7d4QMO8Fuw==
X-Received: by 2002:a05:690c:6f04:b0:70c:ceba:16 with SMTP id 00721157ae682-71bc7edb174mr5896047b3.17.1754410851928;
        Tue, 05 Aug 2025 09:20:51 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:51 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 1/5] mm/damon/core: Add damos_destroy_dests()
Date: Tue,  5 Aug 2025 11:20:18 -0500
Message-ID: <20250805162022.4920-2-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patch adds damos_destroy_dests(), which is used to free a struct
damos_migrate_dests. Currently, the contents of a struct
damos_migrate_dests in freed inline in damon_destroy_scheme(). Moving
the code to a separate function is useful for when damos_migrate_dest
structs need to also be freed elsewhere.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6b797120d2f2..a851c8bc2e52 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -914,6 +914,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
 void damos_destroy_quota_goal(struct damos_quota_goal *goal);
 
+void damos_destroy_dests(struct damos_migrate_dests *dests);
+
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6a2fe1f2c952..07b4fc5a9790 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -359,6 +359,12 @@ void damos_destroy_quota_goal(struct damos_quota_goal *g)
 	damos_free_quota_goal(g);
 }
 
+void damos_destroy_dests(struct damos_migrate_dests *dests)
+{
+	kfree(dests->node_id_arr);
+	kfree(dests->weight_arr);
+}
+
 /* initialize fields of @quota that normally API users wouldn't set */
 static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 {
@@ -451,8 +457,7 @@ void damon_destroy_scheme(struct damos *s)
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
-	kfree(s->migrate_dests.node_id_arr);
-	kfree(s->migrate_dests.weight_arr);
+	damos_destroy_dests(&s->migrate_dests);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.43.5

