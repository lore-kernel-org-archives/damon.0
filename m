Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70F2F21
	for <damon@lists.linux.dev>; Sat, 17 Sep 2022 13:58:03 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so2479005pja.5
        for <damon@lists.linux.dev>; Sat, 17 Sep 2022 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=acjlS1iDHXhmVGFkLODmzml9Wjz6bw4G2sgkuSolMsE=;
        b=De9EFBz2Cs4MyGwgN7o2yiTJyv7QVqJIeJuFcgWsHlu0lMT0gLJ1BUlR3Xc83qerc6
         2yTzARoaS/tNasaEpDNMSkjI0P8NY2VY+rF5L7CO5bqsRAugMf4wSvbElB4V6ZkB2NEa
         PNgFoZg8uoxloHUXzMdTHz6SskFpUnHhnoExysLMhNpp/OWoAz7IvXnV6krn5nbIYqGH
         t2aknnB9iF2gavHBd/E+v/rw61ZnsWAr99QAaOjbsO5vlZLQOOM8ITZUieWUwKNsKZHn
         ehz5seyhYaoLgYjqN387PE6VnG7d/0ra2J/WAtcNKIw4nUfl3ubR2Fly1II3oaVoR8QC
         xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=acjlS1iDHXhmVGFkLODmzml9Wjz6bw4G2sgkuSolMsE=;
        b=XXUjdS4FQgirbu9UgoGmUDheMvVuEREBuT5ZVrsflDSzbEFZSLgcN7WXiQ1LefnBo5
         bdHC4CL5jQT1Hr+NkjAG8m4bILrSouUotqheIF5/i7zsYgobCPEVA29JZOfAfo1QRcD6
         qsnQgHUFgRyVafOqZJptZFWhVzBLwhEFaPIri0vee9Elubwlt6F3POdu0ZAWHPWEx/jW
         TnGgNAX16tSFt21JV7M32HI+YA7x91gQrcbvVRZgobusYSpP3KjxA/bFFkgf/5Dc0wb3
         hHXqjV5s4jMoeFp+FFzadO3fgn7ozb5FZSSWkmYPtv70iJiYnB5kgaOJ64nDeP/e66Fa
         psBQ==
X-Gm-Message-State: ACrzQf0149h3GxrnOXDoo7x/6h4k18S/fnH8YSCy++iqAtcEHgmFbFDX
	WLSyPTZSGmLWhP+z2FmIheV2BFJGDurF
X-Google-Smtp-Source: AMsMyM6dzD5mG5WjhrfYQ6G/JjxcIHkZbdztnI+4WHm0wAFcbeRU0c08FGTUABEE8s7ABC+TcywBXw==
X-Received: by 2002:a17:902:f684:b0:178:2fe:9f4b with SMTP id l4-20020a170902f68400b0017802fe9f4bmr4514695plg.60.1663423082992;
        Sat, 17 Sep 2022 06:58:02 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001709b9d292esm17202667plg.268.2022.09.17.06.58.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Sep 2022 06:58:02 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] mm/damon: rename damon_pageout_score() to damon_cold_score()
Date: Sat, 17 Sep 2022 21:56:54 +0800
Message-Id: <1663423014-28907-1-git-send-email-kaixuxia@tencent.com>
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
Reviewed-by: SeongJae Park <sj@kernel.org>
---
v2:
 -keep the order of switch cases in damon_pa_scheme_score().

 mm/damon/ops-common.c | 2 +-
 mm/damon/ops-common.h | 2 +-
 mm/damon/paddr.c      | 4 ++--
 mm/damon/vaddr.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

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
index dfeebffe82f4..e1a4315c4be6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -287,11 +287,11 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pageout_score(context, r, scheme);
+		return damon_cold_score(context, r, scheme);
 	case DAMOS_LRU_PRIO:
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
-		return damon_pageout_score(context, r, scheme);
+		return damon_cold_score(context, r, scheme);
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

