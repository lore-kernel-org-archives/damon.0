Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3C352032
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176254; cv=none; b=Mw9GaC+mtR7N+eDI4F5Ngskd7C5NHTXVk+NIu8GHNrcC8IEwb61YCH6o3CqHyqlzPaSk6Hm1alnTjOv828uAOYml6j6llVjRKQZhYAkAGTmEfIAPPldFMCrYZQDNz5XpBhVTMXSL9zyRMqsOLP4NKyE12T1N8nh0Xq+dDtnem1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176254; c=relaxed/simple;
	bh=I7TaQ0V7AXmZ1+0wiHwiAdHeD0et7WeNJ7OkyHsHQOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0bGiIS3yLd15JH1NQqmH3Ng5aTr7p21/zYgUlolwodxYmqla4Zrjwh5cJ56phX5xyyDKTabxeflKQvoH6F9X1vTfcFxpFRf26xodyrfieNJvGpBY+FM4i7zWJn3h86gd3xxCZzzXJU8x3AfnFTtg/TcFKpfBxx1kyz+koyQtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCI6sURX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCI6sURX"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso2898851a12.3
        for <damon@lists.linux.dev>; Mon, 31 Aug 2026 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788176253; x=1788781053; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAhbWor4DKGsX3doFWg/6nm52AV3PsoJHNom3kwfce8=;
        b=fCI6sURX3exiGvKsf2uGdeDaT4a5P+TkghTIKWUQuwdGNGAbuFJSccszn6fEmmf758
         tIbzZUDSUEzZzBNMuP/aQMQAZWjWV/MKNYHvLPSZIsMVeaa3gDPE5HELtiHmKeGNFmCv
         6p22VYv4g/dmpdN4UG+mJrMNuHpn3RIuIg+dD0j29GQYFDrHMXn+HzU6Nb2OEvgTuXOf
         rVSsnNHFnOw6tWwogZ9AC1rmdZRl5BywUH2wKnOrGSLwDXUbMgYjShBlrLbMZiWF85SB
         kiPJ3C6QTG8vtnB49JqymXMZen92T9VmFGhnhNp0ohgyDE6LagXYnxVd6L2YFsIs8RJv
         V7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176253; x=1788781053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAhbWor4DKGsX3doFWg/6nm52AV3PsoJHNom3kwfce8=;
        b=sfWX+XbyDPPTDAfnKxwGzvuMIOWd1Tq1Ac0WaXiK3L7UHKBe9G5zp1x7fFjrul/OLN
         lR78LhijXL6lqC4AZQYcCdPZgWL9VR1avJXjyQSVBCAJ3mCBdPMwsVs/tTE98FSrJXsb
         Qn5OeBsIY3xARYyQUsu+2ldB3xil0g6+jCCV//PygEHaYheEF00qj53TiTo4UCQ+VLCT
         sedInVlc1N2Q7v3XlocsyFhOc4mkCv/dZEJEoXejqI5jVRZfz8CxfQ8wliMB+OeDzoZM
         Oqq+Hhg46aTPIwsjyL7CFhNDeojgEbc8LODUYwdk7ZxpXCAGZ2rW+qvYJzYGuFAz6zYz
         LRsg==
X-Forwarded-Encrypted: i=1; AKwUvBzXa/CgPoA/IzKMs2NTdXuroKWAGsRKYGVndt2oOFpOVTOGFMOMDoEpEBYfw9WdC63K2GKd+Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mL/NMwAyGFHtNpu3eDddNhAMIo5p/S9l5vA8sVqxwBRNfiQ1iV
	wWQPL+tJxfoawQgHRd412XgdnA5qmVhzkrOZYYaoAxD1ZwrYT1yGQHOH
X-Gm-Gg: AYBFou2MZigxg0CeSOz/+zEdbdqtImoacnIzv/FkII/NZyng4nNDHf4qkKrbweUSCmJ
	9EizVNdjgjti/1+0NFr5yHg60lQT6JD/qGskg+xVpZ6lBip4IsHvOd/EHMq3FE7trXjStgwJaDV
	X6J3n1dn73J8WJt2bTVbfhYr8Hn5WqwgNmBm105zIm+q41+rDBR9jcnZ7bY6fOrQ+9mBIatQWzW
	x7eCmezK/V0yQOobD4X+TsH6j+MKhdjMbpJwjat3V0VWL27GOcB8Ka281gkWVuaiQRHS5CM3FeO
	5HodYLmlzuOD9yZK6SwksYu1BsOdCnQEl2ZUcfQT9Yb5dPfZyW0T4M5LFHG/CMdHSpaQlkxu2Mf
	NorWqMS7mc8KuCMkAiaBzfD6B/SjuFDAt6a0s0O+tH8lfXHAygRB3mZ9esiHQh5SKlu9xX/mO+O
	Cv2/yqGcFlZPQJove3kYCgT8BQONKV1PDRPm65Bn8oSEVvRodqBttDZwiyorJufuBTaa+gTAcAV
	WplkoiRbbQl15ux
X-Received: by 2002:a17:90b:1dcb:b0:398:dcf6:d40e with SMTP id 98e67ed59e1d1-39907db4f46mr132089a91.17.1788176252810;
        Mon, 31 Aug 2026 04:37:32 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc08266sm17197591a91.11.2026.08.31.04.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:37:32 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Mon, 31 Aug 2026 19:37:35 +0800
Message-ID: <20260831113735.3349-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
regions") introduced a minor issue that causes the last region to be
skipped before it is processed.

Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 100 bytes per window.
    3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
       addr}_from is saved at (Target, 100).
    4. Window 2: The loop reaches R2.  Because R2 is
       damon_last_region(t), the old code unconditionally returns true,
       skipping R2 entirely and resetting the charge_{target,addr}_from.

    Result: R2 is permanently skipped even though it has never been
    processed.

Add a test to prevent this regression in the future.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/tests/core-kunit.h | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2..90b0fda34fba 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1632,6 +1632,48 @@ static void damon_test_rand(struct kunit *test)
 	}
 }
 
+static void damon_test_last_region_quota_reset(struct kunit *test)
+{
+	struct damos s = {0};
+	struct damon_target *t;
+	struct damon_region *r1, *r2;
+	unsigned long min_region_sz = 10;
+	bool skipped;
+
+	t = damon_new_target();
+	if (!t) {
+		kunit_skip(test, "target alloc fail");
+	}
+
+	r1 = damon_new_region(0, 100);
+	if (!r1) {
+		damon_free_target(t);
+		kunit_skip(test, "region 1 alloc fail");
+	}
+	damon_add_region(r1, t);
+
+	r2 = damon_new_region(100, 200);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "region 2 alloc fail");
+	}
+	damon_add_region(r2, t);
+
+	s.quota.charge_target_from = t;
+	s.quota.charge_addr_from = r1->ar.end;
+
+	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
+
+	/* 'r2' is not processed, it should not skip */
+	KUNIT_EXPECT_EQ(test, skipped, false);
+
+	/* 'r2' is last region, it should reset charge_{target,addr}_from */
+	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
+	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
+
+	damon_free_target(t);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1664,6 +1706,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damon_test_last_region_quota_reset),
 	{},
 };
 
-- 
2.55.0

