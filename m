Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA73388E66
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849419; cv=none; b=Tpy7GTPVfPiS2Epl4LyLzzdl4AegNUEs6OXzS2RtYgKB/dQ2GDshM0Sjfqw+6/DyQMM9T1nt0Qu3NMJDLn/PaMBSZoPw82kScG4HAXgeXUAg7Zf3SB+PoqWpkSfJz9jKE5ZL9VQSAsTUVc8VIMR9MIoLwsiocdHatYO2VjeL1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849419; c=relaxed/simple;
	bh=86bR2fjDOyZrBl/MkYtR05D2x/2su6RiP+C8nGmCZEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVxJ7C83qgUvhv0XQZLPnOCquInMm9AXTOfRTXrNl71S2IW5vbBlo4lPOTzbVrG+OFHCA8qZtFFi2uS0nZ1cLCJ/mE9pXdJN2EwU741ZRxNTobHQr+5Urj2pe9a+xTwM74KZTvaINtfOcZczdtPiCSec8X5SZhnA2BvDz2pUqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6tc3jtR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6tc3jtR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d9004f39d3so51848815ad.2
        for <damon@lists.linux.dev>; Mon, 07 Sep 2026 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788849417; x=1789454217; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm1rxSc0BVfymKk4bSWdt2MAj/JI/30d2pnBXYKFQig=;
        b=R6tc3jtRT9gH2nruKQFmRqPQmaeU0zsn7iLe/Pu2nxV+Pot+wbxLkgv22BeT8U4Jng
         7UM8jETTfximww9mh2DASE8P7E+cNKFJWbzCpT5WsrswygRBdz1fqHPNTwU9rX7FWM0D
         XfmJIlFvnP1/8SUZZ6lpqxgwXKTUxT4dVh91IgS7RHQqt++XJK2b3mN9aiqoLFl+wXln
         xH5sJA2UN4b920fBxxYbzMC0Kb0kAMTw7vuyIeMO4uZdiqv7pAGLAUSdPnVxr0jz/6/k
         7dTyFjDs62BrH4m68+pvg6YiIJZwSG6q6rvVqBifNcgb4hsZZsmeq+bUN2ajOMrYPsn/
         sXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788849417; x=1789454217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm1rxSc0BVfymKk4bSWdt2MAj/JI/30d2pnBXYKFQig=;
        b=RPlpu7CqWe882+1bBIMkMYNWsbfviNYg9Z4JD2x6W1qSScuQBghHlvlLC+QwA+s8e+
         OCghoeh57/v2/m9YRZpLlGZC9DzKy1G6RyJoaFUC+hZrXERmXMNoMTiBbTnfPSfHex8j
         Y3sG/ZsWt0GpWIJlsh70x/V7w5OTlZwgBoItnHr+MbU+ZIPqUSxmrQR0wL39Hs7y/w4b
         kdJ1mNq3G08mVguA7//AYpuRLNPHac1qjtLt1ILen28rfxHT0LMBUlI0OoiHkaQJimy+
         0KK1Cc2hXwk3g2KZx3lsiAehum6xQQFtruzPFGXZb4O4s5qmVLzMzZUYj5eeOIXSRAn0
         ASzw==
X-Forwarded-Encrypted: i=1; AKwUvBx3MCqCQl8l7Vj8V/TUPFB0ZI1lzrNIcRMjrBM4uK64K/TgGjbQcoBdUMhkMkKOMD2oWJez9A==@lists.linux.dev
X-Gm-Message-State: AFuF++m8nz4101TPshylCMLOUE9gTLsXNcfoCk7uc2unRSqCL4ljLVyN
	vFFsFkOoq0SEZsbSdUt5mvgOoXYmZbX0DOoxe+Zz+fjc7o+tUisZUGZF
X-Gm-Gg: AYBFou1yVx+g/1lxpDnAJY2Y8G2+Jb/FArIixZsZmVkdCEe7gdB4tAnxiXotEDTVPFn
	En9/qBntuPqRHqO7bpmyR3/vD1i4dJ7HFbFfVCe+q0SFi14p4g3Q+Iul0VxvpelMuPDxgjscXme
	Q2WHTIxumQcfZxUngrfzQx6U0wno59WtSHGLWosUz+PdRFcVErSuseeXLIBiosf9mCXblWrLXdj
	oShmxHdLutjpeH2YLwiDHrDkgl2zn8FIPuYdU4Z7aFD+2uPjIcW5rh9cFdNNaTeD0fG7a/S8CXn
	rZLhbaHh34pC0oQ2/IylkhzUNpyiyQ9rnUseibH4coqi7mqudJ4+AeoeH72pzlK54W9HQQxyhqS
	75TpiIIFX+ESRAE0MRtXL/B3+e87J7Inb9lNuak1aV6J1/TrhTfdfL+dbcM1JkiEBpFgzgEMaX3
	ieqNYjKdnLBhBvxGvdJ5HtyHzK4Qe/O2EV/LjhcXhtj2/8ILIpohZHok11qnlkNIm1ixt02KpU2
	l29KNQ=
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39b26101029mr40740639a91.1.1788849416965;
        Mon, 07 Sep 2026 23:36:56 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b4b72f62esm18814349a91.5.2026.09.07.23.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:36:56 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: lianux.mm@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Tue,  8 Sep 2026 14:36:35 +0800
Message-ID: <20260908063635.2208922-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_nr_samples_per_aggr() test sets both intervals to zero,
which exercises two different fallback paths at once.

Use separate compound initializers for each case so that each case
tests one fallback path independently. Also make the overflow case
use an explicit non-zero sample interval so that it does not depend
on the zero sample interval fallback.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 mm/damon/tests/core-kunit.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c01e6a75cad..ff23208c181 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -627,12 +627,20 @@ static void damon_test_set_regions(struct kunit *test)
 
 static void damon_test_nr_samples_per_aggr(struct kunit *test)
 {
-	struct damon_attrs attrs = {
+	struct damon_attrs attrs;
+
+	/* Zero sample interval is treated as one. */
+	attrs = (struct damon_attrs){
 		.sample_interval = 0,
-		.aggr_interval = 0,
+		.aggr_interval = 5000,
 	};
+	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 5000);
 
-	/* Zero aggregation interval doesn't cause division by zero */
+	/* Zero samples per aggregation is treated as one. */
+	attrs = (struct damon_attrs){
+		.sample_interval = 5000,
+		.aggr_interval = 0,
+	};
 	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
 
 	/*
@@ -640,7 +648,10 @@ static void damon_test_nr_samples_per_aggr(struct kunit *test)
 	 * overflow
 	 */
 	if (ULONG_MAX > UINT_MAX) {
-		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
+		attrs = (struct damon_attrs){
+			.sample_interval = 1,
+			.aggr_interval = (unsigned long)UINT_MAX + 1,
+		};
 		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
 				UINT_MAX);
 	}

base-commit: d118502628f8b673be9023db8bdf878f64a7ed45
-- 
2.43.0

