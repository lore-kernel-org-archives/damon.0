Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261B258F
	for <damon@lists.linux.dev>; Fri, 26 Aug 2022 08:32:00 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id 199so875624pfz.2
        for <damon@lists.linux.dev>; Fri, 26 Aug 2022 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=HGwS3OwkfwDxERtuzQGvNMSPhF82bFpGx5C7eTjqwZo=;
        b=EPsyWypD33QcVW4SCyLjAm9PAiP16Aj8PplboIwAG/F66l5bvFtyXub0S7WHdAx3EH
         N9PCD+XOwb/KBcvxL1uy4doXAtRsIDC7ueYEzzMtjBcXDUuHksCdFVskFESSOvWsgpWt
         vCs/zq0HAtll3C4ovMN8CXWmai49o6E6h+sZLygFGpeKpuWEVP2AMUjBiMMqeT4Yssoo
         68zWlRK3v3lAg9jc5xGgIZQ7YA3sE4ctnU34tTk7TS5PDC3IbOo1Hw/R1nj8PthFLidU
         RdLRci6dShTBBs+h3TWCGOr3Dwl2af/URPZbiP0bg7mewFQ557XGTouLcE27U/3NE7XH
         jyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=HGwS3OwkfwDxERtuzQGvNMSPhF82bFpGx5C7eTjqwZo=;
        b=sm9hnG09BJqaK6GaHzefahm9ICik5ytVAq35L1TfYd9P5r8mDf8zbcf1SmhqOIumx3
         gDUsdPL6YFkTf4VyTIjYVsqBsZhQkOdnTgtCRJyZQVzWjNLMx5p3khmuk/VyvolnLm73
         +uPa0zeN4I0hUSq/c2ah6pajitguY3nKeKHtGlc3AepSXuk+yI3ZV0m4KjMpNQAOqMvO
         WbWeoeoLTyeLhHIJlfCvZvE07BqfIOtuDtBzOV3tTRsjjJnaIu59b3CtDNErlk92FSDq
         Um2kOQwDDjgwFXKJoDVopnytlvca9E0omQxkZurU325b8YXf/M7t7y710GHtZnWc++x0
         jLAA==
X-Gm-Message-State: ACgBeo2sJkUSr4KweY5sjJlPtijF7/XrfpuDELdXZXPJwJjeCg7EqB4a
	Ob78H2bKr1OHs9TNr2e+Tg==
X-Google-Smtp-Source: AA6agR5e26Dd4o1ct1Xh53Ya1Lc3TsdTH+bpgF9eqipht0V/Vb1I+zPgvR7uzY7+6zK5KFDxUqDtfQ==
X-Received: by 2002:a63:1e1b:0:b0:42b:5561:529e with SMTP id e27-20020a631e1b000000b0042b5561529emr2435166pge.514.1661502720074;
        Fri, 26 Aug 2022 01:32:00 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016f1ef2cd44sm934953plm.154.2022.08.26.01.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:31:59 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date: Fri, 26 Aug 2022 16:31:18 +0800
Message-Id: <1661502678-19336-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
References: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The damon regions that belong to the same damon target have the same
'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
objects among the damon regions in one damon target when checking accesses.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c8c2f306bb6d..db9d0ab37a52 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -534,14 +534,13 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  */
 static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r)
 {
-	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
+	if (ALIGN_DOWN(last_addr, last_page_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
 		if (last_accessed)
 			r->nr_accesses++;
 		return;
@@ -551,7 +550,6 @@ static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r
 	if (last_accessed)
 		r->nr_accesses++;
 
-	last_mm = mm;
 	last_addr = r->sampling_addr;
 }
 
-- 
2.27.0

