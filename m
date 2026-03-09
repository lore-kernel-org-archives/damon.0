Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4B221F39
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018035; cv=none; b=XwTu8NxoqELLMUlskO7qlbfSJMypb9h2X6ijdKqM/VZ/ZwSA9QnXEyxv93uZTp/CT9Ne3rE4Wu2BYWE806kFW/J+giHcG/upg/ZEPAaFmirOQbx22xzB0r7JG0ecoG6hUEirMayunIk037yb2CIv9Tfkun9HF4k26K2VPhhJnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018035; c=relaxed/simple;
	bh=CBq1WzY+CfbSlt/zpeDKPph0ZRMfd7TiyTs16daTZEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di/Dv+eIYUdHkvZ5XK7Myj43Q0thrXSzE8luR0/k+KGj+Oab9mFTgPoejun1Y8Jujra+o931oY2zdbFTEVkzVrlVJgBrnNv6svU6pM7ZTtZ+t610WszDiX7zOx2tS9lBiRy8P8z5t/d6PXCQTrTr+gNGH6k/iMifu2r91aokphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA5uAtbJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA5uAtbJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82990763921so3358039b3a.1
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018033; x=1773622833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn/2guCKRAgRRAybhopaktEdBkVkt8okldP3ZxdUvNk=;
        b=JA5uAtbJoQXeSeE+RIMmnmfOuQr/5WyOrgt24oEaqU+yO/P8ACM5FRfhgYUK0OZlVd
         oaoiWypZnrm+M1+fOHNPwtn7MfFxBHVXSpAEL2THwVcNucdNNjMpifBOSebH26YwslwP
         w5RuiynzzW1HifgzECLSCODtwXO07VsEdRc3/8cat5tdP1QJsnOn2n1bDOxpPsZY4tKj
         xsi/7TjeINN1OPK3X29hXSBIXDj6KEPs1eMKaDLRvyapfQxq0ScpL6SqnkVk2eNnZZu+
         rcIQt8VZ88TJqJwcg4EMMnpjxLbaTd/UHX9rx7XY5oMdBw8+4QwxsllpDjCdvV4PPOvH
         Vo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018033; x=1773622833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pn/2guCKRAgRRAybhopaktEdBkVkt8okldP3ZxdUvNk=;
        b=PHT1oHqchpk7g0uBWDBwwJBh6NijmwSGdCws1aa9NQEXTOUTfQ+OhRd+8AxnF4dtMU
         v8TCllcMpfYctROA5JW7rT9jgPWU/Ml6ZBemB72RO3/MXupOeej662ZSaGcNKOoctChP
         kQPDsLxQcEb21JDslNKDiZsJ4MXPqaMaKW3Jbt4w9Kijv7UBU0GXS4inru5w9yLJvvMy
         pSNY0M1ltHuKb9UXVYS8HXhyo/lnXDx0xGVbnhuqDcXBq/weDM6lRRuBJzGGwGXjoQJM
         zqZftksJ4U5d3Ys7Ju1lLfnLXne2t57BiN4tXo/KdC8WrPYwBLs9Zwh9MP/pg8WXOfS0
         109w==
X-Gm-Message-State: AOJu0YywGEtKDzmNJrjsr5ztL1b/rjYOtZ8fRLbooMi6lCeq3MsYP5QR
	+2c1Xj/qWblKWngzKo3eokN1b+5D24p16KYgJvAavE+G/oZLlKvlQbYX7kb0eg==
X-Gm-Gg: ATEYQzyfrMZNl3NYPpoJbAaxc3kUF83hG5Y1xJ19VbcAuiSn/3M5f118d6Oxb8A80RM
	pbTZcnrgCisP1lCbN5tLhrDGrMQG/PGke09VFRagXjcIOuISIWL96Nymmbv+JZWBLQ8/9gTVZal
	b4tEIVgXASFniuTUCbx34LXNt/misE7uLxBIIZNlFm9nPjRQ4SyQBxUPL3C+pNb7UkY5C2JMwkz
	iM+FpDNzjBqX5TzgHBC7yUQOkAbSklmmaSTQ+QWVUwoy1Uh8WhVmSnIKHNCKfp6LmY+OxDT//yT
	/LoLIq00JHMsFHAlHb6ZIhYXKgPp/Mf4GWb92/PiQo9ShZFzStWC1kMp/qPXH8wQYlDrdb7PLYO
	I2oN2bnCrMW99Wit28QBBaVJA401X3DdgsG6znV6iq9cwd6FXXlhH4KDK/FZBPey+/57Tx98DaO
	IqTMgegb7b3z8m8cQM4i4fpWgxd8u7/omGyM5yZQ==
X-Received: by 2002:a05:6a00:2e1f:b0:824:a20f:17a4 with SMTP id d2e1a72fcca58-829a30e41a7mr8391334b3a.64.1773018033494;
        Sun, 08 Mar 2026 18:00:33 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:33 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 1/6] mm/damon: reintroduce damon_operations->cleanup()
Date: Mon,  9 Mar 2026 10:00:04 +0900
Message-ID: <20260309010009.11639-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50962b16c0d6 ("mm/damon: remove damon_operations->cleanup()")
removed damon_operations->cleanup(). However in order to support perf
event based access checks for physical and virtual address space
monitoring, damon_operations->cleanup() is required to release
perf events created by damon_operations->init().
---
 include/linux/damon.h | 3 +++
 mm/damon/core.c       | 2 ++
 mm/damon/paddr.c      | 1 +
 mm/damon/vaddr.c      | 1 +
 4 files changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4fea23da857..49d2983af4a8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -607,6 +607,7 @@ enum damon_ops_id {
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
  * @cleanup_target:		Clean up each target before deallocation.
+ * @cleanup:			Clean up the context.
  *
  * DAMON can be extended for various address spaces and usages.  For this,
  * users should register the low level operations for their target address
@@ -639,6 +640,7 @@ enum damon_ops_id {
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup_target is called before the target will be deallocated.
+ * @cleanup is called from @kdamond just before its termination.
  */
 struct damon_operations {
 	enum damon_ops_id id;
@@ -654,6 +656,7 @@ struct damon_operations {
 			struct damos *scheme, unsigned long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup_target)(struct damon_target *t);
+	void (*cleanup)(struct damon_ctx *context);
 };
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index adfc52fee9dc..d0d9659658bd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2841,6 +2841,8 @@ static int kdamond_fn(void *data)
 done:
 	damon_destroy_targets(ctx);
 
+	if (ctx->ops.cleanup)
+		ctx->ops.cleanup(ctx);
 	kfree(ctx->regions_score_histogram);
 	kdamond_call(ctx, true);
 	damos_walk_cancel(ctx);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9bfe48826840..4c2c935d82d6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -373,6 +373,7 @@ static int __init damon_pa_initcall(void)
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
 		.target_valid = NULL,
+		.cleanup = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
 		.get_scheme_score = damon_pa_scheme_score,
 	};
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 729b7ffd3565..8a58aa912112 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -1013,6 +1013,7 @@ static int __init damon_va_initcall(void)
 		.check_accesses = damon_va_check_accesses,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
+		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
 	};
-- 
2.43.0

