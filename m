Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD448488D;
	Mon, 28 Sep 2026 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584816; cv=none; b=laqouVemvP/1bNBg6x3OqtthtsizMJ2G/Dw/8xCXaElfhnutDBn2X0BEb31k5R4hUbyVta+EMWtQkO2y73PB9PWhUa0k9BAORnt4TeNk3AeftgQGkPXtgOsSPglQC3h1XCsbnCzA9ASc2mW8hyP+dJCVi5JXm2vYsxltDs1u9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584816; c=relaxed/simple;
	bh=h7evO3RcDKawrqH+2r5GnVJXoUllTPiWt0SIU9IWj9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEFhqG+VG1p3g+bCHQtOU2aV/0oKInU4TxQ2WIg10uGsnUUY0vM2eOtSTBCFiSUFHMHnh++JZ//4tSeQyvqLkTQrkyYeXL02wmBoZF65reMlZ1PyUdTolZ5FbjPkUO0UUJmcXxqYyo1BfLQOD2CTN0PL57prOhVfGFUIYIQArgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouiy1Hwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouiy1Hwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87D31F000FF;
	Mon, 28 Sep 2026 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584815;
	bh=QvJUQAwtTUqWjCL+OziAjJmsBq454CkzwYAl5nK+x/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ouiy1HwyCYaUI/6+irBuhHecQHFC48KigeHFwfi3HT7ohp/BjmgP2sISwQmFwbJFJ
	 puXwxpH5Bs0tqz71RPnr1CvC1mP9jwoGQS4+iabRpSQVjjq/Q24nu8+gwdQryrMxPx
	 9ve+/1vbmjl+EMKLgoUkMsOGnBsKm57LfGJ9BN/j8PMglicbrGNF6PPdGzFyJiEe7a
	 aJ480RSA2ChAXIv9eb0eklGnB1ljkv8J/t2l8gmAyXDuoQqxqcqrPa9Bf1i2UZwsXZ
	 6mvC4WziuAsALJLULuawfQofcBmlquxcj6BxgXt5e5BoIk1Gn1WdTm+2FqrHDliXzV
	 grEBSYpFMEAPw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/tests/core-kunit: test PSI goal values with explicit samples
Date: Mon, 28 Sep 2026 01:39:57 -0700
Message-ID: <20260928083959.4030-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928083959.4030-1-sj@kernel.org>
References: <20260928083959.4030-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

Test the PSI current-value helper with explicit totals so the result does
not depend on the test system's memory pressure. Cover an unmeasured
consist goal, unmeasured temporal goals with zero and nonzero effective
quotas, and measured rounds for both tuners. Check last_psi_total after
each call.

Cc: Lian Wang <lianux.mm@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260921020013.33105-1-kmehltretter@gmail.com
- Collect R-b: from SJ.
- Split out from the series.
- Rebase to the latest mm-new.
- Delete mention of old behavior, as it is irrelevant for commit message.
Changes from v1
- v1: https://lore.kernel.org/20260915060937.3423-1-kmehltretter@gmail.com/
- Use the previous effective quota for the temporal decision, including
  when it is zero. Keep resetting last_psi_total for new and updated
  goals.
- Move the current-value calculation and last_psi_total update into a
  helper. Test both tuners with explicit samples and check
  last_psi_total after each call.

 mm/damon/tests/core-kunit.h | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index df84d9cc7d20..ef4b8b85d67b 100644
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
@@ -2260,6 +2302,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_nr_accesses_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
+	KUNIT_CASE(damos_test_set_psi_current_val),
 	KUNIT_CASE(damos_test_commit_quota_goals),
 	KUNIT_CASE(damos_test_commit_quota),
 	KUNIT_CASE(damos_test_commit_dests),
-- 
2.47.3
