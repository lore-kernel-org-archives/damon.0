Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965D18871F
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034427; cv=none; b=Zr9CKtrqc7t5Td7YfW7sL0G71xRCW8+Ox+1dtLjDcvu1pZ576jVKNwV/Yg38DOWPca6UfDfG0wN6bARo8rXdAsKK+cNr6MyhJdeF+S8zoNDa5mQiDJYUKaySDCoR5suRPDOa1Hl4O+J6HbNRaKwmrzkC6tyD2rtb+aGb7lWNX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034427; c=relaxed/simple;
	bh=Jw8VaToH2oYmgGwd7ADmCwZBvmw0UM3XuC3H3IyL90o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knFXyj0FMkDj5CqiF2IcIO6WZydbGhwfluYeXz4d59/0bcNMoWQwZsSZwmT5dT74KYXuxvTCzPwsflM5cYiJlcSyaac/HFFQwPlP3daZMAB2OtcLmajEMPzaDsYShDpgdgYeKcP0uYT2xnWb18ko2vIDdsIEYFnbvrmXXJcmGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYFYBDrW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYFYBDrW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab077e3f32so4627425ad.3
        for <damon@lists.linux.dev>; Fri, 20 Mar 2026 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034426; x=1774639226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LEQ9U7PnM7Nnhyw/uhPtGyUN+wAdVE54fMETFryOco=;
        b=hYFYBDrWRnif7AuNucTECcd9O4RjFUr7rQ8oUS8Ofo898sAa6On4sRDNdR9U80tz0O
         q7Ihh14KpgPJlsIVVQZEpqCmUBiPiZnGIzEMiS/m/EtdTJzblzVAkdFb/4NDRXV8J7fr
         xqxYfaBZXegX6BsALEE4K5KgApE4Nylqf4fuZ9dYjlaRcnvOk0/FQVOIrZ6wJ1alDsWL
         j4ARms/PuoFfsMdqZqlRKfjJOArOekViRDMV4jtFo4bobyUzICUcxfQywYSWkxcq7/XZ
         llxPAol0dtDyZg7t0Gu94ygSgMNoatdEIknwWlUu7oYyaVcKO3VOGymbQOPnRCVUeqfW
         jtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034426; x=1774639226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LEQ9U7PnM7Nnhyw/uhPtGyUN+wAdVE54fMETFryOco=;
        b=Zl1vIwjKPssGUidJK1gPO3HYdu8JP5DoFjrHwXyhDN0PbykTiUvWJRALpobiSV9Ubr
         gcr88dZiI7zB3BXRNFNCfJi+65KwneOwoyidS4/SXE/7dLBiJwewHZkmDOkJ61TRJNNO
         V83CSKV4OwaQ1WJsURfpypiPAO+95as0Fd4Xyb5q/2uSNfxepTbeAG6MJ1mJ0eFn0fLE
         raCmZAFVhgPcuedjw2aeWBG+eBsC+1gWtbyTY/hhqugk6B0Mlu03OJcIEuV+pQEw5Uy9
         lhNn6MyQBVPILZP6JJh41bT5AWiZjhJn86ptIXlVvLJ6+kr61QQlF6bxLx8xqfPA3KR8
         0evA==
X-Forwarded-Encrypted: i=1; AJvYcCWF5mRcdxL+5lagRaJoduvmJJpMQo+vC5qjLYSH/LhMkcz6vGaB8K28jVDjBIUK8Q8AU/o+Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznkZNG/Pt39At+7bpF9wq2oFv7bLqoMZ8FvZ+TxoL01pNN44o0
	+jok8FxyJDiuF2ecRCCBWzh+J8PurpX13TWpGlhLpBalFv2YA2oiA2FE
X-Gm-Gg: ATEYQzxhTu9psuWOgfMmd9QsNshg25ztse6+5KiLrW8SoXVIK2aVuYNZerr+2PJMmSw
	fd6IIUSJ/C/YS8TWLlyDUw4/NzjVQ6IYJnGa55MCjI+FZFoGv3qXx0O4a8CCevdiHAoduoutH4f
	ETveVlWdpLj65tdGvlAIhyfXVAYND4uCrc+aur1me2pc6IWOUPY1zlm0oRGdf9iuFxlY0eMy14V
	+Y6iS85uWL++Eywc6siWj+6/zo5QP2s0ObDF4hk584ijwaEtoUyieO+u5CqvdQGcM1aJYyp9HNx
	URTNBNiOlVJ2xXm36GZXcdjgCaZvYUEonjrYVqXp4KTt/urb8OpoM9RaPD7mzFU2NeKqflh4xW1
	bH9B3DixwPNbSVd4q3eoaLSrDsNKuPkDvRGflG+WKEVqJ3NO31GzTFGC1YyX+sQbwQQINy08kJl
	l8MXLA/qFcFU3gniTWcqa6Qis32YCJlTi2jOaQSXS1U4IABjQmQoI=
X-Received: by 2002:a17:903:283:b0:2ad:ba04:40ca with SMTP id d9443c01a7336-2b0827a4dbamr35798805ad.25.1774034426024;
        Fri, 20 Mar 2026 12:20:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835161a0sm37085675ad.10.2026.03.20.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:20:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Sat, 21 Mar 2026 03:20:20 +0800
Message-ID: <20260320192020.33004-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320150536.98893-1-sj@kernel.org>
References: <20260320150536.98893-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of damon_hot_score() uses a manual for-loop
to calculate the value of 'age_in_log'. This can be efficiently replaced
by ilog2(), which is semantically more appropriate for calculating the
logarithmic value of age.

In a simulated-kernel-module performance test with 10,000,000 iterations,
this optimization showed a significant reduction in latency (average
latency reduced from ~12ns to ~1ns).

Test results from the simulated-kernel-module:
- ilog2:
    DAMON Perf Test: Starting 10000000 iterations
    =============================================
     Total Iterations : 10000000
     Average Latency  : 1 ns
     P95 Latency      : 41 ns
     P99 Latency      : 41 ns
    ---------------------------------------------
     Range (ns)      | Count        | Percent
    ---------------------------------------------
     0-19            | 0            |      0%
     20-39           | 2625000      |     26%
     40-59           | 7374000      |     73%
     60-79           | 0            |      0%
     80-99           | 0            |      0%
     100+            | 1000         |      0%
    =============================================

- for-loop:
    DAMON Perf Test: Starting 10000000 iterations
    =============================================
     Total Iterations : 10000000
     Average Latency  : 12 ns
     P95 Latency      : 51 ns
     P99 Latency      : 60 ns
    ---------------------------------------------
     Range (ns)      | Count        | Percent
    ---------------------------------------------
     0-19            | 0            |      0%
     20-39           | 0            |      0%
     40-59           | 9862000      |     98%
     60-79           | 135000       |      1%
     80-99           | 1000         |      0%
     100+            | 2000         |      0%
    =============================================

Full raw benchmark results can be found at [1].

[1] https://github.com/aethernet65535/damon-hot-score-fls-optimize/tree/master/result-raw

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
Changes from v1:
- Replace fls() with ilog2() per SeongJae Park's suggestion for better
  semantic clarity.
- Move performance benchmark results into the commit message and add 
  comparison between for-loop and ilog2.
 mm/damon/ops-common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index a218d9922234..ac604fb7b409 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -117,9 +117,12 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 		damon_max_nr_accesses(&c->attrs);
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
-	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
-			age_in_log++, age_in_sec >>= 1)
-		;
+	if (age_in_sec)
+		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
+				DAMON_MAX_AGE_IN_LOG);
+	else
+		age_in_log = 0;
+
 
 	/* If frequency is 0, higher age means it's colder */
 	if (freq_subscore == 0)
-- 
2.53.0

