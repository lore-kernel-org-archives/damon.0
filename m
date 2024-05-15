Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD4155759
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786720; cv=none; b=IojgEhAlGwxjM/DTpDxCclTAFHsQpLVt+jmhfUvuNiKjLdMA6UadMYS8smy4zVYI1NhF1iR7Y+jS7JoC5Hm6Xcg0QqiE8XLHm/RTpMwlfzuDNXHk3oseGphdvcWuisNhyXOjAu08UmimrQ6KsY1xb9jBAtr0xAtzwget2neYUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786720; c=relaxed/simple;
	bh=+z/qE1Rb5ux5/66nSJ9KMmOhByIY1Rvw70Yvxp0cKSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8teO6WUQrRB3zZ4d6BZFWmXURD7SgMOYy5oPSTicqphrQZTB9t4y+D8Ig5rrT1nOZAQsumA4cUXau9qEEi3ZicYmfgmC4OvBjp+PxidEUx1+Nc3IDJsN1Jth6x7w9vU+SuYRpVNfFPgfno/qIs+sbd6yyz3cfWdamd+cUpMj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwcUMTSc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwcUMTSc"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so893029e87.0
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786717; x=1716391517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvljPjgjX6lR6mHciKscjK5EYNju7xwuH9ssF+hIclY=;
        b=GwcUMTSc/k/uqM0IQPX6oBGaPAbmuUlCgmkchQhj3UL0yLHTrHv5WVdqwsjcqZbgPv
         OP8GmBc5rZ5+xHUD8eRIgXR84Pia6eYKLIgA+hIye7VMGtbKbfW6c5DceFN+LctfS9w2
         6h4AtUpJZJqsYvx3CtsohVZpDH9NX5ZV8LCTQYCRljf+8ErtFYN40DC3X4P2r30GVlN+
         gzj3TGP8/4k54r7nRLjcSQgs0Jx6YO8rA5w6BedMe9ZCmZqzawKTsivF3Qvp3/5BX4op
         Fi2Hl9K3kU28sbq+pEuBkn89tC4g7WQaCVXUr9+KgZhxCa7jqOcUM+tPrTRr/dWkiK6A
         Jzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786717; x=1716391517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvljPjgjX6lR6mHciKscjK5EYNju7xwuH9ssF+hIclY=;
        b=s+gMHpwW1wm0MpVkqGVtOn1Yf56CpTYjN28TYJa5qqKD3FSWKWPaAwajvfmoUGjsTT
         Iy4DDg322qz0f4XabivZXMMRt4Vz5b2g9V5lTLkKogVZNn4ThIqf7JKRdQq2vwQe++ZB
         OTLyIU6fdf2Pb5spJYcKRY8wq9+vLslr3/TeSjIR1UBTmxvJgHtA//U/KDk/r8G9VDbl
         kyBkj7rUEo0FvjrqvE/LyW6/T5OJCazb5axMzuB7AxoFHfUEYFTmNZ8u8wy4mLHjgKAS
         0O8uDcMbsg5qY195ShP2/Auk2hN65qkpUJELooFuhBYSs1IoAWNtIG0x+hIMu6Vr+amm
         ByZw==
X-Gm-Message-State: AOJu0Yyxh8PqdTzuRE8G6CLmkM9iite9xHwX/8ZZFpNklze9cQ89cRrt
	91UnGS2LPwJ6QNV0cdaJ8UTzdfebUBsZ6MnBOtR0AufrghYygcZhQ83kYA==
X-Google-Smtp-Source: AGHT+IFkDYkWionD3q0O6nMHtjkRx2IPD38khrTh2sZ94PtfOzQbRvNvxHEWq+6uVEjcoRdr2mZCkA==
X-Received: by 2002:ac2:483b:0:b0:520:ed4e:2206 with SMTP id 2adb3069b0e04-521e0c63f33mr6239718e87.17.1715786716561;
        Wed, 15 May 2024 08:25:16 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:16 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 5/7] mm/damon/core: rename nr_running_ctxs -> nr_running_kdamonds
Date: Wed, 15 May 2024 18:24:55 +0300
Message-ID: <20240515152457.603724-6-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240515152457.603724-1-yorha.op@gmail.com>
References: <20240515152457.603724-1-yorha.op@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

nr_running_ctxs tracked number of currently running
kdamond daemons, but since kdamond could only have
one contexts per kdamond thread name was acceptable.

Starting from this patch series nr_running_ctxs no longer
tracks currently running number of contexts, but
rather number of kdamonds, so rename it this way to
keep sense on this variable.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 mm/damon/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 899487f38..822e54f29 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -24,7 +24,7 @@
 #endif
 
 static DEFINE_MUTEX(damon_lock);
-static int nr_running_ctxs;
+static int nr_running_kdamonds;
 static bool running_exclusive_ctxs;
 
 static DEFINE_MUTEX(damon_ops_lock);
@@ -707,13 +707,13 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
  */
 int damon_nr_running_ctxs(void)
 {
-	int nr_ctxs;
+	int nr_kdamonds;
 
 	mutex_lock(&damon_lock);
-	nr_ctxs = nr_running_ctxs;
+	nr_kdamonds = nr_running_kdamonds;
 	mutex_unlock(&damon_lock);
 
-	return nr_ctxs;
+	return nr_kdamonds;
 }
 
 /**
@@ -769,7 +769,7 @@ static int __damon_start(struct kdamond_struct *kdamond)
 		err = 0;
 		reinit_completion(&kdamond->kdamond_started);
 		kdamond->self = kthread_run(kdamond_fn, kdamond, "kdamond.%d",
-				nr_running_ctxs);
+				nr_running_kdamonds);
 		if (IS_ERR(kdamond->self)) {
 			err = PTR_ERR(kdamond->self);
 			kdamond->self = NULL;
@@ -808,7 +808,7 @@ int damon_start(struct kdamond_struct *kdamond, bool exclusive)
 		return -EINVAL;
 
 	mutex_lock(&damon_lock);
-	if ((exclusive && nr_running_ctxs) ||
+	if ((exclusive && nr_running_kdamonds) ||
 			(!exclusive && running_exclusive_ctxs)) {
 		mutex_unlock(&damon_lock);
 		return -EBUSY;
@@ -817,9 +817,9 @@ int damon_start(struct kdamond_struct *kdamond, bool exclusive)
 	err = __damon_start(kdamond);
 	if (err)
 		return err;
-	nr_running_ctxs++;
+	nr_running_kdamonds++;
 
-	if (exclusive && nr_running_ctxs)
+	if (exclusive && nr_running_kdamonds)
 		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
 
@@ -1755,8 +1755,8 @@ static int kdamond_fn(void *data)
 	mutex_unlock(&kdamond->lock);
 
 	mutex_lock(&damon_lock);
-	nr_running_ctxs--;
-	if (!nr_running_ctxs && running_exclusive_ctxs)
+	nr_running_kdamonds--;
+	if (!nr_running_kdamonds && running_exclusive_ctxs)
 		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
-- 
2.42.0

