Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BE7F
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 09:12:30 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id fs14so10629141pjb.5
        for <damon@lists.linux.dev>; Tue, 13 Sep 2022 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=EMAhRQenL2hUdqt4UEMSUYn6VhBs6usk5YM+b/UiubY=;
        b=QR4h9rBbXfMXwSfowuM29Txd3PECeQyRU2zLkwirxu6Xu2abQFq5FtiBLdiUVEddii
         +8A5gWBwuLdtY9/rQSRIdnxCGqq1RncDjqrwQFgQaM4jQp5e+M+amJh53VGIK2l2wmbG
         WOD3z7A+y5uJMimOycIJqQ+zbL03kHZSc8BkgNyjh/PPa0RcIneNj0IMPEfoY0/cHbBL
         nz0vVzqbxGqoO41lcKrh7cZYZWJRPU535kszr+rvh+Q15W4gTBRCS9bgyi+zeHnNlyfH
         4dG1O1MXN/VO2WYWptHTfHKe+EpupAHhZJl/0MnGquj1wi+eJ8nds4FKPXGNcUtR0EtO
         s45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EMAhRQenL2hUdqt4UEMSUYn6VhBs6usk5YM+b/UiubY=;
        b=LI+XvEfB3HfzWoePkLDgs/IbPH/ixEcvSJhOFVUOS1dBptLl5vTUXgbO4D0dtVNBDV
         2duINQ+cFzMUEmrRL2osHaoX3nt9m1Fmr1XyEmghTNplrDslIwlR7gQesH5hB4GGUdeN
         FIf+4pb9unjZHtps8K0GyXeBfnaMXWSE96JEqv47YPnditLvDNSF5J/cqyj79ZzfF2fJ
         umJm79DPFXsyvgOUApIWdARgmXfbcRoE3sZO6XBPbron5MLbituRzxucQhW2lWKG5DSX
         9P1uHKI1uDZjlYon5Q6FQXzbSc5IG7+9YNuG4lCm//99VaiPx4kuTWxpebDKyn1/I1R9
         nNMg==
X-Gm-Message-State: ACgBeo1r6+o691i891Lwe3ZM2OzQRpqRIen9SkRrVgq+1/yHQQPan1hy
	MDKyy7di+MdgxXZfsEm+VH8EBWMf2Q==
X-Google-Smtp-Source: AA6agR5DxXSkOSzxyXwhhv9jgg+SwSheGvcNYeAQI3G+qRh9y7ZtRQmO490kndDSfsv/LAIvKJD3Fw==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr2974074pjb.167.1663060349560;
        Tue, 13 Sep 2022 02:12:29 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:28 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 1/4] mm/damon: simplify the parameter passing for 'prepare_access_checks'
Date: Tue, 13 Sep 2022 17:11:24 +0800
Message-Id: <1663060287-30201-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' isn't used in the functions
__damon_{p,v}a_prepare_access_check(), so we can remove it and
simplify the parameter passing.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/paddr.c | 5 ++---
 mm/damon/vaddr.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6b0d9e6aa677..f00cbe74a00e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -63,8 +63,7 @@ static void damon_pa_mkold(unsigned long paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
-					    struct damon_region *r)
+static void __damon_pa_prepare_access_check(struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
@@ -78,7 +77,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(ctx, r);
+			__damon_pa_prepare_access_check(r);
 	}
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c2c08c1b316b..39ea48d9cc15 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -397,8 +397,8 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
  * Functions for the access checking of the regions
  */
 
-static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
-			struct mm_struct *mm, struct damon_region *r)
+static void __damon_va_prepare_access_check(struct mm_struct *mm,
+					struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
@@ -416,7 +416,7 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			__damon_va_prepare_access_check(ctx, mm, r);
+			__damon_va_prepare_access_check(mm, r);
 		mmput(mm);
 	}
 }
-- 
2.27.0

