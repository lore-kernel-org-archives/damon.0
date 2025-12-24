Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB9326D63
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580262; cv=none; b=gCcV4VD3oQNrGGWE4AHF5lyEDJxMCG9YMuZdT13FvrIVw7fGukiiNNK1IfgLPItuGHN519pTtT08VBkoaVp/lG1xY0x2JsMKhXwbLxFaz+VkBdjFrYuo3GgwAtCBsLU29EFpfrIBA2KO1fhdRLwBXXr66TP7/ueg7sR9yefdRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580262; c=relaxed/simple;
	bh=bFLgGwjSjYn9nTB8sXEX57wdcy4V+7gCo2uhDro/w4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVWdXpv6dyBf5i4jCzlJjkZI1brUZITfn4n2ra35HerRNhq9D2i+aQxRRQBW77y5eNd323WL6FRRBV70O6ZktUfP/A6jem1c/TwSTebhZqOJAG1PouJJg0o+bRnAAeQXbsdy2oyG1EYZqLP90LxGsmLrP/66D8rsM7KOh/Q47dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRu7OVFr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRu7OVFr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a102494058so34401965ad.0
        for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766580260; x=1767185060; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKYQvQ6NReD5wn+v/jU8gptz8GYN9a8ubrCMIsRMan0=;
        b=gRu7OVFrqbe+t9fjTKXSuabHDUk3WAB3ZcKomeS44BvoXO+w26qaBvNqf7Eatdgm7z
         SRRJ5edZlI8mF3mt47w+kQ80p44I9EybqlO4g6gJrdTIzFWVdOFJKAn9E8suYh9E9wRa
         2miA+MHsGDaKYrKOU/rYH5m858oB+Yijk/BzBRDQBjffwxWqaetsQdCrBwee05tYyZMG
         HJFmY8rf/mmMLHJU36McumC6/NojRGLvAen7a7GJ2DHPT78cotCRa51+aaptA2XipEdo
         JSV+ppTB5vFPKYTW0eiiNSfELo1nQMCXwBZDGiIgnEplfiZPV7nTmvcmNZFb1NEr5w1z
         fPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580260; x=1767185060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKYQvQ6NReD5wn+v/jU8gptz8GYN9a8ubrCMIsRMan0=;
        b=W78tlL8hHZ2uqXCCoIQAfH9/Wh/QIcP9J4NUdHaab98Jb6brDh6LQKdV+sur3yPpyu
         boG3XwjJ/gOTHkw4stq4kiWs20yHE4lkbj2Of3F6MIyZf05QtBeaonzCv0JmSbti0YEm
         eTVSYgWoZVGgk+zAKjAnmDW5F8SP1AmQu9bAfs/72CYAKW6+aTk/1VGmsdoHsLfPr4lK
         M3K+jtDouWJ37MwKR5qoFiia/jwgn2/AgbAgCuP4aEFPxIdjH24vNzLHFX+zNDuItpu+
         Zw0ms5OdlfD5LW8/CtIqXE9yUFqZ/xcCt2ZVa7PQD+ApeHj3ZeSI63sqjSXirM4BxmUx
         LUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2hXgSSsb9RNr/KT26ro1Bmh3tv1VJcC0Hk1eUoYG0uaRBCp1IX5Nt+Bo7Y9tmZFnrPtmn8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAWQg9eWwEMrSvAlzAZ61kB1vhNpBgh9pjXBG9uG8fPLer9JUU
	1b8ys+FurjtL4V/L5ogFkXhMM49qv10OWyhVzHtoLqCbwArzIdVxXoD7
X-Gm-Gg: AY/fxX7Daf6+MVY5WMdN+jTwXk575Exw6EsgFdZ7PVXT6uzit38HhfH7R2smuhkdobl
	cuS0c8u33Kt97aywNDq13xSmgCDu2wdLNCv+543+mrz4pFHSQABZad9BopaRHUOFXeCBuLUvf+F
	piBiky7Jp1Ck765p9pX5jiNf1/RPJLvKKb2hlm9sU3TDQNpHupKWGQXWBEeltWTiUvR77NOP/Iy
	l23FVLhEn59Vox+ssDTiKyP6eJAY5He9fa/+cSkUbYZxwHmlkbcBw4XdJpY3n9I6nuO3mgs6OeG
	3tSRLOWx+3UQEOftFfgOOes0h1Xs++BRsAAYXTAn4C1UEvecauDFGm2eR3AjQOZJLyc7wIdmUz3
	IEmXbJQPOzYOk9sD8pC8Qnb6p4bGageO2Cq3LvrkPd4pnfqv+64TEP9GopFbSYiegRb2NZmeRlj
	jYHT0ISLrxYqnS
X-Google-Smtp-Source: AGHT+IGaFz5m5x5yWwSs6Wyputwoz09+EBgCA1HOBett09MOFwgLX12SwSxMG9G9A+65lYQFeOLZsA==
X-Received: by 2002:a17:903:32c5:b0:2a0:97ea:b1bd with SMTP id d9443c01a7336-2a2ca8f6621mr237053685ad.0.1766580260481;
        Wed, 24 Dec 2025 04:44:20 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a2f3d5f5dasm154014665ad.82.2025.12.24.04.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:20 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Wed, 24 Dec 2025 21:43:54 +0900
Message-ID: <20251224124355.31667-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kdamond_call() function is executed repeatedly in the kdamond_fn()
kernel thread.  The kdamond_call() function is implemented as a while loop.
Therefore, it is important to improve the list processing logic here to
ensure faster execution of control->fn().  For ease of explanation,
the data structure names will be abbreviated as follows:

damon_call_control.list: C.list
ctx->call_controls: CTX.head
repeat_controls: R.head

the execution flow of the while loop of the kdamond_call() function,

Before modification:
Old while loop:

        CTX.head <-----> C.list <-----> C.list <----> C.list
        ^                   |                           |
        |               if (C.repeat)            if (!C.repeat)
   restore: only one        |                           |
   list_add_tail()        list_del()                  list_del()
        |                   |                           |
        +                   |                       complete()
        R.head <------ list_add()

To process C.repeat above, we use an additional list, repeat_controls.
The process of adding C.list to repeat_controls and then restoring it back
to CTX.head is complex and inefficient.  Furthermore, there's the problem
of restoring only a single C.list to CTX.head.

Below, repeat_controls is removed and the existing CTX.head is modified to
loop once(1st rotation).  This simplifies list processing and creates a
more efficient structure.

Modified while loop:
Not used repeat_controls:

        CTX.head <-----> C.list <-----> C.list <----> C.list <-------+
                            |                           |            |
                        if (C.repeat)            if (!C.repeat)      |
                            |                           |            |
                          list_del()                  list_del()     |
                            |                           |            |
                            |                       complete()       |
                            |                                        |
                          first --------> list_add_tail() -----------+

        if (C.list == first) break;

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 mm/damon/core.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 824aa8f22db3..babad37719b6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
  */
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
-	struct damon_call_control *control;
-	LIST_HEAD(repeat_controls);
-	int ret = 0;
+	struct damon_call_control *control, *first = NULL;
+	unsigned int idx = 0;

 	while (true) {
 		mutex_lock(&ctx->call_controls_lock);
 		control = list_first_entry_or_null(&ctx->call_controls,
 				struct damon_call_control, list);
 		mutex_unlock(&ctx->call_controls_lock);
-		if (!control)
+
+		/* check control empty or 1st rotation */
+		if (!control || control == first)
 			break;
-		if (cancel) {
+
+		if (++idx == 1)
+			first = control;
+
+		if (cancel)
 			control->canceled = true;
-		} else {
-			ret = control->fn(control->data);
-			control->return_code = ret;
-		}
+		else
+			control->return_code = control->fn(control->data);
+
 		mutex_lock(&ctx->call_controls_lock);
 		list_del(&control->list);
 		mutex_unlock(&ctx->call_controls_lock);
+
 		if (!control->repeat) {
+			/* run control->fn() one time */
 			complete(&control->completion);
 		} else if (control->canceled && control->dealloc_on_cancel) {
 			kfree(control);
-			continue;
 		} else {
-			list_add(&control->list, &repeat_controls);
+			/* to repeat next time */
+			mutex_lock(&ctx->call_controls_lock);
+			list_add_tail(&control->list, &ctx->call_controls);
+			mutex_unlock(&ctx->call_controls_lock);
 		}
 	}
-	control = list_first_entry_or_null(&repeat_controls,
-			struct damon_call_control, list);
-	if (!control || cancel)
-		return;
-	mutex_lock(&ctx->call_controls_lock);
-	list_add_tail(&control->list, &ctx->call_controls);
-	mutex_unlock(&ctx->call_controls_lock);
 }

 /* Returns negative error code if it's not activated but should return */
--
2.43.0

