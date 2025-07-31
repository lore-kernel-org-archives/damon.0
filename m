Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E6A94A
	for <damon@lists.linux.dev>; Thu, 31 Jul 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968198; cv=none; b=CEKVNjJIVsdeXc9AhFUoA7f/yn7EtDIJgE2jleIyIK6kpIpli8hU2Vc8qglsT8MP1YjHRPWZ02fOz3jqRB8YCHYf7bODf8QNkVrNcEU/xik/KSOZtdFxYkvRsDhlLs2wZxj6Y5ygfh4gBlSTVyPeSuOfWrnrkZ3Dxe6E4TznB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968198; c=relaxed/simple;
	bh=taueXn3lGhPF6TEJNrfFLv95rth3fzeLv/TlioqZUSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmwHv9vGbch3Z3t/8QZBlZCK+MsVUOPtgs+KhLTpJLr3/kZemRdwdPOk0zRTHEgAsP6yGddmicaNKoQ+pfMW+NKgIaraGFONbkCw7LHS2ZzsxDQJnVDzUuiB5l6GQo72qH2zw9q9Hv3+RaYg+uVohkvZVMH4q75PLuUD72Czs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii1G+1tr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii1G+1tr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so847873a91.2
        for <damon@lists.linux.dev>; Thu, 31 Jul 2025 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753968196; x=1754572996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOGGdyHbZUhQyDNRYA2xz+A6y6GeRpSpoCEnGZFiNqY=;
        b=ii1G+1trivPUnjP/1bqau3/0TU1hv1umgNtBeJ0eTXxzTMVf4MW2ZisVyK4eEokP8U
         8Ingz7wbZYsP79wK0Hi8PzfnBelu9TVOo/5uNjNNfVd2MPHwAVTZlij1A4ykJFYrf0bt
         iGHMQZWdfueei8lzDMLHs1DaVn1tiaNm7sm+z2WOjuwPfgQSQzue4fQJsrri5E1bSMNo
         q+VmDdgVs/M9v0UO87ZHm0fd2RROEwrswK8+0PrKYMaORJSnfAcNgHUoiZhGyYX0l2XN
         V7Fh1g4MZKaqldW9/Ev8CjGO1Cf6uuZYjvZd6i7qnedUgbvX9T32RFdfWdhsn0LtVYCf
         UORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968196; x=1754572996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOGGdyHbZUhQyDNRYA2xz+A6y6GeRpSpoCEnGZFiNqY=;
        b=i5+kYCe1cmHlTPBsIAgXgp9nF62OQF9+eqTpDARRZ+5rvv+K2n6eVGQDjGBQQpRVN2
         hpyR+RatBtHo81gqYkLzOpfP36B4ITVHVJlBL0zB76BqqqrAdzwQsxLIAiUyXRYpemi8
         nl7E8I/lNqfchf8iKT/HwTy2Qm8OWtOL6xENzYdGfJRR+rOjKRFNwTACwrw5UTAldgUf
         qlaBY5q1IJbi9kCmrX4xLdo0g3KvBnA66HL6JXhVwXJenIx99ORY0b3iOglfHWe5pFya
         uzOYvTXu+qilJP3kkdnP4nsRXn1rNS5Mt6olIVnyOWfxpaGl42atqVtLr5uwk2tZm0+k
         49Yw==
X-Gm-Message-State: AOJu0Yws5jympwHiMiMuGPq6ghWAZum3spmHbHHbNgskHVON8Pxg/EDq
	N7CAzgyeD86U+S4wkM6G4H7J2kpqNONy0kl0+aVnKnhIoqXtLAlRTDyz
X-Gm-Gg: ASbGnct6CDN1SHCAQMw8b+721sskrdXeOQWRb4QORSFqApXgYU3BjR1rHMKoHuFDtAK
	A32nb7TsuTz2TrHpPmziOjMGKztNvSVIzfq/B9tmSZb5fCoPvkvhl8yGoh1pJKbo/yAcGvE6luU
	VPvJGyyYU/C8W0EU21sBfMuQm9VB1TuqOmmoR0LEi4D4ohALzWIdP1FKiqrcETyt7ahxVGDng9c
	VcrMjKt+HstN9WU/HN1gZ0+W7pf4f7xxA+ArTdYSinmgaZOOso30NjeJvNHmH+rRaSNbZ6l2yfk
	RcCY37SuhezBFW69e++YmxuP8O1ljUPXHAQyLyWWYpG29blNMl34rzyWKtmVMZnCuqW+GxydtHf
	VCegnrcZgTXoRzTAL
X-Google-Smtp-Source: AGHT+IFvwEIp3lXVD/L+5kD/sKYGKqGyXnBBKkOezPOOiveWNVfu4Kceqs4/WOMCqQtd6D8s7RdOsA==
X-Received: by 2002:a17:90b:3c07:b0:31f:20a:b54c with SMTP id 98e67ed59e1d1-31f5dca2727mr11106123a91.0.1753968195707;
        Thu, 31 Jul 2025 06:23:15 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6d3asm2002899a91.23.2025.07.31.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:23:15 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] mm/damon: update expired description of damos_action
Date: Thu, 31 Jul 2025 22:22:30 +0900
Message-ID: <20250731132230.80046-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays, damos operation actions support more various operation set.
But comments(also, generated documentation) doesn't updated.
So, fix the comments with current support status.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
I also found below patch(https://lore.kernel.org/damon/20250730200239.60984-1-sj@kernel.org/T/#t)
So, Is it means that DAMOS_STAT is only supported by paddr now?
If my understanding is correct, then we need to fix Design documentation
and comments both.

However, since it will be fixed soon. Keeping current status is also
affordable. So could you check this point as well? 

---

 include/linux/damon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cddf82eaac4e..0870e9f48b0f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -128,7 +128,7 @@ struct damon_access_report {
  *
  * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
  * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
- * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
+ * @DAMOS_PAGEOUT:	Reclaim the region.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
@@ -146,8 +146,8 @@ struct damon_access_report {
  * The support of each action is up to running &struct damon_operations.
  * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
  * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
- * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
- * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
+ * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD,
+ * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.
  */
 enum damos_action {
 	DAMOS_WILLNEED,
-- 
2.43.0

