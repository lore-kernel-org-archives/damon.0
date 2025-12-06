Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B03B8D47
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765061271; cv=none; b=R+LmT33K7QvI5Rbny+5W7B91hlC28rQCiy5qLne0Cy+ZadIQi9kN4jn/CBU3wosqrIDxVjhTGBKobbe8zc9ZVNx25219khLWHLNuACHaqcWQxZ0Snp4HpgPBLaMBsJhcnQLcbOZkI1fKnV+sX09N9Ue5Du5upK3pRx9fxeCqOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765061271; c=relaxed/simple;
	bh=6qNq9ylIDKGdLncBF+VuytbaDuaSGFXmozWGy4QSDmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhYNoitOyFwHwzqeglPGIYjOd88pViDH6zIutaxsWF9h0k9By7nFYpUnVbXa85+p5RHlPI4Znufx3PLxivYKdkgMhLKtf7oa0Klf/Pc/hA/HYEWgFe/wI2r1HlFjBczRMUWrt6TjNexAldIUOPdZCaWlAtZDceaZ7TNkpJvgcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCVtbBr3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCVtbBr3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1871290b3a.1
        for <damon@lists.linux.dev>; Sat, 06 Dec 2025 14:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765061269; x=1765666069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8HyIOypJQi8MinjibtE2pByaiOBmlIGh+lllMAA2tY=;
        b=iCVtbBr3zKvfk3V5z5UOQAMxyjmOQbriyOVETrvgxN2kaLLEFLux9k6Oos4BpfpRnf
         RdXAYlZ3gcwBwnkC8TraIInrHhDmlvadrz28/nl23asERhrsFUIxFd4wFqi5WTPWjQYJ
         RCguKaEWDSnpKg03BJJ3fElFSCac008pLeHLsR8r85WzZYpu+1aSS2+UScZr+bLxRLrd
         lj9z26dFHwrH23TYcreb5Khzuh1i/zdzUxn4eMYnqBIW2OvVY56NxMGgYHZMHQhYpu+A
         L12IeFWuUnS5nyC6tJNvlIcSgxfrzrIf23oRKEpk72a5koBNPJgQJwU2M/lFuJzS3tBb
         7ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765061269; x=1765666069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8HyIOypJQi8MinjibtE2pByaiOBmlIGh+lllMAA2tY=;
        b=nKklCWnHgqxME5revY7uOTVLTPjd58RwffJ4vcXAYZms8so6FMPcClEyVEg6fxnHG6
         I/WV81ThQE8SINHbdLQgym8+p+NXIJNLJv+eVft0dsrFfR0R1DLuNPWCMxrRphlFO3RY
         e8dfsGdO7/C+qjo5f6YqAGUosjzIHZvNPbrPnf/1o5G+/lShNE1BJbQQw+iCNoYTcOQ3
         bUgA4DmxVjVNC43wVqInbYJFt65eHOOiAc9qFYnAv2pAlFiWChlrsE3jWeOPtex6i2/L
         DJwSzWt1LVL6/GsMzM1mPk2eYOZ+/e2ax8o7Iffdmv/mcCXhSCGTsea4YFbEwDWp22dO
         ly+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD8a/MYbue12ua+ee6JAKkLfz40g7X1c3G++hZ1jeS9QpqMMmTzJQFWqSvugc5yeiriKsBAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZmYm44qvRiubWlqL36c+c+7YSrF1/pS1S3C/dZxTpyKpSQ8y6
	x2rTmOmDz+VwyyW1nnN8L/qTe/Iq3FOhnboSTpU14jOqoPrv2FG9jD6Q
X-Gm-Gg: ASbGncsZzoXtUbp0hBYnVVf9Yo6kJuUIYo3Q7upKST4sB6qZcffXo4O+lEzlZhwV6gl
	w23uNNRBa8ZQAK+jvL3AoznqxAn2ZLvZwC+P8EGqoCH6WrnfSjdUcm+PL9bAkCYG47LyFISxuy3
	P+gnIRVBFiilP1y0hfAmyWffUrPKeN9QiZrXxE/D4XmIiFPvwu8/R7MB7dRVgm0rNohUgtZD4iS
	ucQ4pslTsKN/EOEsuWqZXiSUvvJtdMwewt7S3VBjSR4SCg/w319L1NsXIy6TI/dTp6IBXroD7yG
	ujPmKDz2oTD4x3cVFWvrY2HGKSDeLDPvKpiRgCdIwoh3bvDsJ+ujTSh9EVjpkSfCTOyeNr8sKek
	6UUj8aooY1OXTeVEKJqyJoV6yOQiIt5Y9guiupXE0lWNm1iuqAnHVxr4wqQ1kMlIBklJYuCrn0C
	C5fudc/zVmgRVX
X-Google-Smtp-Source: AGHT+IG5H8nxjn7G4JCl9iN3Z23UEpNSUowdVhWCNwSa30pQ3LuY45xdznOSufJ/9sRdo9pF+fHD3g==
X-Received: by 2002:a05:6a00:94c7:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-7e8b7578ad6mr3537901b3a.9.1765061269365;
        Sat, 06 Dec 2025 14:47:49 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7e2aead366fsm8796486b3a.51.2025.12.06.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 14:47:48 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
Date: Sun,  7 Dec 2025 07:47:23 +0900
Message-ID: <20251206224724.13832-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_call_control structure is used by all damon modules.
In mm/damon/sysfs.c, it is dynamically allocated with kmalloc(), and in
the remaining modules, it is statically coded.  There are many daemon
modules and they are designed to be used only when needed.  It is more
efficient to use kmalloc dynamically whenever needed as in damon/sysfs.c.
Using damon_call_control dynamically and consistently has the advantage of
eliminating the dealloc_on_cancel member variable condition and reducing
code size.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 include/linux/damon.h |  2 --
 mm/damon/core.c       |  2 +-
 mm/damon/lru_sort.c   | 20 ++++++++++++--------
 mm/damon/reclaim.c    | 20 ++++++++++++--------
 mm/damon/stat.c       | 18 +++++++++++-------
 mm/damon/sysfs.c      |  1 -
 samples/damon/prcl.c  | 17 ++++++++++-------
 samples/damon/wsse.c  | 18 +++++++++++-------
 8 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cae8c613c5fc..7a4d7196cc75 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -636,7 +636,6 @@ struct damon_operations {
  * @data:		Data that will be passed to @fn.
  * @repeat:		Repeat invocations.
  * @return_code:	Return code from @fn invocation.
- * @dealloc_on_cancel:	De-allocate when canceled.
  *
  * Control damon_call(), which requests specific kdamond to invoke a given
  * function.  Refer to damon_call() for more details.
@@ -646,7 +645,6 @@ struct damon_call_control {
 	void *data;
 	bool repeat;
 	int return_code;
-	bool dealloc_on_cancel;
 /* private: internal use only */
 	/* informs if the kdamond finished handling of the request */
 	struct completion completion;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 109b050c795a..fb3f844d5da5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2519,7 +2519,7 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 		mutex_unlock(&ctx->call_controls_lock);
 		if (!control->repeat) {
 			complete(&control->completion);
-		} else if (control->canceled && control->dealloc_on_cancel) {
+		} else if (control->canceled) {
 			kfree(control);
 			continue;
 		} else {
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 42b9a656f9de..e3d6a46fa2fb 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -279,14 +279,10 @@ static int damon_lru_sort_damon_call_fn(void *arg)
 	return damon_lru_sort_handle_commit_inputs();
 }

-static struct damon_call_control call_control = {
-	.fn = damon_lru_sort_damon_call_fn,
-	.repeat = true,
-};
-
 static int damon_lru_sort_turn(bool on)
 {
 	int err;
+	struct damon_call_control *call_control;

 	if (!on) {
 		err = damon_stop(&ctx, 1);
@@ -302,8 +298,18 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
+
 	kdamond_pid = ctx->kdamond->pid;
-	return damon_call(ctx, &call_control);
+
+	call_control = kmalloc(sizeof(*call_control), GFP_KERNEL);
+	if (!call_control)
+		return -ENOMEM;
+
+	call_control->fn = damon_lru_sort_damon_call_fn;
+	call_control->repeat = true;
+	call_control->data = ctx;
+
+	return damon_call(ctx, call_control);
 }

 static int damon_lru_sort_addr_unit_store(const char *val,
@@ -378,8 +384,6 @@ static int __init damon_lru_sort_init(void)
 	if (err)
 		goto out;

-	call_control.data = ctx;
-
 	/* 'enabled' has set before this function, probably via command line */
 	if (enabled)
 		err = damon_lru_sort_turn(true);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 7ba3d0f9a19a..967d06d938d6 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -283,14 +283,10 @@ static int damon_reclaim_damon_call_fn(void *arg)
 	return damon_reclaim_handle_commit_inputs();
 }

-static struct damon_call_control call_control = {
-	.fn = damon_reclaim_damon_call_fn,
-	.repeat = true,
-};
-
 static int damon_reclaim_turn(bool on)
 {
 	int err;
+	struct damon_call_control *call_control;

 	if (!on) {
 		err = damon_stop(&ctx, 1);
@@ -306,8 +302,18 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
+
 	kdamond_pid = ctx->kdamond->pid;
-	return damon_call(ctx, &call_control);
+
+	call_control = kmalloc(sizeof(*call_control), GFP_KERNEL);
+	if (!call_control)
+		return -ENOMEM;
+
+	call_control->fn = damon_reclaim_damon_call_fn;
+	call_control->repeat = true;
+	call_control->data = ctx;
+
+	return damon_call(ctx, call_control);
 }

 static int damon_reclaim_addr_unit_store(const char *val,
@@ -382,8 +388,6 @@ static int __init damon_reclaim_init(void)
 	if (err)
 		goto out;

-	call_control.data = ctx;
-
 	/* 'enabled' has set before this function, probably via command line */
 	if (enabled)
 		err = damon_reclaim_turn(true);
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index bf8626859902..6a21de62c3f4 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -196,14 +196,10 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	return NULL;
 }

-static struct damon_call_control call_control = {
-	.fn = damon_stat_damon_call_fn,
-	.repeat = true,
-};
-
 static int damon_stat_start(void)
 {
 	int err;
+	struct damon_call_control *call_control;

 	damon_stat_context = damon_stat_build_ctx();
 	if (!damon_stat_context)
@@ -213,8 +209,16 @@ static int damon_stat_start(void)
 		return err;

 	damon_stat_last_refresh_jiffies = jiffies;
-	call_control.data = damon_stat_context;
-	return damon_call(damon_stat_context, &call_control);
+
+	call_control = kmalloc(sizeof(*call_control), GFP_KERNEL);
+	if (!call_control)
+		return -ENOMEM;
+
+	call_control->fn = damon_stat_damon_call_fn;
+	call_control->repeat = true;
+	call_control->data = damon_stat_context;
+
+	return damon_call(damon_stat_context, call_control);
 }

 static void damon_stat_stop(void)
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3c0d727788c8..3cd0af16a92f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1614,7 +1614,6 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
 	repeat_call_control->data = kdamond;
 	repeat_call_control->repeat = true;
-	repeat_call_control->dealloc_on_cancel = true;
 	damon_call(ctx, repeat_call_control);
 	return err;
 }
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index b7c50f2656ce..b71914549725 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -52,15 +52,11 @@ static int damon_sample_prcl_repeat_call_fn(void *data)
 	return 0;
 }

-static struct damon_call_control repeat_call_control = {
-	.fn = damon_sample_prcl_repeat_call_fn,
-	.repeat = true,
-};
-
 static int damon_sample_prcl_start(void)
 {
 	struct damon_target *target;
 	struct damos *scheme;
+	struct damon_call_control *call_control;
 	int err;

 	pr_info("start\n");
@@ -109,8 +105,15 @@ static int damon_sample_prcl_start(void)
 	if (err)
 		return err;

-	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+	call_control = kmalloc(sizeof(*call_control), GFP_KERNEL);
+	if (!call_control)
+		return -ENOMEM;
+
+	call_control->fn = damon_sample_prcl_repeat_call_fn;
+	call_control->repeat = true;
+	call_control->data = ctx;
+
+	return damon_call(ctx, call_control);
 }

 static void damon_sample_prcl_stop(void)
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 799ad4443943..e9cbc4be3706 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -53,14 +53,10 @@ static int damon_sample_wsse_repeat_call_fn(void *data)
 	return 0;
 }

-static struct damon_call_control repeat_call_control = {
-	.fn = damon_sample_wsse_repeat_call_fn,
-	.repeat = true,
-};
-
 static int damon_sample_wsse_start(void)
 {
 	struct damon_target *target;
+	struct damon_call_control *call_control;
 	int err;

 	pr_info("start\n");
@@ -89,8 +85,16 @@ static int damon_sample_wsse_start(void)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+
+	call_control = kmalloc(sizeof(*call_control), GFP_KERNEL);
+	if (!call_control)
+		return -ENOMEM;
+
+	call_control->fn = damon_sample_wsse_repeat_call_fn;
+	call_control->repeat = true;
+	call_control->data = ctx;
+
+	return damon_call(ctx, call_control);
 }

 static void damon_sample_wsse_stop(void)
--
2.43.0

