Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16438259B
	for <damon@lists.linux.dev>; Fri, 26 Aug 2022 08:31:58 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id m2so1016300pls.4
        for <damon@lists.linux.dev>; Fri, 26 Aug 2022 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=ejcX4jVEjPdrkU9dU00T+efoVTYJPy0kG3uinoXmHSo=;
        b=qmSn+U7UOMfTh5bJbldCWYQMzI8jk/xzz6l13VdM0yIJu1bSu8OsRNo2qulPeCCNAE
         Y00MCO5PftrGLKUObBZ/e7EznloXzjELQF0h0VjTIlYi+yLgKcMbBbp2uSsGziQqoJ5U
         DW7IzctU9Lg3yglf2WxCdGP9mXZvjKHwhF7R7lk4xyKZ1T+giTLS6f8ZDlnyhG2fRQIA
         Y0trohdcerSE6/8mrUQ2cFRqMqTBokAtcP0r8rLA6pCqnfWR6R3oJ1ToIjsUYux7coTo
         oP8+1qk4szSRMwEHcYN8CPpOvOuoJlAnh62wTWL+Aa891nAF0k7zVoSKxY6VWVjRynnT
         NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ejcX4jVEjPdrkU9dU00T+efoVTYJPy0kG3uinoXmHSo=;
        b=V37NKkyRLLuAlFI8S4rJaREf2FmblNekFe6URBR9n/seDKbEi3uOD+KssZJEfHvWEw
         T4566HC+OXkDe4e2C8m4NQg1B6SpDSS93vnodMQ8aYJzLSqOWcU875AZEeh+/0TJbsY/
         YHTk0WD3pFvKizO7rECEtncDgW002f3vRJsVqGdqdtmNQIuA5yH+lS/7kU1CA1gkmJy6
         aT97zl6eDtYf4OoNlC2rVBtMBNTJXIXsrnoJKJKAXXn6UXqYBi8pp1a8DIyZYfm72H3b
         RlWcwNq51Jio7opc9zR5NDLc/QDu/XYcTh/TZUVoTwrpnIwQBFu0laP1U0QVKFj+xann
         NW9A==
X-Gm-Message-State: ACgBeo2AAPb8jipqH6WoMF53UYgdnmlnTjc9/zmMQSzAgRuy2gKFRdHY
	FMPhMgYlmF0FtYjht4XXbQ==
X-Google-Smtp-Source: AA6agR6IsHxv+NS3WcRPeGsCLiGaj9g0DHrOHdXBhcNVEf8r/Z+LHIF4VAngJkDr1WU/jvOjrx+44Q==
X-Received: by 2002:a17:902:cf43:b0:172:86f3:586a with SMTP id e3-20020a170902cf4300b0017286f3586amr2703089plg.71.1661502717626;
        Fri, 26 Aug 2022 01:31:57 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016f1ef2cd44sm934953plm.154.2022.08.26.01.31.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:31:56 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
Date: Fri, 26 Aug 2022 16:31:17 +0800
Message-Id: <1661502678-19336-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
References: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' is unnecessary in damon
'check_accesses' callback operation, so we can remove it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/paddr.c | 5 ++---
 mm/damon/vaddr.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

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
index 3c7b9d6dca95..c8c2f306bb6d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -532,8 +532,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void __damon_va_check_access(struct damon_ctx *ctx,
-			       struct mm_struct *mm, struct damon_region *r)
+static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
@@ -568,7 +567,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
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

