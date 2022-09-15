Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C54403
	for <damon@lists.linux.dev>; Thu, 15 Sep 2022 11:34:50 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id d82so17747652pfd.10
        for <damon@lists.linux.dev>; Thu, 15 Sep 2022 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fTThPrnJpaHeuIoGEw8obeia0/MYZikqiW0fDRszi+8=;
        b=qy/fAFU92j26cseHPnplutz2c07wowoPocmrrC6ua4wwTccbPm4YOvszB8cusuMXcT
         0947vuapD63NyTJiqif+DJaVOwDLkcYM4r+nOaX9ZUYQyI6bY2UHAGzRLgEJfaVjnyJa
         dfWkhOkWx30zqPCVTr4IvjD6+WaTfHMlhYMf9IiXZBQqOh8UYjGNIpb/DwTaW7tqnnGU
         q0uPQp70s/rBK8sha4/2dj9SpL90Vke+BLoPOkWe/NXWj5NHRg8Y0smKhVZeKqwGSFAa
         FC6NYxt2Uf4gaCWoV036qB1glJYiW6okZiBVXxwa2eZMBKcKQDQ5MezIdl/MbgNZkXze
         jNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fTThPrnJpaHeuIoGEw8obeia0/MYZikqiW0fDRszi+8=;
        b=S/q/KBy7tW7trgIVNYh3fi23nutRxS9r7fjmWa2ppxQJ7TEO907ISqdQJ6A9otHBx9
         3+qhjavRr5vW1HZjiiYMpbJFWKWT3rg17mkl0yQ+BUSfqmGxDdG67EoyCsqlDb361DIr
         a4orUIbYonERqCKtxFC9toySVoKIg3JIbMxO3hTLATJVh2qvYv7znJrNHfakE1LYSIcs
         xSIxjTrTJzG16+Kf+YlmZ8db4dIU9uzV+nmrzY3rakalSyODJp9+0V6tc9T9lsi/SevB
         GJPRDEM/KUTpJesGo2qbusAgJmXz2vs/e6g7I+yguH6AGFmlw/FWG7WJtRasmJnQY1Ep
         +Q7A==
X-Gm-Message-State: ACgBeo22ZW99jRl9Lu6UofMvacF8IsPmPv1b8HzjA7xEIeH8wPPQVHlw
	tgKs81QLRp6uLJIIe1xyCA==
X-Google-Smtp-Source: AA6agR640OXsmX5cRg0YHwKSwjJU7hyGd438DG3WT93f0yjbNao+JFUJGApYi+n+XIlDbsPP2SYaUg==
X-Received: by 2002:a65:6951:0:b0:42b:b13:b253 with SMTP id w17-20020a656951000000b0042b0b13b253mr36828372pgq.555.1663241690274;
        Thu, 15 Sep 2022 04:34:50 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id g6-20020aa79f06000000b00537eb00850asm12114310pfr.130.2022.09.15.04.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 04:34:49 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: use 'struct damon_target *' instead of 'void *' in target_valid()
Date: Thu, 15 Sep 2022 19:33:41 +0800
Message-Id: <1663241621-13293-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

We could use 'struct damon_target *' directly instead of 'void *' in
target_valid() operation to make code simple.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h | 2 +-
 mm/damon/vaddr.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c5dc0c77c772..1dda8d0068e5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -346,7 +346,7 @@ struct damon_operations {
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme);
-	bool (*target_valid)(void *target);
+	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
 };
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3f84584f9982..f53c2ff2bcc8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -593,9 +593,8 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
  * Functions for the target validity check and cleanup
  */
 
-static bool damon_va_target_valid(void *target)
+static bool damon_va_target_valid(struct damon_target *t)
 {
-	struct damon_target *t = target;
 	struct task_struct *task;
 
 	task = damon_get_task_struct(t);
-- 
2.27.0

