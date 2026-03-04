Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218637F757;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599288; cv=none; b=sEUd0JwwE31ZEaaLg6YiTVxVFp4/8Q4vjKVtCa6yun5Gtq4XT4tlR3Moy6ycNI+7ndNCBf2m8lxgb0aqejgK/cu3+xxPZOF+NTqVRPGwwJNTSC1LIeSgCIhBEdlXmrhxsgS26RCxLlHHorX6sghZT0at9uhEFDKZgIU2ysUS8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599288; c=relaxed/simple;
	bh=QHI34cc7GPySMrww748vR+nu09NVGXEeGECMJAgm4jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wxug4uFpNQu/3z7D9nAn9QNRlbNm/xOcJ3PxJqncgSNk1Y1Huk6EuUnbA1jo+C2hoGxchVniJi/cJchMbXE4aE38Hl1z+BEegcFD1MSvh5VUkZmpBl4w0aIzKEoLEHK47UuoxjfemgBkYdD9RCX61gJb+GVTYNON7aUFd+z2K18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONaNs8x3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONaNs8x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9DC2BCB2;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599288;
	bh=QHI34cc7GPySMrww748vR+nu09NVGXEeGECMJAgm4jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONaNs8x3vsqddIqGapimPOCja1sezVwIF4WxYgGdeYG+NG8zNawDZImfrPTY1JbJU
	 c5rP/KE86iJpVugDN4qKf2PpnLakeN9DMIQYM5y34jAMIeJU6Jk3wyGjVvT+wdoQH0
	 0kk37hPC8zooX3XBqPFDSu2mhFlVB6R4Mr7ShghG1BYSf/zg2iA1sBRm7uEiEBHchX
	 oWbrEQkHf+6d7s35Q2Ikq411qCiGPUQUZo24RZUaihUxQepoxp6yOjSQUUDUjjVV0F
	 AdfAcI3hUTaFZn1vX+QBKqiCkZ02m+l9oUTqVFf66WJjvNlTA5c+7EQc7ywxTLg/Uo
	 NRngNd4otMCiw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 03/10] mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
Date: Tue,  3 Mar 2026 20:41:12 -0800
Message-ID: <20260304044122.79394-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new goal-based DAMOS quota auto-tuning algorithm, namely
DAMOS_QUOTA_GOAL_TUNER_TEMPORAL (temporal in short).  The algorithm aims
to trigger the DAMOS action only for a temporal time, to achieve the
goal as soon as possible.  For the temporal period, it uses as much
quota as allowed.  Once the goal is achieved, it sets the quota zero, so
effectively makes the scheme be deactivated.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 63f1e3fdd3866..c4095b34f7929 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -216,9 +216,11 @@ struct damos_quota_goal {
 /**
  * enum damos_quota_goal_tuner - Goal-based quota tuning logic.
  * @DAMOS_QUOTA_GOAL_TUNER_CONSIST:	Aim long term consistent quota.
+ * @DAMOS_QUOTA_GOAL_TUNER_TEMPORAL:	Aim zero quota asap.
  */
 enum damos_quota_goal_tuner {
 	DAMOS_QUOTA_GOAL_TUNER_CONSIST,
+	DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d657b87dd99e8..51401d35f1b6b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2337,6 +2337,26 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 	return highest_score;
 }
 
+static void damos_goal_tune_esz_bp_consist(struct damos_quota *quota)
+{
+	unsigned long score = damos_quota_score(quota);
+
+	quota->esz_bp = damon_feed_loop_next_input(
+			max(quota->esz_bp, 10000UL), score);
+}
+
+static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
+{
+	unsigned long score = damos_quota_score(quota);
+
+	if (score >= 10000)
+		quota->esz_bp = 0;
+	else if (quota->sz)
+		quota->esz_bp = quota->sz * 10000;
+	else
+		quota->esz_bp = ULONG_MAX;
+}
+
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
@@ -2351,11 +2371,10 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	}
 
 	if (!list_empty(&quota->goals)) {
-		unsigned long score = damos_quota_score(quota);
-
-		quota->esz_bp = damon_feed_loop_next_input(
-				max(quota->esz_bp, 10000UL),
-				score);
+		if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST)
+			damos_goal_tune_esz_bp_consist(quota);
+		else if (quota->goal_tuner == DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
+			damos_goal_tune_esz_bp_temporal(quota);
 		esz = quota->esz_bp / 10000;
 	}
 
-- 
2.47.3
