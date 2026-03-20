Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B61359A9B
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991484; cv=none; b=brspRMTZZC1Hzk9kZxy3+G7cuyXBYAtbUhT6SVu3DcbetIRGqGFjSzibuP5sFztHciwMbU6SCvnKLADVzICRTghi1ZTCiS7uzi7nMgQ/tbU4UXhxlDQITVsrpTyxv76EFKtMXbTglo1t9R54EcHJx6rrx82ptEx29wyEaFUly68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991484; c=relaxed/simple;
	bh=nmTnACRxUk3zBwf1Cu9Ng7P0+M5l9cG5blBtzVimXBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmkHV7HigBmPT92J9bhOv4w8hUYvhnCGiAUh7iru3/ENQojCko2OTlvSp5lqEQdWVHnYQMH9Z6hkzDDLCpN6iXLPRwF+MHkPBugKOCJaO1DKlYTiUgsGe+g8yawReRyM7HBPln3wy0ay/BLA+xwocNE7L2WxUzcT5bCRYRgfyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb/dxPN2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb/dxPN2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aecefc7503so11088235ad.1
        for <damon@lists.linux.dev>; Fri, 20 Mar 2026 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773991483; x=1774596283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3oO0H+IHOvckZ4fHjT6ZGAeH2S4hcY0XM+PwetfF5I=;
        b=nb/dxPN2xZb3lEYd/3PoMm+eQ3mPwGNLP10C7m01K+irevysaPUeGBnP26ENBY0CFG
         8VrS/8KPCqATUs6eQPs30MgCb6Ibv0OhjCIWgs36VaOJAK5grESIL1O9s5sOF/gOPyLx
         BodHyxX4fiJtKRWw8yM3nWrlS4AP4/5sHEMdHrDy2DQVlqFacEgsXb5ff9+zwpHE2b90
         4tVCUvcAEziEGlS5OjH/bOiYpouebnWuqnywVEKXrsQ0V/TeVMx49Bg6fbQJ9xHHJlEf
         60Qpo/jRA15QnXS/R+re6ItpS9uRgOK4e5SxIVDSFrZRBdvlc0em1LioGnEayz0RnfJ7
         FDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991483; x=1774596283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3oO0H+IHOvckZ4fHjT6ZGAeH2S4hcY0XM+PwetfF5I=;
        b=Ma9dwq/o72hwuIwEgMtAyMuwIP3Eml750r3m+8/C6zYE4C4N0TWsY5R9iloDE55eBX
         TEyyoeDpmWhRLrLyGD1z1UCSw+tousEmG1XnJUVDS1qMf4xJk3YR4RyksG8mlIKWzsE+
         tfnFPYxjXnIecSeX7GftF1xKjYOC14DKRXCgZyugjKQS8PO6WlW4whBptzqfmpM8wD0s
         fNEtVgdU6I8vDDwkS7cqX1qjxyeDCXUySl97IThHtgj9G67/VwszvoaHj6q8H43Ds3RE
         Jdd6mOc9Mxug/YwGIUslrTH7iP884YRKOmEWcuK6au5rmWtEXnsfCTfuceudp0/RFCnI
         qJIA==
X-Gm-Message-State: AOJu0Yyqf/ahraOwj3lRaJVhjLphflwn5J0PITfJH/fZ2KVdHq6QTzm7
	yAj9/nOetyWV/IXdqKw/xu/ERlSPz8WhKOz7N6aFEKGnjIull7z045ckX4F9QzJn
X-Gm-Gg: ATEYQzyzuv0WmZkWZojFp2a4D/BL8Xb66AnwzgY+obKcycYV9ja96gFh9A1sUpIjF3Y
	sFP3MZ3t9UzKFLL7+gaXXjndwXkGhvdlgkNQbh0qj7zJ/xCJIBMRYEvdCV9d5yGIyfEIo6clz+S
	8f5WmfNFer4j+2W+MY2ulVdnTLujno+bCjZegjShp7zcGO9w34cavSzW5WjCK+iotiKgX97edhx
	xa/dYRYgUAHzSJxCLLHFv/gTE4NoXi264kcGWy0QWoLkr4U16Ja1H7hz16EVEOY8dqIXmZU4bKn
	yBK6B7+tWtl56WTCVjZnvyIzjox+BC+Yg9O1f1b+6iqDrQGL+54kfQ03gIXAARY01jeCbtXp/CM
	0+rzLxIHAZOipFlQTlLF2g6F0tDueEnCX1jr4zqUClCvKLBRatZA2B6O/Bq8aHZx0yR04NJf77n
	3jkkkQJ5vuD/z/NBh3VO5/hAS4Bvc=
X-Received: by 2002:a17:902:f549:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b0826c6909mr22728955ad.11.1773991482819;
        Fri, 20 Mar 2026 00:24:42 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516908sm17542935ad.1.2026.03.20.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:24:42 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH] mm/damon/ops-common: optimize damon_hot_score()  using fls()
Date: Fri, 20 Mar 2026 15:24:31 +0800
Message-ID: <20260320072431.248235-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of damon_hot_score() uses a manual for-loop
to calculate the value of 'age_in_log'. This can be efficiently replaced
by the fls().

In a simulated performance test with 10,000,000 iterations, this
optimization showed a significant reduction in latency:
- Average Latency: Reduced from ~9ns to ~1ns.
- P99 Latency: Reduced from ~60ns to ~41ns.
- Throughput: The loop-based version mostly fell into the 40-50ns range,
  while the fls-based version shifted significantly towards the 20-39ns
  range in the test environment.

Although these results are based on a simulated kernel module test
environment [1], they indicate a clear instruction-level optimization.

[1] https://github.com/aethernet65535/damon-hot-score-fls-optimize/blob/master/test-kernel-module/fls.c

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
Note on testing methodology:
I attempted to measure the performance directly within the kernel using
bpftrace, perf, and ktime inside damon_hot_score(). However, the results
were highly unstable (ktime), and in some cases (perf/bpftrace) the
function was difficult to trace reliably (likely due to my own tracing
limitations).

Despite the instability of in-kernel ktime measurements, one thing
remained consistent: the fls-based version significantly improves the
"long tail" latency compared to the for-loop.

Test results from the simulated module:
- fls-based:
    DAMON Perf Test: Starting 10000000 iterations
    =============================================
     Total Iterations : 10000000
     Average Latency  : 1 ns
     P95 Latency      : 40 ns
     P99 Latency      : 41 ns
    ---------------------------------------------
     Range (ns)      | Count    | Percent
    ---------------------------------------------
     20-39           | 3522000  |   35%
     40-59           | 6478000  |   64%
     60-79           | 0        |    0%
    =============================================

- for-loop:
    DAMON Perf Test: Starting 10000000 iterations
    =============================================
     Total Iterations : 10000000
     Average Latency  : 9 ns
     P95 Latency      : 51 ns
     P99 Latency      : 60 ns
    ---------------------------------------------
     Range (ns)      | Count    | Percent
    ---------------------------------------------
     20-39           | 0        |    0%
     40-59           | 9894000  |   98%
     60-79           | 98000    |    0%
    =============================================

Full raw benchmark results can be found at [2].

If anyone could suggest a more robust way to profile this specific
function within live DAMON context, I would greatly appreciate the
guidance.

[2] https://github.com/aethernet65535/damon-hot-score-fls-optimize/tree/master/result-raw

 mm/damon/ops-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 8c6d613425c1..0294de61a23a 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -117,9 +117,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 		damon_max_nr_accesses(&c->attrs);
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
-	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
-			age_in_log++, age_in_sec >>= 1)
-		;
+	age_in_log = min_t(int, fls(age_in_sec), DAMON_MAX_AGE_IN_LOG);
 
 	/* If frequency is 0, higher age means it's colder */
 	if (freq_subscore == 0)
-- 
2.53.0

