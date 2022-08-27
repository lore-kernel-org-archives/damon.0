Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BD28F0
	for <damon@lists.linux.dev>; Sat, 27 Aug 2022 09:03:18 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id v23so3543766plo.9
        for <damon@lists.linux.dev>; Sat, 27 Aug 2022 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=BnthDXQwip9Q9g75mHYulJV0YY03kw/VBBFjsliYM+A=;
        b=oJYgfkP4CP3NNgASktL4x7ODjcR3+HD3vZEwb07NsH609p1YZorhMYaw3uBuhLsaSu
         LZl0QJbmhi0jUukkNquR9EvRQwgy1orz6Qlv9WmSDCJ2x/HAt8SuOhGRRAclg8A068o0
         H6cfWJZSar0AKRZ3vshQt11x9r00U0mbpgkpZSeMSS1XYqBpesH0f5xFjODDp+uhyaJ0
         wXCO8cvU6XjxJ3rp9P2CjOjUN1KMdy5Uu2ZDItMGzCzspltNns3YcHzTAc1sFYUDEM2c
         7UXykdPmR0Y8hi+57sQCVryu7P2/zquX1LjrNBhpnUvGRqEkT+xapyZkXJm6wZ35As4O
         X0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=BnthDXQwip9Q9g75mHYulJV0YY03kw/VBBFjsliYM+A=;
        b=pd3Qu56QNBE8vhwhg8DucwAIkZ0LvalWfOWJh1FVATxX1iPgYSzB7s9vVtnjDLXBq9
         JNAmrE/zWnLgGCC/RBikPckzBajOAxwA9ymBttoVdzQBCcXBqTboooGWoevTV8pqVXSW
         ntBTOBWdyWQeh94ufC8rrEbXAuqz2bX0iJgCam/nLfnpYRgf9kS6MsFDWfLzuvvq6ydR
         NtYKPLfZwDPd/y2F+cUJ+2KRow+BC2VWMrBnHmDBkCM/2Xbwz/rQQI9/15crFbq8abRt
         GPCiAj23oV0dCyrYT3OzZVm8ApZmKRq/6ZSJJtBoxgeKiwLLWLu86G3VBlXX3Uyfo77u
         A89g==
X-Gm-Message-State: ACgBeo3CvWXSRMZaYUV/7G1C7urz2bTaFa/k2JtyPPy101MZs8/yJUb7
	Efi8m6hHXRyEsFrwvAfIn5JWRwtbg/2L
X-Google-Smtp-Source: AA6agR5cNMunEZrg1m2YWRxKj5/mEUiiHmC6GSFb8/9x4IAe9RfU9EnhJkNT4Z4v232c7q5+3WCBeQ==
X-Received: by 2002:a17:90b:1644:b0:1fb:ab0c:c5bf with SMTP id il4-20020a17090b164400b001fbab0cc5bfmr8493090pjb.27.1661590998059;
        Sat, 27 Aug 2022 02:03:18 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b001fb09316a26sm2943332pjj.43.2022.08.27.02.03.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:03:17 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date: Sat, 27 Aug 2022 17:02:51 +0800
Message-Id: <1661590971-20893-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
References: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The damon regions that belong to the same damon target have the same
'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
objects among the damon regions in one damon target when checking accesses.
But the check is necessary when the target changed in
'__damon_va_check_accesses()', so we can simplify the whole operation by
using the bool 'same_target' to indicate whether the target changed.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e481f81c3efb..5f66c826ee3a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -533,15 +533,14 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r)
+				struct damon_region *r, bool same_target)
 {
-	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	/* If the region is in the last checked page, reuse the result */
-	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
+	if (same_target && (ALIGN_DOWN(last_addr, last_page_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
 		if (last_accessed)
 			r->nr_accesses++;
@@ -552,7 +551,6 @@ static void __damon_va_check_access(struct mm_struct *mm,
 	if (last_accessed)
 		r->nr_accesses++;
 
-	last_mm = mm;
 	last_addr = r->sampling_addr;
 }
 
@@ -562,14 +560,17 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	struct mm_struct *mm;
 	struct damon_region *r;
 	unsigned int max_nr_accesses = 0;
+	bool same_target;
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
 		if (!mm)
 			continue;
+		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r);
+			__damon_va_check_access(mm, r, same_target);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+			same_target = true;
 		}
 		mmput(mm);
 	}
-- 
2.27.0

