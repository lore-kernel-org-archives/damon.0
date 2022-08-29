Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14082C9E
	for <damon@lists.linux.dev>; Mon, 29 Aug 2022 09:47:08 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id x23so7441510pll.7
        for <damon@lists.linux.dev>; Mon, 29 Aug 2022 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=WCWvh4lo94fZ8ZBFtAu0Nlm75Eg+DNVgcN8RUJinllU=;
        b=J+GEvp1aNPQ/lMGxZ0Ih9OYwR550sY4wPsU1jBeRdYWP/H+pKXR/pLdWbS8IR8qw0o
         VCr18L8cQyRIk2fNPQIfw+rthUV7UGn6+hmid/1BKMJvt4Dc77I3BFdZOD0rEM6fFUJH
         mSpVhr+pdZbJoz7tibho8YlpMgWcZvWGRK+SGjJeiImU6oDEBmlFpXjpvw3OLJAG5XLj
         79pgQLdLl1+yXALQKgMjdFoGrooq8BLs+WfNC5B7zUr/ZNrQhXFLwybTjyEZxxckcLqw
         1PtHM2JIgoGjqXomZ1JLEFd+Bp4VPrC3hWPFXGJ7lGAWiuQKyFLuUq6x4Y5MSR4FG5pU
         LY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WCWvh4lo94fZ8ZBFtAu0Nlm75Eg+DNVgcN8RUJinllU=;
        b=cpKnUkm9TnmVgk6IjD34S7CCYUyU3hZO8vC9Rt83xbudJ9ykQBnOmeyyHz6Stoqs7y
         9UxR6na9Y48a5kABZOSj81kgNvT9v97A9aF2gJFRjzvOi1ELxj1s9s1oE6IVK79Drr0c
         TX//6S3fmbCtfqYMkmxPRm0M7859dS+1VgOrCBGrllC5zmLYbW4JuLaXljyDd3DsV0w/
         Ivohtumeu7a+aP7/SVYbQRm/sNsNQtGAvtV3nKhg94GPNDHkK+U2oYK3jOwED3vb/gSr
         Qc8LCubaq2sihgUo0Zo4RG2aB9TgHj2Zjn8h6oLoJ222FQgNJZbr6QlepOVwln5Xp+H+
         +6xQ==
X-Gm-Message-State: ACgBeo073Y57oLS8ZmDWb8CifSDiO9uGxkL8rTIfCEA8wSbXTdim2+Ly
	HH6GmPJ77IwPV7CLNVoGcQ==
X-Google-Smtp-Source: AA6agR4UHapZ8kLe3GaRmB8rX3Cc88S3xMaDmHkYryxb9UGyCfBRhCVfinlNXxAKKiBApXkhoNieUg==
X-Received: by 2002:a17:903:18a:b0:16f:e43:efdf with SMTP id z10-20020a170903018a00b0016f0e43efdfmr15514244plg.157.1661766428407;
        Mon, 29 Aug 2022 02:47:08 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709028a8300b00162529828aesm6967306plo.109.2022.08.29.02.47.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:47:07 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: get the hotness from damon_hot_score() in damon_pageout_score()
Date: Mon, 29 Aug 2022 17:46:06 +0800
Message-Id: <1661766366-20998-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

We can get the hotness value from damon_hot_score() directly in
damon_pageout_score() function and improve the code readability.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/ops-common.c | 46 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b1335de200e7..f599838b5f64 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -88,7 +88,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 #define DAMON_MAX_SUBSCORE	(100)
 #define DAMON_MAX_AGE_IN_LOG	(32)
 
-int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
 	unsigned int max_nr_accesses;
@@ -127,48 +127,14 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 	 */
 	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
 
-	/* Return coldness of the region */
-	return DAMOS_MAX_SCORE - hotness;
+	return hotness;
 }
 
-int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
+int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
-	unsigned int max_nr_accesses;
-	int freq_subscore;
-	unsigned int age_in_sec;
-	int age_in_log, age_subscore;
-	unsigned int freq_weight = s->quota.weight_nr_accesses;
-	unsigned int age_weight = s->quota.weight_age;
-	int hotness;
-
-	max_nr_accesses = c->aggr_interval / c->sample_interval;
-	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
+	int hotness = damon_hot_score(c, r, s);
 
-	age_in_sec = (unsigned long)r->age * c->aggr_interval / 1000000;
-	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
-			age_in_log++, age_in_sec >>= 1)
-		;
-
-	/* If frequency is 0, higher age means it's colder */
-	if (freq_subscore == 0)
-		age_in_log *= -1;
-
-	/*
-	 * Now age_in_log is in [-DAMON_MAX_AGE_IN_LOG, DAMON_MAX_AGE_IN_LOG].
-	 * Scale it to be in [0, 100] and set it as age subscore.
-	 */
-	age_in_log += DAMON_MAX_AGE_IN_LOG;
-	age_subscore = age_in_log * DAMON_MAX_SUBSCORE /
-		DAMON_MAX_AGE_IN_LOG / 2;
-
-	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
-	if (freq_weight + age_weight)
-		hotness /= freq_weight + age_weight;
-	/*
-	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
-	 */
-	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
-
-	return hotness;
+	/* Return coldness of the region */
+	return DAMOS_MAX_SCORE - hotness;
 }
-- 
2.27.0

