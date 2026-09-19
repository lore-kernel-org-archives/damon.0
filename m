Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE662D595B
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789805092; cv=none; b=QWBPQOxrebAguEqYbUebXvDy9DRo2tirvTwY0T09OesInw740sBobPGJGSN0DpybHd4DkdQr9Z9+be3xhLWFC0WhBrzZiN8rP1egwLfMd248dlwJ776N9svDqpOolv/BSS3BD7ZxJBTx609VbNkvxqCB98SHI8d+GLAnwKaA11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789805092; c=relaxed/simple;
	bh=KaDOABN88LHq1gFxG1tEAi60S42z1VNhpezrBbGF930=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2Uu/IlFRm3WOuwaiOt/C8hFFfih7odzhA9YsNtrpAqiORnyG4VZDzCKb8N5SPBee10eyV3Wo4Q5vZL880E3Efg/TCm80Xu/7jfW7+ow/tyj62zCxbRV93sDq7b2hHxTghzXhAKDsNwcqB7EoZ3oKxt1foeqx1ajihmYcS5gYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDVJO5+i; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDVJO5+i"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8686f46e4adso1304098b3a.0
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789805090; x=1790409890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+BRVhkKKFrAm9F4me8SFnldKmWn3El7IJQUQ2no8Zc=;
        b=PDVJO5+ijZSZnBYnBHpLE5elw4zr5rirQj4eazFbtZ28nLz4Sekl9qqDbsqta1L1Dg
         7CFCOLKA4IeZCsiqTwbc2HGj/dmDfci66DqLV6R2PL2WWK10uUewtjPUOWRSwEmWK6R4
         3/nf/LLKFoquK9vZrnkT8Mv5MdZPDxvNySOss36II1fk+ZAp+bdQpPTx+PKjAlR17JRQ
         vdb/jEvIfzLap5tNwen/yfM5XU7CrgBdA7sWM1ryE+/f6q5UQ0nkin/DXIKI0DO73Eyb
         JgPpI8dvr1ZwpQ91AUro4MnS7VNU1BOZYslt+Zji71oVBQZT/NUy5Mo3KIbvZFBFioek
         YPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789805090; x=1790409890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+BRVhkKKFrAm9F4me8SFnldKmWn3El7IJQUQ2no8Zc=;
        b=el2fGHqXlPVaVN+jEgh1BUgPsxw3Qm4L86MTmMLaeqrDAYs1zVNU3cLub8HiWzZysC
         FkwlIXhQKjGp28e1xRlAJMn29Xc1hDLw4pb3Ntkj6ouNqfvuYPkwioVJbeMrrru80wPd
         VsHSD8AZ5V7HUm91jdFnYPr/O9jL1j0LoViJf9U7OZlb54MXoTMe9j1jm0n3fUpcFOsM
         3Q4Z8gfUQnnUl6j0A+iBVOxUSsgYHWWOSLztTLpaVmF3OsbVgyjsf4SJbR+VHf06u2fV
         o92B9HkHy0JZbfPdaazEb7hUB+NeM7GExaES3SnJJzsxEEd+L8FhaGMU18Qou5ALTL71
         U1uw==
X-Forwarded-Encrypted: i=1; AKwUvBzYuOqsY3H0EIozi3H5CQpVGlWDB0u3FeD4JQ8r0Zjr4wl7yUhR8n4Te0hTxolqD0ylCG+d9w==@lists.linux.dev
X-Gm-Message-State: AFuF++kKoxH2i4ePBIHgLqFnT8+YS14UixVvL1xyKVaCYidmm0O1zv9v
	N4nd1IdtCz6DjzzTMICM0JWtBNH7JmD64YFWwbJOWoyvcoMlRHjI7y6D
X-Gm-Gg: AYBFou05PQGzFvS/DZrKMAMmzpUVudZTvzu503qdazQdF2DT4vpGRgR3iTqnnwgMqcy
	F55VKS9/iCLYH3WqZ5zxXt/HBfyL8nDna9yrqvCvqpHJQzKKKsVEGv1qylXCrrHOtqgw8PaZ+Rg
	/mEIzGFKc8aQIci+e1CT1Xd3miehFJmzD/Pc5t0mDHd0iXsAEMBtRC2tg2AXftO4OiRmb926H5u
	pq0xV2SNChj7oo+1UmWS8dnV82uUyXk1Vw2E+I2oNj/fJzb5luxYO9doVvk0c0aam8nwVvxNssv
	5uEW0TJdSZS0NIoT1Y5bheiaQC7N1Ip3XSat9T9nkO4wp/oq6V/sTj7AwSMBphojmq2uaT/Cd4j
	pD5ALpRtJFL/vC3axDGbbFpY7wb8roOr9M+0JML95El03hxnaIn7rJCBqZXrl6gmFT+c56Xs8/z
	j1GfXeNZCLAuwJXKSlx19+jR9Hs3zh3rZPalhuM5WEJ7LQm6807Q7zi7vuWPxqOocW4DLP1j6Wd
	S2W1QrydheD
X-Received: by 2002:a05:6a00:4655:b0:852:38ff:b4b6 with SMTP id d2e1a72fcca58-874dd6ff304mr8942695b3a.17.1789805090087;
        Sat, 19 Sep 2026 01:04:50 -0700 (PDT)
Received: from celestia ([2402:1980:c3f:8e4f:9945:ef6a:453a:80bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa11153dsm782402b3a.51.2026.09.19.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:04:49 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Sat, 19 Sep 2026 16:01:58 +0800
Message-ID: <20260919080453.628679-1-aethernet65535@gmail.com>
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

Changes from v1:
- v1: https://lore.kernel.org/damon/20260831113735.3349-1-aethernet65535@gmail.com
- Resend since the dependent patch is merged into mm-new, that would
  help us getting AI review help.

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

