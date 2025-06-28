Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93825C80D;
	Sat, 28 Jun 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129516; cv=none; b=gGNZ8wEocBNuT2E0G/wCTH8R11scKr0nI+QSTwuDMb+gi6HFLV6sVbF09lv9H6E9RpOgLax3synKNWYx4bVjpe/NQf+a4LwPo0/0TcVnBhoTylEy+C21EdKfOOZJczssaZIa7VJweo8x6yVsf7gmcs9ALjAMPHAMPJTG5l0Wcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129516; c=relaxed/simple;
	bh=AIBeBRbmeSSh7sYS8+FVSI4lH0Rgj/i6prmCLpF8QMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tc6xVgE3Qq9HtXQ1TbTpbQesZf6IdKk99d2A38H/sxHjkThNOS59UNQjQkwSQrT4yyvCSBHED4qpxN0T6VG++J9apwnFnjluyH1ht2TKU7vFivdZopUemwD1lA9E7FbX//95uTfhZLHChkM8C+VyN4nphzlPGD0YvUG/A15zDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuGpmL1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuGpmL1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114F4C4CEED;
	Sat, 28 Jun 2025 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129516;
	bh=AIBeBRbmeSSh7sYS8+FVSI4lH0Rgj/i6prmCLpF8QMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuGpmL1mJynk5SlCW0enE68mHiib8LrLQH5BBuHmCx0QYi3WTprxvLhjDGwRLqLXt
	 1RohepaKPT9JSRA/KXO8bBQuR8xlTJtW4TXuqzsLWnNm3Z41kRgNVF52vFkdQYg8ii
	 xdRpEpfpmwn7wXPRnRs/5HQO2zf+GTbYWBPuLWLNHxmkNALaAzHBupUaOu4k1ADoBZ
	 5c2eAuEBU4o5EeGVx01M1k9Jh7YHRhX+dvV8m7IuDl3JIx5mKpV6i+khgGHKQq24qu
	 mh1vFB0DzqrZfDAwZ8TceX6BYzoGDp8lEbbepnlVRnnz2bPGm8YxuobQk4gygLMZVB
	 Ak0rXqC6k6ksQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/11] mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning
Date: Sat, 28 Jun 2025 09:51:41 -0700
Message-Id: <20250628165144.55528-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doing DAMOS_LRU_[DE]PRIO with DAMOS_QUOTA_[IN]ACTIVE_MEM_BP based quota
auto-tuning can be useful.  For example, users can ask DAMON to "find
hot/cold pages and activate/deactivate those aiming 50:50
active:inactive memory size."  But DAMON_LRU_SORT has no interface to do
that.  Add a module parameter for setting the target ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3ccde23a8566..99c5a22cf3f2 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -41,6 +41,20 @@ static bool enabled __read_mostly;
 static bool commit_inputs __read_mostly;
 module_param(commit_inputs, bool, 0600);
 
+/*
+ * Desired active to [in]active memory ratio in bp (1/10,000).
+ *
+ * While keeping the caps that set by other quotas, DAMON_LRU_SORT
+ * automatically increases and decreases the effective level of the quota
+ * aiming the LRU [de]prioritizations of the hot and cold memory resulting in
+ * this active to [in]active memory ratio.  Value zero means disabling this
+ * auto-tuning feature.
+ *
+ * Disabled by default.
+ */
+static unsigned long active_mem_bp __read_mostly;
+module_param(active_mem_bp, ulong, 0600);
+
 /*
  * Filter [none-]young pages accordingly for LRU [de]prioritizations.
  *
@@ -201,6 +215,26 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
+static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
+		struct damos *cold_scheme)
+{
+	struct damos_quota_goal *goal;
+
+	if (!active_mem_bp)
+		return 0;
+	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
+	if (!goal)
+		return -ENOMEM;
+	damos_add_quota_goal(&hot_scheme->quota, goal);
+	/* aim 0.2 % goal conflict, to keep little ping pong */
+	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
+			10000 - active_mem_bp + 2);
+	if (!goal)
+		return -ENOMEM;
+	damos_add_quota_goal(&hot_scheme->quota, goal);
+	return 0;
+}
+
 static int damon_lru_sort_add_filters(struct damos *hot_scheme,
 		struct damos *cold_scheme)
 {
@@ -256,6 +290,9 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(param_ctx, &hot_scheme, 1);
 	damon_add_scheme(param_ctx, cold_scheme);
 
+	err = damon_lru_sort_add_quota_goals(hot_scheme, cold_scheme);
+	if (err)
+		goto out;
 	err = damon_lru_sort_add_filters(hot_scheme, cold_scheme);
 	if (err)
 		goto out;
-- 
2.39.5
