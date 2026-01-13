Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEF393412;
	Tue, 13 Jan 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318053; cv=none; b=lc1HoJ9y7molrsMsUFdZFnGwANnqniYk0K8YWiHjJlKf53lsZiWVkVqV5DFCKDDlnxVRAZRiE/GfZ0hLUc2b/iTONMpuHq3GJBn8LP1mpvpeoZpfnFoNn0cpLAQEtsBmFNHkHWSz9XaJ8URydeT4UFHGiOfmd9/ChK/Eru4YV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318053; c=relaxed/simple;
	bh=pLryvh98ed6XxIPENni66cywNufL7GDRDX92gXVXv0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxNlqFfAoHOfXFVHFYn7THB4MrqZxCicdHsf/rbIP0dYtzefamKdJkDe75FqyyNUHy/wpzhWqCAZKTgSJNDsskaAp5ual1FHE5C3ekP04hfDkD/Ul5aoTnLzIuGyUX+mr438A54ylLPBGTjcPKmQuE+Qeh3h9avxbVXqHQmbw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbPlCZKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbPlCZKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5994C2BC86;
	Tue, 13 Jan 2026 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318053;
	bh=pLryvh98ed6XxIPENni66cywNufL7GDRDX92gXVXv0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbPlCZKpIa9lOj8AUJONXGdiS2aKBOANl+x8LvCD7wN/3tBH/k1xZ21qPaPOTgd1/
	 JQ6KtXiAKUbQtF/268czWsrcAIKAMqWUEOd5YMI2HaveSZkVKBOQEKI+R1GrfEDrOz
	 L9n/QK7uEmuy03W2+7Yc3lG1HjtzKD4RXxfhSMaZjkbSkEpyWBPz1fvlvNNGboeBOi
	 KRemgqA15qfU3IjPJtr2AHIP1eAYyb6+R0Nh7yCUD+2ZKh7wqUawGcv3Oyj4LlEVx8
	 joZHlZo2O1H5B+yqoalAjodSq8qbWo/UHo06cHVY0PCsirMjc3k6J3nb/xY/Htz9Cz
	 Tx/bOa4/5q2ZA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/11] mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning
Date: Tue, 13 Jan 2026 07:27:13 -0800
Message-ID: <20260113152717.70459-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doing DAMOS_LRU_[DE]PRIO with DAMOS_QUOTA_[IN]ACTIVE_MEM_BP based quota
auto-tuning can be easy and intuitive, compared to the manual
[de]prioritization target access pattern thresholds tuning.  For
example, users can ask DAMON to "find hot/cold pages and
activate/deactivate those aiming 50:50 active:inactive memory size." But
DAMON_LRU_SORT has no interface to do that.  Add a module parameter for
setting the target ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f1fdb37b9b47..f3a9dfc246b6 100644
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
  * Filter [non-]young pages accordingly for LRU [de]prioritizations.
  *
@@ -208,6 +222,26 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
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
@@ -277,6 +311,9 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(param_ctx, &hot_scheme, 1);
 	damon_add_scheme(param_ctx, cold_scheme);
 
+	err = damon_lru_sort_add_quota_goals(hot_scheme, cold_scheme);
+	if (err)
+		goto out;
 	err = damon_lru_sort_add_filters(hot_scheme, cold_scheme);
 	if (err)
 		goto out;
-- 
2.47.3
