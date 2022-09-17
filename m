Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A863A
	for <damon@lists.linux.dev>; Sat, 17 Sep 2022 09:41:08 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id p18so23594253plr.8
        for <damon@lists.linux.dev>; Sat, 17 Sep 2022 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I2k6FBkPq2fQ+qY+MPawIgHovGyQd2pxR4RTiazNyF8=;
        b=dajvXB6kZu8KO+gyPyFElF2PIjCqvUmoEXdq2fOMtfG++18dZaL1b843kJfZfLJSO3
         7E3nMhS96Qf1BL+yuOZDmsi4YE4FugYd8/68MOGaaaFiGro9ryPlvtqbyhfFGiL5BfXr
         NspXhgjzr/VCkLZiV5addqJo5r3svDhKKLsNexNgoXeMbkig1LnJRr2h42FPBjkz3oU6
         EvFQC1KhUsH3e6IHe7ErqM8rSvA0YB3KvvGqy79N9hMA4aM/dO/YdaNHvGUf5QBgOxbZ
         HObPOftpFzZXJ2qJab132C4wQhg0xnweWSR/R6bSJ62L+qfu+5WDTaok4GkWYRZJeCmb
         wqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I2k6FBkPq2fQ+qY+MPawIgHovGyQd2pxR4RTiazNyF8=;
        b=D/wQteOYNyX3ZKrElEQa3ecMw+rlj6T6XrCl+MqyP9rzJKcu292qah9FGaYxNElqBQ
         No6QXebfpacPBNZLZ5d+O3+f2g9kfOw654GDe3cjWtphvKQB8lcH5owP9RzruNepNdPm
         QU+U90wZVy/hOkQe4Q3ZC14STcZ6+cHrW4rVSm+vF3BrLVkAgFG1usvipp5g7ut6zrsE
         hfQtNMEd3xwHZqtLoaB0GCbpT0GMjntoXVQvwG8xxc6jvrCKQmt0Dd8NipquuZOf0VZP
         /4D6X+8Thb2w7FzqZRxVlKjb/GNMVN/n3Bf0BNN76CcvW/TFSfVw18CKRdoEHN79HQWv
         S1qQ==
X-Gm-Message-State: ACrzQf25kCp433OPCye7wPsbT4ruW/Qim8QZhDrhjyINO5QbN7zF4qbl
	YM7TQwQZPMeLzv4qmAaFnqp39xSnrSO8
X-Google-Smtp-Source: AMsMyM7ln3m0NecF9yNpxgD75PxgQiwoGa5iE4K0cnpq0dyZyINyb2ggzi7tkMEzvoxMVtf79NTzDA==
X-Received: by 2002:a17:90b:390e:b0:202:affa:1c91 with SMTP id ob14-20020a17090b390e00b00202affa1c91mr20791969pjb.233.1663407668074;
        Sat, 17 Sep 2022 02:41:08 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b001714c36a6e7sm16310677plb.284.2022.09.17.02.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Sep 2022 02:41:06 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: rename damon_pageout_score() to damon_cold_score()
Date: Sat, 17 Sep 2022 17:39:18 +0800
Message-Id: <1663407558-21316-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

In the beginning there is only one damos_action 'DAMOS_PAGEOUT'
that need to get the coldness score of a region for a scheme,
which using damon_pageout_score() to do that. But now there are
also other damos_action actions need the coldness score, so
rename it to damon_cold_score() to make more sense.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/ops-common.c | 2 +-
 mm/damon/ops-common.h | 2 +-
 mm/damon/paddr.c      | 5 ++---
 mm/damon/vaddr.c      | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 9310df72e1c5..75409601f934 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -130,7 +130,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	return hotness;
 }
 
-int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
 	int hotness = damon_hot_score(c, r, s);
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 52329ff361cd..8d82d3722204 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -12,7 +12,7 @@ struct page *damon_get_page(unsigned long pfn);
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
 
-int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dfeebffe82f4..e495146e49e9 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -287,11 +287,10 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pageout_score(context, r, scheme);
+	case DAMOS_LRU_DEPRIO:
+		return damon_cold_score(context, r, scheme);
 	case DAMOS_LRU_PRIO:
 		return damon_hot_score(context, r, scheme);
-	case DAMOS_LRU_DEPRIO:
-		return damon_pageout_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index f53c2ff2bcc8..ea94e0b2c311 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -673,7 +673,7 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pageout_score(context, r, scheme);
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
-- 
2.27.0

