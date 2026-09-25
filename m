Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4E3CB55D
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312019; cv=none; b=dbzhHUrWBKuLTCKLPYA9bYSGrzdCVBrCOshjaf3UJ8SKuQQTyZ8LFoK0V7CCh7wXGw2CfN6bWgZC0sGKlj3t7tSxdGilKWPhTO45pxO9e0KIrNZQWX9lQugVIl9hHbdlz0eeqEBmNxP4Y4+GF+9nsZYWJjZ4w3vwgcEmYwDfI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312019; c=relaxed/simple;
	bh=6jrc6sO4U1GdRZ3xNAkz1/cIeEuKb45P7b8K2zmLeOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=it+AwvXT+B5TxsvJ184iHRxSVLdYv86d4MyqWo9PpCQ5tYe1wPS6m/ppQaEJJC3gy+RiqD3wq3zzwnIvdY4bkLVOugCagzLP0eyzRZPFYwJh2rLDJxoRBaOVSqhfzkkCdAwh5lVqywoV3k1LXYNdohV0b/jkIIt8DrpjPnMXHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvBysyKN; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvBysyKN"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d5045e0so75035a12.1
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 21:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790312018; x=1790916818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=REUbZZ1eN3AuH9mm9MMP7henzS05a7UB/qvCM8QAct8=;
        b=EvBysyKN92yFDQLy60dev6fiq3OZ0LkRmi+pdNQUdHTFg8T+M5kwbK0IaDn4XiHOvj
         goh0dYybVQXHXjWvv8lu3Tjvl1XiovTh0m/Ttz/dstnnBuPsQvcNkyo1Sf9iGi0qf4z4
         xkgLDN1HK+m/AHX2I4svhTo9FjFuPmGqLoO8Nh3yvZ1Xm1fG6NI9+JVrdqHkXC3geXO2
         S0fEJL9RagR1sofcdUQDTPI4mx+M5zeEwa178pcxemwCAgEAWeS6YOIE1sGPnLb1tSvo
         oAYpfavzg9I0m+3Mrw5AhYqfxSGp+7KSFwcNFmQnO9VfUayl1eem43niuRYhUdJXAwji
         RQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790312018; x=1790916818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REUbZZ1eN3AuH9mm9MMP7henzS05a7UB/qvCM8QAct8=;
        b=d/KL2Jgl05Q08kzFR6TR/vCe/eTIw7Lta4FmCIjLdicBrYeFKfBluoFaS5/E9XdUoG
         qxqPZdIOHN8wx7NvHHWBCAga935CrleDyLuji3cD7//AzfT3krjFyIUoyfu4Us92IjvG
         LvfU8YzINdg6eq2C55x7jcfRm1IKpQh4OLCFocARaX86RJbfdZS1B+4ssTFogdNemeAG
         SslNZBkQ1ztya+vghZSL93hECoT1cROdpP7WJCHRa/17CO8imc3kbPDTAMpiBwGATbKO
         V+t4vtWlSIvq6cgh9a6Ywmk11Gi+RTam3cmmHbkRicCZutoHmczCNkSAKxmG5CAUPtYR
         E4jA==
X-Forwarded-Encrypted: i=1; AKwUvBzWPLNxSrjTOa1eA/y7yTxuyeEV+hrvg0mWZjfOsI4xrmHQDNbu0eGKEMXyCNtCWPCKkeqoHA==@lists.linux.dev
X-Gm-Message-State: AFuF++luTuw/enxU+6YXwuJcqQMK/upkhcllf5weJUK9vxAbins9QSJ1
	zAuT8RIeo4lgESTFEQSNmaqBTBzL/QCzQxlniIY5LZQkTYKfGN2CiS6r
X-Gm-Gg: AYBFou3GmDQnKgAfhZ/g/oFd655YQNug/O6iY+tY/sm1RyoxkzZt7dd0idv5oQt8c9K
	ngJ+QDEShA3xfZt9nloFyAAyXlQrQAtC3bPaLA4sllmyos9a5EtYwCe9kj1MdcjWnjx+HInSM5k
	AJMFmVLm/OjrENb3hlCKEwyUiF14zjUjzldXPHxlHXYOjN/ymPCc8qYVoFYZS9KYQ9Za7kBp2nO
	rAz9QMADNBU/SWoQO6pVIcAjrMboUv814wBqp2urFpgyKYTOLjqg74IF8FnRtBm4jw53qBZOgw7
	E+12fVnIumnceMiRVU/jv6tE+CR4WEFu3HKhfXOk3WikXNXFQq2W6/2n0IcjVupWrlr/a6y2MsQ
	98yZMhIHjRQ1H65mikGGhUsFF4o+8QpW3gWtuj7AhbWAV6w49CktFBWSrY93Qia/PRuur1PSWBY
	minOBSKw1zKRijiIsR3tNl+HfdJgnUdH/2p8vLRAbF5qdVvIQPjer+FcXnfICB892xHM8uAbXf
X-Received: by 2002:a17:90b:1dcd:b0:39e:d36c:ee54 with SMTP id 98e67ed59e1d1-3a0bb55308cmr926280a91.5.1790312017647;
        Thu, 24 Sep 2026 21:53:37 -0700 (PDT)
Received: from celestia ([2402:1980:867:387a:70b:38f1:a1dd:9303])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589bbfsm2053242a91.9.2026.09.24.21.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:53:37 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Fri, 25 Sep 2026 12:53:35 +0800
Message-ID: <20260925045350.66595-1-aethernet65535@gmail.com>
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

Changes from v1 RESEND:
- v1 RESEND: https://lore.kernel.org/damon/20260919080453.628679-1-aethernet65535@gmail.com
- Drop braces for single line, as suggested [1] in coding-style.
- Set min_region_sz initial value to power-of-2 value, '1'.
- [1] https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

Changes from v1:
- v1: https://lore.kernel.org/damon/20260831113735.3349-1-aethernet65535@gmail.com
- Resend since the dependent patch is merged into mm-new, that would
  help us getting AI review help.

---
 mm/damon/tests/core-kunit.h | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2..f4237436e1b4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1632,6 +1632,47 @@ static void damon_test_rand(struct kunit *test)
 	}
 }
 
+static void damon_test_last_region_quota_reset(struct kunit *test)
+{
+	struct damos s = {0};
+	struct damon_target *t;
+	struct damon_region *r1, *r2;
+	unsigned long min_region_sz = 1;
+	bool skipped;
+
+	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
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
@@ -1664,6 +1705,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damon_test_last_region_quota_reset),
 	{},
 };
 
-- 
2.55.0

