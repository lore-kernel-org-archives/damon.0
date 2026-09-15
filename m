Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E3440638
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452592; cv=none; b=LcD0uEEdWdjBMlMvhF+e4N5SHOBfxP4JRz8o2953xUVCSgsI5DjbDta7URRsP08rzEySEAh1hrT02rTqEnPH0Itn7WdXyFBZtwX4Jqhr5cblytHGbaUeKnYTDEom9izfU+bwEbsv/JSnqNb3jlK27ZSJlsO/hA4x0ggyH8p9CEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452592; c=relaxed/simple;
	bh=FaG65pZ6DeseFsP335fpFfB3OsL20xr26Do9BjzVW4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0n1ziYdLbEIlrxmdW+47BaBSsKBrrxSdRNGnAhIt4Y+cbe4i2Y3H30WDviV28+iy0xMpm8Hmy5YZw9Z5wJ22/rmR8vrjrHosm/+eH1X9kWviN8SBF/iYVYhrH4+hRWQlBUIo5kpYiV3AFDtuacItXVyTAdtMpjTgACUDP/LZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP01sK1r; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP01sK1r"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso32712355e9.2
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452588; x=1790057388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17npcWfNhvbB0tYfjU0bxEFrefgovxZItMHI62tmYzU=;
        b=XP01sK1rBA1nyNy8/Z2i4XG+IZM7aOtE5LFZPe9DwnZEPJbZxwq4qT2f8XhSsk4VQL
         FtdvZDMAwmzRE+AvyAOSSFhic57Foy75c8Y2KXUh4aU8QWYwOFklolFs2onJfe3EEgox
         7jl4mfD6JTpCP2m4dA1zNPUuO749S5KOwUXfQwpkP0r2PzFj6ZFf84w5Of0W+QMG1RSY
         WqzXDxOeNht+zem9uB4GjLqQZA6zuTESpIPdvW9vD5JMOUFDzmqZBueXQnwJHLlI34G7
         LRR5zfoEcqng1FfUcPdKF9hGQOGD0by9MCzWvZSfVbxr/fsAB42Sqx1nRXn4ZSXf+mSH
         cTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452588; x=1790057388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17npcWfNhvbB0tYfjU0bxEFrefgovxZItMHI62tmYzU=;
        b=ztUbf1By/cg6mlFos55z1Et8y7pahMszZKjdkxg7uY4x+EP1Fb3XEcFeVN/WEsgom5
         N9SEP4BbZAzsUItM3Mz5b+37QjkArkPl2wZP0VwCDtpBqG5xi4r6t4tdyBYZmGKio8y1
         eqToNgzBWNsC+5kCmPHSmvF+KhZ7U1EaRaBDN/OgEUj06eJbbWLj9RIC2usKLwum0omf
         TTfiix+fISPvVr4q65E+gY8fcgiwMWzvtgQ/gkZxni/1OW0J28SpLmMABMe7YcyK+O7u
         r+CjLxQsNi9YnTYqQJaeKMqRHwJX0zUAezgi5XiZdPmNAx9/najMjocZgL51iF1XNIBb
         gy0w==
X-Forwarded-Encrypted: i=1; AKwUvBySHZQZz0iB9sC20V18Xerx3TV3Ms4Q6hjxxomG7kgFpU627fn8/zlQY+2lHFks83hrPYeuRw==@lists.linux.dev
X-Gm-Message-State: AFuF++kPssUin7wLwJVUjMSp+NJRA6WoCQBL5MN/bXXFYEV881GYVlDR
	DpetLFdQOoIeXG+ZcTXAI7FQVs/SeNTia5ZZY9ACyRI8uQ0djpLXn7Pn
X-Gm-Gg: AYBFou2ULDJzNHQhwNaVMTmZePCVc25cUmFzVhy5L81Qekec1BPM3suJ5lg+8wubbNK
	fOtIBDAe13a71ceyGHTsREVllfV2cDG8Gk+7KrA8tC9jfIaR9dXkgEhJXBYCVoYlXAa12ex4h0j
	MT8VGGU0s/3OFHBoipQC5odqMSKihuRnn6vBajU/4y14J0HGDKMsP3oycP0KXIfUz90gwLY9Zo3
	JuOyMWykoRTPACapRCYB8Wr0QLIett+C4GFLBlooYxL1x2eT5Bmb25ZWe5SgagGXM4MvnrRginP
	ZRskeOdyVVaSKne7J5rkaUX5Uqhzwtpz4dBPFtEsMEDlqJVfT/tCTaqvfayqsNndQK5n1zzo3OK
	w+B9So7YCL0uxzK45vdj363jMoydAxzJarswbaRhY3tIWJ50cIJBXWqA/RTiM7z13LvisNyBuUT
	MBXK4iItkbmn3p/nDwSlOr4Cevs/+9yz/kNtbW0hVozkDy1GWf1FTHZGCzrZQ44qkb9yqsK0/9G
	hYr++gC8iwdUFJuS6QPmILyYP3cgV218+/y34Zw0ltYNJo+G2gg1687vDW00uJ8FsRQ8PDPuC1N
	Opi7/9ELORAzl/vO8th6/ZLsUU2x+8eXXYpX6UZSD+DxSv8hz4V6Okrx6jiZlDx5s/w+U8tnmq9
	kMmt7Okf3OA5CZENy
X-Received: by 2002:a05:600c:6297:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49e7a654dfemr129105045e9.6.1789452588005;
        Mon, 14 Sep 2026 23:09:48 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-afd5-c801-cc65-9ba1-765b-bff6.310.pool.telefonica.de. [2a02:3100:afd5:c801:cc65:9ba1:765b:bff6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d27c88fsm44282905e9.2.2026.09.14.23.09.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 23:09:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds under the temporal tuner
Date: Tue, 15 Sep 2026 08:09:37 +0200
Message-Id: <20260915060937.3423-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260915060937.3423-1-kmehltretter@gmail.com>
References: <20260915060937.3423-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise a PSI quota goal under the temporal tuner on its first
round, its next measured round, and after a goal commit. Use
ULONG_MAX as the target so the goal is not reached during the test.
Then check that a measured round which does reach the target sets
the quota to zero, and that the consist tuner keeps its quota over
an unmeasured round.

Without the previous patch, the first and the post-commit checks see
a zero quota.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 mm/damon/tests/core-kunit.h | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c01e6a75cadc..2b9b24ce7dad 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -889,6 +889,74 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 			});
 }
 
+/*
+ * Unmeasured PSI goals must not disable the temporal quota.
+ * Keep sz * 10000 within a 32-bit unsigned long.
+ */
+static void damos_test_set_effective_quota_temporal_psi(struct kunit *test)
+{
+	struct damon_ctx *c = damon_new_ctx();
+	struct damos_access_pattern pattern = {};
+	struct damos_quota quota = {
+		.sz = SZ_64K,
+		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
+	};
+	struct damos_watermarks wmarks = {};
+	struct damos_quota_goal src = {
+		.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+		.target_value = ULONG_MAX,
+	};
+	struct damos_quota_goal *goal;
+	struct damos *s;
+
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(c, s);
+	goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US, ULONG_MAX);
+	if (!goal) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "goal alloc fail");
+	}
+	damos_add_quota_goal(&s->quota, goal);
+
+	/* fresh goal, first tuning round */
+	damos_set_effective_quota(c, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
+
+	/* second round: last_psi_total is initialised now */
+	damos_set_effective_quota(c, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
+
+	/* commit a PSI goal onto the initialised PSI goal */
+	damos_commit_quota_goal(goal, &src);
+	damos_set_effective_quota(c, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
+
+	/* a measured round that reaches the target disables the quota */
+	goal->target_value = 10;
+	goal->last_psi_total = damos_get_some_mem_psi_total() - 10;
+	/* U64_MAX marks an unmeasured goal, keep the sample away from it */
+	if (goal->last_psi_total == U64_MAX)
+		goal->last_psi_total--;
+	damos_set_effective_quota(c, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, 0ul);
+
+	/* the consist tuner keeps its quota over an unmeasured round */
+	s->quota.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_CONSIST;
+	s->quota.esz_bp = SZ_32K * 10000;
+	damos_commit_quota_goal(goal, &src);
+	damos_set_effective_quota(c, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_32K);
+
+	damon_destroy_ctx(c);
+}
+
 static void damos_test_commit_quota_goals_for(struct kunit *test,
 		struct damos_quota_goal *dst_goals, int nr_dst_goals,
 		struct damos_quota_goal *src_goals, int nr_src_goals)
@@ -1887,6 +1955,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
+	KUNIT_CASE(damos_test_set_effective_quota_temporal_psi),
 	KUNIT_CASE(damos_test_commit_quota),
 	KUNIT_CASE(damos_test_commit_dests),
 	KUNIT_CASE(damos_test_commit_filter),
-- 
2.53.0

