Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADC28F0
	for <damon@lists.linux.dev>; Sat, 27 Aug 2022 09:03:16 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id p185so3692919pfb.13
        for <damon@lists.linux.dev>; Sat, 27 Aug 2022 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=d1f8nUkF5t5cqSm1uy6aZjuA2/Q1MZyp0rZYnQGPqp0=;
        b=ADjlqlLIinapEBKNHJvPolEuOZOLX5jS2yCniDir0S71XSJNsvfMC3q6GUuAFzuJqR
         8vplwGxKNX2EsG9DemkIS31tmJaa8urq6d9dQPAoSQfovgGR1RKD8BYEryyzG3AJG/dm
         nG1Hy5RBSbbVJIPOfm9dxB1H/nLD7X0PGfE6nOpZntMCl/OIiy7dvNBflhCnnZlgjQIV
         nuh2nT0+/QE5gOvY/YEECvTlajluTepx43UDivJKpw+BuV2uonfE7Mlc/mAfNIDC7vo4
         SIX0MT+I90XyCiC1VW+mvtuFzDkQDeFK68kD3JdlI5G8HPDdUtlklTfqy/k+gVgiUb7A
         Ut/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=d1f8nUkF5t5cqSm1uy6aZjuA2/Q1MZyp0rZYnQGPqp0=;
        b=IiTwEt5E9sbZ34RbT4ywY23x1itI0IdLMYK0DOxFoxTUx1vWYeWUj+yzeIldK6Veqq
         uuwsGbW66eWQfc/2ocVONQKqr5aXhG8CimRZ8nh4Plt+NqC+yEjrWO5afCLhlZr4ITv1
         MBZAs4S21uhQVQDtifXLMNexw3Bjf1LiGlHjthOABIB20jUyb6fI34026SMYzuK6NRtv
         7J38KYobg4dfsFSotufg/QIbmtV9kap22VxD5Ax5cWU9kSCa90MkBWy169N2xRvsqraO
         m23vfVyUm5i2IPNTCwtEyaj9EjU11w/mAB/7ifmo2q9jq6eIynOCJfeP8NwZCppe/rL5
         QpRA==
X-Gm-Message-State: ACgBeo1rSFLLzFUccr4oC+VZ0rsQO+OUXGJYrnT8lP3bHfTIaw3jskIX
	3HL/T6UaVxYOk/rsAJolhQ==
X-Google-Smtp-Source: AA6agR5q+qB4j7NKYCCupMsiap0S5orWPGACxAjLmCltEPdsahEoARsCXsq2ScHJmpUnXiH+R4HNCg==
X-Received: by 2002:a63:5d4e:0:b0:41d:dcc3:aa85 with SMTP id o14-20020a635d4e000000b0041ddcc3aa85mr6342951pgm.324.1661590995694;
        Sat, 27 Aug 2022 02:03:15 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b001fb09316a26sm2943332pjj.43.2022.08.27.02.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:03:14 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
Date: Sat, 27 Aug 2022 17:02:50 +0800
Message-Id: <1661590971-20893-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
References: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' isn't used in the functions
__damon_{p,v}a_check_access(), so we can remove it and simplify the
parameter passing.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/paddr.c | 5 ++---
 mm/damon/vaddr.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dc131c6a5403..6b0d9e6aa677 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -166,8 +166,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	return result.accessed;
 }
 
-static void __damon_pa_check_access(struct damon_ctx *ctx,
-				    struct damon_region *r)
+static void __damon_pa_check_access(struct damon_region *r)
 {
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
@@ -196,7 +195,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(ctx, r);
+			__damon_pa_check_access(r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..e481f81c3efb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -532,8 +532,8 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void __damon_va_check_access(struct damon_ctx *ctx,
-			       struct mm_struct *mm, struct damon_region *r)
+static void __damon_va_check_access(struct mm_struct *mm,
+				struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
@@ -568,7 +568,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(ctx, mm, r);
+			__damon_va_check_access(mm, r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 		mmput(mm);
-- 
2.27.0

