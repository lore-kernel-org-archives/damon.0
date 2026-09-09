Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B683BFE38
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937652; cv=none; b=irL+PXr9o7Hzk5+9OX3/4dw88RpNAApkqw2GdUnhzIlSOUkDm4UT+LTfXONXhHTkof1nRDA218IUjVu0xSzDXvWZ3WFMcomDHxAgo8AsIn8NjVYGWY/6nk6fiAxi3/y/eSIza6DikA7qw75z5jzPVE6/diowNBt2mRcpmuSQt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937652; c=relaxed/simple;
	bh=8wIBjUz9IF5gEp20IIQYNH4b9XuoZQvuwa1sJkjCEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaHBFxZorAARMe+ezSXsJpLOJ6vXLqU9QOFxCNhmkV5I3KkmeD0OrRyXAnVMEUSHLwJmfL5WdbDBzkYhCTdauVa03WmmNCtjJFch9XO9+EX1VxuOL2b5vVX+I1WweZjYKcBREs0tIhmxGkZSgY8Yiwqy2JNiKHoGTQiDJv0iJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6wpNg2U; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6wpNg2U"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc149372c14so2806793a12.1
        for <damon@lists.linux.dev>; Wed, 09 Sep 2026 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788937645; x=1789542445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zwWptEuC/b5qmaSqXScFrcDGg6WicaoLVMMEs633Yk=;
        b=s6wpNg2UluxUJ1K94pYeLUSD6Tj4gsm5OqAoeV3n39jAECuvpkw3qHvrH8SukFyhls
         1Sg0ITadVb3gSOy5DEFInSgGX24GIjmJQBHRFKhTExjReUAH1LNRMIzFhsfv/Q+2gmjs
         PeKK7fZDJgQsEp75kS5XnsswSKRS6z7WcVXpCDw10zaIEpgfOI6eX6rm8oh+ccTizJcl
         tP2CwmRT01ZlXF/7+PsfCNhJUwGrux91hLR0ifrrKr9VNxL99bopR1zpXk4cRRdpy9If
         3vU18js1wmBqY3AEsxZSa/MTDKUKWowx9u7VxlMUPQXlzl4cOhiK37BKkWGzCFSpmhGo
         pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788937645; x=1789542445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zwWptEuC/b5qmaSqXScFrcDGg6WicaoLVMMEs633Yk=;
        b=cgd/0V9bkaB2+rE8dj2EXJYaB4AtKtJ9kR/VmyrlylVjqHr6pkE9YpyG85J5pZcDb7
         gd2h/+EzrH5TGmS2LTPWSgchEvasBlmI8rr1bThPMyPGWxYYzl9eNKLLEcIk4xrefdNf
         i5k3z/YyB0XwORMecUIi0+rFDOC24MBCxthe/yNUmCRiTE/YQbR+ECQ+Riex16p2CxMR
         6+xxg2fC2cKZIOrmT6RkAD6rdbAqyGW4w/Lsz4kIL6MDt98rBsevQjVgrIcu/zlkmVUN
         RS/DDET6FPxriyGpv2oD8Yj+Lgps2cqC/KVHMIHgIyhIdLERmsm625T3vgbhjoKOmB9n
         jPEg==
X-Gm-Message-State: AFuF++m0FEUQCpr1S7S/E6Zjgc/uXZnTwpuHhmunEjKMXXLTsijNdJol
	vxGr8kUT0IYc/zFvxopLZBa24CTgzf3rWGLSqOk3JNPco260S4fwy661
X-Gm-Gg: AYBFou036BLSooSxLXHlscspLsQj3gLFvlcw57LonGVPxr+P1VAvpiZC+RV3aroIetA
	F8MKNgfx8ugzUVNZPSQXrRvJB/MzTKXkA4Mb7t1wmbXU0Ztz5cpWYxQ4VEqOAe6fipPU3OqCL2Y
	btUA06JdYfE0tJr53y7UZmgefQnHJ88ngdOFAqP/1inpbp0TBT20wTtJmNbGPjZnL2LCs7r0haN
	6/jMIiluVHDIeOtFLWujX5KuYXf5BLs3UL6B2+z1yBx6DYa23AEjCoZmoiaslMyBavsG2etpiHg
	ovblV8UtHOSx036PdielG4KXH/AMjAi9inJEAOrjpCSYWTX71xpDXuQw7sDn5s3KPa8XEptw/Jn
	ZTf05MEo8TpLT5gZCsEOKC+1pEzDPQvTcnnQS6iGau3545fILKX/2PCbhAeP7/xP2GLPf0yYpqq
	+3VGq0FOxUDJ4jLE9o21hNzhGbrQipzIP/nUneZs6rCe7KWzAlA14VYN3y1hVFkK6FHW86fBo+J
	SpcmxjZQcaPGOF+SuDqWenyJKVF
X-Received: by 2002:a17:90b:1a88:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-39b2619138bmr47894514a91.8.1788937640108;
        Wed, 09 Sep 2026 00:07:20 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d7e8sm38243802a91.16.2026.09.09.00.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:07:19 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Wed,  9 Sep 2026 15:07:11 +0800
Message-ID: <20260909070711.2448346-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the zero sample interval case with a non-zero aggregation
interval, and keep the zero/zero case to cover the zero-result
fallback.

Also make the overflow case use an explicit sample interval so that
it does not depend on the zero sample interval fallback.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
---
Changes in v2:
- Use 0/0 for the zero-result case, consistent with damon_set_attrs().
- Update commit msg and add Reviewed-by tag.
- Link to v1: https://lore.kernel.org/damon/20260908063635.2208922-1-kunwu.chan@gmail.com/
---
 mm/damon/tests/core-kunit.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c01e6a75cad..a47a5cdf285 100644
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
+	/* Zero sample and aggregation intervals cover the zero-result fallback. */
+	attrs = (struct damon_attrs){
+		.sample_interval = 0,
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

