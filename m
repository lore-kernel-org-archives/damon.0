Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7629DB6E
	for <damon@lists.linux.dev>; Fri,  5 Sep 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067051; cv=none; b=PybgO7fAtqe+NYwYvoCFjTTvDheVkTVE0NhWhO5JK8bIbwicrJ1iXqco+wUSQqKFSrPJgJ5g1glecVlAYi7IsVjkSV0mN4CLsVY7TVXE6yVyF0cz+YJu7thJdyOF+eocL5HeQbVGUCsB+UqkfqsaXEPUv3OOVOjHCAcxQTEvdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067051; c=relaxed/simple;
	bh=jkTCp3P+yr42VXTfabfgzJWvbpYCF5TmBIOuVAlfHhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAYV110eWHeOB6iLSbvxpzUWP1u+vH+pNoiXO+Ejq8/o8YQDzfuorW/9sy9dmNqYObMbmeKfua9wftb2Lx7nTSqEv7nB/rJwUJFUyuHBbaEWfF50hNoQRIIBmft93vc4Ps7pm5MN5drs+nD4MX5EjZWnGIOS8sIPa0N75R5UPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=lfVG9wCE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="lfVG9wCE"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b046f6fb230so326498766b.1
        for <damon@lists.linux.dev>; Fri, 05 Sep 2025 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757067048; x=1757671848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAnIhBQbDm9gjZjqjenS6A8LuOGC08UU7yZ4phQFyfQ=;
        b=lfVG9wCEyBqlWh983WEYNxZDrfESY6jjBedMipxYZZwdzTCh2iHrn5DcsyOSAv9vm6
         LJVwrYr07hcWNh9pOHOtXLeVCjivy4n+IjyXsWQG9aFfHiroq6Ux8NOtD+HnyM8MZn8y
         mI46v3f+YeWP9O2QBGV/W21+Bo9RrLbXULVjYRzaLv11hJNYCMfKG2Z1aL7ibg4u7hpW
         Nc4XvGjNGOMiwCcfP3mNRoREQcU7mRlu5eHMY74mE8RdfnQQjYB0Dvog4kOuXJk9bElh
         XNaPyvw7hlWI625kp58qyB+KRMEOSA+9W35ZjWF8jRp8esReZCNNW5R32lEwDfKIYHID
         q71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757067048; x=1757671848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAnIhBQbDm9gjZjqjenS6A8LuOGC08UU7yZ4phQFyfQ=;
        b=w3CD+JQVvW6W+/sA9hkc2b8vxDdwLbqWI9jl++N/hlvMyRDYjtRCn8zrcldbFkso2m
         hqgXG7BqPOhAdA8KUIzTXYSTDeN1Qv+wjydTXfl6wMqFsDNlSaSaROYyPs9pUdOYrFrn
         omPbzqeMblHILOW1h5ZKrG0oHDmlkpoGymqwMXDatLywxVXfYjhS5WKa5rfpd76OOWj+
         8AAUgeGLzZOPtUC70IULH4ebmzxmKSx8BUkocFwahKbqkAtuuWbMyIhYU77bePOXMk5R
         KOHQaxYB197GnKE3XozeQ0KCFzwtFzbEEPM/aDd5DWwvLpxTxxcb6QblWtdj420yQGBi
         VwvA==
X-Forwarded-Encrypted: i=1; AJvYcCXyMwTOg2RwCUEBQEL/bvKmPGXtmTjdb0wjGP8rA9Zzya81mn3RURjQPwiXEpDdlSlE+LrOyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz00kLnele8DiqBYc2fVtLijgg09jun+qHL8jDQBBZUJG459qs5
	17ePorD2zlsNxLFzFh4akiaBVw+MgZXijVNbDDB2Aikz+ajXlBgwUEMD6IZ/gYJfg8w=
X-Gm-Gg: ASbGncvvFVHCTbdtgcMqC6lkSp8GiNwyPnuH2OBDVvleac9NX0Pv0kP0yKZ4HKSkW1f
	pkY/aPz9X9FbjnKrkhaX6ZDPsOQ1vy4YMghlB0mj3Z1O7Xzm5OEI0FpmwY9wXGhZ9kQNhKfxYOb
	GnfTlgCKzpSVo2QCYdU0nYtoG1L7Z+Dju+KQgL7iETvvNRvrE/V5X1C7Uyc04vBDP/WTjrhXi+g
	R+PWl0ERbatTRe6rpysyhluI+alouDPCaodvn+QbzigFEdnoP/AMqzKARx4xurEw2ICyQWntgD5
	ntPEnRgALYA7OT1jVTr2HPt/luHB3ABPHkT+ACAw51z1iV+9Vr/2rfkwg/1QA/SlniObOv1w9kc
	MH7AmBuvSr0yv7dXAvuRN1a7B1W5X7e5U5PfaGtyR++TK1d0XGgswWgHizQ==
X-Google-Smtp-Source: AGHT+IGp1pr9JZHYShV64sfeXi9j9BsKxp4VYxKhIH6aW6aeCKq4sV+NmvY4luz6jw3F75rB7Ogdww==
X-Received: by 2002:a17:906:e57:b0:aff:1586:14c2 with SMTP id a640c23a62f3a-b0493086abbmr283824166b.4.1757067048302;
        Fri, 05 Sep 2025 03:10:48 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b02152cc1b8sm1530574566b.36.2025.09.05.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:10:48 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: sj@kernel.org,
	damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH v2] mm/damon/sysfs: fix use-after-free in state_show()
Date: Fri,  5 Sep 2025 13:10:46 +0300
Message-Id: <20250905101046.2288-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

state_show() reads kdamond->damon_ctx without holding damon_sysfs_lock.
This allows a use-after-free race:

CPU 0                         CPU 1
-----                         -----
state_show()                  damon_sysfs_turn_damon_on()
ctx = kdamond->damon_ctx;     mutex_lock(&damon_sysfs_lock);
                              damon_destroy_ctx(kdamond->damon_ctx);
                              kdamond->damon_ctx = NULL;
                              mutex_unlock(&damon_sysfs_lock);
damon_is_running(ctx);        /* ctx is freed */
mutex_lock(&ctx->kdamond_lock); /* UAF */

(The race can also occur with damon_sysfs_kdamonds_rm_dirs() and
damon_sysfs_kdamond_release(), which free or replace the context under
damon_sysfs_lock.)

Fix by taking damon_sysfs_lock before dereferencing the context,
mirroring the locking used in pid_show().

The bug has existed since state_show() first accessed kdamond->damon_ctx.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Reported-by: Stanislav Fort <disclosure@aisle.com>
Closes: N/A # non-publicly reported
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/damon/sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d2b0dab50cb..7b9254cadd5f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1260,14 +1260,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
 
-	if (!ctx)
-		running = false;
-	else
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
 		running = damon_is_running(ctx);
 
+	mutex_unlock(&damon_sysfs_lock);
+
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
-- 
2.39.3 (Apple Git-146)

