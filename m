Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A430C630
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956026; cv=none; b=j36P9Ikp7XWDk97sQZRNta2gjxw0VfWxXqVNflfTo0B1YA2sk7wuT6cRnERkJsm3PhVMSo5zFlNQcgyQfPDO89Ls4M9jHnHM12ZibM6E57ep2fnZ5nkJzXUaEQlB0D316++QFgppvgo3+U82QCU6eWuK3bDiibCbVrpNFGUM1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956026; c=relaxed/simple;
	bh=HwrVy46pwm1N9U0NvKR0Xl4rsY8ItGDn5v+sE6KvLUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMALu5Dc4/mDsOFCsFXNvoa4vu+LSHN6i504XxOpP/yyf+FMASzBzcNKEQVjcX0LKm7U7YBm2bQSS9d7crAkrc6CH0nrzjXWgDQhEDgwMoWTKZx2VvGUMRxjJRfWO6CVsvuo4msUOWDVlVF1If357k1juc6bKvz1ahqZ3yCdvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXKeVALN; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXKeVALN"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so17622675e9.0
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 19:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789956022; x=1790560822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OijqBYKK0m6rMTpt09frMbajAxUXg2fiGkgxoIrzzPc=;
        b=KXKeVALN37QS3Nm3DHzQFhfztDMhs7CJe6SRmiSqu1PqfOEOpkYv0B7K3U79KYd6nZ
         4MzhQ3sVcmZ4PaaY3/arQ7nE4qQDMCk4V63GhDAxucrX7gXeyH55oGlOiu4NXe9SyAIo
         7bE+VSgHgRLERGS5xnRn5urEo1TFsczrFGnkwqG0UlZecqUz2/CSFOWDZFKq+RkKAJTN
         gAuHVOP8Kt7y1joLLjUNSFekRwNNDBxPi6RbkOMJNWNj/hxUexiuUBeZtzod7rRnZOJW
         GfMcRTvFfjnrvUb9ukLO1vgTnz7p7xwFscHlz/ru1P1Xe1egKFI3keNyshs691AkiWPd
         nN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789956022; x=1790560822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OijqBYKK0m6rMTpt09frMbajAxUXg2fiGkgxoIrzzPc=;
        b=vAtiyn1F2DtUSW2GFfsI6VhlD1NDTMDMtbJTkeADY+Satn7FinR837YUWj3VLIaSke
         kKpRC3rt2D+khhzTf43nZxus8FbdYSnGSOToNI2vslkk23ypkf7W3A0PNv2rzj/z+omp
         vxQaiUB+ZEJi3S6pZLvtwQVaqI4bedc5pxjABbJFXR/5PzIy6sG7mINY0D/66uT3NR1a
         urAaDSymsGDLMMK+Ag0BlEWk+itIMVNVHMs9t1MIOScB7zujwIc2muCsClaLoJY0bldQ
         rBe2G72blTBCPlK9kZwFukg8TrD3b7A1QWhww7pCEQ6ZBdEYSRNtlKm1WR6OrxtRHLNI
         BjvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMlG+vZI16CEiAoYF4ZWJnSrZUeq+48oR08ChuL6rFG0F+583D17rr9fb6OKGmaN/gfGBMAQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lq94vZw0g/60r132cvlZPiLgpbrtPNQh7HZ7uyBUvK7LbXUxcX
	vBfxrpQDTD1tvM+zjw2VvgwnarA3Mk6oHN0kegLK2fLUVQyp4G6KAzRm
X-Gm-Gg: AYBFou2Zz7LgmCpkXss54wx6MwOcqwTg9Saa3+K53PRa6efrrcrMr4vYiPZYrnnD99F
	2Q8fdmCmBIl/UhR0CWFogjoSzaO42K2KOPrHt9ictxWPL6yyqlBmkC+v+S1lapfTjSQU4isS+h7
	sRii4e+cLc8eMoQcxHjwA/F3NBFtgohZ4iqI+gVI4vaE0cgSE7Oeo8Dp5owDQM6C90Iq/OqVer1
	EOZ7Vl6/i7avRvnESv+5u5Ri9fYsJFtqEAVAy/aiSmtcAMW7PCEO+ai8QeyppNAFVjftMcgr28p
	dAM4PSANYzEUBeYwu9TfihnDgK2YP5jC9F88sXxYZ51pgAo3KVNnTLsIUsOsCnBefINFTWvAPMq
	K2CF92yySRpdyxMKD24hXUZDsF9M5UxRNIZyrsJHXu5OpELnmR99EfV+MtU4uuc9OlYFhWmg7BY
	FtCcipPkI7UTxctWoWsx9sRTZVi89bg1Q0fw3nGI1vqbkuTW24CozqZ2ZWGzcAHe2jKTJnNWu+e
	7o1Lz/nVp9JK48sEoK5yWM47QKck6vW2eJokCLw/I1Nvl0YN6dx6pSruPYDoncRMWWONxuGGOjw
	8o6vZYoToLIn8h6Lu7LRz/M9PbOxTZ+wm9PHvlTi6eU6vkOKE/6RXjV7tjOjqqjjbS7spdhB003
	T9Q==
X-Received: by 2002:a05:600c:1f95:b0:49e:7862:c09e with SMTP id 5b1f17b1804b1-49fc57238b8mr117988965e9.14.1789956022582;
        Sun, 20 Sep 2026 19:00:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-2c36-515f-49b6-c492.310.pool.telefonica.de. [2a02:3100:a8e9:c501:2c36:515f:49b6:c492])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10273fsm193284995e9.7.2026.09.20.19.00.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:00:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon/tests/core-kunit: test PSI goal values with explicit samples
Date: Mon, 21 Sep 2026 04:00:13 +0200
Message-Id: <20260921020013.33105-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921020013.33105-1-kmehltretter@gmail.com>
References: <20260921020013.33105-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the PSI current-value helper with explicit totals so the result does
not depend on the test system's memory pressure. Cover an unmeasured
consist goal, unmeasured temporal goals with zero and nonzero effective
quotas, and measured rounds for both tuners. Check last_psi_total after
each call.

With the old unmeasured-round behavior retained in the helper, the
temporal check with a nonzero effective quota fails.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 mm/damon/tests/core-kunit.h | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5ff0436c58441..a30040826874e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -910,6 +910,48 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 			});
 }
 
+static void damos_test_set_psi_current_val(struct kunit *test)
+{
+	struct damos s = {
+		.quota.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_CONSIST,
+	};
+	struct damos_quota_goal goal = {
+		.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+		.target_value = 100,
+		.last_psi_total = U64_MAX,
+	};
+
+	/* uninitialized last_psi_total keeps the consist tuner quota */
+	damos_set_psi_current_val(1000, &goal, &s);
+	KUNIT_EXPECT_EQ(test, goal.current_value, 100ul);
+	KUNIT_EXPECT_EQ(test, goal.last_psi_total, 1000ull);
+
+	/* initialized last_psi_total gives the delta */
+	damos_set_psi_current_val(1030, &goal, &s);
+	KUNIT_EXPECT_EQ(test, goal.current_value, 30ul);
+	KUNIT_EXPECT_EQ(test, goal.last_psi_total, 1030ull);
+
+	/* temporal tuner keeps a zero quota */
+	s.quota.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL;
+	s.quota.esz = 0;
+	goal.last_psi_total = U64_MAX;
+	damos_set_psi_current_val(2000, &goal, &s);
+	KUNIT_EXPECT_EQ(test, goal.current_value, 100ul);
+	KUNIT_EXPECT_EQ(test, goal.last_psi_total, 2000ull);
+
+	/* temporal tuner keeps a non-zero quota */
+	s.quota.esz = SZ_64K;
+	goal.last_psi_total = U64_MAX;
+	damos_set_psi_current_val(3000, &goal, &s);
+	KUNIT_EXPECT_EQ(test, goal.current_value, 0ul);
+	KUNIT_EXPECT_EQ(test, goal.last_psi_total, 3000ull);
+
+	/* temporal tuner uses the measured PSI delta */
+	damos_set_psi_current_val(3250, &goal, &s);
+	KUNIT_EXPECT_EQ(test, goal.current_value, 250ul);
+	KUNIT_EXPECT_EQ(test, goal.last_psi_total, 3250ull);
+}
+
 static void damos_test_commit_quota_goals_for(struct kunit *test,
 		struct damos_quota_goal *dst_goals, int nr_dst_goals,
 		struct damos_quota_goal *src_goals, int nr_src_goals)
@@ -1947,6 +1989,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_nr_accesses_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
+	KUNIT_CASE(damos_test_set_psi_current_val),
 	KUNIT_CASE(damos_test_commit_quota_goals),
 	KUNIT_CASE(damos_test_commit_quota),
 	KUNIT_CASE(damos_test_commit_dests),
-- 
2.53.0

