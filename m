Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7638F80
	for <damon@lists.linux.dev>; Sun, 17 Aug 2025 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755396865; cv=none; b=ThQ/KCG1H9E8Y39XX1/74Obz20wPCSzwBRr0FUHdAfTMLZNemAQgr/XJJHzcctOq8CkfEQbdSMY6dm9JoXOkAFQBhBQSMSyik0uPKHXbnOqe5zEV4XglcGUdbCUyqNIjFJ5XO9ld4Fl8OwFLtfkfbGC/z6ACY6A2e7CqpetmsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755396865; c=relaxed/simple;
	bh=VrCuGtUIp7NMFIisaIXVIH0GKE7OKR6VfoA9FXxKtNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxpbMFVFbt/f1xO2Z2I6dbgpeGRr05Un+hyKhQV0RPK1c72+Rev/kQRyZOiDenrtuYSAW1u/UA+JhWtFfY9SP4NM1HclO9nM2EkABzLHoekm0xf2VcZpmEpFQV2WRqHl3LkoPzFTFRYTKBWoaeA5m7aYMT/u5qNCBispvub/M/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvE+aePX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvE+aePX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b472f0106feso1269570a12.2
        for <damon@lists.linux.dev>; Sat, 16 Aug 2025 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755396863; x=1756001663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6It7N83D4C/K797xfMMN/txZOz69/E8M8kxi9IABYA=;
        b=JvE+aePXxHVF/Os/ASwDKiRNV9VDviN7OIdTwjsIYl7Va8VlxUDNR3CK/nbhpKCAYE
         ZGp03S66XszjO60EzW/NcAlHQtYopSRF3ZWoXp1h42l/Yallt2q8JqBdhDR/zHKxQ8Ya
         WQ9P2QiWGwmMdcKhSa4Cdnq5uH4sIG51PXKzgQHPS1AyZKR3j5p/P/sWZEFnzEZ9768Z
         1BMvF5+sAlJMmqZOVtfRrI6bHivq0nkKG0Vmgmsb5XFtbfeuvjN4evAzhSb0zu5B3GHF
         iGVMeiS+OTzDFme3dI4CciAUNPQAB61TSeCcbBkUvJWMTh90GhVzHMnhoKx7A+65oE9Y
         j6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755396863; x=1756001663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6It7N83D4C/K797xfMMN/txZOz69/E8M8kxi9IABYA=;
        b=uOGk+rS2jxgOquDJTFfijaZzTgSoQQI3EYDgRwT2jSuBX459jkMpgB0S2rWfTcZNax
         jPv0UvOs84YBBn9sAzKjUuJZvaSJkTWCQMkaFKgESpAlzqSNMilaHDwk/7WI00djqjuZ
         Fb5sWbym7pPfwhgo40aECKk3FjD7TCo9PGo24m4NhHR3f5tKtK8p3dSEXx/fRhR6FpCt
         DRbAM6nfR0qfabWs8mhVGkYsWXEYEurnohmqpalf0c9b1J4WuSXH5xqPM9PPZQJkQH0F
         BDw7x97m1kcJduTgzJwBRP0X32rHwj9INiEyNvCX4B5jXseTJ+eGlgMSUjLsCYddqpFF
         v4tw==
X-Gm-Message-State: AOJu0YwnjCHDM5uZ4dE9KDqtKnHCavNp5WnBxcTxwEbWlXQjZ8gATW/o
	Q3Odncl+zQlRjYjqB+ujoLyGL8syow0Z30NHwGGTKUI+y9M+6TMfx4gK
X-Gm-Gg: ASbGncv2UfYIYmlP9fCjyypYr12q3baE3wjjIEvDpI+1nSfYROPZvkhg60CXsCvs++V
	ONDigOeEOFtbvLoGM3r4bbB16Pd54iDBWFFRG4zYdvvKn1BHHA+nHKHWaBV6Uhpxvyg+0R5YzRz
	nl6Z1fjes/Loxtng5NYHA62xQrfG7PCwmmjB8Suhvb04XTgQxCB0Z/VXKKXbIkclESBvQo8JEc8
	bHkvkd0ji22MDkuiWV4iwtcHF0HPhn7QkyXyyvHAg/IuTwLK4DHEgh1W3WZcT5rVvlJK1k/Y4SR
	UTDvnwjYMPgCGDGOJwtmKzk9EqBebcIS1bzf1uB1wFVAjVeJTudkJauB1Py4A8Z0KQtCN5/rpMa
	ACmGh2bey8iwvF1lY
X-Google-Smtp-Source: AGHT+IHN3lJKC5Ayd/Md04E0eyowb0RhMB3NC0RYYz1UDMZh3sAVI5KBiuVr3IHvz15y6m4dACPfYg==
X-Received: by 2002:a17:903:3d06:b0:243:e324:a36d with SMTP id d9443c01a7336-2446d749c0bmr90644345ad.23.1755396862836;
        Sat, 16 Aug 2025 19:14:22 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d56d5bbsm44762545ad.147.2025.08.16.19.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 19:14:22 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] mm/damon/tests/core-kunit: add damos_commit_filter test
Date: Sun, 17 Aug 2025 11:13:48 +0900
Message-ID: <20250817021348.570692-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unit test to verify that damos_commmit_filter() change dest value well.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
This test will be succeeded after this patch [1] applied.

[1] https://lore.kernel.org/damon/20250816015116.194589-1-ekffu200098@gmail.com/

---
 mm/damon/tests/core-kunit.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index dfedfff19940..5f5dc9db2e90 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -419,6 +419,22 @@ static void damos_test_new_filter(struct kunit *test)
 	damos_destroy_filter(filter);
 }
 
+static void damos_test_commit_filter(struct kunit *test)
+{
+	struct damos_filter *src_filter = damos_new_filter(
+		DAMOS_FILTER_TYPE_ANON, true, true);
+	struct damos_filter *dst_filter = damos_new_filter(
+		DAMOS_FILTER_TYPE_ACTIVE, false, false);
+
+	damos_commit_filter(dst_filter, src_filter);
+	KUNIT_EXPECT_EQ(test, dst_filter->type, src_filter->type);
+	KUNIT_EXPECT_EQ(test, dst_filter->matching, src_filter->matching);
+	KUNIT_EXPECT_EQ(test, dst_filter->allow, src_filter->allow);
+
+	damos_destroy_filter(src_filter);
+	damos_destroy_filter(dst_filter);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -594,6 +610,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
+	KUNIT_CASE(damos_test_commit_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
-- 
2.43.0

