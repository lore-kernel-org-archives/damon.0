Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E53148C9
	for <damon@lists.linux.dev>; Thu,  4 Sep 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008554; cv=none; b=oVXYh+NQv2KeFs9cEYrHbIXCXW4p1VyMHotrf7iDZD8V7lLLe+rZHMtfpzpJvXsXdS+PUbsWRq7A3E3FTs4WWBGsVkE0Lg1ZEVn8sjx/tBtE9LmaRFwGnNtv0RqoT0V/SYeK9h53X4T+A5MQ1sMNMgoVa3qPk/TLsl6qq361iYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008554; c=relaxed/simple;
	bh=mW2jw4Gqq8kIhfnnpqfGdlZeipHpcksc78sKRIZawQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BxMmWlU8d6dcyTxNok4GuFKbtocp7+jXA+wvRIu8/Io6c/A3qt/ugiAqz8bMFO22UM9FBOIYEwJpRhJBDodb4m+DF2GiMduA8+UmQEpeEbkJGLlGQsoyOf1bupD+RJgCGFFNETr2RiHwZ1FX4DsvFMJ4jJm54N2fydK/njQDvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=Njh+1LPZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="Njh+1LPZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afec5651966so261196566b.2
        for <damon@lists.linux.dev>; Thu, 04 Sep 2025 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757008551; x=1757613351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMtbznq3tl66msCReaOp/sA5Z6pLqOTnltPjz7M8pLk=;
        b=Njh+1LPZ2/ZrK0PJUXXhuWW7S0d10QK6/ucXV/Fkrgg6hYWj6ROHwGa7XkJg8NYk1d
         C5bEnT876fJAzsnkZR8Gvuu3JQ12S97Hs9txFWOl5Wyy/TLLvyeDMh9dfOFLcQWq+9oY
         1YtjGlVIHbRFs4oJ61OUPFbw78msXQbOA5wTGA+t4OYDg5t/z2pSPbAjN1kFxM7NnWs0
         q6hd3/wUDCsUhX1EWNszDlyQ6g/jrXo2LK0XSRoUWjnnnWt9lgjYTODtzwr1PzruF2eN
         7wtCclX8+rtli0fiYil8LVngwTGRcpRltay0A+s77gfxutIOAhuIqUEg6YYcm3m9L8Og
         HXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008551; x=1757613351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMtbznq3tl66msCReaOp/sA5Z6pLqOTnltPjz7M8pLk=;
        b=mZDcJs+QBjfWjwKrjMrI6P/5lOjly87gpinO7HXJv7S9h3tewpkAanqI5xqVW5LsOy
         oW12Q8ccyxNbd+SAnivf9/ka9H/a/xcqGPyFtjOnIqM3QkIslMPsjQPFoaoRijwgUvqU
         PJsufNknQtViMKw7CbOEN/I9lzZejdSTxuZw8r9s/RxIriz2rh0PzOnW0DR73KvNHcdn
         4uA7bWlQqGDOUXVhpRky+Wz238AIG4wvLutSMRaS/KUH6x5GnmYyVQhKqWzQVAqP9on7
         4oKfVGkGuUSg2REjlu25j2pJb+HThICtlTy8o88v1Bbm6Abb8/hbzAkHxJeotF9QV69j
         PW6w==
X-Gm-Message-State: AOJu0Yw2fdEwz8cXoqctE5DPqP0AtVOrfBBBG2xmnlcvjJt9TOKllfDX
	DTlYf2fHY2uN3vRK3wkkXWzSEeJUA2lfyguiBWhLKRfJO9Wt+XP5UYEpNSO5lAaK86/ozrKxs07
	T066J2qQiEXAE
X-Gm-Gg: ASbGncvvclxFi8m1AZrCc6oxcS7nmoEfCV+RRwEFsDBeooGpwU/NZWZ+OWHdTOsC/07
	iCppIaqRGT3jlm+8teEczw2VwK5wyoXMiJNNwFJbAixSDKNBJnvKNPXJLlCRzSyARA+D9qoCdAs
	DpMXGdSasjAIQ/q2HPbnb6rhcECyKet2lHCFC+lH9SulCjIdyZ38OyYLQ2kRUDEYBu9DHdLmj4Z
	5+c+OBExzg+U19QrJo90wpk6aYpMm54GMeFaxaCHYhWGBV/H7SXDuqFpQMMYDR10WdMIUUEJ9i6
	n64/iPKyggCzxCwaFaMPVr4wKui3UoJMG6JjHb6G4cPiIvi6DKpPNIlb9Y/+sE2YA/OylQGWfi6
	0rHrXUdcOn9oW/wvN7VkcyMuEG1+5Uhwqqi8epJy++Rknvs6/GaOEq/u4VA==
X-Google-Smtp-Source: AGHT+IHHwye8S38M+daTlQY3u4C4GqM9qagbcu55Qj4nHECI21MQC05GMM41j4Ip7X73DFZQRvUF2A==
X-Received: by 2002:a17:906:d54a:b0:b04:2049:4c5 with SMTP id a640c23a62f3a-b0420490836mr1656559866b.6.1757008551138;
        Thu, 04 Sep 2025 10:55:51 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b043d6c2f6asm883392266b.62.2025.09.04.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:55:50 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] mm/damon/sysfs: fix use-after-free in state_show()
Date: Thu,  4 Sep 2025 20:55:49 +0300
Message-Id: <20250904175549.88928-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

state_show() currently reads kdamond->damon_ctx without holding
damon_sysfs_lock. This creates a use-after-free race condition:

CPU 0                           CPU 1
-----                           -----
state_show()                    damon_sysfs_turn_damon_on()
  ctx = kdamond->damon_ctx;
                                mutex_lock(&damon_sysfs_lock);
                                damon_destroy_ctx(kdamond->damon_ctx);
                                kdamond->damon_ctx = NULL;
                                mutex_unlock(&damon_sysfs_lock);
  damon_is_running(ctx);        /* ctx is freed */
    mutex_lock(&ctx->kdamond_lock);  /* UAF */

The race can occur with other functions that free or replace the context
while holding damon_sysfs_lock, such as damon_sysfs_kdamonds_rm_dirs()
and damon_sysfs_kdamond_release().

Fix this by acquiring damon_sysfs_lock before accessing the context,
mirroring the locking pattern used in pid_show().

This vulnerability was present when state_show() was first introduced to
access kdamond->damon_ctx.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/damon/sysfs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1234567..abcdef0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1258,17 +1258,24 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
+		running = damon_is_running(ctx);
 
-	if (!ctx)
-		running = false;
-	else
-		running = damon_is_running(ctx);
+	mutex_unlock(&damon_sysfs_lock);
 
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
 }
 
 static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
-- 
2.34.1
