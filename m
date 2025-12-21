Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67642FB09A
	for <damon@lists.linux.dev>; Sun, 21 Dec 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766322169; cv=none; b=P9EDDDEaalzUEfkhrIH6G3npCaErGXazHs4Xj5b2f1WR04RwevHChg1utAr8cK39iOfoGnSUgYzovhYO/ZiFjWC4/c5T3tyQ34SvWoC2FF0hO0LxP7lR/jOBNK6lFxGkOSObmTh0EsAzlqDM61XgDyzFOpYFu7LDx3KJ1/BJerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766322169; c=relaxed/simple;
	bh=YMqQjGqHo3yCY1HtjvHQJhX4vCo3raqTMGv7qPELqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgE6QNj4SNuA1qcJwtyJ7N3E8A1G5bcb0iRErckPrAqXWHS409wjr6wN77/yXhfPefdtyYrqGS0tZCry39RYoFsSRxrfCAJGNigeg9jiFEorJsoIAqmNMdvi5RC8GvnsBnP1FF7HQy8mDnyayxoFbkhLuinoPkfe1yJw4UR/cHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk0a0ooF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk0a0ooF"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so1922651a12.0
        for <damon@lists.linux.dev>; Sun, 21 Dec 2025 05:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766322167; x=1766926967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSY7XOe/WRXINmaJjE9x1cwiIij569xd98uTVI5aS6I=;
        b=Dk0a0ooFgOCWV3I6QaJKCUJW7cNeNyOMC7mfb+ChJBq4pyCKkocudXrwWzYuPc6O5P
         V1FlQXwFVLQdvVIA+MwD0aN6qBhehyEdvumaRctPzNHwirBk5VePtyi/qNOh9pcNjiM8
         h309FJ1ElsiZEVtMdhJDOFlFaujQG62CdAs0/x1pGCl90sx57DjtnKEPFhLZgJm/vAbA
         AoSoPBjI/HFkrlNiKwmd9gnUIqMIg1LY9QcTIN0zWMBUhrTj7Ya/N8HkVDuufFBxN1Dr
         +mX+tKq9F8OdJeht5yDP3Jw8446lOOSm0OO4j7zmt30AJuLU3lL2o1nKfL9LHy5CnG70
         +XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766322167; x=1766926967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSY7XOe/WRXINmaJjE9x1cwiIij569xd98uTVI5aS6I=;
        b=WFwvoHRRPufItCuWtD0egqn4gj0TcbDm44Y/NwiCGwIDCeMweSmJS3o2eBEO9qpNeb
         zxvfVeS1eLJPEvYd3wfMNxUxT+NOl4i0jBQmcATHvyhYKMpkYRA4menxXMAaS6e1/uk5
         NOmgC6FHMYQmpjFcJDZQ2Thpu3mpyLnOc1yVrI1KRcfAvkVPMmLvgZmg+4g/6gc5bztr
         qf1xix7KVbyenwwPflzqiS1waR4TxVKL7agD51pmc0JHBetM+JPLP8jzgNXeOYJkt6dc
         E7i/jQ1ckzT8EJe8HY2D+rGhaKa+tVwKmjoUkVD8QCtYUZ27lpkg70Fz6qtbzw+gQY1n
         n1IA==
X-Forwarded-Encrypted: i=1; AJvYcCVKHY42LeM4AHX05qztv8MIR9xW5iPsrZMm51b/1SN6xTaiYlyu//NDXDeadBt7ozK2JX75HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHaA67q85R4KVjNyEFyyLfPFyTKvPvC8XjjrzXT5CqoHTI8A+D
	prV7HltJKKCeyruTuVyldQJLSZcBNlM+rfx4O7dflr/3ocE4x1sUKouV
X-Gm-Gg: AY/fxX5n2iUdNGDTR4esIF5hxRFamvblcgynasbmuofqHFYdNdbRTXt+vJvgZ02VT6q
	09HcztRlBUVCwNCJmMmKthLNM6sZ7AGW29C6eg49fggyEJ4abgtta47LhZ19efg0WODhtSs7rXv
	2fTwexY4yg5VFX80YgXQnX8ZIL+OBbkDuzJv+GvVFchH1hE+f84ufrsiN45elOh5RvHL7pjQa5Z
	jjkYpAAKsYH2jJvtz5jXoyYuWQCNZoL7EZx4kV2/q15twP6pjoRmvCmRof0yGtlTUNNPSSxFi5u
	Wqv/lfxZBRSKtnm0kNGN9CuL/AS4TOkc9Wt8p0hZ07qTtnnb234nV2637WhftLuWi6i5MShcGXM
	RYPuoXxFncOftM8T9+oeFXKNl4Wa2VlDtFAx/XlQ/Gcp1d+NklCJnCTAjNo48qibubRUOZiDmoM
	yO
X-Google-Smtp-Source: AGHT+IE0pzTSaBZW0PqBo1nLMFou749uCZH2R8Sj1acU7EbMWf8ZDkTgJYeOyEMZv1HM4VBoxc7dMg==
X-Received: by 2002:a05:7022:2093:b0:119:e56c:18ae with SMTP id a92af1059eb24-121722c1f51mr7539579c88.22.1766322166515;
        Sun, 21 Dec 2025 05:02:46 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm31732013c88.1.2025.12.21.05.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:02:46 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: shu17az@gmail.com,
	yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/tests/core-kunit: extend test scenarios and remove redundancy
Date: Sun, 21 Dec 2025 13:01:14 +0000
Message-ID: <20251221130114.1483856-1-shu17az@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some missing test scenarios to cover a wider range of cases. Also,
remove a redundant case in damos_test_commit_quota_goal().

Signed-off-by: Shu Anzai <shu17az@gmail.com>
---
 mm/damon/tests/core-kunit.h | 51 ++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index f59ae7ee19a0..e9ccc3fb34f9 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -158,6 +158,7 @@ static void damon_test_split_at(struct kunit *test)
 	r->nr_accesses_bp = 420000;
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
+	r->age = 10;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
@@ -170,6 +171,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
+	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 	damon_free_target(t);
 }
@@ -190,6 +192,7 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	r->nr_accesses = 10;
 	r->nr_accesses_bp = 100000;
+	r->age = 9;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
 	if (!r2) {
@@ -198,12 +201,15 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	r2->nr_accesses = 20;
 	r2->nr_accesses_bp = 200000;
+	r2->age = 21;
 	damon_add_region(r2, t);
 
 	damon_merge_two_regions(t, r, r2);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, 160000u);
+	KUNIT_EXPECT_EQ(test, r->age, 17u);
 
 	i = 0;
 	damon_for_each_region(r3, t) {
@@ -232,12 +238,12 @@ static void damon_test_merge_regions_of(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
-	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
-	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
+	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184, 235, 240};
+	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230, 240, 10235};
+	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2, 5, 5};
 
-	unsigned long saddrs[] = {0, 114, 130, 156, 170};
-	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	unsigned long saddrs[] = {0, 114, 130, 156, 170, 235, 240};
+	unsigned long eaddrs[] = {112, 130, 156, 170, 230, 240, 10235};
 	int i;
 
 	t = damon_new_target();
@@ -255,9 +261,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	}
 
 	damon_merge_regions_of(t, 9, 9999);
-	/* 0-112, 114-130, 130-156, 156-170 */
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
-	for (i = 0; i < 5; i++) {
+	/* 0-112, 114-130, 130-156, 156-170, 170-230, 235-240, 240-10235 */
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 7u);
+	for (i = 0; i < 7; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
@@ -269,6 +275,9 @@ static void damon_test_split_regions_of(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r;
+	unsigned long sa[] = {0, 300, 500};
+	unsigned long ea[] = {220, 400, 700};
+	int i;
 
 	t = damon_new_target();
 	if (!t)
@@ -286,14 +295,19 @@ static void damon_test_split_regions_of(struct kunit *test)
 	t = damon_new_target();
 	if (!t)
 		kunit_skip(test, "second target alloc fail");
-	r = damon_new_region(0, 220);
-	if (!r) {
-		damon_free_target(t);
-		kunit_skip(test, "second region alloc fail");
+	for (i = 0; i < ARRAY_SIZE(sa); i++) {
+		r = damon_new_region(sa[i], ea[i]);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
+		damon_add_region(r, t);
+	}
+	damon_split_regions_of(t, 4, 5);
+	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
 	}
-	damon_add_region(r, t);
-	damon_split_regions_of(t, 4, 1);
-	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 }
 
@@ -574,9 +588,10 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 			});
 	damos_test_commit_quota_goal_for(test, &dst,
 			&(struct damos_quota_goal) {
-			.metric = DAMOS_QUOTA_USER_INPUT,
-			.target_value = 789,
-			.current_value = 12,
+			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+			.target_value = 234,
+			.current_value = 345,
+			.last_psi_total = 567,
 			});
 }
 
-- 
2.43.0

