Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA92E92BA
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054375; cv=none; b=ad7WRfojtb/7LtD1WqzPXvJZKaHbiS/8oBgI+Y5f4aUxLKHuzIOaXuSnJxfQrEBMM5NBy2dcgexT7oMnzjka2FEE8Djhd02G4tJMW6WvR9DmAIbc33PNSRuLqBH2LmIiHxACOrIuiGYO/mrUS1ESHe/aK2eu9OOtEL2wBGAYYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054375; c=relaxed/simple;
	bh=Y9qPy7mrrxPto9Qxr3HW32SIk+puEGLlGbbY+UJ37W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBt/hnvwqCIo94Tr10UiQCiSC33apLLKuboowPkGud0lLUz/1jgmN5graaQzgUn3+jPqVNCXVGcSJ8+Ziq54GP3wQCDD7ZJ6QT+DIPMdxZ6bCrOZjSm7++m+yXgX8kAvD91VpLEqWKNNyLem+4qo6bKzfGpZTwF2HGyZ5xhmHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7hseoBL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7hseoBL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so5260045ad.1
        for <damon@lists.linux.dev>; Fri, 20 Mar 2026 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774054374; x=1774659174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5RzbziaymrrS+M4u37AJD7hgEjc3lgDwyej9fgC8U=;
        b=a7hseoBLRvr8xYv0tY9txG8IuWzD9Ey7guYPuVi2FiqaetH9ho1Q+QGLneEZ9NeIso
         iZLgG/whFG3gDaY/pt0y17K2Gx8LsyI+HKniuPh5TRWIbuMk/vdBhZspNMNt+gy9VFVm
         rrcJ+4Y/WnHKYxpucR6TDeF8ukqhn/kxy9Ti5MgUZO6I8C39ROpoK3JVUwgKjdK38LUK
         BOOme+BK82gTdhZHUysLLQd1ARD08dd30RFidR5x+cDC4mAYrKXS9BEQmlKcbr9Dn10Q
         OAMdi01ZdWl6dxEkOpd6EpJ1BxVFhr1tS9ATTcmFAB2Mss2vfLduUYksxSRIz4r4iKsL
         wZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774054374; x=1774659174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+5RzbziaymrrS+M4u37AJD7hgEjc3lgDwyej9fgC8U=;
        b=nmnUHSM3UQvOAaxnFuv1qYuLrH8Rm2Qw61+YKVNRkRrVFD3URvJnQhp7ZU3kBGBNZJ
         an7NAxPD8ZtueyoeQUkaktaPPMud+7BBU2/3r9OJAFxjxFqGIexucxkaM7cxg4i6utrM
         Bh7Gejm0Go44pd2lOLvR6eNkAtzW6496eryOxXFv1L5C/VA0UDxlb3xiWbmV2ztev9nk
         sJrltffgMymSZeYgi2xwuJAYVxsYy9GIJmyROZT0Trsay06nNTZW3RPXi3sbpUN2HCcV
         qbBL3AxpWtELFYUcRgozvshuWssCnVuCtcbvDtyx+nEjOyUAZ8lf2lQYxmbXoZhevYbv
         9F6w==
X-Gm-Message-State: AOJu0Yw17DAWU24ktJWr0eFjj95dThKYW99Wocjaz3XTb0RJWLbkiXze
	IHmdNJ6BjoyfdM/eujje9PUgIoEzhZsAObb5xMN4DmJUHu5jowZ6GVng
X-Gm-Gg: ATEYQzwSMK13gf9cyuxB8TqoWMP5A2g8DHLEmn/0ozFM/eA2rupeIQOvMC3CoB87An/
	e5qcrIGGaCmt5SupLQBR+qvIdTTWR3gO9F7UyQvcUFPwU/IfSrZBiLhmwZBoKwYKoZX+xL8NUOm
	4k1lE4t5gKDMC1H8pJF3Xo2+JVKmIVFQ9EO35pDWNnpIctRJ53IzQcg/N+6/Nzdz7wwm6pL3L3o
	arC3klrEwOfuIkr9BfFCkpOCQQ4yBDCsGgcsFAS/0tJ3CBzlPObvEwrCaEzMca12QqcHv2Wgk27
	AFZtZpV80aWG70CiY6Ln5aUc6BI8hJLsOSMWjfjKQ9fsDDAijNEKAlzUZkvifuIlkmS3h7vqo+P
	XLkyRADnQHiimfu8yv6ILpo4bbwnO5SWmDHHkzTwfvoceZ59oWjZIPrrW/uGfLSbzafL2JlNwSA
	RY+aWRnjhKKN0cwZ8h7XZyBk6Srqrsz1vBEXylvTtw9jbd1naNBfY=
X-Received: by 2002:a17:903:acb:b0:2ae:6012:3168 with SMTP id d9443c01a7336-2b0827a7710mr40513555ad.32.1774054374011;
        Fri, 20 Mar 2026 17:52:54 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm34872915ad.25.2026.03.20.17.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:52:53 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v3] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Sat, 21 Mar 2026 08:52:48 +0800
Message-ID: <20260321005248.6114-1-aethernet65535@gmail.com>
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
Reviewed-by: SeongJae Park <sj@kernel.org>
---
Changes from v2:
- Send as a new thread instead of a reply to previous version.
- Add SeongJae Park's Reviewed-by tag.
- Link to v2: https://lore.kernel.org/20260320192020.33004-1-aethernet65535@gmail.com

Changes from v1:
- Replace fls() with ilog2() per SeongJae Park's suggestion for better
  semantic clarity.
- Move performance benchmark results into the commit message and add 
  comparison between for-loop and ilog2.
- Link to v1: https://lore.kernel.org/20260320072431.248235-1-aethernet65535@gmail.com/

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

